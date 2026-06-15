# Execution Trace Reference

`go tool trace` shows what pprof cannot: **scheduling delays**, GC stop-the-world phases, goroutine state transitions, and why goroutines are **not** running. pprof samples what's on-CPU; trace records every state transition at nanosecond precision.

Use the execution tracer when:

- pprof shows low CPU% but latency is high (goroutines waiting, not working)
- You suspect GC pauses are causing tail latency spikes
- You need to understand goroutine scheduling and contention
- You want to see the wall-clock timeline of concurrent operations

## Generating Traces

### From benchmarks

```bash
go test -bench=BenchmarkParse -trace=trace.out ./pkg/parser
go tool trace trace.out
```

### From running service

Requires `import _ "net/http/pprof"`:

```bash
# Capture 5 seconds of trace data (adjust duration as needed)
curl -o trace.out http://localhost:6060/debug/pprof/trace?seconds=5
go tool trace trace.out
```

**Warning:** traces generate data at MB/s. Keep captures short — 5-10 seconds is typical. Longer traces are unwieldy, slow to parse, and may consume significant memory when opened.

### From tests

```bash
go test -trace=trace.out ./pkg/parser
go tool trace trace.out
```

### From code (programmatic)

```go
import "runtime/trace"

f, _ := os.Create("trace.out")
trace.Start(f)
defer trace.Stop()
```

Or capture a region of interest:

```go
import "runtime/trace"

// Start tracing only when needed
f, _ := os.Create("trace.out")
trace.Start(f)

doExpensiveWork()

trace.Stop()
f.Close()
```

## Full Command Reference

### Opening traces

```bash
# Open trace in web browser (default — starts HTTP server, opens browser)
go tool trace trace.out

# Open on a specific port
go tool trace -http=:8080 trace.out

# Open on a specific host:port (e.g., for remote access)
go tool trace -http=0.0.0.0:8080 trace.out
```

### Extracting pprof profiles from traces

`go tool trace` can convert trace data into pprof-compatible profiles. This bridges the two tools — you capture with the tracer (nanosecond events) and analyze with pprof (statistical aggregation with `top`, `list`, `peek`):

```bash
# Network blocking profile — where goroutines wait on network I/O
go tool trace -pprof=net trace.out > net.prof
go tool pprof -top net.prof

# Synchronization blocking profile — mutexes, channels, wait groups
go tool trace -pprof=sync trace.out > sync.prof
go tool pprof -top sync.prof

# Syscall blocking profile — system calls that block goroutines
go tool trace -pprof=syscall trace.out > syscall.prof
go tool pprof -top syscall.prof

# Scheduler latency profile — time between becoming runnable and actually running
go tool trace -pprof=sched trace.out > sched.prof
go tool pprof -top sched.prof
```

You can chain with any pprof command — e.g., annotated source for a blocking function:

```bash
go tool trace -pprof=sync trace.out > sync.prof
go tool pprof -list=handleRequest sync.prof
go tool pprof -svg sync.prof > sync-blocking.svg
```

### Full capture-to-analysis workflows

```bash
# Workflow 1: benchmark trace — capture, view, extract blocking profile
go test -bench=BenchmarkParse -trace=trace.out ./pkg/parser
go tool trace trace.out                                         # visual timeline
go tool trace -pprof=sync trace.out > sync.prof                 # extract sync blocking
go tool pprof -top -cum sync.prof                               # find worst sync blockers
go tool pprof -list=processOrder sync.prof                      # annotated source

# Workflow 2: production trace — capture from running service, analyze scheduling
curl -o trace.out http://localhost:6060/debug/pprof/trace?seconds=5
go tool trace trace.out                                         # visual timeline
go tool trace -pprof=sched trace.out > sched.prof               # extract scheduling latency
go tool pprof -top sched.prof                                   # goroutines with worst scheduling delay
go tool pprof -svg sched.prof > sched.svg                       # graph of scheduling bottlenecks

# Workflow 3: test trace — capture during test run
go test -trace=trace.out -run=TestSlowIntegration ./pkg/api
go tool trace trace.out                                         # visual timeline
go tool trace -pprof=net trace.out > net.prof                   # extract network blocking
go tool pprof -top net.prof                                     # find network wait sites
```

### `go tool trace` flags summary

| Flag | Example | Purpose |
| --- | --- | --- |
| (none) | `go tool trace trace.out` | Open trace in web browser (default) |
| `-http=:PORT` | `go tool trace -http=:9090 trace.out` | Set HTTP server address for the web UI |
| `-pprof=TYPE` | `go tool trace -pprof=net trace.out > net.prof` | Extract pprof profile from trace. Types: `net`, `sync`, `syscall`, `sched` |

### HTTP endpoints served by the web UI

When `go tool trace trace.out` starts its HTTP server, it exposes these pages:

| Endpoint | What it shows |
| --- | --- |
| `/` | Index page with links to all views |
| `/trace` | Interactive timeline viewer (Chrome trace viewer) — the main visualization |
| `/goroutines` | Goroutine analysis — summary table of all goroutine types, counts, and execution stats |
| `/goroutine/<id>` | Detailed view of a specific goroutine — its full lifecycle timeline |

From `/goroutines`, click on a goroutine type to see all instances and their execution statistics (total time, scheduled time, blocked time). Click an individual goroutine to see its timeline.

## Web UI

### Main views

The web UI (opened by `go tool trace trace.out`) shows a timeline where each horizontal lane represents a processor (P), goroutine, or system event:

- **Trace viewer** (`/trace`) — interactive timeline with:
  - **P lanes** — one per logical processor (GOMAXPROCS), showing which goroutine runs on each P at each moment
  - **Goroutine lanes** — each goroutine's lifecycle: created → runnable → running → waiting → running → …
  - **GC events** — mark phases, sweep, STW pauses shown as colored bands across all P lanes
  - **System events** — syscalls, network I/O, timer events
  - **User annotations** — tasks, regions, and log messages from `runtime/trace` API

- **Goroutine analysis** (`/goroutines`) — summary table:
  - Groups goroutines by creation stack trace (type)
  - Shows count, total execution time, total scheduling wait, total blocking time
  - Click a type to see individual goroutine statistics
  - Click an individual goroutine to see its timeline

### Navigating the trace viewer

The trace viewer uses the Chrome tracing UI (also used by Chrome DevTools):

| Key/Action | Effect |
| --- | --- |
| `W` / scroll up | Zoom in (time axis) |
| `S` / scroll down | Zoom out (time axis) |
| `A` | Pan left |
| `D` | Pan right |
| Click on event | Show details panel at bottom — goroutine ID, duration, stack trace |
| `Shift+click` | Select a time range — highlights all events in that window |
| `M` | Mark current selection |
| `/` | Search for events by name |
| `?` | Show keyboard shortcuts |

### Reading the timeline

**Color coding:**

- **Green bars** on P lanes = goroutine actively executing
- **Blue bars** = syscall (goroutine pinned to OS thread)
- **Orange/yellow marks** = scheduling events (goroutine becoming runnable)
- **Red bands** across all P lanes = GC stop-the-world pause
- **Light blue bands** = GC concurrent mark phase
- **Purple** = user-defined regions (from `trace.WithRegion`)

**Gaps in P lanes** = the processor was idle (no runnable goroutines, or goroutines blocked). Many idle gaps with pending runnable goroutines suggests scheduling contention.

## What to Look For

### Goroutine states

The trace timeline color-codes goroutine states:

| Color | State | Meaning | What it indicates |
| --- | --- | --- | --- |
| **Green** | Running | Actively executing on a P | Normal — doing useful work |
| **Yellow/Orange** | Runnable | Ready to run but waiting for a P | CPU-saturated — too many runnable goroutines competing for too few processors |
| **Red/Pink** | Waiting | Blocked on I/O, channel, mutex, sleep, select | I/O-bound or contention — investigate what it's waiting on |
| **Blue** | GC assist | Drafted by GC to help mark/sweep | GC pressure — too many allocations forcing goroutines to help the collector |

### GC phases

GC events appear as colored bands across all P lanes:

- **Mark assist** — goroutines drafted to help GC scan the heap. Visible as gaps in application goroutine execution. The runtime forces goroutines to assist with GC work in proportion to their allocation rate — heavy allocators get taxed more.
- **STW (stop-the-world)** — brief phases where all goroutines are stopped (mark setup, mark termination). These cause latency spikes visible as vertical bands across all lanes.
- **Sweep** — concurrent sweep of unreachable objects. Usually low overhead but can accumulate if the heap is large.

**Diagnosing GC issues from traces:**

- Frequent GC cycles with long mark assist = too many allocations (reduce allocation rate)
- Long STW phases = too many pointers for the GC to scan (reduce pointer density)
- GC cycles clustering after specific operations = those operations allocate heavily

### Scheduling latency

Time between a goroutine becoming **runnable** and actually **running**. High scheduling latency means:

- Too many goroutines competing for GOMAXPROCS processors
- OS scheduling interference (noisy neighbors, CPU throttling)
- Goroutines pinned to busy threads by cgo or long syscalls

**What to look for:**

- Yellow (runnable) gaps before green (running) segments — the longer the yellow gap, the higher the scheduling latency
- Many goroutines in runnable state simultaneously — indicates CPU saturation
- Uneven distribution across Ps — one P overloaded while others are idle suggests work imbalance

### Network/sync blocking

- **Long red/pink periods** on a goroutine = it's blocked waiting. Click the block event to see what it's waiting on (channel receive, mutex lock, network read, etc.)
- **Many goroutines blocked on the same channel or mutex** = serialization bottleneck. All work funnels through one point.
- **Goroutines blocked on network I/O** = external dependency latency. The Go code can't do anything faster — the bottleneck is upstream. Use `-pprof=net` to generate a pprof profile of network wait locations.

### Goroutine creation and destruction

The trace shows goroutine lifecycle events. Look for:

- **Goroutines created in a loop without bound** = potential goroutine leak
- **Goroutines that are created but never finish** = leak — they accumulate over time
- **Very short-lived goroutines created repeatedly** = high overhead from goroutine creation/scheduling (consider batching or worker pools)

## Custom Annotations

Add application-level context to traces so you can correlate runtime events with business operations.

### Tasks

A task represents a logical operation that may span multiple goroutines:

```go
import "runtime/trace"

func processOrder(ctx context.Context, order Order) error {
    ctx, task := trace.NewTask(ctx, "processOrder")
    defer task.End()

    // All trace events in this context are grouped under the task
    validate(ctx, order)
    charge(ctx, order)
    fulfill(ctx, order)
    return nil
}
```

Tasks appear as named groups in the trace timeline. You can filter the trace view to show only events belonging to a specific task.

### Regions

A region represents a phase within a task or goroutine:

```go
func validate(ctx context.Context, order Order) {
    trace.WithRegion(ctx, "validateAddress", func() {
        // this block is annotated as a region
        validateAddress(order.Address)
    })

    trace.WithRegion(ctx, "validatePayment", func() {
        validatePayment(order.Payment)
    })
}
```

Regions appear as labeled spans on the goroutine's timeline, making it easy to see which phase of processing takes the most wall-clock time.

### Log messages

Add point-in-time log messages to the trace:

```go
trace.Log(ctx, "orderID", order.ID)
trace.Log(ctx, "status", "payment_verified")
```

Logs appear as markers on the timeline — useful for correlating trace events with specific data.

### When to use annotations

- **Always** in server request handlers — wrap each request in a task
- **Performance-critical paths** — add regions to phases you want to measure wall-clock time for
- **Debugging intermittent latency** — add logs at key decision points to see what happened in the slow trace

Annotations add negligible overhead when tracing is disabled (they check a flag and return immediately).

## Flight Recorder (Go 1.25+)

The flight recorder solves a fundamental problem with execution traces in long-running services: when a problem occurs (timeout, failed health check), it's already too late to call `trace.Start()`. The flight recorder keeps a circular buffer of recent trace data in memory, and you snapshot it to disk when something goes wrong — like an airplane's black box.

### Setup

```go
import "runtime/trace"

fr := trace.NewFlightRecorder(trace.FlightRecorderConfig{
    MinAge:   10 * time.Second, // keep at least 10s of data
    MaxBytes: 5 << 20,          // cap at 5 MiB to limit memory usage
})
if err := fr.Start(); err != nil {
    return err
}
```

**Sizing guidance:**

- **MinAge** — set to ~2x your problem window. For 5-second timeout debugging, use 10 seconds. The runtime may retain more data than MinAge if MaxBytes allows.
- **MaxBytes** — busy services generate ~1-10 MB/s of trace data. Start with 1-5 MiB and adjust. MaxBytes takes precedence over MinAge — when the buffer fills, older data is discarded regardless of age.

### Snapshot on error

Capture the trace buffer when something unexpected happens. Use `sync.Once` to prevent multiple snapshots overwriting each other:

```go
var snapshotOnce sync.Once

func captureSnapshot(fr *trace.FlightRecorder) {
    snapshotOnce.Do(func() {
        f, err := os.Create("snapshot.trace")
        if err != nil {
            log.Printf("snapshot file: %v", err)
            return
        }
        defer f.Close()

        if _, err := fr.WriteTo(f); err != nil {
            log.Printf("snapshot write: %v", err)
            return
        }
        fr.Stop()
        log.Printf("captured snapshot to %s", f.Name())
    })
}
```

### Trigger patterns

```go
// Pattern 1: slow request detection
http.HandleFunc("/api/order", func(w http.ResponseWriter, r *http.Request) {
    start := time.Now()
    // ... handler logic ...

    if fr.Enabled() && time.Since(start) > 100*time.Millisecond {
        go captureSnapshot(fr)
    }
})

// Pattern 2: health check failure
if !healthCheck() && fr.Enabled() {
    go captureSnapshot(fr)
}

// Pattern 3: HTTP endpoint for on-demand capture
http.HandleFunc("/debug/flightrecorder", func(w http.ResponseWriter, r *http.Request) {
    if !fr.Enabled() {
        http.Error(w, "flight recorder not active", http.StatusServiceUnavailable)
        return
    }
    w.Header().Set("Content-Type", "application/octet-stream")
    w.Header().Set("Content-Disposition", "attachment; filename=trace.out")
    fr.WriteTo(w)
})
```

### Analyzing a snapshot

```bash
go tool trace snapshot.trace
```

The snapshot contains the same data as a regular trace — use all the same analysis techniques (timeline viewer, goroutine analysis, pprof extraction). The flight recorder's flow events are particularly useful for diagnosing lock contention and goroutine stalls that caused the anomaly.

### Constraints

- **At most one flight recorder** may be active at a time (this restriction may be relaxed in future Go versions)
- A flight recorder **can run concurrently** with `trace.Start` — both can be active simultaneously
- Only one goroutine may call `WriteTo` at a time — the `sync.Once` pattern handles this naturally
- `Stop()` blocks until any concurrent `WriteTo` completes

### When to use flight recorder vs regular tracing

| Scenario | Tool | Why |
| --- | --- | --- |
| Investigating a known slow operation | `go test -trace` or `trace.Start`/`Stop` | You know when to start and stop |
| Intermittent latency spikes in production | Flight recorder | You don't know when the spike will happen — the buffer captures it retroactively |
| Post-mortem after a timeout or crash | Flight recorder | The problem already happened; regular tracing would miss it |
| Continuous performance monitoring | `samber/cc-skills-golang@golang-observability` (Pyroscope) | Flight recorder is for one-shot diagnosis, not continuous collection |

## Overhead and Practical Limits

| Concern | Guidance |
| --- | --- |
| **Runtime overhead** | ~1-2% CPU during capture; negligible when not capturing |
| **Data volume** | Traces generate MB/s of data. A 10-second trace of a busy service can be 50-100MB |
| **Capture duration** | 5-10 seconds is typical. Longer traces are slow to open and hard to navigate |
| **Memory to view** | `go tool trace` loads the entire trace into memory. Large traces may need 1GB+ RAM |
| **Browser performance** | The web UI can struggle with traces >100MB. Use short captures. |
| **Production use** | Safe for short captures on a single instance. Do not capture continuously. |

## Trace vs pprof: When to Use Which

| Question | Tool | Why |
| --- | --- | --- |
| Where does CPU time go? | pprof CPU profile | Statistical sampling, low overhead, good for aggregate view |
| Why is latency high but CPU low? | go tool trace | Shows goroutine waiting states — I/O, channels, mutexes |
| Where do allocations happen? | pprof heap profile | Per-function allocation counts and sizes |
| Why are GC pauses long? | go tool trace | Shows STW phases, mark assist, GC timeline |
| Is there lock contention? | pprof mutex/block + trace | pprof quantifies it; trace shows the timeline |
| Are goroutines leaking? | pprof goroutine + trace | pprof shows the stack; trace shows creation/lifecycle |
| Which goroutines compete for CPU? | go tool trace | Shows runnable vs running states across all Ps |
| What's the wall-clock breakdown of a request? | go tool trace (with annotations) | Timeline view with tasks and regions |

When in doubt, start with pprof (lower overhead, simpler output). Use trace when pprof doesn't explain the latency or when you need the wall-clock timeline view.
