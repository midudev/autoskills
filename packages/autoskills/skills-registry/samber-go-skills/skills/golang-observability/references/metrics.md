# Metrics with Prometheus

→ See `samber/cc-skills-golang@golang-troubleshooting` skill for using metrics to diagnose production issues. → See `samber/cc-skills@promql-cli` skill for executing and testing PromQL queries via CLI.

When using the Prometheus client library, refer to the library's official documentation for up-to-date API signatures and examples.

## Metric Types

| Type | What it measures | Example | When to use |
| --- | --- | --- | --- |
| **Counter** | Cumulative total (only goes up) | Total requests, total errors | Counting events |
| **Gauge** | Current value (goes up and down) | In-flight requests, queue size, temperature | Current state |
| **Histogram** | Distribution of values in configurable buckets | Request duration, response size | Latency, sizes — when you need percentiles |
| **Summary** | Client-computed quantiles | Request duration (pre-computed P50, P99) | Rarely — prefer Histogram |

## Histogram vs Summary

This is one of the most common sources of confusion. Both measure distributions, but they work very differently.

**Histogram** stores observations in configurable buckets (e.g., 5ms, 10ms, 25ms, 50ms, 100ms, ...). Percentiles are computed at query time by Prometheus using `histogram_quantile()`. Because the raw bucket counts are stored server-side, histograms can be **aggregated across multiple instances** — essential for services running multiple replicas.

**Summary** computes quantiles (P50, P99, etc.) on the client side before sending them to Prometheus. This means the quantile values are pre-baked and **cannot be aggregated** — if you have 10 instances, you cannot combine their P99 values into a meaningful overall P99.

**Recommendation**: Histogram SHOULD be preferred over Summary in almost all cases. Summary is only useful when you need exact quantiles for a single instance and don't care about cross-instance aggregation.

## Tracking Percentiles (P50, P90, P99, P99.9)

Define a Histogram with appropriate buckets, then query percentiles with `histogram_quantile()`:

```go
import "github.com/prometheus/client_golang/prometheus"
import "github.com/prometheus/client_golang/prometheus/promauto"

var httpRequestDuration = promauto.NewHistogramVec(
    prometheus.HistogramOpts{
        Namespace: "myapp",
        Subsystem: "http",
        Name:      "request_duration_seconds",
        Help:      "HTTP request duration in seconds.",
        Buckets:   prometheus.DefBuckets, // .005, .01, .025, .05, .1, .25, .5, 1, 2.5, 5, 10
    },
    []string{"method", "path", "status"},
)

// In your handler or middleware:
func instrumentHandler(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        start := time.Now()
        sw := &statusWriter{ResponseWriter: w, status: 200}
        next.ServeHTTP(sw, r)
        httpRequestDuration.WithLabelValues(
            r.Method,
            r.URL.Path,
            strconv.Itoa(sw.status),
        ).Observe(time.Since(start).Seconds())
    })
}
```

**PromQL queries for percentiles:**

```promql
# P50 (median) over the last 5 minutes
histogram_quantile(0.50, rate(myapp_http_request_duration_seconds_bucket[5m]))

# P90
histogram_quantile(0.90, rate(myapp_http_request_duration_seconds_bucket[5m]))

# P99
histogram_quantile(0.99, rate(myapp_http_request_duration_seconds_bucket[5m]))

# P99.9
histogram_quantile(0.999, rate(myapp_http_request_duration_seconds_bucket[5m]))

# P99 broken down by path
histogram_quantile(0.99, sum(rate(myapp_http_request_duration_seconds_bucket[5m])) by (le, path))
```

## Naming Conventions

Metric names MUST follow the [Prometheus naming best practices](https://prometheus.io/docs/practices/naming/). The pattern is: `<namespace>_<subsystem>_<name>_<unit>`

**Rules:**

- Use a single-word application prefix (namespace) relevant to the domain
- A metric must refer to a single unit and single quantity
- Include the unit as a suffix, in **plural** form
- MUST use **base units** — not derived units

**Always use base units:**

| Measurement   | Use            | Not                         |
| ------------- | -------------- | --------------------------- |
| Time          | `_seconds`     | `_milliseconds`, `_minutes` |
| Data size     | `_bytes`       | `_kilobytes`, `_megabytes`  |
| Temperature   | `_celsius`     | `_fahrenheit`               |
| Ratio/percent | `_ratio` (0–1) | `_percent` (0–100)          |
| Mass          | `_grams`       | `_kilograms`                |

**Suffix conventions:**

| Suffix | When to use | Example |
| --- | --- | --- |
| `_total` | Counters MUST use this suffix | `myapp_http_requests_total` |
| `_seconds` | Duration measurements | `myapp_http_request_duration_seconds` |
| `_bytes` | Data sizes | `myapp_response_size_bytes` |
| `_info` | Pseudo-metrics exposing metadata | `myapp_build_info` |
| `_created` | Creation timestamp of a counter | `myapp_http_requests_created` |

```go
// ✓ Good — namespace, subsystem, descriptive name, base unit suffix
myapp_http_requests_total              // Counter
myapp_http_request_duration_seconds    // Histogram — seconds, not milliseconds
myapp_http_response_size_bytes         // Histogram — bytes, not kilobytes
myapp_db_connections_active            // Gauge
myapp_queue_messages_pending           // Gauge
process_cpu_seconds_total              // Counter — total CPU time in seconds

// ✗ Bad
request_count             // no namespace, no unit suffix
httpDuration              // camelCase, no unit
request_duration_ms       // milliseconds instead of seconds
myapp_request_size_kb     // kilobytes instead of bytes
```

**Label naming:** do not embed label names into the metric name. Use labels to differentiate characteristics:

```go
// ✗ Bad — operation embedded in metric name
myapp_http_get_requests_total
myapp_http_post_requests_total

// ✓ Good — use a label
myapp_http_requests_total{method="GET"}
myapp_http_requests_total{method="POST"}
```

**Semantic consistency:** `sum()` or `avg()` over all label dimensions of a metric should be meaningful. If not, split into separate metrics.

## Exposing Metrics

```go
import "github.com/prometheus/client_golang/prometheus/promhttp"

mux.Handle("/metrics", promhttp.Handler())
```

## Document Metrics with PromQL Comments

EVERY METRIC declaration SHOULD include the relevant PromQL queries and alert rules as comments directly above the variable. This makes metrics self-documenting — when a developer reads the code, they immediately see how the metric is used in dashboards and alerts, without hunting through Grafana or alert configurations.

```go
// ✗ Bad — metric exists but nobody knows how to query or alert on it
var httpRequestsTotal = promauto.NewCounterVec(...)

// ✓ Good — PromQL queries and alert rules are part of the code
//
// Dashboard: rate(myapp_http_requests_total[5m])
// Dashboard: sum by (status) (rate(myapp_http_requests_total[5m]))
// Alert:     sum(rate(myapp_http_requests_total{status=~"5.."}[5m])) / sum(rate(myapp_http_requests_total[5m])) > 0.01
var httpRequestsTotal = promauto.NewCounterVec(...)
```

This convention has practical benefits: PromQL queries are reviewed in PRs alongside the metric, queries stay in sync with metric changes (label renames, bucket changes), and new team members can understand the metric's purpose at a glance.

## Metric Examples and PromQL Queries

Production-ready metrics covering all four types with comprehensive PromQL for dashboards and alerts.

For infrastructure and dependency alerting (databases, caches, message brokers, reverse proxies, Kubernetes), [awesome-prometheus-alerts](https://samber.github.io/awesome-prometheus-alerts/) provides a curated collection of ~500 ready-to-use Prometheus alerting rules organized by technology. See [alerting.md](alerting.md) for integration details and Go runtime alerts.

NEVER use `irate(...)` for alerts — use `rate(...)` instead.

### Counters — tracking events

```go
// Dashboard: rate(myapp_http_requests_total[5m])
// Dashboard: sum by (status) (rate(myapp_http_requests_total[5m]))
// Dashboard: sum by (path) (rate(myapp_http_requests_total[5m]))
// Dashboard: topk(5, sum by (path) (rate(myapp_http_requests_total[5m])))
// Dashboard: increase(myapp_http_requests_total[1h])
// SLI:      1 - (sum(rate(myapp_http_requests_total{status=~"5.."}[5m])) / sum(rate(myapp_http_requests_total[5m])))
// Alert:    sum(rate(myapp_http_requests_total{status=~"5.."}[5m])) / sum(rate(myapp_http_requests_total[5m])) > 0.01
// Alert:    sum(rate(myapp_http_requests_total{status=~"5.."}[1m])) / sum(rate(myapp_http_requests_total[1m])) > 0.05
var httpRequestsTotal = promauto.NewCounterVec(
    prometheus.CounterOpts{
        Namespace: "myapp",
        Subsystem: "http",
        Name:      "requests_total",
        Help:      "Total number of HTTP requests.",
    },
    []string{"method", "path", "status"},
)

// Dashboard: sum by (type) (rate(myapp_errors_total[5m]))
// Dashboard: topk(3, sum by (type) (rate(myapp_errors_total[5m])))
// Alert:    rate(myapp_errors_total{type="database"}[5m]) > 0.5
var errorsTotal = promauto.NewCounterVec(
    prometheus.CounterOpts{
        Namespace: "myapp",
        Name:      "errors_total",
        Help:      "Total number of errors by type.",
    },
    []string{"type"}, // "database", "external_api", "validation"
)

// Dashboard: sum by (payment_method) (rate(myapp_orders_created_total[5m]))
// Dashboard: increase(myapp_orders_created_total[24h])
// Alert:    rate(myapp_orders_created_total[30m]) == 0
var ordersCreated = promauto.NewCounterVec(
    prometheus.CounterOpts{
        Namespace: "myapp",
        Subsystem: "orders",
        Name:      "created_total",
        Help:      "Total number of orders created.",
    },
    []string{"payment_method"},
)
```

**Key PromQL patterns for counters:**

```promql
# Requests per second (smoothed over 5 minutes)
rate(myapp_http_requests_total[5m])

# Traffic by status code — see distribution of 2xx/4xx/5xx
sum by (status) (rate(myapp_http_requests_total[5m]))

# Top 5 busiest endpoints
topk(5, sum by (path) (rate(myapp_http_requests_total[5m])))

# Absolute request count in the last hour (useful for reports)
increase(myapp_http_requests_total[1h])

# Error ratio — fraction of requests returning 5xx (SLI)
sum(rate(myapp_http_requests_total{status=~"5.."}[5m]))
/
sum(rate(myapp_http_requests_total[5m]))

# 4xx error ratio — client errors (useful for spotting bad deployments)
sum(rate(myapp_http_requests_total{status=~"4.."}[5m]))
/
sum(rate(myapp_http_requests_total[5m]))

# Alert: error rate > 1% for 5 minutes (for: 5m)
sum(rate(myapp_http_requests_total{status=~"5.."}[5m]))
/
sum(rate(myapp_http_requests_total[5m]))
> 0.01

# Alert: spike detection — error rate > 5% over 1 minute (for: 2m)
sum(rate(myapp_http_requests_total{status=~"5.."}[1m]))
/
sum(rate(myapp_http_requests_total[1m]))
> 0.05

# Alert: zero orders for 30 minutes — business is broken (for: 30m)
rate(myapp_orders_created_total[30m]) == 0
```

### Gauges — tracking current state

```go
// Dashboard: myapp_http_in_flight_requests
// Alert:    myapp_http_in_flight_requests > 500
var httpInFlightRequests = promauto.NewGauge(
    prometheus.GaugeOpts{
        Namespace: "myapp",
        Subsystem: "http",
        Name:      "in_flight_requests",
        Help:      "Number of HTTP requests currently being processed.",
    },
)

// Dashboard: myapp_db_connections_active
// Dashboard: myapp_db_connections_active / myapp_db_connections_max
// Alert:    myapp_db_connections_active{pool="write"} / myapp_db_connections_max{pool="write"} > 0.9
// Alert:    predict_linear(myapp_db_connections_active[15m], 600) > myapp_db_connections_max
var dbConnectionsActive = promauto.NewGaugeVec(
    prometheus.GaugeOpts{
        Namespace: "myapp",
        Subsystem: "db",
        Name:      "connections_active",
        Help:      "Number of active database connections.",
    },
    []string{"pool"}, // "read", "write"
)

var dbConnectionsMax = promauto.NewGaugeVec(
    prometheus.GaugeOpts{
        Namespace: "myapp",
        Subsystem: "db",
        Name:      "connections_max",
        Help:      "Maximum database connections in the pool.",
    },
    []string{"pool"},
)

// Dashboard: myapp_queue_messages_pending
// Dashboard: deriv(myapp_queue_messages_pending[5m])
// Alert:    myapp_queue_messages_pending{queue_name="orders"} > 1000
// Alert:    deriv(myapp_queue_messages_pending[10m]) > 50
// Alert:    predict_linear(myapp_queue_messages_pending[30m], 3600) > 10000
var queueSize = promauto.NewGaugeVec(
    prometheus.GaugeOpts{
        Namespace: "myapp",
        Subsystem: "queue",
        Name:      "messages_pending",
        Help:      "Number of messages waiting to be processed.",
    },
    []string{"queue_name"},
)

// Dashboard: myapp_workers_active / myapp_workers_max
// Alert:    myapp_workers_active / myapp_workers_max > 0.8
var workersActive = promauto.NewGauge(
    prometheus.GaugeOpts{
        Namespace: "myapp",
        Name:      "workers_active",
        Help:      "Number of worker goroutines currently processing jobs.",
    },
)

// Usage in middleware:
func instrumentMiddleware(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        httpInFlightRequests.Inc()
        defer httpInFlightRequests.Dec()
        next.ServeHTTP(w, r)
    })
}
```

**Key PromQL patterns for gauges:**

```promql
# Current value — gauges are queried directly
myapp_http_in_flight_requests

# Saturation — what fraction of the pool is in use
myapp_db_connections_active{pool="write"} / myapp_db_connections_max{pool="write"}

# Rate of change — is the queue growing or shrinking? (items/second)
deriv(myapp_queue_messages_pending[5m])

# Prediction — will the connection pool be exhausted in 10 minutes?
# predict_linear extrapolates the trend from the last 15 minutes
predict_linear(myapp_db_connections_active[15m], 600) > myapp_db_connections_max

# Prediction — will the queue exceed 10k items in 1 hour?
predict_linear(myapp_queue_messages_pending[30m], 3600) > 10000

# Alert: connection pool > 90% saturated (for: 5m)
myapp_db_connections_active{pool="write"} / myapp_db_connections_max{pool="write"} > 0.9

# Alert: queue depth growing faster than 50 items/sec (for: 10m)
deriv(myapp_queue_messages_pending[10m]) > 50

# Alert: worker pool saturated (for: 5m)
myapp_workers_active / myapp_workers_max > 0.8
```

### Histograms — tracking distributions (recommended for latency)

```go
// Dashboard: histogram_quantile(0.50, sum(rate(myapp_http_request_duration_seconds_bucket[5m])) by (le))
// Dashboard: histogram_quantile(0.90, sum(rate(myapp_http_request_duration_seconds_bucket[5m])) by (le))
// Dashboard: histogram_quantile(0.99, sum(rate(myapp_http_request_duration_seconds_bucket[5m])) by (le))
// Dashboard: histogram_quantile(0.99, sum(rate(myapp_http_request_duration_seconds_bucket[5m])) by (le, path))
// SLI:      sum(rate(myapp_http_request_duration_seconds_bucket{le="0.3"}[5m])) / sum(rate(myapp_http_request_duration_seconds_count[5m]))
// Alert:    histogram_quantile(0.99, sum(rate(myapp_http_request_duration_seconds_bucket[5m])) by (le)) > 2
var httpRequestDuration = promauto.NewHistogramVec(
    prometheus.HistogramOpts{
        Namespace: "myapp",
        Subsystem: "http",
        Name:      "request_duration_seconds",
        Help:      "HTTP request duration in seconds.",
        Buckets:   []float64{.005, .01, .025, .05, .1, .25, .5, 1, 2.5, 5, 10},
    },
    []string{"method", "path", "status"},
)

// Dashboard: histogram_quantile(0.95, sum(rate(myapp_external_call_duration_seconds_bucket[5m])) by (le, service))
// Alert:    histogram_quantile(0.99, sum(rate(myapp_external_call_duration_seconds_bucket[5m])) by (le, service)) > 5
var externalAPICallDuration = promauto.NewHistogramVec(
    prometheus.HistogramOpts{
        Namespace: "myapp",
        Subsystem: "external",
        Name:      "call_duration_seconds",
        Help:      "Duration of external API calls in seconds.",
        Buckets:   []float64{.01, .05, .1, .25, .5, 1, 2.5, 5, 10, 30},
    },
    []string{"service", "endpoint"},
)

// Dashboard: histogram_quantile(0.95, sum(rate(myapp_orders_amount_dollars_bucket[5m])) by (le))
var orderAmount = promauto.NewHistogramVec(
    prometheus.HistogramOpts{
        Namespace: "myapp",
        Subsystem: "orders",
        Name:      "amount_dollars",
        Help:      "Order amount in dollars.",
        Buckets:   []float64{1, 5, 10, 25, 50, 100, 250, 500, 1000, 5000},
    },
    []string{"payment_method"},
)
```

**Key PromQL patterns for histograms:**

```promql
# Percentile latencies — the core latency dashboard
histogram_quantile(0.50, sum(rate(myapp_http_request_duration_seconds_bucket[5m])) by (le))  # P50
histogram_quantile(0.90, sum(rate(myapp_http_request_duration_seconds_bucket[5m])) by (le))  # P90
histogram_quantile(0.95, sum(rate(myapp_http_request_duration_seconds_bucket[5m])) by (le))  # P95
histogram_quantile(0.99, sum(rate(myapp_http_request_duration_seconds_bucket[5m])) by (le))  # P99
histogram_quantile(0.999, sum(rate(myapp_http_request_duration_seconds_bucket[5m])) by (le)) # P99.9

# P99 latency broken down by endpoint — find the slowest paths
histogram_quantile(0.99, sum(rate(myapp_http_request_duration_seconds_bucket[5m])) by (le, path))

# Average latency (mean) — useful alongside percentiles
sum(rate(myapp_http_request_duration_seconds_sum[5m]))
/
sum(rate(myapp_http_request_duration_seconds_count[5m]))

# Apdex-like SLI — fraction of requests under 300ms (target threshold)
sum(rate(myapp_http_request_duration_seconds_bucket{le="0.3"}[5m]))
/
sum(rate(myapp_http_request_duration_seconds_count[5m]))

# Request throughput from histogram (requests/sec)
sum(rate(myapp_http_request_duration_seconds_count[5m]))

# External API P95 latency per service
histogram_quantile(0.95, sum(rate(myapp_external_call_duration_seconds_bucket[5m])) by (le, service))

# Alert: P99 latency > 2s (for: 5m)
histogram_quantile(0.99, sum(rate(myapp_http_request_duration_seconds_bucket[5m])) by (le)) > 2

# Alert: P95 latency > 500ms (for: 10m)
histogram_quantile(0.95, sum(rate(myapp_http_request_duration_seconds_bucket[5m])) by (le)) > 0.5

# Alert: external API P99 > 5s (for: 5m)
histogram_quantile(0.99, sum(rate(myapp_external_call_duration_seconds_bucket[5m])) by (le, service)) > 5

# Alert: less than 95% of requests under 300ms (SLO breach) (for: 10m)
(
  sum(rate(myapp_http_request_duration_seconds_bucket{le="0.3"}[5m]))
  /
  sum(rate(myapp_http_request_duration_seconds_count[5m]))
) < 0.95
```

### Summary — client-side quantiles (use sparingly)

Summaries compute quantiles on the client and cannot be aggregated across instances. Use them only for single-process diagnostics where exact quantiles matter. Prefer Histogram in all other cases.

```go
// Dashboard: myapp_jobs_processing_seconds{quantile="0.5"}
// Dashboard: myapp_jobs_processing_seconds{quantile="0.99"}
// Note: these quantiles CANNOT be aggregated across instances
var jobProcessingDuration = promauto.NewSummary(
    prometheus.SummaryOpts{
        Namespace:  "myapp",
        Subsystem:  "jobs",
        Name:       "processing_seconds",
        Help:       "Job processing duration in seconds.",
        Objectives: map[float64]float64{0.5: 0.05, 0.9: 0.01, 0.99: 0.001},
        MaxAge:     10 * time.Minute,
    },
)
```

## Multi-Window Burn-Rate SLO Alerting

For critical services, simple threshold alerts ("error rate > 1%") fire too late for fast incidents and too early for slow ones. Multi-window burn-rate alerting scales alert urgency to how fast you're consuming your error budget.

For a **99.9% availability SLO** (0.1% error budget over 30 days):

| Window | Burn rate | Error rate | Severity | Meaning |
| --- | --- | --- | --- | --- |
| 5m + 1h | 14.4x | > 1.44% | Critical (page) | Budget exhausted in ~2 days |
| 30m + 6h | 6x | > 0.6% | Critical (page) | Budget exhausted in ~5 days |
| 2h + 24h | 1x | > 0.1% | Warning (ticket) | On track to exhaust budget |

```promql
# Fast burn — page immediately (for: 2m)
# Both short and long windows must fire to avoid noise from brief spikes
(
  (1 - sum(rate(myapp_http_requests_total{status=~"2.."}[5m])) / sum(rate(myapp_http_requests_total[5m]))) > 0.0144
  and
  (1 - sum(rate(myapp_http_requests_total{status=~"2.."}[1h])) / sum(rate(myapp_http_requests_total[1h]))) > 0.0144
)

# Medium burn — page (for: 15m)
(
  (1 - sum(rate(myapp_http_requests_total{status=~"2.."}[30m])) / sum(rate(myapp_http_requests_total[30m]))) > 0.006
  and
  (1 - sum(rate(myapp_http_requests_total{status=~"2.."}[6h])) / sum(rate(myapp_http_requests_total[6h]))) > 0.006
)

# Slow burn — ticket (for: 1h)
(
  (1 - sum(rate(myapp_http_requests_total{status=~"2.."}[2h])) / sum(rate(myapp_http_requests_total[2h]))) > 0.001
  and
  (1 - sum(rate(myapp_http_requests_total{status=~"2.."}[24h])) / sum(rate(myapp_http_requests_total[24h]))) > 0.001
)
```

The short window catches the incident fast; the long window confirms it's sustained. Together they eliminate false positives from transient blips.

## High-Cardinality Labels

NEVER use high-cardinality labels (user IDs, full URLs, request IDs). Every unique combination of label values creates a separate time series in Prometheus. Unbounded labels cause memory explosion on the Prometheus server, slow queries, and can crash the monitoring stack.

```go
// ✗ Bad — unbounded cardinality (millions of unique values)
httpRequestsTotal.WithLabelValues(r.URL.Path)    // /users/alice, /users/bob, /users/charlie...
httpRequestsTotal.WithLabelValues(userID)          // one series per user
httpRequestsTotal.WithLabelValues(r.Header.Get("X-Request-ID")) // one series per request!

// ✓ Good — bounded, normalized labels
httpRequestsTotal.WithLabelValues(routePattern)   // /users/:id (the route template, not the actual path)
httpRequestsTotal.WithLabelValues(r.Method)        // GET, POST, PUT, DELETE (5 values)
httpRequestsTotal.WithLabelValues(statusBucket)    // "2xx", "3xx", "4xx", "5xx" (4 values)
```

**How to limit cardinality:**

- Use route templates (`/users/:id`) instead of actual paths (`/users/alice`)
- Bucket status codes (`2xx`, `4xx`, `5xx`) instead of exact codes (200, 201, 204, 400, 401, ...)
- Never use user IDs, request IDs, session IDs, or email addresses as labels
- Use attributes/tags in traces instead — traces handle high cardinality naturally
- **Rule of thumb**: if a label can have more than ~100 unique values, it's too many
