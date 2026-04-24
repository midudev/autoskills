---
title: Configure Semantic Cache Properly
impact: MEDIUM
impactDescription: Correct threshold tuning balances hit rate vs accuracy
tags: langcache, cache, threshold, ttl, semantic
description: Configure Semantic Cache Properly
alwaysApply: true
---

## Configure Semantic Cache Properly

> **Note:** LangCache is currently in preview on Redis Cloud. Features and behavior may change.

Tune similarity threshold and cache separation for optimal LangCache results.

**Correct:** Tune similarity threshold for your use case.

```python
from langcache import LangCache

lang_cache = LangCache(
    server_url=f"https://{os.getenv('HOST')}",
    cache_id=os.getenv("CACHE_ID"),
    api_key=os.getenv("API_KEY")
)

# Stricter matching - fewer false positives (0.95 = very similar)
result = lang_cache.search(
    prompt="What is Redis?",
    similarity_threshold=0.95
)

# Looser matching - higher hit rate (0.8 = somewhat similar)
result = lang_cache.search(
    prompt="What is Redis?",
    similarity_threshold=0.8
)
```

**Correct:** Use separate caches for different use cases.

```python
# Create different cache IDs in Redis Cloud for different LLM tasks
support_cache = LangCache(
    server_url=server_url,
    cache_id="support-cache-id",
    api_key=api_key
)

code_cache = LangCache(
    server_url=server_url,
    cache_id="code-cache-id",
    api_key=api_key
)
```

**Incorrect:** Using a single cache for all LLM tasks.

```python
# All tasks share one cache - responses may not be relevant
result = lang_cache.search(prompt="How do I reset my password?")
# Could return a code snippet if someone asked a similar coding question
```

**Best practices:**
- Start with threshold 0.9, adjust based on your use case
- Use custom attributes to filter results within a single cache
- Monitor cache hit rates to evaluate effectiveness
- Use separate cache IDs for fundamentally different LLM tasks

Reference: [LangCache Best Practices](https://redis.io/docs/latest/develop/ai/langcache/)

