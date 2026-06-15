---
name: golang-samber-ro
description: "Reactive streams and event-driven programming in Golang using samber/ro — ReactiveX implementation with 150+ type-safe operators, cold/hot observables, 5 subject types (Publish, Behavior, Replay, Async, Unicast), declarative pipelines via Pipe, 40+ plugins (HTTP, cron, fsnotify, JSON, logging), automatic backpressure, error propagation, and Go context integration. Apply when using or adopting samber/ro, when the codebase imports github.com/samber/ro, or when building asynchronous event-driven pipelines, real-time data processing, streams, or reactive architectures in Go. Not for finite slice transforms (→ See `samber/cc-skills-golang@golang-samber-lo` skill)."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents, and for projects using Golang.
metadata:
  author: samber
  version: "1.1.0"
  openclaw:
    emoji: "👁"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
    install: []
    skill-library-version: "0.3.0"
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Agent mcp__context7__resolve-library-id mcp__context7__query-docs AskUserQuestion
---

**Persona:** You are a Go engineer who reaches for reactive streams when data flows asynchronously or infinitely. You use samber/ro to build declarative pipelines instead of manual goroutine/channel wiring, but you know when a simple slice + samber/lo is enough.

**Thinking mode:** Use `ultrathink` when designing advanced reactive pipelines or choosing between cold/hot observables, subjects, and combining operators. Wrong architecture leads to resource leaks or missed events.

# samber/ro — Reactive Streams for Go

Go implementation of [ReactiveX](https://reactivex.io/). Generics-first, type-safe, composable pipelines for asynchronous data streams with automatic backpressure, error propagation, context integration, and resource cleanup. 150+ operators, 5 subject types, 40+ plugins.

**Official Resources:**

- [github.com/samber/ro](https://github.com/samber/ro)
- [ro.samber.dev](https://ro.samber.dev)
- [pkg.go.dev/github.com/samber/ro](https://pkg.go.dev/github.com/samber/ro)

This skill is not exhaustive. Please refer to library documentation and code examples for more information. Context7 can help as a discoverability platform.

## Why samber/ro (Streams vs Slices)

Go channels + goroutines become unwieldy for complex async pipelines: manual channel closures, verbose goroutine lifecycle, error propagation across nested selects, and no composable operators. `samber/ro` solves this with declarative, chainable stream operators.

**When to use which tool:**

| Scenario | Tool | Why |
| --- | --- | --- |
| Transform a slice (map, filter, reduce) | `samber/lo` | Finite, synchronous, eager — no stream overhead needed |
| Simple goroutine fan-out with error handling | `errgroup` | Standard lib, lightweight, sufficient for bounded concurrency |
| Infinite event stream (WebSocket, tickers, file watcher) | `samber/ro` | Declarative pipeline with backpressure, retry, timeout, combine |
| Real-time data enrichment from multiple async sources | `samber/ro` | CombineLatest/Zip compose dependent streams without manual select |
| Pub/sub with multiple consumers sharing one source | `samber/ro` | Hot observables (Share/Subjects) handle multicast natively |

**Key differences: lo vs ro**

| Aspect | `samber/lo` | `samber/ro` |
| --- | --- | --- |
| Data | Finite slices | Infinite streams |
| Execution | Synchronous, blocking | Asynchronous, non-blocking |
| Evaluation | Eager (allocates intermediate slices) | Lazy (processes items as they arrive) |
| Timing | Immediate | Time-aware (delay, throttle, interval, timeout) |
| Error model | Return `(T, error)` per call | Error channel propagates through pipeline |
| Use case | Collection transforms | Event-driven, real-time, async pipelines |

## Installation

```bash
go get github.com/samber/ro
```

## Core Concepts

Four building blocks:

1. **Observable** — a data source that emits values over time. Cold by default: each subscriber triggers independent execution from scratch
2. **Observer** — a consumer with three callbacks: `onNext(T)`, `onError(error)`, `onComplete()`
3. **Operator** — a function that transforms an observable into another observable, chained via `Pipe`
4. **Subscription** — the connection between observable and observer. Call `.Wait()` to block or `.Unsubscribe()` to cancel

```go
observable := ro.Pipe2(
    ro.RangeWithInterval(0, 5, 1*time.Second),
    ro.Filter(func(x int) bool { return x%2 == 0 }),
    ro.Map(func(x int) string { return fmt.Sprintf("even-%d", x) }),
)

observable.Subscribe(ro.NewObserver(
    func(s string) { fmt.Println(s) },      // onNext
    func(err error) { log.Println(err) },    // onError
    func() { fmt.Println("Done!") },         // onComplete
))
// Output: "even-0", "even-2", "even-4", "Done!"

// Or collect synchronously:
values, err := ro.Collect(observable)
```

## Cold vs Hot Observables

**Cold** (default): each `.Subscribe()` starts a new independent execution. Safe and predictable — use by default.

**Hot**: multiple subscribers share a single execution. Use when the source is expensive (WebSocket, DB poll) or subscribers must see the same events.

| Convert with | Behavior |
| --- | --- |
| `Share()` | Cold → hot with reference counting. Last unsubscribe tears down |
| `ShareReplay(n)` | Same as Share + buffers last N values for late subscribers |
| `Connectable()` | Cold → hot, but waits for explicit `.Connect()` call |
| Subjects | Natively hot — call `.Send()`, `.Error()`, `.Complete()` directly |

| Subject | Constructor | Replay behavior |
| --- | --- | --- |
| `PublishSubject` | `NewPublishSubject[T]()` | None — late subscribers miss past events |
| `BehaviorSubject` | `NewBehaviorSubject[T](initial)` | Replays last value to new subscribers |
| `ReplaySubject` | `NewReplaySubject[T](bufferSize)` | Replays last N values |
| `AsyncSubject` | `NewAsyncSubject[T]()` | Emits only last value, only on complete |
| `UnicastSubject` | `NewUnicastSubject[T](bufferSize)` | Single subscriber only |

For subject details and hot observable patterns, see [Subjects Guide](./references/subjects-guide.md).

## Operator Quick Reference

| Category | Key operators | Purpose |
| --- | --- | --- |
| Creation | `Just`, `FromSlice`, `FromChannel`, `Range`, `Interval`, `Defer`, `Future` | Create observables from various sources |
| Transform | `Map`, `MapErr`, `FlatMap`, `Scan`, `Reduce`, `GroupBy` | Transform or accumulate stream values |
| Filter | `Filter`, `Take`, `TakeLast`, `Skip`, `Distinct`, `Find`, `First`, `Last` | Selectively emit values |
| Combine | `Merge`, `Concat`, `Zip2`–`Zip6`, `CombineLatest2`–`CombineLatest5`, `Race` | Merge multiple observables |
| Error | `Catch`, `OnErrorReturn`, `OnErrorResumeNextWith`, `Retry`, `RetryWithConfig` | Recover from errors |
| Timing | `Delay`, `DelayEach`, `Timeout`, `ThrottleTime`, `SampleTime`, `BufferWithTime` | Control emission timing |
| Side effect | `Tap`/`Do`, `TapOnNext`, `TapOnError`, `TapOnComplete` | Observe without altering stream |
| Terminal | `Collect`, `ToSlice`, `ToChannel`, `ToMap` | Consume stream into Go types |

Use typed `Pipe2`, `Pipe3` ... `Pipe25` for compile-time type safety across operator chains. The untyped `Pipe` uses `any` and loses type checking.

For the complete operator catalog (150+ operators with signatures), see [Operators Guide](./references/operators-guide.md).

## Common Mistakes

| Mistake | Why it fails | Fix |
| --- | --- | --- |
| Using `ro.OnNext()` without error handler | Errors are silently dropped — bugs hide in production | Use `ro.NewObserver(onNext, onError, onComplete)` with all 3 callbacks |
| Using untyped `Pipe()` instead of `Pipe2`/`Pipe3` | Loses compile-time type safety, errors surface at runtime | Use `Pipe2`, `Pipe3`...`Pipe25` for typed operator chains |
| Forgetting `.Unsubscribe()` on infinite streams | Goroutine leak — the observable runs forever | Use `TakeUntil(signal)`, context cancellation, or explicit `Unsubscribe()` |
| Using `Share()` when cold is sufficient | Unnecessary complexity, harder to reason about lifecycle | Use hot observables only when multiple consumers need the same stream |
| Using `samber/ro` for finite slice transforms | Stream overhead (goroutines, subscriptions) for a synchronous operation | Use `samber/lo` — it's simpler, faster, and purpose-built for slices |
| Not propagating context for cancellation | Streams ignore shutdown signals, causing resource leaks on termination | Chain `ContextWithTimeout` or `ThrowOnContextCancel` in the pipeline |

## Best Practices

1. **Always handle all three events** — use `NewObserver(onNext, onError, onComplete)`, not just `OnNext`. Unhandled errors cause silent data loss
2. **Use `Collect()` for synchronous consumption** — when the stream is finite and you need `[]T`, `Collect` blocks until complete and returns the slice + error
3. **Prefer typed Pipe functions** — `Pipe2`, `Pipe3`...`Pipe25` catch type mismatches at compile time. Reserve untyped `Pipe` for dynamic operator chains
4. **Bound infinite streams** — use `Take(n)`, `TakeUntil(signal)`, `Timeout(d)`, or context cancellation. Unbounded streams leak goroutines
5. **Use `Tap`/`Do` for observability** — log, trace, or meter emissions without altering the stream. Chain `TapOnError` for error monitoring
6. **Prefer `samber/lo` for simple transforms** — if the data is a finite slice and you need Map/Filter/Reduce, use `lo`. Reach for `ro` when data arrives over time, from multiple sources, or needs retry/timeout/backpressure

## Plugin Ecosystem

40+ plugins extend ro with domain-specific operators:

| Category | Plugins | Import path prefix |
| --- | --- | --- |
| Encoding | JSON, CSV, Base64, Gob | `plugins/encoding/...` |
| Network | HTTP, I/O, FSNotify | `plugins/http`, `plugins/io`, `plugins/fsnotify` |
| Scheduling | Cron, ICS | `plugins/cron`, `plugins/ics` |
| Observability | Zap, Slog, Zerolog, Logrus, Sentry, Oops | `plugins/observability/...`, `plugins/samber/oops` |
| Rate limiting | Native, Ulule | `plugins/ratelimit/...` |
| Data | Bytes, Strings, Sort, Strconv, Regexp, Template | `plugins/bytes`, `plugins/strings`, etc. |
| System | Process, Signal | `plugins/proc`, `plugins/signal` |

For the full plugin catalog with import paths and usage examples, see [Plugin Ecosystem](./references/plugin-ecosystem.md).

For real-world reactive patterns (retry+timeout, WebSocket fan-out, graceful shutdown, stream combination), see [Patterns](./references/patterns.md).

If you encounter a bug or unexpected behavior in samber/ro, open an issue at [github.com/samber/ro/issues](https://github.com/samber/ro/issues).

## Cross-References

- → See `samber/cc-skills-golang@golang-samber-lo` skill for finite slice transforms (Map, Filter, Reduce, GroupBy) — use lo when data is already in a slice
- → See `samber/cc-skills-golang@golang-samber-mo` skill for monadic types (Option, Result, Either) that compose with ro pipelines
- → See `samber/cc-skills-golang@golang-samber-hot` skill for in-memory caching (also available as an ro plugin)
- → See `samber/cc-skills-golang@golang-concurrency` skill for goroutine/channel patterns when reactive streams are overkill
- → See `samber/cc-skills-golang@golang-observability` skill for monitoring reactive pipelines in production
