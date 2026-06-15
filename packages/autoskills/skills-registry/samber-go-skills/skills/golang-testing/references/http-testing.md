# HTTP Handler Testing

Use `httptest` package for testing HTTP handlers without starting a server.

## Basic Handler Test

```go
func TestCreateUserHandler(t *testing.T) {
    tests := []struct {
        name           string
        body           string
        expectedStatus int
    }{
        {
            name:           "valid request",
            body:           `{"name": "Alice", "email": "alice@example.com"}`,
            expectedStatus: http.StatusCreated,
        },
        {
            name:           "invalid JSON",
            body:           `invalid json`,
            expectedStatus: http.StatusBadRequest,
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            is := assert.New(t)

            req := httptest.NewRequest(http.MethodPost, "/users", strings.NewReader(tt.body))
            req.Header.Set("Content-Type", "application/json")

            w := httptest.NewRecorder()
            handler := http.HandlerFunc(CreateUserHandler)
            handler.ServeHTTP(w, req)

            is.Equal(tt.expectedStatus, w.Code)
        })
    }
}
```

## Query Parameters and Headers

```go
func TestListUsersHandler(t *testing.T) {
    tests := []struct {
        name           string
        query          string
        authHeader     string
        expectedStatus int
    }{
        {
            name:           "paginated results",
            query:          "?page=1&limit=10",
            authHeader:     "Bearer token123",
            expectedStatus: http.StatusOK,
        },
        {
            name:           "missing auth",
            query:          "?page=1",
            authHeader:     "",
            expectedStatus: http.StatusUnauthorized,
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            is := assert.New(t)

            req := httptest.NewRequest(http.MethodGet, "/users"+tt.query, nil)
            if tt.authHeader != "" {
                req.Header.Set("Authorization", tt.authHeader)
            }

            w := httptest.NewRecorder()
            handler := AuthMiddleware(ListUsersHandler)
            handler.ServeHTTP(w, req)

            is.Equal(tt.expectedStatus, w.Code)
        })
    }
}
```
