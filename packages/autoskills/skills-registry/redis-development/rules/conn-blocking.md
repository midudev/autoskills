---
title: Avoid Slow Commands in Production
impact: HIGH
impactDescription: Prevents Redis from becoming unresponsive
tags: slow-commands, keys, scan, performance
description: Avoid Slow Commands in Production
alwaysApply: true
---

## Avoid Slow Commands in Production

Some Redis commands are slow because they scan large datasets. Use incremental alternatives to avoid blocking the server.

| Avoid | Use Instead |
|-------|-------------|
| `KEYS *` | `SCAN` with cursor |
| `SMEMBERS` on large sets | `SSCAN` |
| `HGETALL` on large hashes | `HSCAN` |
| `LRANGE 0 -1` on large lists | Paginate with `LRANGE 0 100` |

**Correct:** Use SCAN for iteration.

**Python** (redis-py):
```python
# Good: Non-blocking iteration
cursor = 0
while True:
    cursor, keys = redis.scan(cursor, match="user:*", count=100)
    for key in keys:
        process(key)
    if cursor == 0:
        break
```

**Java** (Jedis):
```java
import redis.clients.jedis.ScanIteration;
import redis.clients.jedis.UnifiedJedis;
import java.util.List;

try (UnifiedJedis jedis = new UnifiedJedis("redis://localhost:6379")) {
    // ScanIteration manages the cursor automatically
    ScanIteration scan = jedis.scanIteration(10, "user:*", "hash");

    while (!scan.isIterationCompleted()) {
        List<String> result = scan.nextBatch().getResult();
        for (String key : result) {
            process(key);
        }
    }
}
```

**Incorrect:** Using KEYS in production.

**Python** (redis-py):
```python
# Bad: Scans all keys, slow on large datasets
keys = redis.keys("user:*")
```

**Java** (Jedis):
```java
// Bad: Scans all keys, blocks the server
Set<String> result = jedis.keys("*");
```

**Note:** Truly blocking commands (like `BLPOP`, `BRPOP`, `BLMOVE`) that wait indefinitely for data are appropriate for some use cases like job queues, but should be used with timeouts.

```python
# Blocking pop with timeout - appropriate for queue consumers
result = redis.blpop("task_queue", timeout=5)
```

Reference: [Redis SCAN](https://redis.io/docs/latest/commands/scan/)
