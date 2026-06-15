---
name: golang-samber-do
description: "Dependency injection in Golang using samber/do — service containers, lifecycle management, scopes, health checks, graceful shutdown, and module organization. Apply when using or adopting samber/do, when the codebase imports github.com/samber/do or github.com/samber/do/v2, or when refactoring manual constructor injection into a DI container."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents, and for projects using Golang.
metadata:
  author: samber
  version: "1.2.1"
  openclaw:
    emoji: "💉"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
    install: []
    skill-library-version: "2.0.0"
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Agent WebFetch mcp__context7__resolve-library-id mcp__context7__query-docs
---

**Persona:** You are a Go architect setting up dependency injection. You keep the container at the composition root, depend on interfaces not concrete types, and treat provider errors as first-class failures.

# Using samber/do for Dependency Injection in Go

Type-safe dependency injection toolkit for Go based on Go 1.18+ generics.

**Official Resources:**

- [pkg.go.dev/github.com/samber/do/v2](https://pkg.go.dev/github.com/samber/do/v2)
- [do.samber.dev](https://do.samber.dev)
- [github.com/samber/do/v2](https://github.com/samber/do)

This skill is not exhaustive. Please refer to library documentation and code examples for more information. Context7 can help as a discoverability platform.

DO NOT USE v1 OF THIS LIBRARY. INSTALL v2 INSTEAD:

```bash
go get -u github.com/samber/do/v2
```

## Core Concepts

### The Injector (Container)

```go
import "github.com/samber/do/v2"

injector := do.New()
```

### Service Types

- **Lazy** (default): Created when first requested
- **Eager**: Created immediately when the container starts
- **Transient**: New instance created on every request
- **Value**: Pre-created value, no instantiation

### Provider Functions

Services MUST be registered via provider functions:

```go
type Provider[T any] func(i Injector) (T, error)
```

## Basic Usage

### 1. Define and Register Services

Follow "Accept Interfaces, Return Structs":

```go
// Register a service (lazy by default)
do.Provide(injector, func(i do.Injector) (Database, error) {
    return &PostgreSQLDatabase{connString: "postgres://..."}, nil
})

// Register a pre-created value
do.ProvideValue(injector, &Config{Port: 8080})

// Register a transient service (new instance each time)
do.ProvideTransient(injector, func(i do.Injector) (*Logger, error) {
    return &Logger{}, nil
})

// Register an eager service (created immediately at startup)
do.ProvideValue(injector, &Config{Port: 8080})
```

### 2. Invoke Services

The container MUST only be accessed at the composition root:

```go
// Invoke with error handling
db, err := do.Invoke[Database](injector)

// MustInvoke panics on error (use when confident service exists)
db := do.MustInvoke[Database](injector)
```

### 3. Service Dependencies

```go
func NewUserService(i do.Injector) (UserService, error) {
    db := do.MustInvoke[Database](i)
    cache := do.MustInvoke[Cache](i)
    return &userService{db: db, cache: cache}, nil
}

do.Provide(injector, NewUserService)
```

### 4. Implicit Aliasing (Preferred)

Register a concrete type and invoke as an interface without explicit aliasing:

```go
// Register concrete type
do.Provide(injector, func(i do.Injector) (*PostgreSQLDatabase, error) {
    return &PostgreSQLDatabase{}, nil
})

// Invoke directly as interface (implicit aliasing)
db := do.MustInvokeAs[Database](injector)
```

### 5. Named Services

Register multiple services of the same type:

```go
do.ProvideNamed(injector, "primary-db", func(i do.Injector) (*Database, error) {
    return &Database{URL: "postgres://primary..."}, nil
})

mainDB := do.MustInvokeNamed[*Database](injector, "primary-db")
```

## Package Organization

Use `do.Package()` to organize service registration by module:

```go
// infrastructure/package.go
var Package = do.Package(
    do.Lazy(func(i do.Injector) (*postgres.DB, error) {
        cfg := do.MustInvoke[*Config](i)
        return postgres.Connect(cfg.DatabaseURL)
    }),
    do.Lazy(func(i do.Injector) (*redis.Client, error) {
        cfg := do.MustInvoke[*Config](i)
        return redis.NewClient(cfg.RedisURL), nil
    }),
)

// main.go
injector := do.New(infrastructure.Package, service.Package)
```

## Full Application Setup

```go
func main() {
    injector := do.New(
        infrastructure.Package,
        repository.Package,
        service.Package,
        transport.Package,
    )

    server := do.MustInvoke[*http.Server](injector)
    go server.ListenAndServe()

    _ = injector.ShutdownOnSignalsWithContext(context.Background(), os.Interrupt)
}
```

## Best Practices

1. Depend on interfaces, not concrete types — lets you swap implementations in tests without touching production code
2. Each service should have one job — services with multiple responsibilities are harder to test and harder to replace
3. Keep dependency trees shallow — chains beyond 3-4 levels make initialization order fragile and errors harder to trace
4. Handle errors in provider functions — a silently failing provider creates a broken service that crashes later in unexpected places
5. Use scopes to organize services by lifecycle — request-scoped services prevent leaks, global services prevent redundant initialization

For scopes, lifecycle management, struct injection, and debugging, see [Advanced Usage](./references/advanced.md).

For testing patterns (cloning, overrides, mocks), see [Testing](./references/testing.md).

## Quick Reference

### Registration

| Function                        | Purpose                          |
| ------------------------------- | -------------------------------- |
| `do.Provide[T]()`               | Register lazy service (default)  |
| `do.ProvideNamed[T]()`          | Register named lazy service      |
| `do.ProvideValue[T]()`          | Register pre-created value       |
| `do.ProvideNamedValue[T]()`     | Register named value             |
| `do.ProvideTransient[T]()`      | Register new instance each time  |
| `do.ProvideNamedTransient[T]()` | Register named transient service |
| `do.Package()`                  | Group service registrations      |

### Invocation

| Function                   | Purpose                                   |
| -------------------------- | ----------------------------------------- |
| `do.Invoke[T]()`           | Get service (with error)                  |
| `do.InvokeNamed[T]()`      | Get named service                         |
| `do.InvokeAs[T]()`         | Get first service matching interface      |
| `do.InvokeStruct[T]()`     | Inject into struct fields using tags      |
| `do.MustInvoke[T]()`       | Get service (panic on error)              |
| `do.MustInvokeNamed[T]()`  | Get named service (panic on error)        |
| `do.MustInvokeAs[T]()`     | Get service by interface (panic on error) |
| `do.MustInvokeStruct[T]()` | Inject into struct (panic on error)       |

## Cross-References

- → See `samber/cc-skills-golang@golang-dependency-injection` skill for DI concepts, comparison, and when to adopt a DI library
- → See `samber/cc-skills-golang@golang-structs-interfaces` skill for interface design patterns
- → See `samber/cc-skills-golang@golang-testing` skill for general testing patterns
