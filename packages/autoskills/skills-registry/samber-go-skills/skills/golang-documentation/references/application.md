# Application Documentation

→ See `samber/cc-skills-golang@golang-cli` skill for CLI application patterns and frameworks.

## CLI Help Text

For CLI applications, `--help` output is the primary documentation. CLI tools MUST have comprehensive `--help` text:

```go
// Use cobra or similar framework for structured help text
var rootCmd = &cobra.Command{
    Use:   "mytool",
    Short: "A brief description of mytool",
    Long: `A longer description that explains the tool in detail.

mytool helps you do X, Y, and Z. It connects to your
database and performs analysis on the data.

Environment variables:
  MYTOOL_DB_URL    Database connection string (required)
  MYTOOL_LOG_LEVEL Log level: debug, info, warn, error (default: info)
  MYTOOL_TIMEOUT   Request timeout (default: 30s)`,
    Example: `  # Basic usage
  mytool analyze --input data.csv

  # With custom configuration
  mytool analyze --input data.csv --output report.json --format json

  # Using environment variables
  export MYTOOL_DB_URL="postgres://localhost/mydb"
  mytool serve`,
}
```

---

## Configuration Documentation

Configuration SHOULD be documented. Document all configuration sources in the README or a dedicated `docs/configuration.md`:

````markdown
## Configuration

Configuration is loaded in this order (later sources override earlier ones):

1. Default values
2. Configuration file (`~/.config/mytool/config.yaml`)
3. Environment variables
4. Command-line flags

### Environment Variables

| Variable           | Description                | Default | Required |
| ------------------ | -------------------------- | ------- | -------- |
| `MYTOOL_DB_URL`    | Database connection string | —       | Yes      |
| `MYTOOL_LOG_LEVEL` | Log verbosity              | `info`  | No       |
| `MYTOOL_PORT`      | HTTP server port           | `8080`  | No       |
| `MYTOOL_TIMEOUT`   | Request timeout            | `30s`   | No       |

### Configuration File

```yaml
# ~/.config/mytool/config.yaml
database:
  url: postgres://localhost/mydb
  max_connections: 25
server:
  port: 8080
  read_timeout: 30s
logging:
  level: info
  format: json
```
````

---

## Architecture & design decisions

For complex applications, document architectural decisions in `docs/architecture/`:

```
docs/
  architecture/
    0001-use-postgres-as-primary-store.md
    0002-event-driven-architecture.md
    0003-jwt-for-authentication.md
    README.md
```

Each design document follows a standard format:

```markdown
# Use PostgreSQL as Primary Store

## Context

We need a persistent data store that supports...

## Design

We use PostgreSQL because...

## Consequences

- Positive: ACID transactions, rich query language...
- Negative: Operational overhead, connection management...
```

---

## API Documentation

### REST APIs — OpenAPI / Swagger

Use [swaggo/swag](https://github.com/swaggo/swag) to auto-generate OpenAPI docs from Go annotations:

```go
// @Summary Get user by ID
// @Description Returns a single user
// @Tags users
// @Accept json
// @Produce json
// @Param id path int true "User ID"
// @Success 200 {object} User
// @Failure 404 {object} ErrorResponse
// @Failure 500 {object} ErrorResponse
// @Router /users/{id} [get]
func GetUser(w http.ResponseWriter, r *http.Request) {
```

Generate the spec:

```bash
go get -tool github.com/swaggo/swag/cmd/swag@latest
go tool swag init -g cmd/server/main.go -o docs/swagger
```

This produces `docs/swagger/swagger.json` and `docs/swagger/swagger.yaml`. Serve with Swagger UI or Redoc.

### Event-Driven — AsyncAPI

For message-based APIs (Kafka, NATS, RabbitMQ), use [AsyncAPI](https://www.asyncapi.com/):

```yaml
asyncapi: "2.6.0"
info:
  title: Order Events
  version: "1.0.0"
channels:
  orders/created:
    publish:
      message:
        payload:
          type: object
          properties:
            orderId:
              type: string
            amount:
              type: number
```

### gRPC — Protobuf

Protobuf files serve as both code contracts and documentation. Add comments to messages and RPCs:

```protobuf
syntax = "proto3";

// UserService manages user accounts.
service UserService {
  // GetUser retrieves a user by their unique identifier.
  // Returns NOT_FOUND if the user does not exist.
  rpc GetUser(GetUserRequest) returns (User);

  // CreateUser registers a new user account.
  // Returns ALREADY_EXISTS if the email is taken.
  rpc CreateUser(CreateUserRequest) returns (User);
}

// User represents a registered user account.
message User {
  // Unique identifier for the user (UUID v4).
  string id = 1;
  // User's display name (1-100 characters).
  string name = 2;
  // User's email address (must be unique across all users).
  string email = 3;
}
```

Use [buf](https://buf.build/) for linting and breaking change detection:

```bash
buf lint
buf breaking --against '.git#branch=main'
```

For REST+gRPC, use [grpc-gateway](https://github.com/grpc-ecosystem/grpc-gateway) to serve both from the same protobuf definition.

### When to Use Each Format

| API Style | Format | Auto-generation |
| --- | --- | --- |
| REST/HTTP with Go handlers | OpenAPI 3.x | swaggo/swag from annotations |
| REST/HTTP with framework | OpenAPI 3.x | Framework-specific (e.g., huma) |
| gRPC services | Protobuf | Proto files are the source of truth |
| gRPC + REST gateway | Protobuf + OpenAPI | grpc-gateway generates OpenAPI |
| Message queues / events | AsyncAPI | Manual or code-gen |
| GraphQL | SDL schema | Schema is the docs |
