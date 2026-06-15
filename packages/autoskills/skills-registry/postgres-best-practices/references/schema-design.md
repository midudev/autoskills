# Schema Design

Best practices for designing Postgres schemas.

## Choosing Data Types

- Prefer `text` over `varchar(n)` unless a length constraint is meaningful to the domain.
- Use `timestamptz` instead of `timestamp` to always store timezone-aware timestamps.
- Use `uuid` for primary keys when IDs may be exposed externally or generated client-side.
