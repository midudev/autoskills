# Transactions, Isolation Levels, and Locking

## Basic transaction pattern

```go
tx, err := db.BeginTxx(ctx, nil) // default isolation (READ COMMITTED)
if err != nil {
    return fmt.Errorf("beginning transaction: %w", err)
}
defer tx.Rollback() // no-op if already committed

// ... execute queries using tx ...

if err := tx.Commit(); err != nil {
    return fmt.Errorf("committing transaction: %w", err)
}
```

## Custom isolation level

```go
tx, err := db.BeginTxx(ctx, &sql.TxOptions{
    Isolation: sql.LevelSerializable, // strongest guarantee
})
```

| Level | Use when |
| --- | --- |
| `LevelReadCommitted` | Default — good for most operations |
| `LevelRepeatableRead` | Need consistent reads within a transaction |
| `LevelSerializable` | Financial operations, inventory, anything with strict consistency |

## SELECT FOR UPDATE — prevent race conditions

```go
var balance int
err := tx.GetContext(ctx, &balance, "SELECT balance FROM accounts WHERE id = $1 FOR UPDATE", accountID)
// Row is locked until tx.Commit() or tx.Rollback()
```

Use `FOR UPDATE` when you read a value, compute something from it, and then write it back. Without the lock, concurrent transactions can read stale data.

## Locking variants

| Clause | Effect |
| --- | --- |
| `FOR UPDATE` | Locks rows for write — other transactions block on same rows |
| `FOR UPDATE NOWAIT` | Same, but fails immediately instead of waiting |
| `FOR SHARE` | Locks rows for read — prevents writes but allows other reads |
