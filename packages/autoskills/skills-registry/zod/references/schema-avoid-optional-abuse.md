---
title: Avoid Overusing Optional Fields
impact: CRITICAL
impactDescription: Excessive optional fields create schemas that accept almost anything; forces null checks throughout codebase
tags: schema, optional, nullable, required
---

## Avoid Overusing Optional Fields

Making too many fields optional creates overly permissive schemas that validate almost any input. This pushes validation downstream into business logic, requiring defensive null checks everywhere instead of guaranteeing data shape at the boundary.

**Incorrect (optional abuse):**

```typescript
import { z } from 'zod'

// Every field optional - almost anything passes
const userSchema = z.object({
  id: z.string().optional(),
  name: z.string().optional(),
  email: z.string().optional(),
  role: z.string().optional(),
})

type User = z.infer<typeof userSchema>
// { id?: string; name?: string; email?: string; role?: string }

// Empty object passes validation!
userSchema.parse({})  // ✓ Valid: {}

function greetUser(user: User) {
  // Forced to add null checks everywhere
  if (user.name) {
    console.log(`Hello, ${user.name}`)
  } else {
    console.log('Hello, stranger')  // Shouldn't happen if data is clean
  }
}
```

**Correct (explicit required vs optional):**

```typescript
import { z } from 'zod'

// Required fields are required, optional fields are intentional
const userSchema = z.object({
  id: z.string().uuid(),  // Required
  name: z.string().min(1),  // Required, non-empty
  email: z.string().email(),  // Required
  role: z.enum(['admin', 'user', 'guest']),  // Required
  nickname: z.string().optional(),  // Intentionally optional
  bio: z.string().nullable(),  // Can be explicitly null
})

type User = z.infer<typeof userSchema>

// Empty object fails validation
userSchema.parse({})  // ✗ Throws ZodError

function greetUser(user: User) {
  // user.name is guaranteed to exist
  console.log(`Hello, ${user.name}`)

  // Only optional fields need checks
  if (user.nickname) {
    console.log(`Also known as: ${user.nickname}`)
  }
}
```

**Use `.partial()` for update schemas:**

```typescript
// Base schema with required fields
const userSchema = z.object({
  id: z.string().uuid(),
  name: z.string().min(1),
  email: z.string().email(),
})

// All fields optional for PATCH updates
const updateUserSchema = userSchema.partial()

// Only specific fields optional
const createUserSchema = userSchema.partial({ id: true })
```

**When NOT to use this pattern:**
- When modeling partial updates (PATCH endpoints)
- When fields genuinely may not exist (legacy data, external APIs)

Reference: [Zod API - optional](https://zod.dev/api#optional)
