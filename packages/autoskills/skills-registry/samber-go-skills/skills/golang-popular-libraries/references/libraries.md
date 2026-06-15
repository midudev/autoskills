# Top Go Libraries by Category

## Web Frameworks

**Gin** (<https://github.com/gin-gonic/gin>) High-performance HTTP web framework with minimalist API. Up to 40x faster than some alternatives. Great for building REST APIs and microservices.

**Echo** (<https://github.com/labstack/echo>) Minimalist, extensible web framework. Clean middleware system, excellent performance. Good for both REST APIs and traditional web apps.

**Fiber** (<https://github.com/gofiber/fiber>) Express.js-inspired web framework built on Fasthttp. Very fast, easy for Node.js developers transitioning to Go.

**Chi** (<https://github.com/go-chi/chi>) Lightweight, idiomatic router that composes well with net/http. Minimal dependencies, great for smaller projects.

## HTTP Clients

**Resty** (<https://github.com/go-resty/resty>) Simple HTTP and REST client for Go. Inspired by Ruby's rest-client. Great for API consumption with retry support.

**Req** (<https://github.com/imroc/req>) Simple Go HTTP client with "black magic" - less code, more efficiency. Clean API for common operations.

## ORM & Database

**GORM** (<https://github.com/go-gorm/gorm>) Feature-complete ORM library. Developer-friendly, supports associations, hooks, auto-migrations. The most popular Go ORM.

**SQLx** (<https://github.com/jmoiron/sqlx>) Extensions for database/sql that provide convenience while maintaining power. Type-safe, performant query helpers.

**Ent** (<https://github.com/ent/ent>) Entity framework for Go. Code-generated, type-safe ORM with excellent support for complex queries and graph traversals.

**Sqlc** (<https://github.com/sqlc-dev/sqlc>) Generate type-safe Go code from SQL. No runtime reflection, compiler-checked queries.

## Database Drivers

**go-sql-driver/mysql** (<https://github.com/go-sql-driver/mysql>) MySQL driver for Go's database/sql package. Maintained by the Go team, reliable and performant.

**lib/pq** (<https://github.com/lib/pq>) Pure Go PostgreSQL driver. The gold standard for PostgreSQL in Go.

**pgx** (<https://github.com/jackc/pgx>) PostgreSQL driver with advanced features. Faster than lib/pq, supports all PostgreSQL types.

**redis-go** (<https://github.com/redis/go-redis>) Redis client for Go. Cluster support, modern Redis features, well-maintained.

**mongo-go-driver** (<https://github.com/mongodb/mongo-go-driver>) Official MongoDB driver for Go. Supports async operations, transactions (in newer versions).

## Testing

**Testify** (<https://github.com/stretchr/testify>) Sacred extension to the testing package. Assertions, mocking, suite testing. Essential for Go testing.

**gomock** (<https://github.com/uber-go/mock>) Mocking framework for Go interfaces. Widely used, integrates well with testing package.

**go-sqlmock** (<https://github.com/DATA-DOG/go-sqlmock>) SQL mock driver for testing database operations. Test database code without a real database.

**testcontainers-go** (<https://golang.testcontainers.org>) Integration testing with real dependencies in Docker containers. Spin up databases, message queues, etc.

**httptest** (standard library) Testing HTTP servers/clients. Built into Go, no external dependency needed.

## Command Line and Configuration

**Cobra** (<https://github.com/spf13/cobra>) Commander for modern Go CLI applications. Powerful subcommand system, flags, auto-generated docs. Industry standard for CLIs.

**Viper** (<https://github.com/spf13/viper>) Go configuration with fangs. Works with Cobra, supports multiple formats (JSON, YAML, TOML, env).

**urfave/cli** (<https://github.com/urfave/cli>) Simple, fast, fun package for building command line apps. Alternative to Cobra.

**Koanf** (<https://github.com/knadh/koanf>) Lightweight, extensible library for reading config. Support for JSON, YAML, TOML, env, command line.

**env** (from <https://github.com/caarlos0/env>) Parse environment variables into Go structs with defaults. Simple, type-safe, no struct tags.

## Logging

**Zap** (<https://github.com/uber-go/zap>) Fast, structured, leveled logging. Uber's production logger, zero-allocation in hot paths.

**Zerolog** (<https://github.com/rs/zerolog>) Zero-allocation JSON logging. Very fast, simple API, leveled logging.

**Logrus** (<https://github.com/sirupsen/logrus>) Structured logger for Go. Mature, widely-used, plugin architecture. Note: deprecated in favor of structured logging.

## Validation

**validator** (<https://github.com/go-playground/validator>) Go struct validation. Tags-based, extensive validators, cross-field validation.

**ozzo-validation** (<https://github.com/go-ozzo/ozzo-validation>) Fast validation library. Modern alternative for struct validation.

## JSON Processing

**jsoniter** (<https://github.com/json-iterator/go>) High-performance 100% compatible drop-in replacement for encoding/json. Faster JSON parsing.

## Authentication & Authorization

**Casbin** (<https://github.com/casbin/casbin>) Authorization library supporting ACL, RBAC, ABAC. Policy-based access control.

**JWT** (<https://github.com/golang-jwt/jwt>) JSON Web Token implementation for Go. Full-featured, widely-used.

## Caching

**Ristretto** (<https://github.com/dgraph-io/ristretto>) High-performance memory-bound Go cache.

**BigCache** (<https://github.com/allegro/bigcache>) Efficient key/value cache for gigabytes of data. Sharded, optimized for high throughput.

**go-cache** (<https://github.com/patrickmn/go-cache>) In-memory key-value store with expiration. Thread-safe, simple API.

## Rate Limiting

**Tollbooth** (<https://github.com/ulule/limiter>) Rate limiting HTTP middleware. Simple, volume-based limiting, easy to use.

**golang.org/x/time/rate** (<https://golang.org/x/time/rate>) Standard library rate limiter. Token bucket algorithm, well-maintained.

## Concurrency & Goroutines

**Watermill** (<https://github.com/ThreeDotsLabs/watermill>) Event-driven framework for Go. Message streams, event sourcing, CQRS patterns.

**ro** (<https://github.com/samber/ro>) Reactive programming for Go. Event-driven streams with operators for data flow transformation.

## Messaging

**franz-go** (<https://github.com/twmb/franz-go>) Kafka client for Go. Modern, high-performance, feature-complete client with excellent documentation and community support.

**amqp091-go** (<https://github.com/rabbitmq/amqp091-go>) Official RabbitMQ client for Go. Maintained by RabbitMQ team, supports AMQP 0.9.1 protocol.

**NATS.go** (<https://github.com/nats-io/nats.go>) Client for NATS messaging system. Simple, secure, performant communications.

**Temporal Go SDK** (<https://github.com/temporalio/sdk-go>) Durable execution framework for building reliable async applications. Workflows, activities, and long-running processes.

**DBOS** (<https://github.com/dbos-inc/dbos-transact-golang>) Backend framework for Go applications with durable execution, built on PostgreSQL.

## Types and Data Structures

**gods** (<https://github.com/emirpasic/gods>) Go Data Structures - Sets, Lists, Stacks, Maps, Trees, Queues, and much more

**bloom** (<https://github.com/bits-and-blooms/bloom>) Bloom filter implementation. Memory-efficient set membership testing.

**hyperloglog** (<https://github.com/clarkduvall/hyperloglog>) HyperLogLog implementation for Go. Memory-efficient cardinality estimation for large datasets.

**Carbon** (<https://github.com/uniplaces/carbon>) Simple, semantic time library for Go. Time parsing, formatting, manipulation.

**google/uuid** (<https://github.com/google/uuid>) Generate and parse UUIDs. Official Google library, RFC 4122 compliant.

## Database Schema Migration

**golang-migrate** (<https://github.com/golang-migrate/migrate>) Database migration tool. Supports multiple databases, version control for schemas.

**goose** (<https://github.com/pressly/goose>) Database migration tool. SQL or Go migrations, supports multiple databases.

## WebSockets

**gorilla/websocket** (<https://github.com/gorilla/websocket>) WebSocket package for Go. Mature, widely-used, part of Gorilla toolkit.

## gRPC

**grpc-go** (<https://github.com/grpc/grpc-go>) The Go language implementation of gRPC. HTTP/2 based RPC framework by Google.

## GraphQL

**gqlgen** (<https://github.com/99designs/gqlgen>) Go generate based graphql server library. Type-safe, schema-first, code generation.

**graphql-go** (<https://github.com/graphql-go/graphql>) Implementation of GraphQL for Go. Query execution, schema parsing.

## File Watching

**fsnotify** (<https://github.com/fsnotify/fsnotify>) Cross-platform file system watcher for Go. Watch for file changes efficiently.

## Retry Logic

**avast/retry-go** (<https://github.com/avast/retry-go>) Retry mechanism for Go with exponential backoff. Simple, configurable.

## Error Handling

**pkg/errors** (<https://github.com/pkg/errors>) Legacy projects only. Prefer stdlib `errors`, `fmt.Errorf("%w")`, and `errors.Join` for new code; use a structured error library only when you need stack traces or rich context.

**oops** (<https://github.com/samber/oops>) Error handling library with stack traces, hints, and context. Rich error wrapping with type-safe error chains.

## Metrics & Monitoring

**prometheus/client_golang** (<https://github.com/prometheus/client_golang>) Prometheus instrumentation library for Go. Metrics, histograms, counters, gauges.

**opentelemetry-go** (<https://github.com/open-telemetry/opentelemetry-go>) OpenTelemetry Go API and SDK. Distributed tracing, metrics, logs.

## API Documentation

**swag** (<https://github.com/swaggo/swag>) Auto-generate OpenAPI/Swagger specs from Go code annotations. Parses comment-based annotations (`@Summary`, `@Param`, `@Success`, `@Router`, etc.) on handler functions to produce `swagger.json`/`swagger.yaml`. Integrates with Gin (`gin-swagger`), Echo (`echo-swagger`), Fiber (`fiber-swagger`), Chi, and net/http. Supports Swagger 2.0 and OpenAPI 3.x output.

## Dependency Injection

**do** (<https://github.com/samber/do>) Dependency injection library for Go. Simple, runtime DI with service locator pattern and health checks.

**Wire** (<https://github.com/google/wire>) Code-generated dependency injection for Go. Compile-time dependency injection without reflection.

**Dig** (<https://github.com/uber-go/dig>) Dependency injection container for Go. Runtime DI with lifecycle management.

**Fx** (<https://github.com/uber-go/fx>) Application framework for Go. Built on Dig, provides lifecycle management, dependency injection, and observability.

## Functional Programming & Utilities

**lo** (<https://github.com/samber/lo>) A generics-based helper library for Go. Slice, map, and tuple operations with functional programming style.

**mo** (<https://github.com/samber/mo>) Monads and functional programming helpers for Go. Option, Either, Try, and other functional patterns.

## Excel & Spreadsheet

**Excelize** (<https://github.com/qax-os/excelize>) Go library for reading and writing Excel files (XLSX). Supports formatting, charts, and complex spreadsheet operations.
