---
title: Only concurrent indexes in SQLAlchemy
impact: CRITICAL
impactDescription: Prevents blocking writes during index creation and deletion
tags: postgresql, sqlalchemy, alembic, migrations, indexes
---

When creating or dropping indexes in PostgreSQL using SQLAlchemy migrations, always use the `postgresql_concurrently=True` option within an autocommit block. This prevents blocking writes during index operations.

For `upgrade()`:

Bad:

```python
def upgrade():
    op.create_index('idx_users_email', 'users', ['email'])
```

Good:

```python
def upgrade():
    with op.get_context().autocommit_block():
        op.create_index('idx_users_email', 'users', ['email'], postgresql_concurrently=True)
```

For `downgrade()`:

Bad:

```python
def downgrade():
    op.drop_index('idx_users_email', 'users')
```

Good:

```python
def downgrade():
    with op.get_context().autocommit_block():
        op.drop_index('idx_users_email', 'users', postgresql_concurrently=True)
```
