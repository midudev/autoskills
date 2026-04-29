---
title: Use DIALECT 2 for Query Syntax
impact: MEDIUM
impactDescription: Ensures consistent query behavior and access to modern features
tags: rqe, dialect, query, syntax
description: Use DIALECT 2 for Query Syntax
alwaysApply: true
---

## Use DIALECT 2 for Query Syntax

Use DIALECT 2 for consistent query behavior. Many Redis client libraries now default to DIALECT 2, and other dialects (1, 3, 4) are deprecated as of Redis 8.

**Correct:** Use DIALECT 2 explicitly or rely on modern client defaults.

```python
from redis import Redis

r = Redis()

# Modern redis-py (6.0+) defaults to DIALECT 2
# You can also set it explicitly
results = r.ft("idx:products").search(
    "@name:laptop",
    dialect=2
)
```

```
# In raw commands, specify DIALECT 2
FT.SEARCH idx:products "@name:laptop" DIALECT 2

FT.AGGREGATE idx:products "@category:{electronics}"
    GROUPBY 1 @category
    REDUCE COUNT 0 AS count
    DIALECT 2
```

**Note:** DIALECT 2 is required for vector search queries. Most modern client libraries (redis-py 6.0+, go-redis, Lettuce) now use DIALECT 2 by default.

**Why DIALECT 2:**
- Consistent handling of special characters
- Better NULL value handling
- More predictable query parsing
- Required for vector search

Reference: [Query Dialects](https://redis.io/docs/latest/develop/interact/search-and-query/advanced-concepts/dialects/)
