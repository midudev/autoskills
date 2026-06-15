# Nil Safety Deep Dive

## Nil Pointer Receivers

MUST check for nil before calling methods on pointer receivers from external sources. A method call on a nil pointer does not always panic — it depends on whether the method dereferences the receiver:

```go
type Logger struct {
    prefix string
}

// ✓ Safe on nil but NEVER do that — does not dereference l
func (l *Logger) IsEnabled() bool {
    return l != nil
}

// ✗ Panics on nil — dereferences l to access prefix
func (l *Logger) Log(msg string) {
    fmt.Printf("[%s] %s\n", l.prefix, msg)
}

var l *Logger
l.IsEnabled() // false — works fine
l.Log("test") // panic: nil pointer dereference
```

Anyway, NEVER call a method on a nil pointer.

### Designing nil-safe receivers

When a nil receiver is a valid state (e.g., optional components), guard against it explicitly:

```go
func (l *Logger) Log(msg string) {
    if l == nil {
        return // silently skip if no logger configured
    }
    fmt.Printf("[%s] %s\n", l.prefix, msg)
}
```

This pattern is useful for optional dependencies, but use it sparingly — a nil receiver usually signals a bug, not an intentional state. Document when nil is an expected value.

## Nil Function Values

NEVER rely on nil function values — always validate before calling. Calling a nil `func` variable panics:

```go
// ✗ Bad — panics if callback was never set
type Worker struct {
    onComplete func(result string)
}

func (w *Worker) Finish(result string) {
    w.onComplete(result) // panic if onComplete is nil
}

// ✓ Good — check before calling
func (w *Worker) Finish(result string) {
    if w.onComplete != nil {
        w.onComplete(result)
    }
}
```

### Default function pattern

Provide a no-op default to avoid nil checks at every call site:

```go
func NewWorker(opts ...Option) *Worker {
    w := &Worker{
        onComplete: func(string) {}, // no-op default
    }
    for _, opt := range opts {
        opt(w)
    }
    return w
}
```

## Nil and Error Comparisons

### Returning nil error correctly

Interface comparisons with nil MUST account for the nil interface trap. A function returning `error` must return the untyped `nil`, not a typed nil pointer:

```go
// ✗ Bad — returns non-nil error interface
func validate(s string) error {
    var err *ValidationError // typed nil
    if s == "" {
        err = &ValidationError{Field: "name"}
    }
    return err // even when err is nil, interface is non-nil
}

// ✓ Good — return nil explicitly
func validate(s string) error {
    if s == "" {
        return &ValidationError{Field: "name"}
    }
    return nil
}
```

### Checking error chains with nil

`errors.Is(err, nil)` returns `true` only if `err` is truly nil. It does not help with the nil interface trap — the trap occurs before the error reaches `errors.Is`.

## Nil in Generic Code

### The `comparable` constraint and nil

Generic code MUST handle the zero value of type parameters correctly. Type parameters constrained by `comparable` can be compared with `==`, but nil is not always a valid value:

```go
// ✗ Confusing — T may or may not be nillable
func IsZero[T comparable](v T) bool {
    var zero T
    return v == zero // works, but "zero" for *Foo is nil, for int is 0
}

// ✓ Better — be explicit about what "empty" means
func IsNil[T interface{ ~*U }, U any](v T) bool {
    return v == nil
}
```

### Nil checks with unconstrained type parameters

You cannot compare an unconstrained type parameter to nil:

```go
// ✗ Does not compile
func Check[T any](v T) bool {
    return v == nil // compile error: cannot compare T with nil
}

// ✓ Good — use reflect or constrain to pointer types
func IsNilPtr[T any](v *T) bool {
    return v == nil
}
```

## Patterns for Nil-Safe APIs

### Constructor with defaults

Require initialization through a constructor, making the zero value impossible for external callers:

```go
type Client struct {
    httpClient *http.Client
    baseURL    string
}

// Constructor guarantees non-nil fields
func NewClient(baseURL string) *Client {
    return &Client{
        httpClient: http.DefaultClient,
        baseURL:    baseURL,
    }
}
```

### Lazy initialization for zero-value usability

When you want the zero value to be usable but need internal resources:

```go
type Cache struct {
    mu   sync.Mutex
    data map[string]any
}

func (c *Cache) Get(key string) (any, bool) {
    c.mu.Lock()
    defer c.mu.Unlock()
    if c.data == nil {
        return nil, false
    }
    v, ok := c.data[key]
    return v, ok
}

func (c *Cache) Set(key string, val any) {
    c.mu.Lock()
    defer c.mu.Unlock()
    if c.data == nil {
        c.data = make(map[string]any)
    }
    c.data[key] = val
}
```

→ See `samber/cc-skills-golang@golang-error-handling` skill for nil error comparison pitfalls.
