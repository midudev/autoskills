---
title: Never Trust JSON.parse Output
impact: CRITICAL
impactDescription: JSON.parse returns any type; unvalidated JSON allows type confusion attacks and runtime crashes
tags: parse, json, security, type-safety
---

## Never Trust JSON.parse Output

`JSON.parse()` returns `any` (or `unknown` in strict mode), providing no type guarantees. Always validate JSON output with Zod before using it, even if you control the JSON source. This catches corruption, version mismatches, and ensures type safety.

**Incorrect (trusting JSON.parse):**

```typescript
// JSON.parse returns any - no type safety
const config = JSON.parse(fs.readFileSync('config.json', 'utf-8'))
// config is 'any' - TypeScript allows anything

// This might crash at runtime if structure changed
console.log(config.database.host)  // TypeError: Cannot read property 'host' of undefined

// API response - also unvalidated
const response = await fetch('/api/user')
const user = await response.json()  // any type
console.log(user.name.toUpperCase())  // Crash if name is null/undefined
```

**Correct (validate after JSON.parse):**

```typescript
import { z } from 'zod'

const configSchema = z.object({
  database: z.object({
    host: z.string(),
    port: z.number(),
    name: z.string(),
  }),
  api: z.object({
    key: z.string(),
    timeout: z.number().default(5000),
  }),
})

// Parse JSON then validate
const rawConfig = JSON.parse(fs.readFileSync('config.json', 'utf-8'))
const config = configSchema.parse(rawConfig)
// config is fully typed: { database: { host: string, ... }, ... }

// API response validation
const userSchema = z.object({
  id: z.string(),
  name: z.string(),
  email: z.string().email(),
})

const response = await fetch('/api/user')
const rawUser = await response.json()
const user = userSchema.parse(rawUser)
// user is fully typed and validated
```

**Helper for validated JSON parsing:**

```typescript
function parseJSON<T>(schema: z.ZodType<T>, json: string): T {
  return schema.parse(JSON.parse(json))
}

function safeParseJSON<T>(schema: z.ZodType<T>, json: string) {
  try {
    return { success: true as const, data: schema.parse(JSON.parse(json)) }
  } catch (error) {
    if (error instanceof SyntaxError) {
      return { success: false as const, error: 'Invalid JSON' }
    }
    if (error instanceof z.ZodError) {
      return { success: false as const, error: error.issues }
    }
    throw error
  }
}

// Usage
const config = parseJSON(configSchema, fs.readFileSync('config.json', 'utf-8'))
```

**Validate localStorage/sessionStorage:**

```typescript
const cartSchema = z.array(z.object({
  productId: z.string(),
  quantity: z.number().int().positive(),
}))

function getCart() {
  const raw = localStorage.getItem('cart')
  if (!raw) return []

  const result = cartSchema.safeParse(JSON.parse(raw))
  if (!result.success) {
    // Corrupted cart data - clear it
    localStorage.removeItem('cart')
    return []
  }
  return result.data
}
```

**When NOT to use this pattern:**
- When you genuinely need to pass through arbitrary JSON without processing

Reference: [Zod API - parse](https://zod.dev/api#parse)
