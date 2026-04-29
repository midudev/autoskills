---
title: Use Hybrid Search for Better Results
impact: MEDIUM
impactDescription: Combining vector + filters improves relevance and reduces search space
tags: vector, hybrid, filters, redisvl, search
description: Use Hybrid Search for Better Results
alwaysApply: true
---

## Use Hybrid Search for Better Results

Combine vector similarity with attribute filtering for more relevant results.

**Correct:** Apply filters to reduce search space.

```python
from redisvl.query import VectorQuery

query = VectorQuery(
    vector=query_embedding,
    vector_field_name="embedding",
    return_fields=["content", "category", "date"],
    num_results=10,
    filter_expression="@category:{technology} @date:[2024 2025]"
)

results = index.search(query)
```

**Incorrect:** Searching entire vector space when filters apply.

```python
# Bad: No filter - searches all vectors then filters client-side
results = index.search(VectorQuery(
    vector=query_embedding,
    vector_field_name="embedding",
    num_results=1000
))
# Client-side filtering - wasteful
filtered = [r for r in results if r["category"] == "technology"]
```

**Tips:**
- Use TAG fields for category filters
- Use NUMERIC fields for date/price ranges
- Filters are applied before vector search, reducing computation

Reference: [Redis Hybrid Queries](https://redis.io/docs/latest/develop/interact/search-and-query/query/combined/)

