# Testing — google/wire

Wire generates plain Go constructor calls, so tests work directly on the constructor layer — no container API to learn.

## Unit Tests: Plain Constructor Injection

The generated code has no wire dependency. Test constructors directly:

```go
func TestUserService_GetUser(t *testing.T) {
    mockStore := &MockUserStore{users: map[int64]*User{1: &User{ID: 1, Name: "Alice"}}}
    cache := newTestRedis(t)
    svc := service.NewUserService(mockStore, cache)

    u, err := svc.GetUser(context.Background(), 1)
    require.NoError(t, err)
    assert.Equal(t, "Alice", u.Name)
}
```

Pass mocks directly as constructor arguments. No wire, no container, no file to generate. This is the idiomatic approach for unit tests.

## Test Injectors: Swapping Providers

For integration or component tests where you want the full wired graph but with selected dependencies replaced, create a test-only injector in a `_test.go` file.

```go
// app_test.go
//go:build wireinject

package main

import (
    "testing"
    "github.com/google/wire"
)

// TestSet replaces real infra with in-memory fakes
var TestSet = wire.NewSet(
    NewTestConfig,
    NewInMemoryUserStore,
    wire.Bind(new(repo.UserStore), new(*InMemoryUserStore)),
    NewTestRedis,
)

func InitTestApp(t *testing.T) (*App, func(), error) {
    wire.Build(TestSet, service.ServiceSet, NewApp)
    return nil, nil, nil
}
```

```go
// app_integration_test.go
//go:build !wireinject  // compiles when the wireinject tag is NOT set

package main

func TestApp_GetUser(t *testing.T) {
    app, cleanup, err := InitTestApp(t)
    require.NoError(t, err)
    defer cleanup()

    // test against the fully-wired app with fake dependencies
    u, err := app.GetUser(context.Background(), 1)
    require.NoError(t, err)
    assert.NotNil(t, u)
}
```

Run `wire ./...` to generate `wire_gen.go` — the test injector is included because the `_test.go` file is compiled as part of the package during `go test`.

**Key pattern from upstream best practices:** Prefer creating a test-only provider set over passing mocks as injector arguments (though both work). The set approach keeps the test injector composable.

## Passing Mocks as Injector Arguments

An alternative to a test set: pass the mock directly as an injector parameter. Wire treats it as a pre-built provider.

```go
//go:build wireinject

func InitTestApp(store repo.UserStore) (*App, func(), error) {
    wire.Build(config.ConfigSet, service.ServiceSet, NewApp)
    return nil, nil, nil
}

// Test
func TestApp(t *testing.T) {
    mock := &MockUserStore{}
    app, cleanup, err := InitTestApp(mock)
    require.NoError(t, err)
    defer cleanup()
    // ...
}
```

Use this form when you only need to replace one or two dependencies and a full `TestSet` is overkill.

## CI: Detecting Stale `wire_gen.go`

If `wire_gen.go` is not regenerated after a provider change, CI builds pass but the graph is wrong. Enforce freshness in CI:

```bash
# Option 1: re-run wire and check for diffs
wire ./...
git diff --exit-code -- '**/wire_gen.go'
```

```yaml
# .github/workflows/ci.yml
- name: Check wire_gen.go is up-to-date
  run: |
    go install github.com/google/wire/cmd/wire@v0.7.0
    wire ./...
    git diff --exit-code -- '**/wire_gen.go'
```

```bash
# Option 2: use wire check (verifies graph without regenerating)
wire check ./...
```

`wire check` exits non-zero if the graph is inconsistent but does **not** update `wire_gen.go`. Use it for a fast graph-validity check without modifying files.

## Testing Interface Bindings

`wire.Bind` can be used in test sets to bind a fake to the same interface:

```go
// Fake implements the same interface as the real provider
type FakeMailer struct{ sent []string }
func (f *FakeMailer) Send(to, body string) error { f.sent = append(f.sent, to); return nil }

var TestMailerSet = wire.NewSet(
    NewFakeMailer,
    wire.Bind(new(notification.Mailer), new(*FakeMailer)),
)

var TestSet = wire.NewSet(
    TestMailerSet,
    realServiceSet,  // everything else is real
)
```

This keeps the test injector narrow — only the Mailer is faked; the rest of the graph is real.

## Table-Driven Tests Without Wire

Wire is an initialization tool. Once the object graph is built, table-driven tests on individual services need no wire involvement:

```go
func TestUserService(t *testing.T) {
    cases := []struct {
        name  string
        id    int64
        users map[int64]*User
        want  string
        err   bool
    }{
        {"found", 1, map[int64]*User{1: &User{Name: "Alice"}}, "Alice", false},
        {"not found", 99, nil, "", true},
    }
    for _, tc := range cases {
        t.Run(tc.name, func(t *testing.T) {
            svc := service.NewUserService(&MockUserStore{users: tc.users}, nil)
            u, err := svc.GetUser(context.Background(), tc.id)
            if tc.err { require.Error(t, err); return }
            assert.Equal(t, tc.want, u.Name)
        })
    }
}
```

Wire has no role here — the injector was only needed to build the object graph in `main` (or in an integration test). Unit tests construct dependencies directly.
