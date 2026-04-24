---
name: clerk-nextjs-patterns
description: Advanced Next.js patterns - middleware, Server Actions, caching with
  Clerk.
license: MIT
allowed-tools: WebFetch
metadata:
  author: clerk
  version: 2.2.0
---

# Next.js Patterns

> **Version**: Check `package.json` for the SDK version — see `clerk` skill for the version table. Core 2 differences are noted inline with `> **Core 2 ONLY (skip if current SDK):**` callouts.

For basic setup, see `clerk-setup` skill.

## What Do You Need?

| Task | Reference |
|------|-----------|
| Server vs client auth (`auth()` vs hooks) | references/server-vs-client.md |
| Configure middleware (public-first vs protected-first) | references/middleware-strategies.md |
| Protect Server Actions | references/server-actions.md |
| API route auth (401 vs 403) | references/api-routes.md |
| Cache auth data (user-scoped caching) | references/caching-auth.md |

## References

| Reference | Description |
|-----------|-------------|
| `references/server-vs-client.md` | `await auth()` vs hooks |
| `references/middleware-strategies.md` | Public-first vs protected-first, `proxy.ts` (Next.js <=15: `middleware.ts`) |
| `references/server-actions.md` | Protect mutations |
| `references/api-routes.md` | 401 vs 403 |
| `references/caching-auth.md` | User-scoped caching |

## Mental Model

Server vs Client = different auth APIs:
- **Server**: `await auth()` from `@clerk/nextjs/server` (async!)
- **Client**: `useAuth()` hook from `@clerk/nextjs` (sync)

Never mix them. Server Components use server imports, Client Components use hooks.

Key properties from `auth()`:
- `isAuthenticated` — boolean, replaces the `!!userId` pattern
- `sessionStatus` — `'active'` | `'pending'`, for detecting incomplete session tasks
- `userId`, `orgId`, `orgSlug`, `has()`, `protect()` — unchanged

> **Core 2 ONLY (skip if current SDK):** `isAuthenticated` and `sessionStatus` are not available. Check `!!userId` instead.

## Minimal Pattern

```typescript
// Server Component
import { auth } from '@clerk/nextjs/server'

export default async function Page() {
  const { isAuthenticated, userId } = await auth()  // MUST await!
  if (!isAuthenticated) return <p>Not signed in</p>
  return <p>Hello {userId}</p>
}
```

> **Core 2 ONLY (skip if current SDK):** `isAuthenticated` is not available. Use `if (!userId)` instead.

### Conditional Rendering with `<Show>`

For client-side conditional rendering based on auth state:

```tsx
import { Show } from '@clerk/nextjs'

<Show when="signed-in" fallback={<p>Please sign in</p>}>
  <Dashboard />
</Show>
```

> **Core 2 ONLY (skip if current SDK):** Use `<SignedIn>` and `<SignedOut>` components instead of `<Show>`. See `clerk-custom-ui` skill, `core-3/show-component.md` for the full migration table.

## Common Pitfalls

| Symptom | Cause | Fix |
|---------|-------|-----|
| `undefined` userId in Server Component | Missing `await` | `await auth()` not `auth()` |
| Auth not working on API routes | Missing matcher | Add `'/(api|trpc)(.*)'` to `proxy.ts` (Next.js <=15: `middleware.ts`) |
| Cache returns wrong user's data | Missing userId in key | Include `userId` in `unstable_cache` key |
| Mutations bypass auth | Unprotected Server Action | Check `auth()` at start of action |
| Wrong HTTP error code | Confused 401/403 | 401 = not signed in, 403 = no permission |

## Session Tokens & Custom JWTs

### getToken() for external APIs

Pass a custom JWT to third-party services (Hasura, Supabase, etc.) using JWT templates defined in the Clerk dashboard.

**Server-side (Server Component or Route Handler)**:

```typescript
import { auth } from '@clerk/nextjs/server'

export default async function Page() {
  const { getToken } = await auth()
  const token = await getToken({ template: 'hasura' })
  if (!token) return <p>Not authenticated</p>

  const res = await fetch('https://api.example.com/graphql', {
    headers: { Authorization: `Bearer ${token}` },
  })
  const data = await res.json()
  return <pre>{JSON.stringify(data)}</pre>
}
```

**Client-side (Client Component)**:

```typescript
'use client'
import { useAuth } from '@clerk/nextjs'

export function DataFetcher() {
  const { getToken } = useAuth()

  async function fetchData() {
    const token = await getToken({ template: 'supabase' })
    if (!token) return

    const res = await fetch('https://api.example.com/data', {
      headers: { Authorization: `Bearer ${token}` },
    })
    return res.json()
  }

  return <button onClick={fetchData}>Fetch</button>
}
```

`getToken()` returns `null` when the user is not authenticated — always null-check before use.

### useSession() for session data

Access session metadata in client components:

```typescript
'use client'
import { useSession } from '@clerk/nextjs'

export function SessionInfo() {
  const { session } = useSession()
  if (!session) return null

  return (
    <p>
      Session {session.id} — last active: {session.lastActiveAt.toISOString()}
    </p>
  )
}
```

### Manual JWT verification (no Clerk middleware)

For standalone API servers that receive Clerk session tokens from the `Authorization` header or the `__session` cookie (same-origin).

**Using `@clerk/backend` `verifyToken`** (recommended):

```typescript
import { verifyToken } from '@clerk/backend'

const token = req.headers.authorization?.replace('Bearer ', '')
if (!token) return res.status(401).json({ error: 'No token' })

try {
  const claims = await verifyToken(token, {
    jwtKey: process.env.CLERK_JWT_KEY,
  })
  // claims.sub = userId
} catch {
  return res.status(401).json({ error: 'Invalid token' })
}
```

**Using `jsonwebtoken`** (when you can't use `@clerk/backend`):

```typescript
import jwt from 'jsonwebtoken'

const publicKey = process.env.CLERK_PEM_PUBLIC_KEY!.replace(/\\n/g, '\n')
const token = req.headers.authorization?.replace('Bearer ', '')
if (!token) return res.status(401).json({ error: 'No token' })

try {
  const claims = jwt.verify(token, publicKey, { algorithms: ['RS256'] }) as jwt.JwtPayload
  // Manually check exp and nbf (jsonwebtoken does this automatically, but verify azp if needed)
  // claims.sub = userId
} catch {
  return res.status(401).json({ error: 'Invalid or expired token' })
}
```

Token sources:
- **Same-origin requests**: `__session` cookie (Clerk sets this automatically)
- **Cross-origin / mobile / API-to-API**: `Authorization: Bearer <token>` header

> **CRITICAL**: Always check `exp` and `nbf` claims. `verifyToken` from `@clerk/backend` handles this automatically; with raw `jsonwebtoken`, set `ignoreExpiration: false` (default) and ensure `clockTolerance` is minimal.

## See Also

- `clerk-setup`
- `clerk-orgs`

## Docs

[Next.js SDK](https://clerk.com/docs/reference/nextjs/overview)
