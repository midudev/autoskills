# gqlgen Reference

gqlgen is a schema-first, code-generation library. Write SDL, run `go generate`, fill in resolver bodies.

## Project Setup

```bash
# Bootstrap a new project
go run github.com/99designs/gqlgen init

# Pin the tool in go.mod for reproducible generation (Go 1.24+)
go get -tool github.com/99designs/gqlgen@latest
```

For Go <1.24 modules, use the legacy `tools.go` blank-import workaround instead.

```bash
# Regenerate after every schema change
go tool gqlgen generate
```

Never hand-edit generated files (`generated.go`, `models_gen.go`) — `generate` overwrites them.

## gqlgen.yml

```yaml
schema:
  - graph/schema/*.graphql

exec:
  filename: graph/generated.go
  package: graph

model:
  filename: graph/model/models_gen.go
  package: model

resolver:
  layout: follow-schema # one resolvers file per schema file
  dir: graph
  package: graph
  filename_template: "{name}.resolvers.go"

autobind:
  - github.com/me/app/internal/domain # reuse existing structs

models:
  # ID: graphql.IntID  # legacy only — use opaque string IDs for new schemas
  User:
    model: github.com/me/app/internal/domain.User
    fields:
      posts:
        resolver: true # force a custom resolver (required for DataLoader fields)

omit_slice_element_pointers: true
struct_fields_always_pointers: false
resolvers_always_return_pointers: true
```

Key knobs:

- `autobind` — maps Go structs to GraphQL types; fields must match by name (case-insensitive)
- `models.<T>.model` — override which Go type backs a GraphQL type
- `fields.<f>.resolver: true` — force a custom resolver instead of struct field access; required for any field that should batch via DataLoader
- `struct_fields_always_pointers` / `resolvers_always_return_pointers` — controls `*T` vs `T` in generated signatures; match your domain model conventions

## Resolver Structure

The generated `Config` holds a `Resolvers` field of the generated interface. You implement it:

```go
// graph/resolver.go — you own this file, not generated
type Resolver struct {
    db          *sql.DB
    userService *service.UserService
    loaders     *dataloaders.Loaders // injected per-request
}
```

Per-type resolvers implement the generated interface split by GraphQL type:

```go
type queryResolver struct{ *Resolver }
type mutationResolver struct{ *Resolver }
type userResolver struct{ *Resolver }

func (r *queryResolver) User(ctx context.Context, id string) (*model.User, error) { ... }
func (r *userResolver) Posts(ctx context.Context, obj *model.User) ([]*model.Post, error) { ... }
```

`obj` is the parent object — the entry point for walking the graph.

## DataLoaders (gqlgen)

Use `github.com/vikstrous/dataloadgen` (generics, fast) or `github.com/graph-gophers/dataloader`:

```go
// Inject per-request via middleware
func Middleware(db *sql.DB, next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        loaders := &Loaders{
            PostsByUserID: dataloadgen.NewLoader(func(ctx context.Context, ids []string) ([][]*domain.Post, []error) {
                return batchPostsByUserID(ctx, db, ids) // returns one []Post per user ID
            }, dataloadgen.WithWait(1*time.Millisecond)),
        }
        ctx := context.WithValue(r.Context(), loadersKey, loaders)
        next.ServeHTTP(w, r.WithContext(ctx))
    })
}

// Resolver uses the loader — never the DB directly
func (r *userResolver) Posts(ctx context.Context, obj *model.User) ([]*model.Post, error) {
    return loaders.For(ctx).PostsByUserID.Load(ctx, obj.ID)
}
```

Set `wait` to 1–2ms — allows multiple concurrent resolvers to register keys before the batch fires.

## Authentication Directives

```graphql
directive @hasRole(role: Role!) on FIELD_DEFINITION

type Query {
  adminStats: Stats! @hasRole(role: ADMIN)
}
```

```go
// Implement the directive function
func HasRole(ctx context.Context, obj any, next graphql.Resolver, role model.Role) (any, error) {
    user := auth.UserFromContext(ctx)
    if user == nil || user.Role != role {
        return nil, &gqlerror.Error{
            Message:    "access denied",
            Extensions: map[string]any{"code": "FORBIDDEN"},
        }
    }
    return next(ctx)
}

// Register at server bootstrap
c := generated.Config{
    Resolvers: &graph.Resolver{...},
    Directives: generated.DirectiveRoot{
        HasRole: HasRole,
    },
}
```

## Middleware Hooks

```go
srv.AroundOperations(func(ctx context.Context, next graphql.OperationHandler) graphql.ResponseHandler {
    // log operation name, add trace span
    return next(ctx)
})
srv.AroundFields(func(ctx context.Context, next graphql.Resolver) (any, error) {
    // per-field tracing, timing
    return next(ctx)
})
```

## Error Presenter

```go
srv.SetErrorPresenter(func(ctx context.Context, err error) *gqlerror.Error {
    var gqlErr *gqlerror.Error
    if errors.As(err, &gqlErr) {
        return gqlErr
    }
    log.Ctx(ctx).Error("resolver error", "err", err)
    return gqlerror.Errorf("internal server error")
})

srv.SetRecoverFunc(func(ctx context.Context, err any) error {
    log.Ctx(ctx).Error("panic in resolver", "err", err)
    return fmt.Errorf("internal server error")
})
```

## Subscriptions

```go
srv.AddTransport(transport.Websocket{
    KeepAlivePingInterval: 10 * time.Second,
    Upgrader: websocket.Upgrader{
        // Restrict to your own origin in production; true here is dev-only.
        CheckOrigin: func(r *http.Request) bool {
            return r.Header.Get("Origin") == "https://app.example.com"
        },
    },
    InitFunc: func(ctx context.Context, initPayload transport.InitPayload) (context.Context, *transport.InitPayload, error) {
        // auth at connection time
        token := initPayload.Authorization()
        user, err := validateToken(token)
        if err != nil {
            return ctx, nil, err
        }
        return context.WithValue(ctx, userKey, user), &initPayload, nil
    },
})
```

gqlgen supports both `graphql-ws` (legacy) and `graphql-transport-ws` (current) subprotocols.

## File Uploads

```go
srv.AddTransport(transport.MultipartForm{
    MaxUploadSize: 10 << 20, // 10 MB total
    MaxMemory:     5 << 20,  // 5 MB in memory; rest spills to disk
})
```

Schema:

```graphql
scalar Upload

type Mutation {
  uploadAvatar(file: Upload!): User!
}
```

Resolver receives `graphql.Upload{File io.Reader, Filename string, Size int64, ContentType string}`.

## Apollo Federation v2

`gqlgen.yml`:

```yaml
federation:
  filename: graph/federation.go
  version: 2
```

Schema:

```graphql
extend schema
  @link(
    url: "https://specs.apollo.dev/federation/v2.3"
    import: ["@key", "@shareable", "@external"]
  )

type User @key(fields: "id") {
  id: ID!
  name: String!
}
```

Implement `FindUserByID` in the generated entity resolver. Works with Apollo Router and Cosmo.

## Production Handler Setup

```go
srv := handler.New(es)
srv.AddTransport(transport.Options{})
srv.AddTransport(transport.GET{})
srv.AddTransport(transport.POST{})
srv.AddTransport(transport.MultipartForm{MaxUploadSize: 10 << 20, MaxMemory: 5 << 20})
srv.AddTransport(transport.Websocket{KeepAlivePingInterval: 10 * time.Second})

srv.SetQueryCache(lru.New[*ast.QueryDocument](1000))
if os.Getenv("ENV") != "production" {
    srv.Use(extension.Introspection{})
}
srv.Use(extension.AutomaticPersistedQuery{Cache: lru.New[string](100)})
srv.Use(extension.FixedComplexityLimit(200))
```
