---
title: Use Hash Tags for Multi-Key Operations
impact: HIGH
impactDescription: Enables multi-key operations in Redis Cluster
tags: cluster, hash-tags, keys, sharding, multi-key
description: Use Hash Tags for Multi-Key Operations
alwaysApply: true
---

## Use Hash Tags for Multi-Key Operations

In Redis Cluster, keys are distributed across slots based on their hash. Use hash tags to ensure keys that must be used together in [multi-key operations](https://redis.io/docs/latest/operate/rs/databases/durability-ha/clustering/#multikey-operations) are on the same slot.

**Correct:** Use hash tags for keys used in multi-key operations.

**Python** (redis-py):
```python
# These keys go to the same slot because {user:1001} is the hash tag
redis.set("{user:1001}:profile", "...")
redis.set("{user:1001}:settings", "...")
redis.set("{user:1001}:cart", "...")

# Now you can use transactions and pipelines
pipe = redis.pipeline()
pipe.get("{user:1001}:profile")
pipe.get("{user:1001}:settings")
pipe.execute()

# Multi-key commands also work
redis.lmove("{user:1001}:pending", "{user:1001}:processed", "LEFT", "RIGHT")
```

**Java** (Jedis):
```java
import redis.clients.jedis.UnifiedJedis;
import java.util.Set;

try (UnifiedJedis jedis = new UnifiedJedis("redis://localhost:6379")) {
    // Hash tags ensure keys go to the same slot
    jedis.sadd("{bikes:racing}:france", "bike:1", "bike:2", "bike:3");
    jedis.sadd("{bikes:racing}:usa", "bike:1", "bike:4");

    // Multi-key operation works because of matching hash tags
    Set<String> result = jedis.sdiff("{bikes:racing}:france", "{bikes:racing}:usa");
}
```

**Incorrect:** Keys without hash tags that need multi-key operations.

**Python** (redis-py):
```python
# Bad: These may be on different slots
redis.set("user:1001:profile", "...")  # No hash tag
redis.set("user:1001:settings", "...")

# This will fail in cluster mode
pipe = redis.pipeline()
pipe.get("user:1001:profile")
pipe.get("user:1001:settings")
pipe.execute()  # CROSSSLOT error
```

**Java** (Jedis):
```java
// Bad: No hash tags - keys may be on different slots
jedis.sadd("bikes:racing:france", "bike:1", "bike:2", "bike:3");
jedis.sadd("bikes:racing:usa", "bike:1", "bike:4");

// This will fail in cluster mode with CROSSSLOT error
Set<String> result = jedis.sdiff("bikes:racing:france", "bikes:racing:usa");
```

**Hash tag rules:**
- Only the part between `{` and `}` is hashed for slot assignment
- Use meaningful identifiers like `{user:1001}` not just `{1001}` to avoid unrelated keys (e.g., `purchase:{1001}`, `employee:{1001}`) saturating the same slot
- Use hash tags only where multi-key operations are needed, not as a general habit

Reference: [Redis Cluster Key Distribution](https://redis.io/docs/latest/operate/oss_and_stack/reference/cluster-spec/#hash-tags)
