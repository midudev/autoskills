# Slice Internals

## Memory Layout

A slice is a 24-byte header (3 machine words):

- **Pointer** — points to backing array (heap-allocated)
- **Length** — number of elements in use
- **Capacity** — allocated size of backing array

Assigning or passing a slice copies the 24-byte header, not the backing array. Both the original and copy point to the same underlying data—mutations are visible to both.

## Capacity Growth

When `append` exceeds capacity:

- `oldCap < 256`: double capacity
- `oldCap ≥ 256`: grow ~25% (`oldCap + (oldCap + 3*256) / 4`)

### Growth Cost

Each growth is O(n) — the entire array is copied to a new location. For a slice growing from 0 to N elements one at a time, the amortized cost per append is O(1), but the total copies are roughly 2N. **Preallocation eliminates all intermediate copies:**

```go
// Known size — direct indexing
out := make([]Result, len(input))
for i, v := range input {
    out[i] = transform(v)
}

// Approximate size
out := make([]Result, 0, len(input)*2)
for _, v := range input {
    out = append(out, transform(v))
}
```

## `slices` Package (Go 1.21+)

| Category | Key Functions |
| --- | --- |
| **Sort** | `Sort`, `SortFunc`, `SortStableFunc`, `IsSorted` |
| **Search** | `BinarySearch`, `BinarySearchFunc`, `Contains`, `Index`, `IndexFunc` |
| **Mutate** | `Insert`, `Delete`, `Replace`, `Compact`, `Reverse`, `Grow`, `Clip` |
| **Create** | `Concat` (1.22+), `Repeat` (1.23+), `Chunk` (1.23+) |
| **Compare** | `Clone`, `Equal`, `EqualFunc`, `Compare`, `DeleteFunc` |

## `copy()` vs `append()` vs `slices.Clone()`

| Operation             | Use When                         |
| --------------------- | -------------------------------- |
| `copy(dst, src)`      | Copying into pre-allocated slice |
| `append(dst, src...)` | Appending to a slice             |
| `slices.Clone(s)`     | Creating independent copy        |
| `s[:len(s):len(s)]`   | Preventing append aliasing       |
