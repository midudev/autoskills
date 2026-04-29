---
name: nodejs-express-server
description: >
  Build production-ready Express.js servers with middleware, authentication,
  routing, and database integration. Use when creating REST APIs, managing
  requests/responses, implementing middleware chains, and handling server logic.
---

# Node.js Express Server

## Table of Contents

- [Overview](#overview)
- [When to Use](#when-to-use)
- [Quick Start](#quick-start)
- [Reference Guides](#reference-guides)
- [Best Practices](#best-practices)

## Overview

Create robust Express.js applications with proper routing, middleware chains, authentication mechanisms, and database integration following industry best practices.

## When to Use

- Building REST APIs with Node.js
- Implementing server-side request handling
- Creating middleware chains for cross-cutting concerns
- Managing authentication and authorization
- Connecting to databases from Node.js
- Implementing error handling and logging

## Quick Start

Minimal working example:

```javascript
const express = require("express");
const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.get("/health", (req, res) => {
  res.json({ status: "OK", timestamp: new Date().toISOString() });
});

// Error handling
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(err.status || 500).json({
    error: err.message,
    requestId: req.id,
  });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
```

## Reference Guides

Detailed implementations in the `references/` directory:

| Guide | Contents |
|---|---|
| [Basic Express Setup](references/basic-express-setup.md) | Basic Express Setup |
| [Middleware Chain Implementation](references/middleware-chain-implementation.md) | Middleware Chain Implementation |
| [Database Integration (PostgreSQL with Sequelize)](references/database-integration-postgresql-with-sequelize.md) | Database Integration (PostgreSQL with Sequelize) |
| [Authentication with JWT](references/authentication-with-jwt.md) | Authentication with JWT |
| [RESTful Routes with CRUD Operations](references/restful-routes-with-crud-operations.md) | RESTful Routes with CRUD Operations |
| [Error Handling Middleware](references/error-handling-middleware.md) | Error Handling Middleware |
| [Environment Configuration](references/environment-configuration.md) | Environment Configuration |

## Best Practices

### ✅ DO

- Use middleware for cross-cutting concerns
- Implement proper error handling
- Validate input data before processing
- Use async/await for async operations
- Implement authentication on protected routes
- Use environment variables for configuration
- Add logging and monitoring
- Use HTTPS in production
- Implement rate limiting
- Keep route handlers focused and small

### ❌ DON'T

- Handle errors silently
- Store sensitive data in code
- Use synchronous operations in routes
- Forget to validate user input
- Implement authentication in route handlers
- Use callback hell (use promises/async-await)
- Expose stack traces in production
- Trust client-side validation only
