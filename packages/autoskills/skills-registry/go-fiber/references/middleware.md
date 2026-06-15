# Fiber v3 Middleware

## Middleware Fundamentals

Fiber middleware is any `fiber.Handler` that calls `c.Next()` to pass control downstream. Middleware registered with `app.Use()` runs for every request. Group-level middleware runs only for routes within that group.

```go
// Basic middleware signature
func myMiddleware(c fiber.Ctx) error {
    // Pre-processing (before handler)
    start := time.Now()

    // Continue to next middleware or handler
    err := c.Next()

    // Post-processing (after handler)
    duration := time.Since(start)
    log.Printf("Request took %v", duration)

    return err
}

app.Use(myMiddleware)
```

## Middleware Execution Order

Middleware runs in registration order. Place middleware that must wrap all requests first.

```go
// Correct order for production
app.Use(recover.New())          // 1. Catch panics (outermost)
app.Use(requestid.New())        // 2. Assign request IDs
app.Use(logger.New())           // 3. Log all requests
app.Use(cors.New(corsConfig))   // 4. Handle CORS preflight
app.Use(helmet.New())           // 5. Security headers
app.Use(limiter.New(limConfig)) // 6. Rate limiting

// Group-level middleware runs after app-level
api := app.Group("/api")
api.Use(jwtAuthMiddleware)      // 7. Auth only for API routes
```

## Built-in Middleware

### Recover

Catches panics and converts them to 500 responses.

```go
import "github.com/gofiber/fiber/v3/middleware/recover"

app.Use(recover.New(recover.Config{
    EnableStackTrace: true, // Include stack in error handler
    StackTraceHandler: func(c fiber.Ctx, e interface{}) {
        log.Printf("PANIC: %v\n%s", e, debug.Stack())
    },
}))
```

### Request ID

Generates unique request identifiers for tracing.

```go
import "github.com/gofiber/fiber/v3/middleware/requestid"

app.Use(requestid.New(requestid.Config{
    Header: "X-Request-Id",
    Generator: func() string {
        return uuid.New().String()
    },
}))

// Access in handler
func handler(c fiber.Ctx) error {
    reqID := c.Locals("requestid").(string)
    return c.JSON(fiber.Map{"request_id": reqID})
}
```

### CORS

Configures Cross-Origin Resource Sharing headers.

```go
import "github.com/gofiber/fiber/v3/middleware/cors"

app.Use(cors.New(cors.Config{
    AllowOrigins:     "https://app.example.com, https://admin.example.com",
    AllowMethods:     "GET,POST,PUT,DELETE,OPTIONS",
    AllowHeaders:     "Origin, Content-Type, Authorization",
    AllowCredentials: true,
    MaxAge:           3600,
}))
```

### Helmet

Sets security-related HTTP headers.

```go
import "github.com/gofiber/fiber/v3/middleware/helmet"

app.Use(helmet.New(helmet.Config{
    XSSProtection:         "1; mode=block",
    ContentTypeNosniff:    "nosniff",
    XFrameOptions:         "DENY",
    ReferrerPolicy:        "strict-origin-when-cross-origin",
    CrossOriginEmbedderPolicy: "require-corp",
    CrossOriginOpenerPolicy:   "same-origin",
    CrossOriginResourcePolicy: "same-origin",
    ContentSecurityPolicy: "default-src 'self'; script-src 'self'",
}))
```

### Rate Limiter

Limits request rate per client.

```go
import "github.com/gofiber/fiber/v3/middleware/limiter"

app.Use(limiter.New(limiter.Config{
    Max:        100,
    Expiration: 1 * time.Minute,
    KeyGenerator: func(c fiber.Ctx) string {
        return c.IP() // Rate limit per IP
    },
    LimitReached: func(c fiber.Ctx) error {
        return c.Status(429).JSON(fiber.Map{
            "code":    "RATE_LIMIT_EXCEEDED",
            "message": "Too many requests, please try again later",
        })
    },
    Storage: redisStorage, // Use Redis for distributed deployments
}))
```

### Logger

Structured request logging.

```go
import "github.com/gofiber/fiber/v3/middleware/logger"

app.Use(logger.New(logger.Config{
    Format:     "${time} | ${status} | ${latency} | ${ip} | ${method} ${path}\n",
    TimeFormat: time.RFC3339,
    TimeZone:   "UTC",
    Output:     os.Stdout,
}))
```

## Custom Middleware Patterns

### Authentication Middleware

```go
func jwtAuthMiddleware(c fiber.Ctx) error {
    header := c.Get("Authorization")
    if !strings.HasPrefix(header, "Bearer ") {
        return fiber.NewError(fiber.StatusUnauthorized, "Missing or invalid token")
    }

    token := strings.TrimPrefix(header, "Bearer ")
    claims, err := validateJWT(token)
    if err != nil {
        return fiber.NewError(fiber.StatusUnauthorized, "Invalid token")
    }

    c.Locals("user", claims)
    return c.Next()
}
```

### Timing Middleware

```go
func timingMiddleware(c fiber.Ctx) error {
    start := time.Now()
    err := c.Next()
    duration := time.Since(start)
    c.Set("X-Response-Time", duration.String())
    return err
}
```

### Conditional Middleware

```go
func skipForHealthCheck(handler fiber.Handler) fiber.Handler {
    return func(c fiber.Ctx) error {
        if c.Path() == "/health" {
            return c.Next()
        }
        return handler(c)
    }
}

app.Use(skipForHealthCheck(jwtAuthMiddleware))
```

## Middleware with Configuration

Follow the config-pattern convention used by official Fiber middleware.

```go
type RateLimitConfig struct {
    Max        int
    Window     time.Duration
    KeyFunc    func(fiber.Ctx) string
    SkipFunc   func(fiber.Ctx) bool
}

func NewRateLimit(config ...RateLimitConfig) fiber.Handler {
    cfg := RateLimitConfig{
        Max:    100,
        Window: time.Minute,
        KeyFunc: func(c fiber.Ctx) string { return c.IP() },
    }
    if len(config) > 0 {
        cfg = config[0]
    }

    return func(c fiber.Ctx) error {
        if cfg.SkipFunc != nil && cfg.SkipFunc(c) {
            return c.Next()
        }
        key := cfg.KeyFunc(c)
        // Rate limiting logic using key...
        return c.Next()
    }
}
```

## Common Mistakes

| Mistake | Fix |
| --- | --- |
| Forgetting `c.Next()` | Middleware must call `c.Next()` or return a response |
| Recovery not first | Place `recover.New()` before all other middleware |
| Global auth middleware | Apply auth at the group level, not app level |
| Ignoring `c.Next()` error | Check and return the error from `c.Next()` |
| Modifying response after send | Check if response has been committed before writing |
