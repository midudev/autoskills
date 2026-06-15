---
name: golang-uber-dig
description: "Implements dependency injection in Golang using uber-go/dig — reflection-based container, Provide/Invoke, dig.In/dig.Out parameter and result objects, named values, value groups, optional dependencies, scopes, and Decorate. Apply when using or adopting uber-go/dig, when the codebase imports `go.uber.org/dig`, or when wiring an application graph at startup. For higher-level lifecycle and modules, see `samber/cc-skills-golang@golang-uber-fx` skill."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents, and for projects using Golang.
metadata:
  author: samber
  version: "1.1.0"
  openclaw:
    emoji: "⛏"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
    install: []
    skill-library-version: "1.19.0"
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Agent WebFetch mcp__context7__resolve-library-id mcp__context7__query-docs
---

**Persona:** You are a Go architect wiring an application graph with dig. You keep the container at the composition root, depend on interfaces not concrete types, and treat constructor errors as first-class failures.

# Using uber-go/dig for Dependency Injection in Go

Reflection-based DI toolkit, designed to power application frameworks (it is the engine behind `uber-go/fx`) and resolve object graphs during startup.

**Official Resources:**

- [pkg.go.dev/go.uber.org/dig](https://pkg.go.dev/go.uber.org/dig)
- [github.com/uber-go/dig](https://github.com/uber-go/dig)

This skill is not exhaustive. Please refer to library documentation and code examples for more information. Context7 can help as a discoverability platform.

```bash
go get go.uber.org/dig
```

## dig vs. fx

fx is built on dig and shares the same container engine — the DI primitives (`Provide`, `Invoke`, `In`/`Out` structs, named values, value groups) are identical. `fx.In`/`fx.Out` are re-exports of `dig.In`/`dig.Out`.

What fx adds on top of dig:

| Concern | dig | fx |
| --- | --- | --- |
| DI container | ✅ `dig.New()` | ✅ (embedded) |
| Lifecycle hooks | ❌ | ✅ `fx.Lifecycle` OnStart/OnStop |
| Module system | ❌ | ✅ `fx.Module` with scoped decorators |
| Signal-aware run loop | ❌ | ✅ `app.Run()` blocks on SIGINT/SIGTERM |
| Structured event logging | ❌ | ✅ `fx.WithLogger` / `fxevent` |
| Startup/shutdown timeout | ❌ | ✅ `fx.StartTimeout` / `fx.StopTimeout` |

**Choose dig** when you need the wiring graph only: CLI tools, libraries exposing a container to callers, test harnesses, or embedding DI into an existing app that manages its own lifecycle.

**Choose fx** for long-running services (HTTP servers, workers, daemons) — lifecycle and signal handling are non-negotiable there. See `samber/cc-skills-golang@golang-uber-fx` skill.

## Container

```go
import "go.uber.org/dig"

c := dig.New()
```

Useful options: `dig.DeferAcyclicVerification()` (faster startup), `dig.RecoverFromPanics()` (turn panics into `dig.PanicError`), `dig.DryRun(true)` (validate without invoking).

## Provide and Invoke

```go
// Register a constructor — lazy, only runs when its output is needed
err := c.Provide(func(cfg *Config) (*sql.DB, error) {
    return sql.Open("postgres", cfg.DSN)
})

// Pull a service out of the container by asking for it as a function parameter
err = c.Invoke(func(db *sql.DB) error {
    return db.Ping()
})
```

Constructors are **lazy** and **memoized**: each output type is built once and shared (singleton per container). `Provide` errors at registration if the constructor is malformed; `Invoke` returns the constructor's error wrapped with the dependency path that triggered it.

A dig constructor is any function. Inputs are dependencies, outputs are provided types. `error` (last return) signals construction failure. Follow "accept interfaces, return structs".

## Parameter Objects with `dig.In`

Once a constructor has 4+ dependencies, embed `dig.In` to group them as struct fields and tag fields:

```go
type HandlerParams struct {
    dig.In

    Logger *zap.Logger
    DB     *sql.DB
    Cache  *redis.Client `optional:"true"`           // zero value if not provided
    DBRO   *sql.DB       `name:"readonly"`           // named dependency
    Routes []http.Handler `group:"routes"`           // value group
}

func NewHandler(p HandlerParams) *Handler { /* ... */ }
```

Tags: `name:"..."`, `optional:"true"`, `group:"..."`.

## Result Objects with `dig.Out`

Return several values from one constructor and attach `name`/`group` tags to results:

```go
type ConnResult struct {
    dig.Out

    ReadWrite *sql.DB `name:"primary"`
    ReadOnly  *sql.DB `name:"readonly"`
}

func NewConnections(cfg *Config) (ConnResult, error) { /* ... */ }
```

## Named Values

Two providers of the same type collide. Disambiguate with `dig.Name`:

```go
c.Provide(NewPrimaryDB,  dig.Name("primary"))
c.Provide(NewReadOnlyDB, dig.Name("readonly"))
```

Consume by adding `name:"primary"` / `name:"readonly"` to a `dig.In` field.

## Value Groups

Many providers, one consumer slice — typical for HTTP handlers, health checks, migrations:

```go
type RouteResult struct {
    dig.Out
    Handler http.Handler `group:"routes"`
}

func NewUserHandler(db *sql.DB) RouteResult { /* ... */ }
func NewPostHandler(db *sql.DB) RouteResult { /* ... */ }

type ServerParams struct {
    dig.In
    Routes []http.Handler `group:"routes"`
}
```

**Flatten** — append `,flatten` (e.g. `group:"routes,flatten"`) to unwrap a slice instead of nesting it. Group order is **not guaranteed**; if order matters, provide an explicit ordered slice from a single constructor.

## Provide as Interface (`dig.As`)

Register a concrete constructor and expose it under one or more interfaces without a separate adapter:

```go
c.Provide(NewPostgresDB, dig.As(new(Database), new(io.Closer)))
// Consumers ask for Database or io.Closer; *PostgresDB stays hidden.
```

## Full Application Example

```go
func main() {
    c := dig.New()

    must(c.Provide(NewConfig))
    must(c.Provide(NewLogger))
    must(c.Provide(NewDatabase))
    must(c.Provide(NewServer))

    err := c.Invoke(func(srv *http.Server) error {
        return srv.ListenAndServe()
    })
    if err != nil {
        log.Fatal(err)
    }
}

func must(err error) { if err != nil { panic(err) } }
```

dig has **no built-in lifecycle**. If you need OnStart/OnStop hooks, signal handling, and graceful shutdown, use fx — see `samber/cc-skills-golang@golang-uber-fx` skill.

For Decorate, Scopes, optional deps, error helpers, and Visualize, see [advanced.md](./references/advanced.md).

## Best Practices

1. Keep the container at the composition root — never pass `*dig.Container` as a parameter; treat it like a plumbing detail of `main()`. Service-locator patterns defeat the testability gains of DI.
2. Depend on interfaces, not concrete types — lets you swap implementations in tests without touching production code, and lets you use `dig.As` to expose narrow interfaces from wide structs.
3. Prefer parameter objects (`dig.In` structs) once a constructor has 4+ dependencies — call sites stay readable and adding a new dependency is a one-line change instead of a signature break.
4. Group registration by module (one file per module that calls `c.Provide` for its types) — review and refactoring become a per-module concern, and you can extract a module into a fx.Module later without rewriting wiring.
5. Validate the graph eagerly in tests — call `c.Invoke` against the composition root in CI to surface missing providers at boot time, not at first request. `DryRun(true)` skips constructor execution.
6. Return errors from constructors instead of panicking — dig wraps them with the dependency path, which makes the failure point obvious.

## Common Mistakes

| Mistake | Fix |
| --- | --- |
| Passing the container into services | The container belongs to `main()`. Inject the typed dependencies a service needs; otherwise tests need to build a real container. |
| Two providers for the same type without `Name` | dig errors at `Provide` time. Either name them, or merge into a single provider that returns a `dig.Out` result struct. |
| Ignoring `Provide` errors | Wrap each `Provide` with a `must` helper. A silent registration error becomes a missing-type error far later. |
| Using groups when ordering matters | Groups are unordered. If order matters (middleware chain, migration sequence), provide an explicit ordered slice with one constructor. |
| Constructors with side effects on import | Keep `init()` empty — start work only inside the constructor, after the graph is built. |

## Testing

dig containers are cheap — build a fresh one per test, override providers with `Decorate`, and call `Invoke` to drive the system. For full patterns (per-test wiring, shared helpers, graph validation in CI, asserting wire-time errors, recovering from constructor panics), see [testing.md](./references/testing.md).

## Further Reading

- [advanced.md](./references/advanced.md) — Decorate, Scopes, optional deps, error helpers, Visualize, full Quick Reference
- [recipes.md](./references/recipes.md) — end-to-end examples: HTTP server with route group, two databases, request scopes, decorators, dry-run validation
- [testing.md](./references/testing.md) — testing patterns and graph validation

## Cross-References

- → See `samber/cc-skills-golang@golang-uber-fx` skill for application lifecycle, modules, and signal-aware Run() built on top of dig
- → See `samber/cc-skills-golang@golang-dependency-injection` skill for DI concepts and library comparison
- → See `samber/cc-skills-golang@golang-samber-do` skill for a generics-based alternative without reflection
- → See `samber/cc-skills-golang@golang-google-wire` skill for compile-time DI (no runtime container)
- → See `samber/cc-skills-golang@golang-structs-interfaces` skill for interface design patterns
- → See `samber/cc-skills-golang@golang-testing` skill for general testing patterns

If you encounter a bug or unexpected behavior in uber-go/dig, open an issue at <https://github.com/uber-go/dig/issues>.
