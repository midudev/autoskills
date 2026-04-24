---
title: Avoid Dynamic Schema Creation in Hot Paths
impact: LOW-MEDIUM
impactDescription: Zod 4's JIT compilation makes schema creation slower; creating schemas in loops adds ~0.15ms per creation
tags: perf, dynamic, hot-path, optimization
---

## Avoid Dynamic Schema Creation in Hot Paths

Zod 4 uses JIT (Just-In-Time) compilation to speed up repeated parsing, but this makes initial schema creation slower. Avoid creating schemas inside loops or frequently-called functions—pre-create them instead.

**Incorrect (schema creation in hot path):**

```typescript
import { z } from 'zod'

async function validateBatch(items: unknown[]) {
  const results = []

  for (const item of items) {
    // Schema created for EACH item - slow!
    const schema = z.object({
      id: z.string(),
      value: z.number(),
    })

    results.push(schema.safeParse(item))
  }

  return results
}

// 1000 items = 1000 schema creations = ~150ms overhead
```

**Correct (pre-created schema):**

```typescript
import { z } from 'zod'

// Schema created ONCE
const itemSchema = z.object({
  id: z.string(),
  value: z.number(),
})

async function validateBatch(items: unknown[]) {
  // Reuse the same schema instance
  return items.map(item => itemSchema.safeParse(item))
}

// 1000 items = 1 schema creation + 1000 fast parses
```

**Dynamic schemas with caching:**

```typescript
import { z } from 'zod'

// Cache for dynamically-configured schemas
const schemaCache = new WeakMap<object, z.ZodType>()

function getSchemaForConfig(config: { fields: string[] }) {
  // Check cache first
  if (schemaCache.has(config)) {
    return schemaCache.get(config)!
  }

  // Create and cache
  const shape: Record<string, z.ZodString> = {}
  for (const field of config.fields) {
    shape[field] = z.string()
  }

  const schema = z.object(shape)
  schemaCache.set(config, schema)
  return schema
}

// Subsequent calls with same config reuse cached schema
```

**Lazy schema creation:**

```typescript
import { z } from 'zod'

// Schema created only when first used
let _userSchema: z.ZodObject<any> | null = null

function getUserSchema() {
  if (!_userSchema) {
    _userSchema = z.object({
      id: z.string().uuid(),
      email: z.string().email(),
      profile: z.object({
        name: z.string(),
        avatar: z.string().url().optional(),
      }),
    })
  }
  return _userSchema
}

// Or use a getter
const schemas = {
  _user: null as z.ZodType | null,
  get user() {
    if (!this._user) {
      this._user = z.object({ /* ... */ })
    }
    return this._user
  }
}
```

**Benchmark considerations:**

```typescript
// Zod 4 JIT compilation:
// - Schema creation: ~0.15ms per schema
// - First parse: triggers JIT compile
// - Subsequent parses: 7-14x faster

// For schemas used once:
// - Creation + parse: ~0.15ms + first-parse overhead
// - Consider if validation is even needed

// For schemas used many times:
// - Create once, parse many: optimal
// - JIT compilation amortized over all parses
```

**When NOT to use this pattern:**
- One-off validation where schema is used once
- Dynamically generated forms where fields change per request
- Test files where performance doesn't matter

Reference: [Zod v4 Performance](https://zod.dev/v4#performance)
