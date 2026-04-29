---
title: Add Path to Refinement Errors
impact: MEDIUM
impactDescription: Errors without path show at object level; adding path highlights the specific field that failed
tags: refine, path, errors, forms
---

## Add Path to Refinement Errors

When using `.refine()` on object schemas for cross-field validation, add a `path` option to indicate which field the error relates to. Without it, the error appears at the object level, making form error display confusing.

**Incorrect (error at object level):**

```typescript
import { z } from 'zod'

const formSchema = z.object({
  password: z.string().min(8),
  confirmPassword: z.string(),
}).refine(
  (data) => data.password === data.confirmPassword,
  { message: 'Passwords do not match' }  // No path specified
)

const result = formSchema.safeParse({
  password: 'secret123',
  confirmPassword: 'different',
})

if (!result.success) {
  const flattened = result.error.flatten()
  // {
  //   formErrors: ['Passwords do not match'],  // At form level!
  //   fieldErrors: {}  // Empty - no field association
  // }
}

// Form UI can't highlight which field has the error
```

**Correct (error with path):**

```typescript
import { z } from 'zod'

const formSchema = z.object({
  password: z.string().min(8),
  confirmPassword: z.string(),
}).refine(
  (data) => data.password === data.confirmPassword,
  {
    message: 'Passwords do not match',
    path: ['confirmPassword'],  // Error appears on this field
  }
)

const result = formSchema.safeParse({
  password: 'secret123',
  confirmPassword: 'different',
})

if (!result.success) {
  const flattened = result.error.flatten()
  // {
  //   formErrors: [],
  //   fieldErrors: {
  //     confirmPassword: ['Passwords do not match']  // Associated with field
  //   }
  // }
}

// Form can now show error next to confirmPassword input
```

**Multiple cross-field validations:**

```typescript
const dateRangeSchema = z.object({
  startDate: z.coerce.date(),
  endDate: z.coerce.date(),
  minDays: z.number().optional(),
  maxDays: z.number().optional(),
}).refine(
  (data) => data.endDate >= data.startDate,
  { message: 'End date must be after start date', path: ['endDate'] }
).refine(
  (data) => {
    if (!data.minDays) return true
    const days = (data.endDate.getTime() - data.startDate.getTime()) / 86400000
    return days >= data.minDays
  },
  { message: 'Date range is too short', path: ['endDate'] }
).refine(
  (data) => {
    if (!data.maxDays) return true
    const days = (data.endDate.getTime() - data.startDate.getTime()) / 86400000
    return days <= data.maxDays
  },
  { message: 'Date range is too long', path: ['endDate'] }
)
```

**With superRefine for multiple path errors:**

```typescript
const orderSchema = z.object({
  billingAddress: z.object({
    street: z.string(),
    city: z.string(),
  }),
  shippingAddress: z.object({
    street: z.string(),
    city: z.string(),
  }),
  sameAsBilling: z.boolean(),
}).superRefine((data, ctx) => {
  if (data.sameAsBilling) {
    // If sameAsBilling but addresses differ, show errors on shipping
    if (data.shippingAddress.street !== data.billingAddress.street) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: 'Must match billing address',
        path: ['shippingAddress', 'street'],  // Nested path
      })
    }
    if (data.shippingAddress.city !== data.billingAddress.city) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: 'Must match billing address',
        path: ['shippingAddress', 'city'],
      })
    }
  }
})
```

**When NOT to use this pattern:**
- When the error genuinely applies to the whole object
- Simple single-field refinements (path is implicit)

Reference: [Zod API - refine](https://zod.dev/api#refine)
