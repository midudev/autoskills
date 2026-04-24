---
name: tanstack-start
description: Full-stack React framework powered by TanStack Router with SSR, streaming, server functions, and deployment to any hosting provider.
---

# TanStack Start Skills

## Overview

TanStack Start is a full-stack React framework built on TanStack Router, powered by Vite and Nitro (via Vinxi). It provides server-side rendering, streaming, server functions (RPC), middleware, API routes, and deploys to any platform via Nitro presets.

**Package:** `@tanstack/react-start`
**Router Plugin:** `@tanstack/router-plugin`
**Build Tool:** Vinxi (Vite + Nitro)
**Status:** RC (Release Candidate)
**RSC Support:** React Server Components support is in active development and will land as a non-breaking v1.x addition

## Installation & Project Setup

```bash
npx @tanstack/cli create my-app
# Or manually:
npm install @tanstack/react-start @tanstack/react-router react react-dom
npm install -D @tanstack/router-plugin typescript vite vite-tsconfig-paths
```

### Project Structure

```
my-app/
  app/
    routes/
      __root.tsx          # Root layout
      index.tsx           # / route
      posts.$postId.tsx   # /posts/:postId
      api/
        users.ts          # /api/users API route
    client.tsx            # Client entry
    router.tsx            # Router creation
    ssr.tsx               # SSR entry
    routeTree.gen.ts      # Auto-generated route tree
  app.config.ts           # TanStack Start config
  tsconfig.json
  package.json
```

### Configuration (`app.config.ts`)

```typescript
import { defineConfig } from '@tanstack/react-start/config'
import viteTsConfigPaths from 'vite-tsconfig-paths'

export default defineConfig({
  vite: {
    plugins: [
      viteTsConfigPaths({ projects: ['./tsconfig.json'] }),
    ],
  },
  server: {
    preset: 'node-server', // 'vercel' | 'netlify' | 'cloudflare-pages' | etc.
  },
  tsr: {
    appDirectory: './app',
    routesDirectory: './app/routes',
    generatedRouteTree: './app/routeTree.gen.ts',
  },
})
```

## Server Functions (`createServerFn`)

Server functions provide type-safe RPC calls between client and server.

### Basic Server Functions

```typescript
import { createServerFn } from '@tanstack/react-start'

// GET (data fetching, cacheable)
const getUsers = createServerFn()
  .handler(async () => {
    const users = await db.query.users.findMany()
    return users
  })

// POST (mutations, side effects)
const createUser = createServerFn({ method: 'POST' })
  .validator((data: { name: string; email: string }) => data)
  .handler(async ({ data }) => {
    const user = await db.insert(users).values(data).returning()
    return user
  })
```

### With Zod Validation

```typescript
import { z } from 'zod'

const updateUser = createServerFn({ method: 'POST' })
  .validator(
    z.object({
      id: z.string(),
      name: z.string().min(1),
      email: z.string().email(),
    })
  )
  .handler(async ({ data }) => {
    // data is fully typed: { id: string; name: string; email: string }
    return await db.update(users).set(data).where(eq(users.id, data.id))
  })
```

## Middleware

### Creating Middleware

```typescript
import { createMiddleware } from '@tanstack/react-start'

const loggingMiddleware = createMiddleware().handler(async ({ next }) => {
  console.log('Request started')
  const result = await next()
  console.log('Request completed')
  return result
})
```

### Auth Middleware with Context

```typescript
const authMiddleware = createMiddleware().handler(async ({ next }) => {
  const request = getWebRequest()
  const session = await getSession(request)

  if (!session?.user) {
    throw redirect({ to: '/login' })
  }

  // Pass typed context to handler
  return next({ context: { user: session.user } })
})
```

### Chaining Middleware

```typescript
const adminMiddleware = createMiddleware()
  .middleware([authMiddleware])
  .handler(async ({ next, context }) => {
    // context.user is typed from authMiddleware
    if (context.user.role !== 'admin') {
      throw redirect({ to: '/unauthorized' })
    }
    return next({ context: { isAdmin: true } })
  })

// Usage
const adminAction = createServerFn({ method: 'POST' })
  .middleware([adminMiddleware])
  .handler(async ({ context }) => {
    // context: { user: User; isAdmin: boolean }
    return { success: true }
  })
```

## API Routes (Server Routes)

```typescript
// app/routes/api/users.ts
import { createAPIFileRoute } from '@tanstack/react-start/api'

export const APIRoute = createAPIFileRoute('/api/users')({
  GET: async ({ request }) => {
    const users = await db.query.users.findMany()
    return Response.json(users)
  },
  POST: async ({ request }) => {
    const body = await request.json()
    const user = await db.insert(users).values(body).returning()
    return new Response(JSON.stringify(user), { status: 201 })
  },
})
```

## SSR Strategies

### Streaming SSR (Default)

```typescript
export const Route = createFileRoute('/dashboard')({
  loader: async () => ({
    criticalData: await fetchCriticalData(),
    deferredData: defer(fetchSlowData()),
  }),
  component: Dashboard,
})

function Dashboard() {
  const { criticalData, deferredData } = Route.useLoaderData()
  return (
    <div>
      <CriticalSection data={criticalData} />
      <Suspense fallback={<Loading />}>
        <Await promise={deferredData}>
          {(data) => <SlowSection data={data} />}
        </Await>
      </Suspense>
    </div>
  )
}
```

## Deployment

### Supported Platforms (Nitro Presets)

```typescript
// app.config.ts
export default defineConfig({
  server: {
    preset: 'node-server',        // Self-hosted Node.js
    // preset: 'vercel',          // Vercel
    // preset: 'netlify',         // Netlify
    // preset: 'cloudflare-pages', // Cloudflare Pages
    // preset: 'aws-lambda',      // AWS Lambda
    // preset: 'deno-server',     // Deno Deploy
    // preset: 'bun',             // Bun
  },
})
```

## Best Practices

1. **Use validators for all server function inputs** - runtime safety and TypeScript inference
2. **Compose middleware** for cross-cutting concerns (auth, logging, rate limiting)
3. **Use `createServerFn` GET** for data fetching (cacheable, preloadable)
4. **Use `createServerFn` POST** for mutations and side effects
5. **Use `beforeLoad`** for route-level auth guards
6. **Use `defer()`** for non-critical data to improve TTFB
7. **Set `defaultPreload: 'intent'`** on the router for instant navigation
8. **Co-locate server functions** with the routes that use them

## Common Pitfalls

- Server functions cannot close over client-side variables (they're extracted to separate bundles)
- Data returned from server functions must be serializable
- Forgetting `await` in loaders leads to streaming issues
- Importing server-only code in client bundles causes build errors
- Missing `declare module '@tanstack/react-router'` loses all type safety
