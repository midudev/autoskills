# pprof Reference

`go tool pprof` is the primary tool for understanding where CPU time, memory, and contention go in Go programs. This file covers how to **use** the CLI and **interpret** the output. For enabling pprof endpoints on running services (net/http/pprof import, authentication, security), → See `samber/cc-skills-golang@golang-troubleshooting` skill.

## Profile Types

Each profile type answers a different performance question. Choosing the wrong profile type wastes investigation time — match the symptom to the profile before capturing.

| Profile | Flag / Endpoint | Use when | Why this profile and not another |
| --- | --- | --- | --- |
| **CPU** | `-cpuprofile` or `/debug/pprof/profile?seconds=30` | High CPU usage, slow functions | Samples which functions are on-CPU at 100Hz; misses off-CPU time (I/O, sleep) |
| **Heap (alloc_objects)** | `-memprofile` then `pprof -alloc_objects` | GC pressure, too many allocations | Counts allocation events regardless of size; useful when allocation frequency and object churn dominate |
| **Heap (alloc_space)** | `pprof -alloc_space` | Finding largest allocation sites by volume | Measures total bytes allocated; use when you need to reduce peak memory, not just GC frequency |
| **Heap (inuse_space)** | `pprof -inuse_space` | Memory growing over time, suspected leaks | Shows currently live heap objects; compare two snapshots to isolate leak sources |
| **Heap (inuse_objects)** | `pprof -inuse_objects` | Object count growth, suspected leak of small objects | Counts live objects regardless of size; useful when leak is many small objects not visible in inuse_space |
| **Goroutine** | `/debug/pprof/goroutine` | Blocked I/O, goroutine leaks, pool exhaustion | Snapshots all goroutine stacks; look for goroutines piling up on the same call site |
| **Mutex** | `/debug/pprof/mutex` | Lock contention between goroutines | Measures cumulative time goroutines waited to acquire mutexes. Must enable first: `runtime.SetMutexProfileFraction(5)` |
| **Block** | `/debug/pprof/block` | Goroutines blocked on channels, mutexes, timers, select | Measures cumulative time goroutines spent blocked on synchronization primitives. Must enable first: `runtime.SetBlockProfileRate(1)` |
| **Threadcreate** | `/debug/pprof/threadcreate` | Excessive OS thread creation | Shows stack traces that created new OS threads; typically from cgo calls or blocking syscalls that pin a thread |

### Choosing between alloc_objects and alloc_space

- **alloc_objects** — "where do I allocate the most often?" — use when allocation frequency and object churn are driving GC work
- **alloc_space** — "where do I allocate the most bytes?" — use for reducing peak memory usage and RSS
- In practice, start with `alloc_objects` because GC churn is the most common allocation-related bottleneck in Go.

### Choosing between inuse_space and alloc_space

- **alloc_space** is cumulative since program start — it includes objects already freed by GC
- **inuse_space** is a point-in-time snapshot — only currently live objects
- Use `alloc_space` to find allocation hot spots for optimization. Use `inuse_space` to debug memory leaks.

### Enabling mutex and block profiles

These profiles are disabled by default because they add overhead. Enable them before capturing:

```go
import "runtime"

// Mutex profiling: fraction of mutex contention events recorded.
// 5 means 1 out of 5 events is recorded. Higher = less overhead but less detail.
runtime.SetMutexProfileFraction(5)

// Block profiling: time-based sampling rate.
// 1 = record all blocking events. Higher values sample about one event per rate nanoseconds blocked.
// Use 1 for debugging, higher values (e.g. 1000000 = 1ms) for production.
runtime.SetBlockProfileRate(1)
```

Disable after investigation to eliminate overhead:

```go
runtime.SetMutexProfileFraction(0)
runtime.SetBlockProfileRate(0)
```

## Generating Profiles

### From benchmarks (no HTTP server needed)

```bash
# CPU profile — measures where compute time goes during benchmark execution
go test -bench=BenchmarkParse -cpuprofile=cpu.prof ./pkg/parser

# Memory profile — captures allocation patterns during benchmark
go test -bench=BenchmarkParse -memprofile=mem.prof ./pkg/parser

# Both at once — but be aware CPU profiling adds ~5% overhead which can skew memory results
go test -bench=BenchmarkParse -cpuprofile=cpu.prof -memprofile=mem.prof ./pkg/parser
```

### From running service

Requires `import _ "net/http/pprof"` (see `samber/cc-skills-golang@golang-troubleshooting` skill for secure setup):

```bash
# CPU profile — captures 30 seconds of CPU samples
go tool pprof http://localhost:6060/debug/pprof/profile?seconds=30

# Heap profile — snapshots current heap state
go tool pprof -alloc_objects http://localhost:6060/debug/pprof/heap

# Goroutine profile — snapshots all goroutine stacks
go tool pprof http://localhost:6060/debug/pprof/goroutine

# Mutex profile — contention data since last reset
go tool pprof http://localhost:6060/debug/pprof/mutex

# Block profile — blocking data since last reset
go tool pprof http://localhost:6060/debug/pprof/block
```

### From code (programmatic)

```go
import "runtime/pprof"

// CPU profile
f, _ := os.Create("cpu.prof")
pprof.StartCPUProfile(f)
defer pprof.StopCPUProfile()

// Heap snapshot at a specific point
f, _ := os.Create("heap.prof")
pprof.WriteHeapProfile(f)
f.Close()

// Named profile (goroutine, threadcreate, etc.)
pprof.Lookup("goroutine").WriteTo(f, 0)
```

## Interactive CLI Commands

Open a profile in interactive mode:

```bash
go tool pprof cpu.prof
# or from a URL:
go tool pprof http://localhost:6060/debug/pprof/profile?seconds=30
```

### `top` — self time ranking (start here)

The first command to run. Shows functions ranked by the time (or allocations) spent in the function itself:

```
(pprof) top
Showing nodes accounting for 4.2s, 84% of 5s total
      flat  flat%   sum%        cum   cum%
     1.50s 30.00% 30.00%      2.80s 56.00%  encoding/json.Marshal
     0.80s 16.00% 46.00%      0.80s 16.00%  runtime.mallocgc
     0.60s 12.00% 58.00%      0.60s 12.00%  runtime.memmove
     0.50s 10.00% 68.00%      0.50s 10.00%  runtime.scanobject
     0.40s  8.00% 76.00%      1.90s 38.00%  myapp/pkg/parser.Parse
     0.30s  6.00% 82.00%      0.30s  6.00%  syscall.syscall
     0.10s  2.00% 84.00%      0.10s  2.00%  runtime.futex
```

| Column | Meaning | How to read it |
| --- | --- | --- |
| **flat** | Time spent in the function itself, excluding callees | High flat = the function's own code is expensive |
| **flat%** | flat as percentage of total sample time | Quick way to see relative cost |
| **sum%** | Running total of flat% going down the list | "The top 3 functions account for 58% of total time" |
| **cum** | Time in function + all functions it calls (cumulative) | High cum with low flat = the function delegates to expensive callees |
| **cum%** | cum as percentage of total | Compare with flat% — big gap means the cost is in callees |

**Limiting output:**

```
(pprof) top 5              # show only top 5 functions
(pprof) top -cum 10        # top 10 by cumulative time
(pprof) top -flat 20       # top 20 by flat time (default sort)
```

### `top -cum` — cumulative time ranking

Critical when `top` shows runtime functions (`runtime.mallocgc`, `runtime.memmove`, `runtime.scanobject`) dominating. These are symptoms, not causes. `top -cum` reveals which **application** functions trigger them:

```
(pprof) top -cum
      flat  flat%   sum%        cum   cum%
     0.40s  8.00%  8.00%      3.80s 76.00%  myapp/pkg/handler.HandleRequest
     0.10s  2.00% 10.00%      2.80s 56.00%  myapp/pkg/handler.serializeResponse
     1.50s 30.00% 40.00%      2.80s 56.00%  encoding/json.Marshal
```

Now you can see that `HandleRequest` → `serializeResponse` → `json.Marshal` is the hot path. The optimization target is `serializeResponse`, not `runtime.mallocgc`.

### `list funcName` — annotated source

Shows the source code of a function with per-line cost annotations. This is how you pinpoint the **exact line** causing the bottleneck:

```
(pprof) list serializeResponse
Total: 5s
ROUTINE ======================== myapp/pkg/handler.serializeResponse
     0.10s      2.80s (flat, cum) 56.00% of Total
         .          .     38:func serializeResponse(w http.ResponseWriter, data any) {
         .      0.20s     39:    w.Header().Set("Content-Type", "application/json")
     0.10s      2.60s     40:    buf, err := json.Marshal(data)
         .          .     41:    if err != nil {
         .          .     42:        http.Error(w, err.Error(), 500)
         .          .     43:        return
         .          .     44:    }
         .      0.20s     45:    w.Write(buf)
         .          .     46:}
```

- Left column = **flat** time (work done by this line itself)
- Right column = **cumulative** time (this line + everything it calls)
- Line 40 accounts for 2.60s cumulative because `json.Marshal` is expensive

**Use `list` with a regex** to find all matching functions:

```
(pprof) list Parse.*       # all functions starting with Parse
(pprof) list \.Handle      # all Handle methods across packages
```

### `peek funcName` — callers and callees

Shows who calls a function and what it calls — the one-hop neighborhood in the call graph. Use to trace the responsibility chain when a function appears hot but you're unsure whether the problem is upstream (too many calls) or downstream (expensive callees):

```
(pprof) peek json.Marshal
Showing nodes accounting for 5s, 100% of 5s total
----------------------------------------------+-------------
                                               |      flat  flat%   sum%        cum   cum%
 myapp/pkg/handler.serializeResponse 2.60s     |
 myapp/pkg/api.buildResponse         0.20s     |     1.50s 30.00% 30.00%      2.80s 56.00%  encoding/json.Marshal
----------------------------------------------+-------------
                                               |
 reflect.Value.MapRange              0.40s     |
 encoding/json.(*encodeState).marshal 0.30s    |
 runtime.mallocgc                     0.80s    |
```

Top section = callers (who calls json.Marshal). Bottom section = callees (what json.Marshal calls internally).

### `tree` — hierarchical call tree

Displays the full call tree with cumulative costs at each level. Useful when you need more context than `peek` provides:

```
(pprof) tree
     0.40s  8.00%  8.00%      3.80s 76.00%  myapp/pkg/handler.HandleRequest
              0.10s  myapp/pkg/handler.serializeResponse
                     1.50s  encoding/json.Marshal
                            0.80s  runtime.mallocgc
              0.20s  myapp/pkg/handler.validateInput
              0.10s  myapp/pkg/handler.fetchData
```

### `traces` — raw stack traces

Dumps all raw sample stack traces. Each stack trace shows what the program was doing at the moment it was sampled:

```
(pprof) traces
-----------+-------------------------------------------------------
     bytes:  1.5MB
     1.50s   encoding/json.Marshal
             myapp/pkg/handler.serializeResponse
             myapp/pkg/handler.HandleRequest
             net/http.(*ServeMux).ServeHTTP
-----------+-------------------------------------------------------
```

Useful for spotting unexpected call paths (e.g., a function you didn't expect being called from a hot path).

### `web` / `svg` — graphical call graph

`web` opens a call graph in the browser. `svg` saves it to a file. Both require graphviz installed (`brew install graphviz` or `apt install graphviz`).

Visual encoding:

- **Thicker edges** = more time flows through that call
- **Larger nodes** = more time spent in that function
- **Red/dark nodes** = hot spots (high flat time)
- **Edge labels** = time flowing through that call path

Use when the text commands don't reveal the full picture — the visual layout often reveals call patterns that are hard to see in text.

### `disasm funcName` — assembly-level

Shows generated assembly with per-instruction cost. Use for micro-optimization: verifying SIMD instructions, bounds check elimination, or inlining at the instruction level:

```
(pprof) disasm Parse
Total: 5s
ROUTINE ======================== myapp/pkg/parser.Parse
     0.40s      1.90s (flat, cum) 38.00% of Total
     0.10s      0.10s    4a3b20: MOVQ 0x8(SP), AX          ;parser.go:15
     0.20s      0.20s    4a3b28: CMPQ AX, $0x100           ;parser.go:16
         .      0.10s    4a3b2f: JGE 0x4a3b80              ;parser.go:16
     0.10s      1.50s    4a3b35: CALL runtime.makeslice(SB) ;parser.go:17
```

### `weblist funcName` — annotated source in browser

Like `list` but opens the annotated source in a browser with color-coded cost highlighting. Each line is shaded from white (no cost) to red (hot). More visually immediate than the text version:

```
(pprof) weblist serializeResponse
```

Requires a browser. Falls back to `list` if no browser is available.

### `tags` — profile label breakdown

Shows tag values present in the profile. Go runtime profiles carry tags like `thread_id`; custom profiles can add arbitrary labels via `pprof.Do()`:

```go
labels := pprof.Labels("request_type", "api", "endpoint", "/users")
pprof.Do(ctx, labels, func(ctx context.Context) {
    handleRequest(ctx)
})
```

```
(pprof) tags
request_type: api (85%), batch (15%)
endpoint: /users (40%), /orders (35%), /products (25%)
```

### `tagroot` and `tagleaf` — group by labels

Group the profile data by tag values, creating a virtual call tree rooted on tag names:

```
(pprof) tagroot request_type    # group everything by request_type first
(pprof) top                     # now shows breakdown per request_type
(pprof) tagleaf endpoint        # add endpoint as leaf grouping
```

Useful for multi-tenant profiling or breaking down by request type without code changes.

### `granularity` — control grouping level

Changes how samples are aggregated:

```
(pprof) granularity=functions    # default — group by function name
(pprof) granularity=filefunctions # group by file:function
(pprof) granularity=files        # group by file only
(pprof) granularity=lines        # group by exact source line
(pprof) granularity=addresses    # group by instruction address (most granular)
```

`lines` is especially useful when a single function has multiple hot spots — it reveals which specific lines are expensive without needing `list`.

### `sort` — change sort order

```
(pprof) sort=flat     # sort by flat time (default for top)
(pprof) sort=cum      # sort by cumulative time (same as top -cum)
```

### `source` — show source for matching regex

Similar to `list` but searches all functions matching a pattern and shows their annotated source:

```
(pprof) source handler   # show annotated source for all functions matching "handler"
```

### `focus`, `ignore`, `hide`, `show` — filtering

Narrow the analysis to specific functions or exclude noise. These are stateful — they persist across commands until explicitly cleared:

```
(pprof) focus=myapp            # only show call paths that pass through "myapp"
(pprof) ignore=runtime         # remove runtime functions from display
(pprof) hide=testing           # hide testing framework noise from graphs
(pprof) show=handler           # only show functions matching "handler"
(pprof) tagfocus=endpoint=/users  # only show samples with this tag value
(pprof) tagignore=request_type=batch  # exclude samples with this tag value
```

**Difference between `focus`, `show`, `hide`, and `ignore`:**

- `focus` — keeps only paths that contain a matching function; everything else is dropped
- `ignore` — removes matching functions from the graph entirely; their costs are attributed to callers
- `show` — like `focus` but only affects display, not cost accounting
- `hide` — like `ignore` but only hides from display, not cost accounting

**Clear all filters:**

```
(pprof) reset
```

### `normalize` — normalize against a base profile

When comparing two profiles with `-base`, values are deltas by default. `normalize` scales the base profile to match the total of the main profile, making ratios comparable even if run durations differ:

```
(pprof) normalize
```

### `sample_index` — switch metric in multi-metric profiles

Heap profiles contain multiple metrics (alloc_objects, alloc_space, inuse_objects, inuse_space). Switch between them without reloading:

```
(pprof) sample_index=alloc_objects
(pprof) top                       # now shows allocation counts
(pprof) sample_index=inuse_space
(pprof) top                       # now shows live memory
```

### `unit` — change display units

```
(pprof) unit=ms         # display time in milliseconds
(pprof) unit=seconds    # display in seconds
(pprof) unit=MB         # display memory in megabytes
(pprof) unit=auto       # automatic (default)
```

### `callgrind` — export for KCachegrind

Exports the profile in callgrind format, which can be opened in KCachegrind or QCachegrind for advanced visualization:

```
(pprof) callgrind
Generating report in callgrind format
```

### `proto` — save processed profile

Save the current profile (after filtering) in protobuf format for sharing or later analysis:

```
(pprof) proto > filtered.pb.gz
```

### `help` — list all commands

```
(pprof) help             # full command list with descriptions
(pprof) help top         # detailed help for a specific command
```

### `show_from=regex` — trim callers above match

Hides all frames above the first matching function. Useful when you're only interested in a specific subsystem and want to remove framework/routing noise above it:

```
(pprof) show_from=handler.Handle   # start the graph from Handle, hide all callers above
```

### `noinlines` — flatten inlined functions

Attributes inlined functions to their first out-of-line caller. Useful when inlined functions create confusing call chains in the graph:

```
(pprof) noinlines
```

### Full command reference

Every command below works both as a standalone shell command and inside the interactive `(pprof)` prompt. The interactive form omits `go tool pprof` and the profile path — e.g., `go tool pprof -top cpu.prof` becomes just `top` inside the prompt.

**Reporting commands:**

```bash
# Top functions by self (flat) cost — the first command to run
go tool pprof -top cpu.prof

# Top 20 functions by cumulative cost (self + callees)
go tool pprof -cum -top -nodecount=20 cpu.prof

# Annotated source for a specific function — pinpoints the exact expensive line
go tool pprof -list=json.Marshal cpu.prof

# Callers and callees of a function — trace the responsibility chain
go tool pprof -peek=serializeResponse cpu.prof

# Hierarchical call tree with costs at each level
go tool pprof -tree cpu.prof

# Raw sample stack traces — spot unexpected call paths
go tool pprof -traces cpu.prof

# Per-instruction assembly cost — verify SIMD, bounds checks, inlining
go tool pprof -disasm=Parse cpu.prof

# Annotated source for all functions matching a regex
go tool pprof -source='handler\..*' cpu.prof

# Text output (flat table, alternative to -top)
go tool pprof -text cpu.prof
```

**Graph/export commands:**

```bash
# SVG call graph (viewable in any browser, no graphviz server needed)
go tool pprof -svg cpu.prof > cpu.svg

# SVG of only the subgraph matching a regex
go tool pprof -svg -focus=handler cpu.prof > handler.svg

# PDF call graph
go tool pprof -pdf cpu.prof > cpu.pdf

# PNG call graph
go tool pprof -png cpu.prof > cpu.png

# GIF call graph
go tool pprof -gif cpu.prof > cpu.gif

# DOT format (for custom graphviz processing: dot -Tsvg cpu.dot > cpu.svg)
go tool pprof -dot cpu.prof > cpu.dot

# Callgrind format (open with KCachegrind / QCachegrind)
go tool pprof -callgrind cpu.prof > cpu.callgrind

# Save current profile (with filters applied) in protobuf format
go tool pprof -proto -focus=handler cpu.prof > handler-only.pb.gz

# Annotated source in browser with color-coded cost per line
go tool pprof -weblist=serializeResponse cpu.prof
```

**Filtering flags** — narrow analysis to relevant functions:

```bash
# Focus: keep only call paths passing through matching functions
go tool pprof -focus=myapp/pkg/handler -top cpu.prof

# Ignore: remove matching functions — their cost is attributed to callers
go tool pprof -ignore=runtime -top cpu.prof

# Show: display only matching functions (display-only, does not change cost accounting)
go tool pprof -show=handler -top cpu.prof

# Hide: hide matching functions from display (does not change cost accounting)
go tool pprof -hide=testing -svg cpu.prof > clean.svg

# Show_from: trim all frames above the first match — hides framework/routing callers
go tool pprof -show_from=handler.Handle -top cpu.prof

# Noinlines: attribute inlined functions to their first out-of-line caller
go tool pprof -noinlines -top cpu.prof

# Combine multiple filters
go tool pprof -cum -top -nodecount=10 -focus=handler -ignore=runtime cpu.prof
```

**Tag-based filtering** — for profiles with labels (via `pprof.Do()`):

```bash
# Show all tag keys and their value distributions
go tool pprof -tags cpu.prof

# Keep only samples tagged with a specific key=value
go tool pprof -tagfocus=endpoint=/users -top cpu.prof

# Exclude samples with a specific tag
go tool pprof -tagignore=request_type=batch -top cpu.prof

# Group by tag — insert pseudo frames at root, breaking down by tag value
go tool pprof -tagroot=request_type -top cpu.prof

# Group by tag as leaf — breaks down each function by tag value
go tool pprof -tagleaf=endpoint -top cpu.prof

# Show/hide tags as annotations in graph output
go tool pprof -tagshow=endpoint -svg cpu.prof > tagged.svg
go tool pprof -taghide=thread_id -svg cpu.prof > clean.svg
```

**Granularity and display control:**

```bash
# Group by source line instead of function — reveals hot lines in multi-hot-spot functions
go tool pprof -granularity=lines -top cpu.prof

# Group by file:function
go tool pprof -granularity=filefunctions -top cpu.prof

# Group by file only
go tool pprof -granularity=files -top cpu.prof

# Group by instruction address (most granular)
go tool pprof -granularity=addresses -top cpu.prof

# Change display units
go tool pprof -unit=ms -top cpu.prof

# Edge/node fraction cutoffs — hide small contributions from graphs
go tool pprof -edgefraction=0.01 -nodefraction=0.005 -svg cpu.prof > clean.svg

# Disable trimming — show the full graph including tiny nodes
go tool pprof -trim=false -svg cpu.prof > full.svg
```

**Heap profile commands:**

```bash
# Top allocation sites by object count — diagnose GC churn
go tool pprof -top -alloc_objects mem.prof

# Top allocation sites by bytes — diagnose peak memory
go tool pprof -top -alloc_space mem.prof

# Currently live objects — diagnose memory leaks
go tool pprof -top -inuse_space mem.prof

# Currently live object count — diagnose leak of many small objects
go tool pprof -top -inuse_objects mem.prof

# Annotated source showing allocation sites by object count
go tool pprof -alloc_objects -list=Parse mem.prof

# SVG call graph colored by allocation objects
go tool pprof -alloc_objects -svg mem.prof > allocs.svg

# Compare two heap snapshots — show only growth (memory leak detection)
go tool pprof -top -base heap-baseline.prof heap-after.prof

# Diff with normalization — makes ratios comparable when capture durations differ
go tool pprof -normalize -top -base heap-baseline.prof heap-after.prof

# Diff as SVG — visualize what grew
go tool pprof -base heap-baseline.prof -svg heap-after.prof > leak.svg

# Diff with annotated source for a specific function
go tool pprof -base heap-baseline.prof -list=handleRequest heap-after.prof
```

**Fetching profiles from a running service:**

```bash
# CPU profile — fetch 30 seconds of samples and open interactive mode
go tool pprof http://localhost:6060/debug/pprof/profile?seconds=30

# CPU profile — fetch and immediately generate SVG (no interactive mode)
go tool pprof -svg http://localhost:6060/debug/pprof/profile?seconds=10 > cpu.svg

# CPU profile — fetch with a timeout
go tool pprof -timeout=60 "http://localhost:6060/debug/pprof/profile?seconds=30"

# Heap profile — fetch and show top allocation sites
go tool pprof -top -alloc_objects http://localhost:6060/debug/pprof/heap

# Goroutine profile — fetch and show top goroutine stacks
go tool pprof -top http://localhost:6060/debug/pprof/goroutine

# Mutex profile — fetch contention data
go tool pprof -top http://localhost:6060/debug/pprof/mutex

# Block profile — fetch blocking data
go tool pprof -top http://localhost:6060/debug/pprof/block

# Fetch and save to a file without analysis (using curl)
curl -o heap.prof http://localhost:6060/debug/pprof/heap

# Human-readable goroutine dump (no go tool pprof needed)
curl http://localhost:6060/debug/pprof/goroutine?debug=1

# Goroutine dump with full stack traces, creation site, and labels
curl http://localhost:6060/debug/pprof/goroutine?debug=2

# Human-readable heap stats
curl http://localhost:6060/debug/pprof/heap?debug=1

# Fetch over TLS with client certificate
go tool pprof -tls_cert=client.crt -tls_key=client.key -tls_ca=ca.crt https://myservice:6060/debug/pprof/profile?seconds=30

# Fetch over TLS skipping server certificate verification
go tool pprof https+insecure://myservice:6060/debug/pprof/profile?seconds=30
```

**Comparison commands (diff two profiles):**

```bash
# Diff: subtract base from source — all values become deltas
go tool pprof -base cpu-before.prof cpu-after.prof

# Diff base: percentages shown relative to base profile
go tool pprof -diff_base=cpu-before.prof cpu-after.prof

# Diff with normalization — scale base to match source total
go tool pprof -normalize -base heap-before.prof heap-after.prof

# Diff as top report
go tool pprof -top -base cpu-before.prof cpu-after.prof

# Diff as SVG graph
go tool pprof -svg -base cpu-before.prof cpu-after.prof > diff.svg
```

**Web UI:**

```bash
# Open interactive web UI with flamegraph, graph, source, and disassembly views
go tool pprof -http=:8080 cpu.prof

# Open on a different port
go tool pprof -http=:9090 mem.prof

# Open with a specific sample type pre-selected
go tool pprof -http=:8080 -alloc_objects mem.prof

# Open with filters pre-applied
go tool pprof -http=:8080 -focus=handler cpu.prof

# Open a diff view in the web UI
go tool pprof -http=:8080 -base heap-baseline.prof heap-after.prof

# Open with no browser auto-launch (just start the server)
go tool pprof -http=:8080 -no_browser cpu.prof
```

**Symbolization flags:**

```bash
# Disable symbolization (show raw addresses)
go tool pprof -symbolize=none cpu.prof

# Only use local binaries for symbolization (don't contact remote)
go tool pprof -symbolize=local cpu.prof

# Contact running service for symbol information
go tool pprof -symbolize=remote http://localhost:6060/debug/pprof/profile?seconds=10

# Show mangled C++ names (relevant for cgo profiles)
go tool pprof -symbolize=demangle=none cpu.prof

# Full demangling without simplification
go tool pprof -symbolize=demangle=full cpu.prof
```

**Environment variables:**

| Variable | Purpose |
| --- | --- |
| `PPROF_BINARY_PATH` | Search path for local binaries used in symbolization (default: `$HOME/pprof/binaries`). Set when profiling remote servers where binaries aren't in the default path. |
| `PPROF_TOOLS` | Directory containing binutils tools (`addr2line`, `nm`, `objdump`). Set when these tools aren't in `$PATH`. |

## Graphical / Web UI

When CLI output is insufficient and you need interactive exploration:

```bash
# Opens browser with interactive UI
go tool pprof -http=:8080 cpu.prof

# Specify a different port if 8080 is taken
go tool pprof -http=:9090 mem.prof

# Open with specific sample type pre-selected
go tool pprof -http=:8080 -alloc_objects mem.prof

# Open with filters pre-applied
go tool pprof -http=:8080 -focus=handler cpu.prof

# Compare two profiles — open with -base
go tool pprof -http=:8080 -base heap-baseline.prof heap-after.prof
```

The web UI provides:

- **Flamegraph** (most intuitive) — horizontal width proportional to cost; click to zoom into subtrees; inverted flamegraph available (icicle graph)
- **Graph** — directed call graph with edge weights; nodes and edges sized/colored by cost; interactive zoom and click-to-focus
- **Top** — same as `top` command but sortable columns, clickable to navigate to source
- **Source** — annotated source with per-line cost; browsable across all functions
- **Disassembly** — same as `disasm` but browsable across functions
- **Peek** — interactive peek view with expandable callers/callees

Default to CLI commands for quick diagnosis — use the web UI when exploring unfamiliar call graphs, comparing profiles visually, or presenting findings to others.

## Comparing Profiles

### Memory leak detection with `-base`

Compare two heap profiles to isolate what grew between them:

```bash
# Step 1: take a baseline snapshot
curl http://localhost:6060/debug/pprof/heap > heap-baseline.prof

# Step 2: wait for the suspected leak to accumulate (minutes to hours)

# Step 3: take a second snapshot
curl http://localhost:6060/debug/pprof/heap > heap-after.prof

# Step 4: diff — shows only what grew between the two snapshots
go tool pprof -base heap-baseline.prof heap-after.prof
# Then use top, list, peek as usual — all values are deltas
```

### Comparing CPU profiles across code versions

```bash
# Before your change
go test -bench=BenchmarkParse -cpuprofile=cpu-before.prof ./pkg/parser

# After your change
go test -bench=BenchmarkParse -cpuprofile=cpu-after.prof ./pkg/parser

# Compare visually — load both in separate browser tabs
go tool pprof -http=:8080 cpu-before.prof
go tool pprof -http=:8081 cpu-after.prof
```

For statistical comparison of benchmark numbers (not profiles), use [benchstat](./benchstat.md) instead.

## Common Patterns

Learn to recognize these recurring shapes — they tell you what class of problem you're dealing with before you start fixing.

### Flat high + cum high

The function itself is the bottleneck. It does expensive work directly (tight loop, heavy computation, complex string processing). Optimize the function's own code — algorithm, data structure, or implementation.

### Flat low + cum high

The function calls slow things but does little work itself. It's a coordinator or dispatcher. Drill into callees with `list` or `peek`. The fix is usually in the called functions, or reducing how often they're called.

### `alloc_objects` high, `inuse_space` low

Short-lived allocations creating GC churn. Objects are allocated and freed rapidly — each one is cheap individually but the aggregate volume triggers frequent GC cycles. Common sources: `fmt.Errorf` in hot paths (allocates every call), interface boxing (`any` arguments), string-to-byte conversions, slice growth without preallocation. → See `samber/cc-skills-golang@golang-performance` skill for allocation reduction patterns.

### `inuse_space` growing over time

Memory leak. Take two heap snapshots minutes apart and compare with `-base` (see Comparing Profiles above). Growing types reveal the leak source. Common causes: unbounded caches, maps that never shrink (Go maps don't release bucket memory on delete), goroutine leaks holding references.

### Mutex/block profile hot

Contention, not CPU. The CPU is waiting, not working. The goroutines are all trying to acquire the same lock or read from the same channel. Reduce critical section scope, shard locks across multiple mutexes, or use lock-free structures (`sync/atomic`, `sync.Map` for read-heavy workloads). → See `samber/cc-skills-golang@golang-concurrency` skill.

### Many goroutines blocked on same channel/mutex

Serialization bottleneck. All work funnels through a single point. The throughput ceiling is the speed of that single point. Consider worker pools with multiple independent queues, sharding the work, or buffered channels to smooth bursts.

### `runtime.mallocgc` dominates CPU profile

Allocation rate is the bottleneck, not computation. The Go runtime is spending more time allocating and collecting garbage than running your code. Switch to the `alloc_objects` heap profile to find which functions allocate the most, then → See `samber/cc-skills-golang@golang-performance` skill for reduction patterns.

### `runtime.memmove` high in CPU profile

Large memory copies — usually from slice `append` growing beyond capacity, `copy()` of large slices, or string-to-byte conversions. Pre-allocate slices to final capacity, reuse buffers, or work with `[]byte` directly.

### `runtime.scanobject` high in CPU profile

GC pointer scanning. The heap contains many pointers that the GC must trace. Reduce pointer density: use value types instead of pointers in slices/maps, flatten nested structures, consider `[N]byte` arrays instead of `string` in hot structs.

## Which Profile for Which Symptom?

| Symptom | Profile | Flag/Command |
| --- | --- | --- |
| High CPU, slow function | CPU | `-cpuprofile` or `pprof/profile` |
| Too many allocations (GC pressure) | Heap (alloc_objects) | `-memprofile` then `pprof -alloc_objects` |
| Large allocations (memory usage) | Heap (alloc_space) | `pprof -alloc_space` |
| Memory growing over time (leak) | Heap (inuse_space) | `pprof -inuse_space`, compare with `-base` |
| Lock contention | Mutex | `pprof/mutex` (enable `SetMutexProfileFraction` first) |
| Goroutines blocked on sync | Block | `pprof/block` (enable `SetBlockProfileRate` first) |
| Too many goroutines / leak | Goroutine | `pprof/goroutine` |
| High latency but low CPU | Goroutine + Block + Trace | Scheduling delays, I/O waits — see [Trace Reference](./trace.md) |
| Excessive thread creation | Threadcreate | `pprof/threadcreate` |
