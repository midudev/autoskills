---
title: Limit non unique indexes in SQLAlchemy
impact: MEDIUM
impactDescription: Improves index efficiency and reduces storage overhead
tags: postgresql, sqlalchemy, alembic, migrations, indexes, performance
---

Limit non-unique indexes to a maximum of three columns in PostgreSQL databases:

Bad:

```python
def upgrade():
    with op.get_context().autocommit_block():
        op.create_index(
            'index_users_on_multiple_columns',
            'users',
            ['column_a', 'column_b', 'column_c', 'column_d'],
            postgresql_concurrently=True
        )
```

Good:

```python
def upgrade():
    # Limit to most selective columns for better performance
    with op.get_context().autocommit_block():
        op.create_index(
            'index_users_on_selective_columns',
            'users',
            ['column_d', 'column_b'],
            postgresql_concurrently=True
        )
```
