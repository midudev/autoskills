# SSR Pages

## Basic Auth Check

```astro
---
// src/pages/dashboard.astro
const { userId } = Astro.locals.auth()
if (!userId) return Astro.redirect('/sign-in')

const data = await fetchData(userId)
---

<h1>Dashboard</h1>
<pre>{JSON.stringify(data)}</pre>
```

## Org-Scoped Page

```astro
---
const { userId, orgId, orgRole } = Astro.locals.auth()
if (!userId) return Astro.redirect('/sign-in')
if (!orgId) return Astro.redirect('/select-org')
if (orgRole !== 'org:admin') return Astro.redirect('/dashboard')

const settings = await fetchOrgSettings(orgId)
---

<h1>Org Settings</h1>
```

## Fetch Current User Data

```astro
---
import { clerkClient } from '@clerk/astro/server'

const { userId } = Astro.locals.auth()
if (!userId) return Astro.redirect('/sign-in')

const client = clerkClient(Astro)
const user = await client.users.getUser(userId)
---

<img src={user.imageUrl} alt={user.fullName ?? ''} />
```

## getToken for External APIs

```astro
---
const auth = Astro.locals.auth()
if (!auth.userId) return Astro.redirect('/sign-in')

const token = await auth.getToken({ template: 'supabase' })
const data = await fetchFromSupabase(token)
---
```

## Auth Object Fields

| Field | Type | Description |
|-------|------|-------------|
| `userId` | `string \| null` | Current user ID |
| `orgId` | `string \| null` | Active org ID |
| `orgRole` | `string \| null` | User's role in active org |
| `sessionId` | `string \| null` | Current session ID |
| `has()` | `function` | Check permissions |
| `getToken()` | `async function` | Get JWT for external APIs |

## CRITICAL

- `Astro.locals.auth()` returns an auth object — note the `()` call
- Pages must NOT have `export const prerender = true` for server auth to work
- To opt a single page out of static rendering: `export const prerender = false`
