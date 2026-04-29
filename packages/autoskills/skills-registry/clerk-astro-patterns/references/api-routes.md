# API Routes

## Basic Auth Check

```ts
// src/pages/api/data.ts
import type { APIRoute } from 'astro'

export const GET: APIRoute = async (context) => {
  const { userId } = context.locals.auth()

  if (!userId) {
    return new Response('Unauthorized', { status: 401 })
  }

  const data = await fetchData(userId)
  return new Response(JSON.stringify(data), {
    headers: { 'Content-Type': 'application/json' },
  })
}
```

## POST with Org Check

```ts
export const POST: APIRoute = async (context) => {
  const { userId, orgId } = context.locals.auth()

  if (!userId) return new Response('Unauthorized', { status: 401 })
  if (!orgId) return new Response('No active org', { status: 403 })

  const body = await context.request.json()
  await saveOrgData(orgId, body)

  return new Response(JSON.stringify({ ok: true }), {
    headers: { 'Content-Type': 'application/json' },
  })
}
```

## Permission Check

```ts
export const DELETE: APIRoute = async (context) => {
  const auth = context.locals.auth()
  if (!auth.userId) return new Response('Unauthorized', { status: 401 })

  const canDelete = auth.has({ permission: 'org:items:delete' })
  if (!canDelete) return new Response('Forbidden', { status: 403 })

  await deleteItem(context.params.id!)
  return new Response(null, { status: 204 })
}
```

## Using clerkClient in API Routes

```ts
import { clerkClient } from '@clerk/astro/server'

export const GET: APIRoute = async (context) => {
  const { userId } = context.locals.auth()
  if (!userId) return new Response('Unauthorized', { status: 401 })

  const client = clerkClient(context)
  const user = await client.users.getUser(userId)

  return new Response(JSON.stringify({ name: user.fullName }), {
    headers: { 'Content-Type': 'application/json' },
  })
}
```

## CRITICAL

- API routes are always SSR — `prerender` does not apply
- Use `context.locals.auth()` (not `Astro.locals.auth()`) in API routes
- Return proper HTTP status codes: 401 = not authenticated, 403 = not authorized
