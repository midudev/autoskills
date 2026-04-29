# Django Expert - Examples

Practical examples demonstrating Django best practices for common development scenarios.

## Example 1: Model Design with Custom Manager

**User Request:**
> "Create a User model with email authentication, profile tracking, and a way to query active users"

**Claude Response:**
```
I'll create a custom User model following Django best practices:

1. Extend AbstractUser for email-based authentication
2. Add custom manager for common queries
3. Include proper Meta configuration with indexes
4. Add timestamp tracking fields
```

**Implementation:**
```python
# models.py
from django.contrib.auth.models import AbstractUser
from django.db import models

class UserManager(models.Manager):
    """Custom manager for User model with common query methods."""

    def active_users(self):
        """Return users who are active and email verified."""
        return self.filter(is_active=True, email_verified=True)

    def get_by_email(self, email):
        """Case-insensitive email lookup."""
        return self.get(email__iexact=email)

class User(AbstractUser):
    email = models.EmailField(unique=True, db_index=True)
    email_verified = models.BooleanField(default=False)
    profile_completed = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    objects = UserManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username']

    class Meta:
        db_table = 'users'
        ordering = ['-created_at']
        indexes = [
            models.Index(fields=['email', 'is_active']),
            models.Index(fields=['created_at']),
        ]

    def __str__(self):
        return self.email

    def get_full_name(self):
        """Return user's full name or email if name not set."""
        full_name = f"{self.first_name} {self.last_name}".strip()
        return full_name if full_name else self.email
```

**Next steps:**
- Run `python manage.py makemigrations` to create migrations
- Update settings.py: `AUTH_USER_MODEL = 'yourapp.User'`
- Create email verification workflow if needed

---

## Example 2: Query Optimization (N+1 Problem)

**User Request:**
> "This blog post list view is generating 100+ database queries and it's really slow"

**Current Code (Problematic):**
```python
# BAD: N+1 query problem
def post_list(request):
    posts = Post.objects.all()  # 1 query
    return render(request, 'posts/list.html', {'posts': posts})

# Template causes N+1:
# {% for post in posts %}
#   {{ post.author.name }}      # 1 query per post
#   {{ post.comments.count }}   # 1 query per post
# {% endfor %}
```

**Claude Response:**
```
I can see the N+1 query problem. The view fetches posts, but the template
accesses related `author` (ForeignKey) and `comments` (reverse ForeignKey)
for each post, causing additional queries.

Solution: Use select_related() for ForeignKey and prefetch_related() for
reverse relationships.
```

**Optimized Code:**
```python
# GOOD: Optimized with proper eager loading
from django.db.models import Count, Prefetch

def post_list(request):
    posts = Post.objects.select_related(
        'author'  # ForeignKey - use select_related (SQL JOIN)
    ).prefetch_related(
        Prefetch(
            'comments',
            queryset=Comment.objects.select_related('author').filter(is_approved=True)
        )
    ).annotate(
        comment_count=Count('comments', filter=Q(comments__is_approved=True))
    ).order_by('-published_at')

    return render(request, 'posts/list.html', {'posts': posts})

# Now template only uses the prefetched data - no additional queries!
```

**Performance Impact:**
- Before: 1 + N (authors) + N (comment counts) = 201 queries for 100 posts
- After: 3 queries total (posts, authors via JOIN, comments prefetch)

---

## Example 3: Django REST Framework API Endpoint

**User Request:**
> "Create a REST API for my Product model with filtering, pagination, and proper permissions"

**Claude Response:**
```
I'll implement a complete DRF endpoint following best practices:

1. Create ModelSerializer with validation
2. Implement ViewSet with proper permissions
3. Add filtering and search capabilities
4. Configure pagination
5. Set up URL routing
```

**Implementation:**

```python
# serializers.py
from rest_framework import serializers
from .models import Product

class ProductSerializer(serializers.ModelSerializer):
    category_name = serializers.CharField(source='category.name', read_only=True)
    is_available = serializers.SerializerMethodField()

    class Meta:
        model = Product
        fields = [
            'id', 'name', 'description', 'price', 'stock',
            'category', 'category_name', 'is_available', 'created_at'
        ]
        read_only_fields = ['id', 'created_at']

    def get_is_available(self, obj):
        """Check if product is in stock."""
        return obj.stock > 0

    def validate_price(self, value):
        """Ensure price is positive."""
        if value <= 0:
            raise serializers.ValidationError("Price must be greater than zero")
        return value

# views.py
from rest_framework import viewsets, filters
from rest_framework.permissions import IsAuthenticatedOrReadOnly
from django_filters.rest_framework import DjangoFilterBackend
from .models import Product
from .serializers import ProductSerializer

class ProductViewSet(viewsets.ModelViewSet):
    """
    ViewSet for Product CRUD operations.

    List and retrieve are public, create/update/delete require authentication.
    """
    queryset = Product.objects.select_related('category').filter(is_active=True)
    serializer_class = ProductSerializer
    permission_classes = [IsAuthenticatedOrReadOnly]
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['category', 'stock']
    search_fields = ['name', 'description']
    ordering_fields = ['price', 'created_at', 'stock']
    ordering = ['-created_at']

    def get_queryset(self):
        """Filter products based on query params."""
        queryset = super().get_queryset()

        # Filter by price range
        min_price = self.request.query_params.get('min_price')
        max_price = self.request.query_params.get('max_price')

        if min_price:
            queryset = queryset.filter(price__gte=min_price)
        if max_price:
            queryset = queryset.filter(price__lte=max_price)

        return queryset

# urls.py
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import ProductViewSet

router = DefaultRouter()
router.register(r'products', ProductViewSet, basename='product')

urlpatterns = [
    path('api/', include(router.urls)),
]

# settings.py (pagination configuration)
REST_FRAMEWORK = {
    'DEFAULT_PAGINATION_CLASS': 'rest_framework.pagination.PageNumberPagination',
    'PAGE_SIZE': 20,
}
```

**API Usage Examples:**
```bash
# List all products (paginated)
GET /api/products/

# Search products
GET /api/products/?search=laptop

# Filter by category and price range
GET /api/products/?category=electronics&min_price=100&max_price=500

# Order by price ascending
GET /api/products/?ordering=price

# Retrieve single product
GET /api/products/123/

# Create product (requires authentication)
POST /api/products/
```

---

## Example 4: Writing Django Tests

**User Request:**
> "Write tests for the Product API endpoint"

**Implementation:**
```python
# tests/test_product_api.py
from django.test import TestCase
from django.contrib.auth import get_user_model
from rest_framework.test import APIClient
from rest_framework import status
from decimal import Decimal
from .models import Product, Category

User = get_user_model()

class ProductAPITestCase(TestCase):
    """Test suite for Product API endpoints."""

    def setUp(self):
        """Set up test data before each test."""
        self.client = APIClient()
        self.user = User.objects.create_user(
            email='test@example.com',
            password='testpass123'
        )
        self.category = Category.objects.create(name='Electronics')
        self.product = Product.objects.create(
            name='Test Product',
            description='A test product',
            price=Decimal('99.99'),
            stock=10,
            category=self.category
        )

    def test_list_products_unauthenticated(self):
        """Unauthenticated users can list products."""
        response = self.client.get('/api/products/')

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data['results']), 1)

    def test_create_product_requires_authentication(self):
        """Creating products requires authentication."""
        data = {
            'name': 'New Product',
            'price': '49.99',
            'stock': 5,
            'category': self.category.id
        }
        response = self.client.post('/api/products/', data)

        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    def test_create_product_authenticated(self):
        """Authenticated users can create products."""
        self.client.force_authenticate(user=self.user)
        data = {
            'name': 'New Product',
            'description': 'A new product',
            'price': '49.99',
            'stock': 5,
            'category': self.category.id
        }
        response = self.client.post('/api/products/', data)

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(Product.objects.count(), 2)
        self.assertEqual(response.data['name'], 'New Product')

    def test_filter_by_price_range(self):
        """Products can be filtered by price range."""
        Product.objects.create(
            name='Expensive Product',
            price=Decimal('299.99'),
            stock=5,
            category=self.category
        )

        response = self.client.get('/api/products/?min_price=200')

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data['results']), 1)
        self.assertEqual(response.data['results'][0]['name'], 'Expensive Product')

    def test_product_availability_field(self):
        """is_available field correctly reflects stock status."""
        response = self.client.get(f'/api/products/{self.product.id}/')

        self.assertEqual(response.data['is_available'], True)

        # Update stock to 0
        self.product.stock = 0
        self.product.save()

        response = self.client.get(f'/api/products/{self.product.id}/')
        self.assertEqual(response.data['is_available'], False)
```

**Run tests:**
```bash
python manage.py test tests.test_product_api
```
