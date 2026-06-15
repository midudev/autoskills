# Recipes — google/wire

End-to-end examples. Each recipe is self-contained.

## HTTP Server with Postgres and Redis

A typical service: parsed config → DB (with cleanup) → Redis (with cleanup) → repo → service → HTTP server.

```
myapp/
├── config/
│   ├── config.go
│   └── wire.go
├── infra/
│   ├── db.go
│   ├── cache.go
│   └── wire.go
├── repo/
│   ├── user.go
│   └── wire.go
├── service/
│   ├── user.go
│   └── wire.go
├── transport/
│   ├── handler.go
│   └── wire.go
├── wire.go        // injector — //go:build wireinject
├── wire_gen.go    // generated — commit this
└── main.go
```

```go
// config/config.go
type Config struct {
    Addr      string
    DSN       string
    CacheAddr string
}

func NewConfig() *Config {
    return &Config{
        Addr:      env("ADDR", ":8080"),
        DSN:       mustEnv("DATABASE_URL"),
        CacheAddr: env("REDIS_ADDR", "localhost:6379"),
    }
}

// config/wire.go
var ConfigSet = wire.NewSet(NewConfig)
```

```go
// infra/db.go
func NewDB(cfg *config.Config) (*sql.DB, func(), error) {
    db, err := sql.Open("postgres", cfg.DSN)
    if err != nil { return nil, nil, err }
    if err := db.Ping(); err != nil { db.Close(); return nil, nil, err }
    return db, func() { db.Close() }, nil
}

// infra/cache.go
func NewRedis(cfg *config.Config) (*redis.Client, func(), error) {
    c := redis.NewClient(&redis.Options{Addr: cfg.CacheAddr})
    if err := c.Ping(context.Background()).Err(); err != nil {
        return nil, nil, err
    }
    return c, func() { c.Close() }, nil
}

// infra/wire.go
var InfraSet = wire.NewSet(NewDB, NewRedis)
```

```go
// repo/user.go
type UserStore interface {
    GetUser(ctx context.Context, id int64) (*User, error)
}

type PostgresUserRepo struct{ db *sql.DB }

func NewUserRepo(db *sql.DB) *PostgresUserRepo { return &PostgresUserRepo{db: db} }

// repo/wire.go
var RepoSet = wire.NewSet(
    NewUserRepo,
    wire.Bind(new(UserStore), new(*PostgresUserRepo)),
)
```

```go
// service/user.go
type UserService struct {
    store  repo.UserStore
    cache  *redis.Client
}

func NewUserService(store repo.UserStore, cache *redis.Client) *UserService {
    return &UserService{store: store, cache: cache}
}

// service/wire.go
var ServiceSet = wire.NewSet(NewUserService)
```

```go
// wire.go
//go:build wireinject

package main

func InitApp() (*transport.Handler, func(), error) {
    wire.Build(
        config.ConfigSet,
        infra.InfraSet,
        repo.RepoSet,
        service.ServiceSet,
        transport.NewHandler,
    )
    return nil, nil, nil
}
```

```go
// main.go
func main() {
    handler, cleanup, err := InitApp()
    if err != nil { log.Fatal(err) }
    defer cleanup()

    srv := &http.Server{Addr: ":8080", Handler: handler}
    log.Fatal(srv.ListenAndServe())
}
```

## Multiple Build Variants (Prod vs Dev)

Use separate injector files with `//go:build` constraints to select different provider sets at build time.

```go
// wire_prod.go
//go:build wireinject && !dev

package main

func InitApp() (*App, func(), error) {
    wire.Build(ProdSet, NewApp)
    return nil, nil, nil
}

// wire_dev.go
//go:build wireinject && dev

package main

func InitApp() (*App, func(), error) {
    wire.Build(DevSet, NewApp) // DevSet swaps real DB for in-memory SQLite
    return nil, nil, nil
}
```

Use `-output_file_prefix` to write separate output files — both commands would otherwise overwrite the same `wire_gen.go`:

```bash
wire -tags dev -output_file_prefix=wire_gen_dev gen .
wire -output_file_prefix=wire_gen_prod gen .
```

Add build constraints to the generated files so only one compiles per build:

```go
// wire_gen_prod.go — add at the top (after wire writes it)
//go:build !dev

// wire_gen_dev.go — add at the top
//go:build dev
```

Commit both generated files. At build time, only the matching file is compiled.

## Cleanup-Heavy Graph

When several providers need shutdown coordination, wire's reverse-order cleanup is essential.

```go
// Providers return (T, func(), error)
func NewDBPool(cfg *Config) (*pgxpool.Pool, func(), error) {
    pool, err := pgxpool.New(context.Background(), cfg.DSN)
    if err != nil { return nil, nil, err }
    return pool, func() { pool.Close() }, nil
}

func NewOTelExporter(cfg *Config) (*otlptrace.Exporter, func(), error) {
    exp, err := otlptracegrpc.New(context.Background(), ...)
    if err != nil { return nil, nil, err }
    return exp, func() { exp.Shutdown(context.Background()) }, nil
}

func NewTracerProvider(exp *otlptrace.Exporter) (*trace.TracerProvider, func(), error) {
    tp := trace.NewTracerProvider(trace.WithBatcher(exp))
    return tp, func() { tp.Shutdown(context.Background()) }, nil
}
```

Wire generates shutdown in reverse: `TracerProvider` → `OTelExporter` → `DBPool`. Each cleanup runs before its dependencies shut down — guaranteeing in-flight spans are flushed before the exporter closes.

## Embedding Wire in a CLI

Wire produces a struct, not an app framework. You control the lifecycle:

```go
// wire.go
//go:build wireinject

package cmd

func InitServer(cfg *Config) (*http.Server, func(), error) {
    wire.Build(InfraSet, ServiceSet, NewHTTPServer)
    return nil, nil, nil
}

// cmd/serve.go
func runServe(cfg *Config) error {
    srv, cleanup, err := InitServer(cfg)
    if err != nil { return err }
    defer cleanup()

    quit := make(chan os.Signal, 1)
    signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM)

    go func() {
        if err := srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
            log.Fatal(err)
        }
    }()
    <-quit
    ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
    defer cancel()
    return srv.Shutdown(ctx)
}
```

Unlike `fx.Run()`, wire does not manage the lifecycle loop. Implement signal handling and graceful shutdown explicitly. This is a feature for CLI tools that spin up short-lived services and need precise control over the shutdown sequence.

## Passing External Values to Wire

Values built before wire runs (parsed config, test doubles) become injector parameters:

```go
//go:build wireinject

// cfg is resolved outside the graph — treated as a provided *Config
func InitApp(cfg *Config) (*App, func(), error) {
    wire.Build(InfraSet, ServiceSet, NewApp)
    return nil, nil, nil
}

// main.go
cfg, err := config.Load()
if err != nil { log.Fatal(err) }
app, cleanup, err := InitApp(cfg)
```

The parameter `cfg *Config` satisfies any downstream provider that requests `*Config` — no `wire.Value` or extra set entry needed.
