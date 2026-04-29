# Router Guards (CRITICAL)

## beforeLoad Auth Guard

`beforeLoad` runs before the route renders. Throw a redirect to block unauthenticated access:

```typescript
import { createFileRoute, redirect } from '@tanstack/react-router'
import { createServerFn } from '@tanstack/react-start'
import { auth } from '@clerk/tanstack-react-start/server'

const checkAuth = createServerFn().handler(async () => {
  const { isAuthenticated, userId } = await auth()
  if (!isAuthenticated) {
    throw redirect({ to: '/sign-in' })
  }
  return { userId }
})

export const Route = createFileRoute('/dashboard')({
  beforeLoad: async () => await checkAuth(),
})
```

## Passing Auth to Loader

```typescript
export const Route = createFileRoute('/dashboard')({
  beforeLoad: async () => {
    const { userId } = await checkAuth()
    return { userId }
  },
  loader: async ({ context }) => {
    const { userId } = context
    const data = await fetchUserData(userId)
    return { data }
  },
  component: Dashboard,
})

function Dashboard() {
  const { data } = Route.useLoaderData()
  return <div>{JSON.stringify(data)}</div>
}
```

## Layout Route Guard

Protect a group of routes with a single layout check:

```typescript
// src/routes/_authenticated.tsx
import { createFileRoute, redirect, Outlet } from '@tanstack/react-router'
import { createServerFn } from '@tanstack/react-start'
import { auth } from '@clerk/tanstack-react-start/server'

const getAuth = createServerFn().handler(async () => {
  const { isAuthenticated, userId } = await auth()
  if (!isAuthenticated) {
    throw redirect({ to: '/sign-in' })
  }
  return { userId }
})

export const Route = createFileRoute('/_authenticated')({
  beforeLoad: async () => await getAuth(),
  component: () => <Outlet />,
})
```

Child routes under `/_authenticated/` inherit the guard automatically.

## Redirect After Sign-In

```typescript
throw redirect({
  to: '/sign-in',
  search: { redirect: window.location.pathname },
})
```

[Docs](https://clerk.com/docs/tanstack-react-start/getting-started/quickstart)
