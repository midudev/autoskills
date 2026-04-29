---
title: Export Both Schemas and Inferred Types
impact: HIGH
impactDescription: Exporting only schemas forces consumers to derive types themselves; exporting both reduces boilerplate and improves DX
tags: type, export, module, organization
---

## Export Both Schemas and Inferred Types

When defining schemas in shared modules, export both the schema and its inferred type. This saves consumers from writing `z.infer<typeof schema>` repeatedly and makes imports cleaner.

**Incorrect (exporting only schema):**

```typescript
// schemas/user.ts
import { z } from 'zod'

export const userSchema = z.object({
  id: z.string().uuid(),
  email: z.string().email(),
  name: z.string(),
  role: z.enum(['admin', 'user']),
})

// Every consumer must derive the type
// api/users.ts
import { userSchema } from '@/schemas/user'
import type { z } from 'zod'

type User = z.infer<typeof userSchema>  // Repeated everywhere

// components/UserCard.tsx
import { userSchema } from '@/schemas/user'
import type { z } from 'zod'

type User = z.infer<typeof userSchema>  // Same boilerplate again
```

**Correct (exporting schema and type):**

```typescript
// schemas/user.ts
import { z } from 'zod'

export const userSchema = z.object({
  id: z.string().uuid(),
  email: z.string().email(),
  name: z.string(),
  role: z.enum(['admin', 'user']),
})

export type User = z.infer<typeof userSchema>

// For schemas with transforms, export both
export const apiUserSchema = z.object({
  id: z.string(),
  created_at: z.string().transform(s => new Date(s)),
})

export type ApiUserInput = z.input<typeof apiUserSchema>
export type ApiUser = z.infer<typeof apiUserSchema>
```

```typescript
// api/users.ts - clean import
import { userSchema, type User } from '@/schemas/user'

async function getUser(id: string): Promise<User> {
  const data = await db.users.findUnique({ where: { id } })
  return userSchema.parse(data)
}

// components/UserCard.tsx - just the type
import type { User } from '@/schemas/user'

function UserCard({ user }: { user: User }) {
  return <div>{user.name}</div>
}
```

**Organizing schema exports:**

```typescript
// schemas/index.ts - barrel file for schemas
export { userSchema, type User, type UserInput } from './user'
export { orderSchema, type Order } from './order'
export { productSchema, type Product } from './product'

// Usage
import { userSchema, type User, type Order } from '@/schemas'
```

**With enums, export the enum values too:**

```typescript
// schemas/user.ts
export const UserRole = z.enum(['admin', 'user', 'guest'])
export type UserRole = z.infer<typeof UserRole>

export const userSchema = z.object({
  id: z.string(),
  role: UserRole,
})

export type User = z.infer<typeof userSchema>

// Access enum values
UserRole.options  // ['admin', 'user', 'guest']
UserRole.enum.admin  // 'admin'
```

**When NOT to use this pattern:**
- Internal schemas that won't be used outside the module
- Transient schemas used only for validation (not as types)

Reference: [Zod API - Type Inference](https://zod.dev/api#type-inference)
