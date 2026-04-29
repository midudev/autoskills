---
title: Clear, Action-Oriented Title (e.g., "Use Connection Pooling")
impact: MEDIUM
impactDescription: Brief quantified benefit (e.g., "Reduces connection overhead by 10x")
tags: relevant, keywords, here
description: Clear, Action-Oriented Title (e.g., "Use Connection Pooling")
alwaysApply: true
---

## [Rule Title]

[1-2 sentence explanation of the problem and why it matters. Focus on practical impact.]

**Correct:** Description of the good approach.

```python
# Comment explaining why this is better
pool = ConnectionPool(host='localhost', max_connections=50)
redis = Redis(connection_pool=pool)  # Reuse connections
result = redis.get('key')
```

---
### Choose ONE of the following patterns:

#### Pattern A: "Incorrect" (when alternative causes real harm)
Use when the alternative causes race conditions, security issues, crashes, or significant performance problems.

**Incorrect:** Description of the problematic approach.

```python
# Comment explaining what makes this problematic
redis = Redis(host='localhost')  # New connection per request - 10x overhead
result = redis.get('key')
```

#### Pattern B: "When to use" (for feature introductions)
Use when not using the feature is a valid choice for many use cases.

**When to use:**
- Scenario where this approach is beneficial
- Another scenario where it helps

**When NOT needed:**
- Scenario where the simpler approach is fine
- Another scenario where this adds unnecessary complexity

---

[Optional: Additional context, edge cases, or trade-offs]

Reference: [Redis Docs](https://redis.io/docs/)
