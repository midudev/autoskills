---
title: Add foreign keys safely in SQLAlchemy
impact: HIGH
impactDescription: Avoids blocking writes on both tables during foreign key validation
tags: postgresql, sqlalchemy, alembic, migrations, foreign-keys
---

When adding foreign keys in SQLAlchemy migrations, split the operation into two steps to avoid blocking writes on both tables:

1. First create the foreign key constraint without validation
2. Then validate existing data in a separate migration

Bad:

```python
def upgrade():
    # Directly creating a foreign key constraint can block writes on both tables
    op.create_foreign_key(
        'fk_users_orders',
        'users',
        'orders',
        ['order_id'],
        ['id']
    )
```

Good:

```python
# Migration 1: Add foreign key without validation

def upgrade():
    # Create the foreign key constraint without validating existing data
    op.create_foreign_key(
        'fk_users_orders',
        'users',
        'orders',
        ['order_id'],
        ['id'],
        postgresql_not_valid=True
    )
```

```python
# Migration 2: Validate existing data

def upgrade():
    op.execute('ALTER TABLE users VALIDATE CONSTRAINT fk_users_orders')
```
