---
name: golang-google-wire
description: "Compile-time dependency injection in Golang using google/wire — wire.NewSet, wire.Build, wire.Bind (interface→concrete), wire.Struct, wire.Value, wire.InterfaceValue, wire.FieldsOf, cleanup functions, //go:build wireinject injector files, and generated wire_gen.go. Apply when using or adopting google/wire, when the codebase imports `github.com/google/wire`, or when wiring an application graph at compile time via `wire.Build`. For runtime DI with reflection, see `samber/cc-skills-golang@golang-uber-dig` skill."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents, and for projects using Golang.
metadata:
  author: samber
  version: "1.0.3"
  openclaw:
    emoji: "🪡"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
        - wire
    install:
      - kind: go
        package: github.com/google/wire/cmd/wire@latest
        bins: [wire]
    skill-library-version: "0.7.0"
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Agent WebFetch mcp__context7__resolve-library-id mcp__context7__query-docs Bash(wire:*)
---

**Persona:** You are a Go architect using wire for compile-time DI. You let the compiler catch missing dependencies, treat `wire_gen.go` as committed source, and re-run `wire ./...` after every graph change.

**Dependencies:**

- wire: `go install github.com/google/wire/cmd/wire@latest`

# Using google/wire for Compile-Time Dependency Injection in Go

Code-generation DI toolkit. Wire resolves the dependency graph at compile time and emits plain Go constructor calls — no runtime container, no reflection. Errors appear when you run `wire ./...`, not at first request.

Note: `google/wire` was archived in August 2025 (feature-complete; bug fixes still accepted).

**Official Resources:** [pkg.go.dev](https://pkg.go.dev/github.com/google/wire) · [github.com/google/wire](https://github.com/google/wire) · [User Guide](https://github.com/google/wire/blob/main/docs/guide.md) · [Best Practices](https://github.com/google/wire/blob/main/docs/best-practices.md)

This skill is not exhaustive. Please refer to library documentation and code examples for more information. Context7 can help as a discoverability platform.

```bash
go get -tool github.com/google/wire/cmd/wire@latest
go get github.com/google/wire
```

## wire vs. Runtime DI

| Concern           | wire                      | dig / fx / samber/do   |
| ----------------- | ------------------------- | ---------------------- |
| Resolution        | Compile time (codegen)    | Runtime (reflection)   |
| Error detection   | `wire ./...` fails        | First `Invoke`/startup |
| Runtime container | None — plain Go calls     | Present                |
| Lifecycle hooks   | Not built in              | fx: OnStart/OnStop     |
| Generated files   | `wire_gen.go` (committed) | None                   |

For lifecycle, lazy loading, and a full matrix see `samber/cc-skills-golang@golang-dependency-injection`.

## Providers

A provider is any Go function — inputs are dependencies, outputs are provided types. Three return forms:

```go
func NewConfig() *Config                          { return &Config{Addr: ":8080"} }
func NewDB(cfg *Config) (*sql.DB, error)          { return sql.Open("postgres", cfg.DSN) }
func NewRedis(cfg *Config) (*redis.Client, func(), error) { // cleanup chained in reverse order
    c := redis.NewClient(&redis.Options{Addr: cfg.RedisAddr})
    return c, func() { c.Close() }, nil
}
```

## Provider Sets

`wire.NewSet` groups providers for reuse. Sets can reference other sets.

```go
// infra/wire.go
var InfraSet = wire.NewSet(
    NewConfig,
    NewDB,
    NewRedis,
)

// service/wire.go
var ServiceSet = wire.NewSet(
    NewUserRepo,
    NewUserService,
    wire.Bind(new(UserStore), new(*UserRepo)), // interface binding
)
```

Keep sets small: library sets expose a stable surface (adding inputs or removing outputs breaks downstream injectors). One set per package is a useful default.

## Injectors and `//go:build wireinject`

The injector file declares the initialization function. Wire generates its body into `wire_gen.go` and replaces the stub.

```go
//go:build wireinject

package main

import "github.com/google/wire"

// Wire generates the body of this function.
func InitApp() (*App, func(), error) {
    wire.Build(InfraSet, ServiceSet, NewApp)
    return nil, nil, nil // replaced by codegen
}
```

The `//go:build wireinject` tag prevents the stub from being compiled into the binary — only `wire_gen.go` (which has no such tag) makes it through `go build`. Without this tag, both files define the same function, causing a compile error.

Alternative syntax when a dummy return is inconvenient:

```go
func InitApp() (*App, func(), error) {
    panic(wire.Build(InfraSet, ServiceSet, NewApp))
}
```

## Interface Bindings

Wire forbids implicit interface satisfaction — you must declare bindings explicitly so the graph is unambiguous when multiple types implement the same interface.

```go
var Set = wire.NewSet(
    NewPostgresUserRepo,
    wire.Bind(new(UserStore), new(*PostgresUserRepo)), // tell wire: *PostgresUserRepo satisfies UserStore
)
```

Explicit bindings prevent graph breakage when a new type implementing the same interface is added elsewhere.

## Struct Providers and Values

`wire.Struct` fills struct fields from the graph without a manual constructor. Tag fields `wire:"-"` to exclude them.

```go
wire.Struct(new(Server), "Logger", "DB") // inject named fields
wire.Struct(new(Server), "*")            // inject all non-excluded fields
wire.Value(Foo{X: 42})                   // constant expression (no fn calls / channels)
wire.InterfaceValue(new(io.Reader), os.Stdin) // interface-typed literal
wire.FieldsOf(new(Config), "DSN", "Addr")    // promote struct fields as graph nodes
```

See [advanced.md](references/advanced.md) for the `wire:"-"` exclusion tag and `wire.FieldsOf` details.

## Disambiguating Duplicate Types

Wire forbids two providers for the same type. Wrap the underlying type in distinct named types so each has exactly one provider:

```go
type PrimaryDSN string
type ReplicaDSN string
```

## Full Application Example

```go
// wire.go — injector, excluded from binary via build tag
//go:build wireinject

package main

func InitApp() (*App, func(), error) {
    wire.Build(config.ConfigSet, infra.InfraSet, service.ServiceSet, NewApp)
    return nil, nil, nil
}

// main.go
func main() {
    app, cleanup, err := InitApp()
    if err != nil { log.Fatal(err) }
    defer cleanup()
    app.Run()
}
```

Wire generates `wire_gen.go` (plain Go, committed, DO NOT EDIT). For a full example with per-package sets, cleanup-heavy graphs, and generated output, see [recipes.md](references/recipes.md).

## Codegen Workflow

```bash
wire ./...           # regenerate all injectors in the module
wire check ./...     # validate graph without regenerating (fast CI check)
```

Run `wire ./...` after every constructor signature change. Add `//go:generate go run github.com/google/wire/cmd/wire` to injector files so `go generate ./...` also works. Commit `wire_gen.go` — it must stay in sync for CI builds.

## Best Practices

1. Never edit `wire_gen.go` — it is overwritten on every `wire ./...` run. Treat it as a build artifact that happens to be committed; source of truth is the provider and injector files.
2. Always add `//go:build wireinject` to injector files — omitting it causes duplicate-symbol compile errors because both the stub and the generated file define the same function.
3. Use named types to distinguish values of the same underlying type — wire enforces one provider per type; named types like `type DSN string` let you have `PrimaryDSN` and `ReplicaDSN` coexist.
4. Keep library provider sets minimal and backward-compatible — adding new required inputs breaks downstream injectors; removing outputs does too. Introduce only newly-created types in the same release.
5. Return `(T, func(), error)` from cleanup providers and let wire chain them — wire generates the correct reverse-order cleanup and handles partial failures (if construction fails midway, only already-built cleanups run).
6. Keep injector files focused — one function per file, one package import at a time. Fat injectors with dozens of `wire.Build` arguments are hard to reason about; delegate to per-package sets.

## Common Mistakes

| Mistake | Fix |
| --- | --- |
| Editing `wire_gen.go` manually | Never edit it. Change providers or injectors and re-run `wire ./...`. |
| Missing `//go:build wireinject` | Add the tag as the very first line of every injector file. |
| Two providers returning `*sql.DB` | Wrap with a named struct type: `type PrimaryDB struct { *sql.DB }` — Wire does not distinguish pointer type aliases. |
| Injecting an interface without `wire.Bind` | Add `wire.Bind(new(MyInterface), new(*MyImpl))` to the provider set. |
| Forgetting to re-run `wire ./...` after changes | Run wire before `go build`; add it to `go generate` or a Makefile target. |
| Calling `cleanup()` without guarding for nil | Wire returns nil cleanup on construction error; guard with `if cleanup != nil { defer cleanup() }`. |

## Testing

Wire generates plain Go constructors, so unit tests use manual injection — no container to clone or reset. For testing patterns (test injectors swapping real providers for fakes, CI stale-check for `wire_gen.go`), see [testing.md](references/testing.md).

## Further Reading

- [advanced.md](references/advanced.md) — cleanup chains, multiple injectors, set nesting, error catalogue, codegen flags, quick reference
- [recipes.md](references/recipes.md) — HTTP server, multi-injector build, cleanup-heavy graph, CLI embedding
- [testing.md](references/testing.md) — test injectors, fake bindings, CI stale check

## Cross-References

- → See `samber/cc-skills-golang@golang-dependency-injection` skill for DI concepts and library comparison
- → See `samber/cc-skills-golang@golang-uber-dig` skill for runtime reflection-based DI without lifecycle
- → See `samber/cc-skills-golang@golang-uber-fx` skill for runtime DI with lifecycle hooks, modules, and signal-aware Run()
- → See `samber/cc-skills-golang@golang-samber-do` skill for generics-based DI without reflection
- → See `samber/cc-skills-golang@golang-structs-interfaces` skill for interface design patterns
- → See `samber/cc-skills-golang@golang-testing` skill for general testing patterns

If you encounter a bug or unexpected behavior in google/wire, open an issue at <https://github.com/google/wire/issues>.
