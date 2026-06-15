# samber/oops — Advanced Patterns

## Assertions

Use assertions for invariant checks (carefully — assertions panic):

```go
func ProcessPayment(amount int) error {
    return oops.
        In("payment-service").
        Recover(func() {
            oops.Assertf(amount > 0, "amount must be positive, got %d", amount)
            oops.Assert(amount < 1_000_000)
            // ... payment logic
        })
}
```

Assertions should be rare in Go. Use them only for truly impossible states that indicate a bug.

## Configuration

```go
oops.StackTraceMaxDepth = 20          // adjust stack trace depth
oops.SourceFragmentsHidden = false    // enable source code fragments
loc, _ := time.LoadLocation("America/New_York")
oops.Local = loc                      // set timezone for error timestamps
```

## Logger integration

`samber/oops` works with any logger. The error struct provides methods for extracting structured data:

```go
oopsErr := err.(oops.OopsError)
fmt.Println("operation failed",
    "code", oopsErr.Code(),
    "domain", oopsErr.Domain(),
    "user_id", oopsErr.User(),
    "error", oopsErr,
)

// With slog
slog.Error(err.Error(), slog.Any("error", err))

// With zerolog (formatter available)
log.Error().Err(err).Msg("operation failed")

// With logrus (formatter available)
log.WithError(err).Error("operation failed")
```
