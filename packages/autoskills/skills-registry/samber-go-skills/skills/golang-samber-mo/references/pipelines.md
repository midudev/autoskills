# Pipeline Sub-Packages Reference

samber/mo provides sub-packages (`option`, `result`, `either`, `either3`, `either4`, `either5`) with standalone functions for type-changing transformations and composable pipelines.

## Why Sub-Packages Exist

Direct methods on Option/Result/Either (`.Map`, `.FlatMap`) cannot change the type parameter because Go methods cannot introduce new type parameters. For example:

```go
opt := mo.Some(42)
// opt.Map can return Option[int], but NOT Option[string]
// because Map's signature is: func (o Option[T]) Map(func(T) (T, bool)) Option[T]
```

Sub-package functions solve this by being standalone generic functions:

```go
import "github.com/samber/mo/option"

// option.Map CAN change the type: Option[int] -> Option[string]
strOpt := option.Map(func(v int) string {
    return strconv.Itoa(v)
})(mo.Some(42))
// Some("42")
```

## option/ Package

### Transformation Functions

| Function | Signature | Description |
| --- | --- | --- |
| `option.Map` | `func(I) O -> func(Option[I]) Option[O]` | Transform value, changing type |
| `option.FlatMap` | `func(I) Option[O] -> func(Option[I]) Option[O]` | Chain with type change |
| `option.Match` | `(onValue, onNone) -> func(Option[I]) Option[O]` | Branch with type change |
| `option.FlatMatch` | `(onValue, onNone) -> func(Option[I]) Option[O]` | Branch returning Options |

### Pipe Functions

Chain multiple transformations in a readable pipeline:

```go
import "github.com/samber/mo/option"

result := option.Pipe3(
    mo.Some(42),                                                          // Option[int]
    option.Map(func(v int) string { return strconv.Itoa(v) }),            // -> Option[string]
    option.Map(func(s string) []byte { return []byte(s) }),               // -> Option[[]byte]
    option.FlatMap(func(b []byte) mo.Option[string] {                     // -> Option[string]
        if len(b) > 0 { return mo.Some(string(b)) }
        return mo.None[string]()
    }),
)
```

Available: `option.Pipe1` through `option.Pipe10` (1 to 10 transformation steps).

## result/ Package

### Transformation Functions

| Function | Signature | Description |
| --- | --- | --- |
| `result.Map` | `func(I) O -> func(Result[I]) Result[O]` | Transform success value, changing type |
| `result.FlatMap` | `func(I) Result[O] -> func(Result[I]) Result[O]` | Chain with type change |
| `result.Match` | `(onValue, onError) -> func(Result[I]) Result[O]` | Branch with type change |
| `result.FlatMatch` | `(onValue, onError) -> func(Result[I]) Result[O]` | Branch returning Results |

### Pipe Functions

```go
import "github.com/samber/mo/result"

parsed := result.Pipe2(
    mo.TupleToResult(os.ReadFile("config.yaml")),                         // Result[[]byte]
    result.Map(func(data []byte) Config {                                 // -> Result[Config]
        var cfg Config
        yaml.Unmarshal(data, &cfg)
        return cfg
    }),
    result.FlatMap(func(cfg Config) mo.Result[ValidConfig] {              // -> Result[ValidConfig]
        return validateConfig(cfg)
    }),
)
```

Available: `result.Pipe1` through `result.Pipe10`.

## either/ Package

### Transformation Functions

| Function | Signature | Description |
| --- | --- | --- |
| `either.MapLeft` | `func(Lin) Lout -> func(Either[Lin, R]) Either[Lout, R]` | Transform left side type |
| `either.MapRight` | `func(Rin) Rout -> func(Either[L, Rin]) Either[L, Rout]` | Transform right side type |
| `either.FlatMapLeft` | `func(Lin) Either[Lout, R] -> func(Either[Lin, R]) Either[Lout, R]` | Chain left with type change |
| `either.FlatMapRight` | `func(Rin) Either[L, Rout] -> func(Either[L, Rin]) Either[L, Rout]` | Chain right with type change |
| `either.Match` | `(onLeft, onRight) -> func(Either[Lin, Rin]) Either[Lout, Rout]` | Branch both sides |
| `either.Swap` | `func(Either[I, O]) Either[O, I]` | Exchange left and right |

### Pipe Functions

```go
import "github.com/samber/mo/either"

result := either.Pipe2(
    mo.Right[error, int](42),
    either.MapRight(func(v int) string { return strconv.Itoa(v) }),
    either.MapRight(func(s string) []byte { return []byte(s) }),
)
```

Available: `either.Pipe1` through `either.Pipe10`.

## either3/, either4/, either5/ Packages

Each provides:

- `Match` with handlers for each argument type
- `MapArg1`, `MapArg2`, `MapArg3` (up to `MapArg5` for either5)
- `Pipe1` through `Pipe10`

## When to Use Pipes vs Direct Methods

| Scenario | Use | Why |
| --- | --- | --- |
| Same type in, same type out | Direct method (`.Map`) | Simpler, no import needed |
| Type changes across steps | Sub-package function | Go methods can't add type params |
| 3+ chained type transforms | `Pipe3`+ | Readable left-to-right flow |
| Single type transform | Sub-package function call | Pipe1 is overkill |
| Mixed same-type and cross-type | Combine both | Direct for same-type, pipe for cross-type |

### Example: Combined Usage

```go
// Start with direct method (same type)
opt := mo.Some(42).
    Map(func(v int) (int, bool) { return v * 2, true })  // still Option[int]

// Then use pipe for type change
result := option.Pipe2(
    opt,
    option.Map(func(v int) string { return strconv.Itoa(v) }),  // -> Option[string]
    option.Map(func(s string) User { return User{Name: s} }),   // -> Option[User]
)
```
