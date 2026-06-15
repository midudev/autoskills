# Sampling Strategies

## Why Sample

High-throughput services generate enormous log volumes. At 10k RPS with 1KB per log entry, you produce 10MB/s — 864GB/day. Sampling reduces cost, network bandwidth, and storage without losing visibility into critical events.

The key insight: sample noise (Debug/Info), never errors. Combine sampling strategies with level-based routing so Warn/Error records always reach every sink.

## Strategy Comparison

| Strategy | Constructor | Behavior | Overhead | Best for |
| --- | --- | --- | --- | --- |
| Uniform | `UniformSamplingOption` | Drop fixed % of all records randomly | Minimal | Dev/staging noise reduction |
| Threshold | `ThresholdSamplingOption` | Log first N per interval, then sample at rate R | Low | Production — initial visibility then throttle |
| Absolute | `AbsoluteSamplingOption` | Cap at N records per interval globally | Medium | Hard cost/throughput cap |
| Custom | `CustomSamplingOption` | User function returns sample rate per record | Varies | Level-aware, time-aware, context-aware rules |

## Uniform Sampling

Simplest strategy. Drops a fixed percentage of all records uniformly.

```go
import slogsampling "github.com/samber/slog-sampling"

option := slogsampling.UniformSamplingOption{
    Rate: 0.33, // keep 33% of records
}

logger := slog.New(
    slogmulti.Pipe(option.NewMiddleware()).
        Handler(slog.NewJSONHandler(os.Stdout, nil)),
)
```

**Warning:** Uniform sampling drops errors and warnings at the same rate as debug logs. Only use in dev/staging or combine with level-based routing that bypasses sampling for high-severity records.

## Threshold Sampling

Logs the first N records with the same "hash" per interval, then switches to rate-based sampling. The hash is determined by the Matcher.

```go
option := slogsampling.ThresholdSamplingOption{
    Tick:      5 * time.Second,
    Threshold: 10,               // first 10 records per hash: always logged
    Rate:      0.1,              // after threshold: 10% sampling
    Matcher:   slogsampling.MatchByLevelAndMessage(), // default grouping
}
```

**Pattern:** "Show me the first 10 occurrences of each message per 5s window. After that, show every 10th." This preserves initial visibility into new issues while limiting noise from repeated messages.

## Absolute Sampling

Caps total throughput at a fixed number of records per interval, regardless of how many unique messages exist.

```go
option := slogsampling.AbsoluteSamplingOption{
    Tick:    1 * time.Second,
    Max:     1000,                           // cap at 1000 records/sec
    Matcher: slogsampling.MatchAll(),        // all records share one counter
}
```

**Use when:** You have a hard budget — e.g., "our log backend can handle 1000 records/sec max" or "we pay per GB ingested."

## Custom Sampling

Full control: return a sample rate [0.0, 1.0] per record based on any criteria.

```go
option := slogsampling.CustomSamplingOption{
    Sampler: func(ctx context.Context, record slog.Record) float64 {
        // Always log errors and warnings
        if record.Level >= slog.LevelWarn {
            return 1.0
        }
        // Night hours: log everything (low traffic)
        if record.Time.Hour() < 6 || record.Time.Hour() > 22 {
            return 1.0
        }
        // Business hours: heavy sampling for info/debug
        return 0.01 // 1%
    },
}
```

**When to use:** Complex rules that depend on time of day, log level, specific attributes, or context values. Higher overhead than other strategies because the function runs per record.

## Matchers — Record Grouping

Matchers determine how records are grouped for threshold/absolute counting. Records with the same hash share a counter.

| Matcher | Groups by | Use when |
| --- | --- | --- |
| `MatchAll()` | All records share one counter | Global throughput cap |
| `MatchByLevel()` | Log level | Different rates per level |
| `MatchByMessage()` | Message text | Deduplicate repeated messages |
| `MatchByLevelAndMessage()` | Level + message (default) | Standard deduplication |
| `MatchBySource()` | Source file:line | Group by call site |
| `MatchByAttribute(groups, key)` | Attribute value | Group by module, user, etc. |
| `MatchByContextValue(key)` | Context value | Group by request-scoped value |

## Chaining Multiple Strategies

Stack sampling strategies for layered control:

```go
// Layer 1: per-message deduplication (threshold)
threshold := slogsampling.ThresholdSamplingOption{
    Tick: 5 * time.Second, Threshold: 100, Rate: 0.1,
    Matcher: slogsampling.MatchByLevelAndMessage(),
}.NewMiddleware()

// Layer 2: global throughput cap (absolute)
absolute := slogsampling.AbsoluteSamplingOption{
    Tick: 1 * time.Second, Max: 1000,
    Matcher: slogsampling.MatchAll(),
}.NewMiddleware()

logger := slog.New(
    slogmulti.
        Pipe(threshold).  // first: per-message dedup
        Pipe(absolute).   // then: global cap
        Handler(handler),
)
```

## Pipeline Ordering

Sampling MUST be the first stage in the pipeline. Placing it after formatting or routing wastes CPU on records that get dropped.

```
// WRONG: format then sample — CPU wasted on dropped records
record → [Formatter] → [Sampling] → [Sink]

// RIGHT: sample then format — only surviving records get processed
record → [Sampling] → [Formatter] → [Sink]
```

To exempt errors from sampling, use a `FirstMatch` Router so error records match the first route and skip sampling:

```go
logger := slog.New(
    slogmulti.Router().
        Add(sentryHandler, slogmulti.LevelIs(slog.LevelError)).  // errors: no sampling, first match wins
        Add(slogmulti.                                            // everything else: sampled
            Pipe(samplingMiddleware).
            Handler(lokiHandler),
        ).
        FirstMatch().  // stop at first matching route — errors won't fall through to sampled path
        Handler(),
)
```

## Hook Functions — Observability on Sampling

Track how many records are dropped via `OnAccepted` and `OnDropped` hooks:

```go
var (
    acceptedCounter = prometheus.NewCounter(...)
    droppedCounter  = prometheus.NewCounter(...)
)

option := slogsampling.ThresholdSamplingOption{
    Tick: 5 * time.Second, Threshold: 10, Rate: 0.1,
    OnAccepted: func(ctx context.Context, record slog.Record) {
        acceptedCounter.Inc()
    },
    OnDropped: func(ctx context.Context, record slog.Record) {
        droppedCounter.Inc()
    },
}
```

This lets you monitor your sampling ratio in Prometheus/Grafana and tune thresholds based on actual traffic patterns.
