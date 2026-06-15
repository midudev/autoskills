# Production Patterns

## Stale-While-Revalidate

Return stale data immediately while refreshing in the background. Two time thresholds:

1. **TTL** — after this, entries become "stale" and trigger async background refresh via loaders
2. **Stale duration** — after TTL + stale, entries are hard-expired and removed

```go
refreshLoader := func(keys []string) (map[string]*Config, error) {
    return fetchConfigsFromDB(keys)
}

cache := hot.NewHotCache[string, *Config](hot.WTinyLFU, 1_000).
    WithTTL(5 * time.Minute).                              // stale after 5min
    WithRevalidation(1 * time.Minute, refreshLoader).       // hard-expire after 6min total
    WithRevalidationErrorPolicy(hot.KeepOnError).           // keep stale value if refresh fails
    WithJitter(0.1, 30*time.Second).                        // spread expirations
    WithJanitor().
    Build()
defer cache.StopJanitor()
```

**Timeline for an entry set at T=0 with this config:**

- T=0 to T=5min: fresh — returned directly
- T=5min to T=6min: stale — returned immediately, background refresh triggered
- T>6min: expired — removed, next `Get()` blocks on loader

**Error policies:**

- `hot.KeepOnError` — if background refresh fails, keep the stale value until hard expiry
- `hot.DropOnError` — if refresh fails, drop the entry immediately

Use `KeepOnError` when stale data is better than no data (config caches, product catalogs). Use `DropOnError` when correctness matters more than availability.

## Sharding

Split the cache into N independent segments to reduce lock contention under high concurrency:

```go
cache := hot.NewHotCache[string, *User](hot.WTinyLFU, 100_000).
    WithTTL(5 * time.Minute).
    WithSharding(16, func(key string) uint64 {
        h := fnv.New64a()
        h.Write([]byte(key))
        return h.Sum64()
    }).
    WithJanitor().
    Build()
defer cache.StopJanitor()
```

**Sizing guidance:**

- Use powers of 2 (4, 8, 16, 32) for optimal hash distribution
- Rule of thumb: shard count ~= number of CPU cores for high-contention workloads
- Each shard gets `capacity / shards` items
- Over-sharding (>64 shards) adds overhead without benefit

## Missing Key Caching (Negative Caching)

Prevents repeated loader calls for keys that don't exist in the source:

### Dedicated missing cache (recommended)

Independent eviction algorithm and capacity — gives fine-grained control:

```go
cache := hot.NewHotCache[string, *User](hot.WTinyLFU, 100_000).
    WithTTL(1 * time.Hour).
    WithMissingCache(hot.LFU, 10_000).  // separate LFU cache for missing keys
    WithLoaders(userLoader).
    WithJanitor().
    Build()
defer cache.StopJanitor()
```

### Shared missing cache

Missing entries stored in the main cache — simpler but uses main cache capacity:

```go
cache := hot.NewHotCache[string, *User](hot.WTinyLFU, 100_000).
    WithTTL(1 * time.Hour).
    WithMissingSharedCache().
    WithLoaders(userLoader).
    WithJanitor().
    Build()
defer cache.StopJanitor()
```

### Manual missing key marking

```go
// Mark individual key as missing
cache.SetMissing("nonexistent-user")
cache.SetMissingWithTTL("temp-missing", 5*time.Minute)

// Batch mark missing
cache.SetMissingMany([]string{"user:404", "user:405"})
```

**Important:** `Keys()`, `Values()`, `All()` exclude missing entries — they only return real values.

## Loader Chains

Multiple loaders execute sequentially for L1/L2 cache patterns:

```go
redisLoader := func(keys []string) (map[string]*User, error) {
    return redis.MGet(ctx, keys...)
}

dbLoader := func(keys []string) (map[string]*User, error) {
    return db.GetUsersByIDs(ctx, keys)
}

cache := hot.NewHotCache[string, *User](hot.WTinyLFU, 10_000).
    WithTTL(5 * time.Minute).
    WithLoaders(redisLoader, dbLoader).  // Redis first, then DB for remaining
    WithJanitor().
    Build()
defer cache.StopJanitor()
```

**Chain behavior:**

- `redisLoader` called first with all missing keys
- `dbLoader` called only with keys NOT found by `redisLoader`
- If both return the same key, `dbLoader`'s value wins (later overwrites earlier)
- Any error stops the chain — partial results from earlier loaders are discarded

## Copy-on-Read / Copy-on-Write

Required when cached values are mutable (pointers, slices, maps):

```go
cache := hot.NewHotCache[string, *User](hot.WTinyLFU, 10_000).
    WithTTL(5 * time.Minute).
    WithCopyOnRead(func(u *User) *User {
        copy := *u
        return &copy
    }).
    WithCopyOnWrite(func(u *User) *User {
        copy := *u
        return &copy
    }).
    WithJanitor().
    Build()
defer cache.StopJanitor()
```

- **CopyOnRead** — clones at retrieval: callers get independent copies, mutations don't affect cache
- **CopyOnWrite** — clones at storage: cache holds a snapshot, external mutations to the original don't corrupt cached value
- Use both when callers read and write concurrently. Use only one when the mutation direction is known.

## Prometheus Monitoring

### Setup

```go
cache := hot.NewHotCache[string, *User](hot.WTinyLFU, 10_000).
    WithTTL(5 * time.Minute).
    WithPrometheusMetrics("user_cache").
    WithJanitor().
    Build()
defer cache.StopJanitor()

prometheus.MustRegister(cache)
```

### Key PromQL Queries

```promql
# Hit ratio (target: >80%)
rate(hot_cache_hit_count{cache="user_cache"}[5m]) /
rate(hot_cache_get_count{cache="user_cache"}[5m])

# Eviction rate (high = cache too small or TTL too short)
rate(hot_cache_eviction_count{cache="user_cache"}[5m])

# Cache size vs capacity
hot_cache_len{cache="user_cache"} / hot_cache_capacity{cache="user_cache"}
```

**Alerts to consider:**

- Hit rate drops below 70% for >5 minutes — cache may be undersized
- Eviction rate spikes — working set exceeds capacity
- Cache size near capacity — consider increasing capacity or reviewing TTLs

## Warm-Up on Startup

Pre-populate the cache before serving traffic:

```go
cache := hot.NewHotCache[string, *User](hot.WTinyLFU, 10_000).
    WithTTL(1 * time.Hour).
    WithWarmUp(func() (map[string]*User, []string, error) {
        users, err := db.GetFrequentUsers(ctx)
        if err != nil {
            return nil, nil, err
        }
        missingKeys := []string{"deleted-user-1", "deleted-user-2"}
        return users, missingKeys, nil  // values + known missing keys + error
    }).
    WithJanitor().
    Build()
defer cache.StopJanitor()
```

Use `WithWarmUpWithTimeout(30*time.Second, fn)` to bound startup time.

## Graceful Shutdown

Always stop the janitor goroutine before exit:

```go
cache := hot.NewHotCache[string, *User](hot.WTinyLFU, 10_000).
    WithTTL(5 * time.Minute).
    WithJanitor().
    Build()
defer cache.StopJanitor()  // clean up background goroutine
```

In applications with graceful shutdown orchestration, call `cache.StopJanitor()` during the shutdown phase alongside other resource cleanup.
