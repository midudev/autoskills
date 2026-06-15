# uber-go/dig + uber-go/fx — Reflection-Based DI

`dig` is the low-level DI container; `fx` is the full application framework built on top. Powerful but uses reflection — errors appear at startup, not compile time.

- Docs: [github.com/uber-go/dig](https://github.com/uber-go/dig) | [uber-go.github.io/fx](https://uber-go.github.io/fx/)

Before writing dig/fx code, refer to the library's official documentation for up-to-date API signatures and examples.

## dig — Basic Container

```go
func main() {
    container := dig.New()

    container.Provide(NewConfig)
    container.Provide(NewDatabase)
    container.Provide(NewUserStore)
    container.Provide(NewUserService)

    // Invoke — dig resolves the full dependency chain
    err := container.Invoke(func(svc *UserService) {
        svc.Run()
    })
    if err != nil {
        log.Fatal(err)
    }
}
```

### Named Dependencies

```go
type DatabaseParams struct {
    dig.In

    Primary *sql.DB `name:"primary"`
    Replica *sql.DB `name:"replica"`
}

container.Provide(NewPrimaryDB, dig.Name("primary"))
container.Provide(NewReplicaDB, dig.Name("replica"))

container.Provide(func(p DatabaseParams) *UserService {
    return &UserService{
        writer: p.Primary,
        reader: p.Replica,
    }
})
```

### dig Tradeoffs

- Uses reflection — type mismatches are runtime errors, not compile errors
- `dig.In` and `dig.Out` structs add boilerplate for complex graphs
- No built-in lifecycle management
- Powerful grouping with `dig.Group` for collecting multiple implementations

## fx — Full Application Framework

### Basic Application

```go
func main() {
    app := fx.New(
        fx.Provide(
            NewConfig,
            NewDatabase,
            NewUserStore,
            NewUserService,
        ),
        fx.Invoke(RegisterRoutes),
        fx.Invoke(StartServer),
    )

    app.Run() // blocks until signal, then calls shutdown hooks
}
```

### Lifecycle Hooks

```go
func NewDatabase(lc fx.Lifecycle, cfg *Config) (*Database, error) {
    db := &Database{}

    lc.Append(fx.Hook{
        OnStart: func(ctx context.Context) error {
            return db.Connect(cfg.URL)
        },
        OnStop: func(ctx context.Context) error {
            return db.Close()
        },
    })

    return db, nil
}
```

### Modules

```go
var InfraModule = fx.Module("infra",
    fx.Provide(NewConfig),
    fx.Provide(NewDatabase),
    fx.Provide(NewCache),
)

var ServiceModule = fx.Module("service",
    fx.Provide(NewUserService),
    fx.Provide(NewOrderService),
)

app := fx.New(InfraModule, ServiceModule, fx.Invoke(StartServer))
```

### Testing with fx

```go
func TestUserService(t *testing.T) {
    var svc *UserService

    app := fxtest.New(t,
        fx.Provide(NewMockUserStore),
        fx.Provide(NewUserService),
        fx.Populate(&svc),
    )
    app.RequireStart()
    defer app.RequireStop()

    // ... test svc
}
```

### fx Tradeoffs

- Full application framework — manages startup, shutdown, and signal handling
- Reflection-based — errors at startup, not compile time
- Steep learning curve — `fx.In`, `fx.Out`, `fx.Annotate`, `fx.Decorate`
- Built-in lifecycle (OnStart/OnStop hooks)
- Heavyweight — pulls in the full fx framework
- `fxtest` package for testing, but requires starting/stopping the app

fx lifecycle hooks MUST be used for start/stop — register `OnStart`/`OnStop` via `fx.Lifecycle`. fx modules SHOULD group related providers — use `fx.Module` to organize by domain.
