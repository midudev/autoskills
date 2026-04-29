---
title: Distinguish transform() from refine() and coerce()
impact: MEDIUM
impactDescription: Using wrong method causes validation to pass with wrong data; each method has distinct purpose
tags: refine, transform, coerce, conversion
---

## Distinguish transform() from refine() and coerce()

`.refine()` validates and returns boolean, `.transform()` converts data to new format, and `.coerce` converts input before validation. Using the wrong one causes bugs where validation passes but data is wrong.

**Purpose of each method:**

```typescript
import { z } from 'zod'

// coerce: Convert type BEFORE validation
// Input: unknown -> Output: validated type
z.coerce.number().parse('42')  // Converts "42" to 42, then validates as number

// refine: Validate with custom logic, return boolean
// Input: T -> Output: T (unchanged, but validated)
z.number().refine((n) => n > 0)  // Validates n > 0, returns n unchanged

// transform: Convert to different type AFTER validation
// Input: T -> Output: U (different type)
z.string().transform((s) => s.length)  // Validates string, returns length
```

**Incorrect (using transform for validation):**

```typescript
// Wrong: transform should convert, not validate
const schema = z.number().transform((n) => {
  if (n < 0) throw new Error('Must be positive')  // Don't throw in transform
  return n
})
```

**Correct (using appropriate method):**

```typescript
import { z } from 'zod'

// VALIDATION: Use refine - returns boolean, data unchanged
const positiveNumber = z.number().refine(
  (n) => n > 0,
  { message: 'Must be positive' }
)

positiveNumber.parse(5)  // 5
positiveNumber.parse(-1)  // ZodError: Must be positive

// CONVERSION: Use transform - returns new value
const stringLength = z.string().transform((s) => s.length)

type StringLength = z.infer<typeof stringLength>  // number
stringLength.parse('hello')  // 5

// COERCION: Use coerce - converts input type
const coercedNumber = z.coerce.number()

coercedNumber.parse('42')  // 42 (from string)
coercedNumber.parse(42)  // 42 (already number)
```

**Combining methods correctly:**

```typescript
// Input: string -> Coerce to number -> Validate positive -> Transform to dollars
const priceSchema = z.coerce
  .number()
  .refine((n) => n >= 0, 'Price cannot be negative')
  .transform((cents) => `$${(cents / 100).toFixed(2)}`)

priceSchema.parse('1999')  // "$19.99"
priceSchema.parse('-100')  // ZodError: Price cannot be negative
```

**Order of operations:**

```typescript
const schema = z
  .preprocess(val => val, z.string())  // 1. preprocess (before type check)
  .transform(s => s.trim())             // 2. transform (after type check)
  .refine(s => s.length > 0)            // 3. refine (custom validation)
  .transform(s => s.toUpperCase())      // 4. another transform

// Input flows: preprocess -> type check -> transforms/refines in order
```

**Use case comparison:**

| Need | Method | Example |
|------|--------|---------|
| Convert string to number | `z.coerce.number()` | Form input |
| Validate number is positive | `.refine(n => n > 0)` | Business rule |
| Convert cents to dollars | `.transform(n => n/100)` | Display format |
| Trim whitespace before check | `z.preprocess` | Input cleanup |

**When NOT to use this pattern:**
- Simple type coercion: use `z.coerce.*`
- Simple validation: use built-in methods like `.min()`, `.email()`

Reference: [Zod API - transform](https://zod.dev/api#transform)
