# Django ORM Best Practices

## The N+1 Query Problem

The most common performance issue in Django applications.

### Problem Example

```python
# ❌ BAD: N+1 queries (1 + N where N = number of users)
users = User.objects.all()  # 1 query
for user in users:
    print(user.profile.bio)  # N additional queries!
```

This results in:
```sql
SELECT * FROM users;                    -- 1 query
SELECT * FROM profiles WHERE user_id=1; -- Query for each user
SELECT * FROM profiles WHERE user_id=2;
SELECT * FROM profiles WHERE user_id=3;
-- ... etc
```

### Solution: select_related()

Use `select_related()` for **foreign key** and **one-to-one** relationships:

```python
# ✅ GOOD: 1 query with JOIN
users = User.objects.select_related('profile').all()
for user in users:
    print(user.profile.bio)  # No additional queries!
```

This results in:
```sql
SELECT *
FROM users
INNER JOIN profiles ON users.id = profiles.user_id;  -- 1 query
```

### Solution: prefetch_related()

Use `prefetch_related()` for **many-to-many** and **reverse foreign key** relationships:

```python
# ❌ BAD: N+1 queries
users = User.objects.all()
for user in users:
    for group in user.groups.all():  # N queries!
        print(group.name)

# ✅ GOOD: 2 queries total
users = User.objects.prefetch_related('groups').all()
for user in users:
    for group in user.groups.all():  # No additional queries!
        print(group.name)
```

This results in:
```sql
SELECT * FROM users;                                    -- Query 1
SELECT * FROM groups
INNER JOIN user_groups ON groups.id = user_groups.group_id
WHERE user_groups.user_id IN (1, 2, 3, ...);           -- Query 2
```

## Combining select_related() and prefetch_related()

```python
# Get users with their profiles AND groups in 2 queries
users = User.objects.select_related('profile').prefetch_related('groups').all()
```

## Advanced Prefetching

### Prefetch with Filtering

```python
from django.db.models import Prefetch

# Only prefetch active posts
users = User.objects.prefetch_related(
    Prefetch(
        'posts',
        queryset=Post.objects.filter(is_published=True).order_by('-created_at')
    )
).all()
```

### Nested Prefetching

```python
# Get users with their posts and each post's comments
users = User.objects.prefetch_related(
    'posts',
    'posts__comments',
    'posts__comments__author'
).all()
```

## Custom Managers

Encapsulate common queries in custom managers:

```python
class UserManager(models.Manager):
    def active(self):
        """Get active users."""
        return self.filter(is_active=True)

    def with_profile(self):
        """Always include profile to prevent N+1."""
        return self.select_related('profile')

    def with_full_details(self):
        """Get users with all related data."""
        return self.select_related('profile').prefetch_related(
            'groups',
            'user_permissions',
            Prefetch(
                'posts',
                queryset=Post.objects.filter(is_published=True)
            )
        )

class User(AbstractUser):
    objects = UserManager()

# Usage
active_users = User.objects.active().with_profile()
detailed_users = User.objects.with_full_details()
```

## QuerySet Methods

### only() and defer()

Load only specific fields when you don't need the entire model:

```python
# only() - Load ONLY specified fields
users = User.objects.only('id', 'email', 'first_name')
# SELECT id, email, first_name FROM users

# defer() - Load ALL fields EXCEPT specified
users = User.objects.defer('password', 'last_login')
# SELECT id, email, first_name, ... FROM users (excludes password, last_login)
```

**Warning**: Accessing deferred fields triggers an additional query!

```python
users = User.objects.defer('bio').all()
for user in users:
    print(user.bio)  # Additional query per user!
```

### values() and values_list()

Get dictionaries or tuples instead of model instances (faster):

```python
# values() - Returns dictionaries
users = User.objects.values('id', 'email')
# [{'id': 1, 'email': 'user@example.com'}, ...]

# values_list() - Returns tuples
user_ids = User.objects.values_list('id', flat=True)
# [1, 2, 3, 4, ...]

user_data = User.objects.values_list('id', 'email')
# [(1, 'user@example.com'), (2, 'other@example.com'), ...]
```

### exists() and count()

```python
# ❌ BAD: Loads all objects into memory
if len(User.objects.filter(email=email)):
    ...

# ✅ GOOD: Database-level check
if User.objects.filter(email=email).exists():
    ...

# ❌ BAD: Loads all objects to count
total = len(User.objects.all())

# ✅ GOOD: Database-level count
total = User.objects.count()
```

## Aggregation & Annotation

### aggregate()

Get summary statistics:

```python
from django.db.models import Count, Avg, Max, Min, Sum

# Get statistics about all users
stats = User.objects.aggregate(
    total=Count('id'),
    avg_posts=Avg('posts__count'),
    max_created=Max('created_at')
)
# {'total': 100, 'avg_posts': 5.2, 'max_created': datetime(...)}
```

### annotate()

Add calculated fields to each object:

```python
from django.db.models import Count, Q

# Add post count to each user
users = User.objects.annotate(
    total_posts=Count('posts'),
    published_posts=Count('posts', filter=Q(posts__is_published=True))
)

for user in users:
    print(f"{user.email}: {user.total_posts} total, {user.published_posts} published")
```

## Bulk Operations

### bulk_create()

Create multiple objects in one query:

```python
# ❌ BAD: N queries
for i in range(1000):
    User.objects.create(email=f"user{i}@example.com")

# ✅ GOOD: 1 query
users = [
    User(email=f"user{i}@example.com")
    for i in range(1000)
]
User.objects.bulk_create(users, batch_size=500)
```

**Note**: `bulk_create()` doesn't call `save()` or send signals!

### bulk_update()

Update multiple objects in one query:

```python
# ❌ BAD: N queries
for user in users:
    user.is_active = False
    user.save()

# ✅ GOOD: 1 query
for user in users:
    user.is_active = False
User.objects.bulk_update(users, ['is_active'], batch_size=500)
```

### update()

Update multiple objects with one query:

```python
# ❌ BAD: N queries
for user in User.objects.filter(is_active=True):
    user.last_login = timezone.now()
    user.save()

# ✅ GOOD: 1 query
User.objects.filter(is_active=True).update(last_login=timezone.now())
```

**Note**: `update()` doesn't call `save()` or send signals!

## Database Indexes

Add indexes for fields used in:
- Filtering (`WHERE` clauses)
- Ordering (`ORDER BY`)
- Joins (`FOREIGN KEY`)

```python
class User(models.Model):
    email = models.EmailField(unique=True)  # Automatic index
    created_at = models.DateTimeField(auto_now_add=True)
    is_active = models.BooleanField(default=True)

    class Meta:
        indexes = [
            models.Index(fields=['created_at']),  # Single field
            models.Index(fields=['is_active', 'created_at']),  # Composite
            models.Index(fields=['-created_at']),  # Descending order
        ]
```

### When to Add Indexes

✅ **Add indexes for:**
- Foreign keys (automatically indexed)
- Fields used in `filter()` frequently
- Fields used in `order_by()` frequently
- Unique fields (automatically indexed)

❌ **Don't add indexes for:**
- Fields that are rarely queried
- Small tables (< 1000 rows)
- Fields that change frequently
- Too many indexes (slows down writes)

## Query Optimization Patterns

### 1. Filter Early, Annotate/Aggregate Late

```python
# ✅ GOOD: Filter before annotation
active_users = User.objects.filter(is_active=True).annotate(
    post_count=Count('posts')
)

# ❌ BAD: Annotate then filter (processes all rows first)
active_users = User.objects.annotate(
    post_count=Count('posts')
).filter(is_active=True)
```

### 2. Use iterator() for Large QuerySets

```python
# ❌ BAD: Loads all 1M users into memory
for user in User.objects.all():
    process_user(user)

# ✅ GOOD: Streams users in chunks
for user in User.objects.all().iterator(chunk_size=1000):
    process_user(user)
```

### 3. Avoid Chaining Multiple Queries

```python
# ❌ BAD: Multiple queries
active_users = User.objects.filter(is_active=True)
verified_users = active_users.filter(email_verified=True)
recent_users = verified_users.filter(created_at__gte=last_week)

# ✅ GOOD: Single query
recent_users = User.objects.filter(
    is_active=True,
    email_verified=True,
    created_at__gte=last_week
)
```

## Transactions

Use transactions for operations that must succeed or fail together:

```python
from django.db import transaction

# Atomic decorator
@transaction.atomic
def create_user_with_profile(data):
    user = User.objects.create(**data['user'])
    Profile.objects.create(user=user, **data['profile'])
    return user

# Atomic context manager
def transfer_credits(from_user, to_user, amount):
    with transaction.atomic():
        from_user.credits -= amount
        from_user.save()

        to_user.credits += amount
        to_user.save()

# Rollback on error
try:
    with transaction.atomic():
        User.objects.create(email=email)
        send_welcome_email(email)  # If this fails, user creation is rolled back
except Exception:
    # Transaction automatically rolled back
    logger.exception("Failed to create user")
```

## Raw SQL (When Necessary)

Sometimes the ORM can't express complex queries efficiently:

```python
# Use raw SQL as a last resort
users = User.objects.raw('''
    SELECT u.*, COUNT(p.id) as post_count
    FROM users u
    LEFT JOIN posts p ON u.id = p.user_id
    GROUP BY u.id
    HAVING COUNT(p.id) > 10
''')

# ALWAYS use parameters to prevent SQL injection
users = User.objects.raw(
    'SELECT * FROM users WHERE created_at > %s',
    [start_date]
)
```

## Debugging Queries

### See Generated SQL

```python
queryset = User.objects.filter(is_active=True)
print(queryset.query)  # Print SQL

# Or in shell
from django.db import connection
print(connection.queries)  # All queries executed
```

### Django Debug Toolbar

Install and use django-debug-toolbar in development:

```bash
pip install django-debug-toolbar
```

Shows:
- Number of queries per request
- Duplicate queries
- Slow queries
- SQL for each query

## Performance Checklist

Before deploying a feature:

✅ Check for N+1 queries
✅ Use select_related() for FK/OneToOne
✅ Use prefetch_related() for M2M/reverse FK
✅ Add database indexes for filtered/ordered fields
✅ Use bulk operations for creating/updating many objects
✅ Use only()/defer() when loading partial models
✅ Use exists() instead of if queryset
✅ Use count() instead of len(queryset)
✅ Wrap multi-step operations in transactions
✅ Test with production-sized data

---

**Remember**: Premature optimization is the root of all evil, but N+1 queries are not premature - they're fundamental!