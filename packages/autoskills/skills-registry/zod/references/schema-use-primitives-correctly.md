---
title: Use Primitive Schemas Correctly
impact: CRITICAL
impactDescription: Incorrect primitive selection causes validation to pass on wrong types; using z.any() or z.unknown() loses all type safety
tags: schema, primitives, types, basics
---

## Use Primitive Schemas Correctly

Zod provides specific schemas for each primitive type. Using the wrong schema (e.g., `z.string()` when you need `z.number()`) or falling back to `z.any()` defeats the purpose of validation entirely, allowing corrupt data through.

**Incorrect (wrong primitive or any):**

```typescript
import { z } from 'zod'

// Using any loses all type safety
const userSchema = z.object({
  id: z.any(),  // Accepts anything - no validation
  age: z.string(),  // Wrong type - age should be number
  active: z.any(),  // Should be boolean
})

// This passes validation but data is wrong
userSchema.parse({ id: null, age: "twenty", active: "yes" })
// Result: { id: null, age: "twenty", active: "yes" }
```

**Correct (specific primitives):**

```typescript
import { z } from 'zod'

const userSchema = z.object({
  id: z.string().uuid(),  // Specific format validation
  age: z.number().int().positive(),  // Correct type with constraints
  active: z.boolean(),  // Exact boolean type
})

// Now invalid data is rejected
userSchema.parse({ id: null, age: "twenty", active: "yes" })
// Throws ZodError with specific field errors
```

**Available primitive schemas:**
- `z.string()` - strings with optional regex, min, max, email, url, uuid
- `z.number()` - numbers with optional int, positive, negative, min, max
- `z.bigint()` - BigInt values
- `z.boolean()` - true/false only
- `z.date()` - Date objects
- `z.symbol()` - Symbol type
- `z.undefined()` - undefined only
- `z.null()` - null only
- `z.void()` - undefined (for function returns)
- `z.never()` - no valid value

**When NOT to use this pattern:**
- When you genuinely need to accept any value (rare - consider `z.unknown()` instead)
- When migrating legacy code incrementally (use `z.any()` temporarily, then fix)

Reference: [Zod Primitives](https://zod.dev/api#primitives)
