# Server API Routes (HIGH)

## Auth Context in Nitro

`event.context.auth` is automatically populated by `@clerk/nuxt` for all server routes.

```typescript
// server/api/me.get.ts
export default defineEventHandler(async (event) => {
  const { userId } = event.context.auth ?? {}

  if (!userId) {
    throw createError({ statusCode: 401, message: 'Unauthorized' })
  }

  return { userId }
})
```

## Using clerkClient

Import `clerkClient` from `@clerk/nuxt/server` to access the Clerk backend API:

```typescript
// server/api/user.get.ts
import { clerkClient } from '@clerk/nuxt/server'

export default defineEventHandler(async (event) => {
  const { userId } = event.context.auth ?? {}

  if (!userId) {
    throw createError({ statusCode: 401, message: 'Unauthorized' })
  }

  const user = await clerkClient(event).users.getUser(userId)

  return {
    id: user.id,
    firstName: user.firstName,
    email: user.emailAddresses[0]?.emailAddress,
  }
})
```

## Org-Scoped Server Routes

```typescript
// server/api/projects.get.ts
export default defineEventHandler(async (event) => {
  const { userId, orgId } = event.context.auth ?? {}

  if (!userId) {
    throw createError({ statusCode: 401, message: 'Unauthorized' })
  }

  if (!orgId) {
    throw createError({ statusCode: 403, message: 'No active organization' })
  }

  const projects = await db.projects.findMany({ where: { orgId } })
  return projects
})
```

## Error Codes

- `401` — not authenticated (no valid session)
- `403` — authenticated but no permission (wrong role, no org)

[Docs](https://clerk.com/docs/nuxt/getting-started/quickstart)
