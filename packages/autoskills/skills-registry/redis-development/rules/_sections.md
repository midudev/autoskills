# Section Definitions

This file defines the rule categories for Redis best practices. Rules are automatically assigned to sections based on their filename prefix.

---

## 1. Data Structures & Keys (data)
**Impact:** HIGH
**Description:** Choosing the right Redis data type and key naming conventions. Foundation for efficient Redis usage.

## 2. Memory & Expiration (ram)
**Impact:** HIGH
**Description:** Memory limits, eviction policies, TTL strategies, and memory optimization techniques.

## 3. Connection & Performance (conn)
**Impact:** HIGH
**Description:** Connection pooling, pipelining, timeouts, and avoiding blocking commands.

## 4. JSON Documents (json)
**Impact:** MEDIUM
**Description:** Using Redis JSON for nested structures, partial updates, and integration with RQE.

## 5. Redis Query Engine (rqe)
**Impact:** HIGH
**Description:** FT.CREATE, FT.SEARCH, FT.AGGREGATE, index design, field types, and query optimization.

## 6. Vector Search & RedisVL (vector)
**Impact:** HIGH
**Description:** Vector indexes, HNSW vs FLAT, hybrid search, and RAG patterns with RedisVL.

## 7. Semantic Caching (semantic-cache)
**Impact:** MEDIUM
**Description:** LangCache for LLM response caching, distance thresholds, and cache strategies.

## 8. Streams & Pub/Sub (stream)
**Impact:** MEDIUM
**Description:** Choosing between Streams and Pub/Sub for messaging patterns.

## 9. Clustering & Replication (cluster)
**Impact:** MEDIUM
**Description:** Hash tags for key colocation, read replicas, and cluster-aware patterns.

## 10. Security (security)
**Impact:** HIGH
**Description:** Authentication, ACLs, TLS, and network security.

## 11. Observability (observe)
**Impact:** MEDIUM
**Description:** SLOWLOG, INFO, MEMORY commands, monitoring metrics, and Redis Insight.

