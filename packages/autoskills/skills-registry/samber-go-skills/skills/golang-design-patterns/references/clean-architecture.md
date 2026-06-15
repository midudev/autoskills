# Clean Architecture in Go

## When to Use

Apply clean architecture when you need strong separation between business logic and infrastructure — typically medium-to-large services (2K+ lines) where testability, framework independence, and clear dependency direction matter. Do NOT use for small CLI tools or scripts.

## The Dependency Rule

Dependencies point inward only. Inner layers never import outer layers.

```
Frameworks & Drivers  →  Interface Adapters  →  Use Cases  →  Entities
(HTTP, DB, gRPC)         (handlers, repos)      (app logic)   (domain)
```

Each layer defines interfaces for what it needs. Outer layers implement those interfaces.

## Project Structure

```
order-service/
├── cmd/
│   └── server/
│       └── main.go                  # Wiring only — builds the dependency graph
├── internal/
│   ├── entity/
│   │   ├── order.go                 # Order entity + business rules
│   │   ├── item.go                  # OrderItem
│   │   └── status.go                # OrderStatus enum
│   ├── order/
│   │   ├── place.go                 # PlaceOrderUseCase
│   │   ├── cancel.go                # CancelOrderUseCase
│   │   └── port.go                  # Interfaces this use case depends on
│   ├── adapter/
│   │   ├── handler/
│   │   │   └── order_handler.go    # HTTP handler — calls use cases
│   │   ├── repository/
│   │   │   └── order_postgres.go   # OrderRepository — implements port
│   │   └── gateway/
│   │       └── payment_client.go   # External payment API client
│   └── infrastructure/
│       ├── router.go               # HTTP router setup
│       ├── database.go             # DB connection
│       └── config.go               # Config loading
├── go.mod
└── go.sum
```

## Code Examples

### Entity — pure domain logic, zero dependencies

```go
// internal/entity/order.go
package entity

type Order struct {
    ID     string
    Items  []Item
    Status OrderStatus
}

func (o *Order) Cancel() error {
    if o.Status == StatusShipped {
        return ErrCannotCancelShipped
    }
    o.Status = StatusCancelled
    return nil
}

func (o *Order) Total() int64 {
    var sum int64
    for _, item := range o.Items {
        sum += item.Price * int64(item.Quantity)
    }
    return sum
}
```

### Use Case — orchestrates business operations

```go
// internal/order/port.go
package order

// Ports — interfaces defined by the use case, implemented by adapters
type OrderRepository interface {
    Save(ctx context.Context, order *entity.Order) error
    FindByID(ctx context.Context, id string) (*entity.Order, error)
}

type PaymentGateway interface {
    Charge(ctx context.Context, orderID string, amount int64) error
}
```

```go
// internal/order/place.go
package order

type PlaceOrderUseCase struct {
    orders   OrderRepository
    payments PaymentGateway
}

func NewPlaceOrderUseCase(orders OrderRepository, payments PaymentGateway) *PlaceOrderUseCase {
    return &PlaceOrderUseCase{orders: orders, payments: payments}
}

func (uc *PlaceOrderUseCase) Execute(ctx context.Context, orderID string) error {
    order, err := uc.orders.FindByID(ctx, orderID)
    if err != nil {
        return fmt.Errorf("finding order: %w", err)
    }

    if err := uc.payments.Charge(ctx, order.ID, order.Total()); err != nil {
        return fmt.Errorf("charging payment: %w", err)
    }

    order.Status = entity.StatusPlaced
    return uc.orders.Save(ctx, order)
}
```

### Adapter — implements a port

```go
// internal/adapter/repository/order_postgres.go
package repository

type OrderPostgres struct {
    db *sql.DB
}

func NewOrderPostgres(db *sql.DB) *OrderPostgres {
    return &OrderPostgres{db: db}
}

func (r *OrderPostgres) FindByID(ctx context.Context, id string) (*entity.Order, error) {
    // SQL query, scan into entity.Order
}

func (r *OrderPostgres) Save(ctx context.Context, order *entity.Order) error {
    // SQL upsert
}
```

### Handler — translates HTTP to use case calls

```go
// internal/adapter/handler/order_handler.go
package handler

type OrderHandler struct {
    placeOrder *usecase.PlaceOrderUseCase
}

func (h *OrderHandler) HandlePlaceOrder(w http.ResponseWriter, r *http.Request) {
    orderID := chi.URLParam(r, "id")

    if err := h.placeOrder.Execute(r.Context(), orderID); err != nil {
        // Map domain errors to HTTP status codes
        http.Error(w, err.Error(), mapToHTTPStatus(err))
        return
    }

    w.WriteHeader(http.StatusOK)
}
```

## Key Principle

Interfaces live where they are consumed, not where they are implemented. The `usecase/order/port.go` file defines `OrderRepository` — the adapter in `adapter/repository/` implements it. This keeps the use case layer free from infrastructure imports.

## Wiring

All dependency construction happens in `cmd/server/main.go`. → See `samber/cc-skills-golang@golang-dependency-injection` skill for DI library alternatives.
