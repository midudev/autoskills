# Nuxt Middleware (CRITICAL)

## Built-in Auth Middleware

`@clerk/nuxt` auto-registers an `auth` named middleware. Use it with `definePageMeta`:

```vue
<script setup lang="ts">
definePageMeta({ middleware: 'auth' })
</script>
```

This redirects unauthenticated users to the sign-in page automatically.

## Custom Route Middleware

Create `middleware/require-org.ts` for custom logic:

```typescript
export default defineNuxtRouteMiddleware(() => {
  const { isSignedIn, orgId } = useAuth()

  if (!isSignedIn.value) {
    return navigateTo('/sign-in')
  }

  if (!orgId.value) {
    return navigateTo('/select-org')
  }
})
```

Apply to a page:

```vue
<script setup lang="ts">
definePageMeta({ middleware: ['auth', 'require-org'] })
</script>
```

## Server-Side Middleware (Nitro)

For API-level protection in `server/middleware/auth.ts`:

```typescript
import { clerkClient } from '@clerk/nuxt/server'

export default defineEventHandler(async (event) => {
  const auth = event.context.auth

  if (getRequestURL(event).pathname.startsWith('/api/protected')) {
    if (!auth?.userId) {
      throw createError({ statusCode: 401, message: 'Unauthorized' })
    }
  }
})
```

## Redirect URLs

Configure in `.env`:
```
NUXT_PUBLIC_CLERK_SIGN_IN_URL=/sign-in
NUXT_PUBLIC_CLERK_SIGN_UP_URL=/sign-up
NUXT_PUBLIC_CLERK_SIGN_IN_FALLBACK_REDIRECT_URL=/dashboard
NUXT_PUBLIC_CLERK_SIGN_UP_FALLBACK_REDIRECT_URL=/dashboard
```

[Docs](https://clerk.com/docs/nuxt/getting-started/quickstart)
