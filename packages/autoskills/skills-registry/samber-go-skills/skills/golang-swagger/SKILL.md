---
name: golang-swagger
description: "Golang OpenAPI/Swagger documentation with swaggo/swag — annotation comments (@Summary, @Param, @Success, @Router, @Security), swag init code generation, framework integrations (gin, echo, fiber, chi, net/http), security definitions (Bearer/JWT, OAuth2, API key), and struct tags (swaggertype, enums, example, swaggerignore). Apply when adding or maintaining Swagger/OpenAPI docs in a Go project, or when the codebase imports github.com/swaggo/swag, github.com/swaggo/gin-swagger, github.com/swaggo/echo-swagger, github.com/swaggo/http-swagger, or github.com/swaggo/files."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents. Requires go and swag CLI.
metadata:
  author: samber
  version: "1.0.1"
  openclaw:
    emoji: "📋"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
        - swag
    install:
      - kind: go
        package: github.com/swaggo/swag/cmd/swag@latest
        bins: [swag]
    skill-library-version: "2.0.0-rc5"
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Agent WebFetch mcp__context7__resolve-library-id mcp__context7__query-docs Bash(swag:*) AskUserQuestion
---

**Persona:** You are a Go API documentation engineer. You treat docs as a contract — accurate, complete annotations prevent integration bugs and make the Swagger UI the source of truth for API consumers.

**Modes:**

- **Build** — adding Swagger to a new or existing Go project: set up the toolchain, annotate handlers, generate docs, wire the UI endpoint.
- **Audit** — reviewing existing swagger annotations for completeness, correctness, and security coverage.

**Dependencies:**

- swag: `go install github.com/swaggo/swag/cmd/swag@latest`

## Setup

Three steps to get Swagger UI running:

```bash
swag init                        # generates docs/ with docs.go, swagger.json, swagger.yaml
swag init -g cmd/api/main.go     # if general info is not in main.go
swag fmt                         # format annotation comments (like go fmt)
```

Import the `docs` package to register the spec. Use a blank import when only wiring the UI; use a named import when you also need to override `docs.SwaggerInfo` at runtime:

```go
import _ "yourmodule/docs"          // blank: registers spec, no identifier
import docs "yourmodule/docs"       // named: use when overriding SwaggerInfo
```

Wire the UI endpoint — pick your framework:

```go
// Gin
r.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))

// Echo
e.GET("/swagger/*", echoSwagger.WrapHandler)

// Fiber
app.Get("/swagger/*", fiberSwagger.WrapHandler(swaggerFiles.Handler))

// net/http
mux.Handle("/swagger/", httpSwagger.Handler(swaggerFiles.Handler))

// Chi
r.Get("/swagger/*", httpSwagger.Handler(swaggerFiles.Handler))
```

Access the UI at `/swagger/index.html`.

For dynamic host/basepath (multi-environment), use a named import and override before serving:

```go
import docs "yourmodule/docs"

docs.SwaggerInfo.Host     = os.Getenv("API_HOST")
docs.SwaggerInfo.BasePath = "/api/v1"
```

[Full CLI reference](references/swag-cli.md)

## General API Info

Place in `main.go` (or the file passed via `-g`). These annotations define the top-level spec:

```go
// @title           My API
// @version         1.0
// @description     Short description of the API.
// @host            localhost:8080
// @BasePath        /api/v1
// @schemes         http https

// @contact.name    API Support
// @contact.email   support@example.com
// @license.name    Apache 2.0

// @securityDefinitions.apikey Bearer
// @in header
// @name Authorization
// @description Type "Bearer" followed by a space and the JWT token.
```

## Operation Annotations

Annotate each handler function. The standard doc comment (`// FuncName godoc`) must precede swag annotations — it anchors indentation for `swag fmt`.

```go
// ShowAccount godoc
// @Summary      Get account by ID
// @Description  Returns account details for the given ID.
// @Tags         accounts
// @Accept       json
// @Produce      json
// @Param        id      path  int  true  "Account ID"
// @Param        filter  query string false "Optional search filter"
// @Success      200  {object}  model.Account
// @Success      204  "No content"
// @Failure      400  {object}  api.ErrorResponse
// @Failure      404  {object}  api.ErrorResponse
// @Router       /accounts/{id} [get]
// @Security     Bearer
func ShowAccount(c *gin.Context) {}
```

**@Param** format: `@Param <name> <in> <type> <required> "<description>" [attributes]`

| `<in>`     | Usage                                |
| ---------- | ------------------------------------ |
| `path`     | URL path segment (`/users/{id}`)     |
| `query`    | URL query string (`?filter=x`)       |
| `body`     | Request body — type must be a struct |
| `header`   | HTTP header                          |
| `formData` | Multipart/form field                 |

Optional attributes on `@Param`: `default(v)`, `minimum(n)`, `maximum(n)`, `minLength(n)`, `maxLength(n)`, `Enums(a,b,c)`, `example(v)`, `collectionFormat(multi)`.

**@Success/@Failure** format: `@Success <code> {<kind>} <type> "<description>"`

| `<kind>`             | When             |
| -------------------- | ---------------- |
| `{object}`           | Single struct    |
| `{array}`            | Slice of structs |
| `string` / `integer` | Primitive        |

**Generics** (swag v2): `@Success 200 {object} api.Response[model.User]`

**Nested composition**: `@Success 200 {object} api.Response{data=model.User}`

## Security Definitions

Define once at the API level (in main.go), apply per endpoint with `@Security`.

```go
// Bearer / JWT
// @securityDefinitions.apikey Bearer
// @in header
// @name Authorization

// API key in header
// @securityDefinitions.apikey ApiKeyAuth
// @in header
// @name X-API-Key

// Basic auth
// @securityDefinitions.basic BasicAuth

// OAuth2 authorization code
// @securityDefinitions.oauth2.authorizationCode OAuth2
// @authorizationUrl https://example.com/oauth/authorize
// @tokenUrl https://example.com/oauth/token
// @scope.read Read access
// @scope.write Write access
```

Apply to an endpoint:

```go
// @Security Bearer
// @Security OAuth2[read, write]
// @Security BasicAuth && ApiKeyAuth   // AND — both required
```

## Struct Tags

Enrich models without changing their Go type:

```go
type CreateUserRequest struct {
    Name   string `json:"name" example:"Jane Doe" minLength:"2" maxLength:"100"`
    Role   string `json:"role" enums:"admin,user,guest" example:"user"`
    Age    int    `json:"age" minimum:"18" maximum:"120"`
    Avatar []byte `json:"avatar" swaggertype:"string" format:"base64"`
    Secret string `json:"-" swaggerignore:"true"`  // excluded from docs
}
```

| Tag | Purpose |
| --- | --- |
| `example` | Example value shown in Swagger UI |
| `enums` | Comma-separated allowed values |
| `swaggertype` | Override detected type (e.g., `"primitive,integer"` for `time.Time`) |
| `swaggerignore:"true"` | Exclude field from the generated schema |
| `extensions` | Add OpenAPI extensions: `extensions:"x-nullable,x-deprecated=true"` |

## Common Mistakes

| Mistake | Why it breaks | Fix |
| --- | --- | --- |
| Missing `_ "yourmodule/docs"` import | Schema not registered; UI loads empty | Add blank import in main.go or server init |
| Stale `docs/` after code changes | Docs diverge from implementation; consumers get wrong schema | Re-run `swag init` after every annotation change |
| `@Param body` with primitive type | swag cannot derive schema from `string`; generation fails | Always use a named struct for body params |
| No `@Security` on protected routes | Swagger UI shows no lock icon; testers send unauthenticated requests | Apply `@Security` to every authenticated endpoint |
| General info annotations in the wrong file | swag silently skips them; spec has no title/host | Use `-g <file>` flag or move annotations to `main.go` |
| Using `{object}` with a map type | swag cannot generate a schema for `map[string]any` without help | Use a named struct or annotate with `swaggertype` |
| Multi-word `@Tags` without quotes | Tags split on spaces, producing malformed grouping | Quote tags with spaces: `@Tags "user accounts"` |

## Cross-References

- → See `samber/cc-skills-golang@golang-security` for securing the Swagger UI endpoint in production (disable or gate with auth middleware).
- → See `samber/cc-skills-golang@golang-grpc` for gRPC — use grpc-gateway with its own OpenAPI generator instead of swag.

This skill is not exhaustive. Refer to the swaggo/swag documentation and code examples for up-to-date API signatures and usage patterns. Context7 can help as a discoverability platform.

If you encounter a bug or unexpected behavior in swag, open an issue at <https://github.com/swaggo/swag/issues>.
