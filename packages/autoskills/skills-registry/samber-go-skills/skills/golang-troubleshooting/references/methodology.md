# General Debugging Methodology

For any bug, follow this systematic process:

## Step 1: Understand Expected vs Actual

Before touching code, articulate clearly:

- What **should** happen?
- What **actually** happens?
- What **changed** recently?

```bash
# What changed recently?
git log --oneline -20
git diff HEAD~5

# Binary search for the breaking commit
git bisect start
git bisect bad          # current commit is broken
git bisect good abc123  # this commit was working
# git bisect will walk you to the breaking commit
```

## Step 2: Get the Full Error

```bash
# Full build errors
go build ./... 2>&1

# Verbose test output
go test ./... -v 2>&1

# Static analysis
go vet ./...

# Run linters — see the golang-lint skill for configuration
golangci-lint run ./...
```

Run `golangci-lint` early in your debugging workflow. It catches unchecked errors, suspicious constructs, and many other issues that are easy to miss by reading code. See the `samber/cc-skills-golang@golang-lint` skill for configuration and usage.

## Step 3: Isolate the Problem

Narrow the scope before investigating deeper:

```bash
# Does a single test fail?
go test -run TestSpecificName -v ./pkg/...

# Does it fail without cache?
go test -count=1 -run TestSpecificName ./pkg/...

# Is it a specific package?
go build ./pkg/suspect/...

# Is it flaky? Run multiple times
go test -count=10 -run TestSuspect ./pkg/...
```

Write more tests if you suspect missing test cases or need to test something in different conditions.

## Step 4: Check External Dependencies

Sometimes the bug is not in your code. Before diving deeper, verify that external components behave as expected:

```bash
# Reproduce an API call outside your app
curl -v -X POST https://api.example.com/endpoint \
  -H "Content-Type: application/json" \
  -d '{"key": "value"}'

# Check database content directly
psql -h localhost -U myuser -d mydb -c "SELECT * FROM orders WHERE id = 123"
# Or: mysql, mongosh, redis-cli, etc.
# Or use a database MCP server to query interactively

# Test connectivity and DNS resolution
dig api.example.com
nc -zv api.example.com 443

# Check if an external service is responding at all
curl -o /dev/null -s -w "HTTP %{http_code} in %{time_total}s\n" https://api.example.com/health

# Inspect message queue state
rabbitmqctl list_queues
# Or: kafka-console-consumer, redis-cli LLEN, etc.

# Check certificate validity
openssl s_client -connect api.example.com:443 -brief

# Verify environment variables and config
env | grep DATABASE
env | grep API_KEY
```

**Common external causes:**

- API contract changed (new required field, different response shape, deprecated endpoint)
- Database schema drift (missing column, changed type, new constraint, migration not applied)
- Expired or rotated credentials, tokens, or certificates
- DNS resolution failure or stale DNS cache
- Rate limiting or quota exhaustion
- External service degraded (slow responses, partial failures, 5xx errors)
- Message queue full, consumer lag, or rebalancing
- Different behavior between environments (staging vs production config, feature flags)
- Clock skew affecting JWT validation, cache TTLs, or scheduled jobs
- TLS/mTLS misconfiguration or CA bundle mismatch
- Network policy or firewall rule change blocking traffic
- Proxy or load balancer misconfiguration (wrong backend, sticky sessions, health check)
- Disk full or read-only filesystem
- File permissions changed
- OOM killer terminated a dependency (database, cache, sidecar)
- Docker/K8s: wrong image tag, missing env var, resource limits, liveness probe misconfigured
- Third-party SDK or library upgrade with breaking behavioral change
- Locale, timezone, or encoding mismatch between systems
- Connection pool exhaustion (database, HTTP, gRPC)
- Upstream returning cached/stale data
- Network issue. Webhook or callback URL changed or unreachable

## Step 5: Check Observability Tools

Production debugging MUST start with observability data. The project may already use observability tools that have the answer — look for imports or dependencies like `prometheus`, `opentelemetry`, `datadog`, `sentry`, `elastic/apm` in the codebase. Even if you don't see them in code, the developer may have them deployed separately.

If the information is missing, **ask the user** what monitoring and observability tools they use. Common stacks:

- **Prometheus + Grafana** — Dashboards may show error rate spikes, latency changes, resource saturation. Query examples:

  ```promql
  rate(http_requests_total{status=~"5.."}[5m])           # error rate
  histogram_quantile(0.99, rate(http_duration_seconds_bucket[5m]))  # p99 latency
  go_goroutines                                           # goroutine count over time
  go_memstats_alloc_bytes                                 # heap allocations
  rate(go_gc_duration_seconds_sum[5m])                    # GC pressure
  ```

- **Datadog** — APM traces, error tracking, and infrastructure metrics are available. Query examples:

  ```
  avg:trace.http.request.duration{service:myapp} by {resource_name}
  sum:trace.http.request.errors{service:myapp}.as_count()
  avg:runtime.go.num_goroutine{service:myapp}
  ```

- **Sentry** — Captured exceptions, breadcrumbs, and error grouping are available. Sentry often captures the full stack trace and context of the first occurrence.
- **ELK (Elasticsearch + Logstash + Kibana)** — Structured logs can be searched for error patterns:

  ```
  level:error AND service:myapp AND @timestamp:[now-1h TO now]
  ```

- **OpenTelemetry / Jaeger / Zipkin** — Distributed traces show latency breakdowns across services, failed spans, and propagation issues.

If the user has an MCP server for any of these tools (Datadog MCP, Grafana MCP, etc.), interactive queries may be available through it.

## Step 6: Compare with Working Code

Before forming a hypothesis, find similar code that **works**:

- Search the codebase for analogous functionality that doesn't have the bug
- Read the working reference implementation **completely** — don't skim
- List **every difference** between the working code and the broken code
- Check: are the dependencies the same? The config? The initialization order? The error handling?

Often the bug becomes obvious when you see what the working version does differently.

## Step 7: Form a Hypothesis and Test It

- Form a **single, specific** hypothesis with clear reasoning
- Add targeted logging or a focused test
- Change **one thing**, observe, confirm or reject
- If the hypothesis was wrong, **revert the change** — don't stack fixes on top of failed attempts

## Step 8: Trace to Root Cause

When the symptom appears deep in the call stack, don't fix where the error surfaces. Trace backward:

1. **Find the immediate cause** — what line panics or returns the wrong value?
2. **Ask "what called this?"** — trace one level up the call chain
3. **Keep tracing** — repeat until you find where the invalid data **originated**, not where it was **consumed**
4. **Fix at the source** — the fix belongs where the bad value was created, not where it caused a crash

```go
// Example: panic in handler — but the bug is in the constructor
// ✗ Bad — fixing at the symptom
func (s *Server) Handle(w http.ResponseWriter, r *http.Request) {
    if s.db == nil {  // nil check masks the real bug
        http.Error(w, "db unavailable", 500)
        return
    }
    // ...
}

// ✓ Good — fixing at the source
func NewServer(db *sql.DB) *Server {
    if db == nil {
        panic("NewServer: db must not be nil")  // fail fast at construction
    }
    return &Server{db: db}
}
```

When you can't trace manually, add temporary instrumentation:

```go
// Log the full call chain before the dangerous operation
func suspectFunction(val string) {
    fmt.Fprintf(os.Stderr, "DEBUG suspectFunction: val=%q\n%s\n", val, debug.Stack())
    // ...
}
```

## Step 9: Fix and Verify

- Fix the root cause, not the symptom
- The failing test from step 1 should now pass
- Run the full test suite to check for regressions

## Step 10: Defense-in-Depth

After fixing a bug, ask: "How do I make this bug structurally impossible?" A single fix at one layer can be bypassed by different code paths or future refactoring. Add validation at multiple layers:

1. **Entry point** — reject invalid input at public API boundaries (`New*` constructors, exported functions)
2. **Business logic** — assert preconditions inside internal functions that receive the data
3. **Runtime guards** — use build tags or env checks to catch dangerous operations in tests (e.g., refuse writes outside temp dirs)
4. **Observability** — add structured logging or metrics so the same class of bug is instantly visible if it recurs

Not every fix needs all four layers — use judgment. But when a bug could cause data loss, corruption, or security issues, multi-layer defense is worth the cost.

## When You're Stuck: Escalation Protocol

If your fix doesn't work:

- **< 3 failed attempts:** Return to Step 1. You misidentified the root cause. Gather more evidence.
- **>= 3 failed attempts:** Stop fixing. The problem is likely architectural, not a simple bug. Step back and question your assumptions about how the system works. Ask: "Is the design fundamentally sound, or am I patching a broken abstraction?"
- **Each fix reveals a new problem:** You're chasing symptoms, not the root cause. See the Red Flags section in [SKILL.md](./SKILL.md).
