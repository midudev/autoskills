---
name: deno-typescript
description: Guidelines for developing with Deno and TypeScript using modern runtime features, security model, and native tooling
---

# Deno TypeScript Development

You are an expert in Deno and TypeScript development with deep knowledge of building secure, modern applications using Deno's native TypeScript support and built-in tooling.

## TypeScript General Guidelines

### Basic Principles

- Use English for all code and documentation
- Always declare types for variables and functions (parameters and return values)
- Avoid using `any` type - create necessary types instead
- Use JSDoc to document public classes and methods
- Write concise, maintainable, and technically accurate code
- Use functional and declarative programming patterns
- No configuration needed - Deno runs TypeScript natively

### Nomenclature

- Use PascalCase for classes, types, and interfaces
- Use camelCase for variables, functions, and methods
- Use kebab-case for file and directory names
- Use UPPERCASE for environment variables
- Use descriptive variable names with auxiliary verbs: `isLoading`, `hasError`, `canDelete`
- Start each function with a verb

### Functions

- Write short functions with a single purpose
- Use arrow functions for simple operations
- Use async/await for asynchronous operations
- Prefer the RO-RO pattern for multiple parameters

### Types and Interfaces

- Prefer interfaces over types for object shapes
- Avoid enums; use const objects with `as const`
- Use Zod for runtime validation with inferred types
- Use `readonly` for immutable properties

## Deno-Specific Guidelines

### Project Structure

```
src/
  routes/
    {resource}/
      mod.ts
      handlers.ts
      validators.ts
  middleware/
    auth.ts
    logger.ts
  services/
    {domain}_service.ts
  types/
    mod.ts
  utils/
    mod.ts
  deps.ts
  main.ts
deno.json
```

### Module System

- Use ES modules with explicit file extensions
- Use `deps.ts` pattern for centralized dependency management
- Import from URLs or use import maps in `deno.json`
- Use JSR (jsr.io) for Deno-native packages

```typescript
// deps.ts - centralized dependencies
export { serve } from "https://deno.land/std@0.208.0/http/server.ts";
export { z } from "https://deno.land/x/zod@v3.22.4/mod.ts";

// Using import maps in deno.json
{
  "imports": {
    "std/": "https://deno.land/std@0.208.0/",
    "hono": "https://deno.land/x/hono@v3.11.7/mod.ts"
  }
}
```

### Security Model

Deno is secure by default. Request only necessary permissions:

```bash
# Run with specific permissions
deno run --allow-net --allow-read=./data --allow-env main.ts

# Permission flags
--allow-net=example.com    # Network access to specific domains
--allow-read=./path        # File read access
--allow-write=./path       # File write access
--allow-env=API_KEY        # Environment variable access
--allow-run=cmd            # Subprocess execution
```

```typescript
// Programmatic permission requests
const status = await Deno.permissions.request({ name: "net", host: "api.example.com" });
if (status.state === "granted") {
  // Network access granted
}
```

### HTTP Server with Deno.serve

```typescript
// Simple HTTP server
Deno.serve({ port: 8000 }, (req) => {
  const url = new URL(req.url);

  if (url.pathname === "/api/users" && req.method === "GET") {
    return Response.json({ users: [] });
  }

  return new Response("Not Found", { status: 404 });
});
```

### Using Hono with Deno

```typescript
import { Hono } from "https://deno.land/x/hono/mod.ts";

const app = new Hono();

app.get("/", (c) => c.text("Hello Deno!"));
app.get("/api/users", (c) => c.json({ users: [] }));

Deno.serve(app.fetch);
```

### Using Fresh Framework

```typescript
// routes/index.tsx
import { PageProps } from "$fresh/server.ts";

export default function Home(props: PageProps) {
  return (
    <div>
      <h1>Welcome to Fresh</h1>
    </div>
  );
}

// routes/api/users.ts
import { Handlers } from "$fresh/server.ts";

export const handler: Handlers = {
  async GET(_req, _ctx) {
    const users = await getUsers();
    return Response.json(users);
  },
};
```

### Database Integration

```typescript
// Using Deno KV (built-in key-value store)
const kv = await Deno.openKv();

// Set a value
await kv.set(["users", "1"], { name: "John", email: "john@example.com" });

// Get a value
const result = await kv.get(["users", "1"]);
console.log(result.value);

// List values
const entries = kv.list({ prefix: ["users"] });
for await (const entry of entries) {
  console.log(entry.key, entry.value);
}
```

### Environment Variables

```typescript
// Access environment variables (requires --allow-env)
const apiKey = Deno.env.get("API_KEY");

// Using dotenv
import { load } from "https://deno.land/std/dotenv/mod.ts";
const env = await load();
```

### Testing with Built-in Test Runner

```typescript
// user_test.ts
import { assertEquals, assertRejects } from "https://deno.land/std/assert/mod.ts";
import { describe, it, beforeEach } from "https://deno.land/std/testing/bdd.ts";
import { getUser, createUser } from "./user_service.ts";

describe("User Service", () => {
  beforeEach(() => {
    // Setup
  });

  it("should create a user", async () => {
    const user = await createUser({ name: "John", email: "john@example.com" });
    assertEquals(user.name, "John");
  });

  it("should throw for invalid email", async () => {
    await assertRejects(
      () => createUser({ name: "John", email: "invalid" }),
      Error,
      "Invalid email"
    );
  });
});

// Run tests
// deno test --allow-net --allow-read
```

### Built-in Tooling

```bash
# Formatting
deno fmt

# Linting
deno lint

# Type checking
deno check main.ts

# Bundle
deno bundle main.ts bundle.js

# Compile to executable
deno compile --allow-net main.ts

# Documentation generation
deno doc main.ts

# Dependency inspection
deno info main.ts
```

### Configuration with deno.json

```json
{
  "tasks": {
    "dev": "deno run --watch --allow-net --allow-env main.ts",
    "start": "deno run --allow-net --allow-env main.ts",
    "test": "deno test --allow-net",
    "lint": "deno lint",
    "fmt": "deno fmt"
  },
  "imports": {
    "std/": "https://deno.land/std@0.208.0/",
    "@/": "./src/"
  },
  "compilerOptions": {
    "strict": true,
    "lib": ["deno.window"]
  },
  "lint": {
    "rules": {
      "tags": ["recommended"]
    }
  },
  "fmt": {
    "indentWidth": 2,
    "singleQuote": true
  }
}
```

### Error Handling

```typescript
class AppError extends Error {
  constructor(
    message: string,
    public statusCode: number = 500,
    public code: string = "INTERNAL_ERROR"
  ) {
    super(message);
    this.name = "AppError";
  }
}

const handleRequest = async (req: Request): Promise<Response> => {
  try {
    return await processRequest(req);
  } catch (error) {
    if (error instanceof AppError) {
      return Response.json(
        { error: error.message, code: error.code },
        { status: error.statusCode }
      );
    }
    console.error(error);
    return Response.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
};
```

### Web Standards

Deno embraces web standards. Use:

- `fetch()` for HTTP requests
- `Request` and `Response` objects
- `URL` and `URLSearchParams`
- `Web Crypto API` for cryptography
- `Streams API` for data streaming
- `FormData` for multipart data

### Performance

- Use web streams for large data processing
- Leverage Deno KV for fast key-value storage
- Use `Deno.serve` for high-performance HTTP
- Compile to standalone executables for deployment
