---
name: golang-grpc
description: "Provides gRPC usage guidelines, protobuf organization, and production-ready patterns for Golang microservices. Use when implementing, reviewing, or debugging gRPC servers/clients, writing proto files, setting up interceptors, handling gRPC errors with status codes, configuring TLS/mTLS, testing with bufconn, or working with streaming RPCs."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents, and for projects using Golang.
metadata:
  author: samber
  version: "1.1.4"
  openclaw:
    emoji: "🌐"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
        - protoc
    install:
      - kind: brew
        formula: protobuf
        bins: [protoc]
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Agent WebFetch mcp__context7__resolve-library-id mcp__context7__query-docs Bash(protoc:*) AskUserQuestion
---

**Persona:** You are a Go distributed systems engineer. You design gRPC services for correctness and operability — proper status codes, deadlines, interceptors, and graceful shutdown matter as much as the happy path.

**Modes:**

- **Build mode** — implementing a new gRPC server or client from scratch.
- **Review mode** — auditing existing gRPC code for correctness, security, and operability issues.

**Dependencies:**

- protoc: `brew install protobuf`
- protoc-gen-go: `go install google.golang.org/protobuf/cmd/protoc-gen-go@latest`
- protoc-gen-go-grpc: `go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest`

# Go gRPC Best Practices

Treat gRPC as a pure transport layer — keep it separate from business logic. The official Go implementation is `google.golang.org/grpc`.

This skill is not exhaustive. Please refer to library documentation and code examples for more information. Context7 can help as a discoverability platform.

## Quick Reference

| Concern | Package / Tool |
| --- | --- |
| Service definition | `protoc` or `buf` with `.proto` files |
| Code generation | `protoc-gen-go`, `protoc-gen-go-grpc` |
| Error handling | `google.golang.org/grpc/status` with `codes` |
| Rich error details | `google.golang.org/genproto/googleapis/rpc/errdetails` |
| Interceptors | `grpc.ChainUnaryInterceptor`, `grpc.ChainStreamInterceptor` |
| Middleware ecosystem | `github.com/grpc-ecosystem/go-grpc-middleware` |
| Testing | `google.golang.org/grpc/test/bufconn` |
| TLS / mTLS | `google.golang.org/grpc/credentials` |
| Health checks | `google.golang.org/grpc/health` |

## Proto File Organization

Organize by domain with versioned directories (`proto/user/v1/`). Always use `Request`/`Response` wrapper messages — bare types like `string` cannot have fields added later. Generate with `buf generate` or `protoc`.

[Proto & code generation reference](references/protoc-reference.md)

## Server Implementation

- Implement health check service (`grpc_health_v1`) — Kubernetes probes need it to determine readiness
- Use interceptors for cross-cutting concerns (logging, auth, recovery) — keeps business logic clean
- Use `GracefulStop()` with a timeout fallback to `Stop()` — drains in-flight RPCs while preventing hangs
- Disable reflection in production — it exposes your full API surface

```go
srv := grpc.NewServer(
    grpc.ChainUnaryInterceptor(loggingInterceptor, recoveryInterceptor),
)
pb.RegisterUserServiceServer(srv, svc)
healthpb.RegisterHealthServer(srv, health.NewServer())

go srv.Serve(lis)

// On shutdown signal:
stopped := make(chan struct{})
go func() { srv.GracefulStop(); close(stopped) }()
select {
case <-stopped:
case <-time.After(15 * time.Second):
    srv.Stop()
}
```

### Interceptor Pattern

```go
func loggingInterceptor(ctx context.Context, req any, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (any, error) {
    start := time.Now()
    resp, err := handler(ctx, req)
    log.Printf("method=%s duration=%s code=%s", info.FullMethod, time.Since(start), status.Code(err))
    return resp, err
}
```

## Client Implementation

- Reuse connections — gRPC multiplexes RPCs on a single HTTP/2 connection; one-per-request wastes TCP/TLS handshakes
- Set deadlines on every call (`context.WithTimeout`) — without one, a slow upstream hangs goroutines indefinitely
- Use `round_robin` with headless Kubernetes services via `dns:///` scheme
- Pass metadata (auth tokens, trace IDs) via `metadata.NewOutgoingContext`

```go
conn, err := grpc.NewClient("dns:///user-service:50051",
    grpc.WithTransportCredentials(creds),
    grpc.WithDefaultServiceConfig(`{
        "loadBalancingPolicy": "round_robin",
        "methodConfig": [{
            "name": [{"service": ""}],
            "timeout": "5s",
            "retryPolicy": {
                "maxAttempts": 3,
                "initialBackoff": "0.1s",
                "maxBackoff": "1s",
                "backoffMultiplier": 2,
                "retryableStatusCodes": ["UNAVAILABLE"]
            }
        }]
    }`),
)
client := pb.NewUserServiceClient(conn)
```

## Error Handling

Always return gRPC errors using `status.Error` with a specific code — a raw `error` becomes `codes.Unknown`, telling the client nothing actionable. Clients use codes to decide retry vs fail-fast vs degrade.

| Code                 | When to Use                                 |
| -------------------- | ------------------------------------------- |
| `InvalidArgument`    | Malformed input (missing field, bad format) |
| `NotFound`           | Entity does not exist                       |
| `AlreadyExists`      | Create failed, entity exists                |
| `PermissionDenied`   | Caller lacks permission                     |
| `Unauthenticated`    | Missing or invalid token                    |
| `FailedPrecondition` | System not in required state                |
| `ResourceExhausted`  | Rate limit or quota exceeded                |
| `Unavailable`        | Transient issue, safe to retry              |
| `Internal`           | Unexpected bug                              |
| `DeadlineExceeded`   | Timeout                                     |

```go
// ✗ Bad — caller gets codes.Unknown, can't decide whether to retry
return nil, fmt.Errorf("user not found")

// ✓ Good — specific code lets clients act appropriately
if errors.Is(err, ErrNotFound) {
    return nil, status.Errorf(codes.NotFound, "user %q not found", req.UserId)
}
return nil, status.Errorf(codes.Internal, "lookup failed: %v", err)
```

For field-level validation errors, attach `errdetails.BadRequest` via `status.WithDetails`.

## Streaming

| Pattern | Use Case |
| --- | --- |
| Server streaming | Server sends a sequence (log tailing, result sets) |
| Client streaming | Client sends a sequence, server responds once (file upload, batch) |
| Bidirectional | Both send independently (chat, real-time sync) |

Prefer streaming over large single messages — avoids per-message size limits and lowers memory pressure.

```go
func (s *server) ListUsers(req *pb.ListUsersRequest, stream pb.UserService_ListUsersServer) error {
    for _, u := range users {
        if err := stream.Send(u); err != nil {
            return err
        }
    }
    return nil
}
```

## Testing

Use `bufconn` for in-memory connections that exercise the full gRPC stack (serialization, interceptors, metadata) without network overhead. Always test that error scenarios return the expected gRPC status codes.

[Testing patterns and examples](references/testing.md)

## Security

- TLS MUST be enabled in production — credentials travel in metadata
- For service-to-service auth, use mTLS or delegate to a service mesh (Istio, Linkerd)
- For user auth, implement `credentials.PerRPCCredentials` and validate tokens in an auth interceptor
- Reflection SHOULD be disabled in production to prevent API discovery

## Performance

| Setting | Purpose | Typical Value |
| --- | --- | --- |
| `keepalive.ServerParameters.Time` | Ping interval for idle connections | 30s |
| `keepalive.ServerParameters.Timeout` | Ping ack timeout | 10s |
| `grpc.MaxRecvMsgSize` | Override 4 MB default for large payloads | 16 MB |
| Connection pooling | Multiple conns for high-load streaming | 4 connections |

Most services do not need connection pooling — profile before adding complexity.

## Common Mistakes

| Mistake | Fix |
| --- | --- |
| Returning raw `error` | Becomes `codes.Unknown` — client can't decide whether to retry. Use `status.Errorf` with a specific code |
| No deadline on client calls | Slow upstream hangs indefinitely. Always `context.WithTimeout` |
| New connection per request | Wastes TCP/TLS handshakes. Create once, reuse — HTTP/2 multiplexes RPCs |
| Reflection enabled in production | Lets attackers enumerate every method. Enable only in dev/staging |
| `codes.Internal` for all errors | Wrong codes break client retry logic. `Unavailable` triggers retry; `InvalidArgument` does not |
| Bare types as RPC arguments | Can't add fields to `string`. Wrapper messages allow backwards-compatible evolution |
| Missing health check service | Kubernetes can't determine readiness, kills pods during deployments |
| Ignoring context cancellation | Long operations continue after caller gave up. Check `ctx.Err()` |

## Cross-References

- → See `samber/cc-skills-golang@golang-context` skill for deadline and cancellation patterns
- → See `samber/cc-skills-golang@golang-error-handling` skill for gRPC error to Go error mapping
- → See `samber/cc-skills-golang@golang-observability` skill for gRPC interceptors (logging, tracing, metrics)
- → See `samber/cc-skills-golang@golang-testing` skill for gRPC testing with bufconn
