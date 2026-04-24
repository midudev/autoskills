---
name: flask-api-development
description: >
  Develop lightweight Flask APIs with routing, blueprints, database integration,
  authentication, and request/response handling. Use when building RESTful APIs,
  microservices, or lightweight web services with Flask.
---

# Flask API Development

## Table of Contents

- [Overview](#overview)
- [When to Use](#when-to-use)
- [Quick Start](#quick-start)
- [Reference Guides](#reference-guides)
- [Best Practices](#best-practices)

## Overview

Create efficient Flask APIs with blueprints for modular organization, SQLAlchemy for ORM, JWT authentication, comprehensive error handling, and proper request validation following REST principles.

## When to Use

- Building RESTful APIs with Flask
- Creating microservices with minimal overhead
- Implementing lightweight authentication systems
- Designing API endpoints with proper validation
- Integrating with relational databases
- Building request/response handling systems

## Quick Start

Minimal working example:

```python
# app.py
from flask import Flask, request, jsonify
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager
import os

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URL', 'sqlite:///app.db')
app.config['JWT_SECRET_KEY'] = os.getenv('JWT_SECRET_KEY', 'dev-secret')
app.config['JSON_SORT_KEYS'] = False

db = SQLAlchemy(app)
jwt = JWTManager(app)
CORS(app)

# Request ID middleware
@app.before_request
def assign_request_id():
    import uuid
    request.request_id = str(uuid.uuid4())

# Error handlers
@app.errorhandler(400)
def bad_request(error):
// ... (see reference guides for full implementation)
```

## Reference Guides

Detailed implementations in the `references/` directory:

| Guide | Contents |
|---|---|
| [Flask Application Setup](references/flask-application-setup.md) | Flask Application Setup |
| [Database Models with SQLAlchemy](references/database-models-with-sqlalchemy.md) | Database Models with SQLAlchemy |
| [Authentication and JWT](references/authentication-and-jwt.md) | Authentication and JWT |
| [Blueprints for Modular API Design](references/blueprints-for-modular-api-design.md) | Blueprints for Modular API Design |
| [Request Validation](references/request-validation.md) | Request Validation |
| [Application Factory and Configuration](references/application-factory-and-configuration.md) | Application Factory and Configuration |

## Best Practices

### ✅ DO

- Use blueprints for modular organization
- Implement proper authentication with JWT
- Validate all user input
- Use SQLAlchemy ORM for database operations
- Implement comprehensive error handling
- Use pagination for collection endpoints
- Log errors and important events
- Return appropriate HTTP status codes
- Implement CORS properly
- Use environment variables for configuration

### ❌ DON'T

- Store secrets in code
- Use global variables for shared state
- Ignore database transactions
- Trust user input without validation
- Return stack traces in production
- Use mutable default arguments
- Forget to handle database connection errors
- Implement authentication in route handlers
