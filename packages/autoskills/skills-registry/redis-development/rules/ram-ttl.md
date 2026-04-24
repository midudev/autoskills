---
title: Set TTL on Cache Keys
impact: HIGH
impactDescription: Prevents unbounded memory growth
tags: ttl, expiration, cache, memory
description: Set TTL on Cache Keys
alwaysApply: true
---

## Set TTL on Cache Keys

Always set expiration times on cache keys to prevent unbounded memory growth.

**Correct:** Set TTL at write time.

**Python** (redis-py):
```python
# Good: TTL set atomically with the value
redis.setex("cache:user:1001", 3600, user_json)

# Good: For hashes, set TTL after
redis.hset("session:abc", mapping=session_data)
redis.expire("session:abc", 1800)
```

**Java** (Jedis):
```java
import redis.clients.jedis.params.SetParams;

// Good: TTL set atomically with SetParams
jedis.set("cachedItem:1", "fe8c357903ac9", new SetParams().ex(120));
```

**Incorrect:** Forgetting TTL on cache keys.

**Python** (redis-py):
```python
# Risk: This key may live forever
redis.set("cache:user:1001", user_json)
```

**Java** (Jedis):
```java
// Risk: This key may live forever
jedis.set("cachedItem:1", "fe8c357903ac9");
```

**TTL strategies:**
- Cache data: 1-24 hours depending on freshness requirements
- Sessions: 30 minutes to 24 hours
- Rate limiting: Seconds to minutes
- Temporary locks: Seconds with automatic release

Reference: [Redis EXPIRE](https://redis.io/commands/expire/)

