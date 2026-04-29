# Django Production Deployment Reference

This guide covers essential configuration and best practices for deploying Django applications to production environments.

## Pre-Deployment Checklist

### Run Deployment Checks

Django provides an automated deployment check command:

```bash
python manage.py check --deploy
```

This validates critical settings and warns about common misconfigurations.

**Rule**: Always run `check --deploy` before going live.

### Switch from Development Server

```bash
# ❌ NEVER use in production
python manage.py runserver

# ✅ Use production-ready servers
gunicorn myproject.wsgi:application
# or
uvicorn myproject.asgi:application
# or
daphne myproject.asgi:application
```

**Common WSGI/ASGI servers:**
- **Gunicorn**: Standard WSGI server, excellent for most Django apps
- **uWSGI**: High-performance WSGI server with many features
- **Uvicorn**: ASGI server for async Django (channels, async views)
- **Daphne**: ASGI server built for Django Channels

---

## Critical Settings

### SECRET_KEY

**Never commit `SECRET_KEY` to version control.**

```python
# ✅ GOOD: Load from environment
import os
SECRET_KEY = os.environ["SECRET_KEY"]

# ✅ GOOD: Load from file
with open("/etc/secrets/django_secret_key.txt") as f:
    SECRET_KEY = f.read().strip()

# ✅ GOOD: Using python-decouple
from decouple import config
SECRET_KEY = config('SECRET_KEY')

# ❌ BAD: Hardcoded in settings
SECRET_KEY = 'django-insecure-hardcoded-key-123'
```

**Key rotation with fallbacks:**

```python
SECRET_KEY = os.environ["CURRENT_SECRET_KEY"]
SECRET_KEY_FALLBACKS = [
    os.environ["OLD_SECRET_KEY"],
]
```

This allows existing sessions to work during key rotation. Remove old keys from fallbacks after sufficient time.

**Rule**: Treat `SECRET_KEY` like a database password.

### DEBUG

```python
# ✅ PRODUCTION: Debug disabled
DEBUG = False

# ✅ GOOD: Environment-based
DEBUG = os.environ.get('DJANGO_DEBUG', 'False') == 'True'

# ❌ NEVER in production
DEBUG = True
```

**Why `DEBUG = True` is dangerous:**
- Exposes source code in error pages
- Shows database queries and local variables
- Reveals settings and library versions
- Significantly impacts performance

**Rule**: `DEBUG = False` in production, always.

### ALLOWED_HOSTS

```python
# ✅ PRODUCTION: Specific hosts only
ALLOWED_HOSTS = ['example.com', 'www.example.com']

# ✅ GOOD: From environment
ALLOWED_HOSTS = os.environ.get('ALLOWED_HOSTS', '').split(',')

# ❌ BAD: Allows any host (CSRF vulnerability)
ALLOWED_HOSTS = ['*']

# ❌ BAD: Empty (Django will refuse to run)
ALLOWED_HOSTS = []
```

**Nginx configuration to handle invalid hosts:**

```nginx
server {
    listen 80 default_server;
    server_name _;
    return 444;  # Close connection without response
}

server {
    listen 80;
    server_name example.com www.example.com;
    # Your Django app configuration
}
```

**Rule**: Always specify exact hostnames in production.

---

## Database Configuration

### Connection Settings

```python
# ✅ PRODUCTION: Secure connection parameters
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': os.environ['DB_NAME'],
        'USER': os.environ['DB_USER'],
        'PASSWORD': os.environ['DB_PASSWORD'],
        'HOST': os.environ['DB_HOST'],
        'PORT': os.environ.get('DB_PORT', '5432'),
        'CONN_MAX_AGE': 600,  # Persistent connections
        'OPTIONS': {
            'sslmode': 'require',  # Enforce SSL
        },
    }
}

# ❌ BAD: Hardcoded credentials
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'mydb',
        'USER': 'postgres',
        'PASSWORD': 'password123',
        'HOST': 'localhost',
    }
}
```

### Connection Pooling

```python
# ✅ GOOD: Persistent connections
DATABASES = {
    'default': {
        'CONN_MAX_AGE': 600,  # Keep connections open for 10 minutes
    }
}

# ✅ BETTER: External connection pooler (PgBouncer)
DATABASES = {
    'default': {
        'HOST': 'pgbouncer-host',
        'PORT': 6432,
        'CONN_MAX_AGE': None,  # Let PgBouncer handle pooling
    }
}
```

**Rule**: Enable persistent connections or use external pooling.

### Database Backups

```bash
# PostgreSQL backup
pg_dump -h localhost -U user -d database > backup.sql

# Automated backups (example cron)
0 2 * * * pg_dump -h localhost -U user -d database | gzip > /backups/db_$(date +\%Y\%m\%d).sql.gz
```

**Rule**: Set up automated backups before going live.

---

## HTTPS Configuration

**All production sites must use HTTPS**, especially those handling authentication.

### SSL/TLS Settings

```python
# ✅ PRODUCTION: Force HTTPS
SECURE_SSL_REDIRECT = True

# ✅ GOOD: Strict Transport Security
SECURE_HSTS_SECONDS = 31536000  # 1 year
SECURE_HSTS_INCLUDE_SUBDOMAINS = True
SECURE_HSTS_PRELOAD = True

# ✅ REQUIRED: Secure cookies
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SECURE = True

# ✅ GOOD: Additional cookie security
SESSION_COOKIE_HTTPONLY = True
CSRF_COOKIE_HTTPONLY = True
SESSION_COOKIE_SAMESITE = 'Lax'
CSRF_COOKIE_SAMESITE = 'Lax'
```

**HSTS (HTTP Strict Transport Security) considerations:**
- Start with shorter duration for testing: `SECURE_HSTS_SECONDS = 3600`
- Increase gradually: 1 week → 1 month → 1 year
- Only enable `PRELOAD` after testing with shorter durations
- Be aware: HSTS cannot be easily undone

### Nginx SSL Configuration

```nginx
server {
    listen 443 ssl http2;
    server_name example.com;

    ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;

    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

**Rule**: Never serve authenticated pages over HTTP.

---

## Static and Media Files

### Static Files

```python
# settings.py
STATIC_URL = '/static/'
STATIC_ROOT = '/var/www/myproject/static/'

# ✅ GOOD: Use CDN for static files
STATIC_URL = 'https://cdn.example.com/static/'

# ✅ GOOD: Enable compression
STORAGES = {
    "staticfiles": {
        "BACKEND": "whitenoise.storage.CompressedManifestStaticFilesStorage",
    },
}
```

**Collect static files before deployment:**

```bash
python manage.py collectstatic --no-input
```

**Nginx static file serving:**

```nginx
location /static/ {
    alias /var/www/myproject/static/;
    expires 1y;
    add_header Cache-Control "public, immutable";
}
```

**Rule**: Serve static files through CDN or reverse proxy, not Django.

### Media Files

```python
# settings.py
MEDIA_URL = '/media/'
MEDIA_ROOT = '/var/www/myproject/media/'

# ✅ BETTER: Use object storage
DEFAULT_FILE_STORAGE = 'storages.backends.s3boto3.S3Boto3Storage'
AWS_STORAGE_BUCKET_NAME = 'my-bucket'
AWS_S3_CUSTOM_DOMAIN = 'cdn.example.com'
```

**Nginx media file serving:**

```nginx
location /media/ {
    alias /var/www/myproject/media/;

    # ✅ CRITICAL: Prevent script execution
    location ~ \.(php|py|pl|sh|cgi)$ {
        deny all;
    }
}
```

**Security considerations:**
- Never execute uploaded files
- Validate file types before saving
- Use unique filenames to prevent overwrites
- Set up backups for user uploads
- Consider virus scanning for uploaded files

**Rule**: Treat all media files as untrusted user input.

---

## Caching

### Cache Backend

```python
# ✅ PRODUCTION: Redis cache
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.redis.RedisCache',
        'LOCATION': os.environ.get('REDIS_URL', 'redis://127.0.0.1:6379/1'),
        'OPTIONS': {
            'CLIENT_CLASS': 'django_redis.client.DefaultClient',
            'PASSWORD': os.environ.get('REDIS_PASSWORD'),
        },
        'KEY_PREFIX': 'myapp',
        'TIMEOUT': 300,
    }
}

# ❌ DEVELOPMENT ONLY: Dummy cache
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.dummy.DummyCache',
    }
}
```

### Session Backend

```python
# ✅ PRODUCTION: Cached sessions
SESSION_ENGINE = 'django.contrib.sessions.backends.cached_db'

# ✅ ALSO GOOD: Redis sessions
SESSION_ENGINE = 'django.contrib.sessions.backends.cache'
SESSION_CACHE_ALIAS = 'default'

# ✅ GOOD: Set reasonable session timeout
SESSION_COOKIE_AGE = 86400  # 24 hours
```

**Clear expired sessions regularly:**

```bash
# Add to cron
python manage.py clearsessions
```

**Rule**: Use Redis or Memcached for production caching.

### Template Caching

```python
# ✅ PRODUCTION: Cached template loader
TEMPLATES = [{
    'BACKEND': 'django.template.backends.django.DjangoTemplates',
    'OPTIONS': {
        'loaders': [
            ('django.template.loaders.cached.Loader', [
                'django.template.loaders.filesystem.Loader',
                'django.template.loaders.app_directories.Loader',
            ]),
        ],
    },
}]
```

This is automatically enabled when `DEBUG = False`, but explicit configuration provides better control.

---

## Email Configuration

### SMTP Settings

```python
# ✅ PRODUCTION: Proper email configuration
EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = os.environ.get('EMAIL_HOST', 'smtp.sendgrid.net')
EMAIL_PORT = int(os.environ.get('EMAIL_PORT', 587))
EMAIL_USE_TLS = True
EMAIL_HOST_USER = os.environ['EMAIL_HOST_USER']
EMAIL_HOST_PASSWORD = os.environ['EMAIL_HOST_PASSWORD']

DEFAULT_FROM_EMAIL = 'noreply@example.com'
SERVER_EMAIL = 'server@example.com'

# ❌ DEVELOPMENT ONLY: Console backend
EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'
```

**Email services:**
- **SendGrid**: Reliable transactional email
- **Mailgun**: Good deliverability and analytics
- **Amazon SES**: Cost-effective for high volume
- **Postmark**: Excellent for transactional email

**Rule**: Use a professional email service, not localhost.

---

## Error Monitoring and Logging

### Logging Configuration

```python
# ✅ PRODUCTION: Comprehensive logging
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'verbose': {
            'format': '{levelname} {asctime} {module} {process:d} {thread:d} {message}',
            'style': '{',
        },
    },
    'handlers': {
        'file': {
            'level': 'ERROR',
            'class': 'logging.handlers.RotatingFileHandler',
            'filename': '/var/log/django/error.log',
            'maxBytes': 1024 * 1024 * 10,  # 10 MB
            'backupCount': 5,
            'formatter': 'verbose',
        },
        'console': {
            'level': 'INFO',
            'class': 'logging.StreamHandler',
            'formatter': 'verbose',
        },
    },
    'loggers': {
        'django': {
            'handlers': ['file', 'console'],
            'level': 'INFO',
            'propagate': False,
        },
        'myapp': {
            'handlers': ['file', 'console'],
            'level': 'INFO',
            'propagate': False,
        },
    },
}
```

### Error Notifications

```python
# ✅ GOOD: Admin notifications
ADMINS = [
    ('Admin Name', 'admin@example.com'),
]

MANAGERS = [
    ('Manager Name', 'manager@example.com'),
]

# Filter spurious 404s
IGNORABLE_404_URLS = [
    re.compile(r'\.(php|cgi)$'),
    re.compile(r'^/phpmyadmin/'),
]
```

**Limitations of email notifications:**
- Don't scale well with traffic
- Can overwhelm email
- No aggregation or analytics
- Delayed notification

### Sentry Integration

```python
# ✅ BETTER: Sentry for error tracking
import sentry_sdk
from sentry_sdk.integrations.django import DjangoIntegration

sentry_sdk.init(
    dsn=os.environ.get('SENTRY_DSN'),
    integrations=[DjangoIntegration()],
    traces_sample_rate=0.1,  # Performance monitoring
    send_default_pii=False,  # Don't send personal data
    environment=os.environ.get('ENVIRONMENT', 'production'),
)
```

**Benefits of Sentry:**
- Real-time error tracking
- Error aggregation and deduplication
- Stack trace analysis
- Performance monitoring
- Release tracking

**Rule**: Use Sentry or similar service for production error monitoring.

---

## Security Headers

```python
# ✅ PRODUCTION: Security headers
SECURE_BROWSER_XSS_FILTER = True
SECURE_CONTENT_TYPE_NOSNIFF = True
X_FRAME_OPTIONS = 'DENY'

# ✅ GOOD: Content Security Policy
CSP_DEFAULT_SRC = ("'self'",)
CSP_SCRIPT_SRC = ("'self'", "'unsafe-inline'")  # Avoid unsafe-inline in production
CSP_STYLE_SRC = ("'self'", "'unsafe-inline'")
CSP_IMG_SRC = ("'self'", "data:", "https:")
```

**Using django-csp:**

```python
MIDDLEWARE = [
    # ...
    'csp.middleware.CSPMiddleware',
]

CSP_DEFAULT_SRC = ("'none'",)
CSP_SCRIPT_SRC = ("'self'", "https://cdn.example.com")
CSP_STYLE_SRC = ("'self'",)
CSP_IMG_SRC = ("'self'", "https://cdn.example.com")
CSP_FONT_SRC = ("'self'", "https://fonts.gstatic.com")
```

**Rule**: Enable all security headers in production.

---

## Performance Optimization

### Database Query Optimization

```python
# ✅ PRODUCTION: Monitor slow queries
LOGGING['loggers']['django.db.backends'] = {
    'level': 'DEBUG' if DEBUG else 'WARNING',
    'handlers': ['console'],
}

# ✅ GOOD: Query timeout (PostgreSQL)
DATABASES['default']['OPTIONS'] = {
    'options': '-c statement_timeout=5000'  # 5 seconds
}
```

### Middleware Optimization

```python
# ✅ Order matters for performance
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'whitenoise.middleware.WhiteNoiseMiddleware',  # Serve static files early
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.cache.UpdateCacheMiddleware',  # Cache first
    'django.middleware.common.CommonMiddleware',
    'django.middleware.cache.FetchFromCacheMiddleware',  # Then fetch
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]
```

### Compression

```python
# ✅ Enable GZip compression
MIDDLEWARE = [
    'django.middleware.gzip.GZipMiddleware',  # Add near top
    # ... other middleware
]
```

**Rule**: Always enable compression in production.

---

## Environment-Based Settings

### Settings Structure

```
myproject/
├── settings/
│   ├── __init__.py
│   ├── base.py          # Shared settings
│   ├── development.py   # Local development
│   ├── staging.py       # Staging environment
│   └── production.py    # Production environment
```

**base.py:**

```python
# Common settings for all environments
INSTALLED_APPS = [...]
MIDDLEWARE = [...]
```

**production.py:**

```python
from .base import *

DEBUG = False
ALLOWED_HOSTS = os.environ.get('ALLOWED_HOSTS', '').split(',')
SECURE_SSL_REDIRECT = True
# ... production-specific settings
```

**Set environment:**

```bash
export DJANGO_SETTINGS_MODULE=myproject.settings.production
```

### Using Environment Variables

```python
# ✅ RECOMMENDED: python-decouple
from decouple import config, Csv

DEBUG = config('DEBUG', default=False, cast=bool)
SECRET_KEY = config('SECRET_KEY')
ALLOWED_HOSTS = config('ALLOWED_HOSTS', cast=Csv())
DATABASE_URL = config('DATABASE_URL')
```

**.env file (never commit this):**

```env
DEBUG=False
SECRET_KEY=your-secret-key-here
ALLOWED_HOSTS=example.com,www.example.com
DATABASE_URL=postgresql://user:pass@localhost/dbname
REDIS_URL=redis://localhost:6379/1
```

**Rule**: Store all environment-specific config in environment variables.

---

## Deployment Process

### Pre-Deployment Steps

```bash
# 1. Run tests
python manage.py test

# 2. Check for issues
python manage.py check --deploy

# 3. Check migrations
python manage.py makemigrations --check --dry-run

# 4. Collect static files
python manage.py collectstatic --no-input

# 5. Check for security issues
bandit -r myproject/
safety check
```

### Zero-Downtime Deployment

```bash
#!/bin/bash
# deploy.sh

# Pull latest code
git pull origin main

# Install dependencies
pip install -r requirements.txt

# Run migrations
python manage.py migrate --no-input

# Collect static files
python manage.py collectstatic --no-input

# Graceful restart (sends SIGHUP to workers)
systemctl reload gunicorn

# Or for manual process management
kill -HUP $(cat /tmp/gunicorn.pid)
```

### Health Checks

```python
# myapp/views.py
from django.http import JsonResponse
from django.db import connection

def health_check(request):
    """Simple health check endpoint for load balancers."""
    try:
        # Check database
        with connection.cursor() as cursor:
            cursor.execute("SELECT 1")

        # Check cache
        from django.core.cache import cache
        cache.set('health_check', 'ok', 10)
        cache.get('health_check')

        return JsonResponse({'status': 'healthy'})
    except Exception as e:
        return JsonResponse({'status': 'unhealthy', 'error': str(e)}, status=500)
```

**Rule**: Implement health checks for load balancers and monitoring.

---

## Monitoring and Observability

### Application Performance Monitoring

```python
# ✅ New Relic
import newrelic.agent
newrelic.agent.initialize('/etc/newrelic.ini')

# ✅ DataDog
from ddtrace import patch_all
patch_all()

# ✅ Application Insights (Azure)
from applicationinsights.django import ApplicationInsightsMiddleware
MIDDLEWARE = [
    'applicationinsights.django.ApplicationInsightsMiddleware',
    # ...
]
```

### Key Metrics to Monitor

- **Response time**: Average, 95th, 99th percentile
- **Error rate**: 4xx and 5xx responses
- **Database query time**: Slow query detection
- **Cache hit rate**: Redis/Memcached efficiency
- **Memory usage**: Application and database
- **CPU usage**: Under load
- **Disk space**: Logs and media files

**Rule**: Monitor application performance from day one.

---

## Backup Strategy

### Database Backups

```bash
#!/bin/bash
# backup-db.sh

BACKUP_DIR="/backups/postgres"
DATE=$(date +%Y%m%d_%H%M%S)
DB_NAME="mydb"

# Create backup
pg_dump -h localhost -U postgres -Fc $DB_NAME > $BACKUP_DIR/db_$DATE.dump

# Keep only last 7 days
find $BACKUP_DIR -type f -mtime +7 -delete

# Upload to S3
aws s3 cp $BACKUP_DIR/db_$DATE.dump s3://my-backups/postgres/
```

### Media Files Backup

```bash
#!/bin/bash
# backup-media.sh

MEDIA_DIR="/var/www/myproject/media"
BACKUP_DIR="/backups/media"
DATE=$(date +%Y%m%d)

# Incremental backup
rsync -avz --delete $MEDIA_DIR $BACKUP_DIR/latest/

# Daily snapshot
cp -al $BACKUP_DIR/latest $BACKUP_DIR/$DATE
```

**Rule**: Test backup restoration regularly.

---

## Checklist Summary

Before going live, verify:

- [ ] `DEBUG = False`
- [ ] `SECRET_KEY` loaded from environment
- [ ] `ALLOWED_HOSTS` configured
- [ ] Database backups scheduled
- [ ] Static files collected and served by CDN/nginx
- [ ] HTTPS enabled with proper certificates
- [ ] `SESSION_COOKIE_SECURE = True`
- [ ] `CSRF_COOKIE_SECURE = True`
- [ ] Error monitoring configured (Sentry)
- [ ] Logging configured
- [ ] Cache backend configured (Redis)
- [ ] Email backend configured
- [ ] Security headers enabled
- [ ] `python manage.py check --deploy` passes
- [ ] Health check endpoint implemented
- [ ] Monitoring and alerts configured
- [ ] Deployment process documented
- [ ] Rollback plan prepared

**Final command:**

```bash
python manage.py check --deploy --settings=myproject.settings.production
```

If this passes with no warnings, you're ready for production.
