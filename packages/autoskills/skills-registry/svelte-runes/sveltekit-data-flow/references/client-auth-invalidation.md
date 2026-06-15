# Client-Side Auth Invalidation

When using client-side auth libraries (Better Auth, Firebase, Supabase client),
layout server data doesn't auto-refresh after login/logout.

## The Problem

```typescript
// signin/+page.svelte - BROKEN
async function handle_signin() {
  await auth_client.signIn.email({ email, password });
  goto('/');  // Layout still shows "logged out"
}
```

**Why?** Client-side navigation (`goto()`) doesn't re-run server load functions.
The session cookie is set, but `+layout.server.ts` data is stale.

## Solution A: Inline Invalidation (Simple)

Call `invalidateAll()` after auth state change:

```typescript
// signin/+page.svelte
import { goto, invalidateAll } from '$app/navigation';

async function handle_signin() {
  const result = await auth_client.signIn.email({ email, password });
  if (result.error) return;

  await invalidateAll();  // Re-runs ALL load functions
  goto('/');
}

// signout handler
async function handle_signout() {
  await auth_client.signOut();
  await invalidateAll();
}
```

**Use when:** Single auth entry point, simple apps.

## Solution B: Auth State Listener (Robust)

Set up a listener in root layout that auto-invalidates on auth changes:

```svelte
<!-- +layout.svelte -->
<script>
  import { invalidateAll } from '$app/navigation';
  import { onMount } from 'svelte';
  import { auth_client } from '$lib/auth-client';

  onMount(() => {
    // Listen for auth state changes
    const unsubscribe = auth_client.onAuthStateChange(() => {
      invalidateAll();
    });

    return unsubscribe;
  });
</script>
```

**Use when:** Multiple auth flows (OAuth, magic links, etc.), complex apps.

## Common Mistakes

### Not awaiting invalidateAll()

```typescript
// WRONG - race condition
invalidateAll();
goto('/');

// RIGHT - wait for data refresh
await invalidateAll();
goto('/');
```

### Destructuring layout data

```svelte
<!-- WRONG - static snapshot -->
<script>
  let { data } = $props();
  const { user } = data;  // Never updates after invalidateAll()
</script>

<!-- RIGHT - reactive access -->
<script>
  let { data } = $props();
</script>

{data.user?.email}
```

## When invalidateAll() Runs

Per [Svelte docs](https://svelte.dev/tutorial/kit/invalidate-all):

> `invalidateAll()` is the nuclear option - it re-runs ALL load functions
> for the current page, regardless of dependencies.

This includes:
- `+layout.server.ts` (all levels)
- `+layout.ts` (all levels)
- `+page.server.ts`
- `+page.ts`

## Comparison with Server-Side Auth

| Approach | Auth Location | Invalidation |
|----------|--------------|--------------|
| Form actions | Server (`+page.server.ts`) | Automatic (page reload) |
| Client auth | Browser (auth_client) | Manual (`invalidateAll()`) |

Form actions with `throw redirect()` cause a full navigation, which
naturally re-runs load functions. Client-side auth with `goto()` does not.

## See Also

- [error-redirect-handling.md](error-redirect-handling.md) - Server-side redirects
- [load-functions.md](load-functions.md) - Server vs universal loads
