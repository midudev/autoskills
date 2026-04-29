---
title: Use Transactions for Atomic Multi-Command Operations
impact: MEDIUM
impactDescription: Prevents race conditions and data inconsistency
tags: transactions, multi, exec, atomicity
description: Use Transactions for Atomic Multi-Command Operations
alwaysApply: true
---

## Use Transactions for Atomic Multi-Command Operations

Use the `MULTI`/`EXEC` commands to create a transaction when you need to execute multiple commands atomically. No other client requests will be processed while the transaction is executing, preventing other clients from modifying the keys used in the transaction and avoiding inconsistent data.

**Correct:** Use transactions when multiple related keys must be updated together.

**Python** (redis-py):
```python
import redis

client = redis.Redis(host='localhost', port=6379)

# Transaction ensures all commands execute atomically
pipe = client.pipeline(transaction=True)
pipe.set("person:1:name", "Alex")
pipe.set("person:1:rank", "Captain")
pipe.set("person:1:serial", "AB1234")
pipe.execute()  # All commands execute as one atomic unit
```

**Java** (Jedis):
```java
import redis.clients.jedis.UnifiedJedis;
import redis.clients.jedis.Transaction;

try (UnifiedJedis jedis = new UnifiedJedis("redis://localhost:6379")) {
    Transaction tran = (Transaction) jedis.multi();

    tran.set("person:1:name", "Alex");
    tran.set("person:1:rank", "Captain");
    tran.set("person:1:serial", "AB1234");

    tran.exec();  // All commands execute atomically
}
```

**Incorrect:** Executing related commands individually when atomicity is required.

**Python** (redis-py):
```python
import redis

client = redis.Redis(host='localhost', port=6379)

# BAD when atomicity matters - another client could read partial state
client.set("person:1:name", "Alex")
# Another client could read here and see incomplete data
client.set("person:1:rank", "Captain")
client.set("person:1:serial", "AB1234")
```

**When to use transactions:**
- Multiple keys must be updated as a single atomic unit
- Other clients reading partial state would cause bugs
- Implementing patterns like "transfer balance between accounts"

**When transactions are NOT needed:**
- Independent operations that don't need to be atomic
- Single-command operations (already atomic)
- When using pipelining purely for performance (use `pipeline(transaction=False)`)

**Note:** Transactions add overhead. Only use them when atomicity is actually required.

Reference: [Transactions](https://redis.io/docs/latest/develop/interact/transactions/)

