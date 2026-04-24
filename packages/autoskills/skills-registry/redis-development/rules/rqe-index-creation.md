---
title: Index Only Fields You Query
impact: HIGH
impactDescription: Reduces index size and improves write performance
tags: rqe, ft.create, index, schema
description: Index Only Fields You Query
alwaysApply: true
---

## Index Only Fields You Query

Create indexes with only the fields you need to search, filter, or sort on.

**Correct:** Index specific fields and use prefixes.

```
FT.CREATE idx:products ON HASH PREFIX 1 product:
    SCHEMA
        name TEXT WEIGHT 2.0
        description TEXT
        category TAG SORTABLE
        price NUMERIC SORTABLE
        location GEO
```

**Java** (Jedis):
```java
import redis.clients.jedis.search.*;

Schema schema = new Schema()
    .addTextField("name", 1)
    .addTagField("categories");

// Good: Specify prefix to index only matching keys
IndexDefinition def = new IndexDefinition(IndexDefinition.Type.HASH)
    .setPrefixes("person:");

jedis.ftCreate("idx", IndexOptions.defaultOptions().setDefinition(def), schema);
```

**Incorrect:** Over-indexing or indexing unused fields.

```
# Bad: Indexing every field "just in case"
FT.CREATE idx:products ON HASH PREFIX 1 product:
    SCHEMA
        name TEXT
        description TEXT
        category TEXT
        subcategory TEXT
        brand TEXT
        sku TEXT
        price NUMERIC
        cost NUMERIC
        margin NUMERIC
        ...
```

**Java** (Jedis):
```java
// Bad: No prefix means all hashes get indexed
IndexDefinition def = new IndexDefinition(IndexDefinition.Type.HASH);
// This will index every hash in the database!
```

**Tips:**
- Start with the minimum required fields
- Add fields as query patterns emerge
- Use `FT.INFO` to monitor index size
- Always specify a prefix to avoid indexing unrelated keys

Reference: [Redis Search Indexing](https://redis.io/docs/latest/develop/interact/search-and-query/indexing/)

