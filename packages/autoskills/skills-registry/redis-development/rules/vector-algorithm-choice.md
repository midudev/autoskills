---
title: Choose HNSW vs FLAT Based on Requirements
impact: HIGH
impactDescription: HNSW trades accuracy for speed, FLAT provides exact results
tags: vector, hnsw, flat, algorithm, performance
description: Choose HNSW vs FLAT Based on Requirements
alwaysApply: true
---

## Choose HNSW vs FLAT Based on Requirements

Select the right algorithm based on your accuracy requirements and dataset size.

| Algorithm | Speed | Accuracy | Memory | Best For |
|-----------|-------|----------|--------|----------|
| HNSW | Fast (approximate) | ~95%+ recall tunable | Higher | Large datasets (>10k vectors) |
| FLAT | Slower (exact) | 100% (exact) | Lower | Small datasets, accuracy-critical |

**Correct:** Use HNSW for large-scale production workloads.

```python
from redisvl.schema import IndexSchema

# HNSW - fast approximate search, tunable accuracy
schema = IndexSchema.from_dict({
    "index": {"name": "idx:docs", "prefix": "doc:"},
    "fields": [
        {"name": "embedding", "type": "vector", "attrs": {
            "dims": 1536,
            "algorithm": "HNSW",
            "distance_metric": "COSINE",
            "M": 16,                  # Higher = more accurate, more memory
            "EF_CONSTRUCTION": 200    # Higher = better index quality, slower build
        }}
    ]
})
```

**Correct:** Use FLAT when exact results are required.

```python
# FLAT - exact brute-force search, guaranteed accuracy
schema = IndexSchema.from_dict({
    "index": {"name": "idx:small", "prefix": "small:"},
    "fields": [
        {"name": "embedding", "type": "vector", "attrs": {
            "dims": 1536,
            "algorithm": "FLAT",
            "distance_metric": "COSINE"
        }}
    ]
})
```

**Tuning HNSW accuracy vs speed:**
- `M`: Connections per node (16-64). Higher = better recall, more memory
- `EF_CONSTRUCTION`: Build-time parameter (100-500). Higher = better graph quality
- `EF_RUNTIME`: Query-time parameter. Higher = better recall, slower queries

Reference: [Redis Vector Search](https://redis.io/docs/latest/develop/interact/search-and-query/advanced-concepts/vectors/)
