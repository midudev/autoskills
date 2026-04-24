# Object caching

Use this file when profiling indicates repeated queries or low cache hit rate.

## Concepts

- Default WP object cache is per-request memory only.
- A persistent object cache “drop-in” (`wp-content/object-cache.php`) can persist cache across requests.

WP-CLI cache commands:

- https://wpcli.dev/docs/cache

Guardrails:

- `wp cache flush` can impact all sites in multisite and cause load spikes:
  - https://wpcli.dev/docs/cache/flush

## Fix patterns

- Cache expensive computed results (transients or object cache) with explicit invalidation.
- Avoid unbounded caches (set expirations or implement invalidation hooks).
- If adding a persistent object cache, coordinate with infra (Redis/Memcached) and test cache flush behavior.

