---
title: Use Enums for Fixed String Values
impact: CRITICAL
impactDescription: Plain strings accept any value including typos; enums restrict to valid values and enable autocomplete
tags: schema, enum, literal, union
---

## Use Enums for Fixed String Values

When a field should only accept specific values (status, role, type), use `z.enum()` or `z.literal()` instead of `z.string()`. Plain strings accept any value including typos, while enums provide validation, type safety, and IDE autocomplete.

**Incorrect (plain string for fixed values):**

```typescript
import { z } from 'zod'

const orderSchema = z.object({
  id: z.string(),
  status: z.string(),  // Accepts any string
  priority: z.string(),  // No constraints
})

type Order = z.infer<typeof orderSchema>
// { id: string; status: string; priority: string }

// Typos and invalid values pass validation
orderSchema.parse({
  id: '123',
  status: 'pendng',  // Typo passes
  priority: 'super-urgent',  // Invalid value passes
})

function processOrder(order: Order) {
  if (order.status === 'pending') {  // Might never match due to typos
    // ...
  }
}
```

**Correct (using z.enum):**

```typescript
import { z } from 'zod'

const OrderStatus = z.enum(['pending', 'processing', 'shipped', 'delivered'])
const Priority = z.enum(['low', 'medium', 'high'])

const orderSchema = z.object({
  id: z.string(),
  status: OrderStatus,
  priority: Priority,
})

type Order = z.infer<typeof orderSchema>
// { id: string; status: 'pending' | 'processing' | 'shipped' | 'delivered'; priority: 'low' | 'medium' | 'high' }

// Typos are caught at validation
orderSchema.parse({
  id: '123',
  status: 'pendng',  // ZodError: Invalid enum value
  priority: 'super-urgent',  // ZodError: Invalid enum value
})

// Extract enum values for reuse
OrderStatus.options  // ['pending', 'processing', 'shipped', 'delivered']
type OrderStatusType = z.infer<typeof OrderStatus>  // 'pending' | 'processing' | ...
```

**For native TypeScript enums:**

```typescript
enum Role {
  Admin = 'admin',
  User = 'user',
  Guest = 'guest',
}

// Use z.nativeEnum for TS enums
const userSchema = z.object({
  role: z.nativeEnum(Role),
})
```

**For single literal values (discriminated unions):**

```typescript
const successResponse = z.object({
  status: z.literal('success'),
  data: z.unknown(),
})

const errorResponse = z.object({
  status: z.literal('error'),
  message: z.string(),
})

const response = z.discriminatedUnion('status', [
  successResponse,
  errorResponse,
])
```

**When NOT to use this pattern:**
- When the set of valid values is dynamic or user-defined
- When values come from a database that may have more options

Reference: [Zod API - Enums](https://zod.dev/api#enums)
