---
name: golang-uber-fx
description: "Golang application framework using uber-go/fx — fx.New, fx.Provide, fx.Invoke, fx.Module, fx.Lifecycle hooks, fx.Annotate (name/group/As), fx.Decorate, fx.Supply, fx.Replace, fx.WithLogger, and signal-aware Run(). Apply when using or adopting uber-go/fx, when the codebase imports `go.uber.org/fx`, or when wiring services with fx.New. For raw DI without lifecycle, see `samber/cc-skills-golang@golang-uber-dig` skill."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents, and for projects using Golang.
metadata:
  author: samber
  version: "1.1.0"
  openclaw:
    emoji: "🏭"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
    install: []
    skill-library-version: "1.24.0"
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Agent WebFetch mcp__context7__resolve-library-id mcp__context7__query-docs
---

**Persona:** You are a Go architect building a long-running service with fx. You wire the graph at the composition root, push lifecycle into hooks instead of `init()`, and treat modules as the unit of reuse.

# Using uber-go/fx for Application Wiring in Go

Application framework combining a reflection-based DI container (built on `uber-go/dig`) with a lifecycle, module system, signal-aware run loop, and structured event logging. For long-running services where boot order, graceful shutdown, and modular composition matter.

**Official Resources:**

- [pkg.go.dev/go.uber.org/fx](https://pkg.go.dev/go.uber.org/fx)
- [uber-go.github.io/fx](https://uber-go.github.io/fx/)
- [github.com/uber-go/fx](https://github.com/uber-go/fx)

This skill is not exhaustive. Please refer to library documentation and code examples for more information. Context7 can help as a discoverability platform.

```bash
go get go.uber.org/fx
```

## fx vs. dig

fx is built on top of dig and shares the same reflection-based container engine. The DI primitives (`Provide`, `Invoke`, `In`/`Out` structs, named values, value groups) are identical — `fx.In`/`fx.Out` are re-exports of `dig.In`/`dig.Out`.

What fx adds on top:

| Concern | dig | fx |
| --- | --- | --- |
| DI container | ✅ `dig.New()` | ✅ (embedded) |
| Lifecycle hooks | ❌ | ✅ `fx.Lifecycle` OnStart/OnStop |
| Module system | ❌ | ✅ `fx.Module` with scoped decorators |
| Signal-aware run loop | ❌ | ✅ `app.Run()` blocks on SIGINT/SIGTERM |
| Structured event logging | ❌ | ✅ `fx.WithLogger` / `fxevent` |
| Startup/shutdown timeout | ❌ | ✅ `fx.StartTimeout` / `fx.StopTimeout` |

**Choose fx** for long-running services (HTTP servers, workers, daemons) — lifecycle and signal handling are mandatory there, and modules make large service graphs manageable.

**Choose raw dig** when you need wiring without a framework: CLI tools, libraries that expose a container to callers, test harnesses, or embedding DI into an existing app that manages its own lifecycle. See `samber/cc-skills-golang@golang-uber-dig` skill.

## The Application

```go
import "go.uber.org/fx"

app := fx.New(
    fx.Provide(NewLogger, NewDatabase, NewServer),
    fx.Invoke(RegisterRoutes),
)
app.Run() // blocks until SIGINT/SIGTERM, then runs OnStop hooks
```

Boot stages: `fx.New` validates types (constructors do not run); `app.Start(ctx)` runs each `fx.Invoke` and fires OnStart hooks in topological order; main blocks on `app.Done()`; `app.Stop(ctx)` fires OnStop hooks in reverse order. Default timeout is **15 seconds** — override with `fx.StartTimeout` / `fx.StopTimeout`.

## Provide and Invoke

```go
fx.New(
    fx.Provide(NewLogger, NewDatabase, NewServer),  // lazy
    fx.Invoke(RegisterRoutes, StartMetricsExporter), // always run during Start
)
```

`fx.Provide` registers constructors; `fx.Invoke` is the trigger — without an Invoke (directly or transitively) referencing a type, its constructor never runs.

## Lifecycle Hooks

Inject `fx.Lifecycle` and append hooks. Constructors should return quickly; long-running work belongs in `OnStart`.

```go
func NewHTTPServer(lc fx.Lifecycle, log *zap.Logger, cfg *Config) *http.Server {
    srv := &http.Server{Addr: cfg.Addr}

    lc.Append(fx.Hook{
        OnStart: func(ctx context.Context) error {
            ln, err := net.Listen("tcp", srv.Addr)
            if err != nil { return err }
            go srv.Serve(ln)         // blocking work in a goroutine
            return nil
        },
        OnStop: func(ctx context.Context) error {
            return srv.Shutdown(ctx)
        },
    })
    return srv
}
```

Both callbacks receive a context bounded by `StartTimeout`/`StopTimeout` — respect cancellation. **OnStart must return quickly** — spawn a goroutine for blocking work; otherwise startup hangs and dependent hooks never fire.

`fx.StartHook` / `fx.StopHook` / `fx.StartStopHook` adapt simpler signatures (no context, no error, or both):

```go
lc.Append(fx.StartStopHook(srv.Start, srv.Stop))   // matched pair
```

## Parameter and Result Objects

fx re-exports dig's `dig.In` / `dig.Out` as `fx.In` / `fx.Out`. Use them when a constructor has 4+ dependencies, or when you need `name`/`group`/`optional` tags.

```go
type ServerParams struct {
    fx.In

    Logger *zap.Logger
    DB     *sql.DB
    Cache  *redis.Client     `optional:"true"`
    Routes []http.Handler    `group:"routes"`
}

func NewServer(p ServerParams) *Server { /* ... */ }
```

## fx.Annotate

`fx.Annotate` wraps a constructor to add tags or interface bindings without a `fx.Out` struct. Prefer it for ergonomic name/group/As bindings:

```go
fx.Provide(
    fx.Annotate(NewPrimaryDB, fx.ResultTags(`name:"primary"`)),
    fx.Annotate(NewPostgresDB, fx.As(new(Database))),    // expose interface
    fx.Annotate(NewUserHandler,
        fx.As(new(http.Handler)),
        fx.ResultTags(`group:"routes"`),
    ),
)
```

## Value Groups

Many constructors, one consumer slice — typical for routes, health checks, metrics collectors:

```go
type RouteResult struct {
    fx.Out
    Handler http.Handler `group:"routes"`
}

type ServerParams struct {
    fx.In
    Routes []http.Handler `group:"routes"`
}
```

Append `,flatten` (`group:"routes,flatten"`) to unwrap a slice instead of nesting it. Order is **not guaranteed** — provide an explicit ordered slice when sequence matters.

## fx.Module

`fx.Module` groups providers, invokes, and decorators under a name. Modules **scope decorators** to themselves and their children — a logger renamed in `fx.Module("db", ...)` only appears renamed for code inside that module.

```go
var DatabaseModule = fx.Module("database",
    fx.Provide(NewConnection, NewUserRepository),
    fx.Decorate(func(log *zap.Logger) *zap.Logger {
        return log.Named("db")
    }),
)

func main() {
    fx.New(
        fx.Provide(NewConfig, NewLogger),
        DatabaseModule,
        HTTPModule,
    ).Run()
}
```

Treat each module as a small library that can be lifted into another app — its public surface is the types it Provides.

For `fx.Supply`/`fx.Replace`/`fx.Decorate`, optional deps, custom logging, manual lifecycle, and Quick Reference, see [advanced.md](./references/advanced.md).

## Best Practices

1. Keep `main()` thin — providers, modules, and a single `Run()`. Push real work into modules so each can be tested in isolation.
2. Use lifecycle hooks instead of `init()` or goroutines launched from constructors — Start/Stop ordering depends on graph topology, but `init()` goroutines do not, which leads to races and leaks.
3. OnStart must return promptly — long work goes in a goroutine inside the hook. A blocking OnStart hangs the rest of the boot.
4. Respect `ctx.Done()` in hooks — a hook that ignores cancellation is reported as a timeout failure but its goroutine continues, leaking resources.
5. Group by module, not by layer — a module owns the providers, lifecycle, and decorators for one concern (HTTP, DB, metrics).
6. Use `fx.Annotate` for tags rather than wrapping a constructor in an `fx.Out` struct — keeps the constructor reusable outside fx.
7. Replace `fx.Provide` with `fx.Supply` for pre-built values (config, command-line flags). Shorter, signals intent.
8. Validate the graph in CI by booting under `fx.New(...).Err()` — catches missing providers and cycles before deploy.

## Common Mistakes

| Mistake | Fix |
| --- | --- |
| Long-running work directly in OnStart | Spawn a goroutine inside OnStart; the hook itself must return quickly so dependent hooks can run. |
| `fx.Provide` something that should be `fx.Supply` | Pre-built values (config, secrets) belong in `fx.Supply` — clearer and avoids a no-op constructor. |
| Module decorator leaking to siblings | Decorate inside `fx.Module(...)` — decorators flow only to descendants. A top-level `fx.Decorate` is global. |
| Group order assumed | Groups are unordered. If order matters, provide an ordered slice from one constructor. |
| Constructors with side effects | Side effects belong in OnStart — constructors should be cheap and pure-ish, since they may run concurrently and lazily. |
| Forgotten `fx.Invoke` | Without an Invoke (or downstream consumer), constructors never run. Add at least one Invoke per app. |

## Testing

Use `go.uber.org/fx/fxtest` to integrate fx with `*testing.T` (failures call `t.Fatal`, `RequireStop` registers as `t.Cleanup`). `fx.Populate(&target)` pulls values out of the graph; `fx.Replace` swaps real dependencies for fakes. Full patterns in [testing.md](./references/testing.md).

## Further Reading

- [advanced.md](./references/advanced.md) — Supply/Replace/Decorate, optional deps, custom event logging, manual lifecycle, full Quick Reference
- [recipes.md](./references/recipes.md) — full HTTP service with database/metrics, background workers with graceful drain, multiple impls of the same interface, manual lifecycle for CLI embedding
- [testing.md](./references/testing.md) — fxtest patterns, `fx.Replace`, `fx.Populate`, isolated lifecycle tests, CI graph validation

## Cross-References

- → See `samber/cc-skills-golang@golang-uber-dig` skill for the underlying container, `dig.In`/`dig.Out`, and DI without lifecycle
- → See `samber/cc-skills-golang@golang-dependency-injection` skill for DI concepts and library comparison
- → See `samber/cc-skills-golang@golang-samber-do` skill for a generics-based alternative without reflection
- → See `samber/cc-skills-golang@golang-google-wire` skill for compile-time DI (no runtime container)
- → See `samber/cc-skills-golang@golang-structs-interfaces` skill for interface design patterns
- → See `samber/cc-skills-golang@golang-context` skill for context propagation in OnStart/OnStop hooks
- → See `samber/cc-skills-golang@golang-testing` skill for general testing patterns

If you encounter a bug or unexpected behavior in uber-go/fx, open an issue at <https://github.com/uber-go/fx/issues>.
