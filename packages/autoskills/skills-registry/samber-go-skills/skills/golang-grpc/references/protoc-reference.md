# Protobuf & Code Generation Reference

## Directory Layout

Organize proto files by domain with versioned directories. Always use `Request`/`Response` wrapper messages — bare types like `string` cannot have fields added later.

```
proto/
├── user/v1/
│   ├── user.proto          # Messages
│   └── user_service.proto  # Service RPCs
├── order/v1/
│   ├── order.proto
│   └── order_service.proto
└── shared/v1/
    └── common.proto        # Pagination, timestamps, shared enums
```

## Proto File Conventions

```protobuf
syntax = "proto3";
package mycompany.user.v1;
option go_package = "github.com/mycompany/myservice/gen/user/v1;userv1";

service UserService {
  rpc GetUser(GetUserRequest) returns (GetUserResponse);
  rpc ListUsers(ListUsersRequest) returns (ListUsersResponse);
  rpc CreateUser(CreateUserRequest) returns (CreateUserResponse);
  rpc UpdateUser(UpdateUserRequest) returns (UpdateUserResponse);
  rpc DeleteUser(DeleteUserRequest) returns (DeleteUserResponse);
}

message GetUserRequest {
  string user_id = 1;
}

message GetUserResponse {
  User user = 1;
}

message ListUsersRequest {
  int32 page_size = 1;
  string page_token = 2;
}

message ListUsersResponse {
  repeated User users = 1;
  string next_page_token = 2;
}
```

### `go_package` conventions

- Format: `"import/path;alias"` — the alias becomes the Go package name
- Convention: lowercase version suffix (e.g. `userv1`, `orderv1`)
- Generate into a `gen/` directory to keep generated code separate from hand-written code

## Code Generation with `protoc`

```bash
# Basic generation
protoc --go_out=gen --go_opt=paths=source_relative \
       --go-grpc_out=gen --go-grpc_opt=paths=source_relative \
       proto/user/v1/*.proto

# With validation (using buf-validate)
protoc --go_out=gen --go_opt=paths=source_relative \
       --go-grpc_out=gen --go-grpc_opt=paths=source_relative \
       --validate_out="lang=go:gen" \
       proto/user/v1/*.proto

# Include external imports
protoc -I proto -I third_party \
       --go_out=gen --go_opt=paths=source_relative \
       --go-grpc_out=gen --go-grpc_opt=paths=source_relative \
       proto/user/v1/*.proto
```

### Common `protoc` flags

| Flag                             | Purpose                                 |
| -------------------------------- | --------------------------------------- |
| `--go_out=DIR`                   | Output directory for message types      |
| `--go-grpc_out=DIR`              | Output directory for service stubs      |
| `--go_opt=paths=source_relative` | Place output relative to proto source   |
| `-I DIR`                         | Add import path for proto dependencies  |
| `--descriptor_set_out=FILE`      | Emit binary descriptor (for reflection) |

## Code Generation with `buf`

`buf` is the recommended modern alternative to raw `protoc`. It manages dependencies, lints protos, and generates code from a single config.

### `buf.gen.yaml`

```yaml
version: v2
plugins:
  - remote: buf.build/protocolbuffers/go
    out: gen
    opt: paths=source_relative
  - remote: buf.build/grpc/go
    out: gen
    opt: paths=source_relative
```

### `buf.yaml`

```yaml
version: v2
modules:
  - path: proto
lint:
  use:
    - STANDARD
breaking:
  use:
    - FILE
```

### Common `buf` commands

```bash
buf generate              # Generate code from buf.gen.yaml
buf lint                  # Lint proto files
buf breaking --against '.git#branch=main'  # Check backward compatibility
buf dep update            # Update dependencies
buf build                 # Validate proto files compile
```

## Generated Code Patterns

After generation, import and use the generated code:

```go
import (
    userv1 "github.com/mycompany/myservice/gen/user/v1"
)

// Server: implement the interface
type userServer struct {
    userv1.UnimplementedUserServiceServer
}

// Client: use the generated client
client := userv1.NewUserServiceClient(conn)
resp, err := client.GetUser(ctx, &userv1.GetUserRequest{UserId: "123"})
```

Always embed `Unimplemented*Server` (not `Unsafe*Server`) — it provides forward compatibility when new RPCs are added to the proto definition.
