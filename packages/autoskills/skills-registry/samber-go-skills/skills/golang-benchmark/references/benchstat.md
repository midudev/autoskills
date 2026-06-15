# benchstat Reference

`benchstat` computes statistical summaries and A/B comparisons of Go benchmark results. A single benchmark run tells you nothing about variance — `benchstat` tells you whether the difference between two runs is real or noise.

## Installation

```bash
go install golang.org/x/perf/cmd/benchstat@latest
```

## Usage

```bash
benchstat [flags] inputs...
```

Each input is a file containing `go test -bench` output. Optionally label inputs with `label=path` syntax.

## Basic Workflow

### Step 0: Write benchmarks

Use the standard Go benchmark function signature in `*_test.go`:

### Step 1: Measure baseline

Run benchmarks with `-count=10` or more. Each run produces one data point — you need at least 10 to compute a meaningful confidence interval:

```bash
go test -run='^$' -bench=BenchmarkParse -benchmem -count=10 ./pkg/parser | tee old.txt
```

`-run='^$'` skips unit tests so only benchmarks run — avoids wasting time on tests during measurement sessions.

### Step 2: Make your change

Edit the code you want to optimize.

### Step 3: Measure again

Same command, same flags, same machine, same load conditions:

```bash
go test -run='^$' -bench=BenchmarkParse -benchmem -count=10 ./pkg/parser | tee new.txt
```

### Step 4: Compare

```bash
benchstat old.txt new.txt
```

Output:

```
goos: linux
goarch: amd64
pkg: myapp/pkg/parser
cpu: AMD Ryzen 9 5950X 16-Core Processor
          │   old.txt   │              new.txt               │
          │   sec/op    │   sec/op     vs base               │
Parse-32    4.592µ ± 2%   3.041µ ± 1%  -33.78% (p=0.000 n=10)

          │  old.txt   │             new.txt              │
          │    B/op    │    B/op     vs base              │
Parse-32    1.024Ki ± 0%   0.512Ki ± 0%  -50.00% (p=0.000 n=10)

          │  old.txt  │            new.txt             │
          │ allocs/op │ allocs/op   vs base            │
Parse-32    12.00 ± 0%   6.000 ± 0%  -50.00% (p=0.000 n=10)
```

## Reading the Output

| Element | Meaning | What to look for |
| --- | --- | --- |
| **median** (e.g., `4.592µ`) | Central value across runs — more robust than mean because outliers don't skew it | The reference number for this benchmark |
| **± N%** (e.g., `± 2%`) | Half-width of the 95% confidence interval as a percentage of the median | Low (≤2%) = stable measurement. High (>5%) = noisy — investigate noise sources before trusting results |
| **vs base** (e.g., `-33.78%`) | Percentage change from the first input (base) to subsequent inputs | Negative = faster/smaller. Positive = slower/larger |
| **p=N** (e.g., `p=0.000`) | p-value from Mann-Whitney U-test (non-parametric) | <0.05 = statistically significant. ≥0.05 = difference could be noise |
| **n=N** (e.g., `n=10`) | Number of samples used in the comparison | Should usually match your `-count`; if it does not, check that each input file contains the same benchmark rows and units |
| **`~`** | No statistically significant difference detected | Do NOT claim improvement — the change might be zero |
| **geomean** row | Geometric mean of changes across all benchmarks in the table | Overall proportional change; useful when comparing many benchmarks at once |

### Unit normalization

benchstat automatically normalizes units for display:

- `ns/op` → displayed as `sec/op` (with µ, m prefixes) to avoid nonsensical `µns/op`
- `MB/s` → displayed as `B/s` (with K, M, G prefixes)

### When the `~` symbol appears

```
Parse-32    4.592µ ± 8%   4.481µ ± 7%  ~ (p=0.089 n=10)
```

This means benchstat cannot distinguish the difference from random noise. The wide confidence intervals (±8%, ±7%) overlap. Do not claim improvement. Options:

- Increase `-count` to 20+ (narrower CI may reveal a real difference)
- Reduce noise sources (close applications, plug in power, use dedicated machine)
- Accept that the change has no measurable effect on this benchmark

## Flags Reference

### Projection flags

These flags control how benchmark results are grouped into tables, rows, and columns.

| Flag | Default | Purpose |
| --- | --- | --- |
| `-table KEYS` | `.config` | Group results into separate tables by these keys |
| `-row KEYS` | `.fullname` | Group results into table rows by these keys |
| `-col KEYS` | `.file` | Compare across columns with different values of these keys |
| `-ignore KEYS` | (none) | Omit keys from grouping — suppresses "benchmarks vary" warnings |

**Available keys:**

| Key | Meaning | Example value |
| --- | --- | --- |
| `.name` | Base benchmark name (without sub-benchmark config) | `Parse` from `BenchmarkParse/size=4k-16` |
| `.fullname` | Full name including sub-benchmark configuration | `Parse/size=4k-16` |
| `.file` | Input file name or custom label | `old.txt` or `baseline` |
| `.config` | All file-level configuration keys combined | `goos/goarch/pkg/cpu` |
| `.unit` | Metric unit name | `sec/op`, `B/op`, `allocs/op` |
| `/{name-key}` | Per-benchmark sub-name key | `/size` extracts `4k` from `Parse/size=4k` |
| `/gomaxprocs` | GOMAXPROCS value — recognizes both `/gomaxprocs=N` and the `-N` suffix convention | `16` from `Parse-16` |
| `goos` | Operating system (from benchmark output header) | `linux`, `darwin` |
| `goarch` | Architecture (from benchmark output header) | `amd64`, `arm64` |
| `pkg` | Package path (from benchmark output header) | `myapp/pkg/parser` |
| `cpu` | CPU model (from benchmark output header) | `AMD Ryzen 9 5950X` |

**Sort order modifiers** — append to any key:

| Modifier | Meaning | Example |
| --- | --- | --- |
| `@alpha` | Alphabetic sort | `/format@alpha` |
| `@num` | Numeric sort (understands prefixes: 2k, 1Mi) | `/size@num` |
| `@(val1 val2 ...)` | Fixed order + filter (only listed values, in this order) | `/format@(gob json)` |

### Filter flag

| Flag | Purpose |
| --- | --- |
| `-filter EXPR` | Filter which benchmarks are processed before grouping and comparison |

See [Filter Expression Syntax](#filter-expression-syntax) below for full details.

### Input labeling

Not a flag but a syntax feature — label input files for clearer column headers:

```bash
# Default: file names become column headers
benchstat old.txt new.txt

# Custom labels
benchstat baseline=old.txt optimized=new.txt

# Multiple versions
benchstat v1=v1.txt v2=v2.txt v3=v3.txt
```

The first input is always the **base** for comparison. All subsequent inputs are compared against it.

## Filter Expression Syntax

Filters select which benchmarks to include before grouping and comparison. The syntax is:

### Matching operators

| Pattern | Meaning | Example |
| --- | --- | --- |
| `key:value` | Exact match | `goos:linux` |
| `key:"value"` | Exact match with quoted value (allows spaces, special chars) | `pkg:"github.com/user/repo"` |
| `key:/regexp/` | Regular expression match (Go regexp syntax) | `.name:/Parse\|Encode/` |
| `key:(val1 OR val2)` | Match any of the listed values | `goos:(linux OR darwin)` |
| `*` | Match everything (all benchmarks) | `*` |

### Logical operators

| Operator | Meaning | Example |
| --- | --- | --- |
| `x y` | AND — both must match (implicit) | `goos:linux goarch:amd64` |
| `x AND y` | AND — explicit form | `goos:linux AND goarch:amd64` |
| `x OR y` | OR — either must match | `goos:linux OR goos:darwin` |
| `-x` | NOT — must not match | `-goos:windows` |
| `(...)` | Grouping / subexpression | `(goos:linux OR goos:darwin) -pkg:/internal/` |

### Filter key types

| Key | What it matches | Example |
| --- | --- | --- |
| `.name` | Base benchmark name | `.name:Parse` |
| `.fullname` | Full name with sub-benchmark config | `.fullname:/Parse\/size=4k/` |
| `/{name-key}` | Sub-benchmark parameter | `/size:4k` |
| `/gomaxprocs` | GOMAXPROCS value | `/gomaxprocs:16` |
| `.file` | Input file label | `.file:old.txt` |
| `.unit` | Metric unit | `.unit:sec/op` |
| `goos` | OS from header | `goos:linux` |
| `goarch` | Architecture from header | `goarch:amd64` |
| `pkg` | Package from header | `pkg:/parser/` |

### Filter examples

```bash
# Only Parse benchmarks
benchstat -filter '.name:Parse' old.txt new.txt

# Only benchmarks with size=4096 sub-parameter
benchstat -filter '/size:4096' old.txt new.txt

# Exclude Parallel benchmarks
benchstat -filter '-.name:/Parallel/' old.txt new.txt

# Linux amd64 only
benchstat -filter 'goos:linux goarch:amd64' old.txt new.txt

# Multiple benchmark names
benchstat -filter '.name:(Parse OR Encode OR Decode)' old.txt new.txt

# Complex: Linux or Darwin, not internal packages, only sec/op metric
benchstat -filter '(goos:linux OR goos:darwin) -pkg:/internal/ .unit:sec/op' old.txt new.txt

# Regex: all benchmarks starting with Bench
benchstat -filter '.name:/^Bench/' old.txt new.txt
```

## Projection Examples

### Default: before/after file comparison

```bash
benchstat old.txt new.txt
# Equivalent to:
benchstat -table .config -row .fullname -col .file old.txt new.txt
```

Creates one row per benchmark, one column per file.

### Compare sub-benchmark parameters within a single file

When a single benchmark file contains multiple sub-benchmarks (e.g., `BenchmarkEncode/format=json` and `BenchmarkEncode/format=gob`):

```bash
benchstat -col /format bench.txt
```

Creates columns for each value of `/format`, comparing them against each other.

### Simplify rows to base name only

```bash
benchstat -col /format -row .name bench.txt
```

Strips sub-benchmark configuration from row names, making the table more compact.

### Control column order

```bash
# Force gob first, then json (instead of alphabetical)
benchstat -col '/format@(gob json)' bench.txt
```

### Group by GOMAXPROCS

```bash
benchstat -col /gomaxprocs bench.txt
```

Compares performance across different GOMAXPROCS values within the same file.

### Separate tables per package

```bash
benchstat -table pkg old.txt new.txt
```

Creates one table per package — useful when comparing benchmarks across multiple packages.

### Ignore a dimension

```bash
# Suppress "benchmarks vary in /gomaxprocs" warning
benchstat -row .name -ignore /gomaxprocs bench.txt
```

### Compare three versions

```bash
benchstat v1=v1.txt v2=v2.txt v3=v3.txt
```

Shows v2 vs v1 and v3 vs v1 (first input is always the base).

### Cross-dimensional comparison

```bash
# Rows = benchmark name, columns = OS, separate tables per architecture
benchstat -row .name -col goos -table goarch results.txt
```

## Unit Metadata

### `assume=exact`

For metrics that should not vary between runs (e.g., binary size, generated code size):

```
BenchmarkSize 1 42 custom-bytes/op
Unit custom-bytes/op assume=exact
```

With `assume=exact`:

- Non-parametric statistics are disabled
- benchstat warns if measured values vary
- Shows comparisons even with a single before/after measurement (no `-count` needed)

### `assume=nothing` (default)

Standard behavior — uses non-parametric statistics (median + Mann-Whitney U-test). Requires multiple samples.

## Interleaving Runs

Sequential runs (all old, then all new) are vulnerable to **systematic bias** — thermal throttling builds up over time, background processes come and go, CPU frequency scaling adapts. Interleaving reduces this:

```bash
# Pre-compile both versions to avoid measuring compilation time
go test -c -o old.test ./pkg/parser
# ... make your change ...
go test -c -o new.test ./pkg/parser

# Interleave runs — alternating reduces systematic bias
for i in $(seq 1 10); do
    ./old.test -test.bench=BenchmarkParse -test.benchmem >> old.txt
    ./new.test -test.bench=BenchmarkParse -test.benchmem >> new.txt
done

benchstat old.txt new.txt
```

Pre-compiling with `go test -c` is critical — without it, each `go test -bench` invocation includes compilation time, which varies and contaminates results.

## How Many Runs?

| Scenario | Minimum `-count` | Why |
| --- | --- | --- |
| Quick local check | 6 | Enough for a rough confidence interval; fast feedback loop |
| Pre-merge comparison | 10 | Standard for detecting moderate (>5%) changes with confidence |
| Detecting small changes (<5%) | 20-30 | More samples narrow the CI; needed when signal is small relative to noise |
| Noisy CI environment | 20+ | Shared CI runners have higher variance; more runs compensate |

**Never "retry until significant"** — rerunning benchmarks until `~` goes away introduces selection bias (p-hacking). If 10 runs show `~`, the change is probably not meaningful. Increase run count **once** and accept the result.

At α=0.05, expect ~5% of benchmarks to randomly report significance with no real change (false positives). This is normal — don't chase them.

## Single-File Summary

Analyze variance of a single run without comparison:

```bash
benchstat bench.txt
```

Shows median and confidence interval for each benchmark. Use to:

- Check measurement stability before making code changes
- Identify noisy benchmarks that need more runs or better isolation
- Get a quick summary of current performance

## Common Pitfalls

| Pitfall | Why it's wrong | Fix |
| --- | --- | --- |
| `-count=1` | Single run has no variance information; benchstat can't compute confidence | Always use `-count=6` minimum, prefer `-count=10` |
| Running on a laptop on battery | CPU throttles to save power; variance explodes | Plug in, disable power saving, or use a desktop/server |
| Running with browser/IDE open | Background processes steal CPU cycles; adds noise | Close unnecessary applications, or accept wider CIs |
| Rerunning until `~` disappears | Selection bias (p-hacking) — you're cherry-picking runs that showed improvement | Run once with high `-count`, accept the result |
| Comparing across machines | Different CPUs, memory, OS = incomparable baselines | Same machine, same conditions, both runs |
| Not interleaving | Systematic bias from thermal throttling, background load drift | Pre-compile both versions with `go test -c`, alternate runs |
| Measuring compilation time | `go test -bench` compiles first; startup overhead varies | Pre-compile with `go test -c`, run the binary directly |
| Ignoring wide CI (± >5%) | Results look significant but variance is too high to be trustworthy | Fix the noise first, then compare; or increase `-count` |
| Comparing different `-count` values | Unequal sample sizes bias the comparison | Use the same `-count` for all inputs |

## benchstat in CI

See [CI Regression Detection](./ci-regression.md) for integrating benchstat comparisons into CI pipelines with benchdiff, cob, and gobenchdata.
