# Fiber v3 Performance

## Why Fiber is Fast

Fiber is built on `fasthttp`, which avoids the per-request allocations that `net/http` makes. Key differences include object reuse through sync.Pool, zero-copy request parsing, and a radix tree router with no allocations on matched routes.

## App Configuration for Performance

```go
app := fiber.New(fiber.Config{
    // Prefork spawns multiple processes for multi-core utilization
    Prefork: false, // Enable only for pure HTTP workloads without shared state

    // Server tuning
    ReadTimeout:           10 * time.Second,
    WriteTimeout:          10 * time.Second,
    IdleTimeout:           120 * time.Second,
    ReadBufferSize:        8192,  // Increase for large headers
    WriteBufferSize:       4096,
    BodyLimit:             4 * 1024 * 1024, // 4MB
    Concurrency:           256 * 1024,      // Max concurrent connections
    DisableStartupMessage: true,            // Reduce log noise in production

    // Reduce allocations
    DisableDefaultContentType: true,  // Don't set Content-Type on every response
    StreamRequestBody:         true,  // Stream large uploads instead of buffering
    ReduceMemoryUsage:         false, // Only enable if memory-constrained
})
```

## Prefork Mode

Prefork spawns one process per CPU core. Each process has its own event loop and does not share memory with others.

```go
app := fiber.New(fiber.Config{
    Prefork: true,
})
```

**When to use prefork:**
- CPU-bound workloads with minimal shared state
- Static file serving at scale
- Stateless API endpoints

**When NOT to use prefork:**
- WebSocket applications (connections are per-process)
- In-memory caching (each process has its own cache)
- Applications with shared mutable state

## Response Optimization

### Avoid unnecessary allocations

```go
// Bad: allocates a new map every request
func handler(c fiber.Ctx) error {
    return c.JSON(map[string]interface{}{
        "status": "ok",
        "data":   result,
    })
}

// Better: use fiber.Map (type alias, but still allocates)
func handler(c fiber.Ctx) error {
    return c.JSON(fiber.Map{"status": "ok", "data": result})
}

// Best for static responses: pre-serialize
var healthResponse = []byte(`{"status":"ok"}`)

func healthHandler(c fiber.Ctx) error {
    c.Set("Content-Type", "application/json")
    return c.Send(healthResponse)
}
```

### Use SendString for text responses

```go
// Slower: SendString converts to bytes internally
func handler(c fiber.Ctx) error {
    return c.SendString("OK")
}

// For high-throughput text endpoints, pre-convert
var okBytes = []byte("OK")

func handler(c fiber.Ctx) error {
    return c.Send(okBytes)
}
```

## JSON Serialization

### Use a fast JSON library

```go
import "github.com/goccy/go-json"

app := fiber.New(fiber.Config{
    JSONEncoder: gojson.Marshal,
    JSONDecoder: gojson.Unmarshal,
})
```

Benchmarks show `goccy/go-json` and `bytedance/sonic` can be 2-3x faster than `encoding/json` for large payloads.

## Middleware Performance

### Skip unnecessary middleware

```go
// Skip auth for public endpoints
app.Use(limiter.New(limiter.Config{
    Next: func(c fiber.Ctx) bool {
        return c.Path() == "/health" || c.Path() == "/metrics"
    },
    Max:        100,
    Expiration: time.Minute,
}))
```

### Minimize middleware per request

Each middleware adds function call overhead. For hot paths, consider:
- Using the `Next` function to skip middleware conditionally
- Combining related middleware into one (e.g., auth + rate limit)
- Placing expensive middleware only on routes that need it

## Connection Pooling

### Database connections

```go
db, err := sql.Open("postgres", dsn)
db.SetMaxOpenConns(25)          // Match expected concurrency
db.SetMaxIdleConns(25)          // Keep all connections warm
db.SetConnMaxLifetime(5 * time.Minute) // Rotate connections
db.SetConnMaxIdleTime(1 * time.Minute) // Close idle connections
```

### HTTP client reuse

```go
// Bad: creates a new client per request
func handler(c fiber.Ctx) error {
    resp, _ := http.Get("https://api.example.com/data")
    // ...
}

// Good: reuse client with connection pooling
var httpClient = &http.Client{
    Transport: &http.Transport{
        MaxIdleConns:        100,
        MaxIdleConnsPerHost: 10,
        IdleConnTimeout:     90 * time.Second,
    },
    Timeout: 10 * time.Second,
}
```

## Profiling with pprof

```go
import "github.com/gofiber/fiber/v3/middleware/pprof"

// Only enable in non-production or behind admin auth
if os.Getenv("ENABLE_PPROF") == "true" {
    app.Use(pprof.New())
}
```

Access profiles at:
- `/debug/pprof/` -- Index
- `/debug/pprof/heap` -- Heap allocations
- `/debug/pprof/goroutine` -- Goroutine stacks
- `/debug/pprof/profile?seconds=30` -- CPU profile

### Analyzing with go tool pprof

```bash
# CPU profile
go tool pprof http://localhost:8080/debug/pprof/profile?seconds=30

# Heap profile
go tool pprof http://localhost:8080/debug/pprof/heap

# Goroutine dump
go tool pprof http://localhost:8080/debug/pprof/goroutine
```

## Benchmark Comparison

Run benchmarks to compare implementations:

```go
func BenchmarkJSONResponse(b *testing.B) {
    app := fiber.New(fiber.Config{
        JSONEncoder: gojson.Marshal,
    })
    app.Get("/bench", func(c fiber.Ctx) error {
        return c.JSON(testPayload)
    })

    req := httptest.NewRequest("GET", "/bench", nil)

    b.ReportAllocs()
    b.ResetTimer()
    for i := 0; i < b.N; i++ {
        app.Test(req, fiber.TestConfig{Timeout: 0})
    }
}
```

## Performance Checklist

| Area | Check |
| --- | --- |
| App config | Timeouts, body limits, concurrency set |
| JSON | Using goccy/go-json or sonic |
| Middleware | Minimal chain, skip where possible |
| Database | Connection pool sized to concurrency |
| HTTP client | Reused with transport pool |
| Static | Compression and cache headers enabled |
| Profiling | pprof available in staging |
| Benchmarks | b.ReportAllocs on critical paths |
| Memory | No goroutine leaks, bounded workers |
