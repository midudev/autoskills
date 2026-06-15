# Advanced — google/wire

Detail topics referenced from `SKILL.md`. Each section is self-contained.

## Cleanup Chains

When a provider returns `(T, func(), error)`, Wire adds the cleanup to a chain. The generated injector runs cleanups in **reverse construction order**: the last-built dependant is cleaned up first, ensuring dependants are torn down before their dependencies.

```go
// Provider with cleanup
func NewDB(cfg *Config) (*sql.DB, func(), error) {
    db, err := sql.Open("postgres", string(cfg.DSN))
    if err != nil { return nil, nil, err }
    return db, func() { db.Close() }, nil
}

func NewCache(cfg *Config) (*redis.Client, func(), error) {
    c := redis.NewClient(&redis.Options{Addr: cfg.CacheAddr})
    return c, func() { c.Close() }, nil
}
```

Wire generates something like:

```go
func InitApp() (*App, func(), error) {
    cfg := NewConfig()
    db, dbCleanup, err := NewDB(cfg)
    if err != nil { return nil, nil, err }
    cache, cacheCleanup, err := NewCache(cfg)
    if err != nil {
        dbCleanup()  // already-built cleanups run on partial failure
        return nil, nil, err
    }
    app := NewApp(db, cache)
    return app, func() {
        cacheCleanup()  // reverse order
        dbCleanup()
    }, nil
}
```

**Caller pattern** — guard against nil cleanup on construction failure:

```go
app, cleanup, err := InitApp()
if err != nil { log.Fatal(err) }
defer cleanup()
```

Wire always returns a non-nil cleanup function when construction succeeds. If construction fails midway, the returned `cleanup` is nil — guard before calling.

## Multiple Injectors in One Package

A package can contain multiple injector functions. Each must live in a file with `//go:build wireinject`. All generated functions land in `wire_gen.go` in the same package.

```go
//go:build wireinject

package main

// Production injector
func InitProdApp() (*App, func(), error) {
    wire.Build(ProdSet, NewApp)
    return nil, nil, nil
}

// Development injector with debug providers
func InitDevApp() (*App, func(), error) {
    wire.Build(DevSet, NewApp)
    return nil, nil, nil
}
```

Select at runtime with a flag, or at build time with separate `//go:build prod` / `//go:build !prod` constraints on the injector files.

## wire.NewSet Nesting Strategies

Sets can contain other sets, building a hierarchy that mirrors your package structure.

```go
// pkg/config/wire.go
var ConfigSet = wire.NewSet(NewConfig)

// pkg/infra/wire.go
var InfraSet = wire.NewSet(
    config.ConfigSet, // embed upstream set
    NewDB,
    NewCache,
)

// pkg/service/wire.go
var ServiceSet = wire.NewSet(
    NewUserService,
    wire.Bind(new(UserStore), new(*UserRepo)),
)

// wire.go (injector)
wire.Build(infra.InfraSet, service.ServiceSet, NewApp)
```

**Library set stability rules** (from upstream best practices):

- Safe: replace one provider with another that has the same or fewer inputs, in the same release.
- Safe: introduce a brand-new output type not previously provided.
- Breaking: add a new required input to a provider — downstream injectors cannot satisfy it.
- Breaking: remove a provided output type — downstream injectors that depend on it fail.
- Breaking: add a type that the injector already provides — Wire reports a duplicate.

## `wire:"-"` Exclusion Tag

Exclude a struct field from `wire.Struct` injection by tagging it:

```go
type Server struct {
    Logger  *zap.Logger
    DB      *sql.DB
    mu      sync.Mutex   `wire:"-"` // unexported — auto-excluded
    Timeout time.Duration `wire:"-"` // exported but opt-out
}

wire.Struct(new(Server), "*") // injects Logger and DB; skips mu and Timeout
```

Unexported fields are always skipped regardless of the tag.

## Common Codegen Errors

| Error message | Root cause | Fix |
| --- | --- | --- |
| `no provider found for TYPE` | A dependency is not provided by any set in `wire.Build` | Add the missing provider or set |
| `multiple bindings for TYPE` | Two providers return the same type | Use named types or remove the duplicate |
| `argument N has no provider for TYPE` | An interface is requested but no `wire.Bind` maps to it | Add `wire.Bind(new(Iface), new(*Impl))` to a set |
| `cycle detected` | A → B → A circular dependency | Break the cycle by introducing an interface or factory |
| `wire.Build used outside of injector function` | `wire.Build` called from a non-injector function | Only call `wire.Build` inside functions with the build tag |
| duplicate symbol / redeclared in this block | Injector file is missing `//go:build wireinject` | Add the build tag as the first line |

## Codegen Flags

```bash
# Specify output file prefix (default: wire_gen)
wire -output_file_prefix=init gen ./cmd/server

# Apply build tags during generation
wire -tags=integration gen ./...

# Prepend a header file (e.g., license comment) to generated output
wire -header_file=hack/boilerplate.go.txt gen ./...
```

## `panic(wire.Build(...))` Alternate Syntax

Wire accepts either a dummy return or a `panic` call as the injector body. The `panic` form avoids writing zero-value returns for complex types:

```go
// Preferred when return types are complex or error-prone to zero-initialize
func InitApp(ctx context.Context) (*App, func(), error) {
    panic(wire.Build(AppSet))
}
```

Wire detects both forms and replaces the body during codegen. The `panic` is never reached in the compiled binary — only the generated `wire_gen.go` version is compiled.

## Accepting External Values as Injector Arguments

When a value is constructed before wire runs (e.g., parsed flags, an `http.Client` from a test), pass it as a parameter to the injector rather than providing it from within the graph:

```go
//go:build wireinject

func InitApp(cfg *Config) (*App, func(), error) {
    wire.Build(InfraSet, ServiceSet, NewApp)
    return nil, nil, nil
}

// main.go
cfg := parseFlags()
app, cleanup, err := InitApp(cfg)
```

Wire treats injector parameters as pre-built providers — they satisfy dependencies without needing a `wire.NewSet` entry.

## Quick Reference

| Symbol | Purpose |
| --- | --- |
| `wire.NewSet(providers...)` | Group providers into a reusable set |
| `wire.Build(sets...)` | Declare injector body (codegen replaces it) |
| `wire.Bind(new(Iface), new(*Concrete))` | Bind interface to concrete type |
| `wire.Struct(new(T), "Field", ...)` | Inject struct fields from the graph |
| `wire.Struct(new(T), "*")` | Inject all non-excluded fields |
| `wire.Value(expr)` | Bind a constant expression (no fn calls/channels) |
| `wire.InterfaceValue(new(I), value)` | Bind a value to an interface type |
| `wire.FieldsOf(new(T), "Field", ...)` | Promote struct fields as individual graph nodes |
| `//go:build wireinject` | Build tag: exclude injector stub from binary |
| `wire_gen.go` | Generated output — commit, never edit |
| `wire ./...` | Regenerate all injectors in the module |
| `wire check ./...` | Validate graph without regenerating |
