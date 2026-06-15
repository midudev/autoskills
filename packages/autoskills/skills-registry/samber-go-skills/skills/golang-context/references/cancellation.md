# Cancellation, Timeouts & Deadlines

## Cancellation

`context.WithCancel` returns a derived context and a `cancel` function. When `cancel()` is called, the context's `Done()` channel is closed, signaling all listeners to stop.

```go
func processItems(ctx context.Context, items []Item) error {
    ctx, cancel := context.WithCancel(ctx)
    defer cancel() // always defer cancel to free resources

    errCh := make(chan error, len(items))
    for _, item := range items {
        go func(item Item) {
            errCh <- processOne(ctx, item)
        }(item)
    }

    for range items {
        if err := <-errCh; err != nil {
            cancel() // cancel remaining goroutines on first error
            return fmt.Errorf("processing items: %w", err)
        }
    }
    return nil
}
```

### Why `defer cancel()` matters

Every `WithCancel`, `WithTimeout`, and `WithDeadline` creates cancellation state; timeout/deadline contexts also use timer resources. `cancel()` MUST be called on all control-flow paths unless the function explicitly returns or transfers ownership of both the context and cancel function. In ordinary scoped work, defer cancel immediately.

```go
// ✗ Bad — cancel is never called, resources leak
func fetch(ctx context.Context) error {
    ctx, _ = context.WithTimeout(ctx, 5*time.Second)
    return doWork(ctx)
}

// ✓ Good — scoped work, defer cancel immediately
func fetch(ctx context.Context) error {
    ctx, cancel := context.WithTimeout(ctx, 5*time.Second)
    defer cancel()
    return doWork(ctx)
}
```

## Timeouts and Deadlines

### `context.WithTimeout` — relative duration

```go
func (s *UserService) GetUser(ctx context.Context, id string) (*User, error) {
    ctx, cancel := context.WithTimeout(ctx, 3*time.Second)
    defer cancel()

    return s.repo.FindByID(ctx, id)
}
```

### `context.WithDeadline` — absolute point in time

```go
func (s *BatchService) ProcessBatch(ctx context.Context, batch Batch) error {
    // The batch must complete by its SLA deadline
    ctx, cancel := context.WithDeadline(ctx, batch.SLADeadline)
    defer cancel()

    for _, item := range batch.Items {
        if err := s.process(ctx, item); err != nil {
            return fmt.Errorf("processing batch item %s: %w", item.ID, err)
        }
    }
    return nil
}
```

### Nested timeouts take the shorter deadline

If a parent context has a 5s timeout and you create a child with 10s, the child still expires at 5s. The shorter deadline always wins.

```go
// Parent has 2s timeout — child's 10s is effectively ignored
parentCtx, cancel := context.WithTimeout(ctx, 2*time.Second)
defer cancel()

childCtx, childCancel := context.WithTimeout(parentCtx, 10*time.Second)
defer childCancel()
// childCtx expires after 2s, not 10s
```

## Listening for Cancellation

### The `select` pattern

Use `ctx.Done()` in a `select` statement to react to cancellation alongside other work:

```go
func poll(ctx context.Context, interval time.Duration) error {
    ticker := time.NewTicker(interval)
    defer ticker.Stop()

    for {
        select {
        case <-ctx.Done():
            return ctx.Err() // context.Canceled or context.DeadlineExceeded
        case <-ticker.C:
            if err := doWork(ctx); err != nil {
                return fmt.Errorf("polling: %w", err)
            }
        }
    }
}
```

### Checking cancellation in loops

For CPU-bound work, periodically check `ctx.Err()`:

```go
func processLargeDataset(ctx context.Context, items []Item) error {
    for i, item := range items {
        if ctx.Err() != nil {
            return fmt.Errorf("processing interrupted after %d/%d items: %w", i, len(items), ctx.Err())
        }
        process(item)
    }
    return nil
}
```

## `context.AfterFunc` (Go 1.21+)

Registers a callback that runs in its own goroutine when the context is cancelled. Useful for cleanup without blocking the main flow.

```go
func watchResource(ctx context.Context, res *Resource) {
    stop := context.AfterFunc(ctx, func() {
        // Runs in a new goroutine when ctx is cancelled
        res.Release()
    })

    // If you no longer need the callback, cancel it:
    // stop() returns true if the callback was successfully cancelled
    _ = stop
}
```

## `context.WithoutCancel` (Go 1.21+)

Creates a child context that is not cancelled when the parent is. Use this for background work that must continue after the request completes — like async logging, audit trails, or enqueuing follow-up tasks.

```go
func (h *Handler) CreateOrder(w http.ResponseWriter, r *http.Request) {
    ctx := r.Context()

    order, err := h.orderService.Create(ctx, req)
    if err != nil {
        // handle error
        return
    }

    // Audit log must complete even if the client disconnects.
    // WithoutCancel preserves context values (trace_id) but detaches cancellation.
    auditCtx := context.WithoutCancel(ctx)
    go h.auditService.LogOrderCreated(auditCtx, order)

    w.WriteHeader(http.StatusCreated)
}
```

Without `WithoutCancel`, you'd have to choose between `ctx` (which gets cancelled when the handler returns, killing your background work) and `context.Background()` (which loses trace_id and other values). `WithoutCancel` gives you the best of both: values are preserved, but cancellation is detached.
