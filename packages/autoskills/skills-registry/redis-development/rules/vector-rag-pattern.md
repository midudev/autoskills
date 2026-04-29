---
title: Implement RAG Pattern Correctly
impact: HIGH
impactDescription: Proper RAG implementation improves LLM response quality
tags: vector, rag, llm, embeddings, retrieval
description: Implement RAG Pattern Correctly
alwaysApply: true
---

## Implement RAG Pattern Correctly

Store documents with embeddings, retrieve relevant context, and pass to LLM.

**Correct:** Full RAG pipeline with RedisVL.

```python
from redisvl.index import SearchIndex
from redisvl.query import VectorQuery

# 1. Store documents with embeddings
for doc in documents:
    embedding = embed_model.encode(doc["content"])
    index.load([{
        "content": doc["content"],
        "embedding": embedding.tolist(),
        "source": doc["source"]
    }])

# 2. Query with vector similarity
query_embedding = embed_model.encode(user_question)
results = index.search(VectorQuery(
    vector=query_embedding,
    vector_field_name="embedding",
    return_fields=["content", "source"],
    num_results=5
))

# 3. Pass context to LLM
context = "\n".join([r["content"] for r in results])
response = llm.generate(f"Context: {context}\n\nQuestion: {user_question}")
```

**Best practices:**
- Normalize vectors if using COSINE distance
- Batch inserts using `index.load()` with lists
- Set appropriate M and EF_CONSTRUCTION for HNSW based on dataset size
- Use filters to reduce the search space before vector comparison
- Consider chunking long documents for better retrieval

Reference: [Redis RAG Quickstart](https://redis.io/docs/latest/develop/get-started/rag/)

