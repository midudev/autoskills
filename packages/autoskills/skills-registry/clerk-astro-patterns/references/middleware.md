# Middleware

## Basic Setup

```ts
// src/middleware.ts
import { clerkMiddleware, createRouteMatcher } from '@clerk/astro/server'

const isProtectedRoute = createRouteMatcher([
  '/dashboard(.*)',
  '/settings(.*)',
  '/api/private(.*)',
])

export const onRequest = clerkMiddleware((auth, context, next) => {
  if (isProtectedRoute(context.request) && !auth().userId) {
    return auth().redirectToSignIn()
  }
  return next()
})
```

## With Custom Handler

```ts
export const onRequest = clerkMiddleware((auth, context, next) => {
  const { userId, orgId } = auth()

  if (isProtectedRoute(context.request)) {
    if (!userId) return auth().redirectToSignIn()
    if (!orgId) return context.redirect('/select-org')
  }

  return next()
})
```

## No Handler (Pass-Through)

```ts
export const onRequest = clerkMiddleware()
```

The middleware still populates `Astro.locals.auth` — you just do the redirect check per-page.

## createRouteMatcher Patterns

```ts
createRouteMatcher([
  '/dashboard',           // exact
  '/dashboard(.*)',       // prefix match
  '/api/private/(.*)',    // nested
  /^\/admin/,            // regex
])
```

## clerkMiddleware Signature

```ts
clerkMiddleware(handler?, options?)

// handler: (auth, context, next) => Response | Promise<Response>
// auth: () => AuthObject  (call it to get { userId, orgId, ... })
// context: Astro APIContext
// next: () => Promise<Response>
```

## CRITICAL

- Middleware is skipped for pages with `export const prerender = true`
- `auth()` is a function — call it to get the auth object: `auth().userId` not `auth.userId`
- Always return `next()` for non-protected routes
