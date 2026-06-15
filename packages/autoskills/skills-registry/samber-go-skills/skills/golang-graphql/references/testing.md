# Testing GraphQL in Go

## gqlgen — Client Harness

The `github.com/99designs/gqlgen/client` package drives the full stack (directives, middleware, resolvers) via an `http.Handler`:

```go
func TestCreateUser(t *testing.T) {
    // Build the full handler with real dependencies (use a test DB)
    srv := handler.NewDefaultServer(graph.NewExecutableSchema(graph.Config{
        Resolvers: &graph.Resolver{
            DB: testDB,
        },
    }))

    c := client.New(srv)

    var resp struct {
        CreateUser struct {
            User struct {
                ID    string
                Email string
            }
            Errors []struct{ Message string }
        }
    }

    c.MustPost(`
        mutation CreateUser($email: String!, $name: String!) {
            createUser(input: {email: $email, name: $name}) {
                user { id email }
                errors { message }
            }
        }
    `, &resp,
        client.Var("email", "alice@example.com"),
        client.Var("name", "Alice"),
        client.AddHeader("Authorization", "Bearer test-token"),
    )

    require.Empty(t, resp.CreateUser.Errors)
    require.Equal(t, "alice@example.com", resp.CreateUser.User.Email)
}
```

For unit testing individual resolvers, call resolver methods directly with a constructed `Resolver` and a real `context.Context` — no HTTP overhead.

## gqlgen — Testing with DataLoaders

Wrap the test server with the DataLoader middleware so resolver tests exercise the full batching path:

```go
srv := handler.NewDefaultServer(es)
h := dataloaders.Middleware(testDB, srv)

c := client.New(h)
```

## gqlgen — Testing Subscriptions

Use `client.Subscription` to test subscription resolvers:

```go
sub := c.Subscription(`subscription { messageAdded(room: "general") { content } }`)
defer sub.Close()

// Trigger an event
publishMessage("general", "hello")

var event struct{ MessageAdded struct{ Content string } }
err := sub.Next(&event)
require.NoError(t, err)
require.Equal(t, "hello", event.MessageAdded.Content)
```

## graph-gophers — gqltesting

```go
func TestUser(t *testing.T) {
    gqltesting.RunTests(t, []*gqltesting.Test{
        {
            Schema: schema,
            Query: `{ user(id: "1") { name email } }`,
            ExpectedResult: `{"user":{"name":"Alice","email":"alice@example.com"}}`,
        },
        {
            Schema:        schema,
            Query:         `{ user(id: "999") { name } }`,
            ExpectedErrors: []*gqlerrors.QueryError{
                {Message: "user not found", Extensions: map[string]any{"code": "NOT_FOUND"}},
            },
        },
    })
}
```

For HTTP-level tests:

```go
func TestRelayHandler(t *testing.T) {
    body := `{"query":"{ user(id: \"1\") { name } }"}`
    req := httptest.NewRequest(http.MethodPost, "/graphql", strings.NewReader(body))
    req.Header.Set("Content-Type", "application/json")
    w := httptest.NewRecorder()

    relay.Handler{Schema: schema}.ServeHTTP(w, req)

    require.Equal(t, http.StatusOK, w.Code)
    require.Contains(t, w.Body.String(), `"Alice"`)
}
```

## Testing Error Handling

Verify error extensions reach the client:

```go
var resp struct {
    Errors []struct {
        Message    string
        Extensions struct{ Code string }
    }
}
c.Post(`{ user(id: "999") { name } }`, &resp)
require.Equal(t, "NOT_FOUND", resp.Errors[0].Extensions.Code)
```

## Testing Auth Directives (gqlgen)

Test the directive function directly:

```go
func TestHasRoleDirective(t *testing.T) {
    ctx := context.WithValue(context.Background(), userKey, &domain.User{Role: "USER"})
    _, err := HasRole(ctx, nil, func(ctx context.Context) (any, error) {
        return "ok", nil
    }, model.RoleAdmin)
    require.Error(t, err)

    var gqlErr *gqlerror.Error
    require.True(t, errors.As(err, &gqlErr))
    require.Equal(t, "FORBIDDEN", gqlErr.Extensions["code"])
}
```

## Table-Driven Tests

```go
func TestUserQueries(t *testing.T) {
    tests := []struct {
        name     string
        query    string
        vars     map[string]any
        wantCode string
        wantName string
    }{
        {"existing user", `query($id:ID!){user(id:$id){name}}`, map[string]any{"id": "1"}, "", "Alice"},
        {"missing user", `query($id:ID!){user(id:$id){name}}`, map[string]any{"id": "999"}, "NOT_FOUND", ""},
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            var resp struct {
                User   *struct{ Name string }
                Errors []struct {
                    Extensions struct{ Code string }
                }
            }
            c.Post(tt.query, &resp, client.Var("id", tt.vars["id"]))
            if tt.wantCode != "" {
                require.Equal(t, tt.wantCode, resp.Errors[0].Extensions.Code)
            } else {
                require.Equal(t, tt.wantName, resp.User.Name)
            }
        })
    }
}
```

For testing patterns across the codebase, see the `samber/cc-skills-golang@golang-testing` skill.
