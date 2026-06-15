# Common Go Bugs

→ See `samber/cc-skills-golang@golang-safety` skill for in-depth nil, slice, and map safety patterns.

## Nil Pointer Dereference

Pointers from external sources MUST be checked before dereferencing.

The most common Go panic. The stack trace tells you the exact line.

```go
// 1. Uninitialized struct field
type Server struct {
    logger *log.Logger  // nil if not set in constructor
}

// 2. Unchecked error return — if err != nil, val may be nil/zero
val, err := doSomething()
val.Method()  // panic if doSomething returned nil val with an error

// 3. Map lookup returns zero value
m := map[string]*Config{}
cfg := m["missing"]  // cfg is nil
cfg.Timeout  // panic

// 4. Type assertion without comma-ok
var i interface{} = "hello"
n := i.(int)        // panic
n, ok := i.(int)    // ok == false, no panic
```

## Interface Nil Gotcha

NEVER compare an interface to nil when it may contain a typed nil pointer.

A typed nil pointer inside an interface is **not** a nil interface:

```go
type MyError struct{ msg string }
func (e *MyError) Error() string { return e.msg }

func doWork() error {
    var err *MyError  // typed nil pointer
    return err        // returns non-nil interface containing nil pointer!
}

func main() {
    if err := doWork(); err != nil {
        // This EXECUTES — the interface is non-nil
        fmt.Println(err)  // panic: nil pointer in Error()
    }
}

// FIX: return nil explicitly, not a typed nil variable
func doWork() error {
    return nil
}
```

## Variable Shadowing with `:=`

The `:=` short declaration creates a new variable in the inner scope instead of assigning to the outer one. Especially dangerous when shadowing `err`, because error handling silently breaks.

```go
// BAD
func doWork() error {
    var err error
    if condition {
        result, err := someFunc() // BUG: new err variable, doesn't set outer one
        if err != nil {
            return err
        }
        process(result)
    }
    return err // always nil — inner err was a different variable
}

// GOOD
func doWork() error {
    var err error
    if condition {
        var result ResultType
        result, err = someFunc() // assigns to outer err
        if err != nil {
            return err
        }
        process(result)
    }
    return err
}
```

**Detect:** run the `golang.org/x/tools/go/analysis/passes/shadow` analyzer through your lint setup. The old shadow flag is not part of standard `go vet`.

## Slice and Map Gotchas

```go
// 1. Nil map write panics
var m map[string]int
m["key"] = 1  // panic: assignment to entry in nil map
// FIX: m := make(map[string]int)
// Note: nil map reads are fine — they return zero value

// 2. Append may share underlying array
a := []int{1, 2, 3}
b := a[:2]
b = append(b, 99)  // overwrites a[2]!
// FIX: full slice expression — b := a[:2:2] to limit capacity

// 3. Range variable capture in goroutine (Go < 1.22)
for _, v := range items {
    go func() {
        process(v)  // v is shared, will likely be last element
    }()
}
// FIX: pass as argument
for _, v := range items {
    go func(v Item) { process(v) }(v)
}
// In Go 1.22+, loop variables are per-iteration (no fix needed)
```

## Defer Gotchas

```go
// 1. Arguments evaluated immediately
x := 1
defer fmt.Println(x)  // prints 1, not 2
x = 2

// 2. Defer in loop — doesn't run until function returns
for _, f := range files {
    file, _ := os.Open(f)
    defer file.Close()  // all Close() calls pile up until return
}
// FIX: wrap in closure
for _, f := range files {
    func() {
        file, _ := os.Open(f)
        defer file.Close()
        // use file
    }()
}

// 3. Named return + defer interaction
func readFile() (err error) {
    f, err := os.Open("file.txt")
    if err != nil { return }
    defer func() {
        if closeErr := f.Close(); err == nil {
            err = closeErr  // modifies named return
        }
    }()
    // ...
    return nil
}
```

## Error Handling Pitfalls

**Silent error swallowing** is the single most common source of "mysterious" bugs:

```go
// BAD — silent failure
result, _ := doSomething()
json.Unmarshal(data, &config)
http.ListenAndServe(":8080", nil)

// GOOD — handle or propagate
result, err := doSomething()
if err != nil {
    return fmt.Errorf("doSomething: %w", err)
}
```

**Find ignored errors:**

```bash
go vet ./...

# More thorough
go get -tool github.com/kisielk/errcheck@latest
go tool errcheck ./...
```

**Error wrapping — use `%w`, not `%v`:**

```go
return fmt.Errorf("reading config from %s: %v", path, err)  // BAD — loses error chain
return fmt.Errorf("reading config from %s: %w", path, err)  // GOOD — preserves Is/As

// Check for specific errors — use errors.Is, not ==
if err == sql.ErrNoRows { ... }            // BAD — breaks if wrapped
if errors.Is(err, sql.ErrNoRows) { ... }   // GOOD — traverses chain

// Extract typed errors
var pathErr *os.PathError
if errors.As(err, &pathErr) { ... }
```

## Context Misuse

```go
// 1. Forgetting to cancel — leaks goroutines
ctx, cancel := context.WithTimeout(ctx, 5*time.Second)
// Missing: defer cancel()

// 2. Using background context when you should propagate
go doWork(context.Background())  // BAD — can't cancel from parent
go doWork(ctx)                   // GOOD — respects parent cancellation

// 3. Not checking context error
err := doWork(ctx)
if err != nil {
    // Distinguish timeout from other errors
    if ctx.Err() == context.DeadlineExceeded {
        log.Printf("operation timed out")
    } else if ctx.Err() == context.Canceled {
        log.Printf("operation cancelled")
    } else {
        log.Printf("operation failed: %v", err)
    }
}

// 4. Background work outliving request context
func handler(w http.ResponseWriter, r *http.Request) {
    // BAD — background work uses request context that cancels when client disconnects
    go processAsync(r.Context(), data)

    // GOOD — derive a new context for background work (Go 1.21+)
    bgCtx := context.WithoutCancel(r.Context())
    go processAsync(bgCtx, data)
}
```

## Concurrent Map Read/Write (Fatal)

Maps MUST NOT be accessed concurrently without synchronization.

Unlike most Go runtime errors, a concurrent map read/write is a **fatal error** — it **cannot be caught with `recover()`** and crashes the entire process. Hard to catch in tests because it depends on timing.

```go
// BAD — fatal: concurrent map read and map write
m := make(map[string]int)
go func() { m["key"] = 1 }()  // concurrent write
go func() { _ = m["key"] }()  // concurrent read — fatal!

// GOOD — protect with mutex
var mu sync.RWMutex
m := make(map[string]int)
go func() { mu.Lock(); m["key"] = 1; mu.Unlock() }()
go func() { mu.RLock(); _ = m["key"]; mu.RUnlock() }()

// Or use sync.Map for read-heavy workloads with stable key sets
```

**Detect:** `go test -race ./...` — always run in CI.

## Copying sync Types

Sync types MUST NEVER be copied — use pointer receivers and pass by pointer.

All `sync` types (`Mutex`, `RWMutex`, `WaitGroup`, `Once`, `Cond`, `Map`, `Pool`) must not be copied. Copying them via value receivers, function arguments, or struct assignment silently breaks synchronization.

```go
// BAD — value receiver copies the Mutex
type Counter struct {
    mu    sync.Mutex
    count int
}

func (c Counter) Increment() { // BUG: copies mutex on every call
    c.mu.Lock()
    c.count++
    c.mu.Unlock()
}

// GOOD — pointer receiver
func (c *Counter) Increment() {
    c.mu.Lock()
    defer c.mu.Unlock()
    c.count++
}
```

**Detect:** `go vet` detects mutex copies. Apply to all sync types.

## WaitGroup.Add Inside Goroutine

If `wg.Add(1)` is called inside the goroutine instead of before it, `wg.Wait()` may return before all goroutines start — a race condition that passes tests most of the time but fails intermittently.

```go
// BAD
var wg sync.WaitGroup
for i := 0; i < n; i++ {
    go func() {
        wg.Add(1) // BUG: may run after wg.Wait() returns
        defer wg.Done()
        doWork()
    }()
}
wg.Wait()

// GOOD
var wg sync.WaitGroup
for i := 0; i < n; i++ {
    wg.Add(1) // called BEFORE launching the goroutine
    go func() {
        defer wg.Done()
        doWork()
    }()
}
wg.Wait()
```

## Missing Return After HTTP Error Response

After writing an error with `http.Error()`, execution continues. This can cause double writes, corrupted responses, or executing logic that should have been skipped.

```go
// BAD
func handler(w http.ResponseWriter, r *http.Request) {
    if !authorized(r) {
        http.Error(w, "Forbidden", http.StatusForbidden)
        // BUG: missing return — handler keeps executing
    }
    doSensitiveAction(r)
}

// GOOD
func handler(w http.ResponseWriter, r *http.Request) {
    if !authorized(r) {
        http.Error(w, "Forbidden", http.StatusForbidden)
        return
    }
    doSensitiveAction(r)
}
```

## JSON Pitfalls

### Numbers into `interface{}` become `float64`

When unmarshaling into `map[string]interface{}` or `interface{}`, all JSON numbers become `float64`. Type-asserting to `int` panics. Large integers (> 2^53) silently lose precision.

```go
// BAD
var result map[string]interface{}
json.Unmarshal([]byte(`{"id": 1234567890123456789}`), &result)
id := result["id"].(int) // PANIC: it's float64, not int

// GOOD — use typed struct (preferred)
type Response struct {
    ID int64 `json:"id"`
}

// GOOD — use json.Number when you must use interface{}
dec := json.NewDecoder(bytes.NewReader(data))
dec.UseNumber()
var result map[string]interface{}
dec.Decode(&result)
id, _ := result["id"].(json.Number).Int64()
```

### Unexported fields silently ignored

Fields starting with lowercase are invisible to `encoding/json`. Marshal produces empty output, unmarshal skips them — no error in either case.

```go
// BAD
type User struct {
    name  string `json:"name"`  // unexported — silently ignored!
    email string `json:"email"` // unexported — silently ignored!
}
u := User{name: "Alice", email: "alice@example.com"}
data, _ := json.Marshal(u) // data is "{}" — no error

// GOOD
type User struct {
    Name  string `json:"name"`
    Email string `json:"email"`
}
```

**Detect:** `go vet` warns when unexported fields have JSON struct tags.

## `strings.Trim` vs `strings.TrimPrefix`

`strings.Trim` treats its second argument as a **set of characters** to strip from both ends, not as a substring. This over-trims unexpectedly.

```go
// BAD
s := strings.Trim("application/json", "application/")
// Result: "js" — stripped all chars in set {a,p,l,i,c,t,o,n,/} from both ends!

// GOOD
s := strings.TrimPrefix("application/json", "application/")
// Result: "json"
```

Use `strings.TrimPrefix`/`strings.TrimSuffix` to remove substrings. Only use `strings.Trim` when you intend to strip a set of characters.

## String Length and Indexing

`len()` on strings returns bytes, not characters. Indexing returns a byte. For multi-byte UTF-8 characters, this gives wrong counts and corrupts data when slicing.

```go
s := "Hello, 世界"
fmt.Println(len(s))    // 13 (bytes), not 9 (characters)
fmt.Println(s[:8])     // "Hello, \xe4" — corrupted! cuts a multi-byte rune

// FIX: use utf8.RuneCountInString for character count
fmt.Println(utf8.RuneCountInString(s)) // 9

// FIX: convert to []rune for character-based slicing
runes := []rune(s)
fmt.Println(string(runes[:8])) // "Hello, 世"

// FIX: use for-range to iterate over characters (runes), not bytes
for _, r := range s { ... } // iterates runes
```

## `break` in `select`/`switch` Inside `for` Loop

A bare `break` inside a `select` or `switch` that is inside a `for` loop only exits the `select`/`switch`, not the loop.

```go
// BAD
for {
    select {
    case msg := <-ch:
        if msg == "quit" {
            break // BUG: only breaks the select, loop continues forever
        }
        process(msg)
    }
}

// GOOD — use labeled break
loop:
for {
    select {
    case msg := <-ch:
        if msg == "quit" {
            break loop // breaks the for loop
        }
        process(msg)
    }
}
```

## Enum Zero Value with `iota`

When `iota` starts at 0, the zero value of the type (from uninitialized variables, zero-value struct fields, or missing JSON fields) is indistinguishable from the first constant.

```go
// BAD
type Status int
const (
    Active   Status = iota // 0 — same as zero value!
    Inactive               // 1
)
type User struct {
    Status Status // zero value is Active — but was it intentional?
}

// GOOD — reserve 0 for "unknown"
type Status int
const (
    StatusUnknown  Status = iota // 0 — explicit unset sentinel
    StatusActive                 // 1
    StatusInactive               // 2
)
```

## `recover()` Only Works in the Same Goroutine

`recover()` can only catch panics in the goroutine where it's deferred. A panic in a child goroutine will crash the entire program — no parent goroutine can catch it.

```go
// BAD — recover() in main cannot catch panic in child goroutine
func main() {
    defer func() {
        if r := recover(); r != nil {
            fmt.Println("recovered:", r) // NEVER REACHED
        }
    }()
    go func() {
        panic("crash!") // crashes the whole program
    }()
    time.Sleep(time.Second)
}

// GOOD — each goroutine must recover its own panics
func main() {
    go func() {
        defer func() {
            if r := recover(); r != nil {
                log.Printf("goroutine recovered: %v", r)
            }
        }()
        panic("crash!") // recovered within this goroutine
    }()
    time.Sleep(time.Second)
}
```

## `os.Exit` Skips Deferred Functions

`os.Exit` terminates the process immediately. No deferred functions run — cleanup, flush, and close operations are skipped. `log.Fatal` calls `os.Exit(1)` internally and has the same problem.

```go
// BAD — deferred cleanup never runs
func main() {
    f, _ := os.Create("data.tmp")
    defer f.Close()       // NEVER RUNS
    defer os.Remove(f.Name()) // NEVER RUNS

    if err := process(); err != nil {
        log.Fatal(err) // calls os.Exit(1) — skips all defers!
    }
}

// GOOD — return from main instead, or restructure so defers run
func main() {
    if err := run(); err != nil {
        fmt.Fprintf(os.Stderr, "error: %v\n", err)
        os.Exit(1) // defers in run() already ran when it returned
    }
}

func run() error {
    f, _ := os.Create("data.tmp")
    defer f.Close()
    return process()
}
```

## `time.Time` Comparison: `==` vs `.Equal()`

`time.Time` includes a monotonic clock reading. Two `time.Time` values representing the same instant may not be `==` if one has a monotonic component and the other doesn't (e.g., one from `time.Now()`, the other deserialized from JSON/database).

```go
// BAD — may fail even for the same instant
t1 := time.Now()
data, _ := t1.MarshalJSON()
var t2 time.Time
t2.UnmarshalJSON(data)
fmt.Println(t1 == t2) // false! t1 has monotonic, t2 doesn't

// GOOD — .Equal() ignores monotonic clock
fmt.Println(t1.Equal(t2)) // true

// Also: strip monotonic explicitly when storing/comparing
t1 = t1.Round(0) // strips monotonic reading
```

## `sql.Rows` Must Be Closed

`sql.Rows` MUST call `rows.Close()` — always defer it immediately after the query.

Forgetting to close `sql.Rows` leaks database connections. The connection is held until `Rows` is garbage collected, but under load the connection pool exhausts first.

```go
// BAD — connection leak if rows aren't closed
rows, err := db.Query("SELECT id FROM users")
if err != nil { return err }
for rows.Next() {
    // ...
}
// rows never closed — connection leak!

// GOOD — always defer Close
rows, err := db.Query("SELECT id FROM users")
if err != nil { return err }
defer rows.Close()
for rows.Next() {
    // ...
}
if err := rows.Err(); err != nil { // don't forget to check rows.Err()
    return err
}
```

Also: use `db.QueryRow()` for single-row queries and `db.Exec()` for non-SELECT statements (INSERT, UPDATE, DELETE). Using `db.Query()` for non-SELECT leaks connections because the returned `Rows` is never iterated/closed.

## Writing to a Closed Channel Panics

Sending to a closed channel panics. Reading from a closed channel returns the zero value immediately (with `ok == false`).

```go
// BAD — panic: send on closed channel
ch := make(chan int, 1)
close(ch)
ch <- 1 // panic!

// GOOD — only the sender should close, never the receiver
// Use a done channel or context to signal completion
func producer(ch chan<- int, done <-chan struct{}) {
    defer close(ch)
    for i := 0; ; i++ {
        select {
        case ch <- i:
        case <-done:
            return
        }
    }
}
```

**Rule of thumb:** Only the sender closes the channel. If multiple senders, use a `sync.Once` or coordinate with a `sync.WaitGroup`.

## Closed Channel in `select` Causes Busy Loop

A closed channel is always ready to receive (returns zero value). In a `select`, this causes the case to fire continuously — a CPU-burning busy loop.

```go
// BAD — after ch is closed, this loops at 100% CPU
for {
    select {
    case v := <-ch: // fires continuously after ch closes
        process(v)   // processes zero values forever
    case <-done:
        return
    }
}

// GOOD — nil the channel after it closes
for {
    select {
    case v, ok := <-ch:
        if !ok {
            ch = nil // nil channel blocks forever in select — disables this case
            continue
        }
        process(v)
    case <-done:
        return
    }
}
```

## `select` with `default` Can Spin CPU

A `select` with a `default` case never blocks. Inside a `for` loop, this creates a busy-wait spin loop that burns CPU.

```go
// BAD — spins at 100% CPU waiting for a message
for {
    select {
    case msg := <-ch:
        process(msg)
    default:
        // runs immediately when ch has nothing — tight loop!
    }
}

// GOOD — remove default to block until a message arrives
for {
    select {
    case msg := <-ch:
        process(msg)
    case <-ctx.Done():
        return
    }
}

// GOOD — if you need non-blocking check, add a small sleep or ticker
for {
    select {
    case msg := <-ch:
        process(msg)
    default:
        time.Sleep(10 * time.Millisecond) // yield CPU
    }
}
```

## Integer Conversion Silently Truncates

Go integer conversions don't check for overflow — they silently truncate. This is especially dangerous when converting from user input or external data.

```go
// BAD — silent truncation
var big int64 = 256
small := int8(big)
fmt.Println(small) // 0 — silently overflowed!

var n int64 = math.MaxInt64
n32 := int32(n)
fmt.Println(n32) // -1 — silently wrapped!

// GOOD — check bounds before converting
func safeIntToInt32(n int64) (int32, error) {
    if n < math.MinInt32 || n > math.MaxInt32 {
        return 0, fmt.Errorf("value %d overflows int32", n)
    }
    return int32(n), nil
}
```

## `filepath.Join` Does Not Prevent Path Traversal

`filepath.Join` cleans the path (resolves `..`) but doesn't prevent escaping the base directory. User-supplied paths can traverse outside the intended root.

```go
// BAD — user can escape the base directory
base := "/srv/files"
userInput := "../../etc/passwd"
path := filepath.Join(base, userInput)
// path = "/etc/passwd" — escaped!

// GOOD (Go 1.24+) — confine access to the base directory
root, err := os.OpenRoot("/srv/files")
if err != nil {
    return err
}
defer root.Close()
file, err := root.Open(userInput)
if err != nil {
    return err
}
defer file.Close()
```

For Go <1.24, use a lexical fallback only when `os.Root` is unavailable:

```go
func safePath(base, userInput string) (string, error) {
    if userInput == "" || filepath.IsAbs(userInput) || !filepath.IsLocal(userInput) {
        return "", fmt.Errorf("invalid relative path: %q", userInput)
    }

    path := filepath.Join(base, userInput)
    rel, err := filepath.Rel(base, path)
    if err != nil {
        return "", fmt.Errorf("checking path: %w", err)
    }
    if rel == ".." || strings.HasPrefix(rel, ".."+string(os.PathSeparator)) {
        return "", fmt.Errorf("path traversal attempt: %s", userInput)
    }

    return path, nil
}
```

## Pointer Receiver Interface Satisfaction

A value of type `T` cannot satisfy an interface that requires methods with `*T` receivers. But `*T` satisfies interfaces requiring either `T` or `*T` methods.

```go
type Sizer interface {
    Size() int
}

type File struct{ size int }
func (f *File) Size() int { return f.size } // pointer receiver

var s Sizer
s = File{}   // COMPILE ERROR: File does not implement Sizer (*File does)
s = &File{}  // OK — *File has the Size method

// This is because the compiler can't always take the address of a value
// (e.g., map values, return values). Pointer receiver = pointer required.
```

## `regexp.MustCompile` in Hot Path

Long-lived regexp MUST be compiled once at package level — not inside functions called repeatedly. Short-lived regexp used once (e.g., in a CLI or test) are acceptable inline.

`regexp.MustCompile` compiles a regex every call. In a hot path (loop, HTTP handler), this is expensive and wasteful.

```go
// BAD — recompiles regex on every call
func isEmail(s string) bool {
    re := regexp.MustCompile(`^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`)
    return re.MatchString(s)
}

// GOOD — compile once at package level
var emailRe = regexp.MustCompile(`^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`)

func isEmail(s string) bool {
    return emailRe.MatchString(s)
}
```

## `init()` Ordering Is Fragile

`init()` functions run in source file order within a package, and in dependency order across packages. But relying on this order creates brittle, hard-to-debug initialization sequences. Multiple `init()` in the same file run top-to-bottom, but across files it's alphabetical by filename — adding a file can change the order.

```go
// BAD — init() depends on another init() having run first
var db *sql.DB

func init() {
    // Assumes config init() already ran — fragile!
    db, _ = sql.Open("postgres", config.DatabaseURL)
}

// GOOD — use explicit initialization
func main() {
    cfg := loadConfig()
    db := setupDatabase(cfg)
    startServer(db)
}
```

Prefer explicit initialization in `main()` over `init()`. Use `init()` only for truly self-contained setup (registering drivers, codecs).

## Map Iteration Order Is Random

Go deliberately randomizes map iteration order. Code that assumes a specific order will produce inconsistent results.

```go
// BAD — output order is random every run
m := map[string]int{"a": 1, "b": 2, "c": 3}
for k, v := range m {
    fmt.Printf("%s=%d ", k, v) // different order each time!
}

// GOOD — sort keys when order matters
keys := make([]string, 0, len(m))
for k := range m {
    keys = append(keys, k)
}
sort.Strings(keys)
for _, k := range keys {
    fmt.Printf("%s=%d ", k, m[k])
}
```

This is especially dangerous in tests (non-deterministic output comparison), serialization (non-deterministic JSON/output), and logging (confusing diffs).

## `fallthrough` in `switch` Executes Unconditionally

Unlike C, Go's `switch` cases don't fall through by default. But when you explicitly use `fallthrough`, it executes the **next case body unconditionally** — it does not check the next case's condition.

```go
// Surprising: fallthrough doesn't check the next condition
switch x := 5; {
case x > 10:
    fmt.Println(">10")
    fallthrough
case x > 0:
    fmt.Println(">0")
    fallthrough
case x < 0:
    fmt.Println("<0") // EXECUTES even though 5 is not < 0!
}
// Output: >0, <0

// fallthrough is rarely needed. Prefer listing multiple values:
switch status {
case "active", "enabled":
    enable()
}
```
