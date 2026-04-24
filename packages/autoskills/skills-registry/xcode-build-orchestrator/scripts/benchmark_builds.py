#!/usr/bin/env python3

import argparse
import json
import os
import platform
import re
import shutil
import statistics
import subprocess
import sys
import tempfile
import time
from datetime import datetime, timezone
from pathlib import Path
from typing import Dict, List, Optional


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Benchmark Xcode clean and incremental builds.")
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("--workspace", help="Path to the .xcworkspace file")
    group.add_argument("--project", help="Path to the .xcodeproj file")
    parser.add_argument("--scheme", required=True, help="Scheme to build")
    parser.add_argument("--configuration", default="Debug", help="Build configuration")
    parser.add_argument("--destination", help="xcodebuild destination string")
    parser.add_argument("--derived-data-path", help="DerivedData path override")
    parser.add_argument("--output-dir", default=".build-benchmark", help="Output directory for artifacts")
    parser.add_argument("--repeats", type=int, default=3, help="Measured runs per build type")
    parser.add_argument("--skip-warmup", action="store_true", help="Skip the validation build")
    parser.add_argument(
        "--touch-file",
        help="Path to a source file to touch before each incremental build. "
        "When provided, measures a real edit-rebuild loop instead of a zero-change build.",
    )
    parser.add_argument(
        "--no-cached-clean",
        action="store_true",
        help="Skip cached clean builds even when COMPILATION_CACHE_ENABLE_CACHING is detected.",
    )
    parser.add_argument(
        "--extra-arg",
        action="append",
        default=[],
        help="Additional xcodebuild argument to append. Can be passed multiple times.",
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


def shell_join(parts: List[str]) -> str:
    return " ".join(subprocess.list2cmdline([part]) for part in parts)


_TASK_COUNT_RE = re.compile(r"^(.+?)\s*\((\d+)\s+tasks?\)$")


def _extract_task_count(name: str) -> tuple[str, Optional[int]]:
    """Split 'Category (N tasks)' into ('Category', N)."""
    match = _TASK_COUNT_RE.match(name)
    if match:
        return match.group(1).strip(), int(match.group(2))
    return name, None


def parse_timing_summary(output: str) -> List[Dict]:
    categories: Dict[str, float] = {}
    task_counts: Dict[str, Optional[int]] = {}
    for raw_line in output.splitlines():
        line = raw_line.strip()
        if not line:
            continue
        for suffix in (" seconds", " second", " sec"):
            if not line.endswith(suffix):
                continue
            trimmed = line[: -len(suffix)]
            if "|" in trimmed:
                name_part, _, seconds_text = trimmed.rpartition("|")
            else:
                name_part, _, seconds_text = trimmed.rpartition(" ")
            try:
                seconds = float(seconds_text.strip())
            except ValueError:
                continue
            cleaned_name = name_part.replace("  ", " ").strip(" -:")
            if len(cleaned_name) < 3:
                continue
            base_name, count = _extract_task_count(cleaned_name)
            categories[base_name] = categories.get(base_name, 0.0) + seconds
            if count is not None:
                task_counts[base_name] = (task_counts.get(base_name) or 0) + count
            break
    result: List[Dict] = []
    for name, seconds in sorted(categories.items(), key=lambda item: item[1], reverse=True):
        entry: Dict = {"name": name, "seconds": round(seconds, 3)}
        if name in task_counts:
            entry["task_count"] = task_counts[name]
        result.append(entry)
    return result


def run_command(command: List[str]) -> subprocess.CompletedProcess:
    return subprocess.run(command, capture_output=True, text=True)


def stats_for(runs: List[Dict[str, object]]) -> Dict[str, float]:
    durations = [run["duration_seconds"] for run in runs if run.get("success")]
    if not durations:
        return {
            "count": 0,
            "min_seconds": 0.0,
            "max_seconds": 0.0,
            "median_seconds": 0.0,
            "average_seconds": 0.0,
        }
    return {
        "count": len(durations),
        "min_seconds": round(min(durations), 3),
        "max_seconds": round(max(durations), 3),
        "median_seconds": round(statistics.median(durations), 3),
        "average_seconds": round(statistics.fmean(durations), 3),
    }


def xcode_version() -> str:
    result = run_command(["xcodebuild", "-version"])
    return result.stdout.strip() if result.returncode == 0 else "unknown"


def detect_compilation_caching(base_command: List[str]) -> bool:
    """Check whether COMPILATION_CACHE_ENABLE_CACHING is enabled in the resolved build settings."""
    result = run_command([*base_command, "-showBuildSettings"])
    if result.returncode != 0:
        return False
    for line in result.stdout.splitlines():
        stripped = line.strip()
        if stripped.startswith("COMPILATION_CACHE_ENABLE_CACHING") and "=" in stripped:
            value = stripped.split("=", 1)[1].strip()
            return value == "YES"
    return False


def measure_build(
    base_command: List[str],
    artifact_stem: str,
    output_dir: Path,
    build_type: str,
    run_index: int,
) -> Dict[str, object]:
    build_command = [*base_command, "build", "-showBuildTimingSummary"]
    started = time.perf_counter()
    result = run_command(build_command)
    elapsed = round(time.perf_counter() - started, 3)
    log_path = output_dir / f"{artifact_stem}-{build_type}-{run_index}.log"
    log_path.write_text(result.stdout + result.stderr)
    return {
        "id": f"{build_type}-{run_index}",
        "build_type": build_type,
        "duration_seconds": elapsed,
        "success": result.returncode == 0,
        "exit_code": result.returncode,
        "command": shell_join(build_command),
        "raw_log_path": str(log_path),
        "timing_summary_categories": parse_timing_summary(result.stdout + result.stderr),
    }


def main() -> int:
    args = parse_args()
    output_dir = Path(args.output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    timestamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    artifact_stem = f"{timestamp}-{args.scheme.replace(' ', '-').lower()}"
    base_command = command_base(args)

    if not args.skip_warmup:
        warmup = run_command([*base_command, "build"])
        if warmup.returncode != 0:
          sys.stderr.write(warmup.stdout + warmup.stderr)
          return warmup.returncode
        warmup_clean = run_command([*base_command, "clean"])
        if warmup_clean.returncode != 0:
            sys.stderr.write(warmup_clean.stdout + warmup_clean.stderr)
            return warmup_clean.returncode
        warmup_rebuild = run_command([*base_command, "build"])
        if warmup_rebuild.returncode != 0:
            sys.stderr.write(warmup_rebuild.stdout + warmup_rebuild.stderr)
            return warmup_rebuild.returncode

    runs: Dict[str, list] = {"clean": [], "incremental": []}

    for index in range(1, args.repeats + 1):
        clean_result = run_command([*base_command, "clean"])
        clean_log_path = output_dir / f"{artifact_stem}-clean-prep-{index}.log"
        clean_log_path.write_text(clean_result.stdout + clean_result.stderr)
        if clean_result.returncode != 0:
            sys.stderr.write(clean_result.stdout + clean_result.stderr)
            return clean_result.returncode
        runs["clean"].append(measure_build(base_command, artifact_stem, output_dir, "clean", index))

    # --- Cached clean builds ---------------------------------------------------
    # When COMPILATION_CACHE_ENABLE_CACHING is enabled, the compilation cache lives outside
    # DerivedData and survives product deletion.  We measure "cached clean"
    # builds by pointing DerivedData at a temp directory, warming the cache with
    # one build, then deleting the DerivedData directory (but not the cache)
    # before each measured rebuild.  This captures the realistic scenario:
    # branch switching, pulling changes, or Clean Build Folder.
    should_cached_clean = not args.no_cached_clean and detect_compilation_caching(base_command)
    if should_cached_clean:
        dd_path = Path(args.derived_data_path) if args.derived_data_path else Path(
            tempfile.mkdtemp(prefix="xcode-bench-dd-")
        )
        cached_cmd = list(base_command)
        if not args.derived_data_path:
            cached_cmd.extend(["-derivedDataPath", str(dd_path)])

        cache_warmup = run_command([*cached_cmd, "build"])
        if cache_warmup.returncode != 0:
            sys.stderr.write("Warning: cached clean warmup build failed, skipping cached clean benchmarks.\n")
            sys.stderr.write(cache_warmup.stdout + cache_warmup.stderr)
            should_cached_clean = False

    if should_cached_clean:
        runs["cached_clean"] = []
        for index in range(1, args.repeats + 1):
            shutil.rmtree(dd_path, ignore_errors=True)
            runs["cached_clean"].append(
                measure_build(cached_cmd, artifact_stem, output_dir, "cached-clean", index)
            )
        shutil.rmtree(dd_path, ignore_errors=True)

    # --- Incremental / zero-change builds --------------------------------------
    incremental_label = "incremental"
    if args.touch_file:
        touch_path = Path(args.touch_file)
        if not touch_path.exists():
            sys.stderr.write(f"--touch-file path does not exist: {touch_path}\n")
            return 1
        incremental_label = "incremental"
    else:
        incremental_label = "zero-change"

    for index in range(1, args.repeats + 1):
        if args.touch_file:
            touch_path.touch()
        runs["incremental"].append(
            measure_build(base_command, artifact_stem, output_dir, incremental_label, index)
        )

    summary: Dict[str, object] = {
        "clean": stats_for(runs["clean"]),
        "incremental": stats_for(runs["incremental"]),
    }
    if "cached_clean" in runs:
        summary["cached_clean"] = stats_for(runs["cached_clean"])

    artifact = {
        "schema_version": "1.2.0" if "cached_clean" in runs else "1.1.0",
        "created_at": datetime.now(timezone.utc).isoformat(),
        "build": {
            "entrypoint": "workspace" if args.workspace else "project",
            "path": args.workspace or args.project,
            "scheme": args.scheme,
            "configuration": args.configuration,
            "destination": args.destination or "",
            "derived_data_path": args.derived_data_path or "",
            "command": shell_join(base_command),
        },
        "environment": {
            "host": platform.node(),
            "macos_version": platform.platform(),
            "xcode_version": xcode_version(),
            "cwd": os.getcwd(),
        },
        "runs": runs,
        "summary": summary,
        "notes": [f"touch-file: {args.touch_file}"] if args.touch_file else [],
    }

    artifact_path = output_dir / f"{artifact_stem}.json"
    artifact_path.write_text(json.dumps(artifact, indent=2) + "\n")

    print(f"Saved benchmark artifact: {artifact_path}")
    print(f"Clean median: {artifact['summary']['clean']['median_seconds']}s")
    if "cached_clean" in artifact["summary"]:
        print(f"Cached clean median: {artifact['summary']['cached_clean']['median_seconds']}s")
    inc_label = "Incremental" if args.touch_file else "Zero-change"
    print(f"{inc_label} median: {artifact['summary']['incremental']['median_seconds']}s")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
