---
title: Configure Connection Timeouts
impact: MEDIUM
impactDescription: Improves connection resilience and failure recovery
tags: timeouts, connections, reliability
description: Configure Connection Timeouts
alwaysApply: true
---

## Configure Connection Timeouts

Configure appropriate timeout values to improve your application's connection resilience. While most Redis clients set default timeouts, choosing well-tuned values based on your application's usage patterns leads to better failure recovery.

**Correct:** Set timeouts based on your application needs.

```python
r = redis.Redis(
    host='localhost',
    socket_timeout=5.0,         # Read/write timeout - tune based on expected operation time
    socket_connect_timeout=2.0,  # Connection timeout - shorter for fast failure detection
    retry_on_timeout=True        # Automatic retry on timeout
)
```

**Incorrect:** Relying solely on defaults without considering your use case.

```python
# Not ideal: Default timeouts may not match your application's needs
r = redis.Redis(host='localhost')

# For example, if your app needs fast failure detection,
# the default timeouts might be too generous
```

**Considerations:**
- Set `socket_connect_timeout` shorter than `socket_timeout` for quick connection failure detection
- For latency-sensitive apps, use tighter timeouts with retry logic
- For batch operations, allow longer timeouts to complete large operations
- Consider using health checks alongside timeouts for robust failure handling

Reference: [Redis Client Configuration](https://redis.io/docs/latest/develop/clients/)
