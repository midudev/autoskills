# Package Guide

samber/lo ships five packages. Each serves a different performance/ergonomics trade-off.

## Import Paths and Aliases

```go
import (
    "github.com/samber/lo"            // lo  — core, immutable
    "github.com/samber/lo/parallel"    // lop — concurrent transforms
    "github.com/samber/lo/mutable"     // lom — in-place mutations
    "github.com/samber/lo/it"          // loi — lazy iterators (Go 1.23+)
    "github.com/samber/lo/exp/simd"    // experimental SIMD
)
```

## `lo` — Core (Immutable)

The default package. 300+ functions that return new collections without modifying inputs.

**Mental model:** Functional transforms like JavaScript's `Array.prototype.map/filter/reduce`, but type-safe via generics.

**Characteristics:**

- Every function allocates a new result slice/map — the input is never modified
- Safe for concurrent reads on the input while transforms run
- Composable: output of one function feeds directly into the next

**Use when:** Always start here. Only move to other packages when profiling reveals a measured bottleneck.

```go
// Immutable — users slice is untouched
active := lo.Filter(users, func(u User, _ int) bool {
    return u.Active
})
```

## `lo/parallel` (lop) — Concurrent Transforms

Parallel variants of core functions. Each element is processed in a separate goroutine with automatic worker pooling.

**Available functions:** `Map`, `ForEach`, `Times`, `GroupBy`, `PartitionBy`

**Characteristics:**

- Results preserve original order despite concurrent execution
- Internal goroutine pool manages concurrency (not configurable via API — one goroutine per element)
- Synchronization via `sync.WaitGroup`

**Use when:**

- CPU-bound transforms on large datasets (~1000+ items)
- Transform function is expensive (parsing, hashing, computing)
- Order must be preserved

**Do NOT use when:**

- Small datasets (<100 items) — goroutine creation overhead exceeds benefit
- I/O-bound work (HTTP calls, DB queries) — use `errgroup` with context cancellation instead
- Transform function is trivial (field access, type cast) — `lo.Map` is faster

```go
// CPU-heavy: parse 10k JSON documents in parallel
parsed := lop.Map(rawDocs, func(doc []byte, _ int) *Document {
    return parseDocument(doc) // expensive operation
})
```

**Diagnose:** `go tool pprof -cpu` — if transform function dominates CPU profile and dataset is large, `lop` helps.

## `lo/mutable` (lom) — In-Place Mutations

Modify the original slice directly. Zero allocation overhead.

**Available functions:** `Filter`, `Map`, `Shuffle`, `Reverse`, `Replace`

**Characteristics:**

- Modifies the input slice — callers must expect side effects
- `lom.Filter` shortens the slice (removes non-matching elements in-place)
- `lom.Map` transforms elements in-place (preserves length)
- Uses Fisher-Yates for `Shuffle`
- Not safe for concurrent access to the source slice

**Use when:**

- `go tool pprof -alloc_objects` confirms allocation pressure from `lo.Filter`/`lo.Map`
- Working with very large slices where GC pressure is measurable
- You explicitly want to modify the source and won't need the original

**Do NOT use when:**

- Multiple goroutines read the same slice
- You need the original data after the transform
- Code readability matters more than micro-optimization

```go
// In-place filter — modifies 'items' directly
items = lom.Filter(items, func(item Item, _ int) bool {
    return item.Price > 0
})
```

**Diagnose:** 1- `go tool pprof -alloc_objects` — find which `lo.*` calls allocate the most 2- `go build -gcflags="-m"` — check if result slices escape to heap

## `lo/it` (loi) — Lazy Iterators

Go 1.23+ iterator support with lazy evaluation. Transforms are deferred until consumed — no intermediate slices allocated.

**Characteristics:**

- Uses `range`-over-func (Go 1.23+)
- Composable pipelines: `loi.Map` → `loi.Filter` → `loi.Take` runs as a single pass
- No intermediate slice allocations between pipeline stages
- Modules: `channel`, `find`, `intersect`, `map`, `math`, `seq`, `string`, `tuples`, `type_manipulation`

**Use when:**

- Chaining 3+ transforms on large datasets — eliminates intermediate allocations
- Processing sequences where you only need a subset (lazy `Take`/`TakeWhile`)
- Building composable pipelines with range-over-func

**Do NOT use when:**

- Go version < 1.23
- Simple single-step transforms — `lo.Map` is clearer and has negligible overhead
- You need random access to intermediate results

```go
// Lazy pipeline — no intermediate slices allocated
for name := range loi.Map(
    loi.Filter(users, func(u User) bool { return u.Active }),
    func(u User) string { return u.Name },
) {
    fmt.Println(name)
}
```

## `lo/exp/simd` — Experimental SIMD

SIMD (Single Instruction Multiple Data) optimized operations for numeric types on amd64.

**Use when:** Bulk numeric operations after benchmarking confirms the bottleneck. Very specialized.

**Warning:** This package is experimental. API may break between minor versions. Not covered by semver stability guarantees. Do not use in production without version pinning.

## Decision Flowchart

```
Start with lo.Map/Filter/Reduce (immutable, safe)
  │
  ├─ Profiler shows allocation pressure?
  │    └─ Yes → Switch specific calls to lom (mutable)
  │
  ├─ Profiler shows CPU-bound transform is slow?
  │    └─ Yes + large dataset → Switch to lop (parallel)
  │
  ├─ Chaining 3+ transforms with intermediate allocations?
  │    └─ Yes + Go 1.23+ → Switch to loi (lazy iterators)
  │
  └─ Need reactive/streaming over infinite events?
       └─ Yes → Use samber/ro instead (different library)
```

## Comparison Table

| Aspect | `lo` | `lop` | `lom` | `loi` | `simd` |
| --- | --- | --- | --- | --- | --- |
| Allocations | New slice/map | New slice/map | Zero (in-place) | Zero (lazy) | Varies |
| Goroutines | None | 1 per element | None | None | None |
| Order preserved | Yes | Yes | Yes | Yes | Yes |
| Input modified | No | No | Yes | No | Varies |
| Concurrent-safe | Read-safe | Read-safe | Not safe | Read-safe | Varies |
| API stability | Stable | Stable | Stable | Stable | Experimental |
| Go version | 1.18+ | 1.18+ | 1.18+ | 1.23+ | 1.25+ |
