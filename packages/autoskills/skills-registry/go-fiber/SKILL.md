---
name: go-fiber
description: "Use when building Go Fiber services, including routing, middleware, WebSockets, request validation, structured errors, and performance tuning."
license: MIT
metadata:
  author: cubis-foundry
  version: "3.0"
compatibility: Claude Code, Codex, GitHub Copilot
---

# Go Fiber v3

## Purpose

Production-grade guidance for building high-performance HTTP APIs and real-time services using Go Fiber v3. Fiber is built on top of fasthttp, delivering Express-inspired ergonomics with Go's concurrency model and near-zero allocation routing.

## When to Use

- Building REST or JSON APIs with Go Fiber v3.
- Configuring middleware stacks for logging, auth, CORS, rate limiting, and recovery.
- Setting up WebSocket endpoints alongside HTTP routes.
- Structuring large Fiber applications with route groups and modular handlers.
- Optimizing request throughput, reducing allocations, and benchmarking Fiber services.
- Migrating from Express.js or net/http to Fiber.

## Instructions

1. **Initialize the Fiber app with explicit configuration** -- create the app with `fiber.New(fiber.Config{...})` and set `ErrorHandler`, `ReadTimeout`, `WriteTimeout`, `IdleTimeout`, and `BodyLimit` explicitly. Leaving these at defaults in production leads to resource exhaustion under load.

2. **Use the Fiber v3 context API, not fasthttp directly** -- access request data through `c.Params()`, `c.Query()`, `c.Body()`, and `c.JSON()`. Reaching into `c.Context()` for raw fasthttp access breaks Fiber's middleware chain and makes code fragile across version upgrades.

3. **Structure routes with `app.Group()` and mount sub-routers** -- group related endpoints under a common prefix (e.g., `/api/v1`) and attach group-level middleware for auth or rate limiting. This keeps route registration readable and lets you apply cross-cutting concerns at the right scope without global middleware bloat.

4. **Build middleware as `fiber.Handler` functions that call `c.Next()`** -- each middleware must either call `c.Next()` to continue the chain or return an error/response to short-circuit. Place recovery middleware first, then logging, then auth, then route-specific middleware. Order determines execution sequence and matters for correctness.

5. **Validate request bodies with a dedicated validator** -- use `go-playground/validator/v10` or a similar library and bind it through a reusable `validate()` helper that calls `c.BodyParser()` then validates the struct. Return `400` with structured field errors. Do not scatter validation logic across handlers because it becomes inconsistent and hard to test.

6. **Return structured error responses with a custom `ErrorHandler`** -- define an `ErrorHandler` in the app config that maps `*fiber.Error`, sentinel errors, and validation errors to consistent JSON envelopes with `code`, `message`, and optional `details`. This centralizes error formatting and prevents handlers from inventing their own response shapes.

7. **Use `c.Locals()` to pass request-scoped data through middleware** -- store authenticated user, request ID, or trace context in locals. Retrieve with type-safe helper functions. Do not use global variables or package-level state for per-request data because fasthttp reuses contexts across connections.

8. **Handle WebSocket connections with `websocket.New()`** -- register WebSocket routes using `app.Get("/ws", websocket.New(handler))` and guard them with an upgrade-check middleware. Manage connection lifecycles with ping/pong deadlines, read limits, and graceful close. Do not mix WebSocket handler logic with REST handlers.

9. **Implement graceful shutdown with `os.Signal` and `app.ShutdownWithTimeout()`** -- listen for `SIGINT`/`SIGTERM` in a goroutine, then call `app.ShutdownWithTimeout(timeout)` to drain in-flight requests. This prevents dropped connections during deploys and lets health checks report the correct state.

10. **Write handler tests using `app.Test()` with `httptest.NewRequest`** -- construct a Fiber app in the test, register the handler under test, build an `*http.Request`, and call `app.Test(req)`. Assert status codes, headers, and JSON bodies. This avoids spinning up a real server and keeps tests fast and deterministic.

11. **Benchmark with `testing.B` and Fiber's built-in test helper** -- write benchmarks that exercise the full middleware chain per request. Use `b.ReportAllocs()` to track allocation regressions. Profile with `pprof` for CPU and heap hotspots before optimizing.

12. **Configure CORS, Helmet, and Rate Limiter middleware from the official packages** -- use `fiber/middleware/cors`, `fiber/middleware/helmet`, and `fiber/middleware/limiter` with explicit allow-lists and limits. Do not rely on permissive defaults (`AllowOrigins: "*"`) in production because it disables credential-based CORS.

13. **Use `fiber/middleware/recover` as the outermost middleware** -- recover catches panics inside handlers and converts them to 500 responses. Without it, a panic in any handler crashes the entire process. Place it before all other middleware so it wraps the full chain.

14. **Serve static files and templates through Fiber's built-in engines** -- use `app.Static()` for file serving with cache headers and `fiber/template/*` engines for server-side rendering. Configure `MaxAge` and `Compress` to reduce bandwidth. Do not serve static files through custom handlers because it bypasses Fiber's optimized file serving.

15. **Propagate `context.Context` for downstream service calls** -- extract the request context with `c.UserContext()` and pass it to database queries, HTTP clients, and gRPC calls. This ensures cancellation propagates when clients disconnect or timeouts fire.

16. **Keep Fiber-specific code at the boundary** -- handlers should parse the request, delegate to a service layer, and format the response. Business logic must not import `gofiber/fiber`. This separation makes logic testable without HTTP concerns and portable across frameworks.

## Output Format

Produces Go source files with Fiber v3 handler signatures, grouped route registration, middleware chains, structured error types, and table-driven handler tests. Includes `go.mod` dependencies and configuration constants where applicable.

## References

Load only what the current step needs.

| File | Load when |
| --- | --- |
| `references/routing.md` | Route registration, groups, parameter parsing, or sub-router mounting needs detail. |
| `references/middleware.md` | Middleware authoring, ordering, or built-in middleware configuration is in scope. |
| `references/error-handling.md` | Custom error handler, structured errors, or panic recovery patterns are needed. |
| `references/testing.md` | Handler testing, integration tests, or benchmark setup is needed. |
| `references/performance.md` | Allocation profiling, fasthttp tuning, or throughput optimization is in scope. |
