#!/usr/bin/env python3

"""Generate a Markdown optimization report from benchmark and diagnostics artifacts."""

import argparse
import json
import re
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple


# ---------------------------------------------------------------------------
# pbxproj helpers
# ---------------------------------------------------------------------------

_SETTING_RE = re.compile(r"^\s*([A-Z_][A-Z_0-9]*)\s*=\s*(.+?)\s*;", re.MULTILINE)

_CONFIG_ID_RE = re.compile(r"([0-9A-F]{24})\s*/\*\s*(Debug|Release)\s*\*/")

_CONFIG_LIST_RE = re.compile(
    r"([0-9A-F]{24})\s*/\*\s*Build configuration list for "
    r"(?P<kind>PBXProject|PBXNativeTarget)\s+\"(?P<name>[^\"]+)\"\s*\*/"
)


def _parse_all_build_configs(pbxproj: str) -> Dict[str, Tuple[str, Dict[str, str]]]:
    """Return {config_id: (config_name, {key: value})} for every XCBuildConfiguration."""
    configs: Dict[str, Tuple[str, Dict[str, str]]] = {}
    for match in re.finditer(
        r"([0-9A-F]{24})\s*/\*\s*(Debug|Release)\s*\*/\s*=\s*\{\s*"
        r"isa\s*=\s*XCBuildConfiguration;\s*buildSettings\s*=\s*\{([^}]*)\}",
        pbxproj,
        re.DOTALL,
    ):
        config_id = match.group(1)
        config_name = match.group(2)
        body = match.group(3)
        settings: Dict[str, str] = {}
        for s in _SETTING_RE.finditer(body):
            val = s.group(2).strip().strip('"')
            settings[s.group(1)] = val
        configs[config_id] = (config_name, settings)
    return configs


def _resolve_config_list(
    pbxproj: str, all_configs: Dict[str, Tuple[str, Dict[str, str]]], kind: str
) -> Dict[str, Dict[str, Dict[str, str]]]:
    """Resolve configuration lists for a given kind (PBXProject or PBXNativeTarget)."""
    results: Dict[str, Dict[str, Dict[str, str]]] = {}
    for list_match in _CONFIG_LIST_RE.finditer(pbxproj):
        if list_match.group("kind") != kind:
            continue
        entity_name = list_match.group("name")
        list_id = list_match.group(1)
        block_start = pbxproj.find(f"{list_id} /*", list_match.end())
        if block_start == -1:
            block_start = list_match.start()
        block = pbxproj[block_start : block_start + 500]
        configs: Dict[str, Dict[str, str]] = {}
        for cid_match in _CONFIG_ID_RE.finditer(block):
            cid = cid_match.group(1)
            if cid in all_configs:
                cname, settings = all_configs[cid]
                configs[cname] = settings
        if configs:
            results[entity_name] = configs
    return results


def _parse_project_level_configs(pbxproj: str) -> Dict[str, Dict[str, str]]:
    """Extract project-level Debug and Release build settings."""
    all_configs = _parse_all_build_configs(pbxproj)
    resolved = _resolve_config_list(pbxproj, all_configs, "PBXProject")
    if resolved:
        return next(iter(resolved.values()))
    return {}


def _parse_target_configs(pbxproj: str) -> Dict[str, Dict[str, Dict[str, str]]]:
    """Extract per-target Debug and Release build settings."""
    all_configs = _parse_all_build_configs(pbxproj)
    return _resolve_config_list(pbxproj, all_configs, "PBXNativeTarget")


# ---------------------------------------------------------------------------
# Best-practices audit
# ---------------------------------------------------------------------------

_DEBUG_EXPECTATIONS: List[Tuple[str, str, str]] = [
    ("SWIFT_COMPILATION_MODE", "singlefile", "Single-file mode recompiles only changed files (Xcode UI: Incremental)"),
    ("SWIFT_OPTIMIZATION_LEVEL", "-Onone", "Optimization passes add compile time without debug benefit"),
    ("GCC_OPTIMIZATION_LEVEL", "0", "C/ObjC optimization adds compile time without debug benefit"),
    ("ONLY_ACTIVE_ARCH", "YES", "Building all architectures multiplies compile and link time"),
    ("DEBUG_INFORMATION_FORMAT", "dwarf", "dwarf-with-dsym generates a separate dSYM, adding overhead"),
    ("ENABLE_TESTABILITY", "YES", "Required for @testable import during development"),
    ("EAGER_LINKING", "YES", "Allows linker to start before all compilation finishes, reducing wall-clock time"),
]

_GENERAL_EXPECTATIONS: List[Tuple[str, str, str]] = [
    ("COMPILATION_CACHE_ENABLE_CACHING", "YES", "Caches compilation results so repeat builds of unchanged inputs are served from cache. Measured 5-14% faster clean builds across tested projects; benefit compounds during branch switching and pulling changes"),
]

_RELEASE_EXPECTATIONS: List[Tuple[str, str, str]] = [
    ("SWIFT_COMPILATION_MODE", "wholemodule", "Whole-module optimization produces faster runtime code"),
    ("SWIFT_OPTIMIZATION_LEVEL", "-O", "Optimized binaries for production (-Osize also acceptable)"),
    ("GCC_OPTIMIZATION_LEVEL", "s", "Optimizes C/ObjC for size in release"),
    ("ONLY_ACTIVE_ARCH", "NO", "Release builds must include all architectures for distribution"),
    ("DEBUG_INFORMATION_FORMAT", "dwarf-with-dsym", "dSYM bundles are needed for crash symbolication"),
    ("ENABLE_TESTABILITY", "NO", "Removes internal-symbol export overhead from release builds"),
]

_CONSISTENCY_KEYS = [
    "SWIFT_COMPILATION_MODE",
    "SWIFT_OPTIMIZATION_LEVEL",
    "ONLY_ACTIVE_ARCH",
    "DEBUG_INFORMATION_FORMAT",
]


def _effective_value(
    project: Dict[str, str], target: Dict[str, str], key: str
) -> Optional[str]:
    return target.get(key, project.get(key))


def _check(actual: Optional[str], expected: str) -> bool:
    if actual is None:
        if expected in ("singlefile",):
            return True
        return False
    if expected == "-O" and actual in ("-O", '"-O"', '"-Osize"', "-Osize"):
        return True
    return actual.strip('"') == expected


def _merged_project_settings(
    project_configs: Dict[str, Dict[str, str]],
) -> Dict[str, str]:
    """Return a flat dict of all settings across Debug and Release for general checks."""
    merged: Dict[str, str] = {}
    for config in project_configs.values():
        merged.update(config)
    return merged


def _audit_config(
    project_settings: Dict[str, str],
    expectations: List[Tuple[str, str, str]],
    config_name: str,
) -> List[str]:
    lines: List[str] = []
    for key, expected, _reason in expectations:
        actual = project_settings.get(key)
        display_actual = actual if actual else "(unset)"
        passed = _check(actual, expected)
        mark = "[x]" if passed else "[ ]"
        lines.append(f"- {mark} `{key}`: `{display_actual}` (recommended: `{expected}`)")
    return lines


def _audit_consistency(
    project_configs: Dict[str, Dict[str, str]],
    target_configs: Dict[str, Dict[str, Dict[str, str]]],
) -> List[str]:
    lines: List[str] = []
    for key in _CONSISTENCY_KEYS:
        overrides = []
        for target_name, configs in target_configs.items():
            for config_name in ("Debug", "Release"):
                target_settings = configs.get(config_name, {})
                if key in target_settings:
                    proj_val = project_configs.get(config_name, {}).get(key, "(unset)")
                    tgt_val = target_settings[key]
                    if tgt_val != proj_val:
                        overrides.append(
                            f"{target_name} ({config_name}): `{tgt_val}` vs project `{proj_val}`"
                        )
        if overrides:
            lines.append(f"- [ ] `{key}` has target-level overrides:")
            for o in overrides:
                lines.append(f"  - {o}")
        else:
            lines.append(f"- [x] `{key}` is consistent across all targets")
    return lines


# ---------------------------------------------------------------------------
# Auto-generated recommendations from audit
# ---------------------------------------------------------------------------


def _auto_recommendations_from_audit(
    project_configs: Dict[str, Dict[str, str]],
) -> Dict[str, Any]:
    """Generate basic recommendations from failing build settings audit checks."""
    items: List[Dict[str, str]] = []

    debug_settings = project_configs.get("Debug", {})
    for key, expected, reason in _DEBUG_EXPECTATIONS:
        if not _check(debug_settings.get(key), expected):
            actual = debug_settings.get(key, "(unset)")
            items.append({
                "title": f"Set `{key}` to `{expected}` for Debug",
                "category": "build-settings",
                "observed_evidence": f"Current value: `{actual}`. {reason}.",
                "estimated_impact": "Medium",
                "confidence": "High",
                "risk_level": "Low",
            })

    merged = {}
    for config in project_configs.values():
        merged.update(config)
    for key, expected, reason in _GENERAL_EXPECTATIONS:
        if not _check(merged.get(key), expected):
            actual = merged.get(key, "(unset)")
            items.append({
                "title": f"Enable `{key} = {expected}`",
                "category": "build-settings",
                "observed_evidence": f"Current value: `{actual}`. {reason}.",
                "estimated_impact": "High",
                "confidence": "High",
                "risk_level": "Low",
            })

    release_settings = project_configs.get("Release", {})
    for key, expected, reason in _RELEASE_EXPECTATIONS:
        if not _check(release_settings.get(key), expected):
            actual = release_settings.get(key, "(unset)")
            items.append({
                "title": f"Set `{key}` to `{expected}` for Release",
                "category": "build-settings",
                "observed_evidence": f"Current value: `{actual}`. {reason}.",
                "estimated_impact": "Medium",
                "confidence": "High",
                "risk_level": "Low",
            })

    if not items:
        return {"recommendations": []}
    return {"recommendations": items}


# ---------------------------------------------------------------------------
# Report generation
# ---------------------------------------------------------------------------


def _section_context(benchmark: Dict[str, Any]) -> str:
    build = benchmark.get("build", {})
    env = benchmark.get("environment", {})
    lines = [
        "## Project Context\n",
        f"- **Project:** `{build.get('path', 'unknown')}`",
        f"- **Scheme:** `{build.get('scheme', 'unknown')}`",
        f"- **Configuration:** `{build.get('configuration', 'unknown')}`",
        f"- **Destination:** `{build.get('destination', 'unknown')}`",
        f"- **Xcode:** {env.get('xcode_version', 'unknown').replace(chr(10), ' ')}",
        f"- **macOS:** {env.get('macos_version', 'unknown')}",
        f"- **Date:** {benchmark.get('created_at', 'unknown')}",
        f"- **Benchmark artifact:** `{benchmark.get('_artifact_path', 'unknown')}`",
    ]
    return "\n".join(lines)


def _section_baseline(benchmark: Dict[str, Any]) -> str:
    summary = benchmark.get("summary", {})
    clean = summary.get("clean", {})
    cached_clean = summary.get("cached_clean", {})
    incremental = summary.get("incremental", {})
    has_cached = bool(cached_clean and cached_clean.get("count", 0) > 0)

    if has_cached:
        lines = [
            "## Baseline Benchmarks\n",
            "| Metric | Clean | Cached Clean | Incremental |",
            "|--------|-------|-------------|-------------|",
            f"| Median | {clean.get('median_seconds', 0):.3f}s | {cached_clean.get('median_seconds', 0):.3f}s | {incremental.get('median_seconds', 0):.3f}s |",
            f"| Min | {clean.get('min_seconds', 0):.3f}s | {cached_clean.get('min_seconds', 0):.3f}s | {incremental.get('min_seconds', 0):.3f}s |",
            f"| Max | {clean.get('max_seconds', 0):.3f}s | {cached_clean.get('max_seconds', 0):.3f}s | {incremental.get('max_seconds', 0):.3f}s |",
            f"| Runs | {clean.get('count', 0)} | {cached_clean.get('count', 0)} | {incremental.get('count', 0)} |",
        ]
        lines.append(
            "\n> **Cached Clean** = clean build with a warm compilation cache. "
            "This is the realistic scenario for branch switching, pulling changes, or "
            "Clean Build Folder. The compilation cache lives outside DerivedData and "
            "survives product deletion.\n"
        )
    else:
        lines = [
            "## Baseline Benchmarks\n",
            "| Metric | Clean | Incremental |",
            "|--------|-------|-------------|",
            f"| Median | {clean.get('median_seconds', 0):.3f}s | {incremental.get('median_seconds', 0):.3f}s |",
            f"| Min | {clean.get('min_seconds', 0):.3f}s | {incremental.get('min_seconds', 0):.3f}s |",
            f"| Max | {clean.get('max_seconds', 0):.3f}s | {incremental.get('max_seconds', 0):.3f}s |",
            f"| Runs | {clean.get('count', 0)} | {incremental.get('count', 0)} |",
        ]

    build_types = ["clean", "cached_clean", "incremental"] if has_cached else ["clean", "incremental"]
    label_map = {"clean": "Clean", "cached_clean": "Cached Clean", "incremental": "Incremental"}
    for build_type in build_types:
        runs = benchmark.get("runs", {}).get(build_type, [])
        all_cats: Dict[str, Dict] = {}
        for run in runs:
            for cat in run.get("timing_summary_categories", []):
                name = cat["name"]
                if name not in all_cats:
                    all_cats[name] = {"seconds": 0.0, "task_count": 0}
                all_cats[name]["seconds"] += cat["seconds"]
                all_cats[name]["task_count"] += cat.get("task_count", 0)
        if all_cats:
            count = len(runs) or 1
            ranked = sorted(all_cats.items(), key=lambda x: x[1]["seconds"], reverse=True)
            label = label_map.get(build_type, build_type.title())
            lines.append(f"\n### {label} Build Timing Summary\n")
            lines.append(
                "> **Note:** These are aggregated task times across all CPU cores. "
                "Because Xcode runs many tasks in parallel, these totals typically exceed "
                "the actual build wait time shown above. A large number here does not mean "
                "it is blocking your build.\n"
            )
            lines.append("| Category | Tasks | Seconds |")
            lines.append("|----------|------:|--------:|")
            for name, data in ranked:
                avg_sec = data["seconds"] / count
                tasks = data["task_count"] // count if data["task_count"] else ""
                lines.append(f"| {name} | {tasks} | {avg_sec:.3f}s |")

    return "\n".join(lines)


def _section_settings_audit(
    project_configs: Dict[str, Dict[str, str]],
    target_configs: Dict[str, Dict[str, Dict[str, str]]],
) -> str:
    lines = ["## Build Settings Audit\n"]

    lines.append("### Debug Configuration\n")
    lines.extend(_audit_config(project_configs.get("Debug", {}), _DEBUG_EXPECTATIONS, "Debug"))

    lines.append("\n### General (All Configurations)\n")
    merged = _merged_project_settings(project_configs)
    lines.extend(_audit_config(merged, _GENERAL_EXPECTATIONS, "General"))

    lines.append("\n### Release Configuration\n")
    lines.extend(_audit_config(project_configs.get("Release", {}), _RELEASE_EXPECTATIONS, "Release"))

    lines.append("\n### Cross-Target Consistency\n")
    lines.extend(_audit_consistency(project_configs, target_configs))

    return "\n".join(lines)


def _section_diagnostics(diagnostics: Optional[Dict[str, Any]]) -> str:
    if diagnostics is None:
        return "## Compilation Diagnostics\n\nNo diagnostics artifact provided. Run `diagnose_compilation.py` to identify type-checking hotspots."
    warnings = diagnostics.get("warnings", [])
    summary = diagnostics.get("summary", {})
    threshold = diagnostics.get("threshold_ms", 100)
    lines = [
        "## Compilation Diagnostics\n",
        f"Threshold: {threshold}ms | "
        f"Total warnings: {summary.get('total_warnings', 0)} | "
        f"Function bodies: {summary.get('function_body_warnings', 0)} | "
        f"Expressions: {summary.get('expression_warnings', 0)}\n",
    ]
    if warnings:
        lines.append("| Duration | Kind | File | Line | Name |")
        lines.append("|---------:|------|------|-----:|------|")
        for w in warnings[:30]:
            short_file = Path(w["file"]).name
            name = w.get("name", "") or "(expression)"
            lines.append(
                f"| {w['duration_ms']}ms | {w['kind']} | {short_file} | {w['line']} | {name} |"
            )
        if len(warnings) > 30:
            lines.append(f"\n*... and {len(warnings) - 30} more warnings (see full artifact)*")
    else:
        lines.append("No type-checking hotspots found above threshold.")
    return "\n".join(lines)


def _section_recommendations(recommendations: Optional[Dict[str, Any]]) -> str:
    if recommendations is None:
        return "## Prioritized Recommendations\n\nNo recommendations artifact provided."
    items = recommendations.get("recommendations", [])
    if not items:
        return "## Prioritized Recommendations\n\nNo recommendations found."
    lines = ["## Prioritized Recommendations\n"]
    for i, item in enumerate(items, 1):
        title = item.get("title", "Untitled")
        lines.append(f"### {i}. {title}\n")
        for field, label in [
            ("wait_time_impact", "Wait-Time Impact"),
            ("actionability", "Actionability"),
            ("category", "Category"),
            ("observed_evidence", "Evidence"),
            ("estimated_impact", "Impact"),
            ("confidence", "Confidence"),
            ("risk_level", "Risk"),
            ("scope", "Scope"),
        ]:
            val = item.get(field)
            if val is None:
                continue
            if isinstance(val, list):
                lines.append(f"**{label}:**")
                for entry in val:
                    lines.append(f"- {entry}")
            else:
                lines.append(f"**{label}:** {val}")
        lines.append("")
    return "\n".join(lines)


def _section_approval(recommendations: Optional[Dict[str, Any]]) -> str:
    if recommendations is None:
        return "## Approval Checklist\n\nNo recommendations to approve."
    items = recommendations.get("recommendations", [])
    if not items:
        return "## Approval Checklist\n\nNo recommendations to approve."
    lines = ["## Approval Checklist\n"]
    for i, item in enumerate(items, 1):
        title = item.get("title", "Untitled")
        wait_impact = item.get("wait_time_impact", "")
        impact = item.get("estimated_impact", "")
        risk = item.get("risk_level", "")
        actionability = item.get("actionability", "")
        impact_str = wait_impact if wait_impact else impact
        actionability_str = f" | Actionability: {actionability}" if actionability else ""
        lines.append(f"- [ ] **{i}. {title}** -- Impact: {impact_str}{actionability_str} | Risk: {risk}")
    return "\n".join(lines)


def _section_next_steps(benchmark: Dict[str, Any]) -> str:
    build = benchmark.get("build", {})
    command = build.get("command", "xcodebuild build")
    lines = [
        "## Next Steps\n",
        "After implementing approved changes, re-benchmark with the same inputs:\n",
        "```bash",
        f"python3 scripts/benchmark_builds.py \\",
    ]
    if build.get("entrypoint") == "workspace":
        lines.append(f"  --workspace {build.get('path', 'App.xcworkspace')} \\")
    else:
        lines.append(f"  --project {build.get('path', 'App.xcodeproj')} \\")
    lines.extend([
        f"  --scheme {build.get('scheme', 'App')} \\",
        f"  --configuration {build.get('configuration', 'Debug')} \\",
    ])
    if build.get("destination"):
        lines.append(f'  --destination "{build["destination"]}" \\')
    lines.append("  --output-dir .build-benchmark")
    lines.append("```\n")
    lines.append("Compare the new wall-clock medians against the baseline. Report results as:")
    lines.append('"Your [clean/incremental] build now takes X.Xs (was Y.Ys) -- Z.Zs faster/slower."')
    return "\n".join(lines)


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Generate a Markdown build optimization report.")
    parser.add_argument("--benchmark", required=True, help="Path to benchmark JSON artifact")
    parser.add_argument("--recommendations", help="Path to recommendations JSON")
    parser.add_argument("--diagnostics", help="Path to diagnostics JSON")
    parser.add_argument("--project-path", help="Path to .xcodeproj for build settings audit")
    parser.add_argument("--output", help="Output Markdown path (default: stdout)")
    return parser.parse_args()


def main() -> int:
    args = parse_args()

    benchmark = json.loads(Path(args.benchmark).read_text())
    benchmark["_artifact_path"] = args.benchmark

    recommendations = None
    if args.recommendations:
        recommendations = json.loads(Path(args.recommendations).read_text())

    diagnostics = None
    if args.diagnostics:
        diagnostics = json.loads(Path(args.diagnostics).read_text())

    project_configs: Dict[str, Dict[str, str]] = {}
    target_configs: Dict[str, Dict[str, Dict[str, str]]] = {}
    if args.project_path:
        pbxproj_path = Path(args.project_path) / "project.pbxproj"
        if pbxproj_path.exists():
            pbxproj = pbxproj_path.read_text()
            project_configs = _parse_project_level_configs(pbxproj)
            target_configs = _parse_target_configs(pbxproj)

    if recommendations is None and project_configs:
        auto = _auto_recommendations_from_audit(project_configs)
        if auto["recommendations"]:
            recommendations = auto

    sections = [
        "# Xcode Build Optimization Plan\n",
        _section_context(benchmark),
        _section_baseline(benchmark),
    ]

    if project_configs:
        sections.append(_section_settings_audit(project_configs, target_configs))

    sections.append(_section_diagnostics(diagnostics))
    sections.append(_section_recommendations(recommendations))
    sections.append(_section_approval(recommendations))
    sections.append(_section_next_steps(benchmark))

    report = "\n\n".join(sections) + "\n"

    if args.output:
        Path(args.output).write_text(report)
        print(f"Saved optimization report: {args.output}")
    else:
        print(report, end="")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
