---
title: Use Read Replicas for Read-Heavy Workloads
impact: MEDIUM
impactDescription: Scales read throughput without adding primary nodes
tags: cluster, replicas, read-scaling, high-availability
description: Use Read Replicas for Read-Heavy Workloads
alwaysApply: true
---

## Use Read Replicas for Read-Heavy Workloads

For read-heavy workloads, distribute reads across replicas to reduce load on primaries.

**Correct:** Configure replica reads in Redis Cluster.

```python
from redis.cluster import RedisCluster

rc = RedisCluster(
    host='localhost',
    port=6379,
    read_from_replicas=True  # Distribute reads to replicas
)

# Writes go to primary
rc.set("key", "value")

# Reads can be served by replicas (eventually consistent)
value = rc.get("key")
```

**Correct:** Use replica reads in standalone replication setup.

```python
from redis import Redis

# Connect to primary for writes
primary = Redis(host='primary-host', port=6379)

# Connect to replica for reads
replica = Redis(host='replica-host', port=6379)

# Write to primary
primary.set("key", "value")

# Read from replica (eventually consistent)
value = replica.get("key")
```

**Considerations:**
- Replica reads are eventually consistent
- Don't read from replicas for data that was just written
- Use for read-heavy, slightly-stale-OK workloads (caches, analytics, dashboards)

Reference: [Redis Replication](https://redis.io/docs/latest/operate/oss_and_stack/management/replication/)
