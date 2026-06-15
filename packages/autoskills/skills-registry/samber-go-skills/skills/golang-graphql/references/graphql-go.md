# graph-gophers/graphql-go Reference

Schema-first, reflection-based — no codegen. Write SDL, bind Go resolver structs. Parse-time validation gives a fail-fast contract.

## Setup

```go
import (
    "github.com/graph-gophers/graphql-go"
    "github.com/graph-gophers/graphql-go/relay"
    "github.com/graph-gophers/graphql-go/trace/otel"
)

schema := graphql.MustParseSchema(sdlString, &RootResolver{},
    graphql.MaxDepth(10),
    graphql.MaxParallelism(10),
    graphql.UseFieldResolvers(), // expose exported struct fields without explicit methods
    graphql.Tracer(otel.DefaultTracer()),
)

http.Handle("/graphql", &relay.Handler{Schema: schema})
```

`MustParseSchema` panics on invalid SDL or resolver mismatch — catch it at startup, not at request time.

## Resolver Structure

One exported method per schema field; name match is case-insensitive:

```go
type RootResolver struct {
    db *sql.DB
}

type QueryResolver struct {
    db *sql.DB
}

func (r *RootResolver) Query() *QueryResolver { return &QueryResolver{db: r.db} }

// Args struct for field arguments
func (r *QueryResolver) User(ctx context.Context, args struct{ ID graphql.ID }) (*UserResolver, error) {
    user, err := r.db.GetUser(ctx, string(args.ID))
    if err != nil {
        return nil, err
    }
    return &UserResolver{user: user}, nil
}
```

Return resolver wrapper structs, not domain models directly — keeps GraphQL projection separate from persistence.

## Type Mapping

<!-- prettier-ignore -->
|GraphQL type|Go type|Notes|
|---|---|---|
|`ID`|`graphql.ID`|string alias|
|`Int`|`int32`|**NOT `int`** — mismatch is a parse-time error|
|`Float`|`float64`||
|`String`|`string`||
|`Boolean`|`bool`||
|`[T]`|`[]*T` or `[]T`||
|Nullable `T`|`*T`|pointer = nullable|
|Non-null `T!`|`T`|non-pointer|
|Custom scalar|implement `UnmarshalGraphQL(input any) error` + `MarshalJSON() ([]byte, error)`||
|Enum|typed string alias||
|Input|exported struct with field tags optional||
|Interface/Union|Go interface returned; `ToConcreteType() (*T, bool)` discriminators||

Common mistake: using `int` for an `Int!` field — the parser rejects it with a type mismatch error.

## Nullable vs Non-null Arguments

```go
// ✓ Good — pointer arg = nullable in schema
func (r *QueryResolver) Users(ctx context.Context, args struct {
    Role *string // nullable: Role in SDL
    Limit int32  // non-null: Limit! in SDL
}) ([]*UserResolver, error) { ... }
```

Forgetting `*` on a nullable argument causes unmarshal failure when clients send `null`.

## Custom Scalar

```go
type DateTime struct{ time.Time }

func (d *DateTime) UnmarshalGraphQL(input any) error {
    s, ok := input.(string)
    if !ok {
        return fmt.Errorf("DateTime must be a string")
    }
    t, err := time.Parse(time.RFC3339, s)
    if err != nil {
        return err
    }
    d.Time = t
    return nil
}

func (d DateTime) MarshalJSON() ([]byte, error) {
    return json.Marshal(d.Time.Format(time.RFC3339))
}
```

## Interfaces and Unions

```graphql
interface Node {
  id: ID!
}
union SearchResult = User | Post
```

```go
// Interface — implement ToUser, ToPost discriminators
type SearchResultResolver struct{ result any }

func (r *SearchResultResolver) ToUser() (*UserResolver, bool) {
    u, ok := r.result.(*domain.User)
    return &UserResolver{u}, ok
}

func (r *SearchResultResolver) ToPost() (*PostResolver, bool) {
    p, ok := r.result.(*domain.Post)
    return &PostResolver{p}, ok
}
```

## DataLoaders

Use `github.com/graph-gophers/dataloader` per-request:

```go
func DataLoaderMiddleware(db *sql.DB, next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        loader := dataloader.NewBatchedLoader(func(ctx context.Context, keys dataloader.Keys) []*dataloader.Result {
            ids := make([]string, len(keys))
            for i, k := range keys {
                ids[i] = k.String()
            }
            posts, err := batchPostsByUserID(ctx, db, ids)
            // map results back to keys order ...
            return results
        })
        ctx := context.WithValue(r.Context(), postsLoaderKey, loader)
        next.ServeHTTP(w, r.WithContext(ctx))
    })
}

// In resolver
func (r *UserResolver) Posts(ctx context.Context) ([]*PostResolver, error) {
    thunk := ctx.Value(postsLoaderKey).(*dataloader.Loader).Load(ctx, dataloader.StringKey(r.user.ID))
    result, err := thunk()
    // ...
}
```

## Error Handling

Implement `ResolverError` to attach structured extensions:

```go
type ResolverError interface {
    error
    Extensions() map[string]any
}

type AppError struct {
    msg  string
    code string
}

func (e *AppError) Error() string { return e.msg }
func (e *AppError) Extensions() map[string]any {
    return map[string]any{"code": e.code}
}

// Usage in resolver
return nil, &AppError{msg: "user not found", code: "NOT_FOUND"}
```

Panics in resolvers are caught automatically and converted to GraphQL errors.

## OpenTelemetry Tracing

```go
import "github.com/graph-gophers/graphql-go/trace/otel"

schema := graphql.MustParseSchema(sdl, &RootResolver{},
    graphql.Tracer(otel.DefaultTracer()),
)
```

Emits spans per request, validation, and field resolution with operation name and field path.

## Subscriptions

```go
func (r *SubscriptionResolver) MessageAdded(ctx context.Context, args struct{ Room string }) <-chan *MessageResolver {
    ch := make(chan *MessageResolver, 1)
    go func() {
        defer close(ch)
        sub := r.pubsub.Subscribe(args.Room)
        defer sub.Unsubscribe()
        for {
            select {
            case <-ctx.Done():
                return
            case msg := <-sub.Chan():
                select {
                case ch <- &MessageResolver{msg: msg}:
                case <-ctx.Done():
                    return
                }
            }
        }
    }()
    return ch
}
```

WebSocket transport is not bundled — pair with `gorilla/websocket` or use the relay handler with a WebSocket-aware mux.

## Disabling Introspection

```go
schema := graphql.MustParseSchema(sdl, &RootResolver{},
    graphql.DisableIntrospection(),
)
```

## Testing

Use `gqltesting.RunTests`:

```go
func TestUser(t *testing.T) {
    gqltesting.RunTests(t, []*gqltesting.Test{
        {
            Schema: schema,
            Query: `{ user(id: "1") { name email } }`,
            ExpectedResult: `{ "user": { "name": "Alice", "email": "alice@example.com" } }`,
        },
    })
}
```

For HTTP-level tests, drive `relay.Handler` with `httptest.NewRecorder()`.

## graph-gophers vs gqlgen Summary

| Concern          | graph-gophers         | gqlgen                      |
| ---------------- | --------------------- | --------------------------- |
| Type safety      | Parse-time reflection | Compile-time codegen        |
| Build complexity | None                  | `go generate` step          |
| Performance      | Slower (reflection)   | Faster (static dispatch)    |
| Federation       | Manual                | First-class (v2)            |
| File uploads     | Manual                | Built-in MultipartForm      |
| Best for         | Small/medium schemas  | Large schemas, strict teams |
