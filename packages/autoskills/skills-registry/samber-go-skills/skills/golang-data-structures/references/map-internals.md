# Map Internals Deep Dive

## Hash Table Structure

Go maps use hash tables with bucket-based collision resolution. The map header holds:

- `count` — number of entries
- `B` — log₂ of bucket count (2^B buckets total)
- `buckets` — pointer to bucket array
- `oldbuckets` — pointer to old buckets during growth

Each bucket holds 8 key-value pairs. Keys and values are stored in separate arrays within buckets to minimize padding waste.

## Memory Growth and Capacity

- **Load factor threshold**: 6.5 entries per bucket triggers growth (sweet spot between memory efficiency and collision performance)
- **Overflow bucket chains** also trigger growth if too long (prevents O(1)→O(n) degradation)
- **Bucket count doubles**: 2^B → 2^(B+1) (efficient rehashing with powers of 2)
- **Incremental evacuation**: Old and new buckets coexist during growth; entries move lazily during operations to avoid GC pauses
- **No `cap()` function**: Capacity depends on hash distribution and load factor, not a fixed limit. Preallocation (`make(map[string]int, expectedSize)`) is worthwhile for large maps to avoid repeated growth cycles

## Preallocation

```go
// Without preallocation — multiple growths as entries are added
m := map[string]int{}

// With preallocation — allocates enough buckets upfront
m := make(map[string]int, expectedSize)
```

Preallocation avoids repeated growths. The hint is approximate — Go allocates 2^B buckets where 2^B \* 6.5 >= hint.

## Pointers vs Values

For large value types, storing pointers reduces copy overhead:

```go
// Large struct — copied on every read/write
m := map[string]BigStruct{}  // copies large struct

// Pointer — only pointer is copied
m := map[string]*BigStruct{} // copies 8-byte pointer
```

Trade-off: pointer maps add GC pressure. For small structs (< 128 bytes), value maps are typically faster.

## `maps` Package (Go 1.21+)

| Function | Description |
| --- | --- |
| `Clone`, `Equal`, `EqualFunc` | Shallow copy and equality comparison |
| `Keys`, `Values`, `All` (1.23+) | Iterators over keys, values, or pairs |
| `Collect`, `Insert` (1.23+) | Build maps from iterators or insert entries |

See `samber/cc-skills-golang@golang-safety` skill for `Clone`, `Equal`, and sorted iteration patterns.

## Map Key Requirements

Map keys must be comparable (`==` must work). This includes:

- All numeric types, `string`, `bool`
- Pointers, channels, interfaces (compared by identity)
- Arrays of comparable types
- Structs where all fields are comparable

Slices, maps, and functions **cannot** be map keys.
