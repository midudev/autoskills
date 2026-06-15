---
name: golang-database
description: "Comprehensive guide for Go database access — parameterized queries, struct scanning, NULLable columns, transactions, isolation levels, SELECT FOR UPDATE, connection pool, batch processing, context propagation, and migration tooling. Use when writing, reviewing, or debugging Golang code that interacts with PostgreSQL, MariaDB, MySQL, or SQLite; for database testing; or for questions about database/sql, sqlx, or pgx. Does NOT generate database schemas or migration SQL."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents, and for projects using Golang.
metadata:
  author: samber
  version: "1.2.1"
  openclaw:
    emoji: "🗄"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
    install: []
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Agent AskUserQuestion
---

**Persona:** You are a Go backend engineer who writes safe, explicit, and observable database code. You treat SQL as a first-class language — no ORMs, no magic — and you catch data integrity issues at the boundary, not deep in the application.

**Modes:**

- **Write mode** — generating new repository functions, query helpers, or transaction wrappers: follow the skill's sequential instructions; launch a background agent to grep for existing query patterns and naming conventions in the codebase before generating new code.
- **Review/debug mode** — auditing or debugging existing database code: use a sub-agent to scan for missing `rows.Close()`, un-parameterized queries, missing context propagation, and absent error checks in parallel with reading the business logic.

> **Community default.** A company skill that explicitly supersedes `samber/cc-skills-golang@golang-database` skill takes precedence.

# Go Database Best Practices

Go's `database/sql` provides a solid foundation for database access. Use `sqlx` or `pgx` on top of it for ergonomics — never an ORM.

When using sqlx or pgx, refer to the library's official documentation and code examples for current API signatures.

## Best Practices Summary

1. **Use sqlx or pgx, not ORMs** — ORMs hide SQL, generate unpredictable queries, and make debugging harder
2. Queries MUST use parameterized placeholders — NEVER concatenate user input into SQL strings
3. Context MUST be passed to all database operations — use `*Context` method variants (`QueryContext`, `ExecContext`, `GetContext`)
4. `sql.ErrNoRows` MUST be handled explicitly — distinguish "not found" from real errors using `errors.Is`
5. Rows MUST be closed after iteration — `defer rows.Close()` immediately after `QueryContext` calls
6. NEVER use `db.Query` for statements that don't return rows — `Query` returns `*Rows` which must be closed; if you forget, the connection leaks back to the pool. Use `db.Exec` instead
7. **Use transactions for multi-statement operations** — wrap related writes in `BeginTxx`/`Commit`
8. **Use `SELECT ... FOR UPDATE`** when reading data you intend to modify — prevents race conditions
9. **Set custom isolation levels** when default READ COMMITTED is insufficient (e.g., serializable for financial operations)
10. **Handle NULLable columns** with pointer fields (`*string`, `*int`) or `sql.NullXxx` types
11. Connection pool MUST be configured — `SetMaxOpenConns`, `SetMaxIdleConns`, `SetConnMaxLifetime`, `SetConnMaxIdleTime`
12. **Use external tools for migrations** — golang-migrate or Flyway, never hand-rolled or AI-generated migration SQL
13. **Batch operations in reasonable sizes** — not row-by-row (too many round trips), not millions at once (locks and memory)
14. **Never create or modify database schemas** — a schema that looks correct on toy data can create hotspots, lock contention, or missing indexes under real production load. Schema design requires understanding of data volumes, access patterns, and production constraints that AI does not have
15. **Avoid hidden SQL features** — do not rely on triggers, views, materialized views, stored procedures, or row-level security in application code

## Library Choice

| Library | Best for | Struct scanning | PostgreSQL-specific |
| --- | --- | --- | --- |
| `database/sql` | Portability, minimal deps | Manual `Scan` | No |
| `sqlx` | Multi-database projects | `StructScan` | No |
| `pgx` | PostgreSQL (30-50% faster) | `pgx.RowToStructByName` | Yes (COPY, LISTEN, arrays) |
| GORM/ent | **Avoid** | Magic | Abstracted away |

**Why NOT ORMs:**

- Unpredictable query generation — N+1 problems you cannot see in code
- Magic hooks and callbacks (BeforeCreate, AfterUpdate) make debugging harder
- Schema migrations coupled to application code
- Learning the ORM API is harder than learning SQL, and the abstraction leaks

## Parameterized Queries

```go
// ✗ VERY BAD — SQL injection vulnerability
query := fmt.Sprintf("SELECT * FROM users WHERE email = '%s'", email)

// ✓ Good — parameterized (PostgreSQL)
var user User
err := db.GetContext(ctx, &user, "SELECT id, name, email FROM users WHERE email = $1", email)

// ✓ Good — parameterized (MySQL)
err := db.GetContext(ctx, &user, "SELECT id, name, email FROM users WHERE email = ?", email)
```

### Dynamic IN clauses

```go
query, args, err := sqlx.In("SELECT * FROM users WHERE id IN (?)", ids)
if err != nil {
    return fmt.Errorf("building IN clause: %w", err)
}
query = db.Rebind(query) // adjust placeholders for your driver
err = db.SelectContext(ctx, &users, query, args...)
```

### Dynamic column names

Never interpolate column names from user input. Use an allowlist:

```go
allowed := map[string]bool{"name": true, "email": true, "created_at": true}
if !allowed[sortCol] {
    return fmt.Errorf("invalid sort column: %s", sortCol)
}
query := fmt.Sprintf("SELECT id, name, email FROM users ORDER BY %s", sortCol)
```

For more injection prevention patterns, see the `samber/cc-skills-golang@golang-security` skill.

## Struct Scanning and NULLable Columns

Use `db:"column_name"` tags for sqlx, `pgx.CollectRows` with `pgx.RowToStructByName` for pgx. Handle NULLable columns with pointer fields (`*string`, `*time.Time`) — they work cleanly with both scanning and JSON marshaling. See [Scanning Reference](./references/scanning.md) for examples of all approaches.

## Error Handling

```go
func GetUser(id string) (*User, error) {
    var user User

    err := db.GetContext(ctx, &user, "SELECT id, name FROM users WHERE id = $1", id)
    if err != nil {
        if errors.Is(err, sql.ErrNoRows) {
            return nil, ErrUserNotFound // translate to domain error
        }
        return nil, fmt.Errorf("querying user %s: %w", id, err)
    }

    return &user, nil
}
```

or:

```go
func GetUser(id string) (u *User, exists bool, err error) {
    var user User

    err := db.GetContext(ctx, &user, "SELECT id, name FROM users WHERE id = $1", id)
    if err != nil {
        if errors.Is(err, sql.ErrNoRows) {
            return nil, false, nil // "no user" is not a technical error, but a domain error
        }
        return nil, false, fmt.Errorf("querying user %s: %w", id, err)
    }

    return &user, true, nil
}
```

### Always close rows

```go
rows, err := db.QueryContext(ctx, "SELECT id, name FROM users")
if err != nil {
    return fmt.Errorf("querying users: %w", err)
}
defer rows.Close() // prevents connection leaks

for rows.Next() {
    // ...
}
if err := rows.Err(); err != nil { // always check after iteration
    return fmt.Errorf("iterating users: %w", err)
}
```

### Common database error patterns

| Error | How to detect | Action |
| --- | --- | --- |
| Row not found | `errors.Is(err, sql.ErrNoRows)` | Return domain error |
| Unique constraint | Check driver-specific error code | Return conflict error |
| Connection refused | `err != nil` on `db.PingContext` | Fail fast, log, retry with backoff |
| Serialization failure | PostgreSQL error code `40001` | Retry the entire transaction |
| Context canceled | `errors.Is(err, context.Canceled)` | Stop processing, propagate |

## Context Propagation

Always use the `*Context` method variants to propagate deadlines and cancellation:

```go
// ✗ Bad — no context, query runs until completion even if client disconnects
db.Query("SELECT ...")

// ✓ Good — respects context cancellation and timeouts
db.QueryContext(ctx, "SELECT ...")
```

For context patterns in depth, see the `samber/cc-skills-golang@golang-context` skill.

## Transactions, Isolation Levels, and Locking

For transaction patterns, isolation levels, `SELECT FOR UPDATE`, and locking variants, see [Transactions](./references/transactions.md).

## Connection Pool

```go
db.SetMaxOpenConns(25)              // limit total connections
db.SetMaxIdleConns(10)              // keep warm connections ready
db.SetConnMaxLifetime(5 * time.Minute)  // recycle stale connections
db.SetConnMaxIdleTime(1 * time.Minute)  // close idle connections faster
```

For sizing guidance and formulas, see [Database Performance](./references/performance.md).

## Migrations

Use an external migration tool. Schema changes require human review with understanding of data volumes, existing indexes, foreign keys, and production constraints.

Recommended tools:

- [golang-migrate](https://github.com/golang-migrate/migrate) — CLI + Go library, supports all major databases
- [Flyway](https://flywaydb.org/) — JVM-based, widely used in enterprise environments
- [Atlas](https://atlasgo.io/) — modern, declarative schema management

Migration SQL should be written and reviewed by humans, versioned in source control, and applied through CI/CD pipelines.

## Avoid Hidden SQL Features

Do not rely on triggers, views, materialized views, stored procedures, or row-level security in application code — they create invisible side effects and make debugging impossible. Keep SQL explicit and visible in Go where it can be tested and version-controlled.

## Schema Creation

**This skill does NOT cover schema creation.** AI-generated schemas are often subtly wrong — missing indexes, incorrect column types, bad normalization, or missing constraints. Schema design requires understanding data volumes, access patterns, query profiles, and business constraints. Use dedicated database tooling and human review.

## Deep Dives

- **[Transactions](./references/transactions.md)** — Transaction boundaries, isolation levels, deadlock prevention, `SELECT FOR UPDATE`
- **[Testing Database Code](./references/testing.md)** — Mock connections, integration tests with containers, fixtures, schema setup/teardown
- **[Database Performance](./references/performance.md)** — Connection pool sizing, batch processing, indexing strategy, query optimization
- **[Struct Scanning](./references/scanning.md)** — Struct tags, NULLable column handling, JSON marshaling patterns

## Cross-References

- → See `samber/cc-skills-golang@golang-security` skill for SQL injection prevention patterns
- → See `samber/cc-skills-golang@golang-context` skill for context propagation to database operations
- → See `samber/cc-skills-golang@golang-error-handling` skill for database error wrapping patterns
- → See `samber/cc-skills-golang@golang-testing` skill for database integration test patterns

## References

- [database/sql tutorial](https://go.dev/doc/database/)
- [sqlx](https://github.com/jmoiron/sqlx)
- [pgx](https://github.com/jackc/pgx)
- [golang-migrate](https://github.com/golang-migrate/migrate)
