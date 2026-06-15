---
name: golang-dependency-injection
description: "Comprehensive guide for dependency injection (DI) in Golang. Covers why DI matters (testability, loose coupling, separation of concerns, lifecycle management), manual constructor injection, and DI library comparison (google/wire, uber-go/dig, uber-go/fx, samber/do). Use this skill when designing service architecture, setting up dependency injection, refactoring tightly coupled code, managing singletons or service factories, or when the user asks about inversion of control, service containers, or wiring dependencies in Go. For a specific DI library, → See `samber/cc-skills-golang@golang-google-wire`, `samber/cc-skills-golang@golang-uber-dig`, `samber/cc-skills-golang@golang-uber-fx`, or `samber/cc-skills-golang@golang-samber-do` skills."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents, and for projects using Golang.
metadata:
  author: samber
  version: "1.2.1"
  openclaw:
    emoji: "🔌"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
    install: []
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Agent WebFetch mcp__context7__resolve-library-id mcp__context7__query-docs AskUserQuestion
---

**Persona:** You are a Go software architect. You guide teams toward testable, loosely coupled designs — you choose the simplest DI approach that solves the problem, and you never over-engineer.

**Modes:**

- **Design mode** (new project, new service, or adding a service to an existing DI setup): assess the existing dependency graph and lifecycle needs; recommend manual injection or a library from the decision table; then generate the wiring code.
- **Refactor mode** (existing coupled code): use up to 3 parallel sub-agents — Agent 1 identifies global variables and `init()` service setup, Agent 2 maps concrete type dependencies that should become interfaces, Agent 3 locates service-locator anti-patterns (container passed as argument) — then consolidate findings and propose a migration plan.

> **Community default.** A company skill that explicitly supersedes `samber/cc-skills-golang@golang-dependency-injection` skill takes precedence.

# Dependency Injection in Go

Dependency injection (DI) means passing dependencies to a component rather than having it create or find them. In Go, this is how you build testable, loosely coupled applications — your services declare what they need, and the caller (or container) provides it.

This skill is not exhaustive. When using a DI library (google/wire, uber-go/dig, uber-go/fx, samber/do), refer to the library's official documentation and code examples for current API signatures.

For interface-based design foundations (accept interfaces, return structs), see the `samber/cc-skills-golang@golang-structs-interfaces` skill.

## Best Practices Summary

1. Dependencies MUST be injected via constructors — NEVER use global variables or `init()` for service setup
2. Small projects (< 10 services) SHOULD use manual constructor injection — no library needed
3. Interfaces MUST be defined where consumed, not where implemented — accept interfaces, return structs
4. NEVER use global registries or package-level service locators
5. The DI container MUST only exist at the composition root (`main()` or app startup) — NEVER pass the container as a dependency
6. **Prefer lazy initialization** — only create services when first requested
7. **Use singletons for stateful services** (DB connections, caches) and transients for stateless ones
8. **Mock at the interface boundary** — DI makes this trivial
9. **Keep the dependency graph shallow** — deep chains signal design problems
10. **Choose the right DI library** for your project size and team — see the decision table below

## Why Dependency Injection?

| Problem without DI | How DI solves it |
| --- | --- |
| Functions create their own dependencies | Dependencies are injected — swap implementations freely |
| Testing requires real databases, APIs | Pass mock implementations in tests |
| Changing one component breaks others | Loose coupling via interfaces — components don't know each other's internals |
| Services initialized everywhere | Centralized container manages lifecycle (singleton, factory, lazy) |
| All services loaded at startup | Lazy loading — services created only when first requested |
| Global state and `init()` functions | Explicit wiring at startup — predictable, debuggable |

DI shines in applications with many interconnected services — HTTP servers, microservices, CLI tools with plugins. For a small script with 2-3 functions, manual wiring is fine. Don't over-engineer.

## Manual Constructor Injection (No Library)

For small projects, pass dependencies through constructors. See [Manual DI examples](./references/manual-di.md) for a complete application example.

```go
// ✓ Good — explicit dependencies, testable
type UserService struct {
    db     UserStore
    mailer Mailer
    logger *slog.Logger
}

func NewUserService(db UserStore, mailer Mailer, logger *slog.Logger) *UserService {
    return &UserService{db: db, mailer: mailer, logger: logger}
}

// main.go — manual wiring
func main() {
    logger := slog.Default()
    db := postgres.NewUserStore(connStr)
    mailer := smtp.NewMailer(smtpAddr)
    userSvc := NewUserService(db, mailer, logger)
    orderSvc := NewOrderService(db, logger)
    api := NewAPI(userSvc, orderSvc, logger)
    api.ListenAndServe(":8080")
}
```

```go
// ✗ Bad — hardcoded dependencies, untestable
type UserService struct {
    db *sql.DB
}

func NewUserService() *UserService {
    db, _ := sql.Open("postgres", os.Getenv("DATABASE_URL")) // hidden dependency
    return &UserService{db: db}
}
```

Manual DI breaks down when:

- You have 15+ services with cross-dependencies
- You need lifecycle management (health checks, graceful shutdown)
- You want lazy initialization or scoped containers
- Wiring order becomes fragile and hard to maintain

## DI Library Comparison

Go has three main approaches to DI libraries:

- [google/wire examples](./references/google-wire.md) — Compile-time code generation
- [uber-go/dig + fx examples](./references/uber-dig-fx.md) — Reflection-based framework
- [samber/do examples](./references/samber-do.md) — Generics-based, no code generation

### Decision Table

| Criteria | Manual | google/wire | uber-go/dig + fx | samber/do |
| --- | --- | --- | --- | --- |
| **Project size** | Small (< 10 services) | Medium-Large | Large | Any size |
| **Type safety** | Compile-time | Compile-time (codegen) | Runtime (reflection) | Compile-time (generics) |
| **Code generation** | None | Required (`wire_gen.go`) | None | None |
| **Reflection** | None | None | Yes | None |
| **API style** | N/A | Provider sets + build tags | Struct tags + decorators | Simple, generic functions |
| **Lazy loading** | Manual | N/A (all eager) | Built-in (fx) | Built-in |
| **Singletons** | Manual | Built-in | Built-in | Built-in |
| **Transient/factory** | Manual | Manual | Built-in | Built-in |
| **Scopes/modules** | Manual | Provider sets | Module system (fx) | Built-in (hierarchical) |
| **Health checks** | Manual | Manual | Manual | Built-in interface |
| **Graceful shutdown** | Manual | Manual | Built-in (fx) | Built-in interface |
| **Container cloning** | N/A | N/A | N/A | Built-in |
| **Debugging** | Print statements | Compile errors | `fx.Visualize()` | `ExplainInjector()`, web interface |
| **Go version** | Any | Any | Any | 1.18+ (generics) |
| **Learning curve** | None | Medium | High | Low |

### Quick Comparison: Same App, Four Ways

The dependency graph: `Config -> Database -> UserStore -> UserService -> API`

**Manual**:

```go
cfg := NewConfig()
db := NewDatabase(cfg)
store := NewUserStore(db)
svc := NewUserService(store)
api := NewAPI(svc)
api.Run()
// No automatic shutdown, health checks, or lazy loading
```

**google/wire**:

```go
// wire.go — then run: wire ./...
func InitializeAPI() (*API, error) {
    wire.Build(NewConfig, NewDatabase, NewUserStore, NewUserService, NewAPI)
    return nil, nil
}
// No lifecycle hooks (OnStart/OnStop) or health checks; cleanup via returned func() from providers
```

**uber-go/fx**:

```go
app := fx.New(
    fx.Provide(NewConfig, NewDatabase, NewUserStore, NewUserService),
    fx.Invoke(func(api *API) { api.Run() }),
)
app.Run() // manages lifecycle, but reflection-based
```

**samber/do**:

```go
i := do.New()
do.Provide(i, NewConfig)
do.Provide(i, NewDatabase)    // auto shutdown + health check
do.Provide(i, NewUserStore)
do.Provide(i, NewUserService)
api := do.MustInvoke[*API](i)
api.Run()
// defer i.Shutdown() — handles all cleanup automatically
```

## Testing with DI

DI makes testing straightforward — inject mocks instead of real implementations:

```go
// Define a mock
type MockUserStore struct {
    users map[string]*User
}

func (m *MockUserStore) FindByID(ctx context.Context, id string) (*User, error) {
    u, ok := m.users[id]
    if !ok {
        return nil, ErrNotFound
    }
    return u, nil
}

// Test with manual injection
func TestUserService_GetUser(t *testing.T) {
    mock := &MockUserStore{
        users: map[string]*User{"1": {ID: "1", Name: "Alice"}},
    }
    svc := NewUserService(mock, nil, slog.Default())

    user, err := svc.GetUser(context.Background(), "1")
    if err != nil {
        t.Fatalf("unexpected error: %v", err)
    }
    if user.Name != "Alice" {
        t.Errorf("got %q, want %q", user.Name, "Alice")
    }
}
```

### Testing with samber/do — Clone and Override

Container cloning creates an isolated copy where you override only the services you need to mock:

```go
func TestUserService_WithDo(t *testing.T) {
    // Create a test injector with mock implementation
    testInjector := do.New()

    // Provide the mock UserStore interface
    do.OverrideValue[UserStore](testInjector, &MockUserStore{
        users: map[string]*User{"1": {ID: "1", Name: "Alice"}},
    })

    // Provide other real services as needed
    do.Provide[*slog.Logger](testInjector, func(i *do.Injector) (*slog.Logger, error) {
        return slog.Default(), nil
    })

    svc := do.MustInvoke[*UserService](testInjector)
    user, err := svc.GetUser(context.Background(), "1")
    // ... assertions
}
```

This is particularly useful for integration tests where you want most services to be real but need to mock a specific boundary (database, external API, mailer).

## When to Adopt a DI Library

| Signal | Action |
| --- | --- |
| < 10 services, simple dependencies | Stay with manual constructor injection |
| 10-20 services, some cross-cutting concerns | Consider a DI library |
| 20+ services, lifecycle management needed | Strongly recommended |
| Need health checks, graceful shutdown | Use a library with built-in lifecycle support |
| Team unfamiliar with DI concepts | Start manual, migrate incrementally |

## Common Mistakes

| Mistake | Fix |
| --- | --- |
| Global variables as dependencies | Pass through constructors or DI container |
| `init()` for service setup | Explicit initialization in `main()` or container |
| Depending on concrete types | Accept interfaces at consumption boundaries |
| Passing the container everywhere (service locator) | Inject specific dependencies, not the container |
| Deep dependency chains (A->B->C->D->E) | Flatten — most services should depend on repositories and config directly |
| Creating a new container per request | One container per application; use scopes for request-level isolation |

## Cross-References

- → See `samber/cc-skills-golang@golang-samber-do` skill for detailed samber/do usage patterns
- → See `samber/cc-skills-golang@golang-structs-interfaces` skill for interface design and composition
- → See `samber/cc-skills-golang@golang-testing` skill for testing with dependency injection
- → See `samber/cc-skills-golang@golang-project-layout` skill for DI initialization placement

## References

- [samber/do/v2 documentation](https://do.samber.dev) | [github.com/samber/do/v2](https://github.com/samber/do)
- [google/wire user guide](https://github.com/google/wire/blob/main/docs/guide.md)
- [uber-go/fx documentation](https://uber-go.github.io/fx/)
- [uber-go/dig](https://github.com/uber-go/dig)
