# Protected Routes

## Loader-Level Protection (Recommended)

Check auth in every loader that needs it. No central middleware needed:

```tsx
export async function loader(args: Route.LoaderArgs) {
  const { userId } = await getAuth(args)
  if (!userId) throw redirect('/sign-in')
  return json({ data: await fetchData(userId) })
}
```

## Middleware-Level Protection

Protect entire route subtrees via middleware in the route file:

```tsx
import { clerkMiddleware, getAuth } from '@clerk/react-router/server'
import { redirect } from 'react-router'

export const middleware = [
  clerkMiddleware(),
  async function requireAuth(args: Route.MiddlewareArgs, next: () => Promise<Response>) {
    const { userId } = await getAuth(args)
    if (!userId) return redirect('/sign-in')
    return next()
  },
]
```

## Client-Side Guard

For client-only redirects after hydration:

```tsx
import { useAuth } from '@clerk/react-router'
import { useNavigate } from 'react-router'

export function ProtectedPage() {
  const { isSignedIn, isLoaded } = useAuth()
  const navigate = useNavigate()

  useEffect(() => {
    if (isLoaded && !isSignedIn) navigate('/sign-in')
  }, [isLoaded, isSignedIn])

  if (!isLoaded || !isSignedIn) return null
  return <Dashboard />
}
```

> Prefer loader-level protection — it runs on the server before any HTML is sent.

## Org-Gated Routes

```tsx
export async function loader(args: Route.LoaderArgs) {
  const { userId, orgId, orgRole } = await getAuth(args)
  if (!userId) throw redirect('/sign-in')
  if (!orgId) throw redirect('/select-org')
  if (orgRole !== 'org:admin') throw new Response('Forbidden', { status: 403 })
  return { settings: await fetchOrgSettings(orgId) }
}
```
