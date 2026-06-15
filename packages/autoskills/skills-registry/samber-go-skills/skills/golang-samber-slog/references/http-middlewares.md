# HTTP Middlewares

All samber/slog HTTP middlewares share a consistent pattern and configuration structure.

## Shared Config Fields

Every middleware provides a `Config` struct with these common fields:

| Field | Type | Default | Purpose |
| --- | --- | --- | --- |
| `DefaultLevel` | `slog.Level` | `slog.LevelInfo` | Log level for 2xx/3xx responses |
| `ClientErrorLevel` | `slog.Level` | `slog.LevelWarn` | Log level for 4xx responses |
| `ServerErrorLevel` | `slog.Level` | `slog.LevelError` | Log level for 5xx responses |
| `WithUserAgent` | `bool` | `false` | Include `User-Agent` header |
| `WithRequestID` | `bool` | `false` | Include request ID |
| `WithRequestBody` | `bool` | `false` | Include request body (capped) |
| `WithResponseBody` | `bool` | `false` | Include response body (capped) |
| `WithRequestHeader` | `bool` | `false` | Include request headers |
| `WithResponseHeader` | `bool` | `false` | Include response headers |
| `WithSpanID` | `bool` | `false` | Include OpenTelemetry span ID |
| `WithTraceID` | `bool` | `false` | Include OpenTelemetry trace ID |
| `WithClientIP` | `bool` | `false` | Include client IP address |
| `Filters` | `[]Filter` | `nil` | Request filter functions |

**Global configuration variables** (set before creating middleware):

- `RequestBodyMaxSize` / `ResponseBodyMaxSize` — default 64KB each
- `HiddenRequestHeaders` / `HiddenResponseHeaders` — headers to redact
- `TraceIDKey` / `SpanIDKey` — context key names for OpenTelemetry

## Default Log Fields

All middlewares emit these fields by default: `method`, `path`, `status`, `latency`, `request-length`, `response-length`.

## Gin — `slog-gin`

```go
import sloggin "github.com/samber/slog-gin"

// Simple
router := gin.New()
router.Use(sloggin.New(logger))

// With config
router.Use(sloggin.NewWithConfig(logger, sloggin.Config{
    DefaultLevel:     slog.LevelInfo,
    ClientErrorLevel: slog.LevelWarn,
    ServerErrorLevel: slog.LevelError,
    WithRequestBody:  true,
    WithUserAgent:    true,
    Filters: []sloggin.Filter{
        sloggin.IgnorePath("/health", "/metrics"),
        sloggin.IgnorePathPrefix("/static"),
    },
}))

// Custom attributes per request
router.GET("/api/users", func(c *gin.Context) {
    sloggin.AddCustomAttributes(c, slog.String("user_id", userID))
    c.JSON(200, users)
})
```

## Echo — `slog-echo`

```go
import slogecho "github.com/samber/slog-echo"

e := echo.New()
e.Use(slogecho.New(logger))

// With config
e.Use(slogecho.NewWithConfig(logger, slogecho.Config{
    DefaultLevel:     slog.LevelInfo,
    ClientErrorLevel: slog.LevelWarn,
    ServerErrorLevel: slog.LevelError,
    WithRequestBody:  true,
    Filters: []slogecho.Filter{
        slogecho.IgnoreStatus(404),
        slogecho.IgnorePath("/health"),
    },
}))

// Custom attributes
e.GET("/api/users", func(c echo.Context) error {
    slogecho.AddCustomAttributes(c, slog.String("user_id", userID))
    return c.JSON(200, users)
})
```

## Fiber — `slog-fiber`

```go
import slogfiber "github.com/samber/slog-fiber"

app := fiber.New()
app.Use(slogfiber.New(logger))

// With config
app.Use(slogfiber.NewWithConfig(logger, slogfiber.Config{
    DefaultLevel:     slog.LevelInfo,
    ClientErrorLevel: slog.LevelWarn,
    ServerErrorLevel: slog.LevelError,
    WithRequestBody:  true,
    Filters: []slogfiber.Filter{
        slogfiber.IgnorePath("/health"),
        slogfiber.IgnoreStatus(404),
    },
}))

// Custom attributes
app.Get("/api/users", func(c fiber.Ctx) error {
    slogfiber.AddCustomAttributes(c, slog.String("user_id", userID))
    return c.JSON(users)
})
```

**Note:** Fiber uses `fasthttp`, not `net/http`. Request/response types differ.

## Chi — `slog-chi`

```go
import slogchi "github.com/samber/slog-chi"

router := chi.NewRouter()
router.Use(slogchi.New(logger))

// With config
router.Use(slogchi.NewWithConfig(logger, slogchi.Config{
    DefaultLevel:     slog.LevelInfo,
    ClientErrorLevel: slog.LevelWarn,
    ServerErrorLevel: slog.LevelError,
    WithRequestBody:  true,
    Filters: []slogchi.Filter{
        slogchi.IgnorePath("/health", "/ready"),
        slogchi.IgnoreStatus(401, 404),
    },
}))

// Custom attributes
router.Get("/api/users", func(w http.ResponseWriter, r *http.Request) {
    slogchi.AddCustomAttributes(r, slog.String("user_id", userID))
    json.NewEncoder(w).Encode(users)
})
```

## net/http — `slog-http`

```go
import sloghttp "github.com/samber/slog-http"

mux := http.NewServeMux()
handler := sloghttp.New(logger)(mux)
http.ListenAndServe(":8080", handler)
```

## Filters

All middlewares support the same filter functions:

```go
sloggin.IgnorePath("/health", "/metrics")     // exact path match
sloggin.IgnorePathPrefix("/static", "/assets") // path prefix
sloggin.IgnoreStatus(401, 404)                 // skip specific status codes

// Custom filter
sloggin.Accept(func(c *gin.Context) bool {
    return c.Request.Method != "OPTIONS"       // skip CORS preflight
})
```

## Logger Grouping

Wrap the logger with `WithGroup("http")` to namespace all middleware attributes under an `http` group:

```go
router.Use(sloggin.New(logger.WithGroup("http")))
// Output: {"http": {"method": "GET", "path": "/api", "status": 200, ...}}
```
