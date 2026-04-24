# Benchmark Artifacts

All skills in this repository should treat `.build-benchmark/` as the canonical location for measured build evidence.

## Goals

- Keep build measurements reproducible.
- Make clean and incremental build data easy to compare.
- Preserve enough context for later specialist analysis without rerunning the benchmark.

## Wall-Clock vs Cumulative Task Time

The `duration_seconds` field on each run and the `median_seconds` in the summary represent **wall-clock time** -- how long the developer actually waits. This is the primary success metric.

The `timing_summary_categories` are **aggregated task times** parsed from Xcode's Build Timing Summary. Because Xcode runs many tasks in parallel across CPU cores, these totals typically exceed the wall-clock duration. A large cumulative `SwiftCompile` value is diagnostic evidence of compiler workload, not proof that compilation is blocking the build. Always compare category totals against the wall-clock median before concluding that a category is a bottleneck.

## File Layout

Recommended outputs:

- `.build-benchmark/<timestamp>-<scheme>.json`
- `.build-benchmark/<timestamp>-<scheme>-clean-1.log`
- `.build-benchmark/<timestamp>-<scheme>-clean-2.log`
- `.build-benchmark/<timestamp>-<scheme>-clean-3.log`
- `.build-benchmark/<timestamp>-<scheme>-cached-clean-1.log` (when COMPILATION_CACHE_ENABLE_CACHING is enabled)
- `.build-benchmark/<timestamp>-<scheme>-cached-clean-2.log`
- `.build-benchmark/<timestamp>-<scheme>-cached-clean-3.log`
- `.build-benchmark/<timestamp>-<scheme>-incremental-1.log`
- `.build-benchmark/<timestamp>-<scheme>-incremental-2.log`
- `.build-benchmark/<timestamp>-<scheme>-incremental-3.log`

Use an ISO-like UTC timestamp without spaces so the files sort naturally.

## Artifact Requirements

Each JSON artifact should include:

- schema version
- creation timestamp
- project context
- environment details when available
- the normalized build command
- separate `clean` and `incremental` run arrays
- summary statistics for each build type
- parsed timing-summary categories
- free-form notes for caveats or noise

## Clean, Cached Clean, And Incremental Separation

Do not merge different build type measurements into a single list. They answer different questions:

- **Clean builds** show full build-system, package, and module setup cost with a cold compilation cache.
- **Cached clean builds** show clean build cost when the compilation cache is warm. This is the realistic scenario for branch switching, pulling changes, or Clean Build Folder. Only present when `COMPILATION_CACHE_ENABLE_CACHING = YES` is detected.
- **Incremental builds** show edit-loop productivity and script or cache invalidation problems.

## Raw Logs

Store raw `xcodebuild` output beside the JSON artifact whenever possible. That allows later skills to:

- re-parse timing summaries
- inspect failed builds
- search for long type-check warnings
- correlate build-system phases with recommendations

## Measurement Caveats

### COMPILATION_CACHE_ENABLE_CACHING

`COMPILATION_CACHE_ENABLE_CACHING = YES` stores compiled artifacts in a system-managed cache outside DerivedData so that repeated compilations of identical inputs are served from cache. The standard clean-build benchmark (`xcodebuild clean` between runs) may add overhead from cache population without showing the corresponding cache-hit benefit.

The benchmark script automatically detects `COMPILATION_CACHE_ENABLE_CACHING = YES` and runs a **cached clean** benchmark phase. This phase:

1. Builds once to warm the compilation cache.
2. Deletes DerivedData (but not the compilation cache) before each measured run.
3. Rebuilds, measuring the cache-hit clean build time.

The cached clean metric captures the realistic developer experience: branch switching, pulling changes, and Clean Build Folder. Use the cached clean median as the primary comparison metric when evaluating `COMPILATION_CACHE_ENABLE_CACHING` impact.

To skip this phase, pass `--no-cached-clean`.

### First-Run Variance

The first clean build after the warmup cycle often runs 20-40% slower than subsequent clean builds due to cold OS-level caches (disk I/O, dynamic linker cache, etc.). The benchmark script mitigates this by running a warmup clean+build cycle before measured runs. If variance between the first and later clean runs is still high, prefer the median or min over the mean, and note the variance in the artifact's `notes` field.

## Shared Consumer Expectations

Any skill reading a benchmark artifact should be able to identify:

- what was measured
- how it was measured
- whether the run succeeded
- whether the results are stable enough to compare

For the authoritative field-level schema, see the `build-benchmark.schema.json` bundled with the xcode-build-benchmark skill.
