# Profiling and Continuous Profiling

→ See `samber/cc-skills-golang@golang-troubleshooting` skill (pprof.md) for on-demand debugging.

## What Profiling Is

Profiling analyzes the runtime behavior of your program — where CPU time is spent, how memory is allocated, which goroutines are blocked, and where lock contention occurs. While metrics tell you "the service is slow," profiling tells you "this specific function on line 42 is the bottleneck."

## On-Demand Profiling with `pprof`

pprof endpoints MUST be protected with basic auth — NEVER expose them publicly. They leak sensitive runtime information and can be abused for DoS.

→ See `samber/cc-skills-golang@golang-troubleshooting` pprof.md for the full pprof CLI reference (profile types, capturing, analyzing, commands).

## Continuous Profiling with Pyroscope

On-demand profiling requires you to be there when the problem happens. Continuous profiling runs always-on in the background with low overhead (~2-5% CPU), so you can look at profiles after the fact. Toggle it with an environment variable.

```go
import "github.com/grafana/pyroscope-go"

func setupContinuousProfiling() {
    if os.Getenv("PROFILING_ENABLED") != "true" {
        return
    }

    _, err := pyroscope.Start(pyroscope.Config{
        ApplicationName: "my-service",
        ServerAddress:   os.Getenv("PYROSCOPE_URL"), // e.g., http://user:pass@pyroscope:4040
        ProfileTypes: []pyroscope.ProfileType{
            pyroscope.ProfileCPU,
            pyroscope.ProfileAllocObjects,
            pyroscope.ProfileAllocSpace,
            pyroscope.ProfileInuseObjects,
            pyroscope.ProfileInuseSpace,
            pyroscope.ProfileGoroutines,
            pyroscope.ProfileMutexCount,
            pyroscope.ProfileMutexDuration,
            pyroscope.ProfileBlockCount,
            pyroscope.ProfileBlockDuration,
        },
    })
    if err != nil {
        slog.Error("failed to start pyroscope", "error", err)
    } else {
        slog.Info("continuous profiling enabled", "server", os.Getenv("PYROSCOPE_URL"))
    }
}
```

## Cost of Continuous Profiling

Continuous profiling adds overhead to every running instance — CPU for collecting stack samples, memory for buffering, and network for transmitting profiles to the backend. While typically low (~2-5% CPU), this cost is **per-instance and always-on**.

**Cost factors:**

- **CPU overhead** — profiling itself consumes CPU cycles. In CPU-bound services, even 2-5% overhead matters.
- **Network/storage** — profile data is continuously shipped to Pyroscope/your backend. High-replica services multiply this.
- **All profile types enabled** — each additional profile type (mutex, block, goroutine) adds incremental overhead.

**Mitigation:**

- Toggle via environment variable (`PROFILING_ENABLED`) — enable only when needed or on a subset of instances
- Start with CPU + heap profiles only; add mutex/block/goroutine profiles when investigating specific issues
- In large deployments, enable continuous profiling on a fraction of replicas (e.g., 1 in 10) rather than all of them

## When to Profile

1. Metrics show high CPU/memory usage → look at CPU/heap profiles
2. P99 latency spikes → CPU profile + mutex profile to find contention
3. Goroutine count growing → goroutine profile to find leaks
4. Before and after an optimization → compare profiles to verify improvement
