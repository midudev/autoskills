---
name: django-expert
description: Expert Django backend development guidance. Use when creating Django models, views, serializers, or APIs; debugging ORM queries or migrations; optimizing database performance; implementing authentication; writing tests; or working with Django REST Framework. Follows Django best practices and modern patterns.
---

# Django Expert

## Overview

This skill provides expert guidance for Django backend development with comprehensive coverage of models, views, Django REST Framework, forms, authentication, testing, and performance optimization. It follows official Django best practices and modern Python conventions to help you build robust, maintainable applications.

**Key Capabilities:**
- Model design with optimal ORM patterns
- View implementation (FBV, CBV, DRF viewsets)
- Django REST Framework API development
- Query optimization and performance tuning
- Authentication and permissions
- Testing strategies and patterns
- Security best practices

## When to Use

Invoke this skill when you encounter these triggers:

**Model & Database Work:**
- "Create a Django model for..."
- "Optimize this queryset/database query"
- "Generate migrations for..."
- "Design database schema for..."
- "Fix N+1 query problem"

**View & API Development:**
- "Create an API endpoint for..."
- "Build a Django view that..."
- "Implement DRF serializer/viewset"
- "Add filtering/pagination to API"

**Authentication & Security:**
- "Implement authentication/permissions"
- "Create custom user model"
- "Secure this endpoint/view"

**Testing & Quality:**
- "Write tests for this Django app"
- "Debug this Django error/issue"
- "Review Django code for issues"

**Performance & Optimization:**
- "This Django view is slow"
- "Optimize database queries"
- "Add caching to..."

**Production Deployment:**
- "Deploy Django to production"
- "Configure Django for production"
- "Set up HTTPS/SSL for Django"
- "Production settings checklist"
- "Configure production database/cache"

## Instructions

Follow this workflow when handling Django development requests:

### 1. Analyze the Request and Gather Context

**Identify the task type:**
- Model design (database schema, relationships, migrations)
- View/API development (FBV, CBV, DRF viewsets, serializers)
- Query optimization (N+1 problems, database performance)
- Authentication/permissions (user models, access control)
- Testing (unit tests, integration tests, fixtures)
- Security review (CSRF, XSS, SQL injection, permissions)
- Production deployment (settings, HTTPS, database, caching, monitoring)
- Template rendering (Django templates, context processors)

**Leverage available context:**
- If `django-ai-boost` MCP server is available, use it to understand project structure and existing patterns
- Read relevant existing code to understand conventions
- Check Django version for compatibility considerations

### 2. Load Relevant Reference Documentation

Based on the task type, reference the appropriate bundled documentation:

- **Models/ORM work** -> `references/models-and-orm.md`
  - Model design patterns and field choices
  - Relationship configurations (ForeignKey, ManyToMany)
  - Custom managers and QuerySet methods
  - Migration strategies

- **View/API development** -> `references/views-and-urls.md` + `references/drf-guidelines.md`
  - FBV vs CBV decision criteria
  - DRF serializers, viewsets, and routers
  - URL configuration patterns
  - Middleware and request/response handling

- **Performance issues** -> `references/performance-optimization.md`
  - Query optimization techniques (select_related, prefetch_related)
  - Caching strategies (Redis, Memcached, database caching)
  - Database indexing and query profiling
  - Connection pooling and async patterns

- **Production deployment** -> `references/production-deployment.md`
  - Critical settings (DEBUG, SECRET_KEY, ALLOWED_HOSTS)
  - HTTPS and SSL/TLS configuration
  - Database and cache configuration
  - Static/media file serving
  - Error monitoring and logging
  - Deployment process and health checks

- **Security concerns** -> `references/security-checklist.md`
  - CSRF/XSS/SQL injection prevention
  - Authentication and authorization patterns
  - Secure configuration practices
  - Input validation and sanitization

- **Testing tasks** -> `references/testing-strategies.md`
  - Test structure and organization
  - Fixtures and factories
  - Mocking external dependencies
  - Coverage and CI/CD integration

### 3. Implement Following Django Best Practices

**Code quality standards:**
- Follow PEP 8 and Django coding style
- Use Django built-ins over third-party packages when possible
- Keep views thin, use services/managers for business logic
- Write descriptive variable names and add docstrings for complex logic
- Handle errors gracefully with appropriate exceptions

**Django-specific patterns:**
- Use `select_related()` for FK/OneToOne, `prefetch_related()` for reverse FK/M2M
- Leverage class-based views and mixins for code reuse
- Use Django forms/serializers for validation
- Follow Django's migration workflow (never edit applied migrations)
- Use Django's built-in security features (CSRF tokens, auth decorators)

**API development (DRF):**
- Use ModelSerializer for standard CRUD operations
- Implement proper pagination and filtering
- Use appropriate permission classes
- Follow RESTful conventions for endpoints
- Version APIs when making breaking changes

### 4. Validate and Test

Before presenting the solution:

**Code review:**
- Check for N+1 query problems (use Django Debug Toolbar mentally)
- Verify proper error handling and edge cases
- Ensure security best practices are followed
- Confirm migrations are clean and reversible

**Testing considerations:**
- Suggest or write appropriate tests for new functionality
- Verify test coverage for critical paths
- Check that fixtures/factories are maintainable

**Performance check:**
- Review database queries for efficiency
- Consider caching opportunities
- Verify proper use of database indexes

## Bundled Resources

**references/** - Comprehensive Django documentation loaded into context as needed

These reference files provide detailed guidance beyond this SKILL.md overview:

- **`references/models-and-orm.md`** (~11k words)
  - Model field types and best practices
  - Relationship configurations (ForeignKey, OneToOne, ManyToMany)
  - Custom managers and QuerySet methods
  - Migration patterns and common pitfalls
  - Database-level constraints and indexes

- **`references/views-and-urls.md`** (~17k words)
  - Function-based vs class-based view trade-offs
  - CBV mixins and inheritance patterns
  - URL routing and reverse resolution
  - Middleware implementation
  - Request/response lifecycle

- **`references/drf-guidelines.md`** (~18k words)
  - Serializer patterns (ModelSerializer, nested serializers)
  - ViewSet and router configurations
  - Pagination, filtering, and search
  - Authentication and permission classes
  - API versioning strategies
  - Performance optimization for APIs

- **`references/testing-strategies.md`** (~18k words)
  - Test organization and structure
  - Factory patterns vs fixtures
  - Testing views, models, and serializers
  - Mocking external services
  - Test database optimization
  - CI/CD integration

- **`references/security-checklist.md`** (~12k words)
  - CSRF protection implementation
  - XSS prevention techniques
  - SQL injection defense
  - Authentication best practices
  - Permission and authorization patterns
  - Secure settings configuration

- **`references/performance-optimization.md`** (~14k words)
  - Query optimization (select_related, prefetch_related, only, defer)
  - Database indexing strategies
  - Caching layers (Redis, Memcached, database cache)
  - Database connection pooling
  - Profiling and monitoring tools
  - Async views and background tasks

- **`references/production-deployment.md`** (~20k words)
  - Critical settings (DEBUG, SECRET_KEY, ALLOWED_HOSTS)
  - Database configuration and connection pooling
  - HTTPS/SSL configuration and security headers
  - Static and media file serving
  - Caching with Redis/Memcached
  - Email configuration for production
  - Error monitoring with Sentry
  - Logging and health checks
  - Zero-downtime deployment strategies

- **`references/examples.md`** - Practical implementation examples
  - Model design with custom managers
  - N+1 query optimization
  - DRF API endpoint implementation
  - Writing Django tests

## Additional Notes

**Django Version Compatibility:**
- Consider LTS releases (4.2, 5.2) for production
- Check deprecation warnings when upgrading
- Use `django-upgrade` tool for automated migration

**Common Pitfalls to Avoid:**
- Circular imports (use lazy references)
- Missing `related_name` on relationships
- Forgetting database indexes on frequently queried fields
- Using `get()` without exception handling
- N+1 queries in templates and serializers
