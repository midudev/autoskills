# Environment Configuration

## Environment Configuration

```javascript
require("dotenv").config();

const config = {
  port: process.env.PORT || 3000,
  env: process.env.NODE_ENV || "development",
  database: {
    url: process.env.DATABASE_URL,
    dialect: "postgres",
  },
  jwt: {
    secret: process.env.JWT_SECRET,
    expiresIn: "24h",
  },
  cors: {
    origin: process.env.CORS_ORIGIN || "http://localhost:3000",
  },
};

module.exports = config;
```
