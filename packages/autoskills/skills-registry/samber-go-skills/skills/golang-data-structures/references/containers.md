# Container Packages and String Builders

## container/list — Doubly-Linked List

A general-purpose doubly-linked list. Elements hold `any` values (no type safety).

### Time Complexity

| Operation | Complexity | Notes |
| --- | --- | --- |
| **Insert at front/back** | O(1) | `PushFront()`, `PushBack()` |
| **Remove front/back** | O(1) | `l.Remove(l.Front())`, `l.Remove(l.Back())` |
| **Insert at arbitrary position** | O(1) | If you have the element reference (`*Element`) |
| **Remove at arbitrary position** | O(1) | If you have the element reference |
| **Access by index** | O(n) | Must walk the chain — no random access |
| **Search for value** | O(n) | Linear scan required |

### When to Use

- LRU cache implementations (O(1) move-to-front)
- Ordered collections with frequent insertion/removal at arbitrary positions
- When you need stable iterators that survive insertions

### When NOT to Use

Slices outperform linked lists for most use cases due to cache locality. If you only append/remove from the ends, use a slice or a deque. Also avoid if you need O(1) random access by index.

### Use Cases

- LRU cache implementations (O(1) move-to-front with element reference)
- Ordered task queues with frequent arbitrary insertions/removals (if mutations happen frequently)
- Undo/redo stacks with stable element references
- Sliding window algorithms where elements are frequently added/removed from both ends

## container/heap — Priority Queue

An interface-based min-heap. You provide a type implementing `heap.Interface` (which embeds `sort.Interface` plus `Push`/`Pop`).

### Time Complexity

| Operation | Complexity | Notes |
| --- | --- | --- |
| **heap.Push** | O(log n) | Appends and bubbles up |
| **heap.Pop** | O(log n) | Removes root, moves last to root, bubbles down |
| **heap.Init** | O(n) | Builds heap from unsorted slice in linear time |
| **heap.Fix** | O(log n) | Re-heapifies after priority change |
| **Peek (access root)** | O(1) | Direct access to `pq[0]` |
| **Search for value** | O(n) | No indexed lookup — must scan all items |

### Space Complexity

O(n) — stores all items in a backing slice. The heap is an array-based structure, not a tree of pointers.

### Use Cases

- Task scheduling (dequeue highest-priority tasks)
- Dijkstra's algorithm (repeatedly pop minimum-distance node)
- Huffman coding (repeatedly pop two smallest frequencies)
- Event processing (process events in time order)
- A\* pathfinding (explore nodes with lowest f-cost)
- Load balancing (process requests from server with lowest load)

## container/ring — Circular Buffer

A fixed-size circular linked list. Useful for rolling windows and round-robin scheduling.

```go
// Rolling average of last 5 values
r := ring.New(5)
for _, v := range values {
    r.Value = v
    r = r.Next()
}

sum := 0.0
r.Do(func(v any) {
    if v != nil {
        sum += v.(float64)
    }
})
avg := sum / float64(r.Len())
```

## bufio — Buffered I/O

`bufio` wraps `io.Reader` and `io.Writer` with an internal buffer, reducing system call overhead for frequent small reads/writes. Use `NewReader()` / `NewWriter()` for default 4096-byte buffers, or `NewReaderSize()` / `NewWriterSize()` for custom sizes.

**bufio.Reader & Writer:** Call `Flush()` explicitly on writers and check its error. Buffered data is not written until flush or the buffer is full; ignoring a flush error can silently lose data.

**bufio.Scanner:** Convenient line-by-line reading with `scanner.Scan()` and `scanner.Text()`. Default max token size is 64 KB; call `scanner.Buffer()` to increase for larger lines.

## strings.Builder vs bytes.Buffer

**strings.Builder:** Optimized for building strings. `String()` returns the accumulated string without copying. Use for concatenating string parts. `Reset()` discards the buffer.

**bytes.Buffer:** Implements both `io.Reader` and `io.Writer`. Use for I/O operations, encoding/decoding, or when you need both read and write. `Reset()` reuses the allocated memory.

**Choose Builder for string concatenation, Buffer for I/O operations or buffer reuse in pools.**
