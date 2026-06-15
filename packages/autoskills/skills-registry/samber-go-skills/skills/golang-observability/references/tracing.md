# Distributed Tracing with OpenTelemetry

→ See `samber/cc-skills-golang@golang-context` skill for propagating context across service boundaries. → See `samber/cc-skills-golang@golang-samber-oops` skill for structured errors with stack traces in spans.

When using the OpenTelemetry Go SDK, refer to the library's official documentation for up-to-date API signatures and examples.

## Why Tracing

When a request crosses multiple services, logs from each service are isolated. Tracing connects them: a single trace shows the full request path with timing for every operation. This is how you answer "why was this request slow?" in a microservices architecture.

## OTel SDK Setup

Set up the TracerProvider early in your application. On new projects, do this first — then add spans everywhere incrementally.

```go
import (
    "go.opentelemetry.io/otel"
    "go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracegrpc"
    "go.opentelemetry.io/otel/sdk/resource"
    sdktrace "go.opentelemetry.io/otel/sdk/trace"
    semconv "go.opentelemetry.io/otel/semconv/v1.26.0"
)

func initTracer(ctx context.Context) (func(), error) {
    exporter, err := otlptracegrpc.New(ctx)
    if err != nil {
        return nil, fmt.Errorf("creating OTLP exporter: %w", err)
    }

    res, err := resource.New(ctx,
        resource.WithAttributes(
            semconv.ServiceNameKey.String("my-service"),
            semconv.ServiceVersionKey.String("1.0.0"),
        ),
    )
    if err != nil {
        return nil, fmt.Errorf("creating resource: %w", err)
    }

    tp := sdktrace.NewTracerProvider(
        sdktrace.WithBatcher(exporter),
        sdktrace.WithResource(res),
    )
    otel.SetTracerProvider(tp)

    shutdown := func() {
        _ = tp.Shutdown(context.Background())
    }
    return shutdown, nil
}
```

## Creating Spans

Every meaningful operation should have a span. Think of spans as the building blocks of a trace — they show where time was spent.

```go
import "go.opentelemetry.io/otel"

var tracer = otel.Tracer("myapp/order-service")

func (s *OrderService) Create(ctx context.Context, req CreateOrderRequest) (*Order, error) {
    ctx, span := tracer.Start(ctx, "OrderService.Create")
    defer span.End()

    // Add attributes that help with debugging
    span.SetAttributes(
        attribute.String("order.payment_method", req.PaymentMethod),
        attribute.Float64("order.amount", req.Amount),
    )

    order, err := s.repo.Insert(ctx, req.ToOrder())
    if err != nil {
        span.RecordError(err)
        span.SetStatus(codes.Error, err.Error())
        return nil, fmt.Errorf("inserting order: %w", err)
    }

    return order, nil
}

func (r *OrderRepo) Insert(ctx context.Context, order Order) (*Order, error) {
    ctx, span := tracer.Start(ctx, "OrderRepo.Insert")
    defer span.End()

    _, err := r.db.ExecContext(ctx, "INSERT INTO orders ...", order.ID)
    if err != nil {
        span.RecordError(err)
        span.SetStatus(codes.Error, err.Error())
        return nil, fmt.Errorf("exec insert: %w", err)
    }
    return &order, nil
}
```

**Where to add spans** — spans MUST be created for:

- Every service method (business logic layer)
- Every database query
- Every external API call
- Every message queue publish/consume
- Any operation that takes measurable time or could fail

## HTTP Middleware with `otelhttp`

Automatically creates spans for incoming and outgoing HTTP requests:

```go
import "go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp"

// Incoming requests — wrap your handler
mux.Handle("/orders", otelhttp.NewHandler(orderHandler, "CreateOrder"))

// Outgoing requests — HTTP clients MUST use otelhttp for automatic span propagation
client := &http.Client{
    Transport: otelhttp.NewTransport(http.DefaultTransport),
}
```

## Span Status and Recording Errors

```go
import (
    "go.opentelemetry.io/otel/codes"
)

// On success — no need to set status (Unset is fine)

// On error — MUST call both RecordError() and SetStatus(Error)
if err != nil {
    span.RecordError(err)
    span.SetStatus(codes.Error, "operation failed")
    return err
}
```

## Structured Errors with `samber/oops`

Standard Go errors lose critical debugging information: there's no stack trace, no structured context, and no way to attach request-scoped metadata. When an error surfaces in a trace, you see `"connection refused"` but not where it originated or which user/tenant was affected.

[`samber/oops`](https://github.com/samber/oops) is a drop-in error library that fills these gaps. Every `oops` error carries a stack trace, structured attributes, and integrates naturally with both OpenTelemetry spans and `slog`:

```go
import "github.com/samber/oops"

func (s *OrderService) Create(ctx context.Context, req CreateOrderRequest) (*Order, error) {
    ctx, span := tracer.Start(ctx, "OrderService.Create")
    defer span.End()

    order, err := s.repo.Insert(ctx, req.ToOrder())
    if err != nil {
        // oops wraps the error with stack trace, structured context, and error code
        return nil, oops.
            In("order-service").
            Code("order_insert_failed").
            With("order_id", req.OrderID).
            With("user_id", req.UserID).
            Wrapf(err, "inserting order")
    }

    return order, nil
}
```

When this error is logged or recorded on a span, you get the full stack trace, the domain (`order-service`), an error code (`order_insert_failed`), and structured attributes (`order_id`, `user_id`) — all machine-parseable and searchable in your observability platform.

`oops` errors work with `span.RecordError()`, `errors.Is`/`errors.As`, and `slog` — see the `samber/cc-skills-golang@golang-error-handling` and `samber/cc-skills-golang@golang-samber-oops` skills for full usage patterns.

## Trace Sampling

In high-throughput services, tracing every request is expensive. Use sampling to control the volume:

```go
tp := sdktrace.NewTracerProvider(
    // Sample 10% of traces in production
    sdktrace.WithSampler(sdktrace.TraceIDRatioBased(0.1)),
    sdktrace.WithBatcher(exporter),
    sdktrace.WithResource(res),
)
```

For more nuanced control, use `sdktrace.ParentBased()` to respect the parent's sampling decision — this keeps traces complete across service boundaries.

## Cost of Tracing

Tracing can be one of the most expensive observability signals. Every span generates data that must be serialized, transmitted, stored, and indexed. In a microservices architecture, a single user request can produce dozens or hundreds of spans across services.

**Cost factors:**

- **Span volume** — a service handling 10k req/s with 5 spans per request generates 50k spans/s. At 100% sampling, this is enormous.
- **Span attributes** — each attribute adds to the payload size. Large attributes (request/response bodies) multiply cost.
- **Storage and indexing** — tracing backends (Jaeger, Tempo, Datadog) charge by volume. Unsampled traces can easily become the largest line item in your observability bill.

**Mitigation:**

- Use sampling (see above) — start with 10% (`TraceIDRatioBased(0.1)`) and adjust based on traffic volume and budget
- For high-throughput services, consider head-based sampling (decide at trace start) or tail-based sampling (decide after the trace completes, keeping only interesting traces like errors or slow requests)
- Avoid attaching large payloads as span attributes — log them instead and correlate via trace_id
