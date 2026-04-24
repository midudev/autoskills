---
title: Use Zod Mini for Bundle-Sensitive Applications
impact: LOW-MEDIUM
impactDescription: Full Zod is ~17kb gzipped; Zod Mini is ~1.9kb - 85% smaller for frontend-critical bundles
tags: perf, bundle, mini, tree-shaking
---

## Use Zod Mini for Bundle-Sensitive Applications

For frontend applications where bundle size is critical, use `@zod/mini` instead of `zod`. Zod Mini provides the same validation capabilities with a functional API that tree-shakes better, reducing bundle size by ~85%.

**When to consider Zod Mini:**

```typescript
// Your app if:
// - Bundle size is critical (mobile-first, slow networks)
// - Edge functions with size limits
// - Simple validation needs (no complex transforms)
// - Tree-shaking is important

// Zod: ~17kb gzipped
import { z } from 'zod'

// Zod Mini: ~1.9kb gzipped (when tree-shaken)
import * as z from '@zod/mini'
```

**Standard Zod (method chaining):**

```typescript
import { z } from 'zod'

// Methods are attached to schema objects - hard to tree-shake
const userSchema = z.object({
  name: z.string().min(1).max(100),
  email: z.string().email(),
  age: z.number().int().positive(),
})

const result = userSchema.safeParse(data)
```

**Zod Mini (functional API):**

```typescript
import * as z from '@zod/mini'

// Functions are imported individually - tree-shakeable
const userSchema = z.object({
  name: z.pipe(z.string(), z.minLength(1), z.maxLength(100)),
  email: z.pipe(z.string(), z.email()),
  age: z.pipe(z.number(), z.int(), z.positive()),
})

const result = z.safeParse(userSchema, data)
```

**API differences:**

```typescript
// Standard Zod
z.string().min(5).max(100).email()
z.number().int().positive()
z.array(z.string()).min(1)
schema.parse(data)
schema.safeParse(data)

// Zod Mini
z.pipe(z.string(), z.minLength(5), z.maxLength(100), z.email())
z.pipe(z.number(), z.int(), z.positive())
z.pipe(z.array(z.string()), z.minLength(1))
z.parse(schema, data)
z.safeParse(schema, data)
```

**When to stick with regular Zod:**

```typescript
// Use regular Zod when:
// - Server-side where bundle size doesn't matter
// - Complex schemas with many transforms
// - Need full method chaining ergonomics
// - Bundle size isn't a constraint

// The 17kb isn't huge - only optimize if needed
// Server: 17kb is negligible
// Browser: 17kb ≈ 0.6ms additional startup on 3G
```

**Shared schemas between packages:**

```typescript
// shared-schemas/package.json
{
  "dependencies": {
    "@zod/mini": "^4.0.0"  // Mini for frontend-shared schemas
  }
}

// If you need both, Zod Mini schemas work with regular Zod
// But prefer consistency - pick one for your codebase
```

**Bundle size comparison:**

| Package | Gzipped Size | Use Case |
|---------|--------------|----------|
| `zod@3` | ~13kb | Legacy, stable |
| `zod@4` | ~17kb | Full features |
| `@zod/mini` | ~1.9kb | Bundle-critical |

**When NOT to use this pattern:**
- Server-side applications (bundle size irrelevant)
- When method chaining ergonomics are preferred
- Complex schemas that benefit from full API

Reference: [Zod Mini](https://zod.dev/packages/mini)
