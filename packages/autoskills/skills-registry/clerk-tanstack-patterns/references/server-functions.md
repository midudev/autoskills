# Server Functions (CRITICAL)

## createServerFn with auth()

`createServerFn` runs on the server. Use `auth()` from `@clerk/tanstack-react-start/server` inside handlers:

```typescript
import { createServerFn } from '@tanstack/react-start'
import { auth } from '@clerk/tanstack-react-start/server'

export const getAuthenticatedUser = createServerFn().handler(async () => {
  const { isAuthenticated, userId } = await auth()

  if (!isAuthenticated) {
    throw new Error('Unauthorized')
  }

  return { userId }
})
```

## Import Path

```typescript
// Server-side auth: always import from /server subpath
import { auth } from '@clerk/tanstack-react-start/server'

// Client-side hooks: import from package root
import { useAuth, useUser } from '@clerk/tanstack-react-start'
```

Mixing these causes runtime errors.

## Redirect Pattern

```typescript
import { createServerFn } from '@tanstack/react-start'
import { redirect } from '@tanstack/react-router'
import { auth } from '@clerk/tanstack-react-start/server'

export const requireAuth = createServerFn().handler(async () => {
  const { isAuthenticated, userId } = await auth()

  if (!isAuthenticated) {
    throw redirect({ to: '/sign-in' })
  }

  return { userId }
})
```

`redirect` must be `throw`n, not returned.

## Org-Scoped Server Function

```typescript
export const getOrgData = createServerFn().handler(async () => {
  const { isAuthenticated, userId, orgId } = await auth()

  if (!isAuthenticated) {
    throw redirect({ to: '/sign-in' })
  }

  if (!orgId) {
    throw redirect({ to: '/select-org' })
  }

  const data = await db.items.findMany({ where: { orgId } })
  return { data, orgId }
})
```

## Calling from Components

Server functions can be called in `beforeLoad`, loaders, or directly in components:

```typescript
// In a component (client-side trigger)
import { getOrgData } from '~/server/functions'

function Page() {
  async function handleClick() {
    const result = await getOrgData()
    console.log(result.data)
  }

  return <button onClick={handleClick}>Load</button>
}
```

[Docs](https://clerk.com/docs/tanstack-react-start/getting-started/quickstart)
