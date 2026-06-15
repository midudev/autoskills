# Pipeline Patterns

Complete code examples for every `slog-multi` composition pattern.

## Fanout — Broadcast to All

Sends every record to every handler sequentially. Latency = sum of all handler latencies.

```go
import slogmulti "github.com/samber/slog-multi"

logger := slog.New(
    slogmulti.Fanout(
        slog.NewJSONHandler(os.Stdout, nil),           // stdout
        slog.NewTextHandler(logFile, nil),              // file
        slogsentry.Option{Level: slog.LevelError}.NewSentryHandler(), // Sentry
    ),
)
```

**When to use:** Every destination must receive every record (audit logs, compliance). **When NOT to use:** Handlers have different record needs (use Router) or high latency (use Pool).

## Router — Predicate-Based Routing

Routes records to ALL handlers whose predicate matches. Unmatched records go nowhere unless a default handler is added.

```go
logger := slog.New(
    slogmulti.Router().
        Add(sentryHandler, slogmulti.LevelIs(slog.LevelError)).
        Add(slackHandler, slogmulti.LevelIs(slog.LevelWarn)).
        Add(lokiHandler, slogmulti.LevelIs(slog.LevelInfo, slog.LevelDebug)).
        Add(slog.NewJSONHandler(os.Stdout, nil)). // catch-all: no predicate
        Handler(),
)
```

**Built-in predicates:**

```go
slogmulti.LevelIs(slog.LevelError)             // match specific levels
slogmulti.LevelIsNot(slog.LevelDebug)          // exclude levels
slogmulti.MessageIs("payment processed")       // exact message match
slogmulti.MessageIsNot("healthcheck")          // exclude exact message
slogmulti.MessageContains("timeout")           // partial message match
slogmulti.MessageNotContains("debug")          // exclude partial message
slogmulti.AttrValueIs("module", "billing")     // match attribute value
slogmulti.AttrKindIs(slog.KindString)          // match attribute kind
```

**Custom predicate:**

```go
func recordMatchRegion(region string) func(ctx context.Context, r slog.Record) bool {
    return func(ctx context.Context, r slog.Record) bool {
        match := false
        r.Attrs(func(attr slog.Attr) bool {
            if attr.Key == "region" && attr.Value.String() == region {
                match = true
                return false
            }
            return true
        })
        return match
    }
}

logger := slog.New(
    slogmulti.Router().
        Add(slackUS, recordMatchRegion("us")).
        Add(slackEU, recordMatchRegion("eu")).
        Handler(),
)
```

**Warning:** Records matching no predicate are silently dropped. Always add a catch-all handler (no predicate) unless you intentionally want to discard unmatched records.

## FirstMatch — Short-Circuit Routing

Like Router but stops at the first matching handler. Each record goes to exactly one destination.

```go
logger := slog.New(
    slogmulti.Router().
        Add(queryHandler, matchQueryLogs).     // priority 1
        Add(requestHandler, matchRequestLogs). // priority 2
        Add(defaultHandler).                   // fallback
        FirstMatch().
        Handler(),
)
```

**When to use:** Priority-based routing where each record should be processed exactly once. Order matters — put the most specific handlers first.

## Failover — Sequential Fallback

Tries handlers in order until one succeeds (returns `nil` error). If primary fails, falls through to secondary.

```go
logger := slog.New(
    slogmulti.Failover()(
        slogloki.Option{Level: slog.LevelDebug, Client: lokiClient}.NewLokiHandler(),
        slog.NewJSONHandler(localFile, nil), // fallback to local file
        slog.NewTextHandler(os.Stderr, nil), // last resort
    ),
)
```

**When to use:** Network sinks that may be unreliable (Loki, Logstash, remote syslog). Primary handles 99.9% of traffic; fallback catches the rest.

## Pool — Load-Balanced Dispatch

Randomly distributes each record to one handler from the pool. Useful when you have equivalent handlers and want to spread load.

```go
logger := slog.New(
    slogmulti.Pool()(
        lokiHandler1, // shard 1
        lokiHandler2, // shard 2
        lokiHandler3, // shard 3
    ),
)
```

**When to use:** Multiple equivalent sinks where you want throughput distribution. Latency = single handler latency (not sum like Fanout).

## Pipe — Middleware Chain

Chains middleware functions that intercept, transform, or enrich records before they reach the final handler.

```go
logger := slog.New(
    slogmulti.
        Pipe(samplingMiddleware).              // step 1: drop noise
        Pipe(piiScrubbingMiddleware).          // step 2: mask PII
        Pipe(traceInjectionMiddleware).        // step 3: add trace_id
        Pipe(slogmulti.RecoverHandlerError(    // step 4: catch handler panics
            func(ctx context.Context, record slog.Record, err error) {
                log.Println("handler error:", err)
            },
        )).
        Handler(slog.NewJSONHandler(os.Stdout, nil)),
)
```

## Inline Handlers and Middleware

Create quick handlers without defining a full struct.

```go
// Inline handler — for testing or simple consumers
handler := slogmulti.NewHandleInlineHandler(
    func(ctx context.Context, groups []string, attrs []slog.Attr, record slog.Record) error {
        fmt.Printf("LOG: %s %s\n", record.Level, record.Message)
        return nil
    },
)

// Inline middleware — intercept and transform records
middleware := slogmulti.NewHandleInlineMiddleware(
    func(ctx context.Context, record slog.Record, next func(context.Context, slog.Record) error) error {
        record.AddAttrs(slog.String("service", "my-api"))
        return next(ctx, record)
    },
)
```

## AttrFromContext — Request-Scoped Attributes

HTTP middlewares (`slog-gin`, `slog-echo`, etc.) inject request attributes into context. Backend handlers extract them via `AttrFromContext`.

```go
// Backend handler extracts trace_id from context
handler := slogsentry.Option{
    Level: slog.LevelError,
    AttrFromContext: []func(ctx context.Context) []slog.Attr{
        func(ctx context.Context) []slog.Attr {
            if traceID := ctx.Value("trace_id"); traceID != nil {
                return []slog.Attr{slog.String("trace_id", traceID.(string))}
            }
            return nil
        },
    },
}.NewSentryHandler()
```

**Important:** `AttrFromContext` only works when the context actually contains the expected values. This requires an HTTP middleware (like `slog-gin`) to populate the context first. Without the middleware, `AttrFromContext` silently returns nil.

## Full Production Pipeline

Canonical ordering: sampling → middleware (PII, trace) → routing → sinks.

```go
import (
    slogmulti "github.com/samber/slog-multi"
    slogsampling "github.com/samber/slog-sampling"
    slogformatter "github.com/samber/slog-formatter"
    slogsentry "github.com/samber/slog-sentry/v2"
    slogloki "github.com/samber/slog-loki/v3"
)

// 1. Sampling: first 20 per 5s, then 10%
sampling := slogsampling.ThresholdSamplingOption{
    Tick: 5 * time.Second, Threshold: 20, Rate: 0.1,
}.NewMiddleware()

// 2. PII scrubbing
pii := slogformatter.NewFormatterMiddleware(
    slogformatter.PIIFormatter("user"),
    slogformatter.IPAddressFormatter("client_ip"),
)

// 3. Error recovery
recovery := slogmulti.RecoverHandlerError(func(ctx context.Context, r slog.Record, err error) {
    log.Printf("slog handler error: %v", err)
})

// 4. Sinks
sentryHandler := slogsentry.Option{Level: slog.LevelError}.NewSentryHandler()
lokiHandler := slogloki.Option{Level: slog.LevelDebug, Client: lokiClient}.NewLokiHandler()
defer lokiClient.Stop() // flush buffered logs

// 5. Compose — errors bypass sampling, everything else is sampled
logger := slog.New(
    slogmulti.
        Pipe(pii).            // scrub PII on all records
        Pipe(recovery).       // catch panics
        Handler(
            slogmulti.Router().
                Add(sentryHandler, slogmulti.LevelIs(slog.LevelError)).  // errors: no sampling
                Add(slogmulti.                                            // everything else: sampled
                    Pipe(sampling).
                    Handler(lokiHandler),
                ).
                FirstMatch().  // stop at first matching route — errors won't fall through to sampled path
                Handler(),
        ),
)
slog.SetDefault(logger)
```
