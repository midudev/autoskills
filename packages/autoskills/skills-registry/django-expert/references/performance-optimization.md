# Django Performance Optimization

## Database Query Optimization

### Avoid N+1 Queries (Most Important!)

```python
# ❌ BAD: N+1 queries
posts = Post.objects.all()
for post in posts:
    print(post.author.username)  # N additional queries!

# ✅ GOOD: 1 query with JOIN
posts = Post.objects.select_related('author').all()
for post in posts:
    print(post.author.username)  # No additional queries!
```

See `models-and-orm.md` for comprehensive coverage of select_related, prefetch_related, and query optimization.

### Use only() and defer()

```python
# ✅ GOOD: Load only needed fields
users = User.objects.only('id', 'username', 'email')

# ✅ GOOD: Exclude large fields
posts = Post.objects.defer('content')  # Skip content field
```

### Database Indexes

```python
class Post(models.Model):
    title = models.CharField(max_length=200)
    created_at = models.DateTimeField(auto_now_add=True)
    is_published = models.BooleanField(default=False)
    view_count = models.IntegerField(default=0)

    class Meta:
        indexes = [
            models.Index(fields=['created_at']),  # For ordering
            models.Index(fields=['is_published', 'created_at']),  # Composite
            models.Index(fields=['-view_count']),  # For popular posts
        ]

# ✅ GOOD: Check if index is used
# Run: EXPLAIN ANALYZE SELECT ...
from django.db import connection
queryset = Post.objects.filter(is_published=True).order_by('-created_at')
print(queryset.query)
```

### Bulk Operations

```python
# ❌ BAD: N queries
for i in range(1000):
    Post.objects.create(title=f'Post {i}')

# ✅ GOOD: 1 query
posts = [Post(title=f'Post {i}') for i in range(1000)]
Post.objects.bulk_create(posts, batch_size=500)

# ❌ BAD: N updates
for post in posts:
    post.view_count += 1
    post.save()

# ✅ GOOD: 1 query
Post.objects.filter(id__in=post_ids).update(view_count=F('view_count') + 1)
```

### Query Profiling

```python
from django.db import connection
from django.test.utils import override_settings

# Check number of queries
with override_settings(DEBUG=True):
    posts = Post.objects.select_related('author').all()
    list(posts)  # Force evaluation
    print(f"Queries: {len(connection.queries)}")
    for query in connection.queries:
        print(query['sql'])
```

## Caching

### Cache Framework Setup

```python
# settings.py
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.redis.RedisCache',
        'LOCATION': 'redis://127.0.0.1:6379/1',
        'OPTIONS': {
            'CLIENT_CLASS': 'django_redis.client.DefaultClient',
        },
        'KEY_PREFIX': 'myapp',
        'TIMEOUT': 300,  # 5 minutes default
    }
}
```

### Low-Level Cache API

```python
from django.core.cache import cache

# ✅ GOOD: Cache expensive queries
def get_popular_posts():
    posts = cache.get('popular_posts')
    if posts is None:
        posts = Post.objects.filter(
            is_published=True
        ).select_related('author').order_by('-view_count')[:10]
        cache.set('popular_posts', posts, timeout=300)  # 5 minutes
    return posts

# ✅ GOOD: Cache with complex key
def get_user_posts(user_id):
    cache_key = f'user_{user_id}_posts'
    posts = cache.get(cache_key)
    if posts is None:
        posts = Post.objects.filter(author_id=user_id)
        cache.set(cache_key, posts, timeout=600)
    return posts

# Invalidate cache
def create_post(user, data):
    post = Post.objects.create(author=user, **data)
    cache.delete(f'user_{user.id}_posts')  # Invalidate
    cache.delete('popular_posts')
    return post
```

### Per-View Cache

```python
from django.views.decorators.cache import cache_page

# ✅ GOOD: Cache entire view response
@cache_page(60 * 15)  # 15 minutes
def blog_list(request):
    posts = Post.objects.filter(is_published=True)
    return render(request, 'blog/list.html', {'posts': posts})

# ✅ GOOD: Cache with conditional logic
from django.views.decorators.cache import cache_control

@cache_control(max_age=3600, public=True)
def public_content(request):
    # Browser and CDN can cache for 1 hour
    ...
```

### Template Fragment Caching

```django
{% load cache %}

{# ✅ GOOD: Cache expensive template sections #}
{% cache 300 sidebar %}
  {% for category in categories %}
    <li>{{ category.name }} ({{ category.post_count }})</li>
  {% endfor %}
{% endcache %}

{# ✅ GOOD: Cache with variables #}
{% cache 600 post_detail post.id post.updated_at %}
  <h1>{{ post.title }}</h1>
  <div>{{ post.content }}</div>
{% endcache %}
```

### Caching Patterns

```python
# ✅ GOOD: Cache with get_or_set
from django.core.cache import cache

def get_post_stats(post_id):
    cache_key = f'post_{post_id}_stats'
    return cache.get_or_set(
        cache_key,
        lambda: compute_expensive_stats(post_id),
        timeout=3600
    )

# ✅ GOOD: Cache invalidation pattern
class Post(models.Model):
    ...

    def save(self, *args, **kwargs):
        super().save(*args, **kwargs)
        # Invalidate related caches
        cache.delete(f'post_{self.id}_detail')
        cache.delete('popular_posts')
        cache.delete(f'user_{self.author_id}_posts')

    def delete(self, *args, **kwargs):
        cache.delete(f'post_{self.id}_detail')
        cache.delete('popular_posts')
        super().delete(*args, **kwargs)
```

## Database Connection Pooling

### Using pgbouncer (PostgreSQL)

```python
# settings.py
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'mydb',
        'USER': 'myuser',
        'PASSWORD': 'mypass',
        'HOST': '127.0.0.1',
        'PORT': '6432',  # pgbouncer port
        'CONN_MAX_AGE': 600,  # Connection pooling
        'OPTIONS': {
            'connect_timeout': 10,
        },
    }
}
```

### Django-DB-Pool

```bash
pip install django-db-pool
```

```python
# settings.py
DATABASES = {
    'default': {
        'ENGINE': 'django_db_pool.backends.postgresql',
        'POOL_OPTIONS': {
            'POOL_SIZE': 10,
            'MAX_OVERFLOW': 10,
        },
        ...
    }
}
```

## Static File Optimization

### Compression and Minification

```bash
pip install django-compressor
```

```python
# settings.py
INSTALLED_APPS += ['compressor']

COMPRESS_ENABLED = True
COMPRESS_CSS_FILTERS = [
    'compressor.filters.css_default.CssAbsoluteFilter',
    'compressor.filters.cssmin.CSSMinFilter',
]
COMPRESS_JS_FILTERS = [
    'compressor.filters.jsmin.JSMinFilter',
]

STATICFILES_FINDERS = [
    'django.contrib.staticfiles.finders.FileSystemFinder',
    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
    'compressor.finders.CompressorFinder',
]
```

```django
{% load compress %}

{% compress css %}
  <link rel="stylesheet" href="{% static 'css/style1.css' %}">
  <link rel="stylesheet" href="{% static 'css/style2.css' %}">
{% endcompress %}

{% compress js %}
  <script src="{% static 'js/script1.js' %}"></script>
  <script src="{% static 'js/script2.js' %}"></script>
{% endcompress %}
```

### CDN for Static Files

```python
# settings.py
# Use WhiteNoise for serving static files
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'whitenoise.middleware.WhiteNoiseMiddleware',  # Add this
    ...
]

STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'

# Or use S3/CloudFront
DEFAULT_FILE_STORAGE = 'storages.backends.s3boto3.S3Boto3Storage'
STATICFILES_STORAGE = 'storages.backends.s3boto3.S3StaticStorage'

AWS_S3_CUSTOM_DOMAIN = 'd123456.cloudfront.net'
STATIC_URL = f'https://{AWS_S3_CUSTOM_DOMAIN}/static/'
```

## Background Tasks with Celery

```bash
pip install celery redis
```

```python
# celery.py
from celery import Celery
import os

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'myproject.settings')

app = Celery('myproject')
app.config_from_object('django.conf:settings', namespace='CELERY')
app.autodiscover_tasks()

# settings.py
CELERY_BROKER_URL = 'redis://localhost:6379/0'
CELERY_RESULT_BACKEND = 'redis://localhost:6379/0'
CELERY_TASK_SERIALIZER = 'json'
CELERY_ACCEPT_CONTENT = ['json']
CELERY_TIMEZONE = 'UTC'

# tasks.py
from celery import shared_task
import time

@shared_task
def send_email(user_id, template):
    """Send email asynchronously."""
    user = User.objects.get(id=user_id)
    # Send email logic
    time.sleep(2)  # Simulate email sending
    return f'Email sent to {user.email}'

@shared_task
def generate_report(report_id):
    """Generate report in background."""
    report = Report.objects.get(id=report_id)
    # Generate report logic
    report.status = 'completed'
    report.save()
    return report_id

# views.py
def register(request):
    user = User.objects.create_user(...)
    # ✅ GOOD: Send email asynchronously
    send_email.delay(user.id, 'welcome')
    return redirect('home')
```

## Pagination

```python
from django.core.paginator import Paginator

# ✅ GOOD: Paginate large querysets
def blog_list(request):
    posts = Post.objects.filter(is_published=True).select_related('author')
    paginator = Paginator(posts, 20)  # 20 posts per page

    page_number = request.GET.get('page', 1)
    page_obj = paginator.get_page(page_number)

    return render(request, 'blog/list.html', {'page_obj': page_obj})

# DRF pagination
# settings.py
REST_FRAMEWORK = {
    'DEFAULT_PAGINATION_CLASS': 'rest_framework.pagination.LimitOffsetPagination',
    'PAGE_SIZE': 20,
}
```

## Middleware Optimization

```python
# ✅ GOOD: Conditional middleware
class ExpensiveMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # Skip for static files
        if request.path.startswith('/static/'):
            return self.get_response(request)

        # Only run for specific paths
        if request.path.startswith('/api/'):
            # Expensive processing
            ...

        response = self.get_response(request)
        return response
```

## Template Optimization

### Use Template Fragment Caching

```django
{% load cache %}

{# Cache expensive queries #}
{% cache 300 sidebar request.user.id %}
  {% include "sidebar.html" %}
{% endcache %}
```

### Avoid Logic in Templates

```django
{# ❌ BAD: N+1 queries in template #}
{% for post in posts %}
  <h2>{{ post.title }}</h2>
  <p>By {{ post.author.username }}</p>  {# N queries! #}
  <p>{{ post.comments.count }} comments</p>  {# N queries! #}
{% endfor %}

{# ✅ GOOD: Preload in view #}
{# posts = Post.objects.select_related('author').annotate(comment_count=Count('comments')) #}
{% for post in posts %}
  <h2>{{ post.title }}</h2>
  <p>By {{ post.author.username }}</p>
  <p>{{ post.comment_count }} comments</p>
{% endfor %}
```

## Profiling and Monitoring

### Django Debug Toolbar

```bash
pip install django-debug-toolbar
```

```python
# settings.py
INSTALLED_APPS += ['debug_toolbar']
MIDDLEWARE += ['debug_toolbar.middleware.DebugToolbarMiddleware']

INTERNAL_IPS = ['127.0.0.1']

# urls.py
from django.conf import settings

if settings.DEBUG:
    import debug_toolbar
    urlpatterns = [
        path('__debug__/', include(debug_toolbar.urls)),
    ] + urlpatterns
```

Shows:
- Number of SQL queries
- Duplicate queries
- Query execution time
- Template rendering time
- Cache hits/misses

### Django Silk (Production Profiling)

```bash
pip install django-silk
```

```python
# settings.py
INSTALLED_APPS += ['silk']
MIDDLEWARE += ['silk.middleware.SilkyMiddleware']

# urls.py
urlpatterns += [path('silk/', include('silk.urls', namespace='silk'))]
```

### Custom Performance Logging

```python
import logging
import time
from functools import wraps

logger = logging.getLogger(__name__)

def log_performance(func):
    """Decorator to log function performance."""
    @wraps(func)
    def wrapper(*args, **kwargs):
        start = time.time()
        result = func(*args, **kwargs)
        duration = time.time() - start

        if duration > 1.0:  # Log if > 1 second
            logger.warning(
                f"{func.__name__} took {duration:.2f}s",
                extra={'duration': duration}
            )

        return result
    return wrapper

@log_performance
def expensive_view(request):
    # View logic
    ...
```

## Database Optimization Checklist

✅ Use select_related() for ForeignKey/OneToOne
✅ Use prefetch_related() for ManyToMany/reverse FK
✅ Add database indexes for filtered/ordered fields
✅ Use only()/defer() for partial model loading
✅ Use values()/values_list() for raw data
✅ Use bulk_create()/bulk_update() for batch operations
✅ Use update() instead of save() when possible
✅ Use exists() instead of counting
✅ Use iterator() for large querysets
✅ Avoid N+1 queries (check with Debug Toolbar)

## Caching Checklist

✅ Cache expensive database queries
✅ Cache API responses
✅ Cache template fragments
✅ Use cache versioning for invalidation
✅ Set appropriate cache timeouts
✅ Monitor cache hit rates
✅ Use Redis for production caching
✅ Invalidate cache on data changes

## General Performance Checklist

✅ Enable database connection pooling
✅ Compress and minify static files
✅ Use CDN for static files
✅ Enable GZIP compression
✅ Offload heavy tasks to Celery
✅ Paginate large result sets
✅ Profile with Django Debug Toolbar
✅ Monitor production performance (Sentry, New Relic, etc.)
✅ Optimize images (compress, lazy load)
✅ Use HTTP/2 and browser caching headers

---

**Remember**: Measure first, optimize second. Don't optimize prematurely - profile to find real bottlenecks, then fix them systematically.
