# API Reference

Complete function catalog for `samber/lo` organized by domain.

For up-to-date signatures, check [pkg.go.dev/github.com/samber/lo](https://pkg.go.dev/github.com/samber/lo) or use Context7.

## Slice Transformations

| Function | Description |
| --- | --- |
| `lo.Map(s, fn)` | Transform each element. `fn(item T, index int) R` |
| `lo.MapErr(s, fn)` | Map with error — stops on first error |
| `lo.UniqMap(s, fn)` | Map + deduplicate results in one pass |
| `lo.Filter(s, fn)` | Keep elements where predicate returns true |
| `lo.FilterErr(s, fn)` | Filter with error propagation |
| `lo.Reject(s, fn)` | Remove elements where predicate returns true (inverse of Filter) |
| `lo.RejectMap(s, fn)` | Reject + map in one pass |
| `lo.FilterReject(s, fn)` | Split into `(matching, non-matching)` slices |
| `lo.FlatMap(s, fn)` | Map then flatten one level |
| `lo.FlatMapErr(s, fn)` | FlatMap with error propagation |
| `lo.FilterMap(s, fn)` | Combined filter + map in one pass. `fn` returns `(R, bool)` |
| `lo.Reduce(s, fn, init)` | Fold left into accumulator |
| `lo.ReduceRight(s, fn, init)` | Fold right into accumulator |
| `lo.ForEach(s, fn)` | Iterate with side effects |
| `lo.ForEachWhile(s, fn)` | Iterate until `fn` returns false |
| `lo.Times(n, fn)` | Call `fn(index)` n times, collect results |
| `lo.Chunk(s, size)` | Split into batches of `size` |
| `lo.Window(s, size)` | Sliding window of `size` over slice |
| `lo.Sliding(s, size)` | Sliding window (overlapping), alias for Window |
| `lo.Flatten(s)` | Flatten `[][]T` → `[]T` (one level) |
| `lo.Concat(slices...)` | Concatenate multiple slices |
| `lo.Interleave(slices...)` | Interleave elements from multiple slices |
| `lo.Repeat(n, val)` | Create slice of `n` copies of `val` |
| `lo.RepeatBy(n, fn)` | Create slice of `n` values from `fn(index)` |
| `lo.Splice(s, i, elements...)` | Insert elements at index |
| `lo.Fill(s, val)` | Fill slice with value (returns new slice) |
| `lo.Reverse(s)` | Reverse order (returns new slice) |
| `lo.Shuffle(s)` | Random shuffle (returns new slice) |
| `lo.Clone(s)` | Shallow copy of slice |

### Slice-to-map conversions

| Function                     | Description                                 |
| ---------------------------- | ------------------------------------------- |
| `lo.KeyBy(s, fn)`            | Slice to map by key extractor. `fn(T) K`    |
| `lo.Keyify(s, fn)`           | Alias for KeyBy                             |
| `lo.SliceToMap(s, fn)`       | Slice to map. `fn(T) (K, V)`                |
| `lo.Associate(s, fn)`        | Alias for SliceToMap                        |
| `lo.FilterSliceToMap(s, fn)` | Filter + slice-to-map. `fn(T) (K, V, bool)` |
| `lo.GroupBy(s, fn)`          | Group into `map[K][]V` by key function      |
| `lo.GroupByMap(s, fn)`       | GroupBy returning `map[K]R` with transform  |

### Error variants

Most transform functions have `Err` suffixes: `MapErr`, `FlatMapErr`, `FilterErr`, `ReduceErr`, `ReduceRightErr`, `ForEachErr`, `GroupByErr`, `UniqByErr`, etc. These stop processing on the first error and return `(result, error)`.

## Slice Queries

| Function | Description |
| --- | --- |
| `lo.Find(s, fn)` | First element matching predicate. Returns `(T, bool)` |
| `lo.FindOrElse(s, fallback, fn)` | First match or fallback value |
| `lo.FindIndexOf(s, fn)` | First match with index. Returns `(T, int, bool)` |
| `lo.FindLastIndexOf(s, fn)` | Last match with index |
| `lo.FindKey(m, val)` | Find key by value in map |
| `lo.FindKeyBy(m, fn)` | Find key by predicate in map |
| `lo.IndexOf(s, val)` | Index of first occurrence (-1 if not found) |
| `lo.LastIndexOf(s, val)` | Index of last occurrence |
| `lo.Contains(s, val)` | True if slice contains value. Note: prefer `slices.Contains` (stdlib Go 1.21+) |
| `lo.ContainsBy(s, fn)` | True if any element matches predicate |
| `lo.Every(s, subset)` | True if all subset elements are in s |
| `lo.EveryBy(s, fn)` | True if all elements match predicate |
| `lo.Some(s, subset)` | True if any subset element is in s |
| `lo.SomeBy(s, fn)` | True if any element matches predicate |
| `lo.None(s, subset)` | True if no subset element is in s |
| `lo.NoneBy(s, fn)` | True if no element matches predicate |
| `lo.Count(s, val)` | Count occurrences of value |
| `lo.CountBy(s, fn)` | Count elements matching predicate |
| `lo.CountValues(s)` | Frequency map `map[T]int` |
| `lo.CountValuesBy(s, fn)` | Frequency map by key function |
| `lo.Min(s)` / `lo.Max(s)` | Min/max of comparable slice |
| `lo.MinBy(s, fn)` / `lo.MaxBy(s, fn)` | Min/max by comparison function |
| `lo.MinIndex(s)` / `lo.MaxIndex(s)` | Index of min/max element |
| `lo.MinIndexBy(s, fn)` / `lo.MaxIndexBy(s, fn)` | Index of min/max by comparison |
| `lo.Earliest(vals...)` | Earliest `time.Time` value |
| `lo.EarliestBy(s, fn)` | Earliest by extractor function |
| `lo.Latest(vals...)` | Latest `time.Time` value |
| `lo.LatestBy(s, fn)` | Latest by extractor function |
| `lo.First(s)` / `lo.Last(s)` | First/last element. Returns `(T, bool)` |
| `lo.FirstOr(s, fallback)` | First element or fallback |
| `lo.FirstOrEmpty(s)` | First element or zero-value |
| `lo.LastOr(s, fallback)` | Last element or fallback |
| `lo.LastOrEmpty(s)` | Last element or zero-value |
| `lo.Nth(s, n)` | Element at index n (supports negative). Returns `(T, error)` |
| `lo.NthOr(s, n, fallback)` | Nth element or fallback |
| `lo.NthOrEmpty(s, n)` | Nth element or zero-value |
| `lo.Sample(s)` | Random element |
| `lo.SampleBy(s, fn)` | Random element matching predicate |
| `lo.Samples(s, n)` | n random elements |
| `lo.SamplesBy(s, n, fn)` | n random elements matching predicate |
| `lo.IsSorted(s)` / `lo.IsSortedBy(s, fn)` | Check if slice is sorted |
| `lo.HasPrefix(s, prefix)` | True if slice starts with prefix elements |
| `lo.HasSuffix(s, suffix)` | True if slice ends with suffix elements |

## Slice Set Operations

| Function | Description |
| --- | --- |
| `lo.Uniq(s)` | Remove duplicates (preserves first occurrence) |
| `lo.UniqBy(s, fn)` | Remove duplicates by key function |
| `lo.PartitionBy(s, fn)` | Split into groups of consecutive elements with same key |
| `lo.Compact(s)` | Remove zero-value elements |
| `lo.Without(s, vals...)` | Remove specific values |
| `lo.WithoutBy(s, fn)` | Remove elements matching predicate |
| `lo.WithoutEmpty(s)` | Remove zero-value elements (alias for Compact) |
| `lo.WithoutNth(s, indices...)` | Remove elements at specific indices |
| `lo.Union(slices...)` | Combine slices, remove duplicates |
| `lo.Intersect(a, b)` | Elements present in both slices |
| `lo.IntersectBy(a, b, fn)` | Intersection by key function |
| `lo.Difference(a, b)` | Elements in a but not in b |
| `lo.Replace(s, old, new, n)` | Replace first n occurrences |
| `lo.ReplaceAll(s, old, new)` | Replace all occurrences |
| `lo.FindDuplicates(s)` | Elements that appear more than once |
| `lo.FindDuplicatesBy(s, fn)` | Duplicates by key function |
| `lo.FindUniques(s)` | Elements that appear exactly once |
| `lo.FindUniquesBy(s, fn)` | Unique elements by key function |
| `lo.ElementsMatch(a, b)` | True if same elements regardless of order |
| `lo.ElementsMatchBy(a, b, fn)` | ElementsMatch by comparison function |
| `lo.Subset(s, offset, length)` | Sub-slice from offset with length |
| `lo.Slice(s, start, end)` | Sub-slice with bounds (safe, no panic) |

### Slice trimming

| Function                        | Description                              |
| ------------------------------- | ---------------------------------------- |
| `lo.Take(s, n)`                 | First n elements                         |
| `lo.TakeWhile(s, fn)`           | Take while predicate is true             |
| `lo.TakeFilter(s, n, fn)`       | Take first n elements matching predicate |
| `lo.Drop(s, n)`                 | Skip first n elements                    |
| `lo.DropRight(s, n)`            | Skip last n elements                     |
| `lo.DropWhile(s, fn)`           | Drop while predicate is true             |
| `lo.DropRightWhile(s, fn)`      | Drop from right while true               |
| `lo.DropByIndex(s, indices...)` | Drop elements at specific indices        |
| `lo.Cut(s, start, end)`         | Remove elements between start and end    |
| `lo.CutPrefix(s, prefix)`       | Remove prefix from slice                 |
| `lo.CutSuffix(s, suffix)`       | Remove suffix from slice                 |
| `lo.Trim(s, fn)`                | Trim both ends while predicate is true   |
| `lo.TrimLeft(s, fn)`            | Trim left while predicate is true        |
| `lo.TrimRight(s, fn)`           | Trim right while predicate is true       |
| `lo.TrimPrefix(s, prefix)`      | Remove exact prefix elements             |
| `lo.TrimSuffix(s, suffix)`      | Remove exact suffix elements             |

## Map Operations

| Function | Description |
| --- | --- |
| `lo.Keys(m)` | All keys as a slice. Note: for Go 1.23+, prefer `slices.Collect(maps.Keys(m))` when stdlib coverage is enough |
| `lo.UniqKeys(m)` | Unique keys (useful for multi-maps) |
| `lo.Values(m)` | All values |
| `lo.UniqValues(m)` | Unique values |
| `lo.HasKey(m, key)` | True if key exists |
| `lo.ValueOr(m, key, fallback)` | Value or fallback if key missing |
| `lo.PickBy(m, fn)` | Keep entries where predicate is true |
| `lo.PickByKeys(m, keys)` | Keep only specified keys |
| `lo.PickByValues(m, vals)` | Keep only specified values |
| `lo.OmitBy(m, fn)` | Remove entries where predicate is true |
| `lo.OmitByKeys(m, keys)` | Remove specified keys |
| `lo.OmitByValues(m, vals)` | Remove specified values |
| `lo.FilterKeys(m, fn)` | Keep entries where key matches predicate |
| `lo.FilterValues(m, fn)` | Keep entries where value matches predicate |
| `lo.MapKeys(m, fn)` | Transform keys |
| `lo.MapValues(m, fn)` | Transform values |
| `lo.MapEntries(m, fn)` | Transform both key and value |
| `lo.MapToSlice(m, fn)` | Convert map entries to slice |
| `lo.FilterMapToSlice(m, fn)` | Filter + map-to-slice in one pass |
| `lo.Entries(m)` / `lo.ToPairs(m)` | Map → `[]lo.Entry[K,V]` |
| `lo.FromEntries(entries)` / `lo.FromPairs(pairs)` | `[]lo.Entry` → map |
| `lo.Invert(m)` | Swap keys and values |
| `lo.Assign(maps...)` | Merge maps (last wins) |
| `lo.ChunkEntries(m, size)` | Split map into chunks of `size` entries |

## String Operations

| Function                          | Description                       |
| --------------------------------- | --------------------------------- |
| `lo.Substring(s, offset, length)` | Safe substring (rune-aware)       |
| `lo.ChunkString(s, size)`         | Split string into chunks          |
| `lo.RuneLength(s)`                | Count runes (not bytes)           |
| `lo.PascalCase(s)`                | `"hello world"` → `"HelloWorld"`  |
| `lo.CamelCase(s)`                 | `"hello world"` → `"helloWorld"`  |
| `lo.KebabCase(s)`                 | `"hello world"` → `"hello-world"` |
| `lo.SnakeCase(s)`                 | `"hello world"` → `"hello_world"` |
| `lo.Words(s)`                     | Split into words                  |
| `lo.Capitalize(s)`                | Capitalize first letter           |
| `lo.Ellipsis(s, maxLen)`          | Truncate with `…`                 |
| `lo.RandomString(n, charset)`     | Generate random string            |

## Math & Comparison

| Function                                | Description                        |
| --------------------------------------- | ---------------------------------- |
| `lo.Range(n)`                           | `[0, 1, ..., n-1]`                 |
| `lo.RangeFrom(start, n)`                | `[start, start+1, ..., start+n-1]` |
| `lo.RangeWithSteps(start, end, step)`   | Custom step range                  |
| `lo.Clamp(val, min, max)`               | Constrain value to range           |
| `lo.Sum(s)`                             | Sum of numeric slice               |
| `lo.SumBy(s, fn)`                       | Sum by extractor function          |
| `lo.Product(s)` / `lo.ProductBy(s, fn)` | Product of elements                |
| `lo.Mean(s)` / `lo.MeanBy(s, fn)`       | Arithmetic mean                    |
| `lo.Mode(s)`                            | Most frequent element(s)           |

### Conditionals

| Function | Description |
| --- | --- |
| `lo.Ternary(cond, a, b)` | Inline if/else (both values evaluated) |
| `lo.TernaryF(cond, fnA, fnB)` | Lazy ternary (only winning branch evaluated) |
| `lo.If(cond, val).ElseIf(cond2, val2).Else(val3)` | Chained conditional |
| `lo.IfF(cond, fn).ElseIfF(cond2, fn2).ElseF(fn3)` | Chained conditional with lazy evaluation |
| `lo.Switch[R](val).Case(v1, r1).Case(v2, r2).Default(r3)` | Pattern matching |

## Tuples

| Function | Description |
| --- | --- |
| `lo.T2(a, b)` ... `lo.T9(...)` | Create tuple from values |
| `lo.Unpack2(t)` ... `lo.Unpack9(t)` | Destructure tuple into values |
| `lo.Zip2(a, b)` ... `lo.Zip9(...)` | Pair elements from multiple slices |
| `lo.ZipBy2(a, b, fn)` ... `lo.ZipBy9(...)` | Zip with custom merge function |
| `lo.Unzip2(pairs)` ... `lo.Unzip9(...)` | Split pairs back into slices |
| `lo.UnzipBy2(s, fn)` ... `lo.UnzipBy9(...)` | Unzip with custom split function |
| `lo.CrossJoin2(a, b)` ... `lo.CrossJoin9(...)` | Cartesian product of slices |
| `lo.CrossJoinBy2(a, b, fn)` ... `lo.CrossJoinBy9(...)` | Cartesian product with transform |

## Channel Operations

| Function | Description |
| --- | --- |
| `lo.ChannelDispatcher(ch, count, strategy)` | Fan-out to multiple channels. Strategies: `RoundRobin`, `Random`, `WeightedRandom`, `First`, `Least`, `Most` |
| `lo.SliceToChannel(bufSize, s)` | Convert slice to buffered channel |
| `lo.ChannelToSlice(ch)` | Collect channel into slice |
| `lo.Generator(bufSize, fn)` | Create channel from generator function |
| `lo.Buffer(ch, size)` | Buffer channel output |
| `lo.BufferWithContext(ctx, ch, size)` | Buffer with context cancellation |
| `lo.BufferWithTimeout(ch, size, timeout)` | Buffer with timeout |
| `lo.FanIn(channels...)` | Merge multiple channels into one |
| `lo.FanOut(ch, count)` | Duplicate channel to multiple consumers |

## Concurrency Helpers

| Function | Description |
| --- | --- |
| `lo.Async(fn)` | Run function in goroutine, return channel for result |
| `lo.Async0` ... `lo.Async6` | Async with tuple returns |
| `lo.Attempt(maxRetries, fn)` | Retry until success or max retries |
| `lo.AttemptWithDelay(max, delay, fn)` | Retry with fixed delay between attempts |
| `lo.AttemptWhile(fn)` | Retry while predicate returns true |
| `lo.AttemptWhileWithDelay(delay, fn)` | AttemptWhile with delay between attempts |
| `lo.Debounce(duration, fn)` | Debounce — execute after quiet period. Returns `(func(), func())` (trigger, cancel) |
| `lo.DebounceBy(duration, fn)` | Debounce by key — separate debounce per key |
| `lo.Throttle(duration, fn)` | Throttle — max one execution per duration |
| `lo.ThrottleWithCount(duration, count, fn)` | Throttle allowing N executions per duration |
| `lo.ThrottleBy(duration, fn)` | Throttle by key — separate throttle per key |
| `lo.ThrottleByWithCount(duration, count, fn)` | ThrottleBy with count |
| `lo.WaitFor(fn, timeout, heartbeat)` | Poll until condition met or timeout |
| `lo.WaitForWithContext(ctx, fn, ...)` | WaitFor with context cancellation |
| `lo.Synchronize(mutexes...)` | Create synchronized wrapper. `sync.Locker`-based |
| `lo.Transaction(fn)` | Execute function with rollback on error |

## Type Manipulation

| Function | Description |
| --- | --- |
| `lo.ToPtr(v)` | Value to pointer (`&v`) |
| `lo.Nil[T]()` | Typed nil pointer |
| `lo.EmptyableToPtr(v)` | Value to pointer, zero-value becomes nil |
| `lo.FromPtr(p)` | Pointer to value (zero-value if nil) |
| `lo.FromPtrOr(p, fallback)` | Pointer to value with fallback |
| `lo.ToSlicePtr(s)` | `[]T` → `[]*T` |
| `lo.FromSlicePtr(s)` | `[]*T` → `[]T` (nil becomes zero-value) |
| `lo.FromSlicePtrOr(s, fallback)` | `[]*T` → `[]T` with fallback for nil |
| `lo.ToAnySlice(s)` | `[]T` → `[]any` |
| `lo.FromAnySlice[T](s)` | `[]any` → `([]T, bool)` |
| `lo.IsNil(v)` | Nil-safe check (handles interface nil) |
| `lo.IsNotNil(v)` | Inverse of IsNil |
| `lo.Empty[T]()` | Zero-value of type T |
| `lo.IsEmpty(v)` | True if zero-value |
| `lo.IsNotEmpty(v)` | True if not zero-value |
| `lo.Coalesce(vals...)` | First non-zero value |
| `lo.CoalesceOrEmpty(vals...)` | First non-zero or zero-value |
| `lo.CoalesceSlice(slices...)` | First non-empty slice |
| `lo.CoalesceSliceOrEmpty(slices...)` | First non-empty slice or empty |
| `lo.CoalesceMap(maps...)` | First non-empty map |
| `lo.CoalesceMapOrEmpty(maps...)` | First non-empty map or empty |

## Function Helpers

| Function | Description |
| --- | --- |
| `lo.Partial(fn, arg)` | Partial application — bind first argument |
| `lo.Partial2(fn, arg)` ... `lo.Partial5(fn, arg)` | Partial with 2-5 args |

## Duration Helpers

| Function | Description |
| --- | --- |
| `lo.Duration(fn)` | Measure execution time. Returns `time.Duration` |
| `lo.Duration0(fn)` ... `lo.Duration10(fn)` | Duration with 0-10 return values — returns `(time.Duration, ...)` |

## Error Helpers

| Function | Description |
| --- | --- |
| `lo.Must(val, err)` | Panic if err != nil, return val. Use in tests/init only |
| `lo.Must0(err)` ... `lo.Must6(...)` | Must with 0-6 return values |
| `lo.Try(fn)` | Run fn, return true if no panic |
| `lo.Try1(fn)` ... `lo.Try6(fn)` | Try with 1-6 return values |
| `lo.TryOr(fn, fallback)` | Run fn, return fallback on panic |
| `lo.TryOr1(fn, fallback)` ... `lo.TryOr6(...)` | TryOr with 1-6 return values |
| `lo.TryCatch(fn, catchFn)` | Try with catch handler |
| `lo.TryWithErrorValue(fn)` | Try returning recovered error value |
| `lo.TryCatchWithErrorValue(fn, catchFn)` | TryCatch with error value |
| `lo.Validate(conditions...)` | Return first error from condition list |
| `lo.ErrorsAs[T](err)` | Generic wrapper for `errors.As` |
| `lo.Assert[T](v)` | Type assertion with panic message |
| `lo.Assertf[T](v, format, args...)` | Type assertion with formatted panic message |
