---
title: Choose strict() vs strip() for Unknown Keys
impact: MEDIUM-HIGH
impactDescription: Default passthrough mode leaks unexpected data; strict() catches schema mismatches, strip() silently removes extras
tags: object, strict, strip, passthrough
---

## Choose strict() vs strip() for Unknown Keys

By default, Zod objects use `.strip()` behavior, silently removing unrecognized keys. This can hide schema/data mismatches. Use `.strict()` to reject unknown keys (catching errors) or explicitly use `.strip()` to document the intention.

**Default behavior (strip - silent removal):**

```typescript
import { z } from 'zod'

const userSchema = z.object({
  id: z.string(),
  name: z.string(),
})

const input = {
  id: '123',
  name: 'John',
  role: 'admin',  // Extra field
  secretToken: 'abc123',  // Another extra field
}

const user = userSchema.parse(input)
// { id: '123', name: 'John' }
// Extra fields silently removed - was this intentional?
```

**Using strict() to catch schema mismatches:**

```typescript
import { z } from 'zod'

const userSchema = z.object({
  id: z.string(),
  name: z.string(),
}).strict()

const input = {
  id: '123',
  name: 'John',
  role: 'admin',
}

userSchema.parse(input)
// ZodError: Unrecognized key(s) in object: 'role'

// This catches:
// - Client sending fields the server doesn't expect
// - Schema out of sync with actual data structure
// - Typos in field names
```

**When to use each mode:**

```typescript
// strict() - Catch unexpected data (API contracts)
const apiRequestSchema = z.object({
  action: z.string(),
  payload: z.unknown(),
}).strict()  // Fail if client sends unknown fields

// strip() - Clean up data (explicit intention)
const dbInsertSchema = z.object({
  name: z.string(),
  email: z.string(),
}).strip()  // Explicitly remove metadata before insert

// passthrough() - Keep everything (pass-through proxy)
const proxySchema = z.object({
  id: z.string(),
}).passthrough()  // Keep fields we don't validate

const input = { id: '123', extra: 'data' }
proxySchema.parse(input)  // { id: '123', extra: 'data' }
```

**Choosing the right mode:**

| Mode | Behavior | Use When |
|------|----------|----------|
| `.strict()` | Reject unknown keys | API contracts, security-sensitive, debugging |
| `.strip()` (default) | Remove unknown keys | General validation, data cleaning |
| `.passthrough()` | Keep unknown keys | Proxying, partial validation |

**Handling specific unknown keys:**

```typescript
const schema = z.object({
  id: z.string(),
  name: z.string(),
}).catchall(z.unknown())  // Allow any additional fields of any type

// Or restrict additional fields to specific type
const metadataSchema = z.object({
  id: z.string(),
}).catchall(z.string())  // Only allow string extras
```

**When NOT to use this pattern:**
- `.strict()`: When forwarding data to another system that may add fields
- `.passthrough()`: When you need to ensure only known fields are stored

Reference: [Zod API - Objects](https://zod.dev/api#objects)
