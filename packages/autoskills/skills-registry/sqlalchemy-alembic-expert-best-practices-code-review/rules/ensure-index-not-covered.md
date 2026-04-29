---
title: Ensure index is not already covered in SQLAlchemy
impact: LOW
impactDescription: Prevents redundant indexes and reduces storage costs
tags: postgresql, sqlalchemy, alembic, migrations, indexes, optimization
---

Ensure that individual column indexes in SQLAlchemy are not covered by existing composite indexes.

Bad:

```python
class User(Base):
    __tablename__ = "users"

    __table_args__ = (
        Index("email_username_idx", "email", "username"),
    )

    id: Mapped[int] = mapped_column(primary_key=True)
    email: Mapped[str] = mapped_column(String(255), index=True)  # covered by email_username_idx
    username: Mapped[str] = mapped_column(String(100))
    status: Mapped[str] = mapped_column(String(20))
```

Good:

```python
class User(Base):
    __tablename__ = "users"

    # Only composite index needed - covers both email and email+username queries
    __table_args__ = (
        Index("email_username_idx", "email", "username"),
    )

    id: Mapped[int] = mapped_column(primary_key=True)
    email: Mapped[str] = mapped_column(String(255))
    username: Mapped[str] = mapped_column(String(100))
    status: Mapped[str] = mapped_column(String(20))
```
