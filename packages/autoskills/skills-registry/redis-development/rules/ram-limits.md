---
title: Configure Memory Limits and Eviction Policies
impact: HIGH
impactDescription: Prevents out-of-memory crashes and unpredictable behavior
tags: memory, maxmemory, eviction, lru, ttl
description: Configure Memory Limits and Eviction Policies
alwaysApply: true
---

## Configure Memory Limits and Eviction Policies

Always configure `maxmemory` and an eviction policy to prevent Redis from consuming all available memory.

**Correct:** Set explicit memory limits.

```
maxmemory 2gb
maxmemory-policy allkeys-lru
```

| Policy | Use Case |
|--------|----------|
| `volatile-lru` | Evict keys with TTL, least recently used first |
| `allkeys-lru` | Evict any key, least recently used first |
| `volatile-ttl` | Evict keys closest to expiration |
| `noeviction` | Return errors when memory is full (use for critical data) |

**Incorrect:** Running Redis without memory limits.

```
# No maxmemory set - Redis will use all available RAM
# Can cause OOM killer to terminate Redis or other processes
```

**Memory optimization tips:**
- Use Hashes for small objects (more memory-efficient than separate keys)
- Use `OBJECT ENCODING key` to check how Redis stores your data
- Use `MEMORY USAGE key` to check individual key memory consumption
- Enable compression in your client for large values

Reference: [Redis Memory Optimization](https://redis.io/docs/latest/operate/oss_and_stack/management/optimization/memory-optimization/)

