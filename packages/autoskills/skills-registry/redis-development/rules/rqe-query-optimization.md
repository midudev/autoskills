---
title: Write Efficient Queries
impact: HIGH
impactDescription: Proper filtering reduces query time by orders of magnitude
tags: rqe, ft.search, query, performance, filters
description: Write Efficient Queries
alwaysApply: true
---

## Write Efficient Queries

Be specific and use filters to reduce the result set early.

**Correct:** Use specific filters and limit results.

```
# Good: Specific query with filters
FT.SEARCH idx:products "@category:{electronics} @price:[100 500]"
    LIMIT 0 20
    RETURN 3 name price category

# Good: Use SORTBY and LIMIT
FT.SEARCH idx:products "@name:laptop"
    SORTBY price ASC
    LIMIT 0 10
```

**Incorrect:** Broad queries returning large result sets.

```
# Bad: Wildcard prefix scans entire index
FT.SEARCH idx:products "*" LIMIT 0 10000

# Bad: Loading all fields from source document
FT.AGGREGATE idx:products "*" LOAD *
```

**Performance tips:**
- Add `SORTABLE` to fields used in `SORTBY`
- Use `TAG SORTABLE UNF` for best performance on tag fields
- Use `NOSTEM` if you don't need stemming
- Profile queries with `FT.PROFILE`

```
FT.PROFILE idx:products SEARCH QUERY "@category:{electronics}"
```

Reference: [Redis Search Query Syntax](https://redis.io/docs/latest/develop/interact/search-and-query/query/)

