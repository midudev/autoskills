---
name: clerk-astro-patterns
description: 'Astro patterns with Clerk — middleware, SSR pages, island components,
  API routes, static vs SSR rendering. Triggers on: astro clerk, clerk astro middleware,
  astro protected page, clerk island component, astro API route auth, clerk astro
  SSR.'
license: MIT
allowed-tools: WebFetch
metadata:
  author: clerk
  version: 1.0.0
---

# Astro Patterns

SDK: `@clerk/astro` v3+. Requires Astro 4.15+.

## What Do You Need?

| Task | Reference |
|------|-----------|
| Configure middleware | references/middleware.md |
| Protect SSR pages | references/ssr-pages.md |
| Use Clerk in island components | references/island-components.md |
| Auth in API routes | references/api-routes.md |
| Use Clerk with React in Astro | references/astro-react.md |

## Mental Model

Astro has two rendering modes per page: **SSR** and **static prerender**. Clerk works differently in each:

- **SSR pages** — use `Astro.locals.auth()` which is populated by the middleware
- **Static pages** (`export const prerender = true`) — Clerk middleware skips them; use client-side hooks in islands
- **Islands** — React/Vue/Svelte components; use `useAuth()` and other hooks from `@clerk/astro/react`

```
Request → clerkMiddleware() → SSR page → Astro.locals.auth()
                                ↓
                         Island (.client) → useAuth() hook
```

## Setup

### astro.config.mjs

```ts
import { defineConfig } from 'astro/config'
import clerk from '@clerk/astro'

export default defineConfig({
  integrations: [clerk()],
  output: 'server',
})
```

### src/middleware.ts

```ts
import { clerkMiddleware, createRouteMatcher } from '@clerk/astro/server'

const isProtectedRoute = createRouteMatcher(['/dashboard(.*)'])

export const onRequest = clerkMiddleware((auth, context, next) => {
  if (isProtectedRoute(context.request) && !auth().userId) {
    return auth().redirectToSignIn()
  }
  return next()
})
```

## SSR Page Auth

```astro
---
const { userId, orgId } = Astro.locals.auth()
if (!userId) return Astro.redirect('/sign-in')
---

<h1>Dashboard</h1>
```

## Common Pitfalls

| Symptom | Cause | Fix |
|---------|-------|-----|
| `Astro.locals.auth` is undefined | Missing middleware | Add `clerkMiddleware` to `src/middleware.ts` |
| Auth works in dev but not production | `output: 'static'` globally | Set `output: 'server'` or `hybrid` for protected pages |
| Static page has no auth | Prerendered pages skip middleware | Use `export const prerender = false` or move to island |
| Island not reactive to sign-in | Missing `client:load` directive | Add `client:load` to the island component |

## Import Map

| What | Import From |
|------|-------------|
| `clerkMiddleware`, `createRouteMatcher` | `@clerk/astro/server` |
| `useAuth`, `useUser`, `UserButton` | `@clerk/astro/react` |
| Astro components (`<SignIn>`, etc.) | `@clerk/astro/components` |

## Env Variables

```
# .env
PUBLIC_CLERK_PUBLISHABLE_KEY=pk_...
CLERK_SECRET_KEY=sk_...
```

Astro uses `PUBLIC_` prefix for client-exposed variables (not `NEXT_PUBLIC_`).

## See Also

- `clerk-setup` - Initial Clerk install
- `clerk-custom-ui` - Custom flows & appearance
- `clerk-orgs` - B2B organizations

## Docs

[Astro SDK](https://clerk.com/docs/astro/getting-started/quickstart)
