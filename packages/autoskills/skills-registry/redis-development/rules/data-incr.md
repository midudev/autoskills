---
title: Use INCR for Atomic Counters
impact: MEDIUM
impactDescription: Atomic increment avoids race conditions
tags: incr, counters, atomic, performance
description: Use INCR for Atomic Counters
alwaysApply: true
---

## Use INCR for Atomic Counters

If a string represents an integer value, use the `INCR` command to increment the number directly. The increment is atomic and always returns the new value. Use `INCRBY` to increment by any integer (positive or negative). This is more efficient and race-condition-free than reading, incrementing in code, and writing back.

**Correct:** Use INCR/INCRBY for atomic counter updates.

**Python** (redis-py):
```python
import redis

client = redis.Redis(host='localhost', port=6379)

# Initialize counter
client.set("counter", "0")

# Atomic increment - returns new value
new_value = client.incr("counter")  # Returns 1

# Increment by specific amount
new_value = client.incrby("counter", 10)  # Returns 11
```

**Java** (Jedis):
```java
import redis.clients.jedis.UnifiedJedis;

try (UnifiedJedis jedis = new UnifiedJedis("redis://localhost:6379")) {
    jedis.set("counter", "0");
    
    // Atomic increment - returns new value
    long newValue = jedis.incr("counter");  // Returns 1
    
    // Increment by specific amount
    newValue = jedis.incrBy("counter", 10);  // Returns 11
}
```

**Incorrect:** Read-modify-write pattern creates race conditions.

**Python** (redis-py):
```python
import redis

client = redis.Redis(host='localhost', port=6379)

client.set("counter", "0")

# BAD: Race condition - another client could modify between GET and SET
curr_value = int(client.get("counter"))
client.set("counter", str(curr_value + 1))  # Not atomic!
```

**Java** (Jedis):
```java
import redis.clients.jedis.UnifiedJedis;

try (UnifiedJedis jedis = new UnifiedJedis("redis://localhost:6379")) {
    jedis.set("counter", "0");
    
    // BAD: Race condition between GET and SET
    long currValue = Long.parseLong(jedis.get("counter"));
    jedis.set("counter", Long.toString(currValue + 1));  // Not atomic!
}
```

Reference: [INCR command](https://redis.io/docs/latest/commands/incr/)

