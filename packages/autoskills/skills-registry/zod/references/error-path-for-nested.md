---
title: Use issue.path for Nested Error Location
impact: HIGH
impactDescription: Without path information, users can't identify which nested field failed; path provides exact location in complex objects
tags: error, path, nested, debugging
---

## Use issue.path for Nested Error Location

When validating nested objects or arrays, `issue.path` tells you exactly where the error occurred. This is essential for highlighting the correct form field or providing precise error messages in complex data structures.

**Incorrect (ignoring path information):**

```typescript
import { z } from 'zod'

const orderSchema = z.object({
  customer: z.object({
    name: z.string().min(1, 'Name required'),
    address: z.object({
      street: z.string().min(1, 'Street required'),
      city: z.string().min(1, 'City required'),
    }),
  }),
  items: z.array(z.object({
    productId: z.string(),
    quantity: z.number().positive('Quantity must be positive'),
  })),
})

const result = orderSchema.safeParse({
  customer: { name: '', address: { street: '', city: '' } },
  items: [{ productId: 'abc', quantity: -1 }],
})

if (!result.success) {
  // Only showing message, not WHERE the error is
  result.error.issues.forEach(issue => {
    console.log(issue.message)  // 'Name required', 'Street required', 'Quantity must be positive'
    // User: "Which quantity? Which field?"
  })
}
```

**Correct (using path information):**

```typescript
import { z } from 'zod'

const orderSchema = z.object({
  customer: z.object({
    name: z.string().min(1, 'Name required'),
    address: z.object({
      street: z.string().min(1, 'Street required'),
      city: z.string().min(1, 'City required'),
    }),
  }),
  items: z.array(z.object({
    productId: z.string(),
    quantity: z.number().positive('Quantity must be positive'),
  })),
})

const result = orderSchema.safeParse({
  customer: { name: '', address: { street: '', city: '' } },
  items: [{ productId: 'abc', quantity: -1 }],
})

if (!result.success) {
  result.error.issues.forEach(issue => {
    // path is an array of keys/indices
    console.log(`${issue.path.join('.')}: ${issue.message}`)
    // 'customer.name: Name required'
    // 'customer.address.street: Street required'
    // 'customer.address.city: City required'
    // 'items.0.quantity: Quantity must be positive'
  })
}
```

**Building field-specific error mapping:**

```typescript
function mapErrorsToFields(error: z.ZodError) {
  const fieldErrors: Map<string, string[]> = new Map()

  for (const issue of error.issues) {
    const fieldPath = issue.path.join('.')
    const existing = fieldErrors.get(fieldPath) ?? []
    fieldErrors.set(fieldPath, [...existing, issue.message])
  }

  return fieldErrors
}

// Usage
const errors = mapErrorsToFields(result.error)
errors.get('customer.name')  // ['Name required']
errors.get('items.0.quantity')  // ['Quantity must be positive']
```

**For array items, get index from path:**

```typescript
const itemsWithErrors: Set<number> = new Set()

result.error.issues.forEach(issue => {
  if (issue.path[0] === 'items' && typeof issue.path[1] === 'number') {
    itemsWithErrors.add(issue.path[1])
  }
})

// Highlight items at indices: Set { 0 }
```

**Using path with format():**

```typescript
const formatted = result.error.format()

// Access errors at any path level
formatted.customer?.address?.city?._errors  // ['City required']
formatted.items?.[0]?.quantity?._errors  // ['Quantity must be positive']
```

**When NOT to use this pattern:**
- Flat objects where field name is obvious
- When using form libraries that handle path mapping

Reference: [Zod Error Handling](https://zod.dev/error-handling)
