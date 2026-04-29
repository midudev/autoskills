---
title: Add unique constraints safely in SQLAlchemy
impact: HIGH
impactDescription: Prevents blocking reads and writes during constraint creation
tags: postgresql, sqlalchemy, alembic, migrations, constraints
---

When adding unique constraints that could affect large tables, create the unique index concurrently first to avoid blocking reads and writes during the migration.

Bad:

```python
def upgrade():
    # Directly creating a unique constraint can block reads and writes
    op.create_unique_constraint('users_email_unique', 'users', ['email'])
```

Good:

```python
# Migration 1: Create unique index concurrently

def upgrade():
    # Create the unique index concurrently (non-blocking)
    op.create_index(
        'users_email_unique_idx',
        'users',
        ['email'],
        unique=True,
        postgresql_concurrently=True
    )
```

```python
# Migration 2: Add constraint using existing index

def upgrade():
    # Add the unique constraint using the existing index
    op.create_unique_constraint(
        'users_email_unique',
        'users',
        ['email'],
        postgresql_using_index='users_email_unique_idx'
    )
```
