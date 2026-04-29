---
title: Use Coercion for Form and Query Data
impact: CRITICAL
impactDescription: Form data and query params are always strings; without coercion, z.number() rejects "42" and z.boolean() rejects "true"
tags: schema, coerce, forms, query-params
---

## Use Coercion for Form and Query Data

HTML forms and URL query parameters always transmit data as strings. Using `z.number()` on form data will fail because `"42"` is not a number. Use `z.coerce.number()` to automatically convert strings to the correct type.

**Incorrect (no coercion for form data):**

```typescript
import { z } from 'zod'

const searchSchema = z.object({
  query: z.string(),
  page: z.number(),  // Expects actual number
  limit: z.number(),
  showDeleted: z.boolean(),  // Expects actual boolean
})

// Form data / query params are strings
const formData = new URLSearchParams('query=test&page=1&limit=10&showDeleted=true')
const params = Object.fromEntries(formData)
// { query: 'test', page: '1', limit: '10', showDeleted: 'true' }

searchSchema.parse(params)
// ZodError: Expected number, received string at "page"
// ZodError: Expected number, received string at "limit"
// ZodError: Expected boolean, received string at "showDeleted"
```

**Correct (using coercion):**

```typescript
import { z } from 'zod'

const searchSchema = z.object({
  query: z.string(),
  page: z.coerce.number().int().positive().default(1),
  limit: z.coerce.number().int().min(1).max(100).default(10),
  showDeleted: z.coerce.boolean().default(false),
})

// Form data / query params are strings
const formData = new URLSearchParams('query=test&page=1&limit=10&showDeleted=true')
const params = Object.fromEntries(formData)

const result = searchSchema.parse(params)
// { query: 'test', page: 1, limit: 10, showDeleted: true }
// Types are correct: number, number, boolean
```

**Available coercion types:**

```typescript
z.coerce.string()  // Converts anything to string via String(value)
z.coerce.number()  // Converts via Number(value), NaN fails validation
z.coerce.boolean()  // Truthy/falsy conversion
z.coerce.bigint()  // Converts via BigInt(value)
z.coerce.date()  // Converts via new Date(value)
```

**Coercion edge cases:**

```typescript
// z.coerce.number() behavior
z.coerce.number().parse("42")  // 42
z.coerce.number().parse("")  // 0 (empty string becomes 0!)
z.coerce.number().parse("abc")  // ZodError (NaN fails)

// z.coerce.boolean() behavior
z.coerce.boolean().parse("true")  // true
z.coerce.boolean().parse("false")  // true! (non-empty string is truthy)
z.coerce.boolean().parse("")  // false
z.coerce.boolean().parse("0")  // true! (non-empty string)

// For strict boolean parsing from strings:
const strictBooleanSchema = z.enum(['true', 'false']).transform(v => v === 'true')
```

**When NOT to use this pattern:**
- When receiving JSON payloads (already typed correctly)
- When you want strict type checking without conversion

Reference: [Zod API - Coercion](https://zod.dev/api#coercion)
