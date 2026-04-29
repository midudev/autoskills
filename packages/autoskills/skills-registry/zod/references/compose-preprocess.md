---
title: Use preprocess() for Data Normalization
impact: MEDIUM
impactDescription: Validating before cleaning data causes false rejections; preprocess() normalizes input before schema validation runs
tags: compose, preprocess, normalize, cleaning
---

## Use preprocess() for Data Normalization

When incoming data needs normalization before validation (trimming whitespace, parsing JSON strings, converting formats), use `z.preprocess()`. This runs a function on the raw input before Zod's type checking, allowing you to clean data that would otherwise fail validation.

**Incorrect (validation fails on unnormalized data):**

```typescript
import { z } from 'zod'

const userSchema = z.object({
  name: z.string().min(1),
  email: z.string().email(),
  config: z.object({
    theme: z.string(),
  }),
})

// Raw form data
const formData = {
  name: '  John Doe  ',  // Has whitespace
  email: 'JOHN@EXAMPLE.COM',  // Uppercase
  config: '{"theme": "dark"}',  // JSON string, not object
}

userSchema.parse(formData)
// ZodError: Expected object, received string at "config"
```

**Correct (using preprocess):**

```typescript
import { z } from 'zod'

// Preprocess normalizes before validation
const trimmedString = z.preprocess(
  (val) => (typeof val === 'string' ? val.trim() : val),
  z.string()
)

const lowercaseEmail = z.preprocess(
  (val) => (typeof val === 'string' ? val.toLowerCase().trim() : val),
  z.string().email()
)

const jsonObject = z.preprocess(
  (val) => {
    if (typeof val === 'string') {
      try {
        return JSON.parse(val)
      } catch {
        return val  // Let Zod report the error
      }
    }
    return val
  },
  z.object({ theme: z.string() })
)

const userSchema = z.object({
  name: trimmedString.pipe(z.string().min(1)),
  email: lowercaseEmail,
  config: jsonObject,
})

const formData = {
  name: '  John Doe  ',
  email: 'JOHN@EXAMPLE.COM',
  config: '{"theme": "dark"}',
}

const user = userSchema.parse(formData)
// { name: 'John Doe', email: 'john@example.com', config: { theme: 'dark' } }
```

**Common preprocessing patterns:**

```typescript
// Trim all strings
const trimmedString = z.preprocess(
  (val) => (typeof val === 'string' ? val.trim() : val),
  z.string()
)

// Parse numeric strings
const numericString = z.preprocess(
  (val) => (typeof val === 'string' ? Number(val) : val),
  z.number()
)

// Parse boolean-like values
const booleanLike = z.preprocess(
  (val) => {
    if (val === 'true' || val === '1' || val === 1) return true
    if (val === 'false' || val === '0' || val === 0) return false
    return val
  },
  z.boolean()
)

// Parse date strings
const dateString = z.preprocess(
  (val) => (typeof val === 'string' ? new Date(val) : val),
  z.date()
)

// Split comma-separated strings into arrays
const csvArray = z.preprocess(
  (val) => (typeof val === 'string' ? val.split(',').map(s => s.trim()) : val),
  z.array(z.string())
)
```

**Preprocess vs Transform:**

```typescript
// preprocess() runs BEFORE type checking
// Use for: Normalizing input format before validation
z.preprocess(val => String(val).trim(), z.string().min(1))

// transform() runs AFTER type checking
// Use for: Converting validated data to different format
z.string().transform(s => s.toUpperCase())

// Order of operations:
// 1. preprocess receives raw unknown input
// 2. Zod validates the preprocessed value
// 3. transform converts the validated value
```

**When NOT to use this pattern:**
- When `.coerce` methods handle the conversion (simpler)
- When transformation should happen after validation (use transform)
- When normalization could hide validation errors

Reference: [Zod API - preprocess](https://zod.dev/api#preprocess)
