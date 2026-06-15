# Testing with uber-go/fx

`go.uber.org/fx/fxtest` integrates fx applications with `*testing.T`: errors fail the test instead of crashing the process, and lifecycle teardown is registered automatically.

## Pulling a value out of the graph with `fx.Populate`

```go
func TestUserService_Create(t *testing.T) {
    var svc *UserService

    app := fxtest.New(t,
        fx.Provide(
            func() Database { return &fakeDatabase{} },
            NewUserService,
        ),
        fx.Populate(&svc),
    )
    defer app.RequireStop()
    app.RequireStart()

    require.NoError(t, svc.Create(context.Background(), "alice@example.com"))
}
```

`fx.Populate(&svc)` fills `svc` with the value the graph would resolve. It replaces ad-hoc `fx.Invoke(func(s *UserService) { svc = s })` patterns.

## `fx.Replace` to swap a real dependency for a fake

```go
func TestServer_HandlesDBError(t *testing.T) {
    var srv *http.Server
    fakeDB := &erroringDatabase{}

    app := fxtest.New(t,
        ProductionModule,                                 // the real wiring
        fx.Replace(fx.Annotate(fakeDB, fx.As(new(Database)))),
        fx.Populate(&srv),
    )
    defer app.RequireStop()
    app.RequireStart()

    // Drive the server with a fake DB
    rec := httptest.NewRecorder()
    req := httptest.NewRequest(http.MethodGet, "/users", nil)
    srv.Handler.ServeHTTP(rec, req)
    require.Equal(t, http.StatusInternalServerError, rec.Code)
}
```

`fx.Replace` works even when the original provider is buried inside a module — it overrides the resolved type without rewriting the module.

## Standalone lifecycle for a unit test

`fxtest.NewLifecycle(t)` gives you an `fx.Lifecycle` outside the `fx.New` machinery, useful for testing a single constructor that registers hooks:

```go
func TestWorker_StartStop(t *testing.T) {
    lc := fxtest.NewLifecycle(t)

    worker := NewWorker(lc, zaptest.NewLogger(t))
    require.NotNil(t, worker)

    lc.RequireStart() // runs OnStart hooks
    require.True(t, worker.IsRunning())

    lc.RequireStop()  // runs OnStop hooks
    require.False(t, worker.IsRunning())
}
```

This is the lightest test for a constructor — no full graph, no `fx.New`.

## Asserting wire-time errors

```go
func TestWiring_MissingDependency(t *testing.T) {
    app := fx.New(
        fx.Provide(NewServer), // depends on *sql.DB which is not provided
        fx.NopLogger,
    )
    require.Error(t, app.Err())
    require.Contains(t, app.Err().Error(), "missing type: *sql.DB")
}
```

Use `fx.New` (not `fxtest.New`) when you _expect_ the wiring to fail — `fxtest.New` would call `t.Fatal`.

## Validating the production graph in CI

```go
func TestProductionGraph(t *testing.T) {
    app := fx.New(
        ProductionOptions(), // every fx.Provide / fx.Module the binary uses
        fx.NopLogger,
    )
    require.NoError(t, app.Err())
}
```

`fx.New` validates the type graph without starting. The test fails before deploy on any missing-provider, cycle, or annotation mismatch.

## Test logger that captures fx events

When you want to assert on lifecycle behavior, route fx events into an in-memory observer:

```go
// go.uber.org/zap/zaptest/observer
core, recorded := observer.New(zap.InfoLevel)
log := zap.New(core)

app := fxtest.New(t,
    fx.WithLogger(func() fxevent.Logger {
        return &fxevent.ZapLogger{Logger: log}
    }),
    fx.Provide(NewWorker),
    fx.Invoke(func(*Worker) {}),
)
defer app.RequireStop()
app.RequireStart()

require.NotEmpty(t, recorded.FilterMessage("OnStart hook executed").All())
```

## Testing a lifecycle hook in isolation

If a constructor returns a value _and_ registers a hook, you often want to test both halves:

```go
func TestNewServer_OnStartFailsBindError(t *testing.T) {
    // Bind a port so :0 is unavailable... no, simpler: pre-bind and pass that addr
    listener, err := net.Listen("tcp", "127.0.0.1:0")
    require.NoError(t, err)
    defer listener.Close()
    addr := listener.Addr().String()

    cfg := &Config{Addr: addr}
    lc := fxtest.NewLifecycle(t)

    NewHTTPServer(lc, zaptest.NewLogger(t), cfg)

    // Use Start directly (not RequireStart) so we can assert the error.
    require.Error(t, lc.Start(context.Background()))
}
```
