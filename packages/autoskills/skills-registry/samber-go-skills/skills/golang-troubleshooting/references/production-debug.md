# Production Debugging

## Production Debugging Checklist

When paged for a production issue:

### Step 1: Capture Immediately (don't restart!)

Capture all profiles before restarting the process. The curl commands in [pprof.md](./pprof.md) can be used targeting your production server address. At minimum, capture: goroutine dump (`?debug=2`), heap, CPU (30s), and mutex profiles.

### Step 2: System Metrics

```bash
ps aux | grep myapp
lsof -p PID | wc -l       # file descriptors
ss -s                       # socket summary
netstat -an | grep ESTABLISHED | wc -l
```

### Step 3: Analyze Locally

Download the captured `.prof` files and analyze with `go tool pprof` (see [pprof.md](./pprof.md)).

---

## Logging & Observability

### Strategic Log Placement

Place logs at **component boundaries**, not sprinkled randomly. The goal is to see data entering and exiting each layer, so you can identify exactly which component corrupts or drops it:

```go
// 1. Function entry/exit with key parameters
func ProcessOrder(ctx context.Context, orderID string) error {
    log.Printf("ProcessOrder: start orderID=%s", orderID)
    defer log.Printf("ProcessOrder: done orderID=%s", orderID)
    // ...
}

// 2. Before and after external calls
log.Printf("calling payment API for order %s", orderID)
resp, err := paymentClient.Charge(ctx, req)
if err != nil {
    log.Printf("payment API: err=%v", err)
} else {
    log.Printf("payment API: status=%d", resp.StatusCode)
}

// 3. At decision points
if user.IsAdmin {
    log.Printf("admin path for user %s", user.ID)
}
```

### Structured Logging (Go 1.21+)

```go
import "log/slog"

slog.Info("processing request",
    "method", r.Method,
    "path", r.URL.Path,
    "user_id", userID,
)

slog.Error("database query failed",
    "err", err,
    "query", query,
    "duration_ms", elapsed.Milliseconds(),
)
```

### Request ID Tracing

```go
type ctxKey string

func WithRequestID(ctx context.Context, id string) context.Context {
    return context.WithValue(ctx, ctxKey("request_id"), id)
}

func RequestID(ctx context.Context) string {
    id, _ := ctx.Value(ctxKey("request_id")).(string)
    return id
}
```

---

## Network & HTTP Debugging

### HTTP Client Issues

```go
// 1. HTTP clients MUST set timeouts — default http.Client has NO timeout
client := &http.Client{
    Timeout: 30 * time.Second,
    Transport: &http.Transport{
        DialContext:          (&net.Dialer{Timeout: 5 * time.Second}).DialContext,
        TLSHandshakeTimeout: 5 * time.Second,
        IdleConnTimeout:     90 * time.Second,
        MaxIdleConns:        100,
        MaxIdleConnsPerHost: 10,
    },
}

// 2. Response body MUST be closed
resp, err := client.Do(req)
if err != nil {
    return err
}
defer resp.Body.Close()

// 3. Read body on error status (for error messages from server)
if resp.StatusCode >= 400 {
    body, _ := io.ReadAll(resp.Body)
    return fmt.Errorf("API error %d: %s", resp.StatusCode, body)
}

// 4. Dump full request/response for debugging
import "net/http/httputil"
dump, _ := httputil.DumpRequestOut(req, true)
log.Printf("request:\n%s", dump)
dump, _ = httputil.DumpResponse(resp, true)
log.Printf("response:\n%s", dump)
```
