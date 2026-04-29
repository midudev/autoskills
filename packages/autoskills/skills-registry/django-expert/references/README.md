# Django Expert - Reference Documentation

This directory contains comprehensive Django best practices documentation that will be loaded into Claude's context when needed.

## Purpose

Reference files provide detailed guidelines, patterns, and examples that would make SKILL.md too long (>5k words). Claude will read these files as needed based on the specific Django task at hand.

## Recommended Reference Files

Create the following markdown files in this directory to provide comprehensive Django guidance:

### 1. `models-and-orm.md` - Model Design & ORM Best Practices

**Topics to cover:**
- Model field types and when to use each
- Database relationships (ForeignKey, ManyToMany, OneToOne)
- Model Meta options (ordering, indexes, constraints)
- Custom model methods and properties
- Model managers and custom querysets
- Database query optimization (select_related, prefetch_related, only, defer)
- Common ORM patterns and anti-patterns
- Migration best practices
- Database indexing strategies

**Example structure:**
```markdown
# Django Models and ORM Best Practices

## Model Design Patterns

### Field Choices
- Use TextChoices or IntegerChoices for Django 3.0+
- Keep choices close to the model definition
[detailed examples...]

## Query Optimization

### N+1 Query Problem
[explanation and solutions...]

### Using select_related vs prefetch_related
[detailed guidance with examples...]
```

### 2. `views-and-urls.md` - Views, URLs, and Request Handling

**Topics to cover:**
- Function-based views vs class-based views
- When to use generic CBVs (ListView, DetailView, CreateView, etc.)
- Custom mixins and view composition
- URL patterns and routing best practices
- Request/response handling
- Middleware usage
- Context processors
- Form handling in views
- Error handling and custom error pages

### 3. `drf-guidelines.md` - Django REST Framework Best Practices

**Topics to cover:**
- Serializer patterns (ModelSerializer, nested serializers, write-only fields)
- ViewSets vs APIView vs function-based views
- Permissions and authentication
- Filtering, searching, and pagination
- Versioning strategies
- Custom actions and decorators
- Response formatting
- Error handling in APIs
- Testing DRF endpoints

### 4. `testing-strategies.md` - Testing Django Applications

**Topics to cover:**
- Test organization and structure
- TestCase vs TransactionTestCase
- Factory patterns and fixtures
- Mocking external services
- Testing models, views, and APIs
- Testing permissions and authentication
- Database testing best practices
- Coverage and test performance
- Integration vs unit testing

### 5. `security-checklist.md` - Django Security Best Practices

**Topics to cover:**
- CSRF protection
- XSS prevention
- SQL injection prevention
- Authentication and authorization
- Password handling and storage
- Secure settings for production
- HTTPS and SSL/TLS configuration
- Content Security Policy
- Rate limiting and throttling
- Security headers
- Common vulnerabilities and mitigations

### 6. `performance-optimization.md` - Performance and Scaling

**Topics to cover:**
- Database query optimization
- Caching strategies (per-view cache, template fragment cache, low-level cache)
- Redis/Memcached integration
- Database connection pooling
- Async views and background tasks (Celery)
- Static file optimization
- Database indexing and query profiling
- Monitoring and profiling tools
- Pagination strategies for large datasets

## How to Populate These Files

1. **Research**: Gather Django best practices from official docs, style guides, and community resources
2. **Structure**: Use clear headings, code examples, and explanations
3. **Examples**: Include both good and bad examples with explanations
4. **Keep Updated**: Maintain version-specific guidance (note Django version compatibility)
5. **Be Specific**: Provide concrete examples rather than general statements

## Example Reference File

Here's an example of what a well-structured reference file looks like:

```markdown
# Django REST Framework Guidelines

## Serializer Best Practices

### 1. Use ModelSerializer for Standard CRUD

For basic model serialization, always start with ModelSerializer:

```python
# Good
from rest_framework import serializers

class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = ['id', 'name', 'price', 'category']
        read_only_fields = ['id', 'created_at']
```

### 2. Nested Serializers for Relationships

For related objects, use nested serializers or use depth:

```python
# Option 1: Nested serializer (more control)
class OrderSerializer(serializers.ModelSerializer):
    items = OrderItemSerializer(many=True, read_only=True)

    class Meta:
        model = Order
        fields = ['id', 'items', 'total']

# Option 2: Auto-nesting with depth (simpler but less control)
class OrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = '__all__'
        depth = 1  # Be careful with performance
```

# [Continue with more patterns...]
```

## Usage

Claude will automatically read these files when working on Django tasks. You don't need to manually reference them - Claude will determine which references are needed based on the task.

## Notes

- Keep files focused on specific topics (don't create one giant file)
- Use code examples liberally
- Include both do's and don'ts
- Reference Django and DRF version numbers when relevant
- Link to official documentation for deep dives
