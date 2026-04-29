---
title: Use Connection Pooling or Multiplexing
impact: HIGH
impactDescription: Reduces connection overhead by 10x or more
tags: connections, pooling, multiplexing, performance
description: Use Connection Pooling or Multiplexing
alwaysApply: true
---

## Use Connection Pooling or Multiplexing

Reuse connections via a pool or multiplexing instead of creating new connections per request.

**Correct:** Use a connection pool.

**Python** (redis-py):
```python
import redis

# Good: Connection pool - reuses existing connections
pool = redis.ConnectionPool(host='localhost', port=6379, max_connections=50)
r = redis.Redis(connection_pool=pool)
```

**Java** (Jedis):
```java
import redis.clients.jedis.JedisPooled;

// JedisPooled manages a connection pool internally
try (JedisPooled jedis = new JedisPooled("redis://localhost:6379")) {
    jedis.set("testKey", "testValue");
}
```

**Correct:** Use multiplexing (Lettuce, NRedisStack).

```java
// Lettuce uses multiplexing by default - single connection handles all traffic
RedisClient client = RedisClient.create("redis://localhost:6379");
StatefulRedisConnection<String, String> connection = client.connect();

// All commands share the single connection efficiently
connection.sync().set("key", "value");
```

**Incorrect:** Creating new connections per request.

**Python** (redis-py):
```python
# Bad: New connection every time
def get_user(user_id):
    r = redis.Redis(host='localhost', port=6379)  # Don't do this
    return r.get(f"user:{user_id}")
```

**Java** (Jedis):
```java
// Bad: Creating new client per request
public String getUser(String userId) {
    try (UnifiedJedis jedis = new UnifiedJedis("redis://localhost:6379")) {
        return jedis.get("user:" + userId);  // Don't do this
    }
}
```

**Pooling vs Multiplexing:**
- **Pooling**: Multiple connections shared across requests (redis-py, Jedis, go-redis)
- **Multiplexing**: Single connection handles all traffic (NRedisStack, Lettuce)
- Multiplexing cannot support blocking commands (BLPOP, etc.) as they would stall all callers

Reference: [Connection Pools and Multiplexing](https://redis.io/docs/latest/develop/clients/pools-and-muxing/)
