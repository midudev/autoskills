# Database / query performance

Use this file when profiling points to DB time or high query counts.

Common fixes:

- Avoid N+1 query patterns (batch queries, prime caches, avoid per-row lookups).
- Prefer `fields => 'ids'` when you only need IDs.
- Avoid expensive meta queries where possible; consider indexing or schema changes.
- Use object caching for repeated reads.

Tools (backend-only):

- Query Monitor (REST headers/envelope) for query lists and stack traces.
- `wp db query` for targeted SQL/explain (be careful in prod).

References:

- Query Monitor plugin: https://wordpress.org/plugins/query-monitor/

