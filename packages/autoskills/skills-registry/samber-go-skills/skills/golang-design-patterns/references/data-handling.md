# Data Handling Patterns

## Iterators for Large Data (Go 1.23+)

Process large datasets without allocating everything into memory:

```go
// Bad — loads all rows into memory
func AllUsers(db *sql.DB) ([]User, error) {
    rows, err := db.Query("SELECT * FROM users")
    // ... scan all into slice
}

// Good — iterator yields one at a time
func AllUsers(db *sql.DB) iter.Seq2[User, error] {
    return func(yield func(User, error) bool) {
        rows, err := db.Query("SELECT * FROM users")
        if err != nil {
            yield(User{}, err)
            return
        }
        defer rows.Close()

        for rows.Next() {
            var u User
            if err := rows.Scan(&u.ID, &u.Name, &u.Email); err != nil {
                yield(User{}, err)
                return
            }
            if !yield(u, nil) {
                return
            }
        }
    }
}
```

## Streaming Large Transfers

When transferring large data between services (e.g., 1M rows from DB, 1M rows in HTTP response), use streaming patterns with iterators or `github.com/samber/ro` to prevent OOM:

```go
// Stream JSON array to HTTP response — constant memory
func (h *Handler) ExportUsers(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "application/json")
    w.Write([]byte("["))

    first := true
    for user, err := range h.repo.AllUsers(r.Context()) {
        if err != nil {
            slog.Error("streaming user", "error", err)
            return
        }
        if !first {
            w.Write([]byte(","))
        }
        json.NewEncoder(w).Encode(user)
        first = false
    }

    w.Write([]byte("]"))
}
```
