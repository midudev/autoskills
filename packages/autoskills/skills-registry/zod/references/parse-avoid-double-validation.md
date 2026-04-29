---
title: Avoid Double Validation
impact: HIGH
impactDescription: Parsing the same data twice wastes CPU cycles; in hot paths this adds measurable latency
tags: parse, performance, optimization, architecture
---

## Avoid Double Validation

Once data is validated by Zod, trust the result. Re-validating the same data in multiple layers doubles CPU usage and adds latency. Pass the typed result through your application instead.

**Incorrect (validating at every layer):**

```typescript
import { z } from 'zod'

const userSchema = z.object({
  id: z.string().uuid(),
  email: z.string().email(),
  name: z.string(),
})

// Controller validates
export async function POST(req: NextRequest) {
  const body = await req.json()
  const user = userSchema.parse(body)  // First parse
  return await userService.create(user)
}

// Service validates again
const userService = {
  async create(data: unknown) {
    const user = userSchema.parse(data)  // Second parse - redundant
    return await userRepository.insert(user)
  }
}

// Repository validates again
const userRepository = {
  async insert(data: unknown) {
    const user = userSchema.parse(data)  // Third parse - wasteful
    return await db.users.create({ data: user })
  }
}
```

**Correct (validate once, pass typed data):**

```typescript
import { z } from 'zod'

const userSchema = z.object({
  id: z.string().uuid(),
  email: z.string().email(),
  name: z.string(),
})

type User = z.infer<typeof userSchema>

// Controller validates at boundary
export async function POST(req: NextRequest) {
  const body = await req.json()

  const result = userSchema.safeParse(body)
  if (!result.success) {
    return NextResponse.json({ errors: result.error.issues }, { status: 400 })
  }

  // Pass validated, typed data
  return await userService.create(result.data)
}

// Service receives typed data, no re-validation needed
const userService = {
  async create(user: User) {
    // user is guaranteed to match schema
    return await userRepository.insert(user)
  }
}

// Repository receives typed data
const userRepository = {
  async insert(user: User) {
    return await db.users.create({ data: user })
  }
}
```

**When you might validate at multiple layers:**

```typescript
// Different schemas for different layers
const apiUserSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),  // Only in API layer
})

const dbUserSchema = z.object({
  id: z.string().uuid(),
  email: z.string().email(),
  passwordHash: z.string(),  // Transformed before storage
})

// API validates input format
export async function POST(req: NextRequest) {
  const input = apiUserSchema.parse(await req.json())
  const user = await userService.create(input)
  return NextResponse.json(user)
}

// Service transforms and validates for storage
const userService = {
  async create(input: z.infer<typeof apiUserSchema>) {
    const dbUser = dbUserSchema.parse({
      id: crypto.randomUUID(),
      email: input.email,
      passwordHash: await hash(input.password),
    })
    return await userRepository.insert(dbUser)
  }
}
```

**When NOT to use this pattern:**
- When schemas differ between layers (API vs DB shape)
- When data crosses trust boundaries (external service response)
- During development when debugging data flow

Reference: [Zod Performance](https://zod.dev/v4#performance)
