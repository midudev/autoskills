# Functions, Methods & Options

## Functions and Methods

Functions returning a value are named like **nouns** (what they return). Functions performing actions are named like **verbs** (what they do).

```go
// Noun-like: returns something
func UserName() string { ... }
func DefaultConfig() Config { ... }

// Verb-like: performs an action
func WriteFile(name string, data []byte) error { ... }
func SendNotification(user *User) error { ... }
```

NEVER repeat the package name in function names:

```go
// Good: users call http.Get(), not http.HTTPGet()
package http
func Get(url string) (*Response, error)

// Bad: stutters at the call site
package http
func HTTPGet(url string) (*Response, error)
```

Functions that accept a format string and variadic args (like `fmt.Sprintf`) MUST end with **`f`**:

```go
// Good
func Errorf(format string, args ...any) error
func Wrapf(err error, format string, args ...any) error
func Logf(format string, args ...any)

// Bad
func Error(format string, args ...any) error    // looks like it takes a plain string
func WrapError(err error, format string, args ...any) error
```

### Getters and Setters

Getters MUST NOT use the `Get` prefix. The getter is simply the field name, capitalized.

```go
// Good
func (u *User) Name() string        { return u.name }
func (u *User) SetName(name string)  { u.name = name }

// Bad
func (u *User) GetName() string      { return u.name }
```

Only use `Get` when the underlying concept inherently uses "get" (e.g., HTTP GET). For expensive or blocking operations, use `Fetch` or `Compute` to signal that the call is not trivial.

**Exception — boolean predicates keep the `Is`/`Has`/`Can` prefix.** The no-Get rule applies to value getters, not boolean predicates. A method returning `bool` SHOULD use `Is`/`Has`/`Can` to read naturally as a question — this follows the standard library pattern (`reflect.Type.IsVariadic()`, `net.IP.IsLoopback()`, `big.Int.IsInt64()`).

```go
// Good — boolean predicate keeps Is prefix
func (s *Server) IsHealthy() bool   { return s.healthy }

// Good — value getter omits Get prefix
func (s *Server) Port() int         { return s.port }

// Good — richer return type, bare name is fine (different semantics)
func (s *Server) Healthy() (HealthStatus, error)

// Bad — bare adjective for bool is ambiguous
func (s *Server) Healthy() bool     { return s.healthy }

// Bad — Get prefix on value getter is redundant
func (s *Server) GetPort() int      { return s.port }
```

### Constructors

Name constructors `New` when the package exports a single primary type, or `NewTypeName` when there are multiple types.

```go
// Single primary type — New is unambiguous
package ring
func New(size int) *Ring

// Multiple types — qualify with the type name
package http
func NewRequest(method, url string, body io.Reader) (*Request, error)
func NewServeMux() *ServeMux
```

### Named Return Values

Named return values SHOULD only be used when it improves readability — typically when multiple return values have the same type, or when the names serve as documentation.

```go
// Good — names clarify which int64 is which
func Copy(dst Writer, src Reader) (written int64, err error)
func ScanBytes(data []byte, atEOF bool) (advance int, token []byte, err error)

// Good — single error return, no name needed
func Write(p []byte) (int, error)

// Bad — names add no clarity
func Read(p []byte) (bytes int, e error)  // "bytes" shadows the package, "e" is non-standard
```

NEVER use named returns just to enable bare `return` — bare returns hurt readability in anything but the shortest functions.

## Functional Options Pattern

When a constructor has 3+ optional parameters that may grow, use the **functional options pattern** for clean, extensible APIs.

- **Struct**: `ServerOptions`, `ClientOptions` (not `Opts`, `Params`, `Settings`, `Config`)
- **Function type**: `ServerOption` (singular, not plural)
- **With\* functions**: `WithPort()`, `WithTimeout()`, `WithLogger()`
- **Factory**: `DefaultServerOptions()`
