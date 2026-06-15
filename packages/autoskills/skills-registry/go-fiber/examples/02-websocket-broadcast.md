# Example: WebSocket Broadcast Service

## Prompt

> Create a Fiber service with a REST endpoint that publishes messages and a WebSocket endpoint that broadcasts those messages to all connected clients in real time. Include connection lifecycle management and tests.

## Expected Output

The skill should produce a Fiber application with both HTTP and WebSocket transports:

### Connection Hub

```go
package ws

import (
    "sync"

    "github.com/gofiber/contrib/websocket"
)

type Hub struct {
    mu      sync.RWMutex
    clients map[*websocket.Conn]bool
}

func NewHub() *Hub {
    return &Hub{
        clients: make(map[*websocket.Conn]bool),
    }
}

func (h *Hub) Register(conn *websocket.Conn) {
    h.mu.Lock()
    defer h.mu.Unlock()
    h.clients[conn] = true
}

func (h *Hub) Unregister(conn *websocket.Conn) {
    h.mu.Lock()
    defer h.mu.Unlock()
    delete(h.clients, conn)
    conn.Close()
}

func (h *Hub) Broadcast(messageType int, data []byte) {
    h.mu.RLock()
    defer h.mu.RUnlock()
    for conn := range h.clients {
        if err := conn.WriteMessage(messageType, data); err != nil {
            // Connection will be cleaned up on next read error
            continue
        }
    }
}
```

### WebSocket Handler with Lifecycle

```go
func wsHandler(hub *Hub) func(*websocket.Conn) {
    return func(c *websocket.Conn) {
        hub.Register(c)
        defer hub.Unregister(c)

        // Configure connection limits
        c.SetReadLimit(4096)
        c.SetReadDeadline(time.Now().Add(60 * time.Second))
        c.SetPongHandler(func(string) error {
            c.SetReadDeadline(time.Now().Add(60 * time.Second))
            return nil
        })

        // Read loop -- keeps the connection alive and detects disconnects
        for {
            _, _, err := c.ReadMessage()
            if err != nil {
                break // Client disconnected or error
            }
        }
    }
}
```

### Route Registration

```go
func setupRoutes(app *fiber.App, hub *Hub) {
    // Health check (no auth)
    app.Get("/api/health", func(c fiber.Ctx) error {
        return c.JSON(fiber.Map{"status": "ok"})
    })

    // Publish message via REST
    app.Post("/api/messages", func(c fiber.Ctx) error {
        var msg MessageRequest
        if err := c.BodyParser(&msg); err != nil {
            return fiber.NewError(fiber.StatusBadRequest, "Invalid body")
        }
        data, _ := json.Marshal(msg)
        hub.Broadcast(websocket.TextMessage, data)
        return c.Status(fiber.StatusAccepted).JSON(fiber.Map{"published": true})
    })

    // WebSocket upgrade check + handler
    app.Use("/ws", func(c fiber.Ctx) error {
        if websocket.IsWebSocketUpgrade(c) {
            return c.Next()
        }
        return fiber.ErrUpgradeRequired
    })
    app.Get("/ws", websocket.New(wsHandler(hub)))
}
```

### Tests

```go
func TestHealthEndpoint(t *testing.T) {
    hub := ws.NewHub()
    app := fiber.New()
    setupRoutes(app, hub)

    req := httptest.NewRequest("GET", "/api/health", nil)
    resp, err := app.Test(req)
    require.NoError(t, err)
    assert.Equal(t, 200, resp.StatusCode)

    var body map[string]string
    json.NewDecoder(resp.Body).Decode(&body)
    assert.Equal(t, "ok", body["status"])
}

func TestWebSocketUpgradeRejection(t *testing.T) {
    hub := ws.NewHub()
    app := fiber.New()
    setupRoutes(app, hub)

    // Non-WebSocket request to /ws should be rejected
    req := httptest.NewRequest("GET", "/ws", nil)
    resp, err := app.Test(req)
    require.NoError(t, err)
    assert.Equal(t, 426, resp.StatusCode) // Upgrade Required
}
```

## Key Observations

- The hub uses `sync.RWMutex` for concurrent safety -- reads (broadcast) do not block each other.
- The WebSocket handler sets read limits and ping/pong deadlines for liveness.
- Connection cleanup is deferred so it always runs on disconnect.
- The upgrade middleware checks `IsWebSocketUpgrade` before allowing the connection.
- REST and WebSocket coexist on the same Fiber app with shared state through the hub.
- Tests verify both the REST path and the WebSocket upgrade rejection without needing a real WebSocket client.
