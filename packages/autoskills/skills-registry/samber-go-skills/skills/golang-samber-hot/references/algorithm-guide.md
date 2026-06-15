# Algorithm Selection Guide

## Decision Tree

```
Start here
  |
  v
Do you know your access pattern?
  |-- No --> Use W-TinyLFU (adapts automatically)
  |-- Yes
       |
       v
     Is recency the primary signal? (sessions, recent queries, time-windowed data)
       |-- Yes --> LRU
       |-- No
            |
            v
          Is frequency the primary signal? (popular products, DNS, static config)
            |-- Yes --> Does the popularity ranking shift over time?
            |           |-- Yes --> TinyLFU (frequency with decay)
            |           |-- No --> LFU
            |-- No
                 |
                 v
               Is throughput critical and cache is large? (>100k items, high write rate)
                 |-- Yes --> S3FIFO
                 |-- No
                      |
                      v
                    Do you want self-tuning with no config? (unknown or shifting patterns)
                      |-- Yes --> ARC (higher memory) or W-TinyLFU (lower memory)
                      |-- No
                           |
                           v
                         Is scan resistance needed with simplicity?
                           |-- Yes --> SIEVE
                           |-- No --> W-TinyLFU (safe default)
```

## Algorithm Deep Dives

### LRU (Least Recently Used)

**Constant:** `hot.LRU`

Evicts the item that hasn't been accessed for the longest time. Simple doubly-linked list + hash map implementation.

- **Strengths:** Simple mental model, predictable behavior, low overhead per operation
- **Weaknesses:** Scan pollution — a single sequential scan evicts all hot items. No frequency awareness.
- **Ideal workload:** Time-windowed data (user sessions, recent search results, short-lived tokens)
- **Degrades when:** A batch job or sequential scan touches many cold keys, evicting frequently-used items

### LFU (Least Frequently Used)

**Constant:** `hot.LFU`

Evicts the item with the fewest accesses. Tracks access counts per key.

- **Strengths:** Keeps genuinely popular items regardless of access timing
- **Weaknesses:** Stale popular items never evict — an item accessed 10,000 times yesterday blocks new hot items today. No frequency decay.
- **Ideal workload:** Stable popularity rankings (DNS records, country code lookups, static configuration)
- **Degrades when:** Popularity shifts over time or new items need to ramp up quickly

### TinyLFU

**Constant:** `hot.TinyLFU`

Combines frequency estimation with a compact Count-Min Sketch instead of per-key counters. Includes frequency decay — old access counts fade over time.

- **Strengths:** Low memory overhead for frequency tracking, handles popularity shifts via decay, good admission filtering
- **Weaknesses:** Admission filter adds overhead on writes. Sketch approximation can cause rare false positives.
- **Ideal workload:** Read-heavy with moderate frequency bias (API response caching, content delivery metadata)
- **Degrades when:** Write-heavy workloads where admission overhead exceeds the benefit

### W-TinyLFU (Weighted TinyLFU)

**Constant:** `hot.WTinyLFU`

Adds a small "window" LRU in front of TinyLFU's admission filter. New items enter the window, and the admission filter decides whether they're promoted to the main cache. Balances recency and frequency automatically.

- **Strengths:** Best general-purpose hit rate across diverse workloads. Self-adapting. Handles both recency and frequency patterns.
- **Weaknesses:** Slightly more complex internals (harder to reason about eviction order during debugging)
- **Ideal workload:** Mixed or unknown access patterns, general-purpose caching
- **Degrades when:** Rarely — it's the safest default. May underperform specialized algorithms on extreme workloads.

### S3FIFO (Segmented Small-Size FIFO)

**Constant:** `hot.S3FIFO`

Three-segment FIFO design: small, main, and ghost queues. Items promoted from small to main only if accessed again. Ghost queue tracks recently evicted keys for scan resistance.

- **Strengths:** Excellent throughput (FIFO operations are cheaper than linked-list manipulations). Good scan resistance. Simple eviction path.
- **Weaknesses:** Needs enough capacity for the segmented structure to work. Less effective on small caches.
- **Ideal workload:** High-throughput systems with large caches (>100k items), CDN-like access patterns
- **Degrades when:** Cache is very small (<1000 items) — the segments don't have enough room to differentiate access patterns

### ARC (Adaptive Replacement Cache)

**Constant:** `hot.ARC`

Maintains four internal lists: two for recency (recent and recent-ghost) and two for frequency (frequent and frequent-ghost). Dynamically adjusts the split between recency and frequency based on which ghost list sees more hits.

- **Strengths:** Self-tuning — learns from misses whether to favor recency or frequency. No manual parameter tuning.
- **Weaknesses:** ~2x memory overhead for ghost lists. More complex implementation.
- **Ideal workload:** Workloads that shift between recency and frequency patterns (mixed database query caching)
- **Degrades when:** Memory is constrained — the ghost lists consume significant space

### TwoQueue

**Constant:** `hot.TwoQueue`

Separates items into "hot" (frequently accessed) and "cold" (recently added) queues with independent eviction. Items graduate from cold to hot on second access.

- **Strengths:** Good separation of one-hit wonders from genuinely useful items. Scan resistant.
- **Weaknesses:** Requires understanding the hot/cold split ratio for optimal tuning
- **Ideal workload:** Workloads with a clear hot/cold distinction (e.g., 20% of keys serve 80% of requests)
- **Degrades when:** Access patterns are uniform with no clear hot/cold split

### SIEVE

**Constant:** `hot.SIEVE`

Modern eviction algorithm that uses a single bit per entry (visited/not-visited) with a circular "hand" pointer. Simple scan-resistant alternative to LRU.

- **Strengths:** Very low per-item overhead (1 bit). Scan-resistant. Simple implementation.
- **Weaknesses:** Less sophisticated than W-TinyLFU or ARC for complex patterns
- **Ideal workload:** When you want scan resistance with minimal complexity and overhead
- **Degrades when:** Access patterns are highly skewed — specialized algorithms capture the skew better

### FIFO (First In, First Out)

**Constant:** `hot.FIFO`

Evicts the oldest inserted item regardless of access pattern. No recency or frequency tracking.

- **Strengths:** Simplest possible eviction. Predictable. Zero per-access overhead.
- **Weaknesses:** No intelligence — ignores how often or recently items are accessed
- **Ideal workload:** TTL-driven caches where all items have similar lifetimes and eviction order doesn't matter (log buffers, time-series windows)
- **Degrades when:** Hit rate matters — any other algorithm will outperform FIFO on non-uniform access patterns

## Comparison Matrix

| Algorithm | Scan Resistance | Frequency Awareness | Memory Overhead | Throughput | Tuning Complexity |
| --- | --- | --- | --- | --- | --- |
| LRU | None | None | Low | High | None |
| LFU | None | High (no decay) | Medium | Medium | None |
| TinyLFU | Medium | High (with decay) | Low | Medium | None |
| W-TinyLFU | High | High (with decay) | Low | Medium | None |
| S3FIFO | High | Low | Medium | Very High | None |
| ARC | High | Medium | High (2x) | Medium | None (self-tuning) |
| TwoQueue | Medium | Medium | Medium | Medium | Low |
| SIEVE | Medium | None | Very Low | High | None |
| FIFO | None | None | Very Low | Very High | None |

## Measuring Hit Rate

Enable Prometheus metrics and check hit ratio to validate your algorithm choice:

```go
cache := hot.NewHotCache[string, *User](hot.WTinyLFU, 10_000).
    WithTTL(5 * time.Minute).
    WithPrometheusMetrics("user_cache").
    WithJanitor().
    Build()
defer cache.StopJanitor()

prometheus.MustRegister(cache)
```

Key PromQL queries:

```promql
# Hit ratio (target: >80%)
rate(hot_cache_hit_count{cache="user_cache"}[5m]) /
rate(hot_cache_get_count{cache="user_cache"}[5m])

# Eviction rate (high = cache too small)
rate(hot_cache_eviction_count{cache="user_cache"}[5m])
```

If hit rate is below your SLO: increase capacity first, then try a different algorithm.

## Switching Algorithms

Changing the algorithm is a one-line change — the rest of the builder chain stays identical:

```go
// Before
cache := hot.NewHotCache[string, *User](hot.LRU, 10_000).
    WithTTL(5 * time.Minute).
    WithJanitor().
    Build()

// After — only the first argument changes
cache := hot.NewHotCache[string, *User](hot.WTinyLFU, 10_000).
    WithTTL(5 * time.Minute).
    WithJanitor().
    Build()
```
