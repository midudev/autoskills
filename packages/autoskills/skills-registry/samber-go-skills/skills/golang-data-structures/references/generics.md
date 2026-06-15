# Writing Generic Data Structures (Go 1.18+)

## Type Constraints

Use the tightest constraint that satisfies your needs:

| Constraint | What It Allows | Use For |
| --- | --- | --- |
| `any` | All types | Containers that only store/retrieve |
| `comparable` | Types supporting `==` and `!=` | Map keys, set membership, dedup |
| `cmp.Ordered` | Numeric types + `string` | Sorting, min/max, binary search |
| Custom interface | Domain-specific operations | Specialized containers |

### Custom Constraints

```go
// Union constraint — restrict to specific types
type Number interface {
    ~int | ~int64 | ~float64
}

// Method constraint — require specific behavior
type Stringer interface {
    comparable
    String() string
}
```

The `~` prefix includes all types whose underlying type matches (e.g., `~int` matches `type UserID int`).

## Generic Set Example

```go
type Set[T comparable] map[T]struct{}

func NewSet[T comparable](vals ...T) Set[T] {
    s := make(Set[T], len(vals))
    for _, v := range vals {
        s[v] = struct{}{}
    }
    return s
}

func (s Set[T]) Add(v T)             { s[v] = struct{}{} }
func (s Set[T]) Remove(v T)          { delete(s, v) }
func (s Set[T]) Contains(v T) bool   { _, ok := s[v]; return ok }
func (s Set[T]) Len() int            { return len(s) }

func (s Set[T]) Union(other Set[T]) Set[T] {
    result := NewSet[T]()
    for v := range s {
        result.Add(v)
    }
    for v := range other {
        result.Add(v)
    }
    return result
}
```

## Generic Sorted Slice

```go
func InsertSorted[T cmp.Ordered](s []T, v T) []T {
    i, _ := slices.BinarySearch(s, v)
    return slices.Insert(s, i, v)
}
```

## Constraint Composition

Combine multiple constraints with embedded interfaces:

```go
type OrderedStringer interface {
    cmp.Ordered
    fmt.Stringer
}
```

## When NOT to Use Generics

- **Single concrete type** — generics add complexity for no benefit
- **`any` constraint with type switches** — you're just reimplementing `interface{}` with extra syntax
- **Two or fewer instantiations** — the abstraction overhead isn't justified
- **Complex type relationships** — Go's type system doesn't support higher-kinded types; if the constraints become convoluted, use interfaces instead

Generics shine for data structures (containers, sets, trees), algorithms (sort, search, transform), and utility functions (min, max, clamp) where the logic is identical across types.

→ See `samber/cc-skills-golang@golang-structs-interfaces` skill for generics vs `any` guidance and interface design.
