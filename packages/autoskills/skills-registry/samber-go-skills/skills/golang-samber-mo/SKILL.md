---
name: golang-samber-mo
description: "Monadic types for Golang using samber/mo — Option, Result, Either, Future, IO, Task, and State types for type-safe nullable values, error handling, and functional composition with pipeline sub-packages. Apply when using or adopting samber/mo, when the codebase imports `github.com/samber/mo`, or when considering functional programming patterns as a safety design for Golang."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents, and for projects using Golang.
metadata:
  author: samber
  version: "1.0.4"
  openclaw:
    emoji: "🎭"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
    install: []
    skill-library-version: "1.16.0"
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Agent WebFetch mcp__context7__resolve-library-id mcp__context7__query-docs AskUserQuestion
---

**Persona:** You are a Go engineer bringing functional programming safety to Go. You use monads to make impossible states unrepresentable — nil checks become type constraints, error handling becomes composable pipelines.

**Thinking mode:** Use `ultrathink` when designing multi-step Option/Result/Either pipelines. Wrong type choice creates unnecessary wrapping/unwrapping that defeats the purpose of monads.

# samber/mo — Monads and Functional Abstractions for Go

Go 1.18+ library providing type-safe monadic types with zero dependencies. Inspired by Scala, Rust, and fp-ts.

**Official Resources:**

- [pkg.go.dev/github.com/samber/mo](https://pkg.go.dev/github.com/samber/mo)
- [github.com/samber/mo](https://github.com/samber/mo)

This skill is not exhaustive. Please refer to library documentation and code examples for more information. Context7 can help as a discoverability platform.

```bash
go get github.com/samber/mo
```

For an introduction to functional programming concepts and why monads are valuable in Go, see [Monads Guide](./references/monads-guide.md).

## Core Types at a Glance

| Type | Purpose | Think of it as... |
| --- | --- | --- |
| `Option[T]` | Value that may be absent | Rust's `Option`, Java's `Optional` |
| `Result[T]` | Operation that may fail | Rust's `Result<T, E>`, replaces `(T, error)` |
| `Either[L, R]` | Value of one of two types | Scala's `Either`, TypeScript discriminated union |
| `EitherX[L, R]` | Value of one of X types | Scala's `Either`, TypeScript discriminated union |
| `Future[T]` | Async value not yet available | JavaScript `Promise` |
| `IO[T]` | Lazy synchronous side effect | Haskell's `IO` |
| `Task[T]` | Lazy async computation | fp-ts `Task` |
| `State[S, A]` | Stateful computation | Haskell's `State` monad |

## Option[T] — Nullable Values Without nil

Represents a value that is either present (`Some`) or absent (`None`). Eliminates nil pointer risks at the type level.

```go
import "github.com/samber/mo"

name := mo.Some("Alice")          // Option[string] with value
empty := mo.None[string]()        // Option[string] without value
fromPtr := mo.PointerToOption(ptr) // nil pointer -> None

// Safe extraction
name.OrElse("Anonymous")  // "Alice"
empty.OrElse("Anonymous")  // "Anonymous"

// Transform if present, skip if absent
upper := name.Map(func(s string) (string, bool) {
    return strings.ToUpper(s), true
})
```

**Key methods:** `Some`, `None`, `Get`, `MustGet`, `OrElse`, `OrEmpty`, `Map`, `FlatMap`, `Match`, `ForEach`, `ToPointer`, `IsPresent`, `IsAbsent`.

Option implements `json.Marshaler/Unmarshaler`, `sql.Scanner`, `driver.Valuer` — use it directly in JSON structs and database models.

For full API reference, see [Option Reference](./references/option.md).

## Result[T] — Error Handling as Values

Represents success (`Ok`) or failure (`Err`). Equivalent to `Either[error, T]` but specialized for Go's error pattern.

```go
// Wrap Go's (value, error) pattern
result := mo.TupleToResult(os.ReadFile("config.yaml"))

// Same-type transform — errors short-circuit automatically
upper := mo.Ok("hello").Map(func(s string) (string, error) {
    return strings.ToUpper(s), nil
})
// Ok("HELLO")

// Extract with fallback
val := upper.OrElse("default")
```

**Go limitation:** Direct methods (`.Map`, `.FlatMap`) cannot change the type parameter — `Result[T].Map` returns `Result[T]`, not `Result[U]`. Go methods cannot introduce new type parameters. For type-changing transforms (e.g. `Result[[]byte]` to `Result[Config]`), use sub-package functions or `mo.Do`:

```go
import "github.com/samber/mo/result"

// Type-changing pipeline: []byte -> Config -> ValidConfig
parsed := result.Pipe2(
    mo.TupleToResult(os.ReadFile("config.yaml")),
    result.Map(func(data []byte) Config { return parseConfig(data) }),
    result.FlatMap(func(cfg Config) mo.Result[ValidConfig] { return validate(cfg) }),
)
```

**Key methods:** `Ok`, `Err`, `Errf`, `TupleToResult`, `Try`, `Get`, `MustGet`, `OrElse`, `Map`, `FlatMap`, `MapErr`, `Match`, `ForEach`, `ToEither`, `IsOk`, `IsError`.

For full API reference, see [Result Reference](./references/result.md).

## Either[L, R] — Discriminated Union of Two Types

Represents a value that is one of two possible types. Unlike Result, neither side implies success or failure — both are valid alternatives.

```go
// API that returns either cached data or fresh data
func fetchUser(id string) mo.Either[CachedUser, FreshUser] {
    if cached, ok := cache.Get(id); ok {
        return mo.Left[CachedUser, FreshUser](cached)
    }
    return mo.Right[CachedUser, FreshUser](db.Fetch(id))
}

// Pattern match
result := fetchUser("user-123")
result.Match(
    func(cached CachedUser) mo.Either[CachedUser, FreshUser] { /* use cached */ },
    func(fresh FreshUser) mo.Either[CachedUser, FreshUser] { /* use fresh */ },
)
```

**When to use Either vs Result:** Use `Result[T]` when one path is an error. Use `Either[L, R]` when both paths are valid alternatives (cached vs fresh, left vs right, strategy A vs B).

`Either3[T1, T2, T3]`, `Either4`, and `Either5` extend this to 3-5 type variants.

For full API reference, see [Either Reference](./references/either.md).

## Do Notation — Imperative Style with Monadic Safety

`mo.Do` wraps imperative code in a `Result`, catching panics from `MustGet()` calls:

```go
result := mo.Do(func() int {
    // MustGet panics on None/Err — Do catches it as Result error
    a := mo.Some(21).MustGet()
    b := mo.Ok(2).MustGet()
    return a * b  // 42
})
// result is Ok(42)

result := mo.Do(func() int {
    val := mo.None[int]().MustGet()  // panics
    return val
})
// result is Err("no such element")
```

Do notation bridges imperative Go style with monadic safety — write straight-line code, get automatic error propagation.

## Pipeline Sub-Packages vs Direct Chaining

samber/mo provides two ways to compose operations:

**Direct methods** (`.Map`, `.FlatMap`) — work when the output type equals the input type:

```go
opt := mo.Some(42)
doubled := opt.Map(func(v int) (int, bool) {
    return v * 2, true
})  // Option[int]
```

**Sub-package functions** (`option.Map`, `result.Map`) — required when the output type differs from input:

```go
import "github.com/samber/mo/option"

// int -> string type change: use sub-package Map
strOpt := option.Map(func(v int) string {
    return fmt.Sprintf("value: %d", v)
})(mo.Some(42))  // Option[string]
```

**Pipe functions** (`option.Pipe3`, `result.Pipe3`) — chain multiple type-changing transformations readably:

```go
import "github.com/samber/mo/option"

result := option.Pipe3(
    mo.Some(42),
    option.Map(func(v int) string { return strconv.Itoa(v) }),
    option.Map(func(s string) []byte { return []byte(s) }),
    option.FlatMap(func(b []byte) mo.Option[string] {
        if len(b) > 0 { return mo.Some(string(b)) }
        return mo.None[string]()
    }),
)
```

**Rule of thumb:** Use direct methods for same-type transforms. Use sub-package functions + pipes when types change across steps.

For detailed pipeline API reference, see [Pipelines Reference](./references/pipelines.md).

## Common Patterns

### JSON API responses with Option

```go
type UserResponse struct {
    Name     string            `json:"name"`
    Nickname mo.Option[string] `json:"nickname"`  // omits null gracefully
    Bio      mo.Option[string] `json:"bio"`
}
```

### Database nullable columns

```go
type User struct {
    ID       int
    Email    string
    Phone    mo.Option[string]  // implements sql.Scanner + driver.Valuer
}

err := row.Scan(&u.ID, &u.Email, &u.Phone)
```

### Wrapping existing Go APIs

```go
// Convert map lookup to Option
func MapGet[K comparable, V any](m map[K]V, key K) mo.Option[V] {
    return mo.TupleToOption(m[key])  // m[key] returns (V, bool)
}
```

### Uniform extraction with Fold

`mo.Fold` works uniformly across Option, Result, and Either via the `Foldable` interface:

```go
str := mo.Fold[error, int, string](
    mo.Ok(42),  // works with Option, Result, or Either
    func(v int) string { return fmt.Sprintf("got %d", v) },
    func(err error) string { return "failed" },
)
// "got 42"
```

## Best Practices

1. **Prefer `OrElse` over `MustGet`** — `MustGet` panics on absent/error values; use it only inside `mo.Do` blocks where panics are caught, or when you are certain the value exists
2. **Use `TupleToResult` at API boundaries** — convert Go's `(T, error)` to `Result[T]` at the boundary, then chain with `Map`/`FlatMap` inside your domain logic
3. **Use `Result[T]` for errors, `Either[L, R]` for alternatives** — Result is specialized for success/failure; Either is for two valid types
4. **Option for nullable fields, not zero values** — `Option[string]` distinguishes "absent" from "empty string"; use plain `string` when empty string is a valid value
5. **Chain, don't nest** — `result.Map(...).FlatMap(...).OrElse(default)` reads left-to-right; avoid nested if/else patterns when monadic chaining is cleaner
6. **Use sub-package pipes for multi-step type transformations** — when 3+ steps each change the type, `option.Pipe3(...)` is more readable than nested function calls

For advanced types (Future, IO, Task, State), see [Advanced Types Reference](./references/advanced-types.md).

If you encounter a bug or unexpected behavior in samber/mo, open an issue at <https://github.com/samber/mo/issues>.

## Cross-References

- -> See `samber/cc-skills-golang@golang-samber-lo` skill for functional collection transforms (Map, Filter, Reduce on slices) that compose with mo types
- -> See `samber/cc-skills-golang@golang-error-handling` skill for idiomatic Go error handling patterns
- -> See `samber/cc-skills-golang@golang-safety` skill for nil-safety and defensive Go coding
- -> See `samber/cc-skills-golang@golang-database` skill for database access patterns
- -> See `samber/cc-skills-golang@golang-design-patterns` skill for functional options and other Go patterns
