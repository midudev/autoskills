---
title: Manage Indexes for Zero-Downtime Updates
impact: MEDIUM
impactDescription: Use aliases for seamless index updates
tags: rqe, index, alias, management, reindex
description: Manage Indexes for Zero-Downtime Updates
alwaysApply: true
---

## Manage Indexes for Zero-Downtime Updates

Use aliases to swap indexes without application changes.

**Correct:** Use aliases for production indexes.

```
# Create versioned index
FT.CREATE idx:products_v2 ON HASH PREFIX 1 product:
    SCHEMA
        name TEXT
        category TAG SORTABLE
        price NUMERIC SORTABLE

# Point alias to new index
FT.ALIASADD products idx:products_v2

# Application queries use alias
FT.SEARCH products "@category:{electronics}"

# Later, swap to new version
FT.ALIASUPDATE products idx:products_v3
```

**Useful management commands:**

```
# Check index info
FT.INFO idx:products

# Drop and recreate (non-blocking)
FT.DROPINDEX idx:products
FT.CREATE idx:products ...

# List all indexes
FT._LIST
```

Reference: [Redis Search Index Management](https://redis.io/docs/latest/develop/interact/search-and-query/administration/)

