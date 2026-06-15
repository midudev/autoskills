# Resource Management Patterns

## Defer Close Immediately

`defer Close()` MUST be called immediately after opening — NEVER delay. This prevents leaks when code is modified later and new return paths are added:

```go
// Good — defer is right next to open
f, err := os.Open(path)
if err != nil {
    return err
}
defer f.Close()

// Bad — Close() is far from Open(), easy to forget when adding early returns
f, err := os.Open(path)
if err != nil {
    return err
}
// ... 50 lines of code ...
f.Close() // might never run if a new return is added above
```

This applies to all closeable resources: files, SQL rows, HTTP response bodies, gzip readers, bufio scanners wrapping readers, etc.

```go
resp, err := http.Get(url)
if err != nil {
    return err
}
defer resp.Body.Close()

rows, err := db.QueryContext(ctx, query)
if err != nil {
    return err
}
defer rows.Close()
```

## `runtime.AddCleanup` over `runtime.SetFinalizer`

`runtime.AddCleanup` SHOULD be preferred over `runtime.SetFinalizer` (Go 1.24+):

```go
type Resource struct {
    handle uintptr
}

func NewResource() *Resource {
    r := &Resource{handle: acquireHandle()}
    runtime.AddCleanup(r, func(handle uintptr) {
        releaseHandle(handle)
    }, r.handle)
    return r
}
```

`AddCleanup` is preferred because:

- Multiple cleanups can be attached to the same object
- The cleanup function receives a copy of the value, not the object itself — no resurrection risk
- Cleanups run even if the object is part of a cycle

## Resource Pools

Resource pools SHOULD use channels with a fixed capacity for bounded allocation. Use channel-based pools or `sync.Pool` to manage limited resources between consumers. Always set a maximum size:

```go
type ConnPool struct {
    conns chan *Conn
}

func NewConnPool(maxSize int, factory func() (*Conn, error)) (*ConnPool, error) {
    pool := &ConnPool{
        conns: make(chan *Conn, maxSize),
    }
    // Pre-fill with initial connections
    for range maxSize {
        conn, err := factory()
        if err != nil {
            return nil, fmt.Errorf("creating connection: %w", err)
        }
        pool.conns <- conn
    }
    return pool, nil
}

func (p *ConnPool) Get(ctx context.Context) (*Conn, error) {
    select {
    case conn := <-p.conns:
        return conn, nil
    case <-ctx.Done():
        return nil, ctx.Err()
    }
}

func (p *ConnPool) Put(conn *Conn) {
    select {
    case p.conns <- conn:
    default:
        conn.Close() // pool is full, discard
    }
}
```

## Graceful Shutdown

Graceful shutdown MUST use `signal.NotifyContext` for clean termination. All resources (connections, files, channels) MUST be drained before process exit. Use `os/signal` and context cancellation:

```go
func main() {
    ctx, stop := signal.NotifyContext(context.Background(),
        syscall.SIGINT, syscall.SIGTERM,
    )
    defer stop()

    srv := &http.Server{Addr: ":8080", Handler: router}

    // Start server in background
    go func() {
        if err := srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
            slog.Error("server error", "error", err)
        }
    }()

    slog.Info("server started", "addr", ":8080")

    // Wait for interrupt signal
    <-ctx.Done()
    slog.Info("shutting down...")

    // Give outstanding requests time to complete
    shutdownCtx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
    defer cancel()

    if err := srv.Shutdown(shutdownCtx); err != nil {
        slog.Error("shutdown error", "error", err)
    }

    // Close other resources: database connections, message queues, etc.
    db.Close()
    slog.Info("shutdown complete")
}
```

This pattern applies to any long-running service — gRPC servers, message consumers, background workers. The key elements are:

1. Capture OS signals with `signal.NotifyContext`
2. Start the server in a goroutine
3. Block on context cancellation
4. Shut down with a timeout to drain in-flight requests
5. Close all remaining resources in order

For goroutine shutdown patterns, see the `samber/cc-skills-golang@golang-concurrency` skill.
