---
title: Use safeParse() for User Input
impact: CRITICAL
impactDescription: parse() throws exceptions on invalid data; unhandled exceptions crash servers and expose stack traces to users
tags: parse, safeParse, error-handling, validation
---

## Use safeParse() for User Input

`parse()` throws a `ZodError` when validation fails, which crashes your application if not caught. `safeParse()` returns a result object that you can inspect without try/catch. Use `safeParse()` for any user-provided or external data.

**Incorrect (parse without error handling):**

```typescript
import { z } from 'zod'
import { NextRequest, NextResponse } from 'next/server'

const createUserSchema = z.object({
  email: z.string().email(),
  name: z.string().min(1),
})

export async function POST(req: NextRequest) {
  const body = await req.json()

  // If validation fails, this throws and crashes the handler
  const user = createUserSchema.parse(body)

  // Never reached if parse throws
  await db.users.create({ data: user })
  return NextResponse.json({ success: true })
}
// Result: 500 Internal Server Error with stack trace
```

**Correct (using safeParse):**

```typescript
import { z } from 'zod'
import { NextRequest, NextResponse } from 'next/server'

const createUserSchema = z.object({
  email: z.string().email(),
  name: z.string().min(1),
})

export async function POST(req: NextRequest) {
  const body = await req.json()

  const result = createUserSchema.safeParse(body)

  if (!result.success) {
    // Return structured error response
    return NextResponse.json(
      { error: 'Validation failed', issues: result.error.issues },
      { status: 400 }
    )
  }

  // result.data is typed correctly
  await db.users.create({ data: result.data })
  return NextResponse.json({ success: true })
}
```

**The result object structure:**

```typescript
// Success case
{ success: true, data: T }

// Error case
{ success: false, error: ZodError }

// Type narrowing works automatically
if (result.success) {
  result.data  // T - fully typed
} else {
  result.error  // ZodError
  result.error.issues  // Array of validation issues
}
```

**When parse() is acceptable:**

```typescript
// Internal data you control - parse is fine
const config = configSchema.parse(JSON.parse(process.env.CONFIG))

// Test assertions - parse throws helpful errors
expect(() => schema.parse(invalidData)).toThrow()

// Schema development - see errors immediately
schema.parse(testData)  // See what fails during development
```

**When NOT to use this pattern:**
- Internal configuration parsing where invalid data should crash early
- Tests where you want exceptions to fail the test
- Scripts where you want to see the full error

Reference: [Zod API - safeParse](https://zod.dev/api#safeparse)
