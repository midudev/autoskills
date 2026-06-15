# Advanced — uber-go/fx

Detail topics referenced from `SKILL.md`. Each section is self-contained.

## fx.Supply, fx.Replace, fx.Decorate

| Option | Purpose |
| --- | --- |
| `fx.Supply(values...)` | Provide pre-built values directly. Use for config, secrets, parsed flags. |
| `fx.Replace(values...)` | Replace an already-provided type. Most useful in tests: swap real for fake. |
| `fx.Decorate(fn)` | Wrap or modify an existing value. Scoped to the surrounding module. |

```go
fx.Supply(cfg, secret)

// Replace inside fxtest
fx.Replace(fx.Annotate(&fakeDB{}, fx.As(new(Database))))

// Decorate, module-scoped
fx.Module("worker",
    fx.Decorate(func(s metrics.Scope) metrics.Scope {
        return s.Tagged(map[string]string{"component": "worker"})
    }),
)
```

## Optional Dependencies

`optional:"true"` lets a consumer compile and run when no provider exists. Use it for genuinely optional features (a tracer, a cache) — not for core services like a database.

```go
type Params struct {
    fx.In

    Logger *zap.Logger
    Tracer trace.Tracer `optional:"true"`
}
```

## Logging fx Events

fx emits structured events (provide, invoke, hook execution, errors) through `fxevent.Logger`. By default it writes to stderr — replace with a Zap logger or silence it in tests:

```go
fx.New(
    fx.Provide(NewZapLogger),
    fx.WithLogger(func(log *zap.Logger) fxevent.Logger {
        return &fxevent.ZapLogger{Logger: log}
    }),
    // Or silence: fx.NopLogger
)
```

## Manual Lifecycle Control

`app.Run()` is convenient but inflexible. For tests, custom signal handling, or embedding fx in a larger program, drive the lifecycle manually:

```go
app := fx.New(/* ... */)

startCtx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
defer cancel()
if err := app.Start(startCtx); err != nil {
    log.Fatal(err)
}

<-app.Done() // waits for SIGINT/SIGTERM

stopCtx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
defer cancel()
if err := app.Stop(stopCtx); err != nil {
    log.Fatal(err)
}
```

`fx.StartTimeout` and `fx.StopTimeout` set defaults; pass an explicit context to override per-call.

## Quick Reference

### Application

| Function          | Purpose                                                |
| ----------------- | ------------------------------------------------------ |
| `fx.New(opts...)` | Build the application graph                            |
| `app.Run()`       | Start, wait for signal, Stop — single call             |
| `app.Start(ctx)`  | Run OnStart hooks in dependency order                  |
| `app.Stop(ctx)`   | Run OnStop hooks in reverse order                      |
| `app.Done()`      | Channel that closes on SIGINT/SIGTERM                  |
| `app.Err()`       | Wiring error from `fx.New` (validate without starting) |

### Wiring

| Option                     | Purpose                                     |
| -------------------------- | ------------------------------------------- |
| `fx.Provide(ctors...)`     | Register constructors                       |
| `fx.Invoke(fns...)`        | Run functions during Start                  |
| `fx.Supply(values...)`     | Provide pre-built values                    |
| `fx.Replace(values...)`    | Replace previously-provided values (tests)  |
| `fx.Decorate(fn)`          | Wrap an existing value (module-scoped)      |
| `fx.Module(name, opts...)` | Group providers/invokes/decorators          |
| `fx.Options(opts...)`      | Bundle options into a single value          |
| `fx.Populate(targets...)`  | Extract typed values from the graph (tests) |

### Annotations

| Function | Purpose |
| --- | --- |
| `fx.Annotate(fn, opts...)` | Tag/interface-wrap a constructor |
| `fx.ParamTags("...")` | Tag parameters of an annotated constructor |
| `fx.ResultTags("...")` | Tag results of an annotated constructor |
| `fx.As(new(I))` | Provide as one or more interfaces |
| `fx.From(types...)` | Bind annotated parameters to specific provided types |

### Lifecycle

| Helper | Purpose |
| --- | --- |
| `fx.Hook{OnStart, OnStop}` | Full hook with context-aware callbacks |
| `fx.StartHook(fn)` | Adapt a simple Start function |
| `fx.StopHook(fn)` | Adapt a simple Stop function |
| `fx.StartStopHook(start, stop)` | Pair of simple Start/Stop functions |
| `fx.StartTimeout(d)`, `fx.StopTimeout(d)` | Override default 15s lifecycle timeouts |
| `fx.ErrorHook(h)` | Intercept lifecycle errors (e.g. failed OnStart) for alerting or cleanup |

### Logging & Testing

| Helper | Purpose |
| --- | --- |
| `fx.WithLogger(fn)` | Plug in a custom `fxevent.Logger` |
| `fx.NopLogger` | Silence fx event logging |
| `fxevent.ZapLogger{Logger: log}` | Bridge fx events into zap |
| `fxevent.SlogLogger{Logger: log}` | Bridge fx events into log/slog |
| `fxtest.New(t, opts...)` | App that fails the test on errors |
| `app.RequireStart()`, `app.RequireStop()` | Start/Stop with `t.Fatal` on failure |
| `fxtest.NewLifecycle(t)` | Standalone lifecycle for unit tests |
