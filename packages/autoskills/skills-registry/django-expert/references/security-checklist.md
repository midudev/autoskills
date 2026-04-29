# Django Security Checklist

Django is secure by default, but you must configure it correctly and avoid common pitfalls.

## OWASP Top 10 & Django

### 1. SQL Injection

**Django protects you automatically** when using the ORM.

```python
# ✅ SAFE: ORM parameterizes queries
User.objects.filter(email=user_input)

# ✅ SAFE: Using parameters
User.objects.raw('SELECT * FROM users WHERE email = %s', [user_input])

# ❌ DANGEROUS: String formatting
User.objects.raw(f'SELECT * FROM users WHERE email = "{user_input}"')

# ❌ DANGEROUS: String concatenation
cursor.execute('SELECT * FROM users WHERE id = ' + user_id)
```

**Rule**: Never use string formatting or concatenation for SQL queries.

### 2. Cross-Site Scripting (XSS)

**Django templates auto-escape by default.**

```django
{# ✅ SAFE: Auto-escaped #}
<p>Hello, {{ user.name }}</p>

{# ❌ DANGEROUS: Marks as safe, disables escaping #}
<p>{{ user_bio|safe }}</p>

{# ✅ SAFE: Use linebreaks filter instead #}
<p>{{ user_bio|linebreaks }}</p>
```

**In views returning JSON for HTMX:**

```python
from django.utils.html import escape

# ✅ GOOD: Escape user input
return JsonResponse({
    'message': escape(user_message)
})
```

**Rule**: Never use `|safe` or `mark_safe()` on user-generated content.

### 3. Cross-Site Request Forgery (CSRF)

**Django's CSRF protection is enabled by default.**

```django
{# ✅ REQUIRED: Include CSRF token in forms #}
<form method="post">
  {% csrf_token %}
  ...
</form>

{# For HTMX #}
<button hx-post="/api/delete/" hx-headers='{"X-CSRFToken": "{{ csrf_token }}"}'>
  Delete
</button>
```

**In views:**

```python
from django.views.decorators.csrf import csrf_exempt, csrf_protect

# ✅ DEFAULT: CSRF protection enabled
@csrf_protect
def my_view(request):
    ...

# ❌ DANGEROUS: Only exempt for APIs with other auth (tokens)
@csrf_exempt
def api_view(request):
    # Must have other protection (API key, JWT, etc.)
    ...
```

**For AJAX/HTMX, include CSRF token in headers:**

```javascript
// HTMX auto-includes if you set this
document.body.addEventListener('htmx:configRequest', (event) => {
  event.detail.headers['X-CSRFToken'] = getCookie('csrftoken');
});
```

**Rule**: Never disable CSRF protection unless you have alternative authentication.

### 4. Broken Authentication

```python
from django.contrib.auth.decorators import login_required
from rest_framework.permissions import IsAuthenticated

# ✅ GOOD: Require authentication
@login_required
def user_profile(request):
    ...

class UserProfileView(APIView):
    permission_classes = [IsAuthenticated]
    ...

# ❌ BAD: Checking authentication manually
def user_profile(request):
    if 'user_id' in request.session:  # Fragile!
        ...
```

**Password Security:**

```python
# settings.py

# ✅ GOOD: Strong password validation
AUTH_PASSWORD_VALIDATORS = [
    {'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator'},
    {'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
     'OPTIONS': {'min_length': 12}},
    {'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator'},
    {'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator'},
]

# ✅ GOOD: Use Argon2 for password hashing
PASSWORD_HASHERS = [
    'django.contrib.auth.hashers.Argon2PasswordHasher',
    'django.contrib.auth.hashers.PBKDF2PasswordHasher',
]
```

**Rule**: Always use Django's authentication system, never roll your own.

### 5. Broken Access Control

```python
# ❌ BAD: No authorization check
@login_required
def delete_post(request, post_id):
    post = Post.objects.get(id=post_id)
    post.delete()  # Any logged-in user can delete any post!
    return HttpResponse('Deleted')

# ✅ GOOD: Check authorization
@login_required
def delete_post(request, post_id):
    post = get_object_or_404(Post, id=post_id)

    # Authorization check
    if post.author != request.user and not request.user.is_staff:
        return HttpResponseForbidden('You cannot delete this post')

    post.delete()
    return HttpResponse('Deleted')

# ✅ BETTER: Use permissions
from rest_framework import permissions

class IsOwnerOrReadOnly(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        if request.method in permissions.SAFE_METHODS:
            return True
        return obj.author == request.user

class PostDetailView(APIView):
    permission_classes = [IsOwnerOrReadOnly]
    ...
```

**Rule**: Authentication ≠ Authorization. Always check permissions.

### 6. Security Misconfiguration

```python
# settings.py

# ❌ DANGEROUS in production
DEBUG = True
SECRET_KEY = 'hardcoded-secret-key'
ALLOWED_HOSTS = ['*']

# ✅ GOOD: Production settings
DEBUG = False
SECRET_KEY = os.environ['DJANGO_SECRET_KEY']
ALLOWED_HOSTS = ['yourdomain.com', 'www.yourdomain.com']

# ✅ GOOD: Security headers
SECURE_SSL_REDIRECT = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SECURE = True
SECURE_BROWSER_XSS_FILTER = True
SECURE_CONTENT_TYPE_NOSNIFF = True
X_FRAME_OPTIONS = 'DENY'
SECURE_HSTS_SECONDS = 31536000  # 1 year
SECURE_HSTS_INCLUDE_SUBDOMAINS = True
SECURE_HSTS_PRELOAD = True

# ✅ GOOD: Use environment variables
import os
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent

SECRET_KEY = os.environ.get('DJANGO_SECRET_KEY')
DEBUG = os.environ.get('DEBUG', 'False') == 'True'
ALLOWED_HOSTS = os.environ.get('ALLOWED_HOSTS', '').split(',')

# Database from environment
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': os.environ.get('DB_NAME'),
        'USER': os.environ.get('DB_USER'),
        'PASSWORD': os.environ.get('DB_PASSWORD'),
        'HOST': os.environ.get('DB_HOST'),
        'PORT': os.environ.get('DB_PORT', '5432'),
    }
}
```

**Rule**: Never commit secrets. Always use environment variables.

### 7. Sensitive Data Exposure

```python
# ✅ GOOD: Don't log sensitive data
import logging
logger = logging.getLogger(__name__)

def process_payment(payment_data):
    # ❌ BAD: Logs credit card number
    logger.info(f"Processing payment: {payment_data}")

    # ✅ GOOD: Log only safe data
    logger.info(f"Processing payment for order {payment_data['order_id']}")

# ✅ GOOD: Don't expose sensitive fields in API
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'email', 'first_name', 'last_name']
        # NOT password, social_security_number, etc.

# ✅ GOOD: Redact in admin interface
from django.contrib import admin

class UserAdmin(admin.ModelAdmin):
    readonly_fields = ['password']  # Don't allow editing
    exclude = ['social_security_number']  # Don't show at all
```

**For database encryption:**

```bash
# Use django-encrypted-model-fields
pip install django-encrypted-model-fields
```

```python
from encrypted_model_fields.fields import EncryptedCharField

class PaymentInfo(models.Model):
    card_number = EncryptedCharField(max_length=16)
```

**Rule**: Assume logs, databases, and backups may be compromised. Encrypt sensitive data.

### 8. Insecure Deserialization

```python
import pickle
import json

# ❌ DANGEROUS: pickle can execute arbitrary code
data = pickle.loads(request.POST['data'])

# ✅ SAFE: Use JSON
data = json.loads(request.POST['data'])

# ✅ SAFE: Use Django's serialization
from django.core import serializers
data = serializers.deserialize('json', request.POST['data'])
```

**Rule**: Never use `pickle` or `eval()` on user input.

### 9. Using Components with Known Vulnerabilities

```bash
# Check for vulnerabilities
pip install safety
safety check

# Keep dependencies updated
pip list --outdated
```

**In requirements.txt, pin versions:**

```
Django==4.2.7  # Not Django>=4.0 (prevents auto-updates)
psycopg2-binary==2.9.9
redis==5.0.1
```

**Rule**: Keep dependencies updated and monitor security advisories.

### 10. Insufficient Logging & Monitoring

```python
import logging
logger = logging.getLogger(__name__)

# ✅ GOOD: Log security events
@login_required
def delete_account(request):
    user = request.user

    # Log security-relevant action
    logger.warning(
        f"Account deletion requested",
        extra={
            'user_id': user.id,
            'user_email': user.email,
            'ip_address': request.META.get('REMOTE_ADDR'),
            'user_agent': request.META.get('HTTP_USER_AGENT'),
        }
    )

    user.delete()
    return HttpResponse('Account deleted')

# ✅ GOOD: Log failed authentication
from django.contrib.auth.signals import user_login_failed

def log_failed_login(sender, credentials, request, **kwargs):
    logger.warning(
        f"Failed login attempt",
        extra={
            'username': credentials.get('username'),
            'ip_address': request.META.get('REMOTE_ADDR'),
        }
    )

user_login_failed.connect(log_failed_login)
```

**Rule**: Log security events, failed auth attempts, privilege escalations.

## Additional Django Security

### Clickjacking Protection

```python
# settings.py
X_FRAME_OPTIONS = 'DENY'  # Prevent embedding in iframes

# Or allow specific domains
X_FRAME_OPTIONS = 'SAMEORIGIN'  # Only same domain
```

### Host Header Validation

```python
# settings.py
ALLOWED_HOSTS = ['yourdomain.com', 'www.yourdomain.com']

# Never use:
ALLOWED_HOSTS = ['*']  # Allows host header injection attacks
```

### File Upload Security

```python
# settings.py
FILE_UPLOAD_MAX_MEMORY_SIZE = 5242880  # 5MB
DATA_UPLOAD_MAX_MEMORY_SIZE = 5242880

# Validate file types
from django.core.exceptions import ValidationError

def validate_file_extension(value):
    import os
    ext = os.path.splitext(value.name)[1]
    valid_extensions = ['.pdf', '.jpg', '.png', '.jpeg']
    if ext.lower() not in valid_extensions:
        raise ValidationError('Unsupported file extension.')

class Document(models.Model):
    file = models.FileField(
        upload_to='documents/',
        validators=[validate_file_extension]
    )

# ✅ GOOD: Store uploads outside web root
MEDIA_ROOT = '/var/www/media/'  # Not in static files directory!
MEDIA_URL = '/media/'
```

### Rate Limiting

```bash
pip install django-ratelimit
```

```python
from django_ratelimit.decorators import ratelimit

# Limit login attempts
@ratelimit(key='ip', rate='5/m', block=True)
def login_view(request):
    ...

# Limit API calls
@ratelimit(key='user', rate='100/h', block=True)
def api_endpoint(request):
    ...
```

## Security Checklist

Before deploying to production:

✅ `DEBUG = False`
✅ `SECRET_KEY` from environment variable
✅ `ALLOWED_HOSTS` configured properly
✅ All security headers enabled (HSTS, CSP, etc.)
✅ HTTPS enforced (`SECURE_SSL_REDIRECT = True`)
✅ Cookies secure (`SESSION_COOKIE_SECURE = True`)
✅ CSRF protection enabled (default)
✅ Strong password validators configured
✅ Database credentials in environment variables
✅ File upload size limits set
✅ Rate limiting on authentication endpoints
✅ Logging configured for security events
✅ Dependencies scanned for vulnerabilities
✅ Admin interface protected (strong password, 2FA if possible)
✅ Run `python manage.py check --deploy`

## Useful Django Management Commands

```bash
# Check deployment security
python manage.py check --deploy

# This checks for:
# - DEBUG = False
# - SECRET_KEY not hardcoded
# - ALLOWED_HOSTS configured
# - Security middleware enabled
# - And more...
```

---

**Remember**: Security is not a feature, it's a requirement. Defense in depth - use multiple layers of security.