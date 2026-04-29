# Error Handling Middleware

## Error Handling Middleware

```javascript
class AppError extends Error {
  constructor(message, statusCode) {
    super(message);
    this.statusCode = statusCode;
    Error.captureStackTrace(this, this.constructor);
  }
}

app.use((err, req, res, next) => {
  err.statusCode = err.statusCode || 500;

  if (err.name === "SequelizeValidationError") {
    return res.status(400).json({
      error: "Validation failed",
      details: err.errors.map((e) => ({ field: e.path, message: e.message })),
    });
  }

  if (process.env.NODE_ENV === "production") {
    return res.status(err.statusCode).json({
      error: err.message,
      requestId: req.id,
    });
  }

  res.status(err.statusCode).json({
    error: err.message,
    stack: err.stack,
  });
});

app.use((req, res) => {
  res.status(404).json({ error: "Route not found" });
});
```
