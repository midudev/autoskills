# Advanced Types Reference

These types are less commonly used than Option/Result/Either but provide powerful abstractions for specific scenarios.

## Type Hierarchy

```
Synchronous                    Asynchronous
-----------                    ------------
IO[T]     (no error)    →     Task[T]     (no error)    → Future[T]
IOEither[T] (with error) →     TaskEither[T] (with error) → Future[T]
```

- **IO** wraps a synchronous side-effecting computation
- **Task** wraps an asynchronous side-effecting computation (returns a Future)
- **Future** represents a value that will be available later
- **Either** variants add error handling capability

## Future[T] — Asynchronous Values

Represents a value that may not yet be available. Similar to JavaScript's Promise.

### Constructor

```go
future := mo.NewFuture(func(resolve func(int), reject func(error)) {
    // runs asynchronously
    result, err := expensiveComputation()
    if err != nil {
        reject(err)
    } else {
        resolve(result)
    }
})
```

### Chaining

```go
future.
    Then(func(v int) (int, error) {
        return v * 2, nil  // transform on success
    }).
    Catch(func(err error) (int, error) {
        return 0, err  // handle error
    }).
    Finally(func(v int, err error) (int, error) {
        // always runs, regardless of success/failure
        log.Println("Done")
        return v, err
    })
```

### Collecting Results

```go
value, err := future.Collect()    // blocks until resolved
result := future.Result()          // blocks, returns Result[T]
either := future.Either()          // blocks, returns Either[error, T]
```

### Cancellation

```go
future.Cancel()  // terminates the future chain
```

## IO[T] — Synchronous Side Effects

Wraps a function that performs side effects. The computation is lazy — it only runs when `Run()` is called. IO never fails.

### Variants by Parameter Count

```go
// No parameters
io := mo.NewIO(func() string { return "hello" })
result := io.Run()  // "hello"

// 1 parameter
io1 := mo.NewIO1(func(name string) string { return "hello " + name })
result := io1.Run("Alice")  // "hello Alice"

// 2-5 parameters (IO2, IO3, IO4, IO5)
io2 := mo.NewIO2(func(a, b int) int { return a + b })
result := io2.Run(1, 2)  // 3
```

## IOEither[T] — Synchronous Side Effects with Errors

Like IO but the computation can fail. The callback must return `Either[error, R]`, not `(R, error)`.

```go
io := mo.NewIOEither(func() mo.Either[error, string] {
    data, err := os.ReadFile("config.yaml")
    if err != nil {
        return mo.Left[error, string](err)
    }
    return mo.Right[error, string](string(data))
})

either := io.Run()  // Either[error, string]
```

### Variants by Parameter Count

```go
// 1 parameter
io1 := mo.NewIOEither1(func(path string) mo.Either[error, string] {
    data, err := os.ReadFile(path)
    if err != nil {
        return mo.Left[error, string](err)
    }
    return mo.Right[error, string](string(data))
})
either := io1.Run("config.yaml")  // Either[error, string]

// IOEither2 through IOEither5 follow the same pattern
```

## Task[T] — Asynchronous Computations

Lazy async computation — `Run()` calls the wrapped function, which returns a `*Future[T]`. Never fails.

```go
task := mo.NewTask(func() *mo.Future[int] {
    return mo.NewFuture(func(resolve func(int), reject func(error)) {
        time.Sleep(time.Second)
        resolve(42)
    })
})

future := task.Run()           // executes the function, returns *Future[int]
value, err := future.Collect() // blocks until done
```

Note: `NewTask` accepts `func() *Future[R]` — it wraps a Future-producing function for lazy execution.

### From IO

```go
io := mo.NewIO(func() int { return 42 })
task := mo.NewTaskFromIO(io)  // wrap IO as async Task
```

### Variants by Parameter Count

```go
task1 := mo.NewTask1(func(n int) *mo.Future[int] {
    return mo.NewFuture(func(resolve func(int), reject func(error)) {
        resolve(n * 2)
    })
})
future := task1.Run(21)  // *Future[int] resolving to 42
```

## TaskEither[T] — Async Computations with Errors

Like Task but the computation can fail. Combines Task semantics with error handling.

```go
te := mo.NewTaskEither(func() *mo.Future[string] {
    return mo.NewFuture(func(resolve func(string), reject func(error)) {
        resp, err := http.Get("https://api.example.com/data")
        if err != nil {
            reject(err)
            return
        }
        defer resp.Body.Close()
        body, err := io.ReadAll(resp.Body)
        if err != nil {
            reject(err)
            return
        }
        resolve(string(body))
    })
})
```

Note: Like `NewTask`, `NewTaskEither` accepts `func() *Future[R]`. The difference is in the methods available on the returned type — TaskEither provides `Match`, `OrElse`, `ToEither`, and `ToTask`.

### Methods

```go
te.OrElse("fallback")                    // blocks, returns value or fallback
te.ToEither()                            // blocks, returns Either[error, T]
te.ToTask("fallback")                    // converts to Task (uses fallback on error)
te.Match(
    func(err error) mo.Either[error, string] { ... },  // on error
    func(v string) mo.Either[error, string] { ... },    // on success
)
```

## State[S, A] — Stateful Computations

Represents a computation that threads state through a series of operations. The state type S flows through the computation while producing result values of type A.

### Constructor

```go
// State computation: takes state, returns (result, newState)
counter := mo.NewState(func(count int) (string, int) {
    return fmt.Sprintf("count=%d", count), count + 1
})

result, newState := counter.Run(0)  // ("count=0", 1)
```

### ReturnState — wrap a value without modifying state

```go
state := mo.ReturnState[int, string]("hello")
result, s := state.Run(42)  // ("hello", 42) — state unchanged
```

### State Manipulation

```go
// Get — return current state as result
getter := mo.NewState(func(s int) (int, int) { return s, s })

// Put — replace state
putter := state.Put(100)
_, s := putter.Run(0)  // (_, 100)

// Modify — transform state
modified := state.Modify(func(s int) int { return s * 2 })
_, s := modified.Run(5)  // (_, 10)
```

### Chaining State Computations

State is useful for accumulating results while threading context:

```go
// Parse tokens while tracking position
type ParseState struct {
    Input    string
    Position int
}

parseChar := mo.NewState(func(s ParseState) (byte, ParseState) {
    ch := s.Input[s.Position]
    return ch, ParseState{Input: s.Input, Position: s.Position + 1}
})
```

## When to Use Advanced Types

| Type       | Use when...                                                   |
| ---------- | ------------------------------------------------------------- |
| Future     | You need async computation with chaining (Then/Catch/Finally) |
| IO         | You want to defer and compose synchronous side effects        |
| IOEither   | Deferred side effects that can fail                           |
| Task       | Deferred async computation (lazy Future)                      |
| TaskEither | Deferred async computation that can fail                      |
| State      | Threading state through a series of pure computations         |

Most Go projects only need **Option**, **Result**, and **Either**. The advanced types are valuable when building functional pipelines or when you want explicit control over when side effects execute.
