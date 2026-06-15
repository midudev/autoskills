# Operators Guide

samber/ro provides 150+ operators organized by category. All operators are generic functions that take and return `Observable[T]`, designed for chaining via `Pipe`.

## Pipeline Construction

```go
// Typed pipes (Pipe1 through Pipe25) — compile-time type safety
result := ro.Pipe2(source, op1, op2)
result := ro.Pipe3(source, op1, op2, op3)

// Untyped pipe — uses any, loses type checking
result := ro.Pipe(source, op1, op2, op3)

// Reusable operator composition (curried)
transform := ro.PipeOp2(op1, op2) // returns func(Observable[A]) Observable[C]
result := transform(source)

// Synchronous collection
values, err := ro.Collect(observable)
```

## Creation Operators

Create observables from various sources. Typically the first argument to `Pipe`.

| Operator | Signature | Purpose |
| --- | --- | --- |
| `Just` | `Just[T](values ...T) Observable[T]` | Emit specific values then complete |
| `Of` | `Of[T](values ...T) Observable[T]` | Alias for Just |
| `FromSlice` | `FromSlice[T](items []T) Observable[T]` | Create from existing slice |
| `FromChannel` | `FromChannel[T](ch <-chan T) Observable[T]` | Wrap Go channel as observable |
| `Range` | `Range(start, end int) Observable[int]` | Emit integer sequence |
| `RangeWithStep` | `RangeWithStep(start, end, step int) Observable[int]` | Integer sequence with custom step |
| `RangeWithInterval` | `RangeWithInterval(start, end int, d time.Duration) Observable[int]` | Integers with delay between each |
| `RangeWithStepAndInterval` | `RangeWithStepAndInterval(start, end, step int, d time.Duration) Observable[int]` | Step + interval combined |
| `Interval` | `Interval(d time.Duration) Observable[int64]` | Emit sequential integers at intervals (infinite) |
| `IntervalWithInitial` | `IntervalWithInitial(initial, d time.Duration) Observable[int64]` | Interval with initial delay |
| `Timer` | `Timer(d time.Duration) Observable[int64]` | Single emission after delay |
| `Repeat` | `Repeat[T](item T, count int64) Observable[T]` | Repeat item N times |
| `RepeatWithInterval` | `RepeatWithInterval[T](item T, count int64, d time.Duration) Observable[T]` | Repeat with delay |
| `Defer` | `Defer[T](factory func() Observable[T]) Observable[T]` | Lazily create observable on subscription |
| `Future` | `Future[T](factory func() (T, error)) Observable[T]` | Single async value from function |
| `Start` | `Start(cb func() (any, error)) Observable[any]` | Execute callback and emit result |
| `Empty` | `Empty[T]() Observable[T]` | Complete immediately, no values |
| `Never` | `Never[T]() Observable[T]` | Never emit or complete |
| `Throw` | `Throw[T](err error) Observable[T]` | Immediately error |

```go
// Custom observable with direct control
obs := ro.NewObservable[int](func(ctx context.Context, observer ro.Observer[int]) error {
    observer.Next(1)
    observer.Next(2)
    observer.Complete()
    return nil
})
```

## Transformation Operators

Transform each value in the stream.

| Operator | Purpose |
| --- | --- |
| `Map[T, R](fn func(T) R)` | Transform each value T -> R |
| `MapI[T, R](fn func(T, int64) R)` | Map with index |
| `MapErr[T, R](fn func(T) (R, error))` | Map that can fail — error propagates |
| `MapWithContext[T, R](fn func(ctx, T) (ctx, R))` | Map with context access |
| `MapTo[T, R](output R)` | Replace all values with a constant |
| `FlatMap[T, R](fn func(T) Observable[R])` | Map each value to observable, flatten results |
| `MergeMap[T, R](fn func(T) Observable[R])` | Alias for FlatMap |
| `Scan[T, R](fn func(R, T) R, seed R)` | Running accumulation, emit each intermediate |
| `Reduce[T, R](fn func(R, T) R, seed R)` | Accumulate, emit only final result |
| `GroupBy[T, K](fn func(T) K)` | Partition into grouped observables by key |
| `Cast[T, U]()` | Type cast values |
| `Flatten[T]()` | Flatten `Observable[[]T]` to `Observable[T]` |
| `Materialize[T]()` | Wrap values in `Notification[T]` (next/error/complete) |
| `Dematerialize[T]()` | Unwrap `Notification[T]` back to values |
| `Timestamp[T]()` | Emit `TimestampValue[T]` with emission time |
| `TimeInterval[T]()` | Emit `IntervalValue[T]` with time since last emission |

```go
// FlatMap: for each user ID, fetch their orders (returns observable)
orders := ro.Pipe2(
    userIDs,
    ro.FlatMap(func(id int) ro.Observable[Order] {
        return fetchOrders(id)
    }),
    ro.Filter(func(o Order) bool { return o.Status == "paid" }),
)

// Scan: running sum
ro.Pipe1(
    ro.Just(1, 2, 3, 4, 5),
    ro.Scan(func(acc, x int) int { return acc + x }, 0),
)
// Emits: 1, 3, 6, 10, 15
```

## Filtering Operators

Selectively emit values from the stream.

| Operator | Purpose |
| --- | --- |
| `Filter[T](fn func(T) bool)` | Emit only values matching predicate |
| `FilterI[T](fn func(T, int64) bool)` | Filter with index |
| `FilterWithContext[T](fn func(ctx, T) (ctx, bool))` | Filter with context access |
| `Distinct[T comparable]()` | Emit only unique values |
| `DistinctBy[T, K](fn func(T) K)` | Unique by key function |
| `Take[T](n int64)` | Emit first N values then complete |
| `TakeLast[T](n int)` | Emit last N values |
| `TakeWhile[T](fn func(T) bool)` | Emit while predicate true, then complete |
| `TakeUntil[T, S](signal Observable[S])` | Emit until signal observable emits |
| `Skip[T](n int64)` | Skip first N values |
| `SkipLast[T](n int)` | Skip last N values |
| `SkipWhile[T](fn func(T) bool)` | Skip while predicate true |
| `SkipUntil[T, S](signal Observable[S])` | Skip until signal emits |
| `Head[T]()` | First item only |
| `Tail[T]()` | All items except first |
| `ElementAt[T](n int)` | Item at specific index |
| `ElementAtOrDefault[T](n int64, fallback T)` | Item at index or default |
| `Find[T](fn func(T) bool)` | First value matching predicate |
| `First[T](fn func(T) bool)` | First matching value (alias-like) |
| `Last[T](fn func(T) bool)` | Last matching value |
| `Contains[T](fn func(T) bool)` | Emit bool: whether any value matches |

All filtering operators have `I` (indexed), `WithContext`, and `IWithContext` variants.

## Combining Operators

Merge multiple observables into one.

| Operator | Purpose |
| --- | --- |
| `Merge[T](sources ...Observable[T])` | Interleave emissions from all sources |
| `MergeWith[T](obs ...Observable[T])` | Chainable merge |
| `MergeAll[T]()` | Flatten `Observable[Observable[T]]` by merging |
| `Concat[T](obs ...Observable[T])` | Sequential: complete first, then start second |
| `ConcatWith[T](obs ...Observable[T])` | Chainable concat |
| `ConcatAll[T]()` | Flatten by concatenating sequentially |
| `Zip2[A, B](a, b)` | Pair values from 2 sources into `lo.Tuple2` |
| `Zip3` ... `Zip6` | Zip 3-6 sources into corresponding `lo.Tuple` |
| `ZipWith[A, B](obsB)` | Chainable zip |
| `CombineLatest2[A, B](a, b)` | Emit combined latest when either source emits |
| `CombineLatest3` ... `CombineLatest5` | Combine 3-5 sources |
| `CombineLatestWith[A, B](obsB)` | Chainable combine-latest |
| `Race[T](sources ...Observable[T])` | Emit from whichever source emits first |
| `Amb[T](sources ...)` | Alias for Race |
| `StartWith[T](prefixes ...T)` | Prepend values before source emissions |
| `EndWith[T](suffixes ...T)` | Append values after source completes |

```go
// Zip: pair user with their settings
ro.Zip2(userStream, settingsStream)
// Emits: lo.Tuple2[User, Settings]

// CombineLatest: re-emit whenever either changes
ro.CombineLatest2(priceStream, quantityStream)
// Emits latest (price, quantity) pair each time either updates
```

## Math and Aggregation

| Operator | Purpose |
| --- | --- |
| `Count[T]()` | Count of emitted values |
| `Sum[T Numeric]()` | Sum of all values |
| `Average[T Numeric]()` | Average as float64 |
| `Max[T Numeric]()` | Maximum value |
| `Min[T Numeric]()` | Minimum value |
| `Abs()` | Absolute value (float64) |
| `Ceil()` / `Floor()` / `Round()` / `Trunc()` | Rounding (float64) |
| `CeilWithPrecision(n)` / `FloorWithPrecision(n)` | Rounding with decimal places |
| `Clamp[T](lower, upper)` | Constrain values to range |

## Error Handling

| Operator | Purpose |
| --- | --- |
| `Catch[T](fn func(error) Observable[T])` | Catch error, switch to recovery observable |
| `OnErrorReturn[T](value T)` | Replace error with fallback value |
| `OnErrorResumeNextWith[T](obs ...Observable[T])` | Continue with fallback observables on error |
| `Retry[T]()` | Retry indefinitely on error |
| `RetryWithConfig[T](cfg RetryConfig)` | Retry with max attempts, delay, backoff |
| `ThrowIfEmpty[T](fn func() error)` | Error if stream completes empty |

```go
// RetryConfig for exponential backoff
ro.RetryWithConfig[Response](ro.RetryConfig{
    Max:               3,
    Delay:             time.Second,
    BackoffMultiplier: 2.0,
    MaxDelay:          10 * time.Second,
})
```

## Timing and Buffering

| Operator | Purpose |
| --- | --- |
| `Delay[T](d time.Duration)` | Delay entire stream |
| `DelayEach[T](d time.Duration)` | Delay between each emission |
| `Timeout[T](d time.Duration)` | Error if no emission within duration |
| `ThrottleTime[T](d time.Duration)` | Ignore values within duration of last |
| `ThrottleWhen[T, t](tick Observable[t])` | Throttle by signal |
| `SampleTime[T](d time.Duration)` | Emit latest value at intervals |
| `SampleWhen[T, t](tick Observable[t])` | Sample by signal |
| `BufferWithCount[T](n int)` | Collect N items, emit as `[]T` |
| `BufferWithTime[T](d time.Duration)` | Collect within time window |
| `BufferWithTimeOrCount[T](n, d)` | Buffer with either condition |
| `BufferWhen[T, B](boundary Observable[B])` | Buffer until signal |
| `WindowWhen[T, B](boundary Observable[B])` | Window as nested observables |
| `Pairwise[T]()` | Emit consecutive pairs |

## Side Effects (Tap / Do)

Execute code without changing the stream. `Do` is an alias for `Tap`.

| Operator                              | Purpose                     |
| ------------------------------------- | --------------------------- |
| `Tap[T](onNext, onError, onComplete)` | Side effect on all events   |
| `TapOnNext[T](fn func(T))`            | Side effect on values       |
| `TapOnError[T](fn func(error))`       | Side effect on errors       |
| `TapOnComplete[T](fn func())`         | Side effect on completion   |
| `TapOnSubscribe[T](fn func())`        | Side effect on subscription |
| `TapOnFinalize[T](fn func())`         | Side effect on teardown     |

All have `WithContext` variants. `Do`, `DoOnNext`, `DoOnError`, `DoOnComplete`, `DoOnSubscribe`, `DoOnFinalize` are aliases.

## Connectable and Sharing

| Operator | Purpose |
| --- | --- |
| `Share[T]()` | Cold -> hot with reference counting |
| `ShareWithConfig[T](cfg ShareConfig[T])` | Share with reset options |
| `ShareReplay[T](bufferSize int)` | Share + replay last N values to late subscribers |
| `ShareReplayWithConfig[T](n, cfg)` | ShareReplay with reset options |
| `Serialize[T]()` | Queue emissions to ensure serial delivery |

```go
// ShareConfig controls lifecycle reset
ro.ShareConfig[T]{
    ResetOnComplete:       true,  // re-subscribe on complete
    ResetOnError:          true,  // re-subscribe on error
    ResetOnReferenceCount: true,  // re-subscribe when count drops to 0
}
```

## Context Operators

| Operator                                 | Purpose                         |
| ---------------------------------------- | ------------------------------- |
| `ContextReset[T](ctx context.Context)`   | Replace pipeline context        |
| `ContextWithValue[T](key, value any)`    | Add value to context            |
| `ContextWithTimeout[T](d time.Duration)` | Add timeout                     |
| `ContextWithDeadline[T](t time.Time)`    | Add deadline                    |
| `ContextMap[T](fn func(ctx) ctx)`        | Transform context               |
| `ThrowOnContextCancel[T]()`              | Error when context is cancelled |

## Conditional Operators

| Operator | Purpose |
| --- | --- |
| `All[T](fn func(T) bool)` | Emit bool: whether all values match |
| `DefaultIfEmpty[T](value T)` | Emit default if source completes empty |
| `ThrowIfEmpty[T](fn func() error)` | Error if empty |
| `Iif[T](pred func() bool, a, b Observable[T])` | Choose between two observables |
| `While[T](cond func() bool)` | Repeat while condition true |
| `DoWhile[T](cond func() bool)` | Execute at least once, repeat while true |
| `SequenceEqual[T](obsB Observable[T])` | Emit bool: whether two streams match |

## Terminal Operators

| Operator | Purpose |
| --- | --- |
| `Collect[T](obs Observable[T]) ([]T, error)` | Block, return all values as slice |
| `CollectWithContext[T](ctx, obs) ([]T, ctx, error)` | Collect with context |
| `ToSlice[T]()` | Operator: emit `[]T` on complete |
| `ToChannel[T](size int)` | Convert to `<-chan Notification[T]` |
| `ToMap[T, K, V](fn func(T) (K, V))` | Collect into map |

## Observer and Subscription

```go
// Full observer (recommended)
observer := ro.NewObserver[T](onNext, onError, onComplete)

// Context-aware observer
observer := ro.NewObserverWithContext[T](onNext, onError, onComplete)

// Convenience shortcuts
observer := ro.OnNext[T](func(v T) { ... })
observer := ro.PrintObserver[T]()  // debug: prints all events
observer := ro.NoopObserver[T]()   // discard all events

// Subscription lifecycle
sub := observable.Subscribe(observer)
sub.Wait()          // block until complete or error
sub.Unsubscribe()   // cancel and cleanup
sub.IsActive()      // check if still running
sub.GetError()      // get terminal error
```

## Scheduling

| Operator                         | Purpose                                  |
| -------------------------------- | ---------------------------------------- |
| `SubscribeOn[T](bufferSize int)` | Run subscription on async scheduler      |
| `ObserveOn[T](bufferSize int)`   | Deliver notifications on async scheduler |

## Concurrency Modes

```go
// Safe (default): synchronized emissions
ro.NewObservable[T](fn)
ro.NewSafeObservable[T](fn)

// Unsafe: no synchronization, caller must guarantee single-goroutine access
ro.NewUnsafeObservable[T](fn)

// Eventually safe: allows brief unsynchronized period, then synchronizes
ro.NewEventuallySafeObservable[T](fn)
```
