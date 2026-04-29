---
title: Use Branded Types for Domain Safety
impact: HIGH
impactDescription: Plain string IDs are interchangeable, allowing userId where orderId is expected; branded types catch these bugs at compile time
tags: type, brand, domain, nominal
---

## Use Branded Types for Domain Safety

Plain strings and numbers are interchangeable in TypeScript's structural type system—a `userId` can be passed where an `orderId` is expected. Zod's `.brand()` creates nominal types that prevent mixing up semantically different values.

**Incorrect (plain IDs are interchangeable):**

```typescript
import { z } from 'zod'

const userIdSchema = z.string().uuid()
const orderIdSchema = z.string().uuid()

type UserId = z.infer<typeof userIdSchema>  // string
type OrderId = z.infer<typeof orderIdSchema>  // string - same type!

async function getOrder(orderId: OrderId) {
  return db.orders.findUnique({ where: { id: orderId } })
}

const userId: UserId = '550e8400-e29b-41d4-a716-446655440000'
getOrder(userId)  // No error! TypeScript allows this bug
// Runtime: queries orders table with user ID, returns nothing or wrong data
```

**Correct (using branded types):**

```typescript
import { z } from 'zod'

const userIdSchema = z.string().uuid().brand<'UserId'>()
const orderIdSchema = z.string().uuid().brand<'OrderId'>()

type UserId = z.infer<typeof userIdSchema>
// string & { __brand: 'UserId' }

type OrderId = z.infer<typeof orderIdSchema>
// string & { __brand: 'OrderId' }

async function getOrder(orderId: OrderId) {
  return db.orders.findUnique({ where: { id: orderId } })
}

const userId = userIdSchema.parse('550e8400-e29b-41d4-a716-446655440000')
getOrder(userId)  // TypeScript error: Argument of type 'UserId' is not assignable to parameter of type 'OrderId'

const orderId = orderIdSchema.parse('660e8400-e29b-41d4-a716-446655440001')
getOrder(orderId)  // Works correctly
```

**Common branded types:**

```typescript
// IDs for different entities
const UserId = z.string().uuid().brand<'UserId'>()
const ProductId = z.string().uuid().brand<'ProductId'>()
const OrderId = z.string().uuid().brand<'OrderId'>()

// Email (validated and branded)
const Email = z.string().email().brand<'Email'>()

// Positive numbers
const PositiveInt = z.number().int().positive().brand<'PositiveInt'>()

// Money amounts (in cents)
const Cents = z.number().int().nonnegative().brand<'Cents'>()

// Slugs
const Slug = z.string().regex(/^[a-z0-9-]+$/).brand<'Slug'>()
```

**Using with object schemas:**

```typescript
const User = z.object({
  id: z.string().uuid().brand<'UserId'>(),
  email: z.string().email().brand<'Email'>(),
  referredBy: z.string().uuid().brand<'UserId'>().optional(),
})

type User = z.infer<typeof User>

function sendReferralBonus(
  referrerId: z.infer<typeof User>['id'],
  refereeId: z.infer<typeof User>['id']
) {
  // Can't accidentally swap these - both are UserId but distinct values
}
```

**When NOT to use this pattern:**
- Simple applications without ID confusion risk
- When interoperating with external systems that expect plain strings
- Performance-critical paths (brand adds tiny overhead)

Reference: [Zod API - brand](https://zod.dev/api#brand)
