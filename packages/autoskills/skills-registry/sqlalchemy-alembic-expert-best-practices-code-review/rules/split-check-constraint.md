---
title: Add check constraints safely in SQLAlchemy
impact: MEDIUM
impactDescription: Prevents blocking writes during constraint validation
tags: postgresql, sqlalchemy, alembic, migrations, constraints
---

When adding check constraints that could affect large tables, create the constraint with `NOT VALID` first to avoid blocking writes during the validation scan.

Bad:

```python
def upgrade():
    # Directly creating a check constraint blocks writes during table scan
    op.create_check_constraint(
        'ck_users_age_positive',
        'users',
        'age >= 0'
    )
```

Good:

```python
# Migration 1: Create check constraint without validation

def upgrade():
    # Create the check constraint without validating existing data (non-blocking)
    op.create_check_constraint(
        'ck_users_age_positive',
        'users',
        'age >= 0',
        postgresql_not_valid=True
    )
```

```python
# Migration 2: Validate existing data

def upgrade():
    op.execute('ALTER TABLE users VALIDATE CONSTRAINT ck_users_age_positive')
```
