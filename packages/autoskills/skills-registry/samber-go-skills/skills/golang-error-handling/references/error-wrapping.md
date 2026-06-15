# Error Wrapping and Inspection

## Error Wrapping with `%w`

Wrapping preserves the original error in a chain that callers can inspect with `errors.Is` and `errors.As`. Errors SHOULD be wrapped at each layer to build a readable chain.

```go
// ✓ Good — wraps with context, preserves the chain
func (s *UserService) GetUser(id string) (*User, error) {
    user, err := s.repo.FindByID(id)
    if err != nil {
        return nil, fmt.Errorf("getting user %s: %w", id, err)
    }
    return user, nil
}
```

### `%w` vs `%v`: controlling exposure

Use `%w` within your module to preserve the error chain. Use `%v` at public API / system boundaries to prevent callers from depending on internal error types.

```go
// Internal layer — wrap to preserve chain
func (r *repo) fetch(id string) error {
    return fmt.Errorf("querying database: %w", err)
}

// Public API boundary — break chain to hide internals
func (s *PublicService) GetItem(id string) error {
    err := s.repo.fetch(id)
    if err != nil {
        return fmt.Errorf("item unavailable: %v", err) // %v — callers cannot unwrap
    }
    return nil
}
```

## Inspecting Errors: `errors.Is` and `errors.As`

### `errors.Is` — match against a sentinel value

```go
// ✗ Bad — direct comparison breaks on wrapped errors
if err == sql.ErrNoRows {

// ✓ Good — traverses the entire error chain
if errors.Is(err, sql.ErrNoRows) {
    return nil, ErrNotFound
}
```

### `errors.As / errors.AsType` — extract a typed error from the chain

```go
// ✗ Bad — type assertion breaks on wrapped errors
if ve, ok := err.(*ValidationError); ok {

// ✓ Good — traverses the entire error chain
var ve *ValidationError
if errors.As(err, &ve) {
    log.Printf("validation failed on field %s: %s", ve.Field, ve.Msg)
}

// ✓ Better (Go 1.26+) — same behavior, simpler syntax
if ve, ok := errors.AsType[*ValidationError](err); ok {
    log.Printf("validation failed on field %s: %s", ve.Field, ve.Msg)
}
```

## Combining Errors with `errors.Join`

`errors.Join` (Go 1.20+) combines multiple independent errors into one. The combined error works with `errors.Is` and `errors.As` — each inner error is inspectable.

### Use case: validating multiple fields

```go
func validateUser(u User) error {
    var errs []error

    if u.Name == "" {
        errs = append(errs, errors.New("name is required"))
    }
    if u.Email == "" {
        errs = append(errs, errors.New("email is required"))
    }

    return errors.Join(errs...) // returns nil if errs is empty
}
```

### Use case: parallel operations with independent failures

```go
func closeAll(closers ...io.Closer) error {
    var errs []error
    for _, c := range closers {
        if err := c.Close(); err != nil {
            errs = append(errs, err)
        }
    }
    return errors.Join(errs...)
}
```

### `errors.Is` works through joined errors

```go
err := errors.Join(ErrNotFound, ErrUnauthorized)

errors.Is(err, ErrNotFound)    // true
errors.Is(err, ErrUnauthorized) // true
```
