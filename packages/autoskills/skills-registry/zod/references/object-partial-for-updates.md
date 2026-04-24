---
title: Use partial() for Update Schemas
impact: MEDIUM-HIGH
impactDescription: Creating separate update schemas duplicates definitions; partial() derives update schema from base, staying in sync
tags: object, partial, update, patch
---

## Use partial() for Update Schemas

When handling PATCH/PUT updates, you need a schema where all fields are optional. Instead of duplicating the schema with optional fields, use `.partial()` to derive it from your base schema. This keeps both schemas in sync automatically.

**Incorrect (duplicating schemas):**

```typescript
import { z } from 'zod'

// Base schema
const userSchema = z.object({
  name: z.string().min(1),
  email: z.string().email(),
  age: z.number().int().positive(),
  role: z.enum(['admin', 'user']),
})

// Manually duplicated for updates - will drift!
const updateUserSchema = z.object({
  name: z.string().min(1).optional(),
  email: z.string().email().optional(),
  age: z.number().int().positive().optional(),
  // Forgot to add role - schemas out of sync!
})

// Later, you add a field to userSchema but forget updateUserSchema
// Now updates silently ignore the new field
```

**Correct (using partial):**

```typescript
import { z } from 'zod'

// Base schema - single source of truth
const userSchema = z.object({
  name: z.string().min(1),
  email: z.string().email(),
  age: z.number().int().positive(),
  role: z.enum(['admin', 'user']),
})

// All fields optional for updates
const updateUserSchema = userSchema.partial()

type User = z.infer<typeof userSchema>
// { name: string; email: string; age: number; role: 'admin' | 'user' }

type UpdateUser = z.infer<typeof updateUserSchema>
// { name?: string; email?: string; age?: number; role?: 'admin' | 'user' }

// Validate partial updates
updateUserSchema.parse({ email: 'new@example.com' })  // Valid
updateUserSchema.parse({})  // Valid - all fields optional
```

**Partial specific fields only:**

```typescript
// Only name and email are optional for updates
const updateUserSchema = userSchema.partial({
  name: true,
  email: true,
})

type UpdateUser = z.infer<typeof updateUserSchema>
// { name?: string; email?: string; age: number; role: 'admin' | 'user' }
// age and role still required
```

**Deep partial for nested objects:**

```typescript
const addressSchema = z.object({
  street: z.string(),
  city: z.string(),
  country: z.string(),
})

const userSchema = z.object({
  name: z.string(),
  address: addressSchema,
})

// .partial() only makes top-level fields optional
const shallowPartial = userSchema.partial()
// { name?: string; address?: { street: string; city: string; country: string } }
// If address is provided, all its fields are still required!

// Use deepPartial for nested optionality
const deepPartialSchema = userSchema.deepPartial()
// { name?: string; address?: { street?: string; city?: string; country?: string } }
```

**Combining with required() for create vs update:**

```typescript
const baseSchema = z.object({
  id: z.string().uuid(),
  name: z.string(),
  email: z.string().email(),
  createdAt: z.date(),
})

// Create: id and createdAt are generated, rest required
const createSchema = baseSchema.omit({ id: true, createdAt: true })

// Update: all user-editable fields optional
const updateSchema = baseSchema.partial().omit({ id: true, createdAt: true })
```

**When NOT to use this pattern:**
- When update logic differs significantly from create (different validations)
- When using GraphQL with explicit input types

Reference: [Zod API - partial](https://zod.dev/api#partial)
