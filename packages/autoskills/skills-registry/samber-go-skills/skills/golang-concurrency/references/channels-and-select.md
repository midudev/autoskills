# Channels and Select Patterns

## Goroutine Lifecycle

NEVER start a goroutine without knowing how it stops. Every goroutine MUST answer: **how will it stop?**

```go
// ✗ Bad — fire-and-forget, no way to stop or wait
func startWorker() {
    go func() {
        for {
            doWork() // runs forever, leaks on shutdown
        }
    }()
}

// ✓ Good — goroutine respects context cancellation, caller can wait
func startWorker(ctx context.Context) *sync.WaitGroup {
    var wg sync.WaitGroup
    wg.Add(1)
    go func() {
        defer wg.Done()
        for {
            select {
            case <-ctx.Done():
                return
            default:
                doWork(ctx)
            }
        }
    }()
    return &wg
}
```

### Panic Recovery at Goroutine Boundaries

A panic in a goroutine crashes the entire process. Always recover at goroutine boundaries in production code:

```go
go func() {
    defer func() {
        if r := recover(); r != nil {
            // ...
        }
    }()
    doWork(ctx)
}()
```

## Channel Direction

Specify direction in function signatures to prevent misuse at compile time:

```go
// ✗ Bad — caller could accidentally close or send on a receive-only channel
func consume(ch chan int) { ... }

// ✓ Good — compiler enforces correct usage
func produce(ch chan<- int) { ... } // send-only
func consume(ch <-chan int) { ... } // receive-only
```

## Channel Closing

Channels MUST be closed by the sender (producer), NEVER by the receiver — it causes a panic if the sender writes after close.

```go
// ✓ Good — producer closes when done
func generate(ctx context.Context) <-chan int {
    ch := make(chan int)
    go func() {
        defer close(ch) // sender closes
        for i := 0; ; i++ {
            select {
            case ch <- i:
            case <-ctx.Done():
                return
            }
        }
    }()
    return ch
}
```

## Buffer Size

| Size | When to use |
| --- | --- |
| 0 (unbuffered) | Default. Synchronizes sender and receiver — use when you need handoff guarantees |
| 1 | Signal channels (`done := make(chan struct{}, 1)`), or when sender must not block on a single pending item |
| N > 1 | Only with measured justification — document why N was chosen and what happens when the buffer fills |

```go
// ✓ Good — unbuffered for synchronous handoff
ch := make(chan Result)

// ✓ Good — buffered 1 for signal
done := make(chan struct{}, 1)

// ✗ Suspicious — arbitrary large buffer hides backpressure problems
// Give explanation in comments.
ch := make(chan Task, 1000) // why 1000? what if it fills?
```

## Select for Non-Blocking Communication

Use `select` to multiplex channel operations and always include `ctx.Done()` to prevent goroutine leaks:

```go
func process(ctx context.Context, in <-chan Task, out chan<- Result) {
    for {
        select {
        case <-ctx.Done():
            return
        case task, ok := <-in:
            if !ok {
                return // channel closed
            }
            result := handle(ctx, task)
            select {
            case out <- result:
            case <-ctx.Done():
                return
            }
        }
    }
}
```

## Avoid Repeated `time.After` in Hot Loops

```go
// ✗ Bad — creates a new timer on every iteration
for {
    select {
    case msg := <-ch:
        handle(msg)
    case <-time.After(5 * time.Second): // repeated allocation/churn
        handleTimeout()
    }
}

// ✓ Good (Go 1.23+) — reuse the timer
timer := time.NewTimer(5 * time.Second)
defer timer.Stop()
for {
    select {
    case msg := <-ch:
        timer.Stop()
        timer.Reset(5 * time.Second)
        handle(msg)
    case <-timer.C:
        handleTimeout()
        timer.Reset(5 * time.Second)
    }
}
```

For Go <1.23, if `timer.Stop()` returns false, drain a possible stale value before `Reset`. In Go 1.23+, receiving from `timer.C` after `Stop` returns is guaranteed to block rather than receive a stale value.
