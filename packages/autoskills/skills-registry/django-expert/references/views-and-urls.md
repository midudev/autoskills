# Django Views & URLs Best Practices

## Function-Based Views (FBV) vs Class-Based Views (CBV)

### When to Use Each

**Use Function-Based Views when:**
- Simple, straightforward logic
- Unique behavior that doesn't fit standard CRUD patterns
- You prefer explicit code over implicit behavior
- Handling a single HTTP method

**Use Class-Based Views when:**
- Standard CRUD operations (list, detail, create, update, delete)
- Sharing behavior across multiple views (mixins)
- Handling multiple HTTP methods on the same endpoint
- You want DRY code with Django's built-in generic views

## Function-Based Views

### Basic FBV Pattern

```python
from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse, JsonResponse
from django.contrib.auth.decorators import login_required

# ✅ GOOD: Simple, explicit view
def blog_list(request):
    posts = Post.objects.filter(is_published=True).order_by('-created_at')
    return render(request, 'blog/list.html', {'posts': posts})

# ✅ GOOD: Handle form submission
def create_post(request):
    if request.method == 'POST':
        form = PostForm(request.POST)
        if form.is_valid():
            post = form.save(commit=False)
            post.author = request.user
            post.save()
            return redirect('post_detail', pk=post.pk)
    else:
        form = PostForm()

    return render(request, 'blog/create.html', {'form': form})

# ✅ GOOD: Protected view
@login_required
def user_dashboard(request):
    user_posts = Post.objects.filter(author=request.user)
    return render(request, 'dashboard.html', {'posts': user_posts})
```

### Handling Different HTTP Methods

```python
from django.views.decorators.http import require_http_methods, require_POST

# ✅ GOOD: Restrict to specific methods
@require_http_methods(["GET", "POST"])
def contact_form(request):
    if request.method == 'POST':
        # Handle form submission
        ...
    return render(request, 'contact.html')

# ✅ GOOD: POST-only view
@require_POST
def delete_post(request, pk):
    post = get_object_or_404(Post, pk=pk, author=request.user)
    post.delete()
    return redirect('blog_list')

# ❌ BAD: No method restriction
def delete_post(request, pk):
    # Can be triggered by GET request! (CSRF vulnerability)
    post = get_object_or_404(Post, pk=pk)
    post.delete()
    return redirect('blog_list')
```

## Class-Based Views

### Generic Class-Based Views

```python
from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.urls import reverse_lazy

# ✅ GOOD: Simple list view
class PostListView(ListView):
    model = Post
    template_name = 'blog/list.html'
    context_object_name = 'posts'
    paginate_by = 20

    def get_queryset(self):
        return Post.objects.filter(is_published=True).select_related('author')

# ✅ GOOD: Detail view with related objects
class PostDetailView(DetailView):
    model = Post
    template_name = 'blog/detail.html'
    context_object_name = 'post'

    def get_queryset(self):
        return Post.objects.select_related('author').prefetch_related('comments')

# ✅ GOOD: Create view with form validation
class PostCreateView(LoginRequiredMixin, CreateView):
    model = Post
    form_class = PostForm
    template_name = 'blog/create.html'
    success_url = reverse_lazy('blog_list')

    def form_valid(self, form):
        form.instance.author = self.request.user
        return super().form_valid(form)

# ✅ GOOD: Update view with permission check
class PostUpdateView(LoginRequiredMixin, UpdateView):
    model = Post
    form_class = PostForm
    template_name = 'blog/edit.html'

    def get_queryset(self):
        # Only allow editing own posts
        return Post.objects.filter(author=self.request.user)

# ✅ GOOD: Delete view
class PostDeleteView(LoginRequiredMixin, DeleteView):
    model = Post
    success_url = reverse_lazy('blog_list')

    def get_queryset(self):
        return Post.objects.filter(author=self.request.user)
```

### Custom Class-Based Views

```python
from django.views import View

# ✅ GOOD: Handle multiple methods
class PostTogglePublishView(LoginRequiredMixin, View):
    def post(self, request, pk):
        post = get_object_or_404(Post, pk=pk, author=request.user)
        post.is_published = not post.is_published
        post.save()
        return JsonResponse({
            'success': True,
            'is_published': post.is_published
        })

# ✅ GOOD: API-like view
class PostAPIView(View):
    def get(self, request, pk):
        post = get_object_or_404(Post, pk=pk)
        return JsonResponse({
            'id': post.id,
            'title': post.title,
            'content': post.content,
        })

    def post(self, request, pk):
        post = get_object_or_404(Post, pk=pk, author=request.user)
        data = json.loads(request.body)
        post.title = data.get('title', post.title)
        post.save()
        return JsonResponse({'success': True})
```

## Mixins

Mixins add reusable functionality to CBVs.

### Built-in Mixins

```python
from django.contrib.auth.mixins import LoginRequiredMixin, PermissionRequiredMixin, UserPassesTestMixin

# ✅ GOOD: Require login
class UserDashboardView(LoginRequiredMixin, ListView):
    model = Post
    login_url = '/login/'  # Where to redirect if not logged in

    def get_queryset(self):
        return Post.objects.filter(author=self.request.user)

# ✅ GOOD: Require specific permission
class PostCreateView(PermissionRequiredMixin, CreateView):
    model = Post
    permission_required = 'blog.add_post'
    # Redirects to login if permission denied

# ✅ GOOD: Custom permission check
class PostUpdateView(UserPassesTestMixin, UpdateView):
    model = Post

    def test_func(self):
        post = self.get_object()
        return post.author == self.request.user or self.request.user.is_staff
```

### Custom Mixins

```python
# ✅ GOOD: Reusable mixin for adding context
class PageTitleMixin:
    page_title = ''

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['page_title'] = self.page_title
        return context

# ✅ GOOD: Mixin for filtering by author
class FilterByAuthorMixin:
    def get_queryset(self):
        queryset = super().get_queryset()
        return queryset.filter(author=self.request.user)

# Usage
class MyPostsView(FilterByAuthorMixin, PageTitleMixin, ListView):
    model = Post
    page_title = 'My Posts'
    template_name = 'blog/my_posts.html'
```

**Rule**: Mixins should go before the view class in inheritance order.

## URL Configuration

### URL Patterns

```python
from django.urls import path, include
from . import views

app_name = 'blog'  # ✅ GOOD: Namespace your URLs

urlpatterns = [
    # ✅ GOOD: Named URL patterns
    path('', views.PostListView.as_view(), name='post_list'),
    path('post/<int:pk>/', views.PostDetailView.as_view(), name='post_detail'),
    path('post/create/', views.PostCreateView.as_view(), name='post_create'),
    path('post/<int:pk>/edit/', views.PostUpdateView.as_view(), name='post_edit'),
    path('post/<int:pk>/delete/', views.PostDeleteView.as_view(), name='post_delete'),

    # ✅ GOOD: Use path converters
    path('post/<slug:slug>/', views.post_detail_by_slug, name='post_by_slug'),
    path('category/<str:category>/', views.posts_by_category, name='posts_by_category'),
    path('archive/<int:year>/<int:month>/', views.archive, name='archive'),
]
```

### URL Converters

Built-in converters:
- `<int:name>` - Matches integers
- `<str:name>` - Matches non-empty strings (excluding '/')
- `<slug:name>` - Matches slugs (letters, numbers, hyphens, underscores)
- `<uuid:name>` - Matches UUIDs
- `<path:name>` - Matches any string (including '/')

```python
# Custom converter
class YearConverter:
    regex = '[0-9]{4}'

    def to_python(self, value):
        return int(value)

    def to_url(self, value):
        return f'{value:04d}'

# Register it
from django.urls import register_converter
register_converter(YearConverter, 'year')

# Use it
path('archive/<year:year>/', views.archive, name='archive')
```

### Including Other URLconfs

```python
# project/urls.py
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('blog/', include('blog.urls')),  # ✅ GOOD: Prefix app URLs
    path('api/', include('api.urls')),
    path('accounts/', include('django.contrib.auth.urls')),  # Login/logout
]
```

### Reverse URL Resolution

```python
from django.urls import reverse
from django.shortcuts import redirect

# ✅ GOOD: Use reverse() in views
def my_view(request):
    return redirect(reverse('blog:post_list'))

# ✅ GOOD: With arguments
def after_create(request, post):
    return redirect(reverse('blog:post_detail', kwargs={'pk': post.pk}))

# ✅ GOOD: In templates
# <a href="{% url 'blog:post_detail' pk=post.pk %}">View Post</a>
```

**Rule**: Never hardcode URLs. Always use `reverse()` in Python and `{% url %}` in templates.

## Context and Template Rendering

### Adding Context to Views

```python
# Function-based view
def blog_list(request):
    posts = Post.objects.filter(is_published=True)
    categories = Category.objects.all()

    context = {
        'posts': posts,
        'categories': categories,
        'page_title': 'Blog Posts',
    }
    return render(request, 'blog/list.html', context)

# Class-based view
class PostListView(ListView):
    model = Post

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['categories'] = Category.objects.all()
        context['page_title'] = 'Blog Posts'
        return context
```

### Context Processors

For data needed across ALL templates:

```python
# blog/context_processors.py
def blog_stats(request):
    return {
        'total_posts': Post.objects.count(),
        'total_published': Post.objects.filter(is_published=True).count(),
    }

# settings.py
TEMPLATES = [
    {
        'OPTIONS': {
            'context_processors': [
                ...
                'blog.context_processors.blog_stats',
            ],
        },
    },
]
```

**Rule**: Only use context processors for truly global data. Don't overuse them.

## HTTP Responses

### Response Types

```python
from django.http import HttpResponse, JsonResponse, HttpResponseRedirect, Http404
from django.shortcuts import render, redirect

# ✅ GOOD: HTML response
def blog_list(request):
    posts = Post.objects.all()
    return render(request, 'blog/list.html', {'posts': posts})

# ✅ GOOD: JSON response
def post_api(request, pk):
    post = get_object_or_404(Post, pk=pk)
    return JsonResponse({
        'id': post.id,
        'title': post.title,
        'content': post.content,
    })

# ✅ GOOD: Redirect
def old_url(request):
    return redirect('new_url_name')

# ✅ GOOD: 404 error
def post_detail(request, pk):
    try:
        post = Post.objects.get(pk=pk)
    except Post.DoesNotExist:
        raise Http404("Post not found")

    return render(request, 'blog/detail.html', {'post': post})

# ✅ BETTER: Use get_object_or_404
def post_detail(request, pk):
    post = get_object_or_404(Post, pk=pk)
    return render(request, 'blog/detail.html', {'post': post})
```

### Custom Response Status Codes

```python
from django.http import HttpResponse

# 201 Created
def create_post(request):
    post = Post.objects.create(...)
    return HttpResponse('Created', status=201)

# 204 No Content
def delete_post(request, pk):
    post = get_object_or_404(Post, pk=pk)
    post.delete()
    return HttpResponse(status=204)

# 400 Bad Request
def api_view(request):
    if not request.POST.get('required_field'):
        return JsonResponse({'error': 'Missing field'}, status=400)
    ...

# 403 Forbidden
from django.http import HttpResponseForbidden

def delete_post(request, pk):
    post = get_object_or_404(Post, pk=pk)
    if post.author != request.user:
        return HttpResponseForbidden('You cannot delete this post')
    ...
```

## Error Handling

### Custom Error Pages

```python
# views.py
def custom_404(request, exception):
    return render(request, '404.html', status=404)

def custom_500(request):
    return render(request, '500.html', status=500)

# urls.py
handler404 = 'blog.views.custom_404'
handler500 = 'blog.views.custom_500'
```

### Exception Handling in Views

```python
from django.core.exceptions import ValidationError, PermissionDenied
import logging

logger = logging.getLogger(__name__)

# ✅ GOOD: Handle specific exceptions
def process_payment(request):
    try:
        result = payment_service.charge(request.POST)
        return JsonResponse({'success': True})
    except ValidationError as e:
        return JsonResponse({'error': str(e)}, status=400)
    except PermissionDenied:
        return JsonResponse({'error': 'Forbidden'}, status=403)
    except Exception as e:
        logger.exception("Payment processing failed")
        return JsonResponse({'error': 'Server error'}, status=500)
```

## Middleware

Middleware processes requests/responses globally.

### Custom Middleware

```python
# middleware.py
class RequestLoggingMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # Process request before view
        logger.info(f"{request.method} {request.path}")

        # Call the view
        response = self.get_response(request)

        # Process response after view
        logger.info(f"Response: {response.status_code}")

        return response

# settings.py
MIDDLEWARE = [
    ...
    'blog.middleware.RequestLoggingMiddleware',
]
```

### Common Middleware Patterns

```python
# Add custom header to all responses
class CustomHeaderMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        response = self.get_response(request)
        response['X-Custom-Header'] = 'value'
        return response

# Block requests from specific IPs
class IPBlockMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response
        self.blocked_ips = ['192.168.1.1']

    def __call__(self, request):
        ip = request.META.get('REMOTE_ADDR')
        if ip in self.blocked_ips:
            return HttpResponseForbidden('Access denied')
        return self.get_response(request)
```

## Decorators

### Common View Decorators

```python
from django.views.decorators.http import require_http_methods, require_POST
from django.views.decorators.cache import cache_page
from django.contrib.auth.decorators import login_required, permission_required

# ✅ GOOD: Combine decorators
@login_required
@require_POST
def delete_post(request, pk):
    ...

# ✅ GOOD: Cache view for 5 minutes
@cache_page(60 * 5)
def blog_list(request):
    posts = Post.objects.all()
    return render(request, 'blog/list.html', {'posts': posts})

# ✅ GOOD: Require permission
@permission_required('blog.add_post')
def create_post(request):
    ...
```

### Custom Decorators

```python
from functools import wraps

# ✅ GOOD: Custom decorator for AJAX-only views
def ajax_required(view_func):
    @wraps(view_func)
    def wrapper(request, *args, **kwargs):
        if not request.headers.get('X-Requested-With') == 'XMLHttpRequest':
            return HttpResponseBadRequest('AJAX required')
        return view_func(request, *args, **kwargs)
    return wrapper

# Usage
@ajax_required
def get_comments(request, post_id):
    comments = Comment.objects.filter(post_id=post_id)
    return JsonResponse({'comments': list(comments.values())})
```

## View Best Practices Checklist

✅ Use `get_object_or_404()` instead of try/except
✅ Always validate user permissions (authentication ≠ authorization)
✅ Use `select_related()` and `prefetch_related()` to avoid N+1 queries
✅ Name all URL patterns for easier maintenance
✅ Use namespaces (`app_name`) in URL configurations
✅ Validate form data before saving
✅ Return appropriate HTTP status codes
✅ Log errors and security-relevant events
✅ Use CSRF protection on all POST/PUT/DELETE views
✅ Add caching to expensive views when appropriate
✅ Keep views focused (single responsibility)
✅ Extract complex logic into model methods or services

---

**Remember**: Views should be thin - they orchestrate, they don't contain business logic. Put complex logic in models, managers, or service modules.
