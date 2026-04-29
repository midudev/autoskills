---
title: Choose JSON vs Hash vs String Appropriately
impact: MEDIUM
impactDescription: Optimal data model for your use case
tags: json, hash, string, data-structures, documents
description: Choose JSON vs Hash vs String Appropriately
alwaysApply: true
---

## Choose JSON vs Hash vs String Appropriately

Redis offers three ways to store structured data: JSON, Hash, and serialized strings. Each has distinct trade-offs around atomic partial operations and indexability.

| Feature | JSON | Hash | String (serialized JSON) |
|---------|------|------|--------------------------|
| **Structure** | Nested objects and arrays | Flat key-value pairs | Any structure |
| **Atomic partial reads** | Yes (`$.field`) | Yes (`HGET`) | No (must fetch entire value) |
| **Atomic partial writes** | Yes (`JSON.SET $.field`) | Yes (`HSET`) | No (must rewrite entire value) |
| **RQE indexing** | Yes | Yes | No |
| **Geospatial indexing** | Yes | Yes | No |
| **Memory efficiency** | Higher overhead | More efficient | Most compact |
| **Field-level expiration** | No | Yes (HEXPIRE) | No |

**When to use each:**
- **JSON**: Nested structures with atomic partial updates and indexing needs
- **Hash**: Flat objects with atomic field access, field-level expiration, or memory efficiency
- **String**: Simple caching where you always read/write the entire object and don't need indexing

**Correct:** Use JSON for nested structures with atomic partial updates.

**Python** (redis-py):
```python
# JSON supports nested structures and atomic deep updates
redis.json().set("user:1001", "$", {
    "name": "Alice",
    "preferences": {"theme": "dark", "notifications": True}
})

# Atomic update of nested field - no read-modify-write needed
redis.json().set("user:1001", "$.preferences.theme", "light")
```

**Java** (Jedis):
```java
import redis.clients.jedis.UnifiedJedis;
import redis.clients.jedis.json.Path2;
import org.json.JSONObject;

try (UnifiedJedis jedis = new UnifiedJedis("redis://localhost:6379")) {
    JSONObject user = new JSONObject();
    user.put("name", "Alice");
    user.put("preferences", new JSONObject().put("theme", "dark"));

    jedis.jsonSet("user:1001", new Path2("$"), user);

    // Atomic update of nested field
    jedis.jsonSet("user:1001", new Path2("$.preferences.theme"), "light");
}
```

**Correct:** Use Hash for flat objects with atomic field access.

**Python** (redis-py):
```python
# Hash is efficient for flat data with atomic field operations
redis.hset("session:abc", mapping={
    "user_id": "1001",
    "created_at": "2024-01-01",
    "ip": "192.168.1.1"
})

# Atomic field read and update
ip = redis.hget("session:abc", "ip")
redis.hset("session:abc", "ip", "10.0.0.1")
```

**Correct:** Use String for simple caching without partial updates.

**Python** (redis-py):
```python
import json

# String is fine when you always read/write the entire object
# and don't need indexing or partial updates
config = {"feature_flags": {"dark_mode": True}, "version": "1.0"}
redis.set("config:app", json.dumps(config), ex=3600)

# Must fetch and parse entire object
config = json.loads(redis.get("config:app"))
```

**Incorrect:** Using String when you need atomic partial updates.

**Python** (redis-py):
```python
import json

# BAD: Must fetch, parse, modify, serialize, and rewrite entire object
data = json.loads(redis.get("user:1001"))
data["preferences"]["theme"] = "light"  # Not atomic!
redis.set("user:1001", json.dumps(data))
# Another client could have modified the object between GET and SET
```

Reference: [Data Type Comparison](https://redis.io/docs/latest/develop/data-types/compare-data-types/#documents)
