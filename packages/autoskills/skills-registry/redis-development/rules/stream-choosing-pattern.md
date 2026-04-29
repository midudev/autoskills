---
title: Choose Streams vs Pub/Sub Appropriately
impact: MEDIUM
impactDescription: Wrong choice leads to lost messages or unnecessary complexity
tags: streams, pubsub, messaging, events, queues
description: Choose Streams vs Pub/Sub Appropriately
alwaysApply: true
---

## Choose Streams vs Pub/Sub Appropriately

Redis supports two messaging approaches for different use cases.

**Incorrect:** Using Pub/Sub when messages must not be lost.

```python
# Pub/Sub - messages lost if no subscribers connected
r.publish("orders", json.dumps(order))  # Fire and forget!
```

**Correct:** Use Streams when message durability matters.

```python
# Streams - messages persist and can be replayed
r.xadd("orders:stream", {"order": json.dumps(order)})

# Consumer group for reliable processing
r.xreadgroup("workers", "worker-1", {"orders:stream": ">"}, count=10)
r.xack("orders:stream", "workers", message_id)
```

### When to Use Each

| Requirement | Use |
|-------------|-----|
| Real-time notifications, OK to miss messages | Pub/Sub |
| Messages must not be lost | Streams |
| Need to replay/reprocess messages | Streams |
| Multiple workers processing same queue | Streams (consumer groups) |
| Simple broadcast to connected clients | Pub/Sub |
| Event sourcing or audit trail | Streams |

Reference: [Redis Streams](https://redis.io/docs/latest/develop/data-types/streams/)

