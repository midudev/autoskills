---
title: Use extend() for Adding Fields
impact: MEDIUM-HIGH
impactDescription: Merging objects manually loses type information; extend() preserves types and allows overriding fields safely
tags: object, extend, composition, inheritance
---

## Use extend() for Adding Fields

When building on existing schemas, use `.extend()` to add new fields rather than manually spreading. Extend preserves type information, allows overriding existing fields, and keeps the schema relationship explicit.

**Incorrect (manual object spreading):**

```typescript
import { z } from 'zod'

const baseUserSchema = z.object({
  id: z.string(),
  name: z.string(),
})

// Manual spreading loses Zod's schema relationship
const adminUserSchema = z.object({
  ...baseUserSchema.shape,  // Accessing internal .shape
  role: z.literal('admin'),
  permissions: z.array(z.string()),
})

// Problems:
// 1. If baseUserSchema changes, TypeScript might not catch issues
// 2. Can't override fields easily
// 3. Loses schema methods and metadata
```

**Correct (using extend):**

```typescript
import { z } from 'zod'

const baseUserSchema = z.object({
  id: z.string(),
  name: z.string(),
  email: z.string().email(),
})

// Extend to add fields
const adminUserSchema = baseUserSchema.extend({
  role: z.literal('admin'),
  permissions: z.array(z.string()),
})

type AdminUser = z.infer<typeof adminUserSchema>
// {
//   id: string;
//   name: string;
//   email: string;
//   role: 'admin';
//   permissions: string[];
// }

// Override existing fields
const strictEmailSchema = baseUserSchema.extend({
  email: z.string().email().endsWith('@company.com'),  // Stricter validation
})
```

**Building hierarchies with extend:**

```typescript
// Base entity with common fields
const entitySchema = z.object({
  id: z.string().uuid(),
  createdAt: z.date(),
  updatedAt: z.date(),
})

// User extends entity
const userSchema = entitySchema.extend({
  email: z.string().email(),
  name: z.string(),
})

// Product extends entity
const productSchema = entitySchema.extend({
  name: z.string(),
  price: z.number().positive(),
  sku: z.string(),
})

// Order extends entity with references
const orderSchema = entitySchema.extend({
  userId: z.string().uuid(),
  items: z.array(z.object({
    productId: z.string().uuid(),
    quantity: z.number().int().positive(),
  })),
  total: z.number().positive(),
})
```

**Combining extend with other methods:**

```typescript
const baseSchema = z.object({
  id: z.string(),
  name: z.string(),
  email: z.string(),
})

// Create input: no id, add password
const createSchema = baseSchema
  .omit({ id: true })
  .extend({
    password: z.string().min(8),
  })

// Update input: all optional except id
const updateSchema = baseSchema
  .partial()
  .extend({
    id: z.string(),  // Override to make required
  })
```

**Merge for combining independent schemas:**

```typescript
const addressSchema = z.object({
  street: z.string(),
  city: z.string(),
})

const contactSchema = z.object({
  email: z.string().email(),
  phone: z.string(),
})

// Merge combines two schemas (both required)
const customerSchema = addressSchema.merge(contactSchema)
// { street: string; city: string; email: string; phone: string }
```

**When NOT to use this pattern:**
- When schemas are genuinely independent (use merge or intersection)
- When you need to remove fields (use omit)

Reference: [Zod API - extend](https://zod.dev/api#extend)
