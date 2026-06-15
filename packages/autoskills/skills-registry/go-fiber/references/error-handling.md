# Fiber v3 Error Handling

## Custom ErrorHandler

Fiber's `ErrorHandler` in the app config is the central place for all error formatting. Every error returned from a handler or middleware flows through this function.

```go
app := fiber.New(fiber.Config{
    ErrorHandler: func(c fiber.Ctx, err error) error {
        code := fiber.StatusInternalServerError
        response := ErrorResponse{
            Code:    "INTERNAL_ERROR",
            Message: "An unexpected error occurred",
        }

        // Handle Fiber errors (404, 405, etc.)
        var fe *fiber.Error
        if errors.As(err, &fe) {
            code = fe.Code
            response.Code = httpStatusToCode(fe.Code)
            response.Message = fe.Message
        }

        // Handle validation errors
        var ve *ValidationError
        if errors.As(err, &ve) {
            code = fiber.StatusBadRequest
            response.Code = "VALIDATION_ERROR"
            response.Message = "Request validation failed"
            response.Details = ve.Fields
        }

        // Handle not-found errors
        var nfe *NotFoundError
        if errors.As(err, &nfe) {
            code = fiber.StatusNotFound
            response.Code = "NOT_FOUND"
            response.Message = nfe.Error()
        }

        // Handle auth errors
        var ae *AuthError
        if errors.As(err, &ae) {
            code = fiber.StatusUnauthorized
            response.Code = ae.Code
            response.Message = ae.Error()
        }

        // Log unexpected errors
        if code == fiber.StatusInternalServerError {
            log.Printf("ERROR: %v", err)
        }

        return c.Status(code).JSON(response)
    },
})
```

## Error Response Structure

Define a consistent envelope for all error responses across the API.

```go
// ErrorResponse is the standard error envelope
type ErrorResponse struct {
    Code    string       `json:"code"`
    Message string       `json:"message"`
    Details []FieldError `json:"details,omitempty"`
}

// FieldError represents a single validation field error
type FieldError struct {
    Field   string `json:"field"`
    Tag     string `json:"tag"`
    Message string `json:"message"`
}
```

## Custom Error Types

Define domain-specific error types that carry enough context for the ErrorHandler to format them correctly.

```go
// ValidationError wraps validator.ValidationErrors with field details
type ValidationError struct {
    Fields []FieldError
}

func (e *ValidationError) Error() string {
    return "validation failed"
}

func NewValidationError(err error) *ValidationError {
    var ve validator.ValidationErrors
    if !errors.As(err, &ve) {
        return &ValidationError{
            Fields: []FieldError{{Message: err.Error()}},
        }
    }

    fields := make([]FieldError, len(ve))
    for i, fe := range ve {
        fields[i] = FieldError{
            Field:   toSnakeCase(fe.Field()),
            Tag:     fe.Tag(),
            Message: formatFieldError(fe),
        }
    }
    return &ValidationError{Fields: fields}
}

// NotFoundError for missing resources
type NotFoundError struct {
    Resource string
    ID       string
}

func (e *NotFoundError) Error() string {
    return fmt.Sprintf("%s with ID %s not found", e.Resource, e.ID)
}

// AuthError for authentication and authorization failures
type AuthError struct {
    Code    string
    Reason  string
}

func (e *AuthError) Error() string {
    return e.Reason
}

// ConflictError for duplicate resource creation
type ConflictError struct {
    Resource string
    Field    string
    Value    string
}

func (e *ConflictError) Error() string {
    return fmt.Sprintf("%s with %s '%s' already exists", e.Resource, e.Field, e.Value)
}
```

## Sentinel Errors

Use sentinel errors for well-known conditions that handlers check with `errors.Is`.

```go
var (
    ErrUnauthorized   = fiber.NewError(fiber.StatusUnauthorized, "Authentication required")
    ErrForbidden      = fiber.NewError(fiber.StatusForbidden, "Insufficient permissions")
    ErrNotFound       = fiber.NewError(fiber.StatusNotFound, "Resource not found")
    ErrConflict       = fiber.NewError(fiber.StatusConflict, "Resource already exists")
    ErrRateLimited    = fiber.NewError(fiber.StatusTooManyRequests, "Rate limit exceeded")
    ErrServiceUnavail = fiber.NewError(fiber.StatusServiceUnavailable, "Service temporarily unavailable")
)
```

## Using Errors in Handlers

```go
func getUser(c fiber.Ctx) error {
    id := c.Params("id")
    user, err := userService.FindByID(c.UserContext(), id)
    if err != nil {
        if errors.Is(err, sql.ErrNoRows) {
            return &NotFoundError{Resource: "User", ID: id}
        }
        return err // Will be caught as 500 by ErrorHandler
    }
    return c.JSON(user)
}

func createUser(c fiber.Ctx) error {
    var req CreateUserRequest
    if err := c.BodyParser(&req); err != nil {
        return fiber.NewError(fiber.StatusBadRequest, "Invalid request body")
    }
    if err := validate.Struct(&req); err != nil {
        return NewValidationError(err)
    }

    user, err := userService.Create(c.UserContext(), req)
    if err != nil {
        var pgErr *pgconn.PgError
        if errors.As(err, &pgErr) && pgErr.Code == "23505" {
            return &ConflictError{Resource: "User", Field: "email", Value: req.Email}
        }
        return err
    }

    return c.Status(fiber.StatusCreated).JSON(user)
}
```

## Panic Recovery

The recover middleware catches panics and feeds them to the ErrorHandler.

```go
import "github.com/gofiber/fiber/v3/middleware/recover"

app.Use(recover.New(recover.Config{
    EnableStackTrace: true,
    StackTraceHandler: func(c fiber.Ctx, e interface{}) {
        // Log the panic with stack trace
        slog.Error("panic recovered",
            "error", e,
            "stack", string(debug.Stack()),
            "path", c.Path(),
            "method", c.Method(),
        )
    },
}))
```

## Error Wrapping for Context

Wrap errors with additional context as they bubble up through service layers.

```go
// Service layer
func (s *UserService) Create(ctx context.Context, req CreateUserRequest) (*User, error) {
    user, err := s.repo.Insert(ctx, req)
    if err != nil {
        return nil, fmt.Errorf("create user: %w", err)
    }
    return user, nil
}

// The ErrorHandler uses errors.As to unwrap and find known error types
// even when they are wrapped with fmt.Errorf("%w", ...)
```

## HTTP Status Code Mapping

| Error Type | HTTP Status | Code String |
| --- | --- | --- |
| `*fiber.Error` | from error | mapped from status |
| `*ValidationError` | 400 | VALIDATION_ERROR |
| `*NotFoundError` | 404 | NOT_FOUND |
| `*AuthError` | 401 | UNAUTHORIZED |
| `*ConflictError` | 409 | CONFLICT |
| Unhandled error | 500 | INTERNAL_ERROR |
| Panic (recovered) | 500 | INTERNAL_ERROR |
