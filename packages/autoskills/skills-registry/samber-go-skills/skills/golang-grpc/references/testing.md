# gRPC Testing Reference

## Testing with `bufconn`

`bufconn` creates in-memory connections that exercise the full gRPC stack (serialization, interceptors, metadata) without network overhead. This is the standard approach for gRPC unit and integration tests.

### Basic Setup

```go
func setupTest(t *testing.T) pb.UserServiceClient {
    t.Helper()
    lis := bufconn.Listen(1024 * 1024)
    t.Cleanup(func() { lis.Close() })

    srv := grpc.NewServer()
    pb.RegisterUserServiceServer(srv, newTestService())
    t.Cleanup(func() { srv.Stop() })
    go srv.Serve(lis)

    conn, err := grpc.NewClient("passthrough:///bufconn",
        grpc.WithContextDialer(func(ctx context.Context, _ string) (net.Conn, error) {
            return lis.DialContext(ctx)
        }),
        grpc.WithTransportCredentials(insecure.NewCredentials()),
    )
    if err != nil {
        t.Fatalf("dial: %v", err)
    }
    t.Cleanup(func() { conn.Close() })
    return pb.NewUserServiceClient(conn)
}
```

### Setup with Interceptors

Test your interceptors by including them in the test server:

```go
func setupTestWithInterceptors(t *testing.T) pb.UserServiceClient {
    t.Helper()
    lis := bufconn.Listen(1024 * 1024)
    t.Cleanup(func() { lis.Close() })

    srv := grpc.NewServer(
        grpc.ChainUnaryInterceptor(
            loggingInterceptor,
            authInterceptor,
            recoveryInterceptor,
        ),
    )
    pb.RegisterUserServiceServer(srv, newTestService())
    t.Cleanup(func() { srv.Stop() })
    go srv.Serve(lis)

    conn, err := grpc.NewClient("passthrough:///bufconn",
        grpc.WithContextDialer(func(ctx context.Context, _ string) (net.Conn, error) {
            return lis.DialContext(ctx)
        }),
        grpc.WithTransportCredentials(insecure.NewCredentials()),
    )
    if err != nil {
        t.Fatalf("dial: %v", err)
    }
    t.Cleanup(func() { conn.Close() })
    return pb.NewUserServiceClient(conn)
}
```

## Testing Error Codes

Always verify that RPCs return the expected gRPC status codes — clients rely on codes for retry and error-handling logic.

```go
func TestGetUser_NotFound(t *testing.T) {
    client := setupTest(t)
    _, err := client.GetUser(context.Background(), &pb.GetUserRequest{UserId: "nonexistent"})

    st, ok := status.FromError(err)
    if !ok {
        t.Fatalf("expected gRPC status error, got: %v", err)
    }
    if st.Code() != codes.NotFound {
        t.Errorf("expected NotFound, got %s: %s", st.Code(), st.Message())
    }
}
```

### Table-Driven Error Code Tests

```go
func TestGetUser_Errors(t *testing.T) {
    client := setupTest(t)

    tests := []struct {
        name     string
        req      *pb.GetUserRequest
        wantCode codes.Code
    }{
        {
            name:     "empty user ID",
            req:      &pb.GetUserRequest{UserId: ""},
            wantCode: codes.InvalidArgument,
        },
        {
            name:     "user not found",
            req:      &pb.GetUserRequest{UserId: "nonexistent"},
            wantCode: codes.NotFound,
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            _, err := client.GetUser(context.Background(), tt.req)
            st, ok := status.FromError(err)
            if !ok {
                t.Fatalf("expected gRPC status error, got: %v", err)
            }
            if st.Code() != tt.wantCode {
                t.Errorf("code = %s, want %s; message: %s", st.Code(), tt.wantCode, st.Message())
            }
        })
    }
}
```

## Testing Streaming RPCs

### Server Streaming

```go
func TestListUsers_Stream(t *testing.T) {
    client := setupTest(t)
    stream, err := client.ListUsers(context.Background(), &pb.ListUsersRequest{})
    if err != nil {
        t.Fatalf("ListUsers: %v", err)
    }

    var users []*pb.User
    for {
        user, err := stream.Recv()
        if err == io.EOF {
            break
        }
        if err != nil {
            t.Fatalf("Recv: %v", err)
        }
        users = append(users, user)
    }

    if len(users) != 3 {
        t.Errorf("got %d users, want 3", len(users))
    }
}
```

### Client Streaming

```go
func TestBatchCreate_ClientStream(t *testing.T) {
    client := setupTest(t)
    stream, err := client.BatchCreateUsers(context.Background())
    if err != nil {
        t.Fatalf("BatchCreateUsers: %v", err)
    }

    for _, u := range testUsers {
        if err := stream.Send(u); err != nil {
            t.Fatalf("Send: %v", err)
        }
    }

    resp, err := stream.CloseAndRecv()
    if err != nil {
        t.Fatalf("CloseAndRecv: %v", err)
    }
    if resp.Created != int32(len(testUsers)) {
        t.Errorf("created = %d, want %d", resp.Created, len(testUsers))
    }
}
```

## Testing Metadata

Verify that interceptors correctly read/write metadata:

```go
func TestAuth_Metadata(t *testing.T) {
    client := setupTestWithInterceptors(t)

    // Without auth token → Unauthenticated
    _, err := client.GetUser(context.Background(), &pb.GetUserRequest{UserId: "1"})
    if st, _ := status.FromError(err); st.Code() != codes.Unauthenticated {
        t.Errorf("expected Unauthenticated without token, got %s", st.Code())
    }

    // With valid token → success
    md := metadata.Pairs("authorization", "Bearer valid-token")
    ctx := metadata.NewOutgoingContext(context.Background(), md)
    resp, err := client.GetUser(ctx, &pb.GetUserRequest{UserId: "1"})
    if err != nil {
        t.Fatalf("expected success with valid token: %v", err)
    }
    if resp.User == nil {
        t.Error("expected user in response")
    }
}
```

## Testing Deadlines

```go
func TestGetUser_DeadlineExceeded(t *testing.T) {
    client := setupTest(t) // server handler sleeps for 5s

    ctx, cancel := context.WithTimeout(context.Background(), 50*time.Millisecond)
    defer cancel()

    _, err := client.GetUser(ctx, &pb.GetUserRequest{UserId: "slow"})
    st, _ := status.FromError(err)
    if st.Code() != codes.DeadlineExceeded {
        t.Errorf("expected DeadlineExceeded, got %s", st.Code())
    }
}
```

## Integration Test Patterns

For tests that hit real dependencies (database, external services), use build tags to separate them:

```go
//go:build integration

func TestUserService_Integration(t *testing.T) {
    // Connect to real gRPC server
    conn, err := grpc.NewClient("localhost:50051",
        grpc.WithTransportCredentials(insecure.NewCredentials()),
    )
    if err != nil {
        t.Fatalf("dial: %v", err)
    }
    defer conn.Close()

    client := pb.NewUserServiceClient(conn)

    // Test full roundtrip
    created, err := client.CreateUser(context.Background(), &pb.CreateUserRequest{
        Name:  "integration-test",
        Email: "test@example.com",
    })
    if err != nil {
        t.Fatalf("CreateUser: %v", err)
    }

    got, err := client.GetUser(context.Background(), &pb.GetUserRequest{
        UserId: created.User.Id,
    })
    if err != nil {
        t.Fatalf("GetUser: %v", err)
    }
    if got.User.Name != "integration-test" {
        t.Errorf("name = %q, want %q", got.User.Name, "integration-test")
    }
}
```

Run integration tests separately:

```bash
go test -tags=integration ./...
```
