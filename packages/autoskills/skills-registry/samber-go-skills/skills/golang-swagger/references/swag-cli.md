# swag CLI Reference

## swag init — Generate Documentation

```bash
swag init                                      # parse main.go, generate docs/
swag init -g cmd/api/main.go                   # general info in a different file
swag init -d ./handlers,./models               # additional directories to parse
swag init --exclude ./vendor,./internal/gen    # skip directories
swag init -ot go,json                          # output only Go and JSON (skip YAML)
swag init -q                                   # quiet mode (no log output)
swag init --parseInternal                      # include internal/ packages
swag init --parseDependency                    # parse vendor/module dependencies
swag init --requiredByDefault                  # mark all struct fields as required
swag init -p camelcase                         # property naming: snakecase | camelcase | pascalcase
swag init --tags Users,Products                # only generate for these tags
swag init --tags '!Internal'                   # exclude tag (! prefix)
swag init --td "[[,]]"                         # custom template delimiters
```

## swag fmt — Format Annotations

```bash
swag fmt                                       # format all annotation comments
swag fmt -d ./handlers                         # format specific directory
swag fmt --exclude ./vendor                    # skip directories
```

`swag fmt` requires a standard Go doc comment (`// FuncName godoc`) immediately before the first `@` annotation — without it the formatter cannot determine indentation.

## Framework Integration Packages

| Framework                | Package                             |
| ------------------------ | ----------------------------------- |
| Gin                      | `github.com/swaggo/gin-swagger`     |
| Echo                     | `github.com/swaggo/echo-swagger`    |
| Fiber                    | `github.com/swaggo/fiber-swagger`   |
| Chi / net/http / Gorilla | `github.com/swaggo/http-swagger`    |
| Buffalo                  | `github.com/swaggo/buffalo-swagger` |
| Hertz                    | `github.com/hertz-contrib/swagger`  |

The shared files package (`github.com/swaggo/files`) is required by all integrations.

## Dynamic Configuration

Override spec values at runtime — useful for multi-environment deployments where host and basepath differ between staging and production:

```go
import docs "yourmodule/docs"  // named import required to access docs.SwaggerInfo

func main() {
    docs.SwaggerInfo.Title       = "My API"
    docs.SwaggerInfo.Description = "Production API"
    docs.SwaggerInfo.Version     = "2.0"
    docs.SwaggerInfo.Host        = os.Getenv("API_HOST")
    docs.SwaggerInfo.BasePath    = "/api/v1"
    docs.SwaggerInfo.Schemes     = []string{"https"}
}
```

## Generics (swag v2)

Single type parameter:

```go
// @Success 200 {object} api.Response[model.User]
// @Success 200 {array}  api.Response[model.User]
```

Multiple type parameters:

```go
// @Success 200 {object} api.Response[model.User, model.Meta]
```

## Nested Composition

Embed or override fields in the documented schema without changing Go types:

```go
// @Success 200 {object} api.Envelope{data=model.User}
// @Success 200 {object} api.Envelope{data=[]model.User}
// @Success 200 {object} api.Envelope{data=model.User,meta=api.Pagination}
```

## Response Headers

```go
// @Header 200       {string} X-Request-ID "Unique request identifier"
// @Header 200,400   {string} X-Request-ID "Unique request identifier"
// @Header all       {string} X-Request-ID "Present on every response"
```

## Function-Scoped Structs

swag can parse structs defined inside handler functions:

```go
// @Param req body main.CreateUser.request true "Create user input"
func CreateUser(c *gin.Context) {
    type request struct {
        Name  string `json:"name"`
        Email string `json:"email"`
    }
}
```

## MIME Type Aliases

| Alias                   | Content-Type                      |
| ----------------------- | --------------------------------- |
| `json`                  | application/json                  |
| `xml`                   | application/xml                   |
| `plain`                 | text/plain                        |
| `html`                  | text/html                         |
| `mpfd`                  | multipart/form-data               |
| `x-www-form-urlencoded` | application/x-www-form-urlencoded |
| `octet-stream`          | application/octet-stream          |
| `png` / `jpeg` / `gif`  | image/png, image/jpeg, image/gif  |
| `event-stream`          | text/event-stream                 |
