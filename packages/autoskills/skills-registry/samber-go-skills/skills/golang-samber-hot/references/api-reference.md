# API Reference

## Constructor

```go
hot.NewHotCache[K comparable, V any](algorithm hot.EvictionAlgorithm, capacity int) *HotCacheBuilder[K, V]
```

**Algorithm constants:**

| Constant       | Algorithm                              |
| -------------- | -------------------------------------- |
| `hot.LRU`      | Least Recently Used                    |
| `hot.LFU`      | Least Frequently Used                  |
| `hot.TinyLFU`  | TinyLFU with frequency decay           |
| `hot.WTinyLFU` | Weighted TinyLFU (recommended default) |
| `hot.S3FIFO`   | Segmented Small-Size FIFO              |
| `hot.ARC`      | Adaptive Replacement Cache             |
| `hot.TwoQueue` | Two-Queue                              |
| `hot.SIEVE`    | SIEVE eviction                         |
| `hot.FIFO`     | First In, First Out                    |

## Builder Methods

Call these on the builder returned by `NewHotCache()`, then finalize with `.Build()`.

| Method | Description |
| --- | --- |
| `WithTTL(ttl time.Duration)` | Default expiration for all entries |
| `WithJitter(lambda float64, upperBound time.Duration)` | Randomize TTL by +/-lambda (capped at upperBound) to prevent thundering herd |
| `WithJanitor()` | Start background goroutine to evict expired entries. Mutually exclusive with `WithoutLocking()` |
| `WithLoaders(loaders ...Loader[K, V])` | Chain of loader functions for cache misses. Execute sequentially; later loaders receive only unmapped keys |
| `WithRevalidation(stale time.Duration, loaders ...Loader[K, V])` | Enable stale-while-revalidate. After TTL, entries become stale and trigger async refresh. Hard-expired after `stale` duration |
| `WithRevalidationErrorPolicy(policy)` | `hot.KeepOnError` (keep stale value) or `hot.DropOnError` (drop on refresh failure) |
| `WithMissingCache(algorithm, capacity)` | Dedicated cache for missing keys (independent eviction) |
| `WithMissingSharedCache()` | Store missing keys in the main cache |
| `WithSharding(shards uint64, hasher Hasher[K])` | Split into N shards to reduce lock contention. Use powers of 2 |
| `WithCopyOnRead(fn func(V) V)` | Clone values on retrieval to prevent external mutation |
| `WithCopyOnWrite(fn func(V) V)` | Clone values on storage to capture snapshots |
| `WithPrometheusMetrics(cacheName string)` | Enable Prometheus metrics collection |
| `WithEvictionCallback(fn func(K, V))` | Synchronous callback on eviction |
| `WithoutLocking()` | Disable mutexes. Single-goroutine access only. Mutually exclusive with `WithJanitor()` |
| `WithWarmUp(fn func() (map[K]V, []K, error))` | Pre-populate cache on build. Returns values + missing keys + error |
| `WithWarmUpWithTimeout(timeout, fn)` | Same as WarmUp with timeout protection |
| `Build()` | Finalize and return `*HotCache[K, V]` |

## Read Operations

| Method | Signature | Behavior |
| --- | --- | --- |
| `Get` | `(key K) (V, bool, error)` | Value, found, loader error. Triggers loaders on miss |
| `GetWithLoaders` | `(key K, loaders ...Loader[K, V]) (V, bool, error)` | Per-call loader override |
| `GetMany` | `(keys []K) (map[K]V, []K, error)` | Batch get. Returns found map + missing keys + error |
| `GetManyWithLoaders` | `(keys []K, loaders ...Loader[K, V]) (map[K]V, []K, error)` | Batch with loader override |
| `MustGet` | `(key K) (V, bool)` | Panics on loader error |
| `MustGetWithLoaders` | `(key K, loaders ...Loader[K, V]) (V, bool)` | Panics on loader error |
| `MustGetMany` | `(keys []K) (map[K]V, []K)` | Panics on error |
| `MustGetManyWithLoaders` | `(keys []K, loaders ...Loader[K, V]) (map[K]V, []K)` | Panics on error |
| `Peek` | `(key K) (V, bool)` | Read without side effects: no loaders, ignores expiration |
| `PeekMany` | `(keys []K) (map[K]V, []K)` | Batch peek |
| `Has` | `(key K) bool` | Key existence check without triggering loaders |
| `HasMany` | `(keys []K) map[K]bool` | Batch existence check |
| `Keys` | `() []K` | All keys with values (excludes missing entries) |
| `Values` | `() []V` | All values |
| `All` | `() map[K]V` | Key-value snapshot |
| `Range` | `(fn func(K, V) bool)` | Iterate. Return false to stop |
| `Len` | `() int` | Total item count |
| `Capacity` | `() (int, int)` | Main capacity, missing cache capacity |
| `Algorithm` | `() (string, string)` | Main algorithm name, missing algorithm name |

## Write Operations

| Method | Signature | Description |
| --- | --- | --- |
| `Set` | `(key K, value V)` | Set with default TTL |
| `SetWithTTL` | `(key K, value V, ttl time.Duration)` | Set with custom TTL |
| `SetMany` | `(items map[K]V)` | Batch set with default TTL |
| `SetManyWithTTL` | `(items map[K]V, ttl time.Duration)` | Batch set with custom TTL |
| `SetMissing` | `(key K)` | Mark key as non-existent. Requires `WithMissingCache()` or `WithMissingSharedCache()` |
| `SetMissingWithTTL` | `(key K, ttl time.Duration)` | Mark missing with custom TTL |
| `SetMissingMany` | `(keys []K)` | Batch mark as missing |
| `SetMissingManyWithTTL` | `(keys []K, ttl time.Duration)` | Batch mark missing with custom TTL |

## Maintenance Operations

| Method | Signature | Description |
| --- | --- | --- |
| `Delete` | `(key K) bool` | Remove single key. Returns true if existed |
| `DeleteMany` | `(keys []K) map[K]bool` | Batch delete. Returns existence map |
| `Purge` | `()` | Clear all entries |
| `WarmUp` | `(fn func() (map[K]V, []K, error)) error` | Pre-populate cache at runtime |
| `Janitor` | `()` | Start background expiration cleanup |
| `StopJanitor` | `()` | Stop background cleanup goroutine |

## Loader Type

```go
type Loader[K comparable, V any] func(keys []K) (found map[K]V, err error)
```

**Chain semantics:**

- Loaders execute sequentially in provided order
- Each loader receives only **unmapped keys** from previous loaders
- Later loader values **overwrite** earlier values for the same key
- Any loader error stops the chain and returns `(nil, err)`
- Built-in singleflight deduplication: concurrent `Get()` calls for the same key share one loader invocation

## Hasher Type (for Sharding)

```go
type Hasher[K any] func(key K) uint64
```

## Prometheus Integration

`*HotCache` implements `prometheus.Collector`. Register it to expose metrics:

```go
cache := hot.NewHotCache[string, *User](hot.WTinyLFU, 10_000).
    WithPrometheusMetrics("user_cache").
    Build()

prometheus.MustRegister(cache)
```
