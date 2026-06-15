# Hexagonal Architecture (Ports & Adapters) in Go

## When to Use

Apply hexagonal architecture when a service interacts with multiple external systems (databases, APIs, message queues, caches) and you want the domain logic fully decoupled from all of them. Particularly effective when the same business logic needs multiple entry points (HTTP, gRPC, CLI, message consumer). Do NOT use for simple CRUD apps or libraries.

## Core Concepts

- **Domain** — Business logic and types. No external dependencies.
- **Ports** — Interfaces that define how the domain interacts with the outside world.
  - **Primary (driving) ports**: How the outside world calls into the domain (e.g., `OrderService` interface).
  - **Secondary (driven) ports**: How the domain calls out to infrastructure (e.g., `OrderRepository`, `PaymentGateway` interfaces).
- **Adapters** — Concrete implementations of ports.
  - **Primary adapters**: HTTP handlers, gRPC servers, CLI commands — they call primary ports.
  - **Secondary adapters**: PostgreSQL repository, Stripe client, Redis cache — they implement secondary ports.

## Project Structure

```
order-service/
├── cmd/
│   ├── server/
│   │   └── main.go                  # HTTP server wiring
│   └── worker/
│       └── main.go                  # Message consumer wiring
├── internal/
│   ├── domain/
│   │   ├── order.go                 # Order entity + business rules
│   │   ├── item.go                  # OrderItem
│   │   └── status.go               # OrderStatus enum
│   ├── port/
│   │   ├── incoming.go             # Primary ports (OrderService interface)
│   │   └── outgoing.go             # Secondary ports (OrderRepository, PaymentGateway)
│   ├── service/
│   │   └── order_service.go        # Implements primary ports — orchestrates domain + secondary ports
│   └── adapter/
│       ├── primary/
│       │   ├── http/
│       │   │   ├── router.go
│       │   │   └── order_handler.go # HTTP adapter — calls OrderService
│       │   └── grpc/
│       │       └── order_server.go  # gRPC adapter — calls OrderService
│       └── secondary/
│           ├── postgres/
│           │   └── order_repo.go    # Implements OrderRepository
│           └── stripe/
│               └── payment.go      # Implements PaymentGateway
├── go.mod
└── go.sum
```

## Code Examples

### Domain — pure business logic

```go
// internal/domain/order.go
package domain

type Order struct {
    ID     string
    Items  []Item
    Status OrderStatus
}

func (o *Order) Ship() error {
    if o.Status != StatusPaid {
        return ErrOrderNotPaid
    }
    o.Status = StatusShipped
    return nil
}
```

### Ports — interfaces defined separately from implementations

```go
// internal/port/incoming.go
package port

// Primary port — how the outside world drives the application
type OrderService interface {
    PlaceOrder(ctx context.Context, items []domain.Item) (string, error)
    ShipOrder(ctx context.Context, orderID string) error
    GetOrder(ctx context.Context, orderID string) (*domain.Order, error)
}
```

```go
// internal/port/outgoing.go
package port

// Secondary ports — how the application reaches external systems
type OrderRepository interface {
    Save(ctx context.Context, order *domain.Order) error
    FindByID(ctx context.Context, id string) (*domain.Order, error)
}

type PaymentGateway interface {
    Charge(ctx context.Context, orderID string, amount int64) error
}
```

### Service — implements primary port, depends on secondary ports

```go
// internal/service/order_service.go
package service

type orderService struct {
    orders   port.OrderRepository
    payments port.PaymentGateway
}

func NewOrderService(orders port.OrderRepository, payments port.PaymentGateway) port.OrderService {
    return &orderService{orders: orders, payments: payments}
}

func (s *orderService) PlaceOrder(ctx context.Context, items []domain.Item) (string, error) {
    order := domain.NewOrder(items)

    if err := s.payments.Charge(ctx, order.ID, order.Total()); err != nil {
        return "", fmt.Errorf("charging payment: %w", err)
    }

    if err := s.orders.Save(ctx, order); err != nil {
        return "", fmt.Errorf("saving order: %w", err)
    }

    return order.ID, nil
}
```

### Primary Adapter — HTTP handler calls the service port

```go
// internal/adapter/primary/http/order_handler.go
package http

type OrderHandler struct {
    svc port.OrderService
}

func NewOrderHandler(svc port.OrderService) *OrderHandler {
    return &OrderHandler{svc: svc}
}

func (h *OrderHandler) HandlePlaceOrder(w http.ResponseWriter, r *http.Request) {
    var req PlaceOrderRequest
    if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
        http.Error(w, "invalid request", http.StatusBadRequest)
        return
    }

    id, err := h.svc.PlaceOrder(r.Context(), req.Items)
    if err != nil {
        http.Error(w, err.Error(), mapToHTTPStatus(err))
        return
    }

    json.NewEncoder(w).Encode(map[string]string{"id": id})
}
```

### Secondary Adapter — implements a driven port

```go
// internal/adapter/secondary/postgres/order_repo.go
package postgres

type OrderRepo struct {
    db *sql.DB
}

func NewOrderRepo(db *sql.DB) *OrderRepo {
    return &OrderRepo{db: db}
}

func (r *OrderRepo) Save(ctx context.Context, order *domain.Order) error {
    // SQL upsert
}

func (r *OrderRepo) FindByID(ctx context.Context, id string) (*domain.Order, error) {
    // SQL query
}
```

## Multiple Entry Points

The hexagonal approach shines when the same `OrderService` is called from different primary adapters — HTTP for external clients, gRPC for internal services, a message consumer for async events. Each adapter is wired in its own `cmd/` entry point.

## Wiring

Construct adapters and inject them in `cmd/server/main.go`. → See `samber/cc-skills-golang@golang-dependency-injection` skill for DI library alternatives.
