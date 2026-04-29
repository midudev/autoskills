# Django Testing Strategies

This guide covers testing Django applications using both Django's built-in `TestCase` and `pytest-django`. Both approaches are valid and widely used in production.

**Quick comparison:**
- **Django TestCase**: Built-in, class-based, familiar to Django developers
- **pytest-django**: Modern, fixture-based, less boilerplate, extensive plugin ecosystem

Choose based on your team's preference and project needs. Both can coexist in the same project.

## Test Organization

### Directory Structure

```
myapp/
├── models.py
├── views.py
├── serializers.py
└── tests/
    ├── __init__.py
    ├── test_models.py
    ├── test_views.py
    ├── test_serializers.py
    ├── test_api.py
    └── factories.py  # Factory Boy factories
```

### Test Discovery

Django automatically discovers tests in:
- Files starting with `test_`
- Files in `tests/` directories

```bash
# Run all tests
python manage.py test

# Run specific app
python manage.py test myapp

# Run specific test file
python manage.py test myapp.tests.test_models

# Run specific test class
python manage.py test myapp.tests.test_models.PostModelTest

# Run specific test method
python manage.py test myapp.tests.test_models.PostModelTest.test_create_post
```

## TestCase vs TransactionTestCase

### TestCase (Recommended)

```python
from django.test import TestCase

# ✅ GOOD: Faster, uses transactions
class PostModelTest(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='test', password='pass')
        self.post = Post.objects.create(title='Test', author=self.user)

    def test_post_creation(self):
        self.assertEqual(self.post.title, 'Test')
        self.assertEqual(Post.objects.count(), 1)
```

**Features:**
- Wraps tests in transactions (rolled back after each test)
- Much faster than TransactionTestCase
- Database is reset between tests automatically

### TransactionTestCase

```python
from django.test import TransactionTestCase

# ✅ GOOD: When you need to test transactions
class PaymentProcessingTest(TransactionTestCase):
    def test_atomic_payment(self):
        with transaction.atomic():
            # Test transaction behavior
            ...
```

**Use TransactionTestCase when:**
- Testing transaction behavior (commit/rollback)
- Testing database-level constraints
- Testing raw SQL that doesn't work in transactions

**Rule**: Use TestCase unless you specifically need TransactionTestCase.

---

## pytest-django Setup

### Installation

```bash
pip install pytest-django
```

### Configuration

Create `pytest.ini` in your project root:

```ini
[pytest]
DJANGO_SETTINGS_MODULE = myproject.settings
python_files = tests.py test_*.py *_tests.py
python_classes = Test*
python_functions = test_*
```

Or use `pyproject.toml`:

```toml
[tool.pytest.ini_options]
DJANGO_SETTINGS_MODULE = "myproject.settings"
python_files = ["test_*.py", "*_test.py"]
```

### Running pytest

```bash
# Run all tests
pytest

# Run specific file
pytest tests/test_models.py

# Run specific test
pytest tests/test_models.py::test_create_post

# Verbose output
pytest -v

# Parallel execution (requires pytest-xdist)
pip install pytest-xdist
pytest -n auto

# Reuse database between runs (faster)
pytest --reuse-db

# Skip migrations (much faster for large projects)
pytest --reuse-db --no-migrations
```

### Key pytest-django Fixtures

```python
# Database access fixtures
db                              # Standard database access
transactional_db                # Transaction testing
django_db_reset_sequences       # Reset DB sequences

# Client fixtures
client                          # Django test client
admin_client                    # Pre-authenticated admin client
async_client                    # AsyncClient for async views

# Request factory fixtures
rf                              # RequestFactory
async_rf                        # Async RequestFactory

# User fixtures
admin_user                      # Superuser instance
django_user_model               # User model class

# Utility fixtures
settings                        # Modify settings temporarily
live_server                     # Run development server
mailoutbox                      # Captured emails
django_assert_num_queries       # Query count assertions
```

### pytest-django Markers

```python
import pytest

# Grant database access
@pytest.mark.django_db
def test_model_save():
    pass

# Transaction testing
@pytest.mark.django_db(transaction=True)
def test_transaction():
    pass

# Override URLs
@pytest.mark.urls('myapp.test_urls')
def test_with_custom_urls():
    pass
```

---

## Model Testing

```python
from django.test import TestCase
from django.core.exceptions import ValidationError

# ✅ GOOD: Test model methods and validation
class PostModelTest(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(
            username='testuser',
            password='testpass123'
        )

    def test_create_post(self):
        """Test post creation."""
        post = Post.objects.create(
            title='Test Post',
            content='Test content',
            author=self.user
        )
        self.assertEqual(post.title, 'Test Post')
        self.assertEqual(post.author, self.user)
        self.assertIsNotNone(post.created_at)

    def test_str_method(self):
        """Test string representation."""
        post = Post.objects.create(title='Test', author=self.user)
        self.assertEqual(str(post), 'Test')

    def test_slug_generation(self):
        """Test automatic slug generation."""
        post = Post.objects.create(
            title='Test Post Title',
            author=self.user
        )
        self.assertEqual(post.slug, 'test-post-title')

    def test_title_max_length(self):
        """Test title max length validation."""
        long_title = 'x' * 201
        post = Post(title=long_title, author=self.user)

        with self.assertRaises(ValidationError):
            post.full_clean()

    def test_get_absolute_url(self):
        """Test get_absolute_url method."""
        post = Post.objects.create(title='Test', author=self.user)
        expected_url = f'/posts/{post.slug}/'
        self.assertEqual(post.get_absolute_url(), expected_url)

    def test_published_posts_manager(self):
        """Test custom manager."""
        Post.objects.create(title='Published', author=self.user, is_published=True)
        Post.objects.create(title='Draft', author=self.user, is_published=False)

        published = Post.published.all()
        self.assertEqual(published.count(), 1)
        self.assertEqual(published.first().title, 'Published')
```

### Model Testing with pytest-django

```python
import pytest
from django.core.exceptions import ValidationError

# ✅ GOOD: Function-based tests with pytest
@pytest.mark.django_db
def test_create_post(django_user_model):
    """Test post creation."""
    user = django_user_model.objects.create_user(
        username='testuser',
        password='testpass123'
    )
    post = Post.objects.create(
        title='Test Post',
        content='Test content',
        author=user
    )
    assert post.title == 'Test Post'
    assert post.author == user
    assert post.created_at is not None


def test_str_method(db):
    """Test string representation."""
    user = User.objects.create_user(username='test', password='pass')
    post = Post.objects.create(title='Test', author=user)
    assert str(post) == 'Test'


def test_slug_generation(db):
    """Test automatic slug generation."""
    user = User.objects.create_user(username='test', password='pass')
    post = Post.objects.create(
        title='Test Post Title',
        author=user
    )
    assert post.slug == 'test-post-title'


def test_title_max_length(db):
    """Test title max length validation."""
    user = User.objects.create_user(username='test', password='pass')
    long_title = 'x' * 201
    post = Post(title=long_title, author=user)

    with pytest.raises(ValidationError):
        post.full_clean()


def test_get_absolute_url(db):
    """Test get_absolute_url method."""
    user = User.objects.create_user(username='test', password='pass')
    post = Post.objects.create(title='Test', author=user)
    expected_url = f'/posts/{post.slug}/'
    assert post.get_absolute_url() == expected_url


def test_published_posts_manager(db):
    """Test custom manager."""
    user = User.objects.create_user(username='test', password='pass')
    Post.objects.create(title='Published', author=user, is_published=True)
    Post.objects.create(title='Draft', author=user, is_published=False)

    published = Post.published.all()
    assert published.count() == 1
    assert published.first().title == 'Published'


# ✅ GOOD: Using fixtures for reusable test data
@pytest.fixture
def test_user(db):
    """Create a test user."""
    return User.objects.create_user(
        username='testuser',
        password='testpass123'
    )


@pytest.fixture
def test_post(test_user):
    """Create a test post."""
    return Post.objects.create(
        title='Test Post',
        content='Test content',
        author=test_user
    )


def test_post_with_fixtures(test_post):
    """Test using fixtures."""
    assert test_post.title == 'Test Post'
    assert test_post.author.username == 'testuser'


# ✅ GOOD: Parametrized testing
@pytest.mark.django_db
@pytest.mark.parametrize('is_published,expected_count', [
    (True, 1),
    (False, 0),
])
def test_published_filter(is_published, expected_count):
    """Test published posts filter."""
    user = User.objects.create_user(username='test', password='pass')
    Post.objects.create(
        title='Test',
        author=user,
        is_published=is_published
    )
    assert Post.published.count() == expected_count
```

---

## View Testing

```python
from django.test import TestCase, Client
from django.urls import reverse

# ✅ GOOD: Test views thoroughly
class PostViewTest(TestCase):
    def setUp(self):
        self.client = Client()
        self.user = User.objects.create_user(
            username='testuser',
            password='testpass123'
        )
        self.post = Post.objects.create(
            title='Test Post',
            content='Test content',
            author=self.user
        )

    def test_post_list_view(self):
        """Test post list view."""
        response = self.client.get(reverse('post_list'))

        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, 'blog/post_list.html')
        self.assertContains(response, 'Test Post')
        self.assertIn('posts', response.context)

    def test_post_detail_view(self):
        """Test post detail view."""
        url = reverse('post_detail', kwargs={'pk': self.post.pk})
        response = self.client.get(url)

        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.context['post'], self.post)

    def test_post_detail_404(self):
        """Test 404 for non-existent post."""
        url = reverse('post_detail', kwargs={'pk': 9999})
        response = self.client.get(url)
        self.assertEqual(response.status_code, 404)

    def test_create_post_authenticated(self):
        """Test creating post when logged in."""
        self.client.login(username='testuser', password='testpass123')

        data = {
            'title': 'New Post',
            'content': 'New content'
        }
        response = self.client.post(reverse('post_create'), data)

        self.assertEqual(response.status_code, 302)  # Redirect after success
        self.assertEqual(Post.objects.count(), 2)
        new_post = Post.objects.latest('created_at')
        self.assertEqual(new_post.title, 'New Post')
        self.assertEqual(new_post.author, self.user)

    def test_create_post_unauthenticated(self):
        """Test creating post when not logged in."""
        data = {'title': 'New Post', 'content': 'New content'}
        response = self.client.post(reverse('post_create'), data)

        # Should redirect to login
        self.assertEqual(response.status_code, 302)
        self.assertIn('/login/', response.url)

    def test_update_own_post(self):
        """Test updating own post."""
        self.client.login(username='testuser', password='testpass123')

        url = reverse('post_update', kwargs={'pk': self.post.pk})
        data = {'title': 'Updated Title', 'content': 'Updated content'}
        response = self.client.post(url, data)

        self.assertEqual(response.status_code, 302)
        self.post.refresh_from_db()
        self.assertEqual(self.post.title, 'Updated Title')

    def test_cannot_update_others_post(self):
        """Test cannot update another user's post."""
        other_user = User.objects.create_user(username='other', password='pass')
        self.client.login(username='other', password='pass')

        url = reverse('post_update', kwargs={'pk': self.post.pk})
        data = {'title': 'Hacked', 'content': 'Hacked'}
        response = self.client.post(url, data)

        # Should get 403 or 404
        self.assertIn(response.status_code, [403, 404])
        self.post.refresh_from_db()
        self.assertNotEqual(self.post.title, 'Hacked')

    def test_delete_post(self):
        """Test deleting post."""
        self.client.login(username='testuser', password='testpass123')

        url = reverse('post_delete', kwargs={'pk': self.post.pk})
        response = self.client.post(url)

        self.assertEqual(response.status_code, 302)
        self.assertEqual(Post.objects.count(), 0)
```

### View Testing with pytest-django

```python
import pytest
from django.urls import reverse

# ✅ GOOD: Using client fixture
def test_post_list_view(client, test_post):
    """Test post list view."""
    response = client.get(reverse('post_list'))

    assert response.status_code == 200
    assert b'Test Post' in response.content


def test_post_detail_view(client, test_post):
    """Test post detail view."""
    url = reverse('post_detail', kwargs={'pk': test_post.pk})
    response = client.get(url)

    assert response.status_code == 200
    assert response.context['post'] == test_post


def test_post_detail_404(client, db):
    """Test 404 for non-existent post."""
    url = reverse('post_detail', kwargs={'pk': 9999})
    response = client.get(url)
    assert response.status_code == 404


def test_create_post_authenticated(client, test_user):
    """Test creating post when logged in."""
    client.force_login(test_user)

    data = {
        'title': 'New Post',
        'content': 'New content'
    }
    response = client.post(reverse('post_create'), data)

    assert response.status_code == 302  # Redirect after success
    assert Post.objects.count() == 1
    new_post = Post.objects.latest('created_at')
    assert new_post.title == 'New Post'
    assert new_post.author == test_user


def test_create_post_unauthenticated(client, db):
    """Test creating post when not logged in."""
    data = {'title': 'New Post', 'content': 'New content'}
    response = client.post(reverse('post_create'), data)

    # Should redirect to login
    assert response.status_code == 302
    assert '/login/' in response.url


def test_update_own_post(client, test_post):
    """Test updating own post."""
    client.force_login(test_post.author)

    url = reverse('post_update', kwargs={'pk': test_post.pk})
    data = {'title': 'Updated Title', 'content': 'Updated content'}
    response = client.post(url, data)

    assert response.status_code == 302
    test_post.refresh_from_db()
    assert test_post.title == 'Updated Title'


def test_cannot_update_others_post(client, test_post, db):
    """Test cannot update another user's post."""
    other_user = User.objects.create_user(username='other', password='pass')
    client.force_login(other_user)

    url = reverse('post_update', kwargs={'pk': test_post.pk})
    data = {'title': 'Hacked', 'content': 'Hacked'}
    response = client.post(url, data)

    # Should get 403 or 404
    assert response.status_code in [403, 404]
    test_post.refresh_from_db()
    assert test_post.title != 'Hacked'


def test_delete_post(client, test_post):
    """Test deleting post."""
    client.force_login(test_post.author)

    url = reverse('post_delete', kwargs={'pk': test_post.pk})
    response = client.post(url)

    assert response.status_code == 302
    assert Post.objects.count() == 0


# ✅ GOOD: Testing with RequestFactory
def test_view_with_request_factory(rf, test_user):
    """Test view logic directly without full HTTP cycle."""
    from myapp.views import post_list

    request = rf.get('/posts/')
    request.user = test_user

    response = post_list(request)
    assert response.status_code == 200
```

---

## API Testing (DRF)

```python
from rest_framework.test import APITestCase, APIClient
from rest_framework import status

# ✅ GOOD: Test API endpoints
class PostAPITest(APITestCase):
    def setUp(self):
        self.client = APIClient()
        self.user = User.objects.create_user(
            username='testuser',
            password='testpass123'
        )
        self.post = Post.objects.create(
            title='Test Post',
            content='Test content',
            author=self.user
        )

    def test_list_posts(self):
        """Test GET /api/posts/"""
        response = self.client.get('/api/posts/')

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data['results']), 1)

    def test_retrieve_post(self):
        """Test GET /api/posts/{id}/"""
        response = self.client.get(f'/api/posts/{self.post.id}/')

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data['title'], 'Test Post')

    def test_create_post_authenticated(self):
        """Test POST /api/posts/ when authenticated."""
        self.client.force_authenticate(user=self.user)

        data = {'title': 'New Post', 'content': 'New content'}
        response = self.client.post('/api/posts/', data, format='json')

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(Post.objects.count(), 2)
        self.assertEqual(response.data['author'], self.user.id)

    def test_create_post_unauthenticated(self):
        """Test POST /api/posts/ when not authenticated."""
        data = {'title': 'New Post', 'content': 'New content'}
        response = self.client.post('/api/posts/', data, format='json')

        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    def test_update_post(self):
        """Test PUT /api/posts/{id}/"""
        self.client.force_authenticate(user=self.user)

        data = {'title': 'Updated', 'content': 'Updated content'}
        response = self.client.put(
            f'/api/posts/{self.post.id}/',
            data,
            format='json'
        )

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.post.refresh_from_db()
        self.assertEqual(self.post.title, 'Updated')

    def test_partial_update_post(self):
        """Test PATCH /api/posts/{id}/"""
        self.client.force_authenticate(user=self.user)

        data = {'title': 'Patched Title'}
        response = self.client.patch(
            f'/api/posts/{self.post.id}/',
            data,
            format='json'
        )

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.post.refresh_from_db()
        self.assertEqual(self.post.title, 'Patched Title')
        self.assertEqual(self.post.content, 'Test content')  # Unchanged

    def test_delete_post(self):
        """Test DELETE /api/posts/{id}/"""
        self.client.force_authenticate(user=self.user)

        response = self.client.delete(f'/api/posts/{self.post.id}/')

        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)
        self.assertEqual(Post.objects.count(), 0)

    def test_filter_by_author(self):
        """Test filtering posts by author."""
        other_user = User.objects.create_user(username='other', password='pass')
        Post.objects.create(title='Other Post', author=other_user)

        response = self.client.get(f'/api/posts/?author={self.user.id}')

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data['results']), 1)
        self.assertEqual(response.data['results'][0]['author'], self.user.id)

    def test_search_posts(self):
        """Test searching posts."""
        Post.objects.create(title='Django Tutorial', content='Learn Django', author=self.user)

        response = self.client.get('/api/posts/?search=Django')

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data['results']), 1)
```

### API Testing with pytest-django

```python
import pytest
from rest_framework import status

# ✅ GOOD: API tests with pytest
@pytest.mark.django_db
def test_list_posts(client, test_post):
    """Test GET /api/posts/"""
    response = client.get('/api/posts/')

    assert response.status_code == status.HTTP_200_OK
    assert len(response.json()['results']) == 1


@pytest.mark.django_db
def test_retrieve_post(client, test_post):
    """Test GET /api/posts/{id}/"""
    response = client.get(f'/api/posts/{test_post.id}/')

    assert response.status_code == status.HTTP_200_OK
    assert response.json()['title'] == 'Test Post'


def test_create_post_authenticated(client, test_user):
    """Test POST /api/posts/ when authenticated."""
    client.force_login(test_user)

    data = {'title': 'New Post', 'content': 'New content'}
    response = client.post('/api/posts/', data, content_type='application/json')

    assert response.status_code == status.HTTP_201_CREATED
    assert Post.objects.count() == 1
    assert response.json()['author'] == test_user.id


def test_create_post_unauthenticated(client, db):
    """Test POST /api/posts/ when not authenticated."""
    data = {'title': 'New Post', 'content': 'New content'}
    response = client.post('/api/posts/', data, content_type='application/json')

    assert response.status_code == status.HTTP_401_UNAUTHORIZED


def test_update_post(client, test_post):
    """Test PUT /api/posts/{id}/"""
    client.force_login(test_post.author)

    data = {'title': 'Updated', 'content': 'Updated content'}
    response = client.put(
        f'/api/posts/{test_post.id}/',
        data,
        content_type='application/json'
    )

    assert response.status_code == status.HTTP_200_OK
    test_post.refresh_from_db()
    assert test_post.title == 'Updated'


def test_partial_update_post(client, test_post):
    """Test PATCH /api/posts/{id}/"""
    client.force_login(test_post.author)

    data = {'title': 'Patched Title'}
    response = client.patch(
        f'/api/posts/{test_post.id}/',
        data,
        content_type='application/json'
    )

    assert response.status_code == status.HTTP_200_OK
    test_post.refresh_from_db()
    assert test_post.title == 'Patched Title'
    assert test_post.content == 'Test content'  # Unchanged


def test_delete_post(client, test_post):
    """Test DELETE /api/posts/{id}/"""
    client.force_login(test_post.author)

    response = client.delete(f'/api/posts/{test_post.id}/')

    assert response.status_code == status.HTTP_204_NO_CONTENT
    assert Post.objects.count() == 0


@pytest.mark.django_db
def test_filter_by_author(client, test_user):
    """Test filtering posts by author."""
    other_user = User.objects.create_user(username='other', password='pass')
    Post.objects.create(title='User Post', author=test_user)
    Post.objects.create(title='Other Post', author=other_user)

    response = client.get(f'/api/posts/?author={test_user.id}')

    assert response.status_code == status.HTTP_200_OK
    results = response.json()['results']
    assert len(results) == 1
    assert results[0]['author'] == test_user.id


@pytest.mark.django_db
def test_search_posts(client, test_user):
    """Test searching posts."""
    Post.objects.create(title='Django Tutorial', content='Learn Django', author=test_user)
    Post.objects.create(title='Python Guide', content='Learn Python', author=test_user)

    response = client.get('/api/posts/?search=Django')

    assert response.status_code == status.HTTP_200_OK
    results = response.json()['results']
    assert len(results) == 1
    assert 'Django' in results[0]['title']


# ✅ GOOD: Parametrized API testing
@pytest.mark.django_db
@pytest.mark.parametrize('endpoint,method,expected_status', [
    ('/api/posts/', 'get', status.HTTP_200_OK),
    ('/api/posts/', 'post', status.HTTP_401_UNAUTHORIZED),
])
def test_api_endpoints(client, endpoint, method, expected_status):
    """Test various API endpoints."""
    response = getattr(client, method)(endpoint)
    assert response.status_code == expected_status
```

---

## Fixtures and Factories

### Fixtures (JSON)

```python
# fixtures/test_data.json
[
    {
        "model": "auth.user",
        "pk": 1,
        "fields": {
            "username": "testuser",
            "email": "test@example.com"
        }
    },
    {
        "model": "blog.post",
        "pk": 1,
        "fields": {
            "title": "Test Post",
            "author": 1
        }
    }
]

# Using fixtures
class PostTest(TestCase):
    fixtures = ['test_data.json']

    def test_with_fixture(self):
        post = Post.objects.get(pk=1)
        self.assertEqual(post.title, 'Test Post')
```

### Factory Boy (Recommended)

```bash
pip install factory-boy
```

```python
# tests/factories.py
import factory
from factory.django import DjangoModelFactory

class UserFactory(DjangoModelFactory):
    class Meta:
        model = User

    username = factory.Sequence(lambda n: f'user{n}')
    email = factory.LazyAttribute(lambda obj: f'{obj.username}@example.com')
    first_name = factory.Faker('first_name')
    last_name = factory.Faker('last_name')

class PostFactory(DjangoModelFactory):
    class Meta:
        model = Post

    title = factory.Faker('sentence', nb_words=5)
    content = factory.Faker('paragraph', nb_sentences=10)
    author = factory.SubFactory(UserFactory)
    is_published = True

class CommentFactory(DjangoModelFactory):
    class Meta:
        model = Comment

    post = factory.SubFactory(PostFactory)
    author = factory.SubFactory(UserFactory)
    content = factory.Faker('paragraph')

# Usage in tests
class PostTest(TestCase):
    def test_create_post_with_factory(self):
        post = PostFactory()
        self.assertIsNotNone(post.id)
        self.assertIsNotNone(post.author)

    def test_create_multiple_posts(self):
        posts = PostFactory.create_batch(10)
        self.assertEqual(Post.objects.count(), 10)

    def test_custom_values(self):
        user = UserFactory(username='specific_user')
        post = PostFactory(author=user, title='Specific Title')
        self.assertEqual(post.author.username, 'specific_user')
```

### Factory Boy with pytest-django

```python
# conftest.py - pytest fixtures available to all tests
import pytest
from tests.factories import UserFactory, PostFactory

@pytest.fixture
def user():
    """Create a test user using factory."""
    return UserFactory()

@pytest.fixture
def post(user):
    """Create a test post using factory."""
    return PostFactory(author=user)

@pytest.fixture
def published_posts(user):
    """Create multiple published posts."""
    return PostFactory.create_batch(5, author=user, is_published=True)


# test_models.py - using the fixtures
def test_create_post_with_factory(post):
    """Test post creation with factory."""
    assert post.id is not None
    assert post.author is not None


def test_create_multiple_posts(published_posts):
    """Test multiple posts creation."""
    assert Post.objects.count() == 5
    assert all(p.is_published for p in published_posts)


def test_custom_values():
    """Test factory with custom values."""
    user = UserFactory(username='specific_user')
    post = PostFactory(author=user, title='Specific Title')
    assert post.author.username == 'specific_user'
    assert post.title == 'Specific Title'
```

**Rule**: Use Factory Boy over JSON fixtures for maintainability and flexibility.

---

## Mocking External Services

```python
from unittest.mock import patch, Mock

# ✅ GOOD: Mock external API calls
class PaymentTest(TestCase):
    @patch('myapp.payment.stripe.Charge.create')
    def test_process_payment(self, mock_charge):
        """Test payment processing."""
        # Configure mock
        mock_charge.return_value = Mock(
            id='ch_123',
            status='succeeded'
        )

        # Call function that uses Stripe
        result = process_payment(amount=1000, token='tok_123')

        # Verify mock was called
        mock_charge.assert_called_once_with(
            amount=1000,
            currency='usd',
            source='tok_123'
        )

        # Verify result
        self.assertTrue(result['success'])
        self.assertEqual(result['charge_id'], 'ch_123')

    @patch('myapp.tasks.send_email.delay')
    def test_user_registration_sends_email(self, mock_send_email):
        """Test registration sends welcome email."""
        user = User.objects.create_user(
            username='test',
            email='test@example.com',
            password='pass'
        )

        # Verify email task was called
        mock_send_email.assert_called_once_with(
            user_id=user.id,
            template='welcome'
        )
```

### Mocking with pytest-django

```python
import pytest
from unittest.mock import patch, Mock

# ✅ GOOD: Using pytest with mocks
@pytest.mark.django_db
@patch('myapp.payment.stripe.Charge.create')
def test_process_payment(mock_charge):
    """Test payment processing."""
    # Configure mock
    mock_charge.return_value = Mock(
        id='ch_123',
        status='succeeded'
    )

    # Call function that uses Stripe
    result = process_payment(amount=1000, token='tok_123')

    # Verify mock was called
    mock_charge.assert_called_once_with(
        amount=1000,
        currency='usd',
        source='tok_123'
    )

    # Verify result
    assert result['success'] is True
    assert result['charge_id'] == 'ch_123'


@pytest.mark.django_db
@patch('myapp.tasks.send_email.delay')
def test_user_registration_sends_email(mock_send_email):
    """Test registration sends welcome email."""
    user = User.objects.create_user(
        username='test',
        email='test@example.com',
        password='pass'
    )

    # Verify email task was called
    mock_send_email.assert_called_once_with(
        user_id=user.id,
        template='welcome'
    )


# ✅ GOOD: Using pytest-mock plugin
def test_with_mocker(mocker, db):
    """Test using pytest-mock plugin."""
    # pip install pytest-mock
    mock_send = mocker.patch('myapp.notifications.send_sms')

    send_notification(phone='+1234567890', message='Test')

    mock_send.assert_called_once_with(
        phone='+1234567890',
        message='Test'
    )
```

---

## Testing Forms

```python
from django.test import TestCase

class PostFormTest(TestCase):
    def test_valid_form(self):
        """Test form with valid data."""
        data = {
            'title': 'Test Post',
            'content': 'Test content'
        }
        form = PostForm(data=data)
        self.assertTrue(form.is_valid())

    def test_invalid_form_missing_title(self):
        """Test form with missing required field."""
        data = {'content': 'Test content'}
        form = PostForm(data=data)
        self.assertFalse(form.is_valid())
        self.assertIn('title', form.errors)

    def test_invalid_form_title_too_long(self):
        """Test form with title exceeding max length."""
        data = {
            'title': 'x' * 201,
            'content': 'Test content'
        }
        form = PostForm(data=data)
        self.assertFalse(form.is_valid())
        self.assertIn('title', form.errors)
```

### Form Testing with pytest-django

```python
import pytest

def test_valid_form():
    """Test form with valid data."""
    data = {
        'title': 'Test Post',
        'content': 'Test content'
    }
    form = PostForm(data=data)
    assert form.is_valid()


def test_invalid_form_missing_title():
    """Test form with missing required field."""
    data = {'content': 'Test content'}
    form = PostForm(data=data)
    assert not form.is_valid()
    assert 'title' in form.errors


def test_invalid_form_title_too_long():
    """Test form with title exceeding max length."""
    data = {
        'title': 'x' * 201,
        'content': 'Test content'
    }
    form = PostForm(data=data)
    assert not form.is_valid()
    assert 'title' in form.errors


# ✅ GOOD: Parametrized form testing
@pytest.mark.parametrize('title,content,is_valid', [
    ('Valid', 'Valid content', True),
    ('', 'Valid content', False),  # Missing title
    ('Valid', '', False),  # Missing content
    ('x' * 201, 'Valid', False),  # Title too long
])
def test_post_form_validation(title, content, is_valid):
    """Test various form validation scenarios."""
    form = PostForm(data={'title': title, 'content': content})
    assert form.is_valid() == is_valid
```

---

## Coverage

```bash
pip install coverage
```

```bash
# Run tests with coverage
coverage run --source='.' manage.py test

# View coverage report
coverage report

# Generate HTML report
coverage html
# Open htmlcov/index.html in browser
```

```ini
# .coveragerc
[run]
omit =
    */migrations/*
    */tests/*
    */venv/*
    manage.py

[report]
exclude_lines =
    pragma: no cover
    def __repr__
    raise AssertionError
    raise NotImplementedError
    if __name__ == .__main__.:
```

### Coverage with pytest

```bash
# Install pytest-cov
pip install pytest-cov

# Run tests with coverage
pytest --cov=myapp

# Generate HTML report
pytest --cov=myapp --cov-report=html

# Coverage with minimum threshold
pytest --cov=myapp --cov-fail-under=80

# Show missing lines
pytest --cov=myapp --cov-report=term-missing
```

## Performance Testing

```python
from django.test import TestCase
from django.test.utils import override_settings
import time

class PerformanceTest(TestCase):
    def test_query_count(self):
        """Test number of queries."""
        PostFactory.create_batch(10)

        with self.assertNumQueries(2):  # Should be 2 queries max
            posts = Post.objects.select_related('author').all()
            list(posts)  # Force evaluation

    def test_response_time(self):
        """Test view response time."""
        start = time.time()
        response = self.client.get('/posts/')
        duration = time.time() - start

        self.assertEqual(response.status_code, 200)
        self.assertLess(duration, 0.5)  # Should respond in < 500ms
```

### Performance Testing with pytest

```python
import pytest
import time

@pytest.mark.django_db
def test_query_count(django_assert_num_queries):
    """Test number of queries."""
    PostFactory.create_batch(10)

    # Should be 2 queries max
    with django_assert_num_queries(2):
        posts = Post.objects.select_related('author').all()
        list(posts)  # Force evaluation


def test_response_time(client, test_post):
    """Test view response time."""
    start = time.time()
    response = client.get('/posts/')
    duration = time.time() - start

    assert response.status_code == 200
    assert duration < 0.5  # Should respond in < 500ms


@pytest.mark.django_db
def test_no_n_plus_one(django_assert_num_queries):
    """Test avoiding N+1 queries."""
    PostFactory.create_batch(10)

    # Should execute constant queries regardless of post count
    with django_assert_num_queries(3):
        posts = Post.objects.select_related('author').prefetch_related('comments')
        for post in posts:
            # Access related objects
            _ = post.author.username
            _ = list(post.comments.all())
```

---

## Advanced pytest Patterns

### Shared Fixtures with conftest.py

```python
# tests/conftest.py - Available to all test files
import pytest
from tests.factories import UserFactory, PostFactory

@pytest.fixture
def api_client():
    """DRF API client."""
    from rest_framework.test import APIClient
    return APIClient()

@pytest.fixture
def authenticated_client(api_client, user):
    """Authenticated API client."""
    api_client.force_authenticate(user=user)
    return api_client

@pytest.fixture
def user(db):
    """Create test user."""
    return UserFactory()

@pytest.fixture
def admin_user(db):
    """Create admin user."""
    return UserFactory(is_staff=True, is_superuser=True)
```

### Custom Markers

```python
# pytest.ini
[pytest]
markers =
    slow: marks tests as slow (deselect with '-m "not slow"')
    integration: marks tests as integration tests
    unit: marks tests as unit tests
    smoke: marks tests as smoke tests

# Usage in tests
@pytest.mark.slow
def test_expensive_operation(db):
    """This test takes a long time."""
    pass

@pytest.mark.integration
def test_full_workflow(client):
    """Integration test."""
    pass

# Run only fast tests
# pytest -m "not slow"

# Run only smoke tests
# pytest -m smoke
```

### Testing Settings Overrides

```python
def test_with_custom_setting(settings):
    """Test with modified settings."""
    settings.DEBUG = False
    settings.CACHES = {
        'default': {
            'BACKEND': 'django.core.cache.backends.dummy.DummyCache'
        }
    }
    # Test behavior with these settings


@pytest.mark.django_db
def test_email_sending(mailoutbox):
    """Test email is sent."""
    send_welcome_email('user@example.com')

    assert len(mailoutbox) == 1
    assert mailoutbox[0].to == ['user@example.com']
    assert 'Welcome' in mailoutbox[0].subject
```

### Testing Management Commands

```python
import pytest
from io import StringIO
from django.core.management import call_command

@pytest.mark.django_db
def test_management_command():
    """Test custom management command."""
    out = StringIO()
    call_command('import_posts', '--source=test.csv', stdout=out)

    assert 'Successfully imported' in out.getvalue()
    assert Post.objects.count() > 0


@pytest.mark.django_db
def test_command_with_error():
    """Test command error handling."""
    with pytest.raises(CommandError):
        call_command('import_posts', '--source=nonexistent.csv')
```

### Async View Testing

```python
import pytest

@pytest.mark.django_db
@pytest.mark.asyncio
async def test_async_view(async_client):
    """Test async view."""
    response = await async_client.get('/async-endpoint/')
    assert response.status_code == 200


@pytest.mark.django_db(transaction=True)
@pytest.mark.asyncio
async def test_async_with_transactions(async_client):
    """Test async view with transaction support."""
    user = await User.objects.acreate(username='async_user')
    response = await async_client.get(f'/users/{user.id}/')
    assert response.status_code == 200
```

---

## Choosing Between Django TestCase and pytest-django

### Use Django TestCase when:
- Team is already familiar with unittest-style tests
- Working on legacy Django project with existing TestCase tests
- Prefer explicit class-based organization
- Need Django-specific test client features

### Use pytest-django when:
- Starting a new project
- Want less boilerplate code
- Need powerful fixtures and dependency injection
- Want parametrized testing
- Need to run tests in parallel easily
- Want to use pytest plugins ecosystem

### Can use both:
pytest can run Django TestCase tests, so you can gradually migrate or use both styles in the same project.

```bash
# pytest runs both styles
pytest  # Runs both TestCase classes and pytest functions
```

---

## Testing Best Practices Checklist

✅ Test one thing per test method/function
✅ Use descriptive test names (test_what_when_expected)
✅ Use Factory Boy instead of JSON fixtures
✅ Test both success and failure cases
✅ Test edge cases and boundary conditions
✅ Test permissions and authorization
✅ Mock external services (APIs, email, payment gateways)
✅ Use fixtures (pytest) or setUp() (TestCase) for reusable data
✅ Test database queries (assertNumQueries / django_assert_num_queries)
✅ Aim for >80% code coverage
✅ Run tests before committing code
✅ Use CI/CD to run tests automatically
✅ Keep tests fast (mock slow operations, use --reuse-db)
✅ Test what could break, not Django's built-in functionality
✅ Use parametrized tests to reduce duplication
✅ Organize tests in dedicated test directories
✅ Run tests in parallel (pytest -n auto)
✅ Use meaningful assertion messages

---

## Quick Reference

### Django TestCase
```python
from django.test import TestCase

class MyTest(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='test')

    def test_something(self):
        self.assertEqual(self.user.username, 'test')
```

### pytest-django
```python
import pytest

@pytest.fixture
def user(db):
    return User.objects.create_user(username='test')

def test_something(user):
    assert user.username == 'test'
```

### Running Tests
```bash
# Django TestCase
python manage.py test

# pytest-django
pytest
pytest --reuse-db --no-migrations  # Faster
pytest -n auto  # Parallel
pytest -v  # Verbose
pytest -k "test_user"  # Run matching tests
pytest tests/test_models.py::test_create_user  # Specific test
```

---

**Remember**: Good tests give you confidence to refactor and catch bugs early. Write tests first (TDD) or immediately after implementation.
