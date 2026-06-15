# Types, Constants & Errors

## Interfaces

### Single-Method Interfaces

Name them with the **method name + `-er`** suffix:

```go
type Reader interface {
    Read(p []byte) (n int, err error)
}

type Stringer interface {
    String() string
}

type Closer interface {
    Close() error
}
```

### Multi-Method Interfaces

Use a descriptive **noun** or compose from single-method interfaces:

```go
type ReadWriteCloser interface {
    Reader
    Writer
    Closer
}

type Handler interface {
    ServeHTTP(ResponseWriter, *Request)
}
```

### Canonical Method Names

Honor established Go method names and their signatures. If your type implements `Read`, it MUST match `io.Reader`'s signature. NEVER invent variations like `ReadData` or `ToString` — use `String`.

| Method name | Expected interface |
| ----------- | ------------------ |
| `Read`      | `io.Reader`        |
| `Write`     | `io.Writer`        |
| `Close`     | `io.Closer`        |
| `String`    | `fmt.Stringer`     |
| `Error`     | `error`            |
| `Len`       | `sort.Interface`   |
| `ServeHTTP` | `http.Handler`     |

## Structs

Name structs with **MixedCaps nouns** describing the entity. Fields follow exported/unexported rules.

```go
type Server struct {
    Addr     string        // exported
    Handler  http.Handler  // exported
    timeout  time.Duration // unexported
}
```

NEVER suffix struct names with `Struct`, `Object`, or `Data` — they add no information.

## Constants

Constants MUST use **MixedCaps**, NEVER `ALL_CAPS`. The name should explain the **role**, not the **value**.

```go
// Good — MixedCaps, name explains purpose
const MaxRetries = 3
const defaultTimeout = 30 * time.Second
const DefaultPort = 8080

// Bad — ALL_CAPS is not idiomatic Go
const MAX_RETRIES = 3
const DEFAULT_TIMEOUT = 30

// Bad — name is the value, not the purpose
const Three = 3
const Port8080 = 8080
```

### Enums (iota)

Prefix enum values with the **type name** to avoid collisions and improve readability at the call site.

```go
type Status int

const (
    StatusUnknown Status = iota // zero value = unknown/invalid
    StatusReady
    StatusRunning
    StatusDone
)

type Color int

const (
    ColorRed Color = iota + 1  // skip zero to catch uninitialized values
    ColorGreen
    ColorBlue
)
```

**Always protect the zero value.** A `var s Status` will silently be 0 — if that maps to a real state like `StatusReady`, code can behave as if a status was deliberately chosen when it wasn't. Either place an explicit `Unknown` sentinel at iota 0, or start at `iota + 1`. This is not optional — uninitialized enums are a common source of silent bugs.

## Errors

### Sentinel Errors

Sentinel error variables use the `Err` prefix. Error strings SHOULD include the package name as prefix to identify the origin when errors are wrapped:

```go
// Good — package prefix identifies origin
var ErrNotFound = errors.New("mypackage: not found")
var ErrPermissionDenied = errors.New("mypackage: permission denied")
var ErrTimeout = errors.New("mypackage: operation timed out")

// Bad — bare strings lose origin when wrapped
var ErrNotFound = errors.New("not found")
```

### Error Types

Custom error types use the `Error` suffix:

```go
type PathError struct {
    Op   string
    Path string
    Err  error
}

type SyntaxError struct {
    Offset int64
    msg    string
}
```

### Error Strings

Error strings MUST be **fully lowercase — including acronyms** — and MUST NOT **end with punctuation**, because they are often printed following other context (`fmt.Errorf("parsing config: %w", err)`). Acronyms that would normally be capitalized in identifiers (`ID`, `URL`, `HTTP`) become lowercase in error strings.

```go
// Good — lowercase including acronyms, no punctuation
errors.New("image: unknown format")
errors.New("mypackage: invalid message id")     // "id" not "ID"
errors.New("mypackage: invalid url")             // "url" not "URL"
fmt.Errorf("decoding config: %w", err)

// Bad — capitalized, acronyms, punctuation
errors.New("Image: Unknown format.")
errors.New("mypackage: invalid message ID")      // ID should be lowercase in error strings
fmt.Errorf("Failed to decode config: %w.", err)
```
