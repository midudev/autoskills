---
title: Use catch() for Fault-Tolerant Parsing
impact: MEDIUM
impactDescription: parse() fails on first invalid field; catch() provides fallback values, enabling partial success with degraded data
tags: refine, catch, fallback, resilience
---

## Use catch() for Fault-Tolerant Parsing

When parsing data that might have some invalid fields but you want to accept what's valid, use `.catch()` to provide fallback values instead of failing entirely. This enables graceful degradation for partially corrupted data.

**Incorrect (all-or-nothing parsing):**

```typescript
import { z } from 'zod'

const userPrefsSchema = z.object({
  theme: z.enum(['light', 'dark']),
  fontSize: z.number().min(8).max(32),
  language: z.string(),
  notifications: z.boolean(),
})

// Corrupted localStorage data
const stored = {
  theme: 'invalid-theme',  // Bad
  fontSize: 200,  // Bad
  language: 'en',  // Good
  notifications: 'yes',  // Bad - should be boolean
}

userPrefsSchema.parse(stored)
// ZodError: Invalid enum value at "theme"
// User loses ALL their preferences because one field is bad
```

**Correct (fault-tolerant with catch):**

```typescript
import { z } from 'zod'

const userPrefsSchema = z.object({
  theme: z.enum(['light', 'dark']).catch('light'),
  fontSize: z.number().min(8).max(32).catch(16),
  language: z.string().catch('en'),
  notifications: z.boolean().catch(true),
})

// Corrupted data
const stored = {
  theme: 'invalid-theme',
  fontSize: 200,
  language: 'en',
  notifications: 'yes',
}

const prefs = userPrefsSchema.parse(stored)
// {
//   theme: 'light',      // Fallback used
//   fontSize: 16,        // Fallback used
//   language: 'en',      // Original value preserved
//   notifications: true  // Fallback used
// }
// User gets mostly working preferences instead of error
```

**Catch with factory function:**

```typescript
// Factory function receives the caught error
const schema = z.object({
  data: z.array(z.number()).catch((ctx) => {
    console.warn('Invalid data array:', ctx.error)
    return []  // Return empty array as fallback
  }),
})
```

**Use case: API response resilience:**

```typescript
const productSchema = z.object({
  id: z.string(),
  name: z.string(),
  price: z.number().positive(),
  // Legacy field that might be missing or wrong format
  legacyCode: z.string().catch('UNKNOWN'),
  // External data that might be malformed
  metadata: z.record(z.string()).catch({}),
})

// API returns partial data
const apiResponse = {
  id: 'prod-123',
  name: 'Widget',
  price: 29.99,
  legacyCode: null,  // Bad - should be string
  metadata: 'invalid',  // Bad - should be object
}

const product = productSchema.parse(apiResponse)
// Works! Returns product with fallbacks for bad fields
```

**Difference between catch() and default():**

```typescript
// .default() - only fills in undefined
z.string().default('fallback')
// undefined -> 'fallback'
// null -> ZodError
// '' -> '' (empty string is valid)

// .catch() - fallback for ANY parse failure
z.string().catch('fallback')
// undefined -> 'fallback'
// null -> 'fallback'
// 123 -> 'fallback'
// Even valid strings pass through unchanged
```

**Combining catch with validation:**

```typescript
// Catch only specific validation failures
const schema = z.string()
  .email()
  .catch('invalid@example.com')  // Fallback if not valid email

// Chain for complex defaults
const ageSchema = z.coerce.number()
  .int()
  .min(0)
  .max(120)
  .catch(0)  // Invalid ages become 0
```

**When NOT to use this pattern:**
- When invalid data should cause errors (strict validation)
- When you need to know which fields failed (use safeParse)
- Critical fields that must be valid

Reference: [Zod API - catch](https://zod.dev/api#catch)
