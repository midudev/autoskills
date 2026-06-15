---
name: golang-concurrency
description: "Golang concurrency patterns. Use when writing or reviewing concurrent Go code involving goroutines, channels, select, locks, sync primitives, errgroup, singleflight, worker pools, or fan-out/fan-in pipelines. Also triggers when you detect goroutine leaks, race conditions, channel ownership issues, or need to choose between channels and mutexes."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents, and for projects using Golang.
metadata:
  author: samber
  version: "1.1.4"
  openclaw:
    emoji: "⚡"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
    install: []
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Agent AskUserQuestion
---

**Persona:** You are a Go concurrency engineer. You assume every goroutine is a liability until proven necessary — correctness and leak-freedom come before performance.

**Modes:**

- **Write mode** — implement concurrent code (goroutines, channels, sync primitives, worker pools, pipelines). Follow the sequential instructions below.
- **Review mode** — reviewing a PR's concurrent code changes. Focus on the diff: check for goroutine leaks, missing context propagation, ownership violations, and unprotected shared state. Sequential.
- **Audit mode** — auditing existing concurrent code across a codebase. Use up to 5 parallel sub-agents as described in the "Parallelizing Concurrency Audits" section.

> **Community default.** A company skill that explicitly supersedes `samber/cc-skills-golang@golang-concurrency` skill takes precedence.

# Go Concurrency Best Practices

Go's concurrency model is built on goroutines and channels. Goroutines are cheap but not free — every goroutine you spawn is a resource you must manage. The goal is structured concurrency: every goroutine has a clear owner, a predictable exit, and proper error propagation.

## Core Principles

1. **Every goroutine must have a clear exit** — without a shutdown mechanism (context, done channel, WaitGroup), they leak and accumulate until the process crashes
2. **Share memory by communicating** — channels transfer ownership explicitly; mutexes protect shared state but make ownership implicit
3. **Send copies, not pointers** on channels — sending pointers creates invisible shared memory, defeating the purpose of channels
4. **Only the sender closes a channel** — closing from the receiver side panics if the sender writes after close
5. **Specify channel direction** (`chan<-`, `<-chan`) — the compiler prevents misuse at build time
6. **Default to unbuffered channels** — larger buffers mask backpressure; use them only with measured justification
7. **Always include `ctx.Done()` in select** — without it, goroutines leak after caller cancellation
8. **Avoid repeated `time.After` in hot loops** — each call allocates a timer and creates unnecessary churn; use `time.NewTimer` + `Reset` for long-running loops
9. **Track goroutine leaks in tests** with `go.uber.org/goleak`

For detailed channel/select code examples, see [Channels and Select Patterns](references/channels-and-select.md).

## Channel vs Mutex vs Atomic

| Scenario | Use | Why |
| --- | --- | --- |
| Passing data between goroutines | Channel | Communicates ownership transfer |
| Coordinating goroutine lifecycle | Channel + context | Clean shutdown with select |
| Protecting shared struct fields | `sync.Mutex` / `sync.RWMutex` | Simple critical sections |
| Simple counters, flags | `sync/atomic` | Lock-free, lower overhead |
| Many readers, few writers on a map | `sync.Map` | Optimized for read-heavy workloads. **Concurrent map read/write causes a hard crash** |
| Caching expensive computations | `sync.Once` / `singleflight` | Execute once or deduplicate |

## WaitGroup vs errgroup

| Need | Use | Why |
| --- | --- | --- |
| Wait for goroutines, errors not needed | `sync.WaitGroup` | Fire-and-forget |
| Wait + collect first error | `errgroup.Group` | Error propagation |
| Wait + cancel siblings on first error | `errgroup.WithContext` | Context cancellation on error |
| Wait + limit concurrency | `errgroup.SetLimit(n)` | Built-in worker pool |

## Sync Primitives Quick Reference

| Primitive | Use case | Key notes |
| --- | --- | --- |
| `sync.Mutex` | Protect shared state | Keep critical sections short; never hold across I/O |
| `sync.RWMutex` | Many readers, few writers | Never upgrade RLock to Lock (deadlock) |
| `sync/atomic` | Simple counters, flags | Prefer typed atomics (Go 1.19+): `atomic.Int64`, `atomic.Bool` |
| `sync.Map` | Concurrent map, read-heavy | No explicit locking; use `RWMutex`+map when writes dominate |
| `sync.Pool` | Reuse temporary objects | Always `Reset()` before `Put()`; reduces GC pressure |
| `sync.Once` | One-time initialization | Go 1.21+: `OnceFunc`, `OnceValue`, `OnceValues` |
| `sync.WaitGroup` | Waiting for simple goroutines | Go 1.25+: prefer `wg.Go(func(){ ... })` for fire-and-wait tasks that do not panic and do not need error propagation. For Go <1.25 use `Add`/`Done`. For errors/cancellation/limits, use `errgroup` with context. |
| `x/sync/singleflight` | Deduplicate concurrent calls | Cache stampede prevention |
| `x/sync/errgroup` | Goroutine group + errors | `SetLimit(n)` replaces hand-rolled worker pools |

For detailed examples and anti-patterns, see [Sync Primitives Deep Dive](references/sync-primitives.md).

## Concurrency Checklist

Before spawning a goroutine, answer:

- [ ] **How will it exit?** — context cancellation, channel close, or explicit signal
- [ ] **Can I signal it to stop?** — pass `context.Context` or done channel
- [ ] **Can I wait for it?** — `sync.WaitGroup` or `errgroup`
- [ ] **Who owns the channels?** — creator/sender owns and closes
- [ ] **Should this be synchronous instead?** — don't add concurrency without measured need

## Pipelines and Worker Pools

For pipeline patterns (fan-out/fan-in, bounded workers, generator chains, Go 1.23+ iterators, `samber/ro`), see [Pipelines and Worker Pools](references/pipelines.md).

## Parallelizing Concurrency Audits

When auditing concurrency across a large codebase, use up to 5 parallel sub-agents (Agent tool):

1. Find all goroutine spawns (`go func`, `go method`) and verify shutdown mechanisms
2. Search for mutable globals and shared state without synchronization
3. Audit channel usage — ownership, direction, closure, buffer sizes
4. Find `time.After` in loops, missing `ctx.Done()` in select, unbounded spawning
5. Check mutex usage, `sync.Map`, atomics, and thread-safety documentation

## Common Mistakes

| Mistake | Fix |
| --- | --- |
| Fire-and-forget goroutine | Provide stop mechanism (context, done channel) |
| Closing channel from receiver | Only the sender closes |
| `time.After` in hot loop | Reuse `time.NewTimer` + `Reset` |
| Missing `ctx.Done()` in select | Always select on context to allow cancellation |
| Unbounded goroutine spawning | Use `errgroup.SetLimit(n)` or semaphore |
| Sharing pointer via channel | Send copies or immutable values |
| `wg.Add` inside goroutine | Call `Add` before `go` — `Wait` may return early otherwise |
| Forgetting `-race` in CI | Always run `go test -race ./...` |
| Mutex held across I/O | Keep critical sections short |

## Cross-References

- -> See `samber/cc-skills-golang@golang-performance` skill for false sharing, cache-line padding, `sync.Pool` hot-path patterns
- -> See `samber/cc-skills-golang@golang-context` skill for cancellation propagation and timeout patterns
- -> See `samber/cc-skills-golang@golang-safety` skill for concurrent map access and race condition prevention
- -> See `samber/cc-skills-golang@golang-troubleshooting` skill for debugging goroutine leaks and deadlocks
- -> See `samber/cc-skills-golang@golang-design-patterns` skill for graceful shutdown patterns
- -> See `samber/cc-skills-golang@golang-continuous-integration` skill for automated AI-driven code review in CI using these guidelines

### Go 1.26 experimental goroutine leak profile

For Go 1.26 diagnostics, there is an experimental goroutine leak profile. It is useful for production-oriented leak investigation, but is gated by `GOEXPERIMENT=goroutineleakprofile`; do not rely on it as default stable behavior.

Typical usage when the experiment is enabled:

```bash
curl http://localhost:6060/debug/pprof/goroutineleak?debug=2
go tool pprof http://localhost:6060/debug/pprof/goroutineleak
```

Keep existing tools:

- tests: `go.uber.org/goleak`
- runtime count: `runtime.NumGoroutine()`
- stack dump: `/debug/pprof/goroutine?debug=2`
- race checks: `go test -race ./...`

## References

- [Go Concurrency Patterns: Pipelines](https://go.dev/blog/pipelines)
- [Effective Go: Concurrency](https://go.dev/doc/effective_go#concurrency)
