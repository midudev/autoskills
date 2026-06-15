# Fiber v3 Routing

## Route Registration

Fiber uses an Express-inspired API for route registration. Routes are matched in registration order against a radix tree for zero-allocation lookups.

```go
app := fiber.New()

// Basic routes
app.Get("/", homeHandler)
app.Post("/users", createUser)
app.Put("/users/:id", updateUser)
app.Delete("/users/:id", deleteUser)
app.Patch("/users/:id", patchUser)

// All methods
app.All("/fallback", catchAllHandler)

// Custom method
app.Add("PURGE", "/cache/:key", purgeCache)
```

## Route Parameters

Parameters are extracted from the URL path using `:name` syntax. Optional parameters use `:name?`. Wildcard catches everything with `*`.

```go
// Required parameter
app.Get("/users/:id", func(c fiber.Ctx) error {
    id := c.Params("id") // string
    return c.SendString("User: " + id)
})

// Integer parameter with built-in constraint
app.Get("/posts/:id<int>", func(c fiber.Ctx) error {
    id, err := c.ParamsInt("id")
    if err != nil {
        return fiber.NewError(fiber.StatusBadRequest, "Invalid ID")
    }
    return c.JSON(fiber.Map{"id": id})
})

// Optional parameter
app.Get("/files/:name?", func(c fiber.Ctx) error {
    name := c.Params("name", "index.html") // default value
    return c.SendString(name)
})

// Wildcard
app.Get("/assets/*", func(c fiber.Ctx) error {
    path := c.Params("*") // everything after /assets/
    return c.SendFile("./public/" + path)
})
```

## Route Groups

Groups share a common prefix and middleware. Nested groups inherit parent middleware.

```go
// API version group
api := app.Group("/api")
api.Use(requestIDMiddleware)

// v1 group inherits /api prefix and requestID middleware
v1 := api.Group("/v1")
v1.Use(jwtAuthMiddleware)

// Nested resource
users := v1.Group("/users")
users.Get("/", listUsers)         // GET /api/v1/users
users.Post("/", createUser)       // POST /api/v1/users
users.Get("/:id", getUser)        // GET /api/v1/users/:id
users.Put("/:id", updateUser)     // PUT /api/v1/users/:id
users.Delete("/:id", deleteUser)  // DELETE /api/v1/users/:id

// Admin group with additional middleware
admin := v1.Group("/admin")
admin.Use(adminOnlyMiddleware)
admin.Get("/stats", adminStats)   // GET /api/v1/admin/stats
```

## Route Naming and URL Generation

Named routes allow URL generation without hardcoding paths.

```go
app.Get("/users/:id", getUser).Name("user.show")
app.Post("/users", createUser).Name("user.create")

// Build URL from name
url, err := app.GetRoute("user.show").Params("id", "42")
// url = "/users/42"
```

## Query Parameters

```go
app.Get("/search", func(c fiber.Ctx) error {
    q := c.Query("q")                        // string
    page := c.QueryInt("page", 1)            // int with default
    limit := c.QueryInt("limit", 20)         // int with default

    // Parse all query params into a struct
    var filter SearchFilter
    if err := c.QueryParser(&filter); err != nil {
        return fiber.NewError(fiber.StatusBadRequest, "Invalid query parameters")
    }

    return c.JSON(results)
})

type SearchFilter struct {
    Query    string   `query:"q"`
    Page     int      `query:"page"`
    Limit    int      `query:"limit"`
    Tags     []string `query:"tags"`
    SortBy   string   `query:"sort_by"`
}
```

## Route Constraints

Fiber supports built-in route constraints that validate parameters at the routing level.

```go
app.Get("/users/:id<int>", handler)          // integers only
app.Get("/files/:name<alpha>", handler)      // alphabetic only
app.Get("/posts/:slug<regex(^[a-z-]+$)>", handler)  // custom regex
app.Get("/date/:date<datetime(2006-01-02)>", handler) // date format

// Multiple constraints
app.Get("/items/:id<int;min(1);max(9999)>", handler)
```

## Mount Sub-Applications

Mount separate Fiber apps for modular architectures.

```go
// users/app.go
func NewUsersApp() *fiber.App {
    app := fiber.New()
    app.Get("/", listUsers)
    app.Post("/", createUser)
    return app
}

// main.go
usersApp := users.NewUsersApp()
app.Mount("/api/v1/users", usersApp)
```

## Static File Serving

```go
// Serve directory
app.Static("/assets", "./public", fiber.Static{
    Compress:      true,
    ByteRange:     true,
    Browse:        false,
    CacheDuration: 24 * time.Hour,
    MaxAge:        86400,
})

// Single file
app.Static("/favicon.ico", "./public/favicon.ico")
```

## Route Patterns Summary

| Pattern | Example | Matches |
| --- | --- | --- |
| `/literal` | `/users` | Exact match |
| `/:param` | `/users/:id` | Single segment |
| `/:param?` | `/users/:id?` | Optional segment |
| `/*` | `/files/*` | All remaining segments |
| `/:param<int>` | `/users/:id<int>` | Integer only |
| `/:param<regex(...)>` | `/slug/:s<regex(^[a-z-]+$)>` | Regex match |
