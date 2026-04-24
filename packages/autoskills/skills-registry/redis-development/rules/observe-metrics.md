---
title: Monitor Key Redis Metrics
impact: MEDIUM
impactDescription: Early detection of performance and capacity issues
tags: observability, metrics, monitoring, memory, connections
description: Monitor Key Redis Metrics
alwaysApply: true
---

## Monitor Key Redis Metrics

Track these metrics to catch issues before they impact users.

| Metric | What It Tells You | Alert When |
|--------|-------------------|------------|
| `used_memory` | Current memory usage | > 80% of maxmemory |
| `connected_clients` | Number of connections | Sudden spikes or drops |
| `blocked_clients` | Clients waiting on blocking ops | > 0 sustained |
| `instantaneous_ops_per_sec` | Current throughput | Significant drops |
| `keyspace_hits/misses` | Cache hit ratio | Hit ratio < 80% |
| `rejected_connections` | Connection limit issues | > 0 |
| `rdb_last_save_time` | Last persistence snapshot | Too old |

**Correct:** Export metrics to your monitoring system.

```python
# Get key metrics
info = redis.info()
print(f"Memory: {info['used_memory_human']}")
print(f"Connections: {info['connected_clients']}")
print(f"Ops/sec: {info['instantaneous_ops_per_sec']}")
print(f"Hit ratio: {info['keyspace_hits'] / (info['keyspace_hits'] + info['keyspace_misses']) * 100:.1f}%")
```

**Redis Insight:**
Use Redis Insight for visual monitoring, query profiling, and debugging. It includes Redis Copilot for natural language queries.

Reference: [Redis Insight](https://redis.io/insight/)

