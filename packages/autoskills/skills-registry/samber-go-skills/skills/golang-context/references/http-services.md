# Context in HTTP Servers & Service Calls

## Context in HTTP Servers

`http.Request` carries a context that is cancelled when the client disconnects or the request handler returns. MUST use `r.Context()` — NEVER create a new `context.Background()` inside a handler.

```go
func (h *Handler) GetOrder(w http.ResponseWriter, r *http.Request) {
    ctx := r.Context() // this context is cancelled if the client disconnects

    order, err := h.orderService.Get(ctx, r.PathValue("id"))
    if err != nil {
        if ctx.Err() != nil {
            // Client disconnected, no point writing a response
            return
        }
        http.Error(w, "internal error", http.StatusInternalServerError)
        return
    }

    json.NewEncoder(w).Encode(order)
}
```

## Middleware enriching context

Middleware injects request-scoped values before handlers run. Use unexported key types to prevent collisions:

```go
// Helpers for trace propagation
type contextKey string
const (
    traceIDKey contextKey = "trace_id"
    spanIDKey  contextKey = "span_id"
)

func TracingMiddleware(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        traceID := r.Header.Get("X-Trace-ID")
        if traceID == "" {
            traceID = generateTraceID()
        }
        spanID := r.Header.Get("X-Span-ID")
        if spanID == "" {
            spanID = generateSpanID()
        }

        ctx := context.WithValue(r.Context(), traceIDKey, traceID)
        ctx = context.WithValue(ctx, spanIDKey, spanID)

        w.Header().Set("X-Trace-ID", traceID)
        w.Header().Set("X-Span-ID", spanID)
        next.ServeHTTP(w, r.WithContext(ctx))
    })
}

// Propagate trace context to downstream services
func (c *HTTPClient) Do(ctx context.Context, method, url string, body io.Reader) (*http.Response, error) {
    req, err := http.NewRequestWithContext(ctx, method, url, body)
    if err != nil {
        return nil, fmt.Errorf("creating request: %w", err)
    }

    if traceID, ok := ctx.Value(traceIDKey).(string); ok {
        req.Header.Set("X-Trace-ID", traceID)
    }
    if spanID, ok := ctx.Value(spanIDKey).(string); ok {
        req.Header.Set("X-Span-ID", spanID)
    }
    return c.client.Do(req)
}
```

## Context in Calls to Other Services

Context MUST be propagated to all HTTP clients and databases using context-aware APIs: `http.NewRequestWithContext`, `QueryContext`, `ExecContext`, and `QueryRowContext`. This ensures that client disconnections cancel all downstream operations.

```go
// ✗ Bad — downstream calls ignore the request context
func (c *PaymentClient) Charge(ctx context.Context, amount int) error {
    req, _ := http.NewRequest("POST", c.url+"/charge", body)
    return c.client.Do(req) // not context-aware
}

// ✓ Good — all downstream operations respect the context
func (c *PaymentClient) Charge(ctx context.Context, amount int) error {
    req, err := http.NewRequestWithContext(ctx, "POST", c.url+"/charge", body)
    if err != nil {
        return fmt.Errorf("creating request: %w", err)
    }
    return c.client.Do(req)
}
```

```go
// ✗ Bad — downstream calls ignore the request context
func (r *UserRepo) FindByID(ctx context.Context, id string) (*User, error) {
    row := r.db.QueryRow("SELECT * FROM users WHERE id = $1", id)
    // ...
}

// ✓ Good — all downstream operations respect the context
func (r *UserRepo) FindByID(ctx context.Context, id string) (*User, error) {
    row := r.db.QueryRowContext(ctx, "SELECT * FROM users WHERE id = $1", id)
    // ...
}
```
