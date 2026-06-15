# Tests, Benchmarks, and Examples

## File Naming Conventions

Go uses suffix-based naming for test-related files:

| Suffix | Purpose | Build Tag |
| --- | --- | --- |
| `_test.go` | Tests | Not included in normal builds |
| `_bench_test.go` | Benchmarks | Not included in normal builds |
| `_example_test.go` | Examples that verify output | Not included in normal builds |
| No suffix | Regular code | Included in all builds |

## Where to Place Tests

**Co-locate tests with the code they test:**

```
internal/
├── handler/
│   ├── handler.go          # Production code
│   ├── handler_test.go     # Tests for handler
│   └── handler_bench_test.go  # Benchmarks (optional)
├── service/
│   ├── service.go
│   └── service_test.go
└── model/
    ├── user.go
    └── user_test.go

pkg/
└── logger/
    ├── logger.go
    └── logger_test.go
```

**Key principles:**

- Tests live in the **same package** as the code (e.g., `package handler`)
- Test files are in the **same directory** as the code they test
- Use `_test.go` suffix for all test files

## Test Package Options

When writing tests, you have two options for the package declaration:

**Option 1: Same package (white-box testing)**

```go
package handler  // Same package, can access unexported

import "testing"

func TestHandler(t *testing.T) {
    // Can access unexported functions and types
    internalFunction()
}
```

**Option 2: Package with `_test` suffix (black-box testing)**

```go
package handler_test  // Different package, only exported API

import "testing"

func TestHandler(t *testing.T) {
    // Can only access exported functions and types
    handler.PublicMethod()
}
```

**When to use each:**

- Use **same package** for unit tests that need to test internals
- Use **`_test` suffix** for integration/behavioral tests

## Benchmarks

Benchmarks use the `_bench_test.go` suffix and contain functions with the `Benchmark` prefix.

## Examples

Examples serve two purposes: documentation and verification.

**In libraries** - use `*_example_test.go` files:

```
pkg/
└── logger/
    ├── logger.go
    ├── logger_test.go
    └── logger_example_test.go     # Examples
```

**Example function format:**

```go
package logger

import "fmt"

func ExampleLogger_Info() {
    log := New()
    log.Info("processing started")
    log.Info("processing complete")
    // Output:
    // INFO: processing started
    // INFO: processing complete
}
```

**Key points:**

- Example functions must start with `Example`
- The `// Output:` comment verifies the output
- Examples are runnable tests: `go test` will fail if output doesn't match
- `godoc` displays examples as documentation
- File name format: `{package}_example_test.go` (e.g., `logger_example_test.go`)

**For executable examples** (standalone demo programs):

```
examples/
└── basic-usage/
    └── main.go                    # Executable example
```

## Test Utilities

When you have shared test helpers, use a dedicated package:

```
test/
└── testutils/
    ├── mock.go
    └── fixtures.go
```

Or use the `internal/testutil` pattern:

```
internal/
└── testutil/
    ├── mock.go
    └── fixtures.go
```

## Test Fixtures

Fixtures are test data files used across multiple tests. Use one of these patterns:

**Option 1: Local testdata directory** (package-specific fixtures)

```
internal/
└── handler/
    ├── handler.go
    ├── handler_test.go
    └── testdata/
        ├── users.json
        ├── request_valid.json
        └── request_invalid.json
```

**Option 2: Global test directory** (shared across packages)

```
test/
└── fixtures/
    ├── users.json
    ├── products.json
    └── responses/
        ├── success.json
        └── error.json
```

**Option 3: Embedded fixtures** (Go 1.16+, use `//go:embed`)

```
internal/
└── handler/
    ├── handler.go
    ├── handler_test.go
    └── testdata/
        └── users.json
```

**Important notes:**

- Go ignores the `testdata` directory when building regular packages
- Use `testdata/` for package-specific test data
- Use `test/fixtures/` for cross-package shared fixtures
- Don't put `.go` files in `testdata/` - they will be ignored

## Running Tests

```bash
go test ./...                    # Run all tests
go test ./internal/handler       # Test specific package
go test -v ./...                 # Verbose output
go test -race ./...              # Race detection
go test -cover ./...             # Coverage report
go test -short ./...             # Skip long-running tests
```

## Test File Summary

| File Type | Suffix | Package | Purpose |
| --- | --- | --- | --- |
| Test | `*_test.go` | `package X` or `package X_test` | Unit/integration tests |
| Benchmark | `*_bench_test.go` | Same as code | Performance tests |
| Example (godoc) | `*_example_test.go` | Same as code | Documentation + verification |
| Executable example | No suffix | `package main` | Standalone demo programs |
| Test utilities | `*_test.go` | `package testutil` | Shared test helpers |
