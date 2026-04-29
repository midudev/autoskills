---
title: Use Hash Field Expiration for Per-Field TTL
impact: MEDIUM
impactDescription: Fine-grained expiration without managing timers
tags: hash, expiration, ttl, hexpire
description: Use Hash Field Expiration for Per-Field TTL
alwaysApply: true
---

## Use Hash Field Expiration for Per-Field TTL

Use hash field expiration (Redis 7.4+) to delete individual fields automatically from a hash after a specific period of time. This is useful for caching scenarios where different fields have different lifetimes, and is easier than managing expiration from your own code.

**Correct:** Use HEXPIRE to set per-field TTL on hash fields.

**Python** (redis-py):
```python
import redis

client = redis.Redis(host='localhost', port=6379)

# Set hash fields
client.hset("sensor:sensor1", mapping={
    "air_quality": "256",
    "battery_level": "89"
})

# Set 60-second TTL on specific fields (Redis 7.4+)
client.hexpire("sensor:sensor1", 60, "air_quality", "battery_level")
```

**Java** (Jedis):
```java
import redis.clients.jedis.UnifiedJedis;
import java.util.Map;
import java.util.HashMap;

try (UnifiedJedis jedis = new UnifiedJedis("redis://localhost:6379")) {
    Map<String, String> hashFields = new HashMap<>();
    hashFields.put("air_quality", "256");
    hashFields.put("battery_level", "89");

    jedis.hset("sensor:sensor1", hashFields);
    
    // Set 60-second TTL on specific fields (Redis 7.4+)
    jedis.hexpire("sensor:sensor1", 60, "air_quality", "battery_level");
}
```

**When to use:**
- Sensor data or metrics that become stale after a period
- Session attributes where different fields have different lifetimes
- Cached values within a hash that should auto-expire independently
- Temporary flags or tokens stored alongside persistent data

**When NOT needed:**
- Persistent user profiles or configuration
- Data where the entire hash should expire together (use `EXPIRE` on the key instead)
- Fields managed by application logic with explicit deletion

Reference: [HEXPIRE command](https://redis.io/docs/latest/commands/hexpire/)

