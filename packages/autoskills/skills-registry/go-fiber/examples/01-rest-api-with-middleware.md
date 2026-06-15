# Example: REST API with Middleware Stack

## Prompt

> Build a Fiber v3 REST API for a bookmarks service with CRUD endpoints under /api/v1/bookmarks. Include recovery, request logging, JWT auth, and request validation. Use a custom error handler for consistent JSON errors.

## Expected Output

The skill should produce a complete Fiber application with the following structure:

### Application Bootstrap

```go
package main

import (
    "log"
    "os"
    "os/signal"
    "syscall"
    "time"

    "github.com/gofiber/fiber/v3"
    "github.com/gofiber/fiber/v3/middleware/recover"
    "github.com/gofiber/fiber/v3/middleware/requestid"
)

func main() {
    app := fiber.New(fiber.Config{
        ErrorHandler:  customErrorHandler,
        ReadTimeout:   10 * time.Second,
        WriteTimeout:  10 * time.Second,
        IdleTimeout:   120 * time.Second,
        BodyLimit:     1 * 1024 * 1024, // 1MB
    })

    // Middleware stack: recovery first, then request ID, then logging
    app.Use(recover.New())
    app.Use(requestid.New())
    app.Use(loggerMiddleware)

    // API group with auth
    api := app.Group("/api/v1")
    api.Use(jwtAuthMiddleware)

    // Bookmark routes
    api.Get("/bookmarks", listBookmarks)
    api.Post("/bookmarks", createBookmark)
    api.Get("/bookmarks/:id", getBookmark)
    api.Put("/bookmarks/:id", updateBookmark)
    api.Delete("/bookmarks/:id", deleteBookmark)

    // Graceful shutdown
    go func() {
        sigCh := make(chan os.Signal, 1)
        signal.Notify(sigCh, syscall.SIGINT, syscall.SIGTERM)
        <-sigCh
        log.Println("Shutting down...")
        _ = app.ShutdownWithTimeout(30 * time.Second)
    }()

    log.Fatal(app.Listen(":8080"))
}
```

### Custom Error Handler

```go
func customErrorHandler(c fiber.Ctx, err error) error {
    code := fiber.StatusInternalServerError
    message := "Internal Server Error"

    var fe *fiber.Error
    if errors.As(err, &fe) {
        code = fe.Code
        message = fe.Message
    }

    var ve *ValidationError
    if errors.As(err, &ve) {
        code = fiber.StatusBadRequest
        return c.Status(code).JSON(ErrorResponse{
            Code:    "VALIDATION_ERROR",
            Message: "Request validation failed",
            Details: ve.Fields,
        })
    }

    return c.Status(code).JSON(ErrorResponse{
        Code:    "ERROR",
        Message: message,
    })
}
```

### Handler with Validation

```go
type CreateBookmarkRequest struct {
    URL   string `json:"url" validate:"required,url"`
    Title string `json:"title" validate:"required,min=1,max=200"`
    Tags  []string `json:"tags" validate:"max=10,dive,min=1,max=50"`
}

func createBookmark(c fiber.Ctx) error {
    var req CreateBookmarkRequest
    if err := c.BodyParser(&req); err != nil {
        return fiber.NewError(fiber.StatusBadRequest, "Invalid request body")
    }
    if err := validate.Struct(&req); err != nil {
        return newValidationError(err)
    }

    bookmark := bookmarkService.Create(c.UserContext(), req)
    return c.Status(fiber.StatusCreated).JSON(bookmark)
}
```

## Key Observations

- The app config includes timeouts and body limits for production safety.
- Recovery middleware is outermost to catch panics from all subsequent middleware.
- Route group applies auth middleware only to API routes, not health checks.
- Validation uses struct tags with a shared validator instance.
- The error handler distinguishes between Fiber errors, validation errors, and unknown errors.
- Graceful shutdown listens for OS signals in a separate goroutine.
