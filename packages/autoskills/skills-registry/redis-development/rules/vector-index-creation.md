---
title: Configure Vector Indexes Properly
impact: HIGH
impactDescription: Correct configuration is essential for vector search accuracy
tags: vector, index, hnsw, flat, embeddings, rqe
description: Configure Vector Indexes Properly
alwaysApply: true
---

## Configure Vector Indexes Properly

Set the correct dimensions, algorithm, and distance metric for your embeddings. Vector indexes can be created via CLI, Redis Insight, or any client library.

**Correct:** Create index via Redis CLI or Insight.

```
FT.CREATE idx:docs ON HASH PREFIX 1 doc:
    SCHEMA
        content TEXT
        embedding VECTOR HNSW 6
            TYPE FLOAT32
            DIM 1536
            DISTANCE_METRIC COSINE
```

**Correct:** Create index via Python (redis-py).

```python
from redis import Redis
from redis.commands.search.field import TextField, VectorField

r = Redis()

# Define schema with vector field
schema = [
    TextField("content"),
    VectorField(
        "embedding",
        algorithm="HNSW",
        attributes={
            "TYPE": "FLOAT32",
            "DIM": 1536,  # Must match your embedding model
            "DISTANCE_METRIC": "COSINE"
        }
    )
]

r.ft("idx:docs").create_index(schema, definition=IndexDefinition(prefix=["doc:"]))
```

**Correct:** Create index via RedisVL.

```python
from redisvl.index import SearchIndex
from redisvl.schema import IndexSchema

schema = IndexSchema.from_dict({
    "index": {"name": "idx:docs", "prefix": "doc:"},
    "fields": [
        {"name": "content", "type": "text"},
        {"name": "embedding", "type": "vector", "attrs": {
            "dims": 1536,
            "algorithm": "HNSW",
            "distance_metric": "COSINE"
        }}
    ]
})

index = SearchIndex(schema)
index.create(overwrite=True)
```

**Incorrect:** Mismatched dimensions or wrong distance metric.

```python
# Bad: Wrong dimensions for your model
{"dims": 768}  # But using OpenAI which outputs 1536

# Bad: Wrong metric for normalized embeddings
{"distance_metric": "L2"}  # When embeddings are normalized for COSINE
```

Reference: [Redis Vector Search](https://redis.io/docs/latest/develop/interact/search-and-query/advanced-concepts/vectors/)
