# Recipes — uber-go/dig

End-to-end examples that go beyond the SKILL.md basics. Each recipe is self-contained and shows a real wiring problem.

## HTTP server with route group

```go
package main

import (
    "fmt"
    "log"
    "net/http"

    "go.uber.org/dig"
)

// Each handler contributes one route to the "routes" group.
type RouteResult struct {
    dig.Out
    Route Route `group:"routes"`
}

type Route struct {
    Pattern string
    Handler http.Handler
}

func NewHealthRoute() RouteResult {
    return RouteResult{Route: Route{
        Pattern: "/health",
        Handler: http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
            w.WriteHeader(http.StatusOK)
        }),
    }}
}

func NewUserRoute(repo *UserRepo) RouteResult {
    return RouteResult{Route: Route{
        Pattern: "/users",
        Handler: http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
            users, err := repo.List(r.Context())
            if err != nil {
                http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
                return
            }
            fmt.Fprintf(w, "%d users", len(users))
        }),
    }}
}

// The server consumes every Route registered to "routes".
type ServerParams struct {
    dig.In
    Routes []Route `group:"routes"`
}

func NewServer(p ServerParams) *http.Server {
    mux := http.NewServeMux()
    for _, r := range p.Routes {
        mux.Handle(r.Pattern, r.Handler)
    }
    return &http.Server{Addr: ":8080", Handler: mux}
}

func main() {
    c := dig.New()

    must(c.Provide(NewDB))           // *sql.DB
    must(c.Provide(NewUserRepo))     // *UserRepo
    must(c.Provide(NewHealthRoute))  // adds to group
    must(c.Provide(NewUserRoute))    // adds to group
    must(c.Provide(NewServer))

    err := c.Invoke(func(srv *http.Server) error {
        log.Println("listening on", srv.Addr)
        return srv.ListenAndServe()
    })
    if err != nil {
        log.Fatal(err)
    }
}

func must(err error) {
    if err != nil {
        panic(err)
    }
}
```

## Two databases (read-write + read-only)

```go
type DBResult struct {
    dig.Out
    Primary  *sql.DB `name:"primary"`
    ReadOnly *sql.DB `name:"readonly"`
}

func NewDatabases(cfg *Config) (DBResult, error) {
    rw, err := sql.Open("postgres", cfg.PrimaryDSN)
    if err != nil {
        return DBResult{}, fmt.Errorf("primary: %w", err)
    }
    ro, err := sql.Open("postgres", cfg.ReadOnlyDSN)
    if err != nil {
        rw.Close()
        return DBResult{}, fmt.Errorf("readonly: %w", err)
    }
    return DBResult{Primary: rw, ReadOnly: ro}, nil
}

type RepoParams struct {
    dig.In
    Writer *sql.DB `name:"primary"`
    Reader *sql.DB `name:"readonly"`
}

func NewUserRepo(p RepoParams) *UserRepo {
    return &UserRepo{w: p.Writer, r: p.Reader}
}
```

## Provide as interface (`dig.As`) to hide concrete types

```go
type Cache interface {
    Get(key string) (string, bool)
    Set(key, value string)
}

type RedisCache struct {
    client *redis.Client
    metrics *Metrics // an internal field consumers should not see
}

func NewRedisCache(client *redis.Client, m *Metrics) *RedisCache {
    return &RedisCache{client: client, metrics: m}
}

func (c *RedisCache) Get(key string) (string, bool) { /* ... */ }
func (c *RedisCache) Set(key, value string)         { /* ... */ }

func main() {
    c := dig.New()
    must(c.Provide(NewRedisClient))
    must(c.Provide(NewMetrics))
    // Consumers see Cache, never *RedisCache or its internals.
    must(c.Provide(NewRedisCache, dig.As(new(Cache))))
    must(c.Invoke(func(cache Cache) {
        cache.Set("hello", "world")
    }))
}
```

## Request-scoped dependencies

A child scope inherits its parent's providers but adds request-local ones:

```go
root := dig.New()
must(root.Provide(NewLogger))
must(root.Provide(NewDB))
must(root.Provide(NewHandler)) // *Handler is shared; the scope inherits it

func handle(w http.ResponseWriter, req *http.Request) {
    scope := root.Scope("request")

    // Request-scoped values
    must(scope.Provide(func() *http.Request { return req }))
    must(scope.Provide(func() RequestID { return RequestID(req.Header.Get("X-Request-ID")) }))
    must(scope.Decorate(func(l *zap.Logger) *zap.Logger {
        return l.With(zap.String("request_id", req.Header.Get("X-Request-ID")))
    }))

    err := scope.Invoke(func(h *Handler) error {
        return h.Serve(w, req)
    })
    if err != nil {
        http.Error(w, err.Error(), 500)
    }
}
```

The decorator only applies inside the request scope — sibling scopes (other in-flight requests) keep their own logger.

## Optional dependency for graceful degradation

```go
type WorkerParams struct {
    dig.In

    DB     *sql.DB
    Tracer trace.Tracer `optional:"true"` // app still boots without OTel
}

func NewWorker(p WorkerParams) *Worker {
    w := &Worker{db: p.DB}
    if p.Tracer != nil {
        w.tracer = p.Tracer
    } else {
        w.tracer = trace.NewNoopTracerProvider().Tracer("noop")
    }
    return w
}
```

Reach for `optional` only when the dependency is genuinely optional — a missing DB hidden behind `optional` becomes a nil-pointer panic at first use.

## Decorate to add cross-cutting behavior

```go
// Wrap the *sql.DB with a metrics-recording wrapper everywhere.
must(c.Decorate(func(db *sql.DB, m *Metrics) *sql.DB {
    return wrapWithMetrics(db, m)
}))

// Wrap the logger with service tags.
must(c.Decorate(func(log *zap.Logger, cfg *Config) *zap.Logger {
    return log.With(
        zap.String("service", cfg.ServiceName),
        zap.String("env", cfg.Env),
    )
}))
```

Decorators are scope-local. A decorator on the root applies everywhere; a decorator on a child scope only applies to that subtree.

## DryRun for graph validation in tests

```go
func TestWiringIsValid(t *testing.T) {
    c := dig.New(dig.DryRun(true))

    // Register everything main() registers
    must := func(err error) {
        require.NoError(t, err)
    }
    must(c.Provide(NewConfig))
    must(c.Provide(NewLogger))
    must(c.Provide(NewDB))
    must(c.Provide(NewServer))

    // Invoke the composition root: dig validates types without running constructors.
    require.NoError(t, c.Invoke(func(*http.Server) {}))
}
```

This catches "no provider for \*X" failures at build time instead of in production.

## Visualizing a failed graph

```go
err := c.Invoke(run)
if err != nil {
    f, _ := os.Create("graph.dot")
    defer f.Close()
    _ = dig.Visualize(c, f, dig.VisualizeError(err))
    log.Fatalf("wiring failed (graph in graph.dot): %v", err)
}
// Render: dot -Tpng graph.dot -o graph.png
```

`VisualizeError` highlights the missing edges in red — much faster than reading the wrapped error chain.
