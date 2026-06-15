# Structured Logging with `slog`

→ See `samber/cc-skills-golang@golang-error-handling` skill for the single handling rule.

## Why Structured Logging

Structured logs emit key-value pairs instead of freeform strings. Log management systems (Datadog, Grafana Loki, CloudWatch) can index, filter, and aggregate structured fields — something impossible with `log.Printf` output.

```go
// ✗ Bad — freeform string, impossible to filter by user_id
log.Printf("ERROR: failed to create user %s: %v", userID, err)

// ✓ Good — structured key-value pairs, machine-parseable
slog.Error("user creation failed",
    "user_id", userID,
    "error", err,
)
// JSON output: {"time":"2025-01-15T10:30:00Z","level":"ERROR","msg":"user creation failed","user_id":"u-123","error":"connection refused"}
```

## Handler Setup

```go
// Production MUST use JSON — because plain-text multiline logs (eg. stack traces) would be split into separate records by log collectors
logger := slog.New(slog.NewJSONHandler(os.Stdout, &slog.HandlerOptions{
    Level: slog.LevelInfo,
}))

// Development — human-readable text
logger := slog.New(slog.NewTextHandler(os.Stderr, &slog.HandlerOptions{
    Level: slog.LevelDebug,
}))

slog.SetDefault(logger)
```

## Log Levels

```go
slog.Debug("cache lookup", "key", cacheKey, "hit", false)
slog.Info("order created", "order_id", orderID, "total", amount)
slog.Warn("rate limit approaching", "current_usage", 0.92, "limit", 1000)
slog.Error("payment failed", "order_id", orderID, "error", err)
```

**Rule of thumb**: if you're unsure between Warn and Error, ask "did the operation succeed?" If yes (even with degradation), use Warn. If no, use Error.

## Cost of Logging

Logging is not free. Each log line costs CPU (serialization), I/O (disk/network), and money (log ingestion/storage in your aggregation platform). The cost scales with volume, which is directly controlled by log level.

- **Debug level in production** can generate millions of log lines per minute in a busy service, overwhelming your log pipeline and inflating costs by 10-100x
- **Info level** is the typical production default — it provides enough visibility without excessive volume
- Debug level SHOULD be disabled in production — use `slog.LevelInfo` in production and `slog.LevelDebug` only in development or when actively debugging a specific issue
- For high-throughput services, consider [samber/slog-sampling](https://github.com/samber/slog-sampling) to sample verbose logs (e.g., emit 1 in 100 Debug logs) rather than dropping them entirely

## Logging with Context

MUST use the `*Context` variants to correlate logs with the current trace. When an OpenTelemetry bridge is configured, trace_id and span_id are automatically injected into log records.

```go
// ✗ Bad — no trace correlation
slog.Error("query failed", "error", err)

// ✓ Good — trace_id/span_id attached automatically when OTel bridge is active
slog.ErrorContext(ctx, "query failed", "error", err)
```

## Adding Request-Scoped Attributes

Use `slog.With()` to create a child logger that includes attributes on every log line. Middleware can inject request-scoped fields so all downstream logs carry the same context.

```go
func LoggingMiddleware(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        logger := slog.With(
            "request_id", r.Header.Get("X-Request-ID"),
            "method", r.Method,
            "path", r.URL.Path,
        )
        // Store enriched logger in context for downstream use
        ctx := WithLogger(r.Context(), logger)
        next.ServeHTTP(w, r.WithContext(ctx))
    })
}
```

## Log Sinks and the `slog` Ecosystem

`slog` supports pluggable handlers. The Go community provides handlers for most log backends:

**Standard library:**

- `slog.JSONHandler` — JSON to stdout/stderr
- `slog.TextHandler` — human-readable key=value

**Log record handling:**

- [samber/slog-multi](https://github.com/samber/slog-multi) — fan-out to multiple handlers, routing, failover
- [samber/slog-sampling](https://github.com/samber/slog-sampling) — sample high-volume logs to reduce cost
- [samber/slog-formatter](https://github.com/samber/slog-formatter) — format/transform log attributes

**HTTP middleware:**

- [samber/slog-http](https://github.com/samber/slog-http) — HTTP server middleware (net/http, chi, fiber, echo, gin)
- [samber/slog-gin](https://github.com/samber/slog-gin) — Gin framework middleware
- [samber/slog-echo](https://github.com/samber/slog-echo) — Echo framework middleware
- [samber/slog-fiber](https://github.com/samber/slog-fiber) — Fiber framework middleware
- [samber/slog-chi](https://github.com/samber/slog-chi) — Chi router middleware

**Third-party log sinks** (see [go.dev/wiki/Resources-for-slog](https://go.dev/wiki/Resources-for-slog)):

- [lmittmann/tint](https://github.com/lmittmann/tint) — colorized terminal output
- [samber/slog-datadog](https://github.com/samber/slog-datadog) — send logs to Datadog
- [samber/slog-sentry](https://github.com/samber/slog-sentry) — send errors to Sentry
- [samber/slog-loki](https://github.com/samber/slog-loki) — send logs to Grafana Loki
- [samber/slog-nats](https://github.com/samber/slog-nats) — send logs to NATS
- [samber/slog-syslog](https://github.com/samber/slog-syslog) — send logs to syslog
- [samber/slog-fluentd](https://github.com/samber/slog-fluentd) — send logs to Fluentd
- [samber/slog-logrus](https://github.com/samber/slog-logrus) — bridge to Logrus
- [samber/slog-zap](https://github.com/samber/slog-zap) — bridge to Zap
- [samber/slog-zerolog](https://github.com/samber/slog-zerolog) — bridge to Zerolog
- [samber/slog-slack](https://github.com/samber/slog-slack) — send critical logs to Slack

## Migrating from zap / logrus / zerolog

`log/slog` is the standard library logger since Go 1.21. If the project uses `zap`, `logrus`, or `zerolog`, migrate to `slog` — it has a stable API, broad ecosystem support, and eliminates an unnecessary dependency.

**Step 1: Bridge** — route `slog` output through the existing logger so you can migrate call sites incrementally without changing log output:

```go
// Example: bridge slog → zap (same pattern for logrus/zerolog)
import slogzap "github.com/samber/slog-zap/v2"

zapLogger, _ := zap.NewProduction()
slog.SetDefault(slog.New(
    slogzap.Option{Level: slog.LevelInfo, Logger: zapLogger}.NewZapHandler(),
))
```

Available bridges: [samber/slog-zap](https://github.com/samber/slog-zap), [samber/slog-logrus](https://github.com/samber/slog-logrus), [samber/slog-zerolog](https://github.com/samber/slog-zerolog)

**Step 2: Replace call sites** — change all logger calls to `slog`:

```go
// zap → slog
// Before: zap.L().Info("order created", zap.String("order_id", id))
// After:
slog.Info("order created", "order_id", id)

// logrus → slog
// Before: logrus.WithField("order_id", id).Info("order created")
// After:
slog.Info("order created", "order_id", id)

// zerolog → slog
// Before: log.Info().Str("order_id", id).Msg("order created")
// After:
slog.Info("order created", "order_id", id)
```

**Step 3: Remove the bridge** — once all call sites are migrated, replace the bridge handler with a native `slog` handler and remove the old logger dependency:

```go
slog.SetDefault(slog.New(slog.NewJSONHandler(os.Stdout, &slog.HandlerOptions{
    Level: slog.LevelInfo,
})))
```

## Common Logging Mistakes

```go
// ✗ Bad — errors MUST be either logged OR returned, NEVER both (single handling rule violation)
if err != nil {
    slog.Error("query failed", "error", err)
    return fmt.Errorf("query: %w", err) // error gets logged twice up the chain
}

// ✓ Good — return with context, log at the top level
if err != nil {
    return fmt.Errorf("querying users: %w", err)
}

// ✗ Bad — NEVER log PII (emails, SSNs, passwords, tokens)
slog.Info("user logged in", "email", user.Email, "ssn", user.SSN)

// ✓ Good — log identifiers, not sensitive data
slog.Info("user logged in", "user_id", user.ID)
```
