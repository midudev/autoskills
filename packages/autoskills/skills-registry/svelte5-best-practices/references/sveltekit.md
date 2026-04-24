# SvelteKit Patterns Reference

## Table of Contents
- [Load Function Types](#load-function-types)
- [Page Props Typing](#page-props-typing)
- [Form Actions Error Handling](#form-actions-error-handling)
- [SSR State Isolation](#ssr-state-isolation)

---

## Load Function Types

SvelteKit has two load function types: universal (`+page.js`) and server-only (`+page.server.ts`).

### When to Use Each

| Use +page.server.ts | Use +page.js |
|---------------------|--------------|
| Accessing secrets/credentials | Public APIs only |
| Database connections | Non-serializable data (functions, classes) |
| Server-only APIs | Client-side caching benefits |
| Sensitive business logic | |

### Security: Secrets in Server Load

**WRONG (secrets exposed):**
```ts
// +page.js - DANGEROUS: runs in browser!
export const load = async ({ fetch }) => {
  const response = await fetch('https://api.stripe.com/charges', {
    headers: { 'Authorization': `Bearer ${STRIPE_SECRET_KEY}` } // EXPOSED!
  });
  return { charges: await response.json() };
};
```

**CORRECT:**
```ts
// +page.server.ts - only runs on server
import { STRIPE_SECRET_KEY } from '$env/static/private';

export const load = async ({ fetch }) => {
  const response = await fetch('https://api.stripe.com/charges', {
    headers: { 'Authorization': `Bearer ${STRIPE_SECRET_KEY}` }
  });
  return { charges: await response.json() };
};
```

### Serialization: Non-serializable in Universal Load

**WRONG (server load can't serialize functions):**
```ts
// +page.server.ts
export const load = async () => {
  return {
    formatDate: (date: Date) => date.toLocaleDateString(), // ERROR
    parser: new DOMParser() // ERROR
  };
};
```

**CORRECT:**
```ts
// +page.js
export const load = async () => {
  return {
    formatDate: (date: Date) => date.toLocaleDateString(), // OK
    parser: typeof window !== 'undefined' ? new DOMParser() : null
  };
};
```

### Database Access

```ts
// +page.server.ts - CORRECT
import { db } from '$lib/server/database';

export const load = async () => {
  const users = await db.query('SELECT * FROM users');
  return { users };
};
```

### Environment Variables

```ts
// +page.server.ts - Private env vars
import { DATABASE_URL, API_SECRET } from '$env/static/private';

// +page.js - Only public env vars
import { PUBLIC_API_URL } from '$env/static/public';
```

---

## Page Props Typing

SvelteKit generates types in `./$types` for full type safety with `$props()`.

### Basic Page Data Typing

```svelte
<!-- +page.svelte -->
<script lang="ts">
  import type { PageProps } from './$types';

  let { data }: PageProps = $props();
</script>

<h1>{data.title}</h1>
```

### Page Data with Form Actions

```svelte
<script lang="ts">
  import type { PageProps } from './$types';

  let { data, form }: PageProps = $props();
</script>

{#if form?.success}
  <p class="success">{form.message}</p>
{/if}

{#if form?.error}
  <p class="error">{form.error}</p>
{/if}
```

### Layout Data Typing

```svelte
<!-- +layout.svelte -->
<script lang="ts">
  import type { LayoutProps } from './$types';

  let { data, children }: LayoutProps = $props();
</script>

<nav>
  {#if data.user}<span>Welcome, {data.user.name}</span>{/if}
</nav>

{@render children()}
```

### Corresponding Load Function

```ts
// +page.server.ts
import type { PageServerLoad, Actions } from './$types';

export const load: PageServerLoad = async () => {
  return {
    title: 'My Page',
    items: await fetchItems()
  };
};

export const actions: Actions = {
  default: async ({ request }) => {
    return { success: true, message: 'Saved successfully' };
  }
};
```

### Error Page

```svelte
<!-- +error.svelte -->
<script lang="ts">
  import { page } from '$app/state';
</script>

<h1>{page.status}: {page.error?.message}</h1>
```

---

## Form Actions Error Handling

SvelteKit distinguishes between validation errors (`fail()`) and unexpected errors (`throw error()`).

### Use fail() for Validation Errors

**WRONG:**
```ts
import { error } from '@sveltejs/kit';

export const actions = {
  default: async ({ request }) => {
    if (!email?.toString().includes('@')) {
      throw error(400, 'Invalid email'); // Shows error page!
    }
  }
};
```

**CORRECT:**
```ts
import { fail } from '@sveltejs/kit';

export const actions = {
  default: async ({ request }) => {
    const data = await request.formData();
    const email = data.get('email')?.toString() ?? '';

    if (!email.includes('@')) {
      return fail(400, {
        error: 'Invalid email address',
        email // Return for repopulation
      });
    }

    return { success: true };
  }
};
```

### Use throw error() for Unexpected Errors

```ts
import { fail, error } from '@sveltejs/kit';

export const actions = {
  default: async ({ request }) => {
    const data = await request.formData();

    // Validation - use fail()
    if (!data.get('title')) {
      return fail(400, { error: 'Title is required' });
    }

    try {
      await database.save(data);
      return { success: true };
    } catch (e) {
      // Unexpected error - use throw
      throw error(500, 'Unable to save. Please try again later.');
    }
  }
};
```

### Structured Validation Responses

```ts
interface FormErrors {
  email?: string;
  password?: string;
}

export const actions = {
  register: async ({ request }) => {
    const data = await request.formData();
    const errors: FormErrors = {};

    if (!email) errors.email = 'Email is required';
    if (password.length < 8) errors.password = 'Password must be at least 8 characters';

    if (Object.keys(errors).length > 0) {
      return fail(400, { errors, values: { email } });
    }

    return { success: true };
  }
};
```

### Handle in Component

```svelte
<script lang="ts">
  import type { PageProps } from './$types';
  import { enhance } from '$app/forms';

  let { form }: PageProps = $props();
</script>

<form method="POST" action="?/register" use:enhance>
  <label>
    Email
    <input name="email" value={form?.values?.email ?? ''} />
    {#if form?.errors?.email}
      <span class="error">{form.errors.email}</span>
    {/if}
  </label>
  <button type="submit">Register</button>
</form>
```

### Error Response Summary

| Situation | Function | Result |
|-----------|----------|--------|
| Missing field | `fail(400, {...})` | Form state preserved |
| Invalid format | `fail(400, {...})` | Form state preserved |
| Not found | `throw error(404, ...)` | Error page |
| Server crash | `throw error(500, ...)` | Error page |
| Auth required | `throw redirect(303, ...)` | Redirect |

---

## SSR State Isolation

Shared server state persists across requests, potentially leaking data between users.

### Dangerous: Module-Level State

**WRONG:**
```ts
// +page.server.ts
let currentUser = null; // SHARED ACROSS ALL REQUESTS!

export const load = async ({ locals }) => {
  currentUser = locals.user; // User B overwrites User A
  return { user: currentUser };
};
```

**CORRECT:**
```ts
export const load = async ({ locals }) => {
  return { user: locals.user }; // Each request gets its own locals
};
```

### Dangerous: Global Stores

**WRONG:**
```ts
// stores.svelte.ts
export const user = $state<User | null>(null); // Server-side singleton!
```

**CORRECT: Use locals and return data from load**
```ts
// +layout.server.ts
export const load = async ({ locals }) => {
  return { user: locals.user };
};
```

### Safe Patterns

**Pattern 1: Use locals**
```ts
// hooks.server.ts
export const handle = async ({ event, resolve }) => {
  event.locals.user = await authenticate(event);
  event.locals.requestId = crypto.randomUUID();
  return resolve(event);
};

// +page.server.ts
export const load = async ({ locals }) => {
  return { user: locals.user };
};
```

**Pattern 2: Context for Component Trees**
```svelte
<!-- +layout.svelte -->
<script lang="ts">
  import { setContext } from 'svelte';
  import type { LayoutProps } from './$types';

  let { data, children }: LayoutProps = $props();

  setContext('user', {
    get current() { return data.user; }
  });
</script>

{@render children()}
```

**Pattern 3: Client-Only State**
```ts
// stores.svelte.ts
import { browser } from '$app/environment';

function createClientStore() {
  if (!browser) return { value: null };
  const state = $state({ value: null });
  return state;
}

export const clientState = createClientStore();
```

### SSR Safety Checklist

- [ ] No module-level `let` variables that store user data
- [ ] No global `$state` that gets set during SSR
- [ ] No singleton service classes with mutable state
- [ ] All user-specific data flows through `locals`
- [ ] All page data comes from load function returns
