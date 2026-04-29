---
title: Verify query patterns are covered by an index in SQLAlchemy
impact: HIGH
impactDescription: Prevents full table scans and improves query performance
tags: postgresql, sqlalchemy, alembic, migrations, indexes, performance
---

Ensure that SQLAlchemy query patterns are covered by appropriate database indexes.

Bad:

```python
# queries.py
def get_user_by_email(session: Session, email: str):
    # Will perform full table scan - no index on email
    return session.scalar(select(User).where(User.email == email))

# models.py
class User(Base):
    __tablename__ = 'users'

    id: Mapped[int] = mapped_column(primary_key=True)
    email: Mapped[str] = mapped_column(String(255))  # No index
    status: Mapped[str] = mapped_column(String(50))
    created_at: Mapped[datetime] = mapped_column(DateTime)
```

Good:

```python
# queries.py
def get_user_by_email(session: Session, email: str):
    # Is covered by an index
    return session.scalar(select(User).where(User.email == email))

# models.py
class User(Base):
    __tablename__ = 'users'

    id: Mapped[int] = mapped_column(primary_key=True)
    email: Mapped[str] = mapped_column(String(255), index=True)
    status: Mapped[str] = mapped_column(String(50))
    created_at: Mapped[datetime] = mapped_column(DateTime)
```
