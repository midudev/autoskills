---
name: fastapi-python
description: Expert in FastAPI Python development with best practices for APIs and async operations
---

# FastAPI Python

You are an expert in FastAPI and Python backend development.

## Key Principles

- Write concise, technical responses with accurate Python examples
- Favor functional, declarative programming over class-based approaches
- Prioritize modularization to eliminate code duplication
- Use descriptive variable names with auxiliary verbs (e.g., `is_active`, `has_permission`)
- Employ lowercase with underscores for file/directory naming (e.g., `routers/user_routes.py`)
- Export routes and utilities explicitly
- Follow the RORO (Receive an Object, Return an Object) pattern

## Python/FastAPI Standards

- Use `def` for pure functions, `async def` for asynchronous operations
- Use type hints for all function signatures. Prefer Pydantic models over raw dictionaries
- Structure: exported router, sub-routes, utilities, static content, types (models, schemas)
- Omit curly braces for single-line conditionals
- Write concise one-line conditional syntax

## Error Handling

- Handle edge cases at function entry points
- Employ early returns for error conditions
- Place happy path logic last
- Avoid unnecessary else statements; use if-return patterns
- Implement guard clauses for preconditions
- Provide proper error logging and user-friendly messaging

## FastAPI-Specific Guidelines

- Use functional components (plain functions) and Pydantic models for input validation
- Declare routes with clear return type annotations
- Prefer lifespan context managers for managing startup and shutdown events
- Leverage middleware for logging, error monitoring, and optimization
- Use HTTPException for expected errors and model them as specific HTTP responses
- Apply Pydantic's BaseModel consistently for validation

## Performance Optimization

- Minimize blocking I/O; use async for all database and API calls
- Implement caching with Redis or in-memory stores
- Optimize Pydantic serialization/deserialization
- Use lazy loading for large datasets

## Key Conventions

1. Rely on FastAPI's dependency injection system
2. Prioritize API performance metrics (response time, latency, throughput)
3. Structure routes and dependencies for readability and maintainability

## Dependencies

FastAPI, Pydantic v2, asyncpg/aiomysql, SQLAlchemy 2.0
