---
name: xcode-build-orchestrator
description: Orchestrate Xcode build optimization by benchmarking first, running the specialist analysis skills, prioritizing findings, requesting explicit approval, delegating approved fixes to xcode-build-fixer, and re-benchmarking after changes. Use when a developer wants an end-to-end build optimization workflow, asks to speed up Xcode builds, wants a full build audit, or needs a recommend-first optimization pass covering compilation, project settings, and packages.
---

# Xcode Build Orchestrator

Use this skill as the recommend-first entrypoint for end-to-end Xcode build optimization work.

## Non-Negotiable Rules

- Wall-clock build time (how long the developer waits) is the primary success metric. Every recommendation must state its expected impact on the developer's actual wait time.
- Start in recommendation mode.
- Benchmark before making changes.
- Do not modify project files, source files, packages, or scripts without explicit developer approval.
- Preserve the evidence trail for every recommendation.
- Re-benchmark after approved changes and report the wall-clock delta.

## Two-Phase Workflow

The orchestration is designed as two distinct phases separated by developer review.

### Phase 1 -- Analyze (recommend-only)

Run this phase in agent mode because the agent needs to execute builds, run benchmark scripts, write benchmark artifacts, and generate the optimization report. However, treat Phase 1 as **recommend-only**: do not modify any project files, source files, packages, or build settings. The only files the agent creates during this phase are benchmark artifacts and the optimization plan inside `.build-benchmark/`.

1. Collect the build target context: workspace or project, scheme, configuration, destination, and current pain point. When both `.xcworkspace` and `.xcodeproj` exist, prefer `.xcodeproj` unless the workspace contains sub-projects required for the build. Workspaces that reference external projects may fail if those projects are not checked out.
2. Run `xcode-build-benchmark` to establish a baseline if no fresh benchmark exists. The benchmark script auto-detects `COMPILATION_CACHE_ENABLE_CACHING = YES` and includes cached clean builds that measure the realistic developer experience (warm cache). If the build fails to compile, check `git log` for a recent buildable commit. When working in a worktree, cherry-picking a targeted build fix from a feature branch is acceptable to reach a buildable state. If SPM packages reference gitignored directories in their `exclude:` paths (e.g., `__Snapshots__`), create those directories before building -- worktrees do not contain gitignored content and `xcodebuild -resolvePackageDependencies` will crash otherwise.
3. Verify the benchmark artifact has non-empty `timing_summary_categories`. If empty, the timing summary parser may have failed -- re-parse the raw logs or inspect them manually. If `COMPILATION_CACHE_ENABLE_CACHING` is enabled, also verify the artifact includes `cached_clean` runs.
   - **Benchmark confidence check**: For each build type (clean, cached clean, incremental), compare the min and max values. If the spread (max - min) exceeds 20% of the median, flag the benchmark as having high variance and recommend running additional repetitions (5+ runs) before drawing conclusions. High variance makes it difficult to distinguish real improvements from noise. After applying changes, only claim an improvement if the post-change median falls outside the baseline's min-max range.
4. If incremental builds are the primary pain point and Xcode 16.4+ is available, recommend the developer enable **Task Backtraces** (Scheme Editor > Build tab > Build Debugging > "Task Backtraces"). This reveals why each task re-ran, which is critical for diagnosing unexpected replanning or input invalidation. Include any Task Backtrace evidence in the analysis.
5. Determine whether compile tasks are likely blocking wall-clock progress or just consuming parallel CPU time. Compare the sum of all timing-summary category seconds against the wall-clock median: if the sum is 2x+ the median, most work is parallelized and compile hotspot fixes are unlikely to reduce wait time. If `SwiftCompile`, `CompileC`, `SwiftEmitModule`, or `Planning Swift module` dominate the timing summary **and** appear likely to be on the critical path, run `diagnose_compilation.py` to capture type-checking hotspots. If they are parallelized, still run diagnostics but label findings as "parallel efficiency improvements" rather than "build time improvements."
6. Run the specialist analyses that fit the evidence by reading each skill's SKILL.md and applying its workflow:
   - [`xcode-compilation-analyzer`](../xcode-compilation-analyzer/SKILL.md)
   - [`xcode-project-analyzer`](../xcode-project-analyzer/SKILL.md)
   - [`spm-build-analysis`](../spm-build-analysis/SKILL.md)
7. Merge findings into a single prioritized improvement plan.
8. Generate the markdown optimization report using `generate_optimization_report.py` and save it to `.build-benchmark/optimization-plan.md`. This report includes the build settings audit, timing analysis, prioritized recommendations, and an approval checklist.
9. Stop and present the plan to the developer for review.

The developer reviews `.build-benchmark/optimization-plan.md`, checks the approval boxes for the recommendations they want implemented, and then triggers phase 2.

### Phase 2 -- Execute and verify (agent mode)

Run this phase in agent mode after the developer has reviewed and approved recommendations from the plan. Delegate all implementation work to [`xcode-build-fixer`](../xcode-build-fixer/SKILL.md) by reading its SKILL.md and applying its workflow.

10. Read `.build-benchmark/optimization-plan.md` and identify the approved items from the approval checklist.
11. Hand off to `xcode-build-fixer` with the approved plan. The fixer applies each approved change, verifies compilation, and re-benchmarks.
12. Append verification results to the optimization plan: post-change medians, absolute and percentage deltas, and confidence notes.
13. Report before and after results, plus any remaining follow-up opportunities.

## Prioritization Rules

The goal is to reduce how long the developer waits for builds to finish.

1. Identify the developer's primary pain (clean build, incremental build, or both) and the measured wall-clock median.
2. Determine what is likely **blocking** wall-clock progress:
   - If the sum of all timing-summary category seconds is 2x+ the wall-clock median, most work is parallelized. Compile hotspot fixes are unlikely to reduce wait time.
   - If a single serial category (e.g. `PhaseScriptExecution`, `CompileAssetCatalog`, `CodeSign`) accounts for a large fraction of wall-clock, that is the real bottleneck.
   - If `Planning Swift module` or `SwiftEmitModule` dominates incremental builds, the cause is likely invalidation or module size, not individual file compile speed.
3. Rank recommendations by likely wall-time savings, not cumulative task reduction.
4. Source-level compile fixes should not outrank project/graph/configuration fixes unless evidence suggests they are on the critical path.

Prefer changes that are measurable, reversible, and low-risk.

## Recommendation Impact Language

Every recommendation presented to the developer must include one of these impact statements:

- "Expected to reduce your [clean/incremental] build by approximately X seconds."
- "Reduces parallel compile work but is unlikely to reduce your build wait time because other tasks take equally long."
- "Impact on wait time is uncertain -- re-benchmark after applying to confirm."
- "No wait-time improvement expected. The benefit is [deterministic builds / faster branch switching / reduced CI cost]."
- For COMPILATION_CACHE_ENABLE_CACHING specifically: "Measured 5-14% faster clean builds across tested projects. The benefit compounds in real workflows where the cache persists between builds -- branch switching, pulling changes, and CI with persistent DerivedData."

Never quote cumulative task-time savings as the headline impact. If a change reduces 5 seconds of parallel compile work but another equally long task still runs, the developer's wait time does not change.

## Approval Gate

Before implementing anything, present a short approval list that includes:

- recommendation name
- expected wait-time impact (using the impact language above)
- evidence summary
- affected files or settings
- whether the change is low, medium, or high risk

Wait for explicit developer approval.

## Post-Approval Execution

After approval, delegate to `xcode-build-fixer`:

- the fixer implements only the approved items
- changes are applied atomically and kept scoped
- any deviations from the original recommendation plan are noted
- the fixer re-benchmarks with the same benchmark contract

## Final Report

Lead with the wall-clock result in plain language, e.g.: "Your clean build now takes 82s (was 86s) -- 4s faster." Then include:

- baseline clean and incremental wall-clock medians
- post-change clean and incremental wall-clock medians
- absolute and percentage wall-clock deltas
- what changed
- what was intentionally left unchanged
- confidence notes if noise prevents a strong conclusion -- if benchmark variance is high (min-to-max spread exceeds 20% of median), say so explicitly rather than presenting noisy numbers as definitive improvements or regressions
- if cumulative task metrics improved but wall-clock did not, say plainly: "Compiler workload decreased but build wait time did not improve. This is expected when Xcode runs these tasks in parallel with other equally long work."
- a ready-to-paste community results row and a link to open a PR (see the report template)

## Preferred Command Paths

### Benchmark

```bash
python3 scripts/benchmark_builds.py \
  --project App.xcodeproj \
  --scheme MyApp \
  --configuration Debug \
  --destination "platform=iOS Simulator,name=iPhone 16" \
  --output-dir .build-benchmark
```

For macOS apps use `--destination "platform=macOS"`. For watchOS use `--destination "platform=watchOS Simulator,name=Apple Watch Series 10"`. For tvOS use `--destination "platform=tvOS Simulator,name=Apple TV"`. Omit `--destination` to use the scheme's default.

To measure real incremental builds (file-touched rebuild) instead of zero-change builds, add `--touch-file path/to/SomeFile.swift`.

### Compilation Diagnostics

```bash
python3 scripts/diagnose_compilation.py \
  --project App.xcodeproj \
  --scheme MyApp \
  --configuration Debug \
  --destination "platform=iOS Simulator,name=iPhone 16" \
  --threshold 100 \
  --output-dir .build-benchmark
```

### Optimization Report

```bash
python3 scripts/generate_optimization_report.py \
  --benchmark .build-benchmark/<artifact>.json \
  --project-path App.xcodeproj \
  --diagnostics .build-benchmark/<diagnostics>.json \
  --output .build-benchmark/optimization-plan.md
```

## Additional Resources

- For the report template, see [references/orchestration-report-template.md](references/orchestration-report-template.md)
- For benchmark artifact requirements, see [references/benchmark-artifacts.md](references/benchmark-artifacts.md)
- For the recommendation format, see [references/recommendation-format.md](references/recommendation-format.md)
- For build settings best practices, see [references/build-settings-best-practices.md](references/build-settings-best-practices.md)
