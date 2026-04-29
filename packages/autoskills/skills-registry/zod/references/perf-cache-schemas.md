---
title: Cache Schema Instances
impact: LOW-MEDIUM
impactDescription: Creating schemas on every render/call wastes CPU; module-level or memoized schemas are created once
tags: perf, cache, memoization, optimization
---

## Cache Schema Instances

Schema creation has overhead. Creating schemas inside render functions or on every function call wastes CPU cycles. Define schemas at module level or memoize them so they're created once and reused.

**Incorrect (creating schema every render):**

```typescript
import { z } from 'zod'

function UserForm() {
  // Schema created on EVERY render - wasteful
  const userSchema = z.object({
    name: z.string().min(1),
    email: z.string().email(),
    age: z.number().int().positive(),
  })

  const handleSubmit = (data: unknown) => {
    const result = userSchema.safeParse(data)
    // ...
  }

  return <form onSubmit={handleSubmit}>...</form>
}
```

**Correct (module-level schema):**

```typescript
import { z } from 'zod'

// Schema created ONCE at module load
const userSchema = z.object({
  name: z.string().min(1),
  email: z.string().email(),
  age: z.number().int().positive(),
})

type User = z.infer<typeof userSchema>

function UserForm() {
  const handleSubmit = (data: unknown) => {
    const result = userSchema.safeParse(data)
    // ...
  }

  return <form onSubmit={handleSubmit}>...</form>
}
```

**For dynamic schemas, use useMemo:**

```typescript
import { z } from 'zod'
import { useMemo } from 'react'

function DynamicForm({ minAge }: { minAge: number }) {
  // Schema only recreated when minAge changes
  const userSchema = useMemo(() =>
    z.object({
      name: z.string().min(1),
      age: z.number().min(minAge),
    }),
    [minAge]
  )

  // ...
}
```

**For server-side, use module cache:**

```typescript
// schemas/user.ts - created once per process
import { z } from 'zod'

export const userSchema = z.object({
  id: z.string().uuid(),
  email: z.string().email(),
})

// api/users.ts
import { userSchema } from '@/schemas/user'

export async function POST(req: Request) {
  const body = await req.json()
  const result = userSchema.safeParse(body)  // Reuses cached schema
  // ...
}
```

**Avoid schema factories in hot paths:**

```typescript
// BAD: Factory called on every validation
function createUserSchema(role: string) {
  return z.object({
    name: z.string(),
    permissions: z.array(z.string()),
  })
}

// Called in hot loop
users.forEach(user => {
  createUserSchema(user.role).parse(user)  // New schema every iteration!
})

// GOOD: Cache by key
const schemaCache = new Map<string, z.ZodObject<any>>()

function getUserSchema(role: string) {
  if (!schemaCache.has(role)) {
    schemaCache.set(role, z.object({
      name: z.string(),
      permissions: z.array(z.string()),
    }))
  }
  return schemaCache.get(role)!
}

// Reuses cached schemas
users.forEach(user => {
  getUserSchema(user.role).parse(user)
})
```

**When NOT to use this pattern:**
- One-off validation where schema is used once
- Test files where performance doesn't matter

Reference: [Zod Performance](https://zod.dev/v4#performance)
