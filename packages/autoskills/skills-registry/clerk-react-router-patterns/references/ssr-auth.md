# SSR Auth

## Pass Auth State to Components

Load user data in the loader, consume in the component:

```tsx
import { getAuth } from '@clerk/react-router/server'
import { clerkClient } from '@clerk/react-router/server'

export async function loader(args: Route.LoaderArgs) {
  const { userId } = await getAuth(args)
  if (!userId) throw redirect('/sign-in')

  const client = clerkClient(args)
  const user = await client.users.getUser(userId)
  return {
    firstName: user.firstName,
    imageUrl: user.imageUrl,
  }
}

export default function Dashboard({ loaderData }: Route.ComponentProps) {
  return <h1>Hello {loaderData.firstName}</h1>
}
```

## useAuth vs getAuth

| | `useAuth` (client) | `getAuth` (server) |
|--|--|--|
| Where | Components, hooks | Loaders, actions |
| Returns | Sync reactive state | Async auth object |
| Import | `@clerk/react-router` | `@clerk/react-router/server` |

## getToken for External APIs

```tsx
export async function loader(args: Route.LoaderArgs) {
  const auth = await getAuth(args)
  const token = await auth.getToken({ template: 'supabase' })
  const data = await fetchFromSupabase(token)
  return { data }
}
```

## Session Claims

```tsx
export async function loader(args: Route.LoaderArgs) {
  const { sessionClaims, userId } = await getAuth(args)
  const role = sessionClaims?.metadata?.role
  if (role !== 'admin') throw new Response('Forbidden', { status: 403 })
  return { adminData: await fetchAdminData() }
}
```
