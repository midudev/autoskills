# Struct Scanning and NULLable Columns

## Struct Scanning with sqlx

Tag struct fields with `db:"column_name"` for sqlx:

```go
type User struct {
    ID        int64      `db:"id"`
    Name      string     `db:"name"`
    Email     string     `db:"email"`
    DeletedAt *time.Time `db:"deleted_at"` // NULLable
}

// Single row
var user User
err := db.GetContext(ctx, &user, "SELECT id, name, email, deleted_at FROM users WHERE id = $1", id)

// Multiple rows
var users []User
err := db.SelectContext(ctx, &users, "SELECT id, name, email, deleted_at FROM users WHERE active = true")
```

## Struct Scanning with pgx

With pgx (v5+), use `pgx.CollectRows` for automatic struct mapping:

```go
rows, err := pool.Query(ctx, "SELECT id, name, email FROM users WHERE active = true")
if err != nil {
    return fmt.Errorf("querying users: %w", err)
}
users, err := pgx.CollectRows(rows, pgx.RowToStructByName[User])
```

## JSON Marshaling

Struct tags for both database and JSON work together. Pointer fields marshal to `null` in JSON when NULL in the database:

```go
type User struct {
    ID        int64      `db:"id"         json:"id"`
    Name      string     `db:"name"       json:"name"`
    Email     string     `db:"email"      json:"email"`
    Bio       *string    `db:"bio"        json:"bio,omitempty"` // NULL → omitted in JSON
    DeletedAt *time.Time `db:"deleted_at" json:"deleted_at"`    // NULL → null in JSON
}
```

## NULLable Columns

Three approaches, from most to least recommended:

**1. Pointer fields (recommended)** — clean, works with JSON marshaling:

```go
type User struct {
    ID        int64      `db:"id"    json:"id"`
    Name      string     `db:"name"  json:"name"`
    DeletedAt *time.Time `db:"deleted_at" json:"deleted_at"` // nil when NULL
}
// Check: if user.DeletedAt != nil { ... }
```

**2. `sql.NullXxx` types** or `sql.Null[T]` generic — explicit but verbose, requires custom JSON marshaling:

```go
type User struct {
    ID        int64          `db:"id"`
    Bio       sql.NullString `db:"bio"`
}
// Check: if user.Bio.Valid { use(user.Bio.String) }
```

**3. `COALESCE` in SQL** — moves NULL handling to the query:

```sql
SELECT id, COALESCE(bio, '') AS bio FROM users WHERE id = $1
```
