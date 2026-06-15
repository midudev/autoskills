# Database Performance

## Connection Pool Sizing

### Configuration

```go
db, err := sqlx.Connect("postgres", dsn)
if err != nil {
    return fmt.Errorf("connecting to database: %w", err)
}

db.SetMaxOpenConns(25)                  // total connections (match your DB capacity)
db.SetMaxIdleConns(10)                  // keep connections warm, reduce handshake overhead
db.SetConnMaxLifetime(5 * time.Minute)  // recycle connections (DNS changes, server restarts)
db.SetConnMaxIdleTime(1 * time.Minute)  // release idle connections back to the pool
```

| Setting | Too low | Too high |
| --- | --- | --- |
| `MaxOpenConns` | Requests queue waiting for conn | DB overwhelmed, context switches |
| `MaxIdleConns` | Cold connections, slow queries | Wasted memory holding idle conns |
| `ConnMaxLifetime` | Frequent reconnection overhead | Stale connections after failover |
| `ConnMaxIdleTime` | Same as MaxIdleConns too low | Idle conns consume server memory |

### Monitoring

Check pool stats in production to detect exhaustion:

```go
stats := db.Stats()
slog.Info("db pool",
    "open", stats.OpenConnections,
    "in_use", stats.InUse,
    "idle", stats.Idle,
    "wait_count", stats.WaitCount,        // total waits for a connection
    "wait_duration", stats.WaitDuration,  // total wait time
)
```

If `WaitCount` keeps climbing, increase `MaxOpenConns` or optimize slow queries.

### Prometheus Metrics

Use a custom Prometheus collector to export pool metrics on-demand (scales to multiple pools automatically):

```go
type DBCollector struct {
    pools map[string]*sqlx.DB
}

func NewDBCollector(pools map[string]*sqlx.DB) *DBCollector {
    return &DBCollector{pools: pools}
}

func (c *DBCollector) Describe(ch chan<- *prometheus.Desc) {
    ch <- prometheus.NewDesc("db_open_connections", "Number of open connections", []string{"pool"}, nil)
    ch <- prometheus.NewDesc("db_in_use_connections", "Connections currently in use", []string{"pool"}, nil)
    ch <- prometheus.NewDesc("db_idle_connections", "Idle connections in pool", []string{"pool"}, nil)
    ch <- prometheus.NewDesc("db_total_latency_seconds", "Total latency for a connection", []string{"pool"}, nil)
}

func (c *DBCollector) Collect(ch chan<- prometheus.Metric) {
    for poolName, db := range c.pools {
        stats := db.Stats()

        ch <- prometheus.MustNewConstMetric(
            prometheus.NewDesc("db_open_connections", "Number of open connections", []string{"pool"}, nil),
            prometheus.GaugeValue, float64(stats.OpenConnections), poolName)

        ch <- prometheus.MustNewConstMetric(
            prometheus.NewDesc("db_in_use_connections", "Connections currently in use", []string{"pool"}, nil),
            prometheus.GaugeValue, float64(stats.InUse), poolName)

        ch <- prometheus.MustNewConstMetric(
            prometheus.NewDesc("db_idle_connections", "Idle connections in pool", []string{"pool"}, nil),
            prometheus.GaugeValue, float64(stats.Idle), poolName)

        ch <- prometheus.MustNewConstMetric(
            prometheus.NewDesc("db_wait_duration_seconds_total", "Total connection wait duration", []string{"pool"}, nil),
            prometheus.CounterValue, stats.WaitDuration.Seconds(), poolName)
    }
}

func init() {
    pools := map[string]*sqlx.DB{
        "primary": mainDB,
        "replica": replicaDB,
    }
    prometheus.MustRegister(NewDBCollector(pools))
}
```

**Collector advantages:**

- Metrics are collected on-demand during scrapes (no background goroutine)
- Always returns current state (no stale data between scrapes)
- Scales to multiple pools automatically
- Lower memory footprint (no metric state in memory)

**Alert thresholds:**

- Open connections approaching `MaxOpenConns` → risk of request queuing
- Wait count climbing steadily → pool is exhausted, increase `MaxOpenConns`
- Idle connections too high → reduce `MaxIdleConns` or lower `ConnMaxIdleTime`

## Batch Processing

Avoid two extremes:

- **Row-by-row** — N round trips for N rows, extremely slow
- **One giant batch** — locks tables, consumes memory, can timeout and block other queries

### Sweet spot: 100–1,000 rows per batch

Adjust based on row size and database load. Larger rows → smaller batches.

### Batch INSERT with sqlx

```go
func insertUsersBatch(ctx context.Context, db *sqlx.DB, users []User) error {
    const batchSize = 500
    for i := 0; i < len(users); i += batchSize {
        end := min(i+batchSize, len(users))
        batch := users[i:end]

        _, err := db.NamedExecContext(ctx, `INSERT INTO users (name, email) VALUES (:name, :email)`, batch)
        if err != nil {
            return fmt.Errorf("inserting users batch %d-%d: %w", i, end, err)
        }
    }
    return nil
}
```

### Bulk INSERT with pgx (PostgreSQL COPY protocol)

For maximum throughput on PostgreSQL, use `pgx.CopyFrom` which uses the binary COPY protocol — significantly faster than multi-row INSERT:

```go
rows := make([][]any, len(users))
for i, u := range users {
    rows[i] = []any{u.Name, u.Email}
}
_, err := pool.CopyFrom(ctx,
    pgx.Identifier{"users"},
    []string{"name", "email"},
    pgx.CopyFromRows(rows),
)
```

### Cursor-based pagination (avoid OFFSET)

For reading large datasets, use cursor-based pagination instead of `OFFSET`. OFFSET re-scans skipped rows, getting slower as you paginate deeper:

```go
// ✗ Bad — OFFSET re-scans rows, O(offset + limit)
SELECT * FROM events ORDER BY created_at LIMIT 100 OFFSET 10000

// ✓ Good — cursor-based, O(limit) regardless of depth
SELECT * FROM events WHERE created_at > $1 ORDER BY created_at LIMIT 100
```

## Indexing Strategy

**Never create or drop indexes yourself.** Index changes affect production query performance and write throughput. Always suggest to the developer and let them decide.

### Use SQL MCP to check existing indexes

When a SQL MCP tool is available, query the database to check existing indexes before suggesting new ones:

```sql
-- PostgreSQL: list indexes on a table
SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'users';

-- Check for unused indexes (low scan count relative to writes)
SELECT schemaname, relname, indexrelname, idx_scan, idx_tup_read
FROM pg_stat_user_indexes
WHERE idx_scan < 10
ORDER BY idx_scan;
```

### When to suggest adding indexes

- Foreign key columns (PostgreSQL does NOT auto-index foreign keys)
- Columns frequently used in `WHERE`, `JOIN`, or `ORDER BY`
- Composite indexes for multi-column queries (leftmost column is most selective)
- Partial indexes for filtered queries (`WHERE active = true`)

### When to suggest removing indexes

- Indexes with near-zero `idx_scan` count (nobody reads them)
- Duplicate indexes (same columns in same order)
- Indexes on write-heavy tables that slow down INSERT/UPDATE/DELETE
- Wide composite indexes where a narrower one would suffice

Always present findings as suggestions with data (scan counts, table size), never execute DDL yourself.

## Query Performance Tips

- **`EXPLAIN ANALYZE`** before optimizing — measure, don't guess
- **List columns explicitly** — avoid `SELECT *`, it fetches unnecessary data and breaks struct scanning when schema changes
- **Use `LIMIT`** for pagination, always with an `ORDER BY`
- **Prefer `EXISTS` over `COUNT`** for existence checks — `EXISTS` stops at the first match
- **Avoid N+1 queries** — use `JOIN` or batch `WHERE id IN (...)` instead of querying in a loop
- **Suggest improvements, never execute them** — performance changes (indexes, query rewrites, configuration) need human review in context of production data and workload patterns

Batch operations SHOULD use 100–1,000 rows per batch — adjust based on row size and database load. Cursor-based pagination MUST replace `OFFSET` for large datasets — the cursor column MUST be chosen based on actual indexes (e.g., `created_at`, `user_id`). NEVER create indexes blindly — check existing indexes, measure with `EXPLAIN ANALYZE`, and present findings as suggestions. N+1 queries MUST be eliminated — use `JOIN` or batch `WHERE id IN (...)`.

→ See `samber/cc-skills-golang@golang-observability` skill for database metrics and query monitoring. → See `samber/cc-skills@promql-cli` skill for querying pool metrics (`db_open_connections`, `db_in_use_connections`, `db_idle_connections`) via CLI.
