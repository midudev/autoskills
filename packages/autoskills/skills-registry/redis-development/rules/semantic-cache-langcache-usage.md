---
title: Use LangCache for LLM Response Caching
impact: HIGH
impactDescription: Reduces LLM API costs by 50-90% for similar queries
tags: langcache, llm, semantic-cache, embeddings, ai
description: Use LangCache for LLM Response Caching
alwaysApply: true
---

## Use LangCache for LLM Response Caching

> **Note:** LangCache is currently in preview on Redis Cloud. Features and behavior may change.

LangCache is a fully-managed semantic caching service on Redis Cloud that reduces LLM costs and latency.

**How it works:**
1. Your app sends a prompt to LangCache via `POST /v1/caches/{cacheId}/entries/search`
2. LangCache generates an embedding and searches for similar cached responses
3. If found (cache hit), returns the cached response instantly
4. If not found (cache miss), your app calls the LLM and stores the response

**Correct:** Use the LangCache Python SDK.

```python
from langcache import LangCache
import os

lang_cache = LangCache(
    server_url=f"https://{os.getenv('HOST')}",
    cache_id=os.getenv("CACHE_ID"),
    api_key=os.getenv("API_KEY")
)

# Search for cached response
result = lang_cache.search(
    prompt="What is Redis?",
    similarity_threshold=0.9
)

if result:
    response = result[0]["response"]
else:
    response = llm.generate("What is Redis?")
    # Store for future queries
    lang_cache.set(
        prompt="What is Redis?",
        response=response
    )
```

**LangCache REST API:**

```bash
# Search cache
curl -X POST "https://$HOST/v1/caches/$CACHE_ID/entries/search" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"prompt": "What is Redis?"}'

# Store a response
curl -X POST "https://$HOST/v1/caches/$CACHE_ID/entries" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"prompt": "What is Redis?", "response": "Redis is an in-memory database..."}'
```

**With custom attributes for filtering:**

```python
# Store with attributes
lang_cache.set(
    prompt="What is Redis?",
    response="Redis is an in-memory database...",
    attributes={"category": "database", "version": "v1"}
)

# Search with attribute filter
result = lang_cache.search(
    prompt="Tell me about Redis",
    attributes={"category": "database"},
    similarity_threshold=0.9
)
```

Reference: [LangCache Documentation](https://redis.io/docs/latest/develop/ai/langcache/)

