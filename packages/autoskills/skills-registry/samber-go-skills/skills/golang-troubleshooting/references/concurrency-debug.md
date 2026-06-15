# Concurrency Debugging

## Goroutine Leaks

**Symptoms:** Memory slowly increasing, goroutine count growing, no obvious CPU spike.

**Diagnosis:**

Use pprof goroutine profile (see [pprof.md](./pprof.md)) with `?debug=2` for human-readable output, then look for goroutines stuck in `chan receive`.

For Go 1.26 diagnostics, there is also an experimental goroutine leak profile. It is useful for production-oriented leak investigation, but is gated by `GOEXPERIMENT=goroutineleakprofile`; do not rely on it as default stable behavior.

```bash
curl http://localhost:6060/debug/pprof/goroutineleak?debug=2
go tool pprof http://localhost:6060/debug/pprof/goroutineleak
```

Keep existing tools: `go.uber.org/goleak` in tests, `runtime.NumGoroutine()` for coarse monitoring, `/debug/pprof/goroutine?debug=2` for stack dumps, and `go test -race ./...` for race checks.

```go
// Programmatic monitoring — log goroutine count to detect leaks
go func() {
    for {
        log.Printf("goroutines: %d", runtime.NumGoroutine())
        time.Sleep(3 * time.Second)
    }
}()

// In tests, use goleak to detect goroutine leaks
// import "go.uber.org/goleak"
// func TestMain(m *testing.M) { goleak.VerifyTestMain(m) }
```

**Common causes:**

```go
// 1. Unclosed channel — goroutine blocks forever
// BAD
for {
    job := <-jobs
    process(job)
}
// GOOD
for {
    select {
    case job, ok := <-jobs:
        if !ok { return }
        process(job)
    case <-ctx.Done():
        return
    }
}

// 2. Forgotten response body close — leaks HTTP connection
// Always defer resp.Body.Close() after HTTP calls.
// See production-debug.md for the correct pattern.

// 3. time.After in hot loop — allocates a new timer each iteration
// BAD
for {
    select {
    case <-time.After(time.Second):
        do()
    }
}
// GOOD — reuse a ticker for repeated intervals
ticker := time.NewTicker(time.Second)
defer ticker.Stop()
for {
    select {
    case <-ticker.C:
        do()
    case <-ctx.Done():
        return
    }
}
```

## Race Conditions

**Symptoms:** Intermittent failures, "sometimes works sometimes doesn't", different results on different machines.

**Diagnosis:** Race conditions MUST be tested with the `-race` flag:

```bash
go test -race ./...
go run -race main.go
# Race detector slows code ~10x but finds data races reliably
```

**Common patterns:**

- Shared map without mutex
- Shared variable without atomic
- Publishing reference before initialization
- go func() accessing outer variables without synchronization

## Deadlocks

**Symptoms:** Program hangs, goroutines stuck in "chan receive" or "mutex lock".

**Diagnosis:**

```bash
curl http://localhost:6060/debug/pprof/goroutine?debug=2

# Or programmatic
runtime.Stack(buf, true)
```

**Common patterns:**

1. **Circular wait** — A waits for B, B waits for A
2. **Forgotten channel send** — sender goroutine exited
3. **Wrong lock order** — always acquire locks in the same order
