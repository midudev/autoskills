# Option[T] API Reference

## Constructors

| Function | Description |
| --- | --- |
| `mo.Some[T](value T)` | Creates Option with a present value |
| `mo.None[T]()` | Creates Option with an absent value |
| `mo.TupleToOption[T](value T, ok bool)` | Converts (value, bool) tuple — Some if ok is true, None otherwise |
| `mo.EmptyableToOption[T](value T)` | None if value equals its zero value, Some otherwise |
| `mo.PointerToOption[T](value *T)` | None if pointer is nil, Some(\*value) otherwise |

## Query Methods

| Method | Returns | Description |
| --- | --- | --- |
| `IsPresent()` / `IsSome()` | `bool` | True if value exists |
| `IsAbsent()` / `IsNone()` | `bool` | True if value is missing |
| `Size()` | `int` | 1 if present, 0 if absent |
| `Get()` | `(T, bool)` | Value and presence indicator |
| `MustGet()` | `T` | Value or panics — use only inside `mo.Do` |

## Value Extraction

| Method               | Returns | Description                            |
| -------------------- | ------- | -------------------------------------- |
| `OrElse(fallback T)` | `T`     | Value if present, fallback otherwise   |
| `OrEmpty()`          | `T`     | Value if present, zero value otherwise |
| `ToPointer()`        | `*T`    | Pointer to value, nil if absent        |

## Transformations

### Map — transform the value if present

```go
opt := mo.Some(42)
doubled := opt.Map(func(v int) (int, bool) {
    return v * 2, true  // (new value, keep as Some)
})
// Some(84)

// Return false to convert to None
filtered := opt.Map(func(v int) (int, bool) {
    return v, v > 100  // None because 42 <= 100
})
```

**Go limitation:** Option.Map takes `func(T) (T, bool)` — the input and output types must be the same `T`. The bool controls whether the result is Some or None. To change the type (e.g. `Option[int]` to `Option[string]`), use sub-package `option.Map` — see [Pipelines Reference](./pipelines.md).

### MapValue — transform without filter

```go
opt := mo.Some(42)
doubled := opt.MapValue(func(v int) int { return v * 2 })
// Some(84) — always stays Some if input was Some, no bool needed
```

Unlike Map, MapValue's callback returns just `T` (not `(T, bool)`), so it cannot convert to None.

### MapNone — provide value when absent

```go
opt := mo.None[int]()
filled := opt.MapNone(func() (int, bool) {
    return 42, true  // provide default as Some
})
// Some(42)
```

### FlatMap — chain Options (same type)

```go
func findUser(id string) mo.Option[User] { ... }
func refreshUser(u User) mo.Option[User] { ... }

refreshed := findUser("123").FlatMap(func(u User) mo.Option[User] {
    return refreshUser(u)  // same type: Option[User] -> Option[User]
})
```

**Go limitation:** Direct `.FlatMap` requires `func(T) Option[T]` — same input and output type. For type-changing chains (e.g. `Option[User]` to `Option[string]`), use `option.FlatMap` from the sub-package or `mo.Do` notation.

### Match — handle both cases

```go
opt.Match(
    func(v int) (int, bool) {
        fmt.Println("Got:", v)
        return v, true       // keep as Some
    },
    func() (int, bool) {
        fmt.Println("Empty!")
        return 0, false       // stay as None
    },
)
```

### ForEach — side effect on present value

```go
opt.ForEach(func(v int) {
    fmt.Println("Value:", v)  // only executes if present
})
```

## Equality

```go
mo.Some(42).Equal(mo.Some(42))  // true
mo.Some(42).Equal(mo.None[int]())  // false
mo.None[int]().Equal(mo.None[int]())  // true
```

## Serialization

Option implements multiple encoding interfaces:

| Interface | Behavior |
| --- | --- |
| `json.Marshaler` / `json.Unmarshaler` | Some(42) -> `42`, None -> `null` |
| `encoding.TextMarshaler` / `TextUnmarshaler` | Text encoding/decoding |
| `encoding.BinaryMarshaler` / `BinaryUnmarshaler` | Binary encoding/decoding |
| `encoding/gob.GobEncoder` / `GobDecoder` | Gob encoding/decoding |

## Database Support

Option implements `sql.Scanner` and `driver.Valuer`:

```go
type User struct {
    ID    int
    Phone mo.Option[string]  // nullable column
}

// Scanning
err := row.Scan(&u.ID, &u.Phone)

// Inserting
_, err := db.Exec("INSERT INTO users (id, phone) VALUES ($1, $2)", u.ID, u.Phone)
```

## Go 1.24+ omitzero Support

```go
type Response struct {
    Data    string            `json:"data"`
    Extra   mo.Option[string] `json:"extra,omitzero"`  // omitted when None
}
```

`IsZero()` returns true when the Option is None, enabling the `omitzero` JSON tag.
