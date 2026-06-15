# Either[L, R] API Reference

A discriminated union representing a value of one of two possible types. By convention, Left is the "alternative" path and Right is the "primary" path, but neither implies success or failure.

## Constructors

| Function                  | Description                 |
| ------------------------- | --------------------------- |
| `mo.Left[L, R](value L)`  | Creates a left-side Either  |
| `mo.Right[L, R](value R)` | Creates a right-side Either |

## Type Checking

| Method      | Returns | Description                            |
| ----------- | ------- | -------------------------------------- |
| `IsLeft()`  | `bool`  | True if the value is on the left side  |
| `IsRight()` | `bool`  | True if the value is on the right side |

## Value Extraction

| Method | Returns | Description |
| --- | --- | --- |
| `Left()` | `(L, bool)` | Left value and whether it exists |
| `Right()` | `(R, bool)` | Right value and whether it exists |
| `MustLeft()` | `L` | Left value or panics |
| `MustRight()` | `R` | Right value or panics |
| `LeftOrElse(fallback L)` | `L` | Left value or fallback |
| `RightOrElse(fallback R)` | `R` | Right value or fallback |
| `LeftOrEmpty()` | `L` | Left value or zero value |
| `RightOrEmpty()` | `R` | Right value or zero value |
| `Unpack()` | `(L, R)` | Both values (one will be zero value) |

## Transformations

### Swap — exchange left and right

```go
e := mo.Left[string, int]("hello")
swapped := e.Swap()  // Either[int, string] — Right("hello")
```

### MapLeft / MapRight — transform one side

The callback receives the value and must return a new `Either[L, R]`:

```go
e := mo.Left[string, int]("hello")
upper := e.MapLeft(func(s string) mo.Either[string, int] {
    return mo.Left[string, int](strings.ToUpper(s))
})
// Left("HELLO")

e2 := mo.Right[string, int](42)
doubled := e2.MapRight(func(v int) mo.Either[string, int] {
    return mo.Right[string, int](v * 2)
})
// Right(84)
```

**Go limitation:** Like Option.Map and Result.Map, direct Either methods cannot change the type parameters. Use sub-package `either.MapLeft`/`either.MapRight` for type-changing transforms — see [Pipelines Reference](./pipelines.md).

### Match — pattern matching

```go
e.Match(
    func(left string) mo.Either[string, int] {
        fmt.Println("Left:", left)
        return mo.Left[string, int](left)
    },
    func(right int) mo.Either[string, int] {
        fmt.Println("Right:", right)
        return mo.Right[string, int](right)
    },
)
```

### ForEach — side effects

```go
e.ForEach(
    func(left string) { fmt.Println("Left:", left) },
    func(right int) { fmt.Println("Right:", right) },
)
```

## Either vs Result

| Feature       | Either[L, R]            | Result[T]               |
| ------------- | ----------------------- | ----------------------- |
| Left/Err type | Any type L              | Always `error`          |
| Semantics     | Two valid alternatives  | Success or failure      |
| Use case      | Cached vs fresh, A vs B | Operation that may fail |
| JSON          | Not supported           | JSON-RPC format         |

`Result[T]` is equivalent to `Either[error, T]` — use `result.ToEither()` to convert.

## Either3[T1, T2, T3] — Three-Type Union

### Constructors

```go
e := mo.NewEither3Arg1[string, int, bool]("hello")  // T1 variant
e := mo.NewEither3Arg2[string, int, bool](42)         // T2 variant
e := mo.NewEither3Arg3[string, int, bool](true)       // T3 variant
```

### Type Checking and Extraction

```go
e.IsArg1()  // true if T1
e.IsArg2()  // true if T2
e.IsArg3()  // true if T3

val, ok := e.Arg1()      // (T1, bool)
val := e.MustArg1()      // T1 or panics
val := e.Arg1OrElse(fb)  // T1 or fallback
val := e.Arg1OrEmpty()   // T1 or zero value
t1, t2, t3 := e.Unpack() // all three (two will be zero)
```

### Pattern Matching

```go
e.Match(
    func(s string) mo.Either3[string, int, bool] { ... },
    func(i int) mo.Either3[string, int, bool] { ... },
    func(b bool) mo.Either3[string, int, bool] { ... },
)
```

### Transformations

MapArg callbacks receive the value and return a new Either3:

```go
e.MapArg1(func(s string) mo.Either3[string, int, bool] {
    return mo.NewEither3Arg1[string, int, bool](strings.ToUpper(s))
})
e.MapArg2(func(i int) mo.Either3[string, int, bool] {
    return mo.NewEither3Arg2[string, int, bool](i * 2)
})
```

## Either4 and Either5

Follow the exact same pattern as Either3 with 4 and 5 type parameters respectively:

- **Either4[T1, T2, T3, T4]**: `NewEither4Arg1` through `NewEither4Arg4`, `IsArg1`-`IsArg4`, `MapArg1`-`MapArg4`
- **Either5[T1, T2, T3, T4, T5]**: `NewEither5Arg1` through `NewEither5Arg5`, `IsArg1`-`IsArg5`, `MapArg1`-`MapArg5`

Use Either3+ when you need a type-safe union of multiple types — for example, an API that returns different response shapes depending on the request type.
