# Loaders and Actions Auth

## getAuth in Loaders

```tsx
import { getAuth } from '@clerk/react-router/server'
import { redirect } from 'react-router'
import type { Route } from './+types/dashboard'

export async function loader(args: Route.LoaderArgs) {
  const { userId, orgId, sessionId } = await getAuth(args)
  if (!userId) throw redirect('/sign-in')
  return { data: await db.query(userId) }
}
```

## getAuth in Actions

```tsx
export async function action(args: Route.ActionArgs) {
  const { userId } = await getAuth(args)
  if (!userId) throw new Response('Unauthorized', { status: 401 })

  const fd = await args.request.formData()
  await db.insert({ userId, title: fd.get('title') })
  return redirect('/dashboard')
}
```

## rootAuthLoader Callback Form

Pass a callback to `rootAuthLoader` when you need auth state in the root route:

```tsx
import { rootAuthLoader } from '@clerk/react-router/server'

export async function loader(args: Route.LoaderArgs) {
  return rootAuthLoader(args, async ({ request }) => {
    const { userId } = request.auth
    if (!userId) return { user: null }
    return { user: await db.getUser(userId) }
  })
}
```

## Available Auth Fields

| Field | Type | Description |
|-------|------|-------------|
| `userId` | `string \| null` | Current user ID |
| `sessionId` | `string \| null` | Current session ID |
| `orgId` | `string \| null` | Active org ID |
| `orgRole` | `string \| null` | User's role in active org |
| `has()` | `function` | Check permissions/features |

## CRITICAL

- `getAuth` throws if `clerkMiddleware` is not installed
- `rootAuthLoader` must be called in `root.tsx` loader — not just any loader
- Import `redirect` from `react-router`, not from `@remix-run/react-router`
