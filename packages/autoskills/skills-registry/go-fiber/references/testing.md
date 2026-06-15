# Fiber v3 Testing

## Handler Testing with app.Test()

Fiber provides `app.Test()` which accepts a standard `*http.Request` and returns an `*http.Response`. This avoids starting a real server and keeps tests fast.

```go
func TestGetUser(t *testing.T) {
    app := fiber.New(fiber.Config{
        ErrorHandler: customErrorHandler,
    })
    app.Get("/users/:id", getUser)

    req := httptest.NewRequest("GET", "/users/42", nil)
    req.Header.Set("Content-Type", "application/json")

    resp, err := app.Test(req)
    require.NoError(t, err)
    assert.Equal(t, 200, resp.StatusCode)

    var user User
    err = json.NewDecoder(resp.Body).Decode(&user)
    require.NoError(t, err)
    assert.Equal(t, "42", user.ID)
}
```

## Table-Driven Handler Tests

Use table-driven tests to cover multiple scenarios with shared setup.

```go
func TestCreateBookmark(t *testing.T) {
    app := setupTestApp()

    tests := []struct {
        name       string
        body       interface{}
        authToken  string
        wantStatus int
        wantCode   string
        checkBody  func(t *testing.T, body []byte)
    }{
        {
            name: "valid bookmark",
            body: map[string]interface{}{
                "url":   "https://example.com",
                "title": "Example Site",
                "tags":  []string{"web", "reference"},
            },
            authToken:  validToken,
            wantStatus: 201,
            checkBody: func(t *testing.T, body []byte) {
                var bm Bookmark
                require.NoError(t, json.Unmarshal(body, &bm))
                assert.NotEmpty(t, bm.ID)
                assert.Equal(t, "https://example.com", bm.URL)
            },
        },
        {
            name:       "missing required URL",
            body:       map[string]interface{}{"title": "No URL"},
            authToken:  validToken,
            wantStatus: 400,
            wantCode:   "VALIDATION_ERROR",
        },
        {
            name:       "invalid URL format",
            body:       map[string]interface{}{"url": "not-a-url", "title": "Bad"},
            authToken:  validToken,
            wantStatus: 400,
            wantCode:   "VALIDATION_ERROR",
        },
        {
            name:       "no auth token",
            body:       map[string]interface{}{"url": "https://example.com", "title": "Test"},
            authToken:  "",
            wantStatus: 401,
            wantCode:   "UNAUTHORIZED",
        },
        {
            name:       "expired token",
            body:       map[string]interface{}{"url": "https://example.com", "title": "Test"},
            authToken:  expiredToken,
            wantStatus: 401,
            wantCode:   "TOKEN_EXPIRED",
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            bodyBytes, _ := json.Marshal(tt.body)
            req := httptest.NewRequest("POST", "/api/v1/bookmarks",
                bytes.NewReader(bodyBytes))
            req.Header.Set("Content-Type", "application/json")
            if tt.authToken != "" {
                req.Header.Set("Authorization", "Bearer "+tt.authToken)
            }

            resp, err := app.Test(req)
            require.NoError(t, err)
            assert.Equal(t, tt.wantStatus, resp.StatusCode)

            body, _ := io.ReadAll(resp.Body)
            if tt.wantCode != "" {
                var errResp ErrorResponse
                require.NoError(t, json.Unmarshal(body, &errResp))
                assert.Equal(t, tt.wantCode, errResp.Code)
            }
            if tt.checkBody != nil {
                tt.checkBody(t, body)
            }
        })
    }
}
```

## Testing Middleware

Test middleware in isolation by registering it on a minimal app.

```go
func TestRequestIDMiddleware(t *testing.T) {
    app := fiber.New()
    app.Use(requestIDMiddleware)
    app.Get("/test", func(c fiber.Ctx) error {
        return c.JSON(fiber.Map{
            "request_id": c.Locals("requestid"),
        })
    })

    // Test auto-generated ID
    req := httptest.NewRequest("GET", "/test", nil)
    resp, err := app.Test(req)
    require.NoError(t, err)

    id := resp.Header.Get("X-Request-Id")
    assert.NotEmpty(t, id)

    // Test client-provided ID is preserved
    req = httptest.NewRequest("GET", "/test", nil)
    req.Header.Set("X-Request-Id", "client-id-123")
    resp, err = app.Test(req)
    require.NoError(t, err)
    assert.Equal(t, "client-id-123", resp.Header.Get("X-Request-Id"))
}

func TestAuthMiddleware(t *testing.T) {
    app := fiber.New(fiber.Config{ErrorHandler: customErrorHandler})
    app.Use(jwtAuthMiddleware)
    app.Get("/protected", func(c fiber.Ctx) error {
        user := c.Locals("user").(*UserClaims)
        return c.JSON(fiber.Map{"user_id": user.ID})
    })

    tests := []struct {
        name       string
        auth       string
        wantStatus int
    }{
        {"valid token", "Bearer " + validToken, 200},
        {"missing header", "", 401},
        {"invalid format", "Token xyz", 401},
        {"expired token", "Bearer " + expiredToken, 401},
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            req := httptest.NewRequest("GET", "/protected", nil)
            if tt.auth != "" {
                req.Header.Set("Authorization", tt.auth)
            }
            resp, err := app.Test(req)
            require.NoError(t, err)
            assert.Equal(t, tt.wantStatus, resp.StatusCode)
        })
    }
}
```

## Integration Tests with Database

```go
func setupTestApp(t *testing.T) *fiber.App {
    t.Helper()

    db := setupTestDB(t) // Create test database
    t.Cleanup(func() {
        db.Close()
    })

    svc := NewBookmarkService(db)
    app := fiber.New(fiber.Config{ErrorHandler: customErrorHandler})
    RegisterRoutes(app, svc)
    return app
}

func TestCreateAndListBookmarks(t *testing.T) {
    app := setupTestApp(t)

    // Create
    createBody, _ := json.Marshal(CreateBookmarkRequest{
        URL:   "https://example.com",
        Title: "Test",
    })
    req := httptest.NewRequest("POST", "/api/v1/bookmarks",
        bytes.NewReader(createBody))
    req.Header.Set("Content-Type", "application/json")
    req.Header.Set("Authorization", "Bearer "+testToken)

    resp, err := app.Test(req)
    require.NoError(t, err)
    assert.Equal(t, 201, resp.StatusCode)

    // List and verify
    req = httptest.NewRequest("GET", "/api/v1/bookmarks", nil)
    req.Header.Set("Authorization", "Bearer "+testToken)

    resp, err = app.Test(req)
    require.NoError(t, err)
    assert.Equal(t, 200, resp.StatusCode)

    var list []Bookmark
    json.NewDecoder(resp.Body).Decode(&list)
    assert.Len(t, list, 1)
    assert.Equal(t, "https://example.com", list[0].URL)
}
```

## Benchmark Tests

```go
func BenchmarkGetBookmarks(b *testing.B) {
    app := setupBenchApp()
    req := httptest.NewRequest("GET", "/api/v1/bookmarks", nil)
    req.Header.Set("Authorization", "Bearer "+testToken)

    b.ReportAllocs()
    b.ResetTimer()

    for i := 0; i < b.N; i++ {
        resp, err := app.Test(req, fiber.TestConfig{
            Timeout: 0, // Disable timeout for benchmarks
        })
        if err != nil {
            b.Fatal(err)
        }
        resp.Body.Close()
    }
}
```

## Test Helpers

```go
// makeRequest builds and executes a test request
func makeRequest(t *testing.T, app *fiber.App, method, path string, body interface{}, token string) *http.Response {
    t.Helper()

    var bodyReader io.Reader
    if body != nil {
        b, _ := json.Marshal(body)
        bodyReader = bytes.NewReader(b)
    }

    req := httptest.NewRequest(method, path, bodyReader)
    req.Header.Set("Content-Type", "application/json")
    if token != "" {
        req.Header.Set("Authorization", "Bearer "+token)
    }

    resp, err := app.Test(req)
    require.NoError(t, err)
    return resp
}

// decodeBody reads and decodes the response body
func decodeBody[T any](t *testing.T, resp *http.Response) T {
    t.Helper()
    var result T
    body, _ := io.ReadAll(resp.Body)
    require.NoError(t, json.Unmarshal(body, &result))
    return result
}
```
