# Basic Express Setup

## Basic Express Setup

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
