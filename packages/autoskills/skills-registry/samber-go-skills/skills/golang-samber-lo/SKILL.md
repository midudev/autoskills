---
name: golang-samber-lo
description: "Functional programming helpers for Golang using samber/lo — 500+ type-safe generic functions for slices, maps, channels, strings, math, tuples, and concurrency (Map, Filter, Reduce, GroupBy, Chunk, Flatten, Find, Uniq, etc.). Core immutable package (lo), concurrent variants (lo/parallel aka lop), in-place mutations (lo/mutable aka lom), lazy iterators (lo/it aka loi for Go 1.23+), and experimental SIMD (lo/exp/simd). Apply when using or adopting samber/lo, when the codebase imports github.com/samber/lo, or when implementing functional-style data transformations in Go. Not for streaming pipelines (→ See `samber/cc-skills-golang@golang-samber-ro` skill)."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents, and for projects using Golang.
metadata:
  author: samber
  version: "1.1.0"
  openclaw:
    emoji: "🧰"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
    install: []
    skill-library-version: "1.53.0"
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) mcp__context7__resolve-library-id mcp__context7__query-docs AskUserQuestion
---

**Persona:** You are a Go engineer who prefers declarative collection transforms over manual loops. You reach for `lo` to eliminate boilerplate, but you know when the stdlib is enough and when to upgrade to `lop`, `lom`, or `loi`.

# samber/lo — Functional Utilities for Go

Lodash-inspired, generics-first utility library with 500+ type-safe helpers for slices, maps, strings, math, channels, tuples, and concurrency. Zero external dependencies. Immutable by default.

**Official Resources:**

- [github.com/samber/lo](https://github.com/samber/lo)
- [lo.samber.dev](https://lo.samber.dev)
- [pkg.go.dev/github.com/samber/lo](https://pkg.go.dev/github.com/samber/lo)

This skill is not exhaustive. Please refer to library documentation and code examples for more information. Context7 can help as a discoverability platform.

## Why samber/lo

Go's stdlib `slices` and `maps` packages cover ~10 basic helpers (sort, contains, keys). Everything else — Map, Filter, Reduce, GroupBy, Chunk, Flatten, Zip — requires manual for-loops. `lo` fills this gap:

- **Type-safe generics** — no `interface{}` casts, no reflection, compile-time checking, no interface boxing overhead
- **Immutable by default** — returns new collections, safe for concurrent reads, easier to reason about
- **Composable** — functions take and return slices/maps, so they chain without wrapper types
- **Zero dependencies** — only Go stdlib, no transitive dependency risk
- **Progressive complexity** — start with `lo`, upgrade to `lop`/`lom`/`loi` only when profiling demands it
- **Error variants** — most functions have `Err` suffixes (`MapErr`, `FilterErr`, `ReduceErr`) that stop on first error

## Installation

```bash
go get github.com/samber/lo
```

| Package | Import | Alias | Go version |
| --- | --- | --- | --- |
| Core (immutable) | `github.com/samber/lo` | `lo` | 1.18+ |
| Parallel | `github.com/samber/lo/parallel` | `lop` | 1.18+ |
| Mutable | `github.com/samber/lo/mutable` | `lom` | 1.18+ |
| Iterator | `github.com/samber/lo/it` | `loi` | 1.23+ |
| SIMD (experimental) | `github.com/samber/lo/exp/simd` | — | 1.25+ (amd64 only) |

## Choose the Right Package

Start with `lo`. Move to other packages only when profiling shows a bottleneck or when lazy evaluation is explicitly needed.

| Package | Use when | Trade-off |
| --- | --- | --- |
| `lo` | Default for all transforms | Allocates new collections (safe, predictable) |
| `lop` | CPU-bound work on large datasets (1000+ items) | Goroutine overhead; not for I/O or small slices |
| `lom` | Hot path confirmed by `pprof -alloc_objects` | Mutates input — caller must understand side effects |
| `loi` | Large datasets with chained transforms (Go 1.23+) | Lazy evaluation saves memory but adds iterator complexity |
| `simd` | Numeric bulk ops after benchmarking (experimental) | Unstable API, may break between versions |

**Key rules:**

- `lop` is for CPU parallelism, not I/O concurrency — for I/O fan-out, use `errgroup` instead
- `lom` breaks immutability — only use when allocation pressure is measured, never assumed
- `loi` eliminates intermediate allocations in chains like `Map → Filter → Take` by evaluating lazily
- For reactive/streaming pipelines over infinite event streams, → see `samber/cc-skills-golang@golang-samber-ro` skill + `samber/ro` package

For detailed package comparison and decision flowchart, see [Package Guide](./references/package-guide.md).

## Core Patterns

### Transform a slice

```go
// ✓ lo — declarative, type-safe
names := lo.Map(users, func(u User, _ int) string {
    return u.Name
})

// ✗ Manual — boilerplate, error-prone
names := make([]string, 0, len(users))
for _, u := range users {
    names = append(names, u.Name)
}
```

### Filter + Reduce

```go
total := lo.Reduce(
    lo.Filter(orders, func(o Order, _ int) bool {
        return o.Status == "paid"
    }),
    func(sum float64, o Order, _ int) float64 {
        return sum + o.Amount
    },
    0,
)
```

### GroupBy

```go
byStatus := lo.GroupBy(tasks, func(t Task, _ int) string {
    return t.Status
})
// map[string][]Task{"open": [...], "closed": [...]}
```

### Error variant — stop on first error

```go
results, err := lo.MapErr(urls, func(url string, _ int) (Response, error) {
    return http.Get(url)
})
```

## Common Mistakes

| Mistake | Why it fails | Fix |
| --- | --- | --- |
| Using `lo.Contains` when `slices.Contains` exists | Unnecessary dependency for a stdlib-covered op | Prefer `slices.Contains`/`slices.Sort` since Go 1.21+ and `slices.Collect(maps.Keys(m))` since Go 1.23+ when a key slice is needed |
| Using `lop.Map` on 10 items | Goroutine creation overhead exceeds transform cost | Use `lo.Map` — `lop` benefits start at ~1000+ items for CPU-bound work |
| Assuming `lo.Filter` modifies the input | `lo` is immutable by default — it returns a new slice | Use `lom.Filter` if you explicitly need in-place mutation |
| Using `lo.Must` in production code paths | `Must` panics on error — fine in tests and init, dangerous in request handlers | Use the non-Must variant and handle the error |
| Chaining many eager transforms on large data | Each step allocates an intermediate slice | Use `loi` (lazy iterators) to avoid intermediate allocations |

## Best Practices

1. **Prefer stdlib when available** — `slices.Contains` and `slices.Sort` (Go 1.21+) carry no dependency; `maps.Keys` is Go 1.23+ and returns an iterator, so use `slices.Collect(maps.Keys(m))` when you need a slice. Use `lo` for transforms the stdlib doesn't offer (Map, Filter, Reduce, GroupBy, Chunk, Flatten)
2. **Compose lo functions** — chain `lo.Filter` → `lo.Map` → `lo.GroupBy` instead of writing nested loops. Each function is a building block
3. **Profile before optimizing** — switch from `lo` to `lom`/`lop` only after `go tool pprof` confirms allocation or CPU as the bottleneck
4. **Use error variants** — prefer `lo.MapErr` over `lo.Map` + manual error collection. Error variants stop early and propagate cleanly
5. **Use `lo.Must` only in tests and init** — in production, handle errors explicitly

## Quick Reference

| Function | What it does |
| --- | --- |
| `lo.Map` | Transform each element |
| `lo.Filter` / `lo.Reject` | Keep / remove elements matching predicate |
| `lo.Reduce` | Fold elements into a single value |
| `lo.ForEach` | Side-effect iteration |
| `lo.GroupBy` | Group elements by key |
| `lo.Chunk` | Split into fixed-size batches |
| `lo.Flatten` | Flatten nested slices one level |
| `lo.Uniq` / `lo.UniqBy` | Remove duplicates |
| `lo.Find` / `lo.FindOrElse` | First match or default |
| `lo.Contains` / `lo.Every` / `lo.Some` | Membership tests |
| `lo.Keys` / `lo.Values` | Extract map keys or values |
| `lo.PickBy` / `lo.OmitBy` | Filter map entries |
| `lo.Zip2` / `lo.Unzip2` | Pair/unpair two slices |
| `lo.Range` / `lo.RangeFrom` | Generate number sequences |
| `lo.Ternary` / `lo.If` | Inline conditionals |
| `lo.ToPtr` / `lo.FromPtr` | Pointer helpers |
| `lo.Must` / `lo.Try` | Panic-on-error / recover-as-bool |
| `lo.Async` / `lo.Attempt` | Async execution / retry with backoff |
| `lo.Debounce` / `lo.Throttle` | Rate limiting |
| `lo.ChannelDispatcher` | Fan-out to multiple channels |

For the complete function catalog (300+ functions), see [API Reference](./references/api-reference.md).

For composition patterns, stdlib interop, and iterator pipelines, see [Advanced Patterns](./references/advanced-patterns.md).

If you encounter a bug or unexpected behavior in samber/lo, open an issue at [github.com/samber/lo/issues](https://github.com/samber/lo/issues).

## Cross-References

- → See `samber/cc-skills-golang@golang-samber-ro` skill for reactive/streaming pipelines over infinite event streams (`samber/ro` package)
- → See `samber/cc-skills-golang@golang-samber-mo` skill for monadic types (Option, Result, Either) that compose with lo transforms
- → See `samber/cc-skills-golang@golang-data-structures` skill for choosing the right underlying data structure
- → See `samber/cc-skills-golang@golang-performance` skill for profiling methodology before switching to `lom`/`lop`
