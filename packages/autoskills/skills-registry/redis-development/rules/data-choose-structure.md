---
title: Choose the Right Data Structure
impact: HIGH
impactDescription: Optimal memory usage and operation performance
tags: data-structures, strings, hashes, sets, lists, sorted-sets, json, streams, vector-sets
description: Choose the Right Data Structure
alwaysApply: true
---

## Choose the Right Data Structure

Selecting the appropriate Redis data type for your use case is fundamental to performance and memory efficiency.

| Use Case | Recommended Type | Why |
|----------|------------------|-----|
| Simple values, counters | String | Fast, atomic operations |
| Object with fields | Hash | Memory efficient, partial updates, field-level expiration |
| Queue, recent items | List | O(1) push/pop at ends |
| Unique items, membership | Set | O(1) add/remove/check |
| Rankings, ranges | Sorted Set | Score-based ordering |
| Nested/hierarchical data | JSON | Path queries, nested structures, geospatial indexing with RQE |
| Event logs, messaging | Stream | Persistent, consumer groups |
| Similarity search | Vector Set | Native vector storage with built-in HNSW indexing |

**Incorrect:** Using strings for everything.

**Python** (redis-py):
```python
# Storing object as JSON string loses atomic field updates
redis.set("user:1001", json.dumps({"name": "Alice", "email": "alice@example.com"}))

# To update email, must fetch, parse, modify, and rewrite entire object
user = json.loads(redis.get("user:1001"))
user["email"] = "new@example.com"
redis.set("user:1001", json.dumps(user))
```

**Java** (Jedis):
```java
// Bad: Storing as delimited string requires manual parsing
jedis.set("bicycle", "Deimos;Ergonom;Enduro bikes;4972");
String bike = jedis.get("bicycle");
String[] fields = bike.split(";");
String model = fields[0];  // Fragile and error-prone
```

**Correct:** Use Hash for objects with fields.

**Python** (redis-py):
```python
# Hash allows atomic field updates
redis.hset("user:1001", mapping={"name": "Alice", "email": "alice@example.com"})

# Update single field without touching others
redis.hset("user:1001", "email", "new@example.com")
```

**Java** (Jedis):
```java
import java.util.Map;
import java.util.HashMap;

// Good: Hash models properties naturally
Map<String, String> hashFields = new HashMap<>();
hashFields.put("model", "Deimos");
hashFields.put("brand", "Ergonom");
hashFields.put("type", "Enduro bikes");
hashFields.put("price", "4972");

jedis.hset("bicycle", hashFields);

// Read individual field
String model = jedis.hget("bicycle", "model");
```

Reference: [Choosing the Right Data Type](https://redis.io/docs/latest/develop/data-types/compare-data-types/)
