---
title: Use Consistent Key Naming Conventions
impact: MEDIUM
impactDescription: Improved maintainability and debugging
tags: keys, naming, conventions, prefixes
description: Use Consistent Key Naming Conventions
alwaysApply: true
---

## Use Consistent Key Naming Conventions

Well-structured key names improve code maintainability, debugging, and enable efficient key scanning.

**Correct:** Use colons as separators with a consistent hierarchy.

```
# Pattern: service:entity:id:attribute
user:1001:profile
user:1001:settings
order:2024:items
cache:api:users:list
session:abc123
```

**Python** (redis-py):
```python
# Good: Short, meaningful key
redis.set("product:8361", cached_html)
page = redis.get("product:8361")
```

**Java** (Jedis):
```java
// Good: Short, meaningful key derived from URL
jedis.set("product:8361", "<some cached HTML>");
String page = jedis.get("product:8361");
```

**Incorrect:** Inconsistent naming, spaces, or very long keys.

```
# These cause confusion and waste memory
User_1001_Profile
my key with spaces
com.mycompany.myapp.production.users.profile.data.1001
```

**Java** (Jedis):
```java
// Bad: Using full URL as key wastes memory and slows comparisons
jedis.set("http://www.verylongurlkey.com/store/products/product.html?id=8361",
          "<some cached HTML>");
```

**Key naming tips:**
- Keep keys short but readable—they consume memory
- Consider key prefixes for multi-tenant applications
- Extract short identifiers from URLs or long strings rather than using the whole thing
- For large binary values, consider using a hash digest as the key instead of the value itself
- Use consistent separators (colons are conventional)

Reference: [Redis Keys](https://redis.io/docs/latest/develop/use/keyspace/)
