# Orchestration Report Template

Use this structure when the orchestrator consolidates benchmark evidence and specialist findings. The `generate_optimization_report.py` script produces this format automatically when given the benchmark and diagnostics artifacts.

```markdown
# Xcode Build Optimization Plan

## Project Context
- **Project:** `App.xcodeproj`
- **Scheme:** `MyApp`
- **Configuration:** `Debug`
- **Destination:** `platform=iOS Simulator,name=iPhone 16`
- **Xcode:** Xcode 26.x
- **Date:** 2026-01-01T00:00:00Z
- **Benchmark artifact:** `.build-benchmark/<timestamp>-<scheme>.json`

## Baseline Benchmarks

| Metric | Clean | Cached Clean | Zero-Change |
|--------|-------|-------------|-------------|
| Median | 0.000s | 0.000s | 0.000s |
| Min | 0.000s | 0.000s | 0.000s |
| Max | 0.000s | 0.000s | 0.000s |
| Runs | 3 | 3 | 3 |

> **Cached Clean** = clean build with a warm compilation cache. This is the realistic scenario for branch switching, pulling changes, or Clean Build Folder. Only present when `COMPILATION_CACHE_ENABLE_CACHING = YES` is detected. "Zero-Change" = rebuild with no edits (measures fixed overhead). Use `--touch-file` in the benchmark script to measure true incremental builds where a source file is modified.

### Clean Build Timing Summary

> **Note:** These are aggregated task times across all CPU cores. Because Xcode runs many tasks in parallel, these totals typically exceed the actual build wait time shown above. A large number here does not mean it is blocking your build.

| Category | Tasks | Seconds |
|----------|------:|--------:|
| SwiftCompile | 325 | 271.245s |
| SwiftEmitModule | 30 | 23.625s |
| ... | ... | ... |

## Build Settings Audit

### Debug Configuration
- [x] `SWIFT_COMPILATION_MODE`: `(unset)` (recommended: `singlefile`)
- [x] `SWIFT_OPTIMIZATION_LEVEL`: `-Onone` (recommended: `-Onone`)
- [x] `GCC_OPTIMIZATION_LEVEL`: `0` (recommended: `0`)
- [x] `ONLY_ACTIVE_ARCH`: `YES` (recommended: `YES`)
- [x] `DEBUG_INFORMATION_FORMAT`: `dwarf` (recommended: `dwarf`)
- [x] `ENABLE_TESTABILITY`: `YES` (recommended: `YES`)
- [x] `EAGER_LINKING`: `YES` (recommended: `YES`)

### General (All Configurations)
- [x] `COMPILATION_CACHE_ENABLE_CACHING`: `YES` (recommended: `YES`)
- [x] `SWIFT_USE_INTEGRATED_DRIVER`: `YES` (recommended: `YES`)
- [x] `CLANG_ENABLE_MODULES`: `YES` (recommended: `YES`)

### Release Configuration
- [x] `SWIFT_COMPILATION_MODE`: `wholemodule` (recommended: `wholemodule`)
- [x] `SWIFT_OPTIMIZATION_LEVEL`: `-O` (recommended: `-O`)
- ...

### Cross-Target Consistency
- [x] `SWIFT_COMPILATION_MODE` is consistent across all targets
- [ ] `OTHER_SWIFT_FLAGS` has target-level overrides: ...

## Compilation Diagnostics

| Duration | Kind | File | Line | Name |
|---------:|------|------|-----:|------|
| 150ms | function-body | MyView.swift | 42 | body |
| ... | ... | ... | ... | ... |

## Prioritized Recommendations

### 1. Recommendation title
**Wait-Time Impact:** Expected to reduce your clean build by approximately 3 seconds.
**Category:** project
**Evidence:** ...
**Impact:** High
**Confidence:** High
**Risk:** Low

## Approval Checklist
- [ ] **1. Recommendation title** -- Wait-Time Impact: ~3s clean build reduction | Risk: Low
- [ ] **2. Another recommendation** -- Wait-Time Impact: Uncertain, re-benchmark to confirm | Risk: Low

## Next Steps

After implementing approved changes, re-benchmark with the same inputs:

...

Compare the new wall-clock medians against the baseline. Report results as:
"Your [clean/incremental] build now takes X.Xs (was Y.Ys) -- Z.Zs faster/slower."

## Execution Report (post-approval)

### Baseline
- Clean build median: X.Xs
- Cached clean build median: X.Xs (if applicable)
- Incremental build median: X.Xs

### Changes Applied

| # | Change | Actionability | Measured Result | Status |
|---|--------|---------------|-----------------|--------|
| 1 | Description of change | repo-local | Clean: X.Xs→Y.Ys, Incr: X.Xs→Y.Ys | Kept / Reverted / Blocked |
| 2 | ... | ... | ... | ... |

Status values: `Kept`, `Kept (best practice)`, `Reverted`, `Blocked`, `No improvement`

### Final Cumulative Result
- Post-change clean build: X.Xs (was Y.Ys) -- Z.Zs faster/slower
- Post-change cached clean build: X.Xs (was Y.Ys) -- Z.Zs faster/slower (when COMPILATION_CACHE_ENABLE_CACHING enabled)
- Post-change incremental build: X.Xs (was Y.Ys) -- Z.Zs faster/slower
- **Net result:** Faster / Slower / Unchanged
- If cumulative task metrics improved but wall-clock did not: "Compiler workload decreased but build wait time did not improve. This is expected when Xcode runs these tasks in parallel with other equally long work."
- If standard clean builds are slower but cached clean builds are faster: "Standard clean builds show overhead from compilation cache population. Cached clean builds (the realistic developer workflow) are faster, confirming the net benefit."

### Blocked or Non-Actionable Findings
- Finding: reason it could not be addressed from the repo

## Remaining follow-up ideas
- Item:
- Why it was deferred:

## Share your results

Add your improvement to the community results table by opening a pull request.
Copy the row below and append it to the table in README.md:

| <project-name> | X.Xs → X.Xs (-X.Xs / X% faster) | X.Xs → X.Xs (-X.Xs / X% faster) |

Open a PR: https://github.com/AvdLee/Xcode-Build-Optimization-Agent-Skill/edit/main/README.md
```

## Usage Notes

- Keep approval-required items explicit.
- Do not imply that an unapproved recommendation was applied.
- If results are noisy, say that the verification is inconclusive instead of overstating success.
- The Build Settings Audit scope is strictly build performance. Do not flag language-migration settings like `SWIFT_STRICT_CONCURRENCY` or `SWIFT_UPCOMING_FEATURE_*`.
- The Compilation Diagnostics section is populated by `diagnose_compilation.py`. If not run, note that it was skipped.
- `COMPILATION_CACHE_ENABLE_CACHING` has been measured at 5-14% faster clean builds across tested projects. The benefit compounds in real developer workflows (branch switching, pulling changes, CI with persistent DerivedData). The benchmark script auto-detects this setting and runs a cached clean phase for validation.
- When recommending SPM version pins, verify that tagged versions exist (`git ls-remote --tags`) before suggesting a pin-to-tag change. If no tags exist, recommend pinning to a commit revision hash.
- Before including a local package in a build-time recommendation, verify it is referenced in `project.pbxproj` via `XCLocalSwiftPackageReference`. Packages that exist on disk but are not linked do not affect build time.
