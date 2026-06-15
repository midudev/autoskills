# Code Comments

→ See `samber/cc-skills-golang@golang-naming` skill for naming conventions that reduce the need for comments.

## Function & Method Doc Comments

### Why, Not What

The most common mistake in doc comments is restating the code. The code already tells the reader _what_ happens — comments SHOULD explain why, not what:

- **Why** this function exists (its purpose in the system)
- **When** to use it (and when not to)
- **What constraints** apply (preconditions, thread safety, performance)
- **What can go wrong** (error cases, panics, edge cases)

Bad — restates the code:

```go
// GetUser gets a user by ID.
func GetUser(id string) (*User, error) {
```

Good — explains why, when, and what can go wrong:

```go
// GetUser retrieves a user from the database by their unique identifier.
// Use this for authenticated endpoints where you need the full user profile.
// For listing or searching, use ListUsers instead — it returns lighter projections.
//
// Returns ErrNotFound if no user exists with the given ID.
// Returns ErrDatabaseUnavailable if the connection pool is exhausted.
func GetUser(id string) (*User, error) {
```

### Anti-Patterns to Remove on Sight

| Anti-pattern | Example | Fix |
| --- | --- | --- |
| Pure paraphrase | `// GetUser gets a user` on `func GetUser()` — starts with the name (required by godoc) but adds nothing | After the name, add _when_ to use it, constraints, and what can go wrong |
| Signature restatement | `// Returns a string and an error` | Document _which_ error and _why_ — the signature already shows types |
| Marketing vocabulary | `seamlessly`, `powerful`, `robust`, `enterprise-grade` | Remove — state facts instead |
| Invented rationale | `// designed to improve scalability` | Only document what the code actually does |
| Groundless future claims | `// supports future extensibility` | Remove or back it with an interface or configuration |
| Hollow filler | `// It's worth noting that...`, `// As mentioned above` | Cut — restate the fact directly if it matters |

### Format

Every doc comment MUST start with the function/method name followed by a verb phrase. This is how godoc renders it in package indexes.

```go
// FuncName verb-phrase describing what it does.
```

### Full Comment Template

Use this structure for exported functions and complex internal functions. Omit sections that don't apply (e.g., no Parameters section for zero-arg functions). Focus on the "why" — don't restate what the code already makes obvious:

```go
// FuncName summarizes what this function does in one sentence.
// Additional context explaining behavior, algorithms, or design decisions
// that callers need to know.
//
// Parameters:
//   - paramName: description of what this parameter represents
//   - anotherParam: description with valid ranges or constraints
//
// Returns description of the return value(s).
// Returns ErrSomething if [condition].
// Returns ErrAnother if [different condition].
//
// Panics if [condition] (only document if the function can panic).
//
// It is safe for concurrent use (or: It is NOT safe for concurrent use).
//
// Play: https://go.dev/play/p/xxxxx
//
// Example:
//
//	result, err := pkg.FuncName(arg1, arg2)
//	if err != nil {
//	    log.Fatal(err)
//	}
//	fmt.Println(result)
func FuncName(paramName Type, anotherParam Type) (ResultType, error) {
```

### What to Document

| Element | Document? |
| --- | --- |
| Exported functions/methods | Always |
| Exported types and interfaces | Always |
| Exported constants and variables | Always |
| Complex internal functions | Yes — algorithms, non-obvious logic |
| Simple internal helpers | Optional — only if the name isn't self-explanatory |
| Test functions | No |
| Getters/setters with no logic | Brief one-liner is enough |

`TODO` comments SHOULD include a tracking issue reference when one exists (e.g., `// TODO(#123): ...`). For informal notes, `// TODO(username): ...` or plain `// TODO: ...` is acceptable.

### Error Cases and Limitations

Document every error a function can return, and any edge cases or limitations:

```go
// Parse parses a duration string such as "300ms", "1.5h", or "2h45m".
//
// Parameters:
//   - s: A duration string. Valid time units are "ns", "us", "ms", "s", "m", "h".
//
// Returns the parsed duration.
// Returns ErrInvalidDuration if the string is empty or has an invalid format.
// Returns ErrOverflow if the duration exceeds math.MaxInt64 nanoseconds.
//
// Limitations:
//   - Does not support day, week, month, or year units.
//   - Precision is limited to nanoseconds.
func Parse(s string) (time.Duration, error) {
```

### Deprecated Functions

Use the `Deprecated:` marker. godoc renders this with special styling:

```go
// OldFunc does something.
//
// Deprecated: Use NewFunc instead. OldFunc will be removed in v3.0.0.
func OldFunc() {}
```

### Interface Documentation

Document the interface itself and each method. Explain the contract that implementations must satisfy:

```go
// Store defines a persistent key-value storage backend.
// Implementations must be safe for concurrent use by multiple goroutines.
//
// All methods accept a context for cancellation and deadlines.
// Implementations should respect context cancellation and return
// ctx.Err() when the context is done.
type Store interface {
    // Get retrieves the value associated with key.
    // Returns ErrNotFound if the key does not exist.
    // Returns ErrExpired if the key exists but has expired.
    Get(ctx context.Context, key string) ([]byte, error)

    // Set stores a key-value pair with an optional TTL.
    // If ttl is 0, the entry does not expire.
    // Overwrites any existing value for the same key.
    Set(ctx context.Context, key string, value []byte, ttl time.Duration) error

    // Delete removes a key from the store.
    // Returns nil (not an error) if the key does not exist.
    Delete(ctx context.Context, key string) error
}
```

### Method Comments on Structs

```go
// Close gracefully shuts down the server.
// It waits for active connections to complete up to the configured timeout.
//
// Returns an error if the shutdown times out or if the server
// encounters an error while draining connections.
//
// Close is idempotent — calling it multiple times is safe.
// It is NOT safe to call Close concurrently from multiple goroutines.
func (s *Server) Close() error {
```

### Inline Code Examples in Comments

Indent code examples by one tab in doc comments. godoc renders these as formatted code blocks:

```go
// Transform applies a function to each element of a slice and returns
// a new slice with the results.
//
// Example:
//
//	names := []string{"alice", "bob"}
//	upper := Transform(names, strings.ToUpper)
//	// upper: ["ALICE", "BOB"]
func Transform[T any, U any](slice []T, fn func(T) U) []U {
```

### Playground Links

Add a `Play:` line linking to a runnable Go Playground example of a public library. Use the samber/go-playground-mcp tool to create and share playground URLs when available:

```go
// Map applies a function to each element of a slice.
//
// Play: https://go.dev/play/p/abc123xyz
//
// Example:
//
//	  doubled := Map([]int{1, 2, 3}, func(x int) int { return x * 2 })
//	  // doubled: [2, 4, 6]
func Map[T any, U any](s []T, fn func(T) U) []U {
```

---

## File & Package Comments

### Package Comment

Every package should have a doc comment. Place it in one of these locations:

1. **At the top of the main `.go` file** — for small packages with one or two files
2. **In a dedicated `doc.go` file** — for packages with many files

```go
// Package httputil provides HTTP utility functions for request parsing,
// response writing, and middleware chaining.
//
// It is designed to work with the standard net/http package and does not
// depend on any specific HTTP framework.
package httputil
```

Use `doc.go` when the package has 3+ files or the package comment is longer than ~10 lines:

```go
// Package auth implements authentication and authorization for the API server.
//
// # Architecture
//
// The package uses a middleware-based approach where each authentication
// strategy (JWT, API key, OAuth2) implements the Authenticator interface.
// Strategies are chained and tried in order until one succeeds.
//
// # Token Lifecycle
//
// Access tokens expire after 15 minutes. Refresh tokens expire after 7 days.
// Token rotation is automatic — each refresh request issues a new refresh token
// and invalidates the previous one.
//
// # Thread Safety
//
// All exported functions and types are safe for concurrent use.
package auth
```

### File-Level Description

For files that implement a specific algorithm, feature, or contain complex logic, add a descriptive comment block below the imports. This is a macro description — explain **why** this file or package exists, what problem it solves, and what design choices were made. Use ASCII art to describe complex flows or architectures. Don't describe what each line does:

```go
package scheduler

import (
    "container/heap"
    "sync"
    "time"
)

// This file implements a priority-queue-based task scheduler.
//
// Tasks are scheduled with a target execution time and stored in a min-heap
// ordered by deadline. A single dispatcher goroutine polls the heap and
// executes tasks when their deadline arrives.
//
// Supports: recurring tasks, one-shot tasks, task cancellation, and
// graceful shutdown with drain timeout.
//
// Architecture:
//
//	            Schedule(task)
//                  |
//                  v
//            [Min-Heap Queue]
//             (by deadline)
//                  |
//         Dispatcher Goroutine
//            (polling loop)
//           /              \
//          /                \
//     Deadline              Deadline
//   not reached             reached
//        |                     |
//      wait                    v
//                           Execute
//                              |
//                  Recurring?  |  One-shot
//                  /           |           \
//                 /            v            \
//            Re-queue      Complete      Discard
//                 \            |           /
//                  \           |          /
//                   v          v         v
//                     [Continue polling]

type Scheduler struct {
```

### When to Add File Descriptions

| Scenario | Add description? |
| --- | --- |
| File implements an algorithm (sorting, scheduling, tree traversal) | Yes |
| File contains a complex state machine or protocol | Yes |
| File has 200+ lines of related logic | Yes |
| File is a simple CRUD handler or data model | No |
| File name already explains everything (`json_parser.go`) | Only if non-obvious |

### Godoc Headings in Comments

Use `# Heading` syntax in doc comments (Go 1.19+) for structured documentation:

```go
// Package config provides configuration loading and validation.
//
// # Supported Sources
//
// Configuration can be loaded from environment variables, YAML files,
// or command-line flags. Sources are merged in order of precedence:
// flags > env vars > config file > defaults.
//
// # Validation
//
// All configuration values are validated at load time. Invalid values
// cause an immediate error rather than failing later at runtime.
package config
```
