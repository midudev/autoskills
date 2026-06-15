# Alerting

> See [metrics.md](metrics.md) for multi-window burn-rate SLO alerting and PromQL patterns for application metrics.

## The Four Golden Signals

Alert on what matters to users. Google's SRE book defines four golden signals — every Go service SHOULD have alerts covering all four:

| Signal | What it measures | Example metric | Alert trigger |
| --- | --- | --- | --- |
| **Latency** | Time to serve a request | `http_request_duration_seconds` (Histogram) | P99 > 2s for 5 minutes |
| **Traffic** | Demand on the system | `http_requests_total` (Counter) | Zero requests for 10 minutes |
| **Errors** | Rate of failed requests | `http_requests_total{status=~"5.."}` (Counter) | Error ratio > 1% for 5 minutes |
| **Saturation** | How full the system is | `db_connections_active / db_connections_max` | Pool > 90% saturated for 5 minutes |

## Awesome Prometheus Alerts

[awesome-prometheus-alerts](https://samber.github.io/awesome-prometheus-alerts/) is a curated collection of ~500 ready-to-use Prometheus alerting rules. This collection serves as a starting point for infrastructure and dependency alerting.

### Categories

| Category | Rules | Covers |
| --- | --: | --- |
| **Basic Resource Monitoring** | ~107 | Host metrics, Docker containers, hardware |
| **Databases and Brokers** | ~233 | PostgreSQL, MySQL, Redis, MongoDB, Kafka, RabbitMQ, etc. |
| **Reverse Proxies and Load Balancers** | ~45 | Nginx, Apache, HAProxy, Traefik |
| **Runtimes** | ~4 | PHP-FPM, JVM, Sidekiq |
| **Orchestrators** | ~74 | Kubernetes, Nomad, Consul, ArgoCD |
| **Network, Security, and Storage** | ~40 | Ceph, MinIO, SSL/TLS, DNS |

### How to Use It

The rules are organized by technology. Each rule is a ready-to-use Prometheus alerting rule in YAML format with customizable threshold values and `for:` durations.

1. **Find by technology** — locate the relevant database, message broker, or infrastructure component
2. **Adapt the YAML rule** — adjust threshold values (`> 0.01`, `> 100`, etc.) and the `for:` duration to match your SLOs and traffic patterns
3. **Place in Prometheus config** — add to the `prometheus/rules/` directory

### Integration Example

Prometheus loads alerting rules from YAML files referenced in its config. After copying rules from awesome-prometheus-alerts, place them in your rules directory:

```yaml
# prometheus/rules/postgresql.yml
groups:
  - name: postgresql
    rules:
      # From awesome-prometheus-alerts — PostgreSQL section
      - alert: PostgresqlDown
        expr: pg_up == 0
        for: 0m
        labels:
          severity: critical
        annotations:
          summary: "PostgreSQL down (instance {{ $labels.instance }})"
          description: "PostgreSQL instance is down.\n  VALUE = {{ $value }}"

      - alert: PostgresqlTooManyConnections
        expr: sum by (instance, datname) (pg_stat_activity_count{datname!~"template.*|postgres"}) > pg_settings_max_connections * 0.8
        for: 2m
        labels:
          severity: warning
        annotations:
          summary: "PostgreSQL too many connections (> 80%) (instance {{ $labels.instance }})"
          description: "PostgreSQL has {{ $value }} connections on {{ $labels.datname }}."
```

```yaml
# prometheus.yml
rule_files:
  - "rules/*.yml"
```

### Workflow for New Dependencies

When adding a new infrastructure dependency (database, cache, message broker, reverse proxy) to a Go service:

1. [awesome-prometheus-alerts](https://samber.github.io/awesome-prometheus-alerts/) has alert rules organized by technology
2. Adapt the relevant alert rules and thresholds to your environment
3. Verify the exporter is deployed (e.g., `postgres_exporter`, `redis_exporter`) — the alerts depend on metrics from these exporters
4. Add the rules to your `prometheus/rules/` directory

## Go Runtime Alerts

The Prometheus Go client automatically exposes runtime metrics. Alert on these to catch resource leaks and GC pressure before they impact users.

```yaml
# prometheus/rules/go-runtime.yml
groups:
  - name: go-runtime
    rules:
      # Goroutine leak — count growing steadily indicates a leak
      # Diagnose: GET /debug/pprof/goroutine?debug=1 to see goroutine stack traces
      - alert: GoroutineLeak
        expr: go_goroutines > 1000
        for: 10m
        labels:
          severity: warning
        annotations:
          summary: "High goroutine count (instance {{ $labels.instance }})"
          description: "Goroutine count is {{ $value }}, possible leak."

      # GC taking too long — P99 GC pause > 100ms degrades tail latency
      - alert: HighGCDuration
        expr: go_gc_duration_seconds{quantile="1"} > 0.1
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "High GC duration (instance {{ $labels.instance }})"
          description: "Max GC pause is {{ $value }}s. Check heap allocations."

      # Heap growing unbounded — likely a memory leak
      - alert: HighMemoryUsage
        expr: go_memstats_alloc_bytes / go_memstats_sys_bytes > 0.9
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: "High memory usage (instance {{ $labels.instance }})"
          description: "Allocated heap is {{ $value | humanizePercentage }} of system memory."

      # Too many threads — usually caused by blocking syscalls or cgo
      - alert: HighThreadCount
        expr: go_threads > 500
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "High OS thread count (instance {{ $labels.instance }})"
          description: "Thread count is {{ $value }}. Check for blocking syscalls."
```

## Alert Severity Levels

Use two severity levels to separate "wake someone up" from "look at it tomorrow":

| Severity | Action | `for:` duration | Example |
| --- | --- | --- | --- |
| **critical** | Page on-call | 2-5 minutes | Service down, error rate > 5%, data loss risk |
| **warning** | Create ticket | 10-30 minutes | P99 latency high, connection pool > 80%, goroutine leak |

The `for:` duration controls how long a condition must be true before the alert fires. Short durations catch fast incidents but risk false positives from transient spikes. Long durations reduce noise but delay response.

**Guidelines:**

- Critical alerts: `for: 2m` to `for: 5m` — fast detection, wake someone up
- Warning alerts: `for: 10m` to `for: 30m` — confirmed trend, create a ticket
- NEVER set `for: 0m` on non-binary alerts — one bad scrape triggers a false page
- Binary alerts (service up/down) can use `for: 0m` or `for: 1m`

## Common Mistakes

```yaml
# Bad -- irate() is too volatile for alerts, reacts to a single scrape interval
# A brief spike or a single slow request triggers the alert
- alert: HighErrorRate
  expr: irate(http_requests_total{status=~"5.."}[5m]) > 0.01

# Good -- rate() smooths over the full window, reducing false positives
- alert: HighErrorRate
  expr: rate(http_requests_total{status=~"5.."}[5m]) / rate(http_requests_total[5m]) > 0.01
  for: 5m
```

```yaml
# Bad -- no "for:" duration, fires on a single bad scrape
- alert: HighLatency
  expr: histogram_quantile(0.99, rate(http_request_duration_seconds_bucket[5m])) > 2

# Good -- must be true for 5 minutes to fire
- alert: HighLatency
  expr: histogram_quantile(0.99, rate(http_request_duration_seconds_bucket[5m])) > 2
  for: 5m
```

```yaml
# Bad -- alerting on raw gauge without trend analysis (flaps constantly)
- alert: HighQueueDepth
  expr: myapp_queue_messages_pending > 1000

# Good -- alert on sustained growth trend
- alert: HighQueueDepth
  expr: myapp_queue_messages_pending > 1000
  for: 10m
```
