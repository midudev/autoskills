---
title: Extract Shared Schemas into Reusable Modules
impact: MEDIUM
impactDescription: Duplicating schemas across files leads to inconsistency; shared schemas ensure single source of truth
tags: compose, reuse, modules, organization
---

## Extract Shared Schemas into Reusable Modules

When the same schema pattern appears in multiple places, extract it into a shared module. This ensures consistency, reduces duplication, and makes changes propagate automatically across your codebase.

**Incorrect (duplicating schemas):**

```typescript
// api/users.ts
import { z } from 'zod'

const userSchema = z.object({
  id: z.string().uuid(),
  email: z.string().email(),
  name: z.string().min(1),
  createdAt: z.date(),
})

// api/orders.ts
import { z } from 'zod'

const orderSchema = z.object({
  id: z.string().uuid(),  // Duplicated
  userId: z.string().uuid(),  // Same pattern
  items: z.array(z.object({
    productId: z.string().uuid(),  // Duplicated
    quantity: z.number().int().positive(),
  })),
  createdAt: z.date(),  // Duplicated
})

// api/comments.ts
import { z } from 'zod'

const commentSchema = z.object({
  id: z.string().uuid(),  // Same duplication
  userId: z.string().uuid(),
  content: z.string().min(1),
  createdAt: z.date(),  // Inconsistency risk
})
```

**Correct (shared schema modules):**

```typescript
// schemas/common.ts
import { z } from 'zod'

// Reusable ID types
export const uuid = z.string().uuid()
export type UUID = z.infer<typeof uuid>

// Timestamps
export const timestamps = z.object({
  createdAt: z.date(),
  updatedAt: z.date(),
})

// Base entity with ID
export const baseEntity = z.object({
  id: uuid,
}).merge(timestamps)

export type BaseEntity = z.infer<typeof baseEntity>

// Pagination
export const paginationParams = z.object({
  page: z.coerce.number().int().positive().default(1),
  limit: z.coerce.number().int().min(1).max(100).default(20),
})
```

```typescript
// schemas/user.ts
import { z } from 'zod'
import { baseEntity, uuid } from './common'

export const userSchema = baseEntity.extend({
  email: z.string().email(),
  name: z.string().min(1),
})

export type User = z.infer<typeof userSchema>
```

```typescript
// schemas/order.ts
import { z } from 'zod'
import { baseEntity, uuid } from './common'

const orderItemSchema = z.object({
  productId: uuid,
  quantity: z.number().int().positive(),
})

export const orderSchema = baseEntity.extend({
  userId: uuid,
  items: z.array(orderItemSchema).min(1),
  total: z.number().positive(),
})

export type Order = z.infer<typeof orderSchema>
```

**Organizing schema modules:**

```
schemas/
├── common.ts       # Shared primitives and base schemas
├── user.ts         # User-related schemas
├── order.ts        # Order-related schemas
├── product.ts      # Product-related schemas
└── index.ts        # Re-exports for convenience
```

```typescript
// schemas/index.ts
export * from './common'
export * from './user'
export * from './order'
export * from './product'

// Usage
import { userSchema, orderSchema, uuid, type User } from '@/schemas'
```

**When NOT to use this pattern:**
- One-off schemas used only in a single file
- When schemas look similar but have different semantics (don't over-abstract)

Reference: [Zod - Type Inference](https://zod.dev/api#type-inference)
