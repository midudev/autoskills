---
title: Use pick() and omit() for Schema Variants
impact: MEDIUM-HIGH
impactDescription: Copying fields between schemas creates duplication; pick/omit derive variants that stay in sync with base schema
tags: object, pick, omit, variants
---

## Use pick() and omit() for Schema Variants

When you need different views of the same data (public vs private, create vs response), use `.pick()` and `.omit()` instead of duplicating fields. This ensures derived schemas stay in sync with the base schema.

**Incorrect (duplicating for variants):**

```typescript
import { z } from 'zod'

// Full user schema
const userSchema = z.object({
  id: z.string().uuid(),
  email: z.string().email(),
  passwordHash: z.string(),
  name: z.string(),
  createdAt: z.date(),
  isAdmin: z.boolean(),
})

// Public view - manually duplicated
const publicUserSchema = z.object({
  id: z.string().uuid(),
  name: z.string(),
  // Forgot email - now users can't see it
  // Added avatar field - doesn't exist in base schema
  avatar: z.string().optional(),
})

// Create input - manually duplicated
const createUserSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),  // Different from passwordHash
  name: z.string(),
  // Missing isAdmin - can't set on create? Intentional?
})
```

**Correct (using pick and omit):**

```typescript
import { z } from 'zod'

// Full user schema - single source of truth
const userSchema = z.object({
  id: z.string().uuid(),
  email: z.string().email(),
  passwordHash: z.string(),
  name: z.string(),
  createdAt: z.date(),
  isAdmin: z.boolean(),
})

// Public view - explicitly pick public fields
const publicUserSchema = userSchema.pick({
  id: true,
  email: true,
  name: true,
})

type PublicUser = z.infer<typeof publicUserSchema>
// { id: string; email: string; name: string }

// API response - omit sensitive fields
const userResponseSchema = userSchema.omit({
  passwordHash: true,
})

type UserResponse = z.infer<typeof userResponseSchema>
// { id: string; email: string; name: string; createdAt: Date; isAdmin: boolean }

// Create input - omit generated fields
const createUserInputSchema = userSchema
  .omit({ id: true, createdAt: true, passwordHash: true })
  .extend({
    password: z.string().min(8),  // Add password (different from hash)
  })

type CreateUserInput = z.infer<typeof createUserInputSchema>
// { email: string; name: string; isAdmin: boolean; password: string }
```

**Common patterns:**

```typescript
// Database row → API response (hide internal fields)
const dbRowSchema = z.object({
  id: z.number(),
  public_id: z.string().uuid(),
  email: z.string(),
  password_hash: z.string(),
  internal_notes: z.string(),
  created_at: z.date(),
})

const apiResponseSchema = dbRowSchema.omit({
  id: true,  // Internal DB id
  password_hash: true,  // Sensitive
  internal_notes: true,  // Staff only
})

// Form data → Database insert (add generated fields)
const formSchema = z.object({
  title: z.string(),
  content: z.string(),
})

const dbInsertSchema = formSchema.extend({
  id: z.string().uuid(),
  authorId: z.string().uuid(),
  createdAt: z.date(),
  updatedAt: z.date(),
})
```

**Chaining operations:**

```typescript
const baseSchema = z.object({
  id: z.string(),
  name: z.string(),
  email: z.string(),
  role: z.enum(['admin', 'user']),
  secret: z.string(),
})

// Combine pick, omit, partial, extend
const updateSchema = baseSchema
  .omit({ id: true, secret: true })  // Remove immutable/sensitive
  .partial()  // Make all optional for updates
  .extend({
    updatedAt: z.date().optional(),  // Add update timestamp
  })
```

**When NOT to use this pattern:**
- When derived schemas need different validation rules (not just different fields)
- When the relationship between schemas is not subset/superset

Reference: [Zod API - pick/omit](https://zod.dev/api#pickomit)
