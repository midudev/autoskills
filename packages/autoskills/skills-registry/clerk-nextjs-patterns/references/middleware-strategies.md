# Middleware Strategies (HIGH)

> **Filename:** `proxy.ts` (Next.js <=15: `middleware.ts`). The code is identical; only the filename changes.

## Public-First (marketing sites, blogs)

Protect specific routes, allow everything else:

```typescript
import { clerkMiddleware, createRouteMatcher } from '@clerk/nextjs/server';

const isProtectedRoute = createRouteMatcher([
  '/dashboard(.*)',
  '/settings(.*)',
  '/api/private(.*)',
]);

export default clerkMiddleware(async (auth, req) => {
  if (isProtectedRoute(req)) await auth.protect();
});

export const config = {
  matcher: [
    '/((?!_next|[^?]*\\.(?:html?|css|js(?!on)|jpe?g|webp|png|gif|svg|ttf|woff2?|ico|csv|docx?|xlsx?|zip|webmanifest)).*)',
    '/(api|trpc)(.*)',
  ],
};
```

## Protected-First (internal tools, dashboards)

Block everything, allow specific public routes:

```typescript
import { clerkMiddleware, createRouteMatcher } from '@clerk/nextjs/server';

const isPublicRoute = createRouteMatcher([
  '/',
  '/sign-in(.*)',
  '/sign-up(.*)',
  '/api/public(.*)',
]);

export default clerkMiddleware(async (auth, req) => {
  if (!isPublicRoute(req)) await auth.protect();
});
```

## Session Tasks

When session tasks are enabled (e.g., forced password reset, MFA setup), users may have a `pending` session status. You can handle this in middleware:

```typescript
export default clerkMiddleware(async (auth, req) => {
  const { sessionStatus } = await auth();

  // Redirect pending sessions to task completion page
  if (sessionStatus === 'pending') {
    return NextResponse.redirect(new URL('/sign-in/tasks', req.url));
  }

  if (isProtectedRoute(req)) await auth.protect();
});
```

> **Core 2 ONLY (skip if current SDK):** `sessionStatus` is not available. Session tasks do not exist in Core 2.

[Docs](https://clerk.com/docs/reference/nextjs/clerk-middleware)
