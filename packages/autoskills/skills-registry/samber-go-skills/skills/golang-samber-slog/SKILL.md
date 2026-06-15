---
name: golang-samber-slog
description: "Structured logging extensions for Golang using samber/slog-**** packages — multi-handler pipelines (slog-multi), log sampling (slog-sampling), attribute formatting (slog-formatter), HTTP middleware (slog-fiber, slog-gin, slog-chi, slog-echo), and backend routing (slog-datadog, slog-sentry, slog-loki, slog-syslog, slog-logstash, slog-graylog...). Apply when using or adopting slog, or when the codebase already imports any github.com/samber/slog-* package."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents, and for projects using Golang.
metadata:
  author: samber
  version: "1.0.4"
  openclaw:
    emoji: "🪵"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
    install: []
    skill-library-version:
      slog-multi: "1.8.0"
      slog-sampling: "1.6.0"
      slog-formatter: "1.3.0"
      slog-fiber: "1.22.1"
      slog-gin: "1.21.0"
      slog-chi: "1.19.0"
      slog-echo: "1.21.0"
      slog-http: "1.12.0"
      slog-betterstack: "1.4.4"
      slog-channel: "1.4.4"
      slog-datadog: "2.10.4"
      slog-sentry: "2.10.3"
      slog-loki: "3.7.2"
      slog-syslog: "2.5.4"
      slog-logstash: "2.6.4"
      slog-graylog: "2.7.5"
      slog-fluentd: "2.5.4"
      slog-kafka: "2.6.5"
      slog-logrus: "2.5.4"
      slog-zap: "2.6.4"
      slog-zerolog: "2.9.2"
      slog-slack: "2.7.5"
      slog-telegram: "2.4.4"
      slog-webhook: "2.8.4"
      slog-mattermost: "2.5.4"
      slog-microsoft-teams: "2.7.4"
      slog-nats: "0.4.5"
      slog-otel: "0.1.0"
      slog-parquet: "2.5.2"
      slog-quickwit: "0.3.4"
      slog-rollbar: "2.7.4"
      slog-mock: "0.1.0"
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Agent WebFetch mcp__context7__resolve-library-id mcp__context7__query-docs AskUserQuestion
---

**Persona:** You are a Go logging architect. You design log pipelines where every record flows through the right handlers — sampling drops noise early, formatters strip PII before records leave the process, and routers send errors to Sentry while info goes to Loki.

# samber/slog-\*\*\*\* — Structured Logging Pipeline for Go

20+ composable `slog.Handler` packages for Go 1.21+. Three core pipeline libraries plus HTTP middlewares and backend sinks that all implement the standard `slog.Handler` interface.

**Official resources:**

- [github.com/samber/slog-multi](https://github.com/samber/slog-multi) — handler composition
- [github.com/samber/slog-sampling](https://github.com/samber/slog-sampling) — throughput control
- [github.com/samber/slog-formatter](https://github.com/samber/slog-formatter) — attribute transformation

This skill is not exhaustive. Please refer to library documentation and code examples for more information. Context7 can help as a discoverability platform.

## The Pipeline Model

Every samber/slog pipeline follows a canonical ordering. Records flow left to right — place sampling first to drop early and avoid wasting CPU on records that never reach a sink.

```
record → [Sampling] → [Pipe: trace/PII] → [Router] → [Sinks]
```

Order matters: sampling before formatting saves CPU. Formatting before routing ensures all sinks receive clean attributes. Reversing this wastes work on records that get dropped.

## Core Libraries

| Library | Purpose | Key constructors |
| --- | --- | --- |
| `slog-multi` | Handler composition | `Fanout`, `Router`, `FirstMatch`, `Failover`, `Pool`, `Pipe` |
| `slog-sampling` | Throughput control | `UniformSamplingOption`, `ThresholdSamplingOption`, `AbsoluteSamplingOption`, `CustomSamplingOption` |
| `slog-formatter` | Attribute transforms | `PIIFormatter`, `ErrorFormatter`, `FormatByType[T]`, `FormatByKey`, `FlattenFormatterMiddleware` |

## slog-multi — Handler Composition

Six composition patterns, each for a different routing need:

| Pattern | Behavior | Latency impact |
| --- | --- | --- |
| `Fanout(handlers...)` | Broadcast to all handlers sequentially | Sum of all handler latencies |
| `Router().Add(h, predicate).Handler()` | Route to ALL matching handlers | Sum of matching handlers |
| `Router().Add(...).FirstMatch().Handler()` | Route to FIRST match only | Single handler latency |
| `Failover()(handlers...)` | Try sequentially until one succeeds | Primary handler latency (happy path) |
| `Pool()(handlers...)` | Load-balance: sends each record to ONE handler | Single handler latency |
| `Pipe(middlewares...).Handler(sink)` | Middleware chain before sink | Middleware overhead + sink |

```go
// Route errors to Sentry, all logs to stdout
logger := slog.New(
    slogmulti.Router().
        Add(sentryHandler, slogmulti.LevelIs(slog.LevelError)).
        Add(slog.NewJSONHandler(os.Stdout, nil)).
        Handler(),
)
```

Built-in predicates: `LevelIs`, `LevelIsNot`, `MessageIs`, `MessageIsNot`, `MessageContains`, `MessageNotContains`, `AttrValueIs`, `AttrKindIs`.

For full code examples of every pattern, see [Pipeline Patterns](references/pipeline-patterns.md).

## slog-sampling — Throughput Control

| Strategy | Behavior | Best for |
| --- | --- | --- |
| Uniform | Drop fixed % of all records | Dev/staging noise reduction |
| Threshold | Log first N per interval, then sample at rate R | Production — preserves initial visibility |
| Absolute | Cap at N records per interval globally | Hard cost control |
| Custom | User function returns sample rate per record | Level-aware or time-aware rules |

Sampling MUST be the outermost handler in the pipeline — placing it after formatting wastes CPU on records that get dropped.

```go
// Threshold: log first 10 per 5s, then 10% — errors always pass through via Router
logger := slog.New(
    slogmulti.
        Pipe(slogsampling.ThresholdSamplingOption{
            Tick: 5 * time.Second, Threshold: 10, Rate: 0.1,
        }.NewMiddleware()).
        Handler(innerHandler),
)
```

Matchers group similar records for deduplication: `MatchByLevel()`, `MatchByMessage()`, `MatchByLevelAndMessage()` (default), `MatchBySource()`, `MatchByAttribute(groups, key)`.

For strategy comparison and configuration details, see [Sampling Strategies](references/sampling-strategies.md).

## slog-formatter — Attribute Transformation

Apply as a `Pipe` middleware so all downstream handlers receive clean attributes.

```go
logger := slog.New(
    slogmulti.Pipe(slogformatter.NewFormatterMiddleware(
        slogformatter.PIIFormatter("user"),          // mask PII fields
        slogformatter.ErrorFormatter("error"),       // structured error info
        slogformatter.IPAddressFormatter("client"),  // mask IP addresses
    )).Handler(slog.NewJSONHandler(os.Stdout, nil)),
)
```

Key formatters: `PIIFormatter`, `ErrorFormatter`, `TimeFormatter`, `UnixTimestampFormatter`, `IPAddressFormatter`, `HTTPRequestFormatter`, `HTTPResponseFormatter`. Generic formatters: `FormatByType[T]`, `FormatByKey`, `FormatByKind`, `FormatByGroup`, `FormatByGroupKey`. Flatten nested attributes with `FlattenFormatterMiddleware`.

## HTTP Middlewares

Consistent pattern across frameworks: `router.Use(slogXXX.New(logger))`.

Available: `slog-gin`, `slog-echo`, `slog-fiber`, `slog-chi`, `slog-http` (net/http).

All share a `Config` struct with: `DefaultLevel`, `ClientErrorLevel`, `ServerErrorLevel`, `WithRequestBody`, `WithResponseBody`, `WithUserAgent`, `WithRequestID`, `WithTraceID`, `WithSpanID`, `Filters`.

```go
// Gin with filters — skip health checks
router.Use(sloggin.NewWithConfig(logger, sloggin.Config{
    DefaultLevel:     slog.LevelInfo,
    ClientErrorLevel: slog.LevelWarn,
    ServerErrorLevel: slog.LevelError,
    WithRequestBody:  true,
    Filters: []sloggin.Filter{
        sloggin.IgnorePath("/health", "/metrics"),
    },
}))
```

For framework-specific setup, see [HTTP Middlewares](references/http-middlewares.md).

## Backend Sinks

All follow the `Option{}.NewXxxHandler()` constructor pattern.

| Category     | Packages                                                   |
| ------------ | ---------------------------------------------------------- |
| Cloud        | `slog-datadog`, `slog-sentry`, `slog-loki`, `slog-graylog` |
| Messaging    | `slog-kafka`, `slog-fluentd`, `slog-logstash`, `slog-nats` |
| Notification | `slog-slack`, `slog-telegram`, `slog-webhook`              |
| Storage      | `slog-parquet`                                             |
| Bridges      | `slog-zap`, `slog-zerolog`, `slog-logrus`                  |

**Batch handlers require graceful shutdown** — `slog-datadog`, `slog-loki`, `slog-kafka`, and `slog-parquet` buffer records internally. Flush on shutdown (e.g., `handler.Stop(ctx)` for Datadog, `lokiClient.Stop()` for Loki, `writer.Close()` for Kafka) or buffered logs are lost.

For configuration examples and shutdown patterns, see [Backend Handlers](references/backend-handlers.md).

## Common Mistakes

| Mistake | Why it fails | Fix |
| --- | --- | --- |
| Sampling after formatting | Wastes CPU formatting records that get dropped | Place sampling as outermost handler |
| Fanout to many synchronous handlers | Blocks caller — latency is sum of all handlers | Use `Pool()` for concurrent dispatch |
| Missing shutdown flush on batch handlers | Buffered logs lost on shutdown | `defer handler.Stop(ctx)` (Datadog), `defer lokiClient.Stop()` (Loki), `defer writer.Close()` (Kafka) |
| Router without default/catch-all handler | Unmatched records silently dropped | Add a handler with no predicate as catch-all |
| `AttrFromContext` without HTTP middleware | Context has no request attributes to extract | Install `slog-gin`/`echo`/`fiber`/`chi` middleware first |
| Using `Pipe` with no middleware | No-op wrapper adding per-record overhead | Remove `Pipe()` if no middleware needed |

## Performance Warnings

- **Fanout latency** = sum of all handler latencies (sequential). With 5 handlers at 10ms each, every log call costs 50ms. Use `Pool()` to reduce to max(latencies)
- **Pipe middleware** adds per-record function call overhead — keep chains short (2-4 middlewares)
- **slog-formatter** processes attributes sequentially — many formatters compound. For hot-path attribute formatting, prefer implementing `slog.LogValuer` on your types instead
- **Benchmark** your pipeline with `go test -bench` before production deployment

**Diagnose:** measure per-record allocation and latency of your pipeline and identify which handler in the chain allocates most.

## Best Practices

1. **Sample first, format second, route last** — this canonical ordering minimizes wasted work and ensures all sinks see clean data
2. **Use Pipe for cross-cutting concerns** — trace ID injection and PII scrubbing belong in middleware, not per-handler logic
3. **Test pipelines with `slogmulti.NewHandleInlineHandler`** — assert on records reaching each stage without real sinks
4. **Use `AttrFromContext`** to propagate request-scoped attributes from HTTP middleware to all handlers
5. **Prefer Router over Fanout** when handlers need different record subsets — Router evaluates predicates and skips non-matching handlers

## Cross-References

- → See `samber/cc-skills-golang@golang-observability` skill for slog fundamentals (levels, context, handler setup, migration)
- → See `samber/cc-skills-golang@golang-error-handling` skill for the log-or-return rule
- → See `samber/cc-skills-golang@golang-security` skill for PII handling in logs
- → See `samber/cc-skills-golang@golang-samber-oops` skill for structured error context with `samber/oops`

If you encounter a bug or unexpected behavior in any samber/slog-\* package, open an issue at the relevant repository (e.g., [slog-multi/issues](https://github.com/samber/slog-multi/issues), [slog-sampling/issues](https://github.com/samber/slog-sampling/issues)).
