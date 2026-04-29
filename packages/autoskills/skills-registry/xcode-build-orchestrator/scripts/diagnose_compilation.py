#!/usr/bin/env python3

"""Run a single Xcode build with -Xfrontend diagnostics to find slow type-checking."""

import argparse
import json
import re
import subprocess
import sys
import time
from datetime import datetime, timezone
from pathlib import Path
from typing import Dict, List, Optional

_TYPECHECK_RE = re.compile(
    r"^(?P<file>.+?):(?P<line>\d+):(?P<col>\d+): warning: "
    r"(?P<kind>instance method|global function|getter|type-check|expression) "
    r"'?(?P<name>[^']*?)'?\s+took\s+(?P<ms>\d+)ms\s+to\s+type-check"
)

_EXPRESSION_RE = re.compile(
    r"^(?P<file>.+?):(?P<line>\d+):(?P<col>\d+): warning: "
    r"expression took\s+(?P<ms>\d+)ms\s+to\s+type-check"
)

_FILE_TIME_RE = re.compile(
    r"^\s*(?P<seconds>\d+(?:\.\d+)?)\s+seconds\s+.*\s+compiling\s+(?P<file>\S+)"
)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Run an Xcode build with -Xfrontend type-checking diagnostics."
    )
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("--workspace", help="Path to the .xcworkspace file")
    group.add_argument("--project", help="Path to the .xcodeproj file")
    parser.add_argument("--scheme", required=True, help="Scheme to build")
    parser.add_argument("--configuration", default="Debug", help="Build configuration")
    parser.add_argument("--destination", help="xcodebuild destination string")
    parser.add_argument("--derived-data-path", help="DerivedData path override")
    parser.add_argument("--output-dir", default=".build-benchmark", help="Output directory")
    parser.add_argument(
        "--threshold",
        type=int,
        default=100,
        help="Millisecond threshold for -warn-long-function-bodies and "
        "-warn-long-expression-type-checking (default: 100)",
    )
    parser.add_argument("--skip-clean", action="store_true", help="Skip clean before build")
    parser.add_argument(
        "--per-file-timing",
        action="store_true",
        help="Add -Xfrontend -debug-time-compilation to report per-file compile times.",
    )
    parser.add_argument(
        "--stats-output",
        action="store_true",
        help="Add -Xfrontend -stats-output-dir to collect detailed compiler statistics.",
    )
    parser.add_argument(
        "--extra-arg",
        action="append",
        default=[],
        help="Additional xcodebuild argument. Can be passed multiple times.",
    )
    return parser.parse_args()


def command_base(args: argparse.Namespace) -> List[str]:
    command = ["xcodebuild"]
    if args.workspace:
        command.extend(["-workspace", args.workspace])
    if args.project:
        command.extend(["-project", args.project])
    command.extend(["-scheme", args.scheme, "-configuration", args.configuration])
    if args.destination:
        command.extend(["-destination", args.destination])
    if args.derived_data_path:
        command.extend(["-derivedDataPath", args.derived_data_path])
    command.extend(args.extra_arg)
    return command


def parse_diagnostics(output: str) -> List[Dict]:
    """Extract type-checking warnings from xcodebuild output."""
    warnings: List[Dict] = []
    seen = set()
    for raw_line in output.splitlines():
        line = raw_line.strip()
        match = _TYPECHECK_RE.match(line)
        if match:
            key = (match.group("file"), match.group("line"), match.group("col"), "function-body")
            if key in seen:
                continue
            seen.add(key)
            warnings.append(
                {
                    "file": match.group("file"),
                    "line": int(match.group("line")),
                    "column": int(match.group("col")),
                    "duration_ms": int(match.group("ms")),
                    "kind": "function-body",
                    "name": match.group("name"),
                }
            )
            continue
        match = _EXPRESSION_RE.match(line)
        if match:
            key = (match.group("file"), match.group("line"), match.group("col"), "expression")
            if key in seen:
                continue
            seen.add(key)
            warnings.append(
                {
                    "file": match.group("file"),
                    "line": int(match.group("line")),
                    "column": int(match.group("col")),
                    "duration_ms": int(match.group("ms")),
                    "kind": "expression",
                    "name": "",
                }
            )
    warnings.sort(key=lambda w: w["duration_ms"], reverse=True)
    return warnings


def parse_file_timings(output: str) -> List[Dict]:
    """Extract per-file compile times from -debug-time-compilation output."""
    timings: List[Dict] = []
    seen = set()
    for raw_line in output.splitlines():
        match = _FILE_TIME_RE.match(raw_line.strip())
        if match:
            filepath = match.group("file")
            if filepath in seen:
                continue
            seen.add(filepath)
            timings.append(
                {
                    "file": filepath,
                    "duration_seconds": float(match.group("seconds")),
                }
            )
    timings.sort(key=lambda t: t["duration_seconds"], reverse=True)
    return timings


def main() -> int:
    args = parse_args()
    output_dir = Path(args.output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    timestamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    scheme_slug = args.scheme.replace(" ", "-").lower()
    artifact_stem = f"{timestamp}-{scheme_slug}"
    base = command_base(args)

    if not args.skip_clean:
        print("Cleaning build products...")
        clean = subprocess.run([*base, "clean"], capture_output=True, text=True)
        if clean.returncode != 0:
            sys.stderr.write(clean.stdout + clean.stderr)
            return clean.returncode

    threshold = str(args.threshold)
    swift_flags = (
        f"$(inherited) -Xfrontend -warn-long-function-bodies={threshold} "
        f"-Xfrontend -warn-long-expression-type-checking={threshold}"
    )
    if args.per_file_timing:
        swift_flags += " -Xfrontend -debug-time-compilation"

    stats_dir: Optional[Path] = None
    if args.stats_output:
        stats_dir = output_dir / f"{artifact_stem}-stats"
        stats_dir.mkdir(parents=True, exist_ok=True)
        swift_flags += f" -Xfrontend -stats-output-dir -Xfrontend {stats_dir}"

    build_command = [
        *base,
        "build",
        "-showBuildTimingSummary",
        f"OTHER_SWIFT_FLAGS={swift_flags}",
    ]

    extras = []
    if args.per_file_timing:
        extras.append("per-file timing")
    if args.stats_output:
        extras.append("stats output")
    extras_label = f" + {', '.join(extras)}" if extras else ""
    print(f"Building with type-check threshold {threshold}ms{extras_label}...")
    started = time.perf_counter()
    result = subprocess.run(build_command, capture_output=True, text=True)
    elapsed = round(time.perf_counter() - started, 3)

    combined_output = result.stdout + result.stderr
    log_path = output_dir / f"{artifact_stem}-diagnostics.log"
    log_path.write_text(combined_output)

    warnings = parse_diagnostics(combined_output)

    file_timings: Optional[List[Dict]] = None
    if args.per_file_timing:
        file_timings = parse_file_timings(combined_output)

    artifact = {
        "schema_version": "1.0.0",
        "created_at": datetime.now(timezone.utc).isoformat(),
        "type": "compilation-diagnostics",
        "build": {
            "entrypoint": "workspace" if args.workspace else "project",
            "path": args.workspace or args.project,
            "scheme": args.scheme,
            "configuration": args.configuration,
            "destination": args.destination or "",
        },
        "threshold_ms": args.threshold,
        "build_duration_seconds": elapsed,
        "build_success": result.returncode == 0,
        "raw_log_path": str(log_path),
        "warnings": warnings,
        "summary": {
            "total_warnings": len(warnings),
            "function_body_warnings": sum(1 for w in warnings if w["kind"] == "function-body"),
            "expression_warnings": sum(1 for w in warnings if w["kind"] == "expression"),
            "slowest_ms": warnings[0]["duration_ms"] if warnings else 0,
        },
    }

    if file_timings is not None:
        artifact["per_file_timings"] = file_timings
    if stats_dir is not None:
        artifact["stats_dir"] = str(stats_dir)

    artifact_path = output_dir / f"{artifact_stem}-diagnostics.json"
    artifact_path.write_text(json.dumps(artifact, indent=2) + "\n")

    print(f"\nSaved diagnostics artifact: {artifact_path}")
    print(f"Build {'succeeded' if result.returncode == 0 else 'failed'} in {elapsed}s")
    print(f"Found {len(warnings)} type-check warnings above {threshold}ms threshold\n")

    if warnings:
        print(f"{'Duration':>10}  {'Kind':<15}  {'Location'}")
        print(f"{'--------':>10}  {'----':<15}  {'--------'}")
        for w in warnings[:20]:
            loc = f"{w['file']}:{w['line']}:{w['column']}"
            label = w["name"] if w["name"] else "(expression)"
            print(f"{w['duration_ms']:>8}ms  {w['kind']:<15}  {loc}  {label}")
        if len(warnings) > 20:
            print(f"\n  ... and {len(warnings) - 20} more (see {artifact_path})")
    else:
        print("No type-checking hotspots found above threshold.")

    if file_timings:
        print(f"\nPer-file compile times (top 20):\n")
        print(f"{'Duration':>12}  {'File'}")
        print(f"{'--------':>12}  {'----'}")
        for t in file_timings[:20]:
            print(f"{t['duration_seconds']:>10.3f}s  {t['file']}")
        if len(file_timings) > 20:
            print(f"\n  ... and {len(file_timings) - 20} more (see {artifact_path})")

    if stats_dir is not None:
        stat_files = list(stats_dir.glob("*.json"))
        print(f"\nCompiler statistics: {len(stat_files)} files written to {stats_dir}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
