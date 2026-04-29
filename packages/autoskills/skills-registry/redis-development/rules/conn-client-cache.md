---
title: Use Client-Side Caching for Frequently Read Data
impact: HIGH
impactDescription: Reduces network round-trips for repeated reads
tags: caching, performance, client-side, tracking
description: Use Client-Side Caching for Frequently Read Data
alwaysApply: true
---

## Use Client-Side Caching for Frequently Read Data

Use a connection with client-side caching enabled for any data that will be read frequently but written only occasionally. Client-side caching avoids contacting the server for repeated access to data that has recently been read, reducing network traffic and improving performance.

**Correct:** Enable client-side caching with RESP3 protocol for frequently accessed data.

**Python** (redis-py):
```python
import redis

# Enable client-side caching with RESP3
client = redis.Redis(
    host='localhost',
    port=6379,
    protocol=3,  # RESP3 required for client-side caching
    cache_config=redis.CacheConfig(max_size=1000)
)

# Cached reads avoid server round-trips
value = client.get("frequently:read:key")
```

**Java** (Jedis):
```java
import redis.clients.jedis.DefaultJedisClientConfig;
import redis.clients.jedis.UnifiedJedis;
import redis.clients.jedis.HostAndPort;
import redis.clients.jedis.CacheConfig;

HostAndPort endpoint = new HostAndPort("localhost", 6379);

DefaultJedisClientConfig config = DefaultJedisClientConfig
    .builder()
    .password("secretPassword")
    .protocol(RedisProtocol.RESP3)
    .build();

CacheConfig cacheConfig = CacheConfig.builder().maxSize(1000).build();

UnifiedJedis client = new UnifiedJedis(endpoint, config, cacheConfig);
```

**When to use:**
- Configuration data read frequently, updated rarely
- User session data accessed on every request
- Feature flags or settings checked repeatedly
- Any read-heavy workload with low write frequency

**When NOT needed:**
- Data that changes frequently (cache invalidation overhead outweighs benefits)
- Write-heavy workloads
- Simple applications where network latency is not a bottleneck
- When you need guaranteed real-time consistency

**Trade-offs:**
- Adds memory overhead on the client
- Requires RESP3 protocol
- Cache invalidation adds complexity for frequently changing data

Reference: [Client-side caching](https://redis.io/docs/latest/develop/clients/client-side-caching/)

