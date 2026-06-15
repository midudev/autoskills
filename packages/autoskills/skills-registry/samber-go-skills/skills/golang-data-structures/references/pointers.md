# Pointer Types Deep Dive

## Regular Pointers (`*T`)

### Stack vs Heap (Escape Analysis)

Go's compiler decides whether to allocate on the stack or heap. A variable "escapes" to the heap when its lifetime extends beyond the function:

```go
func noEscape() int {
    x := 42
    return x // x stays on stack — copied on return
}

func escapes() *int {
    x := 42
    return &x // x escapes to heap — pointer outlives function
}
```

Use `go build -gcflags="-m"` to see escape analysis decisions. Heap allocations add GC pressure — avoid unnecessary escapes in hot paths.

### `new(T)` vs `&T{}`

Both allocate and return a pointer. `&T{}` is preferred because it allows field initialization:

```go
p := new(Point)       // *Point with zero values
p := &Point{X: 1}     // *Point with initialized fields — preferred
```

## `unsafe.Pointer`

`unsafe.Pointer` bypasses Go's type system for FFI and low-level memory manipulation. Only the 6 patterns from the Go spec are safe; any other pattern is undefined behavior.

### The 6 Valid Patterns (from the Go spec)

These are the ONLY safe ways to use `unsafe.Pointer`. Any other pattern is undefined behavior.

**Pattern 1: Convert `*T` to `*U` via `unsafe.Pointer`**

```go
// Reinterpret a float64 as its raw bits
f := 1.5
bits := *(*uint64)(unsafe.Pointer(&f))
```

**Pattern 2: Convert `unsafe.Pointer` to `uintptr` and back (same expression)**

```go
// Pointer arithmetic — MUST be a single expression
p := unsafe.Pointer(uintptr(unsafe.Pointer(&s.field)) + offset)
```

**Pattern 3: `reflect.Value.Pointer()` or `UnsafeAddr()` to `unsafe.Pointer`**

```go
p := unsafe.Pointer(reflect.ValueOf(&x).Pointer())
```

**Pattern 4: `syscall.Syscall` arguments**

```go
syscall.Syscall(SYS_READ, fd, uintptr(unsafe.Pointer(&buf[0])), uintptr(len(buf)))
```

### Critical Rule: NEVER Store `uintptr` Across Statements

```go
// ✗ DANGEROUS — GC can move the object between these two lines
u := uintptr(unsafe.Pointer(&x))
// ... GC may run here, moving x ...
p := unsafe.Pointer(u) // dangling pointer

// ✓ Safe — single expression
p := unsafe.Pointer(uintptr(unsafe.Pointer(&x)) + offset)
```

### Modern Alternatives (prefer these)

| Function | Since | Purpose |
| --- | --- | --- |
| `unsafe.Add(ptr, len)` | Go 1.17 | Pointer arithmetic without `uintptr` conversion |
| `unsafe.Slice(ptr, len)` | Go 1.17 | Create slice from pointer + length |
| `unsafe.String(ptr, len)` | Go 1.20 | Create string from pointer + length |
| `unsafe.SliceData(s)` | Go 1.17 | Get pointer to slice's backing array |
| `unsafe.StringData(s)` | Go 1.20 | Get pointer to string's backing array |

These are safer than manual `uintptr` arithmetic because they keep values as pointers (visible to GC) throughout.

## `weak.Pointer[T]` (Go 1.24+)

A weak pointer holds a reference to an object without preventing garbage collection. When the GC reclaims the object, `Value()` returns `nil`.

```go
strong := new(MyType)
w := weak.Make(strong)

if p := w.Value(); p != nil {
    // object still alive
} else {
    // object was garbage collected
}
```

### Use Cases

- **Deduplication caches** — intern equivalent values without preventing GC
- **Automatic cache eviction** — cached objects evict when no strong references remain

### `runtime.AddCleanup` vs `runtime.SetFinalizer`

Prefer `runtime.AddCleanup` (Go 1.24+) over `runtime.SetFinalizer`:

- Multiple cleanups can be registered per object
- Cleanup function receives a value, not a pointer to the collected object
- No risk of resurrecting the object
- Works correctly with weak pointers
