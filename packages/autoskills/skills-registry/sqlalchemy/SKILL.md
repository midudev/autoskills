---
name: sqlalchemy-orm
description: "SQLAlchemy Python SQL toolkit and ORM with powerful query builder, relationship mapping, and database migrations via Alembic"
user-invocable: false
disable-model-invocation: true
progressive_disclosure:
  entry_point:
    summary: "SQLAlchemy Python SQL toolkit and ORM with powerful query builder, relationship mapping, and database migrations via Alembic"
    when_to_use: "When working with sqlalchemy-orm or related functionality."
    quick_start: "1. Review the core concepts below. 2. Apply patterns to your use case. 3. Follow best practices for implementation."
---
# SQLAlchemy ORM Skill

---
progressive_disclosure:
  entry_point:
    summary: "Python SQL toolkit and ORM with powerful query builder and relationship mapping"
    when_to_use:
      - "When building Python applications with databases"
      - "When needing complex SQL queries with type safety"
      - "When working with FastAPI/Flask/Django"
      - "When needing database migrations (Alembic)"
    quick_start:
      - "pip install sqlalchemy"
      - "Define models with declarative base"
      - "Create engine and session"
      - "Query with select() and commit()"
  token_estimate:
    entry: 70-85
    full: 4500-5500
---

## Core Concepts

### SQLAlchemy 2.0 Modern API
SQLAlchemy 2.0 introduced modern patterns with better type hints, improved query syntax, and async support.

**Key Changes from 1.x:**
- `select()` instead of `Query`
- `Mapped[T]` and `mapped_column()` for type hints
- Explicit `Session.execute()` for queries
- Better async support with `AsyncSession`

### Installation
```bash
# Core SQLAlchemy
pip install sqlalchemy

# With async support
pip install sqlalchemy[asyncio] aiosqlite  # SQLite
pip install sqlalchemy[asyncio] asyncpg    # PostgreSQL

# With Alembic for migrations
pip install alembic

# FastAPI integration
pip install fastapi sqlalchemy
```

## Declarative Models (SQLAlchemy 2.0)

### Basic Model Definition
```python
from datetime import datetime
from typing import Optional
from sqlalchemy import String, DateTime, ForeignKey, func
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship

# Base class for all models
class Base(DeclarativeBase):
    pass

# User model with type hints
class User(Base):
    __tablename__ = "users"

    # Primary key
    id: Mapped[int] = mapped_column(primary_key=True)

    # Required fields
    email: Mapped[str] = mapped_column(String(255), unique=True, index=True)
    username: Mapped[str] = mapped_column(String(50), unique=True)
    hashed_password: Mapped[str] = mapped_column(String(255))

    # Optional fields
    full_name: Mapped[Optional[str]] = mapped_column(String(100))
    is_active: Mapped[bool] = mapped_column(default=True)

    # Timestamps with server defaults
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now()
    )
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now(),
        onupdate=func.now()
    )

    # Relationships
    posts: Mapped[list["Post"]] = relationship(back_populates="author")

    def __repr__(self) -> str:
        return f"User(id={self.id}, email={self.email})"
```

### Relationships

**One-to-Many:**
```python
class Post(Base):
    __tablename__ = "posts"

    id: Mapped[int] = mapped_column(primary_key=True)
    title: Mapped[str] = mapped_column(String(200))
    content: Mapped[str]
    user_id: Mapped[int] = mapped_column(ForeignKey("users.id"))

    # Relationship with back_populates
    author: Mapped["User"] = relationship(back_populates="posts")
    tags: Mapped[list["Tag"]] = relationship(
        secondary="post_tags",
        back_populates="posts"
    )
```

**Many-to-Many:**
```python
from sqlalchemy import Table, Column, Integer, ForeignKey

# Association table
post_tags = Table(
    "post_tags",
    Base.metadata,
    Column("post_id", Integer, ForeignKey("posts.id"), primary_key=True),
    Column("tag_id", Integer, ForeignKey("tags.id"), primary_key=True)
)

class Tag(Base):
    __tablename__ = "tags"

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(50), unique=True)

    posts: Mapped[list["Post"]] = relationship(
        secondary=post_tags,
        back_populates="tags"
    )
```

## Database Setup

### Engine and Session Configuration
```python
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session
from sqlalchemy.pool import QueuePool

# Database URL formats
# SQLite: sqlite:///./database.db
# PostgreSQL: postgresql://user:pass@localhost/dbname
# MySQL: mysql+pymysql://user:pass@localhost/dbname

DATABASE_URL = "postgresql://user:pass@localhost/mydb"

# Create engine with connection pooling
engine = create_engine(
    DATABASE_URL,
    poolclass=QueuePool,
    pool_size=5,
    max_overflow=10,
    pool_pre_ping=True,  # Check connection before using
    echo=False  # Set True for SQL logging
)

# Session factory
SessionLocal = sessionmaker(
    bind=engine,
    autocommit=False,
    autoflush=False,
    expire_on_commit=False
)

# Create tables
Base.metadata.create_all(bind=engine)
```

### Dependency Injection (FastAPI Pattern)
```python
from typing import Generator

def get_db() -> Generator[Session, None, None]:
    """Database session dependency for FastAPI."""
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Usage in FastAPI
from fastapi import Depends

@app.get("/users/{user_id}")
def get_user(user_id: int, db: Session = Depends(get_db)):
    return db.execute(
        select(User).where(User.id == user_id)
    ).scalar_one_or_none()
```

## Query Patterns (SQLAlchemy 2.0)

### Select Queries
```python
from sqlalchemy import select, and_, or_, desc, func

# Basic select
stmt = select(User).where(User.email == "user@example.com")
user = session.execute(stmt).scalar_one_or_none()

# Multiple conditions
stmt = select(User).where(
    and_(
        User.is_active == True,
        User.created_at > datetime(2024, 1, 1)
    )
)
users = session.execute(stmt).scalars().all()

# OR conditions
stmt = select(User).where(
    or_(
        User.email.like("%@gmail.com"),
        User.email.like("%@yahoo.com")
    )
)

# Ordering and limiting
stmt = (
    select(User)
    .where(User.is_active == True)
    .order_by(desc(User.created_at))
    .limit(10)
    .offset(20)
)

# Counting
stmt = select(func.count()).select_from(User)
count = session.execute(stmt).scalar()
```

### Joins
```python
# Inner join
stmt = (
    select(Post, User)
    .join(User, Post.user_id == User.id)
    .where(User.is_active == True)
)
results = session.execute(stmt).all()

# Left outer join
stmt = (
    select(User, func.count(Post.id).label("post_count"))
    .outerjoin(Post)
    .group_by(User.id)
)

# Multiple joins
stmt = (
    select(Post)
    .join(Post.author)
    .join(Post.tags)
    .where(Tag.name == "python")
)
```

### Eager Loading (Solve N+1 Problem)
```python
from sqlalchemy.orm import selectinload, joinedload

# selectinload - separate query (better for collections)
stmt = select(User).options(selectinload(User.posts))
users = session.execute(stmt).scalars().all()
# Now users[0].posts won't trigger additional queries

# joinedload - single query with join (better for one-to-one)
stmt = select(Post).options(joinedload(Post.author))
posts = session.execute(stmt).unique().scalars().all()

# Nested eager loading
stmt = select(User).options(
    selectinload(User.posts).selectinload(Post.tags)
)

# Load only specific columns
from sqlalchemy.orm import load_only
stmt = select(User).options(load_only(User.id, User.email))
```

## CRUD Operations

### Create
```python
def create_user(db: Session, email: str, username: str, password: str):
    """Create new user."""
    user = User(
        email=email,
        username=username,
        hashed_password=hash_password(password)
    )
    db.add(user)
    db.commit()
    db.refresh(user)  # Get updated fields (id, timestamps)
    return user

# Bulk insert
users = [
    User(email=f"user{i}@example.com", username=f"user{i}")
    for i in range(100)
]
db.add_all(users)
db.commit()
```

### Read
```python
def get_user_by_email(db: Session, email: str) -> Optional[User]:
    """Get user by email."""
    stmt = select(User).where(User.email == email)
    return db.execute(stmt).scalar_one_or_none()

def get_users(
    db: Session,
    skip: int = 0,
    limit: int = 100
) -> list[User]:
    """Get paginated users."""
    stmt = (
        select(User)
        .where(User.is_active == True)
        .order_by(User.created_at.desc())
        .offset(skip)
        .limit(limit)
    )
    return db.execute(stmt).scalars().all()
```

### Update
```python
def update_user(db: Session, user_id: int, **kwargs):
    """Update user fields."""
    stmt = select(User).where(User.id == user_id)
    user = db.execute(stmt).scalar_one_or_none()

    if not user:
        return None

    for key, value in kwargs.items():
        setattr(user, key, value)

    db.commit()
    db.refresh(user)
    return user

# Bulk update
from sqlalchemy import update

stmt = (
    update(User)
    .where(User.is_active == False)
    .values(deleted_at=datetime.utcnow())
)
db.execute(stmt)
db.commit()
```

### Delete
```python
def delete_user(db: Session, user_id: int) -> bool:
    """Delete user."""
    stmt = select(User).where(User.id == user_id)
    user = db.execute(stmt).scalar_one_or_none()

    if not user:
        return False

    db.delete(user)
    db.commit()
    return True

# Bulk delete
from sqlalchemy import delete

stmt = delete(User).where(User.is_active == False)
db.execute(stmt)
db.commit()
```

## Transactions and Session Management

### Context Manager Pattern
```python
from contextlib import contextmanager

@contextmanager
def get_db_session():
    """Session context manager."""
    session = SessionLocal()
    try:
        yield session
        session.commit()
    except Exception:
        session.rollback()
        raise
    finally:
        session.close()

# Usage
with get_db_session() as db:
    user = create_user(db, "test@example.com", "testuser", "password")
    # Auto-commits on success, rollback on exception
```

### Manual Transaction Control
```python
def transfer_money(db: Session, from_user_id: int, to_user_id: int, amount: float):
    """Transfer money between users with transaction."""
    try:
        # Begin nested transaction
        with db.begin_nested():
            # Deduct from sender
            stmt = select(User).where(User.id == from_user_id).with_for_update()
            sender = db.execute(stmt).scalar_one()
            sender.balance -= amount

            # Add to receiver
            stmt = select(User).where(User.id == to_user_id).with_for_update()
            receiver = db.execute(stmt).scalar_one()
            receiver.balance += amount

        db.commit()
    except Exception as e:
        db.rollback()
        raise
```

## Async SQLAlchemy

### Async Setup
```python
from sqlalchemy.ext.asyncio import (
    create_async_engine,
    AsyncSession,
    async_sessionmaker
)

# Async engine (note: asyncpg for PostgreSQL, aiosqlite for SQLite)
DATABASE_URL = "postgresql+asyncpg://user:pass@localhost/mydb"

async_engine = create_async_engine(
    DATABASE_URL,
    echo=False,
    pool_size=5,
    max_overflow=10
)

# Async session factory
AsyncSessionLocal = async_sessionmaker(
    async_engine,
    class_=AsyncSession,
    expire_on_commit=False
)

# Create tables
async def init_db():
    async with async_engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
```

### Async CRUD Operations
```python
async def get_user_async(user_id: int) -> Optional[User]:
    """Get user asynchronously."""
    async with AsyncSessionLocal() as session:
        stmt = select(User).where(User.id == user_id)
        result = await session.execute(stmt)
        return result.scalar_one_or_none()

async def create_user_async(email: str, username: str) -> User:
    """Create user asynchronously."""
    async with AsyncSessionLocal() as session:
        user = User(email=email, username=username)
        session.add(user)
        await session.commit()
        await session.refresh(user)
        return user

# FastAPI async dependency
async def get_async_db():
    async with AsyncSessionLocal() as session:
        yield session

@app.get("/users/{user_id}")
async def get_user_endpoint(
    user_id: int,
    db: AsyncSession = Depends(get_async_db)
):
    stmt = select(User).where(User.id == user_id)
    result = await db.execute(stmt)
    return result.scalar_one_or_none()
```

## Alembic Migrations

### Setup Alembic
```bash
# Initialize Alembic
alembic init alembic

# Edit alembic.ini - set database URL
# sqlalchemy.url = postgresql://user:pass@localhost/mydb

# Or use env variable in alembic/env.py
```

### Configure Alembic
```python
# alembic/env.py
from sqlalchemy import engine_from_config, pool
from alembic import context
from myapp.models import Base  # Import your Base

# Add your model's MetaData
target_metadata = Base.metadata

def run_migrations_online():
    """Run migrations in 'online' mode."""
    configuration = config.get_section(config.config_ini_section)
    configuration["sqlalchemy.url"] = os.getenv("DATABASE_URL")

    connectable = engine_from_config(
        configuration,
        prefix="sqlalchemy.",
        poolclass=pool.NullPool,
    )

    with connectable.connect() as connection:
        context.configure(
            connection=connection,
            target_metadata=target_metadata
        )

        with context.begin_transaction():
            context.run_migrations()
```

### Create and Apply Migrations
```bash
# Auto-generate migration from model changes
alembic revision --autogenerate -m "Add users table"

# Review generated migration in alembic/versions/

# Apply migration
alembic upgrade head

# Rollback one version
alembic downgrade -1

# Show current version
alembic current

# Show migration history
alembic history
```

### Manual Migration Example
```python
# alembic/versions/xxx_add_users.py
from alembic import op
import sqlalchemy as sa

def upgrade():
    op.create_table(
        'users',
        sa.Column('id', sa.Integer(), nullable=False),
        sa.Column('email', sa.String(255), nullable=False),
        sa.Column('username', sa.String(50), nullable=False),
        sa.PrimaryKeyConstraint('id')
    )
    op.create_index('ix_users_email', 'users', ['email'], unique=True)

def downgrade():
    op.drop_index('ix_users_email', table_name='users')
    op.drop_table('users')
```

## FastAPI Integration

### Complete FastAPI Example
```python
from fastapi import FastAPI, Depends, HTTPException, status
from sqlalchemy.orm import Session
from pydantic import BaseModel, EmailStr
from typing import List

app = FastAPI()

# Pydantic schemas
class UserBase(BaseModel):
    email: EmailStr
    username: str

class UserCreate(UserBase):
    password: str

class UserResponse(UserBase):
    id: int
    is_active: bool
    created_at: datetime

    class Config:
        from_attributes = True  # SQLAlchemy 2.0 (was orm_mode)

# CRUD operations
@app.post("/users/", response_model=UserResponse, status_code=status.HTTP_201_CREATED)
def create_user_endpoint(user: UserCreate, db: Session = Depends(get_db)):
    # Check if user exists
    stmt = select(User).where(User.email == user.email)
    if db.execute(stmt).scalar_one_or_none():
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Email already registered"
        )

    # Create user
    db_user = User(
        email=user.email,
        username=user.username,
        hashed_password=hash_password(user.password)
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

@app.get("/users/{user_id}", response_model=UserResponse)
def read_user(user_id: int, db: Session = Depends(get_db)):
    stmt = select(User).where(User.id == user_id)
    user = db.execute(stmt).scalar_one_or_none()

    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found"
        )
    return user

@app.get("/users/", response_model=List[UserResponse])
def list_users(
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db)
):
    stmt = (
        select(User)
        .where(User.is_active == True)
        .offset(skip)
        .limit(limit)
    )
    return db.execute(stmt).scalars().all()

@app.put("/users/{user_id}", response_model=UserResponse)
def update_user(
    user_id: int,
    user_update: UserBase,
    db: Session = Depends(get_db)
):
    stmt = select(User).where(User.id == user_id)
    db_user = db.execute(stmt).scalar_one_or_none()

    if not db_user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found"
        )

    db_user.email = user_update.email
    db_user.username = user_update.username
    db.commit()
    db.refresh(db_user)
    return db_user

@app.delete("/users/{user_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_user(user_id: int, db: Session = Depends(get_db)):
    stmt = select(User).where(User.id == user_id)
    db_user = db.execute(stmt).scalar_one_or_none()

    if not db_user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found"
        )

    db.delete(db_user)
    db.commit()
```

## Testing with Pytest

### Test Database Setup
```python
import pytest
from sqlalchemy import create_engine, StaticPool
from sqlalchemy.orm import sessionmaker

# In-memory SQLite for testing
SQLALCHEMY_TEST_DATABASE_URL = "sqlite:///:memory:"

@pytest.fixture(scope="function")
def db_session():
    """Create test database session."""
    engine = create_engine(
        SQLALCHEMY_TEST_DATABASE_URL,
        connect_args={"check_same_thread": False},
        poolclass=StaticPool,
    )

    # Create tables
    Base.metadata.create_all(bind=engine)

    TestingSessionLocal = sessionmaker(
        autocommit=False,
        autoflush=False,
        bind=engine
    )

    session = TestingSessionLocal()
    try:
        yield session
    finally:
        session.close()
        Base.metadata.drop_all(bind=engine)

@pytest.fixture(scope="function")
def test_user(db_session):
    """Create test user."""
    user = User(
        email="test@example.com",
        username="testuser",
        hashed_password="hashed"
    )
    db_session.add(user)
    db_session.commit()
    db_session.refresh(user)
    return user
```

### Test Examples
```python
def test_create_user(db_session):
    """Test user creation."""
    user = User(email="new@example.com", username="newuser")
    db_session.add(user)
    db_session.commit()

    assert user.id is not None
    assert user.email == "new@example.com"
    assert user.created_at is not None

def test_query_user(db_session, test_user):
    """Test user query."""
    stmt = select(User).where(User.email == "test@example.com")
    found_user = db_session.execute(stmt).scalar_one()

    assert found_user.id == test_user.id
    assert found_user.username == test_user.username

def test_update_user(db_session, test_user):
    """Test user update."""
    test_user.username = "updated"
    db_session.commit()

    stmt = select(User).where(User.id == test_user.id)
    updated_user = db_session.execute(stmt).scalar_one()
    assert updated_user.username == "updated"

def test_delete_user(db_session, test_user):
    """Test user deletion."""
    user_id = test_user.id
    db_session.delete(test_user)
    db_session.commit()

    stmt = select(User).where(User.id == user_id)
    assert db_session.execute(stmt).scalar_one_or_none() is None
```

## Performance Optimization

### Query Optimization
```python
# Use indexes
class User(Base):
    __tablename__ = "users"

    email: Mapped[str] = mapped_column(String(255), index=True, unique=True)
    created_at: Mapped[datetime] = mapped_column(index=True)

    # Composite index
    __table_args__ = (
        Index('ix_user_email_active', 'email', 'is_active'),
    )

# Use select_from for complex queries
stmt = (
    select(func.count(Post.id))
    .select_from(User)
    .join(Post)
    .where(User.is_active == True)
)

# Use contains_eager for joined loads
from sqlalchemy.orm import contains_eager

stmt = (
    select(Post)
    .join(Post.author)
    .options(contains_eager(Post.author))
    .where(User.is_active == True)
)
```

### Connection Pooling
```python
# Configure pool
engine = create_engine(
    DATABASE_URL,
    pool_size=20,           # Number of connections to keep
    max_overflow=10,        # Additional connections when pool full
    pool_timeout=30,        # Seconds to wait for connection
    pool_recycle=3600,      # Recycle connections after 1 hour
    pool_pre_ping=True      # Verify connections before use
)

# Monitor pool
from sqlalchemy import event

@event.listens_for(engine, "connect")
def receive_connect(dbapi_conn, connection_record):
    print("New connection established")

@event.listens_for(engine, "checkout")
def receive_checkout(dbapi_conn, connection_record, connection_proxy):
    print("Connection checked out from pool")
```

### Batch Operations
```python
# Bulk insert with executemany
from sqlalchemy import insert

data = [
    {"email": f"user{i}@example.com", "username": f"user{i}"}
    for i in range(1000)
]

stmt = insert(User)
db.execute(stmt, data)
db.commit()

# Bulk update
from sqlalchemy import update

stmt = (
    update(User)
    .where(User.is_active == False)
    .values(deleted_at=func.now())
)
db.execute(stmt)
```

## Best Practices

1. **Use SQLAlchemy 2.0 Syntax**: Modern API with better type hints
2. **Type Annotations**: Use `Mapped[T]` and `mapped_column()`
3. **Eager Loading**: Solve N+1 queries with `selectinload`/`joinedload`
4. **Session Management**: Use dependency injection pattern
5. **Migrations**: Always use Alembic for schema changes
6. **Indexes**: Add indexes for frequently queried columns
7. **Connection Pooling**: Configure appropriate pool settings
8. **Testing**: Use in-memory SQLite for fast tests
9. **Async**: Use `AsyncSession` for async frameworks
10. **Error Handling**: Always handle `NoResultFound` and `MultipleResultsFound`

## Common Patterns

### Repository Pattern
```python
from typing import Generic, TypeVar, Type
from sqlalchemy.orm import Session

T = TypeVar('T', bound=Base)

class BaseRepository(Generic[T]):
    def __init__(self, model: Type[T], db: Session):
        self.model = model
        self.db = db

    def get(self, id: int) -> Optional[T]:
        stmt = select(self.model).where(self.model.id == id)
        return self.db.execute(stmt).scalar_one_or_none()

    def get_all(self, skip: int = 0, limit: int = 100) -> list[T]:
        stmt = select(self.model).offset(skip).limit(limit)
        return self.db.execute(stmt).scalars().all()

    def create(self, obj: T) -> T:
        self.db.add(obj)
        self.db.commit()
        self.db.refresh(obj)
        return obj

    def delete(self, id: int) -> bool:
        obj = self.get(id)
        if obj:
            self.db.delete(obj)
            self.db.commit()
            return True
        return False

# Usage
user_repo = BaseRepository(User, db)
user = user_repo.get(1)
```

### Soft Delete Pattern
```python
class SoftDeleteMixin:
    deleted_at: Mapped[Optional[datetime]] = mapped_column(default=None)

    @property
    def is_deleted(self) -> bool:
        return self.deleted_at is not None

class User(Base, SoftDeleteMixin):
    __tablename__ = "users"
    # ... fields

# Query only active records
stmt = select(User).where(User.deleted_at.is_(None))

# Soft delete
user.deleted_at = datetime.utcnow()
db.commit()
```

### Audit Trail Pattern
```python
class AuditMixin:
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now()
    )
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now(),
        onupdate=func.now()
    )
    created_by: Mapped[Optional[int]] = mapped_column(ForeignKey("users.id"))
    updated_by: Mapped[Optional[int]] = mapped_column(ForeignKey("users.id"))

class Post(Base, AuditMixin):
    __tablename__ = "posts"
    # ... fields
```

## Resources

- [SQLAlchemy 2.0 Documentation](https://docs.sqlalchemy.org/en/20/)
- [Alembic Documentation](https://alembic.sqlalchemy.org/)
- [FastAPI SQLAlchemy Guide](https://fastapi.tiangolo.com/tutorial/sql-databases/)
- [SQLAlchemy Type Annotations](https://docs.sqlalchemy.org/en/20/orm/declarative_tables.html#mapped-column-derives-the-datatype-and-nullability-from-the-mapped-annotation)

## Related Skills

When using Sqlalchemy, these skills enhance your workflow:
- **django**: Django ORM patterns and migration strategies for comparison
- **test-driven-development**: TDD patterns for database models and queries
- **fastapi-local-dev**: FastAPI + SQLAlchemy integration patterns
- **systematic-debugging**: Advanced debugging for ORM query issues and N+1 problems

[Full documentation available in these skills if deployed in your bundle]
