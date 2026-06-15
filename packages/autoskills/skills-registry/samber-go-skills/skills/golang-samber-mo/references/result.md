# Result[T] API Reference

## Constructors

| Function | Description |
| --- | --- |
| `mo.Ok[T](value T)` | Creates a successful Result |
| `mo.Err[T](err error)` | Creates a failed Result |
| `mo.Errf[T](format string, a ...any)` | Creates failed Result with formatted error message |
| `mo.TupleToResult[T](value T, err error)` | Converts Go's (T, error) tuple — Ok if err is nil, Err otherwise |
| `mo.Try[T](f func() (T, error))` | Executes function, wraps result — Ok on success, Err on error |

### Do Notation

```go
result := mo.Do(func() int {
    a := mo.Ok(10).MustGet()     // panics if Err -> caught by Do
    b := mo.Ok(32).MustGet()
    return a + b
})
// Ok(42)
```

`mo.Do` executes a closure and catches any panic from `MustGet()` calls, converting them to `Err`. This enables imperative-style code with monadic error propagation.

## Query Methods

| Method | Returns | Description |
| --- | --- | --- |
| `IsOk()` | `bool` | True if Result is successful |
| `IsError()` | `bool` | True if Result is a failure |
| `Error()` | `error` | Returns the error, or nil if Ok |
| `Get()` | `(T, error)` | Returns value and error (Go-style) |
| `MustGet()` | `T` | Returns value or panics — use only inside `mo.Do` |

## Value Extraction

| Method               | Returns | Description                    |
| -------------------- | ------- | ------------------------------ |
| `OrElse(fallback T)` | `T`     | Value if Ok, fallback if Err   |
| `OrEmpty()`          | `T`     | Value if Ok, zero value if Err |

## Transformations

### Map — transform successful value

```go
result := mo.Ok(42).
    Map(func(v int) (int, error) {
        return v * 2, nil
    })
// Ok(84)

// Errors short-circuit
result := mo.Err[int](errors.New("fail")).
    Map(func(v int) (int, error) {
        return v * 2, nil  // never called
    })
// Err("fail")
```

**Go limitation:** Result.Map takes `func(T) (T, error)` — the input and output types must be the same `T`. Returning a non-nil error converts Ok to Err. To change the type (e.g. `Result[[]byte]` to `Result[Config]`), use sub-package `result.Map` or `mo.Do` notation — see [Pipelines Reference](./pipelines.md).

### MapValue — transform without error possibility

```go
result := mo.Ok(42).MapValue(func(v int) int {
    return v * 2
})
// Ok(84) — no error possible in the mapper
```

### MapErr — transform error state

```go
result := mo.Err[int](errors.New("fail")).
    MapErr(func(err error) (int, error) {
        return 0, fmt.Errorf("wrapped: %w", err)
    })
// Err("wrapped: fail")
```

### FlatMap — chain Results

```go
func parseAge(s string) mo.Result[int] {
    v, err := strconv.Atoi(s)
    return mo.TupleToResult(v, err)
}

func validateAge(age int) mo.Result[int] {
    if age < 0 || age > 150 {
        return mo.Errf[int]("invalid age: %d", age)
    }
    return mo.Ok(age)
}

result := parseAge("25").FlatMap(func(age int) mo.Result[int] {
    return validateAge(age)
})
// Ok(25)
```

### Match — handle both cases

```go
result.Match(
    func(v int) (int, error) {
        fmt.Println("Success:", v)
        return v, nil
    },
    func(err error) (int, error) {
        fmt.Println("Error:", err)
        return 0, err
    },
)
```

### ForEach — side effect on success

```go
result.ForEach(func(v int) {
    fmt.Println("Got:", v)  // only executes if Ok
})
```

## Conversion

```go
either := result.ToEither()  // Either[error, T]
// Ok(42) -> Right(42)
// Err(e) -> Left(e)
```

## JSON Serialization

Result marshals to JSON-RPC format:

```go
// Ok(42) marshals to:
{"result": 42}

// Err("fail") marshals to:
{"error": {"message": "fail"}}
```
