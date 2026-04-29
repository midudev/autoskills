---
title: Use SKIPINITIALSCAN for New Data Only Indexes
impact: MEDIUM
impactDescription: Faster index creation, avoids indexing existing data
tags: index, skipinitialscan, rqe, search
description: Use SKIPINITIALSCAN for New Data Only Indexes
alwaysApply: true
---

## Use SKIPINITIALSCAN for New Data Only Indexes

Enable the `SKIPINITIALSCAN` option when creating an index if you only want to include items that are added after the index is created. This makes index creation faster and avoids indexing existing data that you don't need to search.

**Correct:** Use SKIPINITIALSCAN when you only need to index new data.

**Python** (redis-py):
```python
import redis
from redis.commands.search.field import TextField, TagField
from redis.commands.search.indexDefinition import IndexDefinition, IndexType

client = redis.Redis(host='localhost', port=6379)

# Create index that only indexes new documents
schema = (
    TextField("name"),
    TagField("categories")
)

definition = IndexDefinition(
    prefix=["person:"],
    index_type=IndexType.HASH
)

# SKIPINITIALSCAN - only index documents added after creation
client.ft("idx").create_index(
    schema,
    definition=definition,
    skip_initial_scan=True
)
```

**Java** (Jedis):
```java
import redis.clients.jedis.UnifiedJedis;
import redis.clients.jedis.search.FTCreateParams;
import redis.clients.jedis.search.IndexDataType;
import redis.clients.jedis.search.schemafields.SchemaField;
import redis.clients.jedis.search.schemafields.TagField;
import redis.clients.jedis.search.schemafields.TextField;

try (UnifiedJedis jedis = new UnifiedJedis("redis://localhost:6379")) {
    FTCreateParams params = new FTCreateParams()
        .on(IndexDataType.HASH)
        .skipInitialScan();  // Only index new documents

    jedis.ftCreate(
        "idx",
        params,
        new SchemaField[]{
            new TextField("name"),
            new TagField("categories")
        }
    );
}
```

**When to use SKIPINITIALSCAN:**
- Creating an index for a new feature where existing data is irrelevant
- Setting up indexes in advance before data arrives
- When existing data would be too large to scan during index creation
- Event-driven architectures where you only care about new events

**When NOT to use (default behavior is correct):**
- You need to search existing data immediately after index creation
- Migrating to a new index schema and need all data indexed
- Most typical use cases where historical data matters

**Note:** The default behavior (without SKIPINITIALSCAN) indexes all existing matching keys, which is usually what you want.

Reference: [FT.CREATE SKIPINITIALSCAN](https://redis.io/docs/latest/commands/ft.create/)

