---
name: golang-samber-oops
description: "Structured error handling in Golang with samber/oops — error builders, stack traces, error codes, error context, error wrapping, error attributes, user-facing vs developer messages, panic recovery, and logger integration. Apply when using or adopting samber/oops, or when the codebase already imports github.com/samber/oops."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents, and for projects using Golang.
metadata:
  author: samber
  version: "1.1.3"
  openclaw:
    emoji: "💥"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
    install: []
    skill-library-version: "1.21.0"
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Agent WebFetch mcp__context7__resolve-library-id mcp__context7__query-docs
---

**Persona:** You are a Go engineer who treats errors as structured data. Every error carries enough context — domain, attributes, trace — for an on-call engineer to diagnose the problem without asking the developer.

# samber/oops Structured Error Handling

**samber/oops** is a drop-in replacement for Go's standard error handling that adds structured context, stack traces, error codes, public messages, and panic recovery. Variable data goes in `.With()` attributes (not the message string), so APM tools (Datadog, Loki, Sentry) can group errors properly. Unlike the stdlib approach (adding `slog` attributes at the log site), oops attributes travel with the error through the call stack.

## Why use samber/oops

Standard Go errors lack context — you see `connection failed` but not which user triggered it, what query was running, or the full call stack. `samber/oops` provides:

- **Structured context** — key-value attributes on any error
- **Stack traces** — automatic call stack capture
- **Error codes** — machine-readable identifiers
- **Public messages** — user-safe messages separate from technical details
- **Low-cardinality messages** — variable data in `.With()` attributes, not the message string, so APM tools group errors properly

This skill is not exhaustive. Please refer to library documentation and code examples for more information. Context7 can help as a discoverability platform.

## Core pattern: Error builder chain

All `oops` errors use a fluent builder pattern:

```go
err := oops.
    In("user-service").           // domain/feature
    Tags("database", "postgres").  // categorization
    Code("network_failure").       // machine-readable identifier
    User("user-123", "email", "foo@bar.com").  // user context
    With("query", query).          // custom attributes
    Errorf("failed to fetch user: %s", "timeout")
```

Terminal methods:

- `.Errorf(format, args...)` — create a new error
- `.Wrap(err)` — wrap an existing error
- `.Wrapf(err, format, args...)` — wrap with a message
- `.Join(err1, err2, ...)` — combine multiple errors
- `.Recover(fn)` / `.Recoverf(fn, format, args...)` — convert panic to error

### Error builder methods

| Methods | Use case |
| --- | --- |
| `.With("key", value)` | Add custom key-value attribute (lazy `func() any` values supported) |
| `.WithContext(ctx, "key1", "key2")` | Extract values from Go context into attributes (lazy values supported) |
| `.In("domain")` | Set the feature/service/domain |
| `.Tags("auth", "sql")` | Add categorization tags (query with `err.HasTag("tag")`) |
| `.Code("iam_authz_missing_permission")` | Set machine-readable error identifier/slug |
| `.Public("Could not fetch user.")` | Set user-safe message (separate from technical details) |
| `.Hint("Runbook: https://doc.acme.org/doc/abcd.md")` | Add debugging hint for developers |
| `.Owner("team/slack")` | Identify responsible team/owner |
| `.User(id, "k", "v")` | Add user identifier and attributes |
| `.Tenant(id, "k", "v")` | Add tenant/organization context and attributes |
| `.Trace(id)` | Add trace / correlation ID (default: ULID) |
| `.Span(id)` | Add span ID representing a unit of work/operation (default: ULID) |
| `.Time(t)` | Override error timestamp (default: `time.Now()`) |
| `.Since(t)` | Set duration based on time since `t` (exposed via `err.Duration()`) |
| `.Duration(d)` | Set explicit error duration |
| `.Request(req, includeBody)` | Attach `*http.Request` (optionally including body) |
| `.Response(res, includeBody)` | Attach `*http.Response` (optionally including body) |
| `oops.FromContext(ctx)` | Start from an `OopsErrorBuilder` stored in a Go context |

## Common scenarios

### Database/repository layer

```go
func (r *UserRepository) FetchUser(id string) (*User, error) {
    query := "SELECT * FROM users WHERE id = $1"
    row, err := r.db.Query(query, id)
    if err != nil {
        return nil, oops.
            In("user-repository").
            Tags("database", "postgres").
            With("query", query).
            With("user_id", id).
            Wrapf(err, "failed to fetch user from database")
    }
    // ...
}
```

### HTTP handler layer

```go
func (h *Handler) CreateUser(w http.ResponseWriter, r *http.Request) {
    userID := getUserID(r)

    err := h.service.CreateUser(r.Context(), userID)
    if err != nil {
        err = oops.
            In("http-handler").
            Tags("endpoint", "/users").
            Request(r, false).
            User(userID).
            Wrapf(err, "create user failed")
        http.Error(w, oops.GetPublic(err, "Internal server error"), http.StatusInternalServerError)
        return
    }

    w.WriteHeader(http.StatusCreated)
}
```

### Service layer with reusable builder

```go
func (s *UserService) CreateOrder(ctx context.Context, req CreateOrderRequest) error {
    builder := oops.
        In("order-service").
        Tags("orders", "checkout").
        Tenant(req.TenantID, "plan", req.Plan).
        User(req.UserID, "email", req.UserEmail)

    product, err := s.catalog.GetProduct(ctx, req.ProductID)
    if err != nil {
        return builder.
            With("product_id", req.ProductID).
            Wrapf(err, "product lookup failed")
    }

    if product.Stock < req.Quantity {
        return builder.
            Code("insufficient_stock").
            Public("Not enough items in stock.").
            With("requested", req.Quantity).
            With("available", product.Stock).
            Errorf("insufficient stock for product %s", req.ProductID)
    }

    return nil
}
```

## Error wrapping best practices

### DO: Wrap directly, no nil check needed

```go
// ✓ Good — Wrap returns nil if err is nil
return oops.Wrapf(err, "operation failed")

// ✗ Bad — unnecessary nil check
if err != nil {
    return oops.Wrapf(err, "operation failed")
}
return nil
```

### DO: Add context at each layer

Each architectural layer SHOULD add context via Wrap/Wrapf — at least once per package boundary (not necessarily at every function call).

```go
// ✓ Good — each layer adds relevant context
func Controller() error {
    return oops.In("controller").Trace(traceID).Wrapf(Service(), "user request failed")
}

func Service() error {
    return oops.In("service").With("op", "create_user").Wrapf(Repository(), "db operation failed")
}

func Repository() error {
    return oops.In("repository").Tags("database", "postgres").Errorf("connection timeout")
}
```

### DO: Keep error messages low-cardinality

Error messages MUST be low-cardinality for APM aggregation. Interpolating variable data into the message breaks grouping in Datadog, Loki, Sentry.

```go
// ✗ Bad — high-cardinality, breaks APM grouping
oops.Errorf("failed to process user %s in tenant %s", userID, tenantID)

// ✓ Good — static message + structured attributes
oops.With("user_id", userID).With("tenant_id", tenantID).Errorf("failed to process user")
```

## Panic recovery

`oops.Recover()` MUST be used in goroutine boundaries. Convert panics to structured errors:

```go
func ProcessData(data string) (err error) {
    return oops.
        In("data-processor").
        Code("panic_recovered").
        Hint("Check input data format and dependencies").
        With("input_data", data).
        Recover(func() {
            riskyOperation(data)
        })
}
```

## Accessing error information

`samber/oops` errors implement the standard `error` interface. Access additional info:

```go
if oopsErr, ok := err.(oops.OopsError); ok {
    fmt.Println("Code:", oopsErr.Code())
    fmt.Println("Domain:", oopsErr.Domain())
    fmt.Println("Tags:", oopsErr.Tags())
    fmt.Println("Context:", oopsErr.Context())
    fmt.Println("Stacktrace:", oopsErr.Stacktrace())
}

// Get public-facing message with fallback
publicMsg := oops.GetPublic(err, "Something went wrong")
```

### Output formats

```go
fmt.Printf("%+v\n", err)       // verbose with stack trace
bytes, _ := json.Marshal(err)  // JSON for logging
slog.Error(err.Error(), slog.Any("error", err))  // slog integration
```

## Context propagation

Carry error context through Go contexts:

```go
func middleware(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        builder := oops.
            In("http").
            Request(r, false).
            Trace(r.Header.Get("X-Trace-ID"))

        ctx := oops.WithBuilder(r.Context(), builder)
        next.ServeHTTP(w, r.WithContext(ctx))
    })
}

func handler(ctx context.Context) error {
    return oops.FromContext(ctx).Tags("handler", "users").Errorf("something failed")
}
```

For assertions, configuration, and additional logger examples, see [Advanced patterns](./references/advanced.md).

## References

- [github.com/samber/oops](https://github.com/samber/oops)
- [pkg.go.dev/github.com/samber/oops](https://pkg.go.dev/github.com/samber/oops)

## Cross-References

- → See `samber/cc-skills-golang@golang-error-handling` skill for general error handling patterns
- → See `samber/cc-skills-golang@golang-observability` skill for logger integration and structured logging
