---
title: Use Pipelining for Bulk Operations
impact: HIGH
impactDescription: Reduces round trips, 5-10x faster for batch operations
tags: pipelining, batch, performance, round-trips
description: Use Pipelining for Bulk Operations
alwaysApply: true
---

## Use Pipelining for Bulk Operations

Batch multiple commands into a single round trip to reduce network latency.

**Correct:** Use pipeline for multiple commands.

**Python** (redis-py):
```python
# Good: Single round trip for multiple commands
pipe = redis.pipeline()
for user_id in user_ids:
    pipe.get(f"user:{user_id}")
results = pipe.execute()
```

**Java** (Jedis):
```java
import redis.clients.jedis.Pipeline;

// Good: Buffer commands and send as single batch
Pipeline pipe = (Pipeline) jedis.pipelined();

pipe.set("person:1:name", "Alex");
pipe.set("person:1:rank", "Captain");
pipe.set("person:1:serial", "AB1234");

pipe.sync();
```

**Incorrect:** Sequential commands in a loop.

**Python** (redis-py):
```python
# Bad: N round trips
results = []
for user_id in user_ids:
    results.append(redis.get(f"user:{user_id}"))
```

**Java** (Jedis):
```java
// Bad: 3 separate round trips
jedis.set("person:1:name", "Alex");
jedis.set("person:1:rank", "Captain");
jedis.set("person:1:serial", "AB1234");
```

Reference: [Redis Pipelining](https://redis.io/docs/latest/develop/use/pipelining/)

