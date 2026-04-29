---
title: Use default() for Optional Fields with Defaults
impact: MEDIUM
impactDescription: Manual default handling spreads logic across codebase; .default() centralizes defaults in schema
tags: refine, default, optional, configuration
---

## Use default() for Optional Fields with Defaults

When a field is optional but should have a default value when missing, use `.default()` instead of handling defaults in business logic. This keeps default values centralized in the schema and ensures consistent behavior.

**Incorrect (defaults spread across codebase):**

```typescript
import { z } from 'zod'

const configSchema = z.object({
  timeout: z.number().optional(),
  retries: z.number().optional(),
  debug: z.boolean().optional(),
})

type Config = z.infer<typeof configSchema>

function createClient(config: Config) {
  // Defaults handled in business logic - duplicated everywhere
  const timeout = config.timeout ?? 5000
  const retries = config.retries ?? 3
  const debug = config.debug ?? false

  // ...
}

function createOtherClient(config: Config) {
  // Same defaults duplicated - risk of inconsistency
  const timeout = config.timeout ?? 5000
  const retries = config.retries ?? 3  // What if someone uses 2 here?
  const debug = config.debug ?? false

  // ...
}
```

**Correct (defaults in schema):**

```typescript
import { z } from 'zod'

const configSchema = z.object({
  timeout: z.number().default(5000),
  retries: z.number().default(3),
  debug: z.boolean().default(false),
})

type Config = z.infer<typeof configSchema>
// { timeout: number; retries: number; debug: boolean }
// No optional - defaults fill in missing values

function createClient(config: Config) {
  // config.timeout is guaranteed to exist
  console.log(config.timeout)  // 5000 if not provided
  console.log(config.retries)  // 3 if not provided
  console.log(config.debug)    // false if not provided
}

// Parse fills in defaults
configSchema.parse({})
// { timeout: 5000, retries: 3, debug: false }

configSchema.parse({ timeout: 10000 })
// { timeout: 10000, retries: 3, debug: false }
```

**Input type vs Output type with defaults:**

```typescript
const schema = z.object({
  name: z.string(),
  role: z.enum(['admin', 'user']).default('user'),
})

type SchemaInput = z.input<typeof schema>
// { name: string; role?: 'admin' | 'user' }

type SchemaOutput = z.output<typeof schema>
// { name: string; role: 'admin' | 'user' }

// Input type is optional, output type is required
```

**Default with factory function:**

```typescript
// Static default
const schema1 = z.object({
  id: z.string().default('temp-id'),
})

// Factory function for dynamic defaults
const schema2 = z.object({
  id: z.string().default(() => crypto.randomUUID()),
  createdAt: z.date().default(() => new Date()),
})

// Each parse creates new values
schema2.parse({})  // { id: 'abc-123...', createdAt: 2024-01-15... }
schema2.parse({})  // { id: 'def-456...', createdAt: 2024-01-15... }
```

**Combining with optional/nullable:**

```typescript
// .optional().default() - if undefined, use default
z.string().optional().default('fallback')

// .nullable().default() - null stays null, only undefined gets default
z.string().nullable().default('fallback')
// null -> null
// undefined -> 'fallback'

// .nullish().default() - both null and undefined get default
z.string().nullish().default('fallback')
// null -> 'fallback'
// undefined -> 'fallback'
```

**When NOT to use this pattern:**
- When absence of value has different meaning than default
- When defaults depend on other fields (use transform)

Reference: [Zod API - default](https://zod.dev/api#default)
