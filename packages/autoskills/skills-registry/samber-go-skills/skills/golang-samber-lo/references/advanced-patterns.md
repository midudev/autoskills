# Advanced Patterns

## Composing Transformations

Chain lo functions to build multi-step pipelines. Each function returns a new collection that feeds into the next.

```go
// Pipeline: extract active user emails grouped by role
emailsByRole := lo.GroupBy(
    lo.Map(
        lo.Filter(users, func(u User, _ int) bool {
            return u.Active && u.EmailVerified
        }),
        func(u User, _ int) UserEmail {
            return UserEmail{Role: u.Role, Email: u.Email}
        },
    ),
    func(ue UserEmail, _ int) string {
        return ue.Role
    },
)
```

For long chains, break into named intermediate variables for readability:

```go
active := lo.Filter(users, func(u User, _ int) bool {
    return u.Active
})
names := lo.Map(active, func(u User, _ int) string {
    return u.Name
})
unique := lo.Uniq(names)
```

## lo + stdlib Interop

Prefer stdlib when it covers the operation — `lo` adds value for functional transforms the stdlib doesn't provide.

| Operation | stdlib (prefer) | lo (use when stdlib lacks) |
| --- | --- | --- |
| Contains | `slices.Contains(s, v)` | `lo.ContainsBy(s, fn)` — predicate-based |
| Sort | `slices.SortFunc(s, cmp)` | — (lo doesn't provide sort) |
| Keys | `maps.Keys(m)` | `lo.UniqKeys(m)` — deduplicated keys |
| Clone | `slices.Clone(s)` | `lo.Map(s, fn)` — when you need transform during clone |
| Min/Max | `slices.Min(s)` | `lo.MinBy(s, fn)` — by extractor function |

**Rule of thumb:** If `slices.*` or `maps.*` does what you need, use it. Reach for `lo` when you need predicates, transforms, grouping, or error variants.

## lo + samber/mo Integration

`samber/mo` provides monadic types (Option, Result, Either). They compose naturally with lo:

```go
// Filter users with valid optional emails
validEmails := lo.FilterMap(users, func(u User, _ int) (string, bool) {
    email, ok := u.Email.Get()  // mo.Option[string]
    return email, ok
})

// Map with Result — collect successes
results := lo.FilterMap(urls, func(url string, _ int) (Response, bool) {
    res := fetchURL(url)  // returns mo.Result[Response]
    val, err := res.Get()
    return val, err == nil
})
```

## Iterator Patterns (loi)

Requires Go 1.23+. Lazy iterators avoid intermediate allocations.

### Eager vs lazy comparison

```go
// Eager — allocates 2 intermediate slices
result := lo.Map(lo.Filter(bigSlice, filterFn), mapFn)

// Lazy — zero intermediate allocations
for v := range loi.Map(loi.Filter(bigSlice, filterFn), mapFn) {
    process(v)
}
```

### Building lazy pipelines

```go
// Lazy pipeline: filter → map → take first 10
pipeline := loi.Take(
    loi.Map(
        loi.Filter(records, func(r Record) bool {
            return r.Score > 0.8
        }),
        func(r Record) string {
            return r.Name
        },
    ),
    10,
)

// Consume with range
for name := range pipeline {
    fmt.Println(name)
}
```

## Performance-Sensitive Patterns

### When to switch from lo to lom

**Trigger:** `go tool pprof -alloc_objects` shows `lo.Filter` or `lo.Map` as top allocators in a hot path.

```go
// Before — allocates new slice every call
filtered := lo.Filter(events, isValid)

// After — zero allocations, modifies in-place
events = lom.Filter(events, isValid)
// Warning: 'events' is now modified. Original data is lost.
```

### Parallel transforms

**Trigger:** `go tool pprof -cpu` shows transform function dominating CPU on large datasets.

```go
// Switch from sequential to parallel
results := lop.Map(largeSlice, expensiveTransform)
```

## Testing with lo

lo helpers simplify test data generation and assertions:

```go
// Generate test fixtures
users := lo.Times(100, func(i int) User {
    return User{ID: i, Name: fmt.Sprintf("user-%d", i)}
})

// Assert subset relationships
assert.True(t, lo.Every(expected, lo.Map(actual, extractID)))

// Generate random test data
ids := lo.Times(50, func(_ int) string {
    return lo.RandomString(16, lo.AlphanumericCharset)
})

// Quick frequency check
counts := lo.CountValues(results)
assert.Equal(t, 3, counts["success"])
```

## Slice-to-Map Conversion

Common pattern: convert a slice into a lookup map.

```go
// By ID
userByID := lo.SliceToMap(users, func(u User) (int, User) {
    return u.ID, u
})

// By key function
userByEmail := lo.KeyBy(users, func(u User) string {
    return u.Email
})

// Filter + convert in one pass
activeByID := lo.FilterSliceToMap(users, func(u User) (int, User, bool) {
    return u.ID, u, u.Active
})
```
