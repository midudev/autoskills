# Go Fiber Eval Assertions

## Eval 1: REST API with Middleware Stack

### fiber-app-config
Verifies the Fiber application is initialized with explicit production configuration rather than defaults. The response must show `fiber.New(fiber.Config{...})` with a custom `ErrorHandler` function, timeout settings (`ReadTimeout`, `WriteTimeout`), and a `BodyLimit`. This ensures the service is hardened against resource exhaustion and has centralized error formatting from the start.

### route-grouping-middleware
Verifies routes are organized under a versioned group (`/api/v1`) and middleware is layered in the correct order. Recovery must come first to catch panics, followed by request ID injection, logging, and authentication. Rate limiting should be scoped to specific endpoints, not applied globally. This tests that the response understands middleware ordering semantics and does not apply everything globally.

### validation-binding
Verifies request payloads are validated through struct tags and a validator library, not through ad-hoc checks in the handler. The handler must call `c.BodyParser()` to bind the request body, run validation, and return structured 400 errors with per-field detail. This assertion catches responses that skip validation, validate only at the handler level, or return unstructured error strings.

### custom-error-handler
Verifies a centralized `ErrorHandler` exists that handles different error types (Fiber errors, validation errors, sentinel errors) and maps them to a consistent JSON shape. The response must not have handlers formatting their own error responses in different ways. This tests for production-quality error consistency.

### handler-tests
Verifies tests use Fiber's `app.Test()` helper with `httptest.NewRequest` and follow a table-driven pattern. Tests must cover both create and list endpoints, assert on HTTP status codes and JSON response bodies. This catches responses that skip testing, write only happy-path tests, or spin up a real server for unit tests.

---

## Eval 2: WebSocket Endpoint

### websocket-setup
Verifies the WebSocket route uses the Fiber WebSocket package (`websocket.New()`) and includes an upgrade-check middleware that validates the request is a genuine WebSocket upgrade before allowing connection establishment. This prevents non-WebSocket requests from reaching the handler.

### connection-lifecycle
Verifies WebSocket connections are configured with read limits and ping/pong handlers for liveness detection. The response must set `SetReadLimit` to prevent oversized messages and configure pong/ping handlers with deadlines. This ensures connections do not hang indefinitely or accept unbounded payloads.

### broadcast-pattern
Verifies a hub or registry pattern manages active connections with thread safety. The REST endpoint must be able to push messages to all connected WebSocket clients through this shared structure. This tests that the response correctly bridges HTTP and WebSocket communication without race conditions.

### graceful-disconnect
Verifies the handler properly cleans up when a client disconnects. The connection must be removed from the hub, close frames should be sent, and the read loop must break on error. This catches responses that leak connections or fail silently on client disconnect.

### rest-and-ws-tests
Verifies both the REST health endpoint and the WebSocket upgrade path are tested. The health test should use `app.Test()` and assert 200. The WebSocket test should verify upgrade behavior or middleware rejection for non-WebSocket requests. This ensures both transport mechanisms have test coverage.
