---
title: Use JSON Paths for Partial Updates
impact: MEDIUM
impactDescription: Avoids fetching and rewriting entire documents
tags: json, partial-updates, paths, atomic
description: Use JSON Paths for Partial Updates
alwaysApply: true
---

## Use JSON Paths for Partial Updates

Use JSON path syntax to update specific fields without fetching the entire document.

**Correct:** Use JSON paths for targeted updates.

```python
# Store JSON document
redis.json().set("user:1001", "$", {
    "name": "Alice",
    "email": "alice@example.com",
    "preferences": {"theme": "dark", "notifications": True}
})

# Update nested field without fetching entire document
redis.json().set("user:1001", "$.preferences.theme", "light")

# Get specific field
theme = redis.json().get("user:1001", "$.preferences.theme")

# Increment numeric field atomically
redis.json().numincrby("user:1001", "$.preferences.volume", 5)

# Append to array
redis.json().arrappend("user:1001", "$.tags", "premium")
```

**Incorrect:** Storing JSON as a string and parsing client-side.

```python
# Bad: Loses queryability and atomic updates
redis.set("user:1001", json.dumps(user_data))

# Must fetch, parse, modify, serialize, and rewrite
data = json.loads(redis.get("user:1001"))
data["preferences"]["theme"] = "light"
redis.set("user:1001", json.dumps(data))
```

Reference: [Redis JSON Path](https://redis.io/docs/latest/develop/data-types/json/path/)
