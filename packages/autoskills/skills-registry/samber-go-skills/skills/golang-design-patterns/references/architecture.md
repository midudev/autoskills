# Architecture Patterns

## Choose the Right Level of Architecture

Architecture complexity MUST match project scope — don't over-architect small projects. When starting a new project, ask the developer what architecture they prefer:

| Project Size | Recommended Approach |
| --- | --- |
| Script / small CLI (<500 lines) | Flat `main.go` + a few files, no layers |
| Medium service (500-5K lines) | Simple layered: `handler/`, `service/`, `repository/` |
| Large service / monolith (5K+ lines) | Clean architecture, hexagonal, or DDD — ask the team |

A 100-line CLI does not need a domain layer, ports and adapters, or dependency injection frameworks. Start simple and refactor when complexity demands it.

## Keep Domain Pure

Domain logic MUST remain pure — no framework or infrastructure dependencies. The domain layer contains business logic and types:

```go
// domain/order.go — pure business logic, no imports from infrastructure
package domain

type Order struct {
    ID     string
    Items  []Item
    Status OrderStatus
}

func (o *Order) AddItem(item Item) error {
    if o.Status != StatusDraft {
        return ErrOrderNotEditable
    }
    o.Items = append(o.Items, item)
    return nil
}
```

Infrastructure concerns (database queries, HTTP clients, message queues) live in separate packages that depend on the domain — never the reverse.

## Fail Fast — Validate at Boundaries

Input MUST be validated at system boundaries (HTTP handlers, CLI argument parsing, message consumers). Once data enters your domain layer, trust it:

```go
// Handler layer — validate here
func (h *Handler) CreateOrder(w http.ResponseWriter, r *http.Request) {
    var req CreateOrderRequest
    if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
        http.Error(w, "invalid JSON", http.StatusBadRequest)
        return
    }
    if req.UserID == "" {
        http.Error(w, "user_id is required", http.StatusBadRequest)
        return
    }
    if len(req.Items) == 0 {
        http.Error(w, "at least one item required", http.StatusBadRequest)
        return
    }

    // Domain layer trusts this data is valid
    order, err := h.service.CreateOrder(r.Context(), req.UserID, req.Items)
    // ...
}
```

Don't re-validate the same data at every layer — it clutters the code and violates DRY.

## Make Illegal States Unrepresentable

Use Go's type system to prevent invalid states from being expressible in code:

```go
// Bad — status is a raw string, anything goes
type Order struct {
    Status string // "pending"? "PENDING"? "active"? anything?
}

// Good — typed enum constrains the values
type OrderStatus int

const (
    OrderStatusUnknown   OrderStatus = iota // 0 = invalid
    OrderStatusDraft                        // 1
    OrderStatusConfirmed                    // 2
    OrderStatusShipped                      // 3
)

type Order struct {
    Status OrderStatus
}
```

```go
// Bad — email is a raw string, could be anything
func SendEmail(to string, body string) error { ... }

// Good — validated type enforces the constraint
type Email struct {
    address string // unexported: can only be created via constructor
}

func NewEmail(raw string) (Email, error) {
    if !isValidEmail(raw) {
        return Email{}, fmt.Errorf("invalid email: %s", raw)
    }
    return Email{address: raw}, nil
}
```

## Detailed Architecture Guides

For projects that warrant a formal architecture (typically 5K+ lines), see the dedicated guides:

- [Domain-Driven Design (DDD)](./ddd.md) — aggregates, value objects, bounded contexts
- [Clean Architecture](./clean-architecture.md) — use cases, dependency rule, layered adapters
- [Hexagonal Architecture](./hexagonal-architecture.md) — ports, adapters, domain core isolation

## 12-Factor App Principles

→ See `samber/cc-skills-golang@golang-project-layout` for 12-Factor App conventions.

## Explicit Over Implicit

Go favors explicitness. Code should express its intent clearly without requiring the reader to know hidden conventions:

```go
// Bad — implicit behavior hidden in struct tags and reflection
type Config struct {
    Port int `default:"8080"`
}

// Good — explicit defaults visible in code
func NewConfig() Config {
    return Config{Port: 8080}
}
```

```go
// Bad — implicit dependency via global
func HandleRequest(w http.ResponseWriter, r *http.Request) {
    user := globalDB.FindUser(r.Context(), userID) // where does globalDB come from?
}

// Good — explicit dependency via injection
func (h *Handler) HandleRequest(w http.ResponseWriter, r *http.Request) {
    user := h.db.FindUser(r.Context(), userID) // clear: db is a field on Handler
}
```

→ See `samber/cc-skills-golang@golang-project-layout` skill for directory structure and layout patterns.
