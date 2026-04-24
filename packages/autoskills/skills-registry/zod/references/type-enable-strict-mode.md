---
title: Enable TypeScript Strict Mode
impact: HIGH
impactDescription: Without strict mode, Zod's type inference is unreliable; undefined and null slip through, defeating the purpose of validation
tags: type, typescript, strict, configuration
---

## Enable TypeScript Strict Mode

Zod requires TypeScript's strict mode to work correctly. Without it, `undefined` sneaks into types, `null` checks are bypassed, and type inference becomes unreliable. This undermines the type safety that Zod provides.

**Incorrect (strict mode disabled):**

```json
// tsconfig.json
{
  "compilerOptions": {
    "strict": false
  }
}
```

```typescript
import { z } from 'zod'

const userSchema = z.object({
  name: z.string(),
  email: z.string().email(),
})

type User = z.infer<typeof userSchema>
// With strict:false, type might include undefined implicitly

function processUser(user: User) {
  // No error even if user.name could be undefined
  console.log(user.name.toUpperCase())  // Potential runtime crash
}

// TypeScript allows calling with undefined
processUser(undefined as any)  // No warning
```

**Correct (strict mode enabled):**

```json
// tsconfig.json
{
  "compilerOptions": {
    "strict": true
  }
}
```

```typescript
import { z } from 'zod'

const userSchema = z.object({
  name: z.string(),
  email: z.string().email(),
})

type User = z.infer<typeof userSchema>
// { name: string; email: string } - no implicit undefined

function processUser(user: User) {
  // TypeScript knows name is always string
  console.log(user.name.toUpperCase())  // Safe
}

// TypeScript catches potential undefined
processUser(undefined as any)  // Error with strict null checks
```

**Minimum strict settings for Zod:**

```json
// tsconfig.json
{
  "compilerOptions": {
    // Full strict mode (recommended)
    "strict": true,

    // Or at minimum, enable these:
    "strictNullChecks": true,
    "noImplicitAny": true
  }
}
```

**Common errors when strict mode is disabled:**

```typescript
// Without strictNullChecks
const schema = z.string().optional()
type MaybeString = z.infer<typeof schema>
// Should be: string | undefined
// Without strict: just string (undefined is implicit)

// Without noImplicitAny
const schema = z.object({ name: z.string() })
schema.parse(data)  // data could be 'any', bypassing validation
```

**Migrating to strict mode:**

```typescript
// If enabling strict breaks existing code, fix issues incrementally
// Common fixes:

// 1. Add null checks
if (user.name !== undefined) {
  console.log(user.name.toUpperCase())
}

// 2. Add explicit types
function processData(data: unknown) {  // Was implicit any
  const validated = schema.parse(data)
}

// 3. Handle optional fields
const user: User = {
  name: 'John',
  email: 'john@example.com',  // Now required, was optional without strict
}
```

**When NOT to use this pattern:**
- Never - always enable strict mode for Zod projects

Reference: [Zod Requirements](https://zod.dev/#requirements)
