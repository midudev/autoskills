---
title: Choose refine() vs superRefine() Correctly
impact: MEDIUM
impactDescription: refine() only reports one error; superRefine() enables multiple issues and custom error codes
tags: refine, superRefine, validation, custom
---

## Choose refine() vs superRefine() Correctly

`.refine()` is for simple single-condition validation returning boolean. `.superRefine()` gives you a context object to add multiple issues with custom error codes and paths. Choose based on your error reporting needs.

**Incorrect (using refine for multiple checks):**

```typescript
import { z } from 'zod'

// refine can only report one error at a time
const passwordSchema = z.string().refine(
  (password) => {
    // Checks all conditions but only reports first failure
    if (password.length < 8) return false  // Only this error shown
    if (!/[A-Z]/.test(password)) return false
    if (!/[0-9]/.test(password)) return false
    return true
  },
  { message: 'Password does not meet requirements' }
)

passwordSchema.parse('weak')
// Only shows: "Password does not meet requirements"
// User doesn't know WHICH requirements failed
```

**Correct (using superRefine for multiple issues):**

```typescript
import { z } from 'zod'

const passwordSchema = z.string().superRefine((password, ctx) => {
  if (password.length < 8) {
    ctx.addIssue({
      code: z.ZodIssueCode.custom,
      message: 'Password must be at least 8 characters',
    })
  }

  if (!/[A-Z]/.test(password)) {
    ctx.addIssue({
      code: z.ZodIssueCode.custom,
      message: 'Password must contain an uppercase letter',
    })
  }

  if (!/[0-9]/.test(password)) {
    ctx.addIssue({
      code: z.ZodIssueCode.custom,
      message: 'Password must contain a number',
    })
  }

  if (!/[!@#$%^&*]/.test(password)) {
    ctx.addIssue({
      code: z.ZodIssueCode.custom,
      message: 'Password must contain a special character',
    })
  }
})

passwordSchema.safeParse('weak')
// Shows ALL failures:
// - "Password must be at least 8 characters"
// - "Password must contain an uppercase letter"
// - "Password must contain a number"
// - "Password must contain a special character"
```

**When to use refine():**

```typescript
// Simple boolean condition with one error message
const adultSchema = z.number().refine(
  (age) => age >= 18,
  { message: 'Must be 18 or older' }
)

// Cross-field validation with single outcome
const formSchema = z.object({
  password: z.string(),
  confirmPassword: z.string(),
}).refine(
  (data) => data.password === data.confirmPassword,
  { message: 'Passwords must match', path: ['confirmPassword'] }
)

// Async validation
const emailSchema = z.string().email().refine(
  async (email) => {
    const exists = await checkEmailExists(email)
    return !exists
  },
  { message: 'Email already registered' }
)
```

**When to use superRefine():**

```typescript
// Multiple independent checks on same value
// Cross-field validation with multiple possible errors
// Need custom error codes for i18n or client handling
// Need to add issues at specific paths

const orderSchema = z.object({
  items: z.array(z.object({
    productId: z.string(),
    quantity: z.number(),
  })),
  promoCode: z.string().optional(),
}).superRefine(async (order, ctx) => {
  // Check each item's availability
  for (let i = 0; i < order.items.length; i++) {
    const item = order.items[i]
    const available = await checkInventory(item.productId, item.quantity)

    if (!available) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        path: ['items', i, 'quantity'],  // Specific path
        message: `Only ${available} units available`,
      })
    }
  }

  // Validate promo code
  if (order.promoCode) {
    const valid = await validatePromoCode(order.promoCode)
    if (!valid) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        path: ['promoCode'],
        message: 'Invalid or expired promo code',
      })
    }
  }
})
```

**When NOT to use this pattern:**
- Simple single-condition checks (use refine for simplicity)
- Transform needed instead of validation (use transform)

Reference: [Zod API - refine/superRefine](https://zod.dev/api#refine)
