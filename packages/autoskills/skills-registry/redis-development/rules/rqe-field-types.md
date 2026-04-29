---
title: Choose the Correct Field Type
impact: HIGH
impactDescription: Use TAG instead of TEXT for filtering to improve query speed 10x
tags: rqe, field-types, text, tag, numeric, geo, geoshape, vector
description: Choose the Correct Field Type
alwaysApply: true
---

## Choose the Correct Field Type

Each field type has different capabilities and performance characteristics.

| Field Type | Use When | Notes |
|------------|----------|-------|
| TEXT | Full-text search needed | Tokenized, stemmed |
| TAG | Exact match, filtering | Faster than TEXT for filtering |
| NUMERIC | Range queries, sorting | Use for prices, counts, timestamps |
| GEO | Point location queries | Lat/long coordinates (single points) |
| GEOSHAPE | Area/region queries | Polygons, circles, rectangles |
| VECTOR | Similarity search | HNSW or FLAT algorithm |

**Correct:** Use TAG for exact matching.

```
# Good: TAG for exact category matching
FT.CREATE idx:products ON HASH PREFIX 1 product:
    SCHEMA
        category TAG SORTABLE
        status TAG
```

**Java** (Jedis):
```java
import redis.clients.jedis.search.*;

Schema schema = new Schema()
    .addTextField("name", 1)
    .addTagField("categories");  // TAG for exact matching

IndexDefinition def = new IndexDefinition(IndexDefinition.Type.HASH);

jedis.ftCreate("idx", IndexOptions.defaultOptions().setDefinition(def), schema);

// Query with TAG syntax
SearchResult result = jedis.ftSearch("idx", "@categories:{chef|runner}");
```

**Incorrect:** Using TEXT when you don't need full-text features.

```
# Overkill: TEXT for category adds unnecessary tokenization
FT.CREATE idx:products ON HASH PREFIX 1 product:
    SCHEMA
        category TEXT
        status TEXT
```

**Java** (Jedis):
```java
// Bad: TEXT for categories adds unnecessary overhead
Schema schema = new Schema()
    .addTextField("name", 1)
    .addTextField("categories", 1);  // Overkill for exact matching
```

**Correct:** Use GEO for points, GEOSHAPE for areas.

```
# GEO for point locations (stores, users)
FT.CREATE idx:stores ON HASH PREFIX 1 store:
    SCHEMA
        location GEO

# GEOSHAPE for areas (delivery zones, boundaries)
FT.CREATE idx:zones ON JSON PREFIX 1 zone:
    SCHEMA
        $.boundary AS boundary GEOSHAPE
```

Reference: [Redis Search Field Types](https://redis.io/docs/latest/develop/interact/search-and-query/indexing/geoindex/)
