# Recipes — uber-go/fx

End-to-end examples that go beyond the SKILL.md basics. Each recipe is self-contained and shows a real wiring problem.

## Full HTTP service with database, metrics, and graceful shutdown

```go
package main

import (
    "context"
    "database/sql"
    "fmt"
    "net"
    "net/http"
    "time"

    "github.com/prometheus/client_golang/prometheus"
    "github.com/prometheus/client_golang/prometheus/promhttp"
    "go.uber.org/fx"
    "go.uber.org/fx/fxevent"
    "go.uber.org/zap"
)

func main() {
    fx.New(
        fx.Provide(
            NewConfig,
            NewLogger,
            NewDatabase,
            NewMetricsRegistry,
        ),

        DatabaseModule,
        HTTPModule,
        MetricsModule,

        fx.WithLogger(func(log *zap.Logger) fxevent.Logger {
            return &fxevent.ZapLogger{Logger: log}
        }),

        fx.StartTimeout(30 * time.Second),
        fx.StopTimeout(30 * time.Second),
    ).Run()
}

var DatabaseModule = fx.Module("database",
    fx.Provide(
        NewUserRepository,
        NewPostRepository,
    ),
    fx.Decorate(func(log *zap.Logger) *zap.Logger {
        return log.Named("db")
    }),
)

var HTTPModule = fx.Module("http",
    fx.Provide(
        NewRouter,
        NewHTTPServer,
        // Each handler joins the "routes" group.
        AsRoute(NewUserHandler),
        AsRoute(NewPostHandler),
        AsRoute(NewHealthHandler),
    ),
    fx.Invoke(func(*http.Server) {}), // forces server to be built
)

var MetricsModule = fx.Module("metrics",
    fx.Provide(NewPrometheusHandler),
    fx.Invoke(RegisterMetrics),
)

// Helper to register a handler with the "routes" group.
func AsRoute(ctor any) any {
    return fx.Annotate(
        ctor,
        fx.As(new(Route)),
        fx.ResultTags(`group:"routes"`),
    )
}

type Route interface {
    Pattern() string
    http.Handler
}

type RouterParams struct {
    fx.In
    Routes []Route `group:"routes"`
}

func NewRouter(p RouterParams) *http.ServeMux {
    mux := http.NewServeMux()
    for _, r := range p.Routes {
        mux.Handle(r.Pattern(), r)
    }
    return mux
}

func NewHTTPServer(lc fx.Lifecycle, log *zap.Logger, mux *http.ServeMux, cfg *Config) *http.Server {
    srv := &http.Server{
        Addr:         cfg.Addr,
        Handler:      mux,
        ReadTimeout:  10 * time.Second,
        WriteTimeout: 10 * time.Second,
    }

    lc.Append(fx.Hook{
        OnStart: func(ctx context.Context) error {
            ln, err := net.Listen("tcp", srv.Addr)
            if err != nil {
                return fmt.Errorf("listen %s: %w", srv.Addr, err)
            }
            go func() {
                if err := srv.Serve(ln); err != nil && err != http.ErrServerClosed {
                    log.Error("server error", zap.Error(err))
                }
            }()
            log.Info("listening", zap.String("addr", srv.Addr))
            return nil
        },
        OnStop: func(ctx context.Context) error {
            log.Info("shutting down")
            return srv.Shutdown(ctx)
        },
    })
    return srv
}
```

## Background worker with graceful drain

```go
type Worker struct {
    log    *zap.Logger
    queue  chan Job
    done   chan struct{}
}

func NewWorker(lc fx.Lifecycle, log *zap.Logger) *Worker {
    w := &Worker{
        log:   log,
        queue: make(chan Job, 100),
        done:  make(chan struct{}),
    }

    lc.Append(fx.Hook{
        OnStart: func(ctx context.Context) error {
            go w.run()
            return nil
        },
        OnStop: func(ctx context.Context) error {
            close(w.queue) // signal "no more jobs"
            select {
            case <-w.done:
                w.log.Info("worker drained cleanly")
                return nil
            case <-ctx.Done():
                w.log.Warn("worker stop timeout")
                return ctx.Err()
            }
        },
    })

    return w
}

func (w *Worker) run() {
    defer close(w.done)
    for job := range w.queue {
        job.Do(w.log)
    }
}
```

The worker honors the stop context — under a 30-second `fx.StopTimeout` it has 30 seconds to drain. Beyond that, fx reports the timeout and the process exits.

## Multiple implementations of the same interface

Use named annotations + `fx.As` to register two `Cache` implementations and inject them by name:

```go
fx.Provide(
    fx.Annotate(
        NewRedisCache,
        fx.As(new(Cache)),
        fx.ResultTags(`name:"redis"`),
    ),
    fx.Annotate(
        NewMemcachedCache,
        fx.As(new(Cache)),
        fx.ResultTags(`name:"memcached"`),
    ),
)

type ServiceParams struct {
    fx.In
    Primary  Cache `name:"redis"`
    Fallback Cache `name:"memcached"`
}
```

## fx.Supply for config and secrets

```go
func main() {
    cfg := mustLoadConfig() // parsed flags + env, before fx
    secret := os.Getenv("API_KEY")

    fx.New(
        fx.Supply(cfg),                  // *Config available everywhere
        fx.Supply(fx.Annotate(secret, fx.ResultTags(`name:"apikey"`))),

        fx.Provide(NewLogger, NewAPIClient),
        fx.Invoke(run),
    ).Run()
}

func NewAPIClient(cfg *Config, p struct {
    fx.In
    APIKey string `name:"apikey"`
}) *APIClient {
    return &APIClient{baseURL: cfg.APIBaseURL, key: p.APIKey}
}
```

`fx.Supply` makes pre-built values first-class graph members. It is shorter and clearer than `fx.Provide(func() *Config { return cfg })`.

## Module-scoped decorator

```go
var WorkerModule = fx.Module("worker",
    fx.Provide(NewWorker, NewJobQueue),
    // Inside this module, *zap.Logger is automatically named "worker".
    fx.Decorate(func(log *zap.Logger) *zap.Logger {
        return log.Named("worker")
    }),
)

var APIModule = fx.Module("api",
    fx.Provide(NewServer, NewRouter),
    fx.Decorate(func(log *zap.Logger) *zap.Logger {
        return log.Named("api")
    }),
)
```

The two modules see different loggers — there is no shared mutation of the parent value.

## Optional dependency for tracing

```go
type ServerParams struct {
    fx.In

    Logger *zap.Logger
    Tracer trace.Tracer `optional:"true"`
}

func NewServer(p ServerParams) *Server {
    s := &Server{log: p.Logger}
    if p.Tracer == nil {
        s.tracer = trace.NewNoopTracerProvider().Tracer("noop")
    } else {
        s.tracer = p.Tracer
    }
    return s
}
```

Reach for `optional` only when the dependency is genuinely optional. A missing core service hidden behind `optional` becomes a nil-pointer panic at first use.

## Manual lifecycle for embedding fx in a CLI

When fx is one component inside a larger program (a CLI tool, a test runner), drive Start/Stop yourself instead of calling `Run()`:

```go
func runFxApp(parent context.Context) error {
    app := fx.New(
        fx.Provide(NewConfig, NewLogger, NewWorker),
        fx.Invoke(func(*Worker) {}),
    )
    if err := app.Err(); err != nil {
        return fmt.Errorf("wire: %w", err)
    }

    startCtx, cancel := context.WithTimeout(parent, 30*time.Second)
    defer cancel()
    if err := app.Start(startCtx); err != nil {
        return fmt.Errorf("start: %w", err)
    }

    select {
    case <-parent.Done():
    case <-app.Done(): // SIGINT/SIGTERM
    }

    stopCtx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
    defer cancel()
    return app.Stop(stopCtx)
}
```

`app.Err()` validates wiring without starting — useful for `--check` style flags.

## Custom event logger that filters noise

```go
type ProductionLogger struct {
    inner *fxevent.ZapLogger
}

func (l *ProductionLogger) LogEvent(e fxevent.Event) {
    switch e.(type) {
    case *fxevent.Provided, *fxevent.Supplied, *fxevent.Decorated:
        return // drop the per-Provide chatter
    default:
        l.inner.LogEvent(e)
    }
}

fx.New(
    fx.Provide(NewZapLogger),
    fx.WithLogger(func(log *zap.Logger) fxevent.Logger {
        return &ProductionLogger{inner: &fxevent.ZapLogger{Logger: log}}
    }),
)
```

In production, filtering provide/decorate noise leaves only lifecycle (start/stop) events and errors — much easier to audit.
