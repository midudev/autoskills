# Error Handling

## Error Boundary Placement

**Key rule:** `+error.svelte` must be _above_ the failing route in the
hierarchy.

```
src/routes/
├── +error.svelte           # Catches errors in all routes below
├── +page.svelte            # If this errors → uses +error.svelte above
└── admin/
    ├── +error.svelte       # Catches errors in admin routes
    └── +page.svelte        # If this errors → uses admin/+error.svelte
```

**Wrong:**

```
src/routes/dashboard/
├── +layout.svelte          # If this errors...
└── +error.svelte           # This won't catch it (too low)
```

**Right:**

```
src/routes/
├── +error.svelte           # Catches dashboard layout errors
└── dashboard/
    ├── +layout.svelte
    └── +error.svelte       # Catches dashboard page errors
```

## Error Propagation

Errors bubble up to the nearest `+error.svelte`:

```
src/routes/
├── +error.svelte                    # Level 1 (root fallback)
└── blog/
    ├── +error.svelte                # Level 2 (blog fallback)
    └── [slug]/
        ├── +layout.server.ts        # Error here → blog/+error.svelte
        ├── +page.server.ts          # Error here → blog/+error.svelte
        └── +page.svelte             # Error here → blog/+error.svelte
```

**If no error boundary exists at that level, it goes to the parent.**

## Basic Error Page

```svelte
<!-- +error.svelte -->
<script>
	import { page } from '$app/stores';
</script>

<h1>{$page.status}</h1><p>{$page.error.message}</p>
```

## Custom Error Data

```typescript
// +page.server.ts
import { error } from '@sveltejs/kit';

export const load = async ({ params }) => {
	const post = await getPost(params.id);

	if (!post) {
		throw error(404, {
			message: 'Post not found',
			postId: params.id,
		});
	}

	return { post };
};
```

```svelte
<!-- +error.svelte -->
<script>
	import { page } from '$app/stores';
</script>

<h1>{$page.status}</h1>
<p>{$page.error.message}</p>

{#if $page.error.postId}
	<p>Could not find post with ID: {$page.error.postId}</p>
{/if}
```

## Status Code Specific Errors

```svelte
<!-- +error.svelte -->
<script>
	import { page } from '$app/stores';
</script>

{#if $page.status === 404}
	<h1>Page Not Found</h1>
	<p>The page you're looking for doesn't exist.</p>
	<a href="/">Go home</a>
{:else if $page.status === 403}
	<h1>Access Denied</h1>
	<p>You don't have permission to view this page.</p>
{:else if $page.status === 401}
	<h1>Unauthorized</h1>
	<p>Please log in to continue.</p>
	<a href="/login">Login</a>
{:else if $page.status >= 500}
	<h1>Server Error</h1>
	<p>Something went wrong on our end. Please try again later.</p>
{:else}
	<h1>Error {$page.status}</h1>
	<p>{$page.error.message}</p>
{/if}
```

## Common Status Codes

- **400** - Bad Request (malformed request)
- **401** - Unauthorized (not logged in)
- **403** - Forbidden (logged in but no permission)
- **404** - Not Found (resource doesn't exist)
- **500** - Internal Server Error (unhandled exception)
- **503** - Service Unavailable (server overloaded/down)

## Error in Layout vs Page

**Layout error:**

```typescript
// src/routes/dashboard/+layout.server.ts
export const load = async ({ locals }) => {
	if (!locals.user) {
		throw error(401, 'Not logged in'); // Caught by +error.svelte ABOVE dashboard
	}
	return { user: locals.user };
};
```

**Page error:**

```typescript
// src/routes/dashboard/settings/+page.server.ts
export const load = async () => {
	throw error(404, 'Settings not found'); // Caught by nearest +error.svelte
};
```

## Expected Errors vs Unexpected Errors

**Expected (use error()):**

```typescript
// User requests invalid resource
if (!post) throw error(404, 'Post not found');

// User lacks permission
if (post.authorId !== user.id) throw error(403, 'Not your post');
```

**Unexpected (let it bubble):**

```typescript
// Unhandled exceptions (DB connection fails, etc.)
// Will show generic 500 error
const posts = await db.query.posts.findMany(); // Might throw
```

## Handling Errors in handleError Hook

```typescript
// src/hooks.server.ts
import type { HandleServerError } from '@sveltejs/kit';

export const handleError: HandleServerError = ({ error, event }) => {
	// Log to error tracking service
	console.error('Error:', error, 'Path:', event.url.pathname);

	// Return user-friendly message (don't expose internals)
	return {
		message: 'An unexpected error occurred',
		code: error?.code ?? 'UNKNOWN',
	};
};
```

## Error in Load vs Error in Component

**Load function error (recommended):**

```typescript
// +page.server.ts
export const load = async ({ params }) => {
	const user = await getUser(params.id);
	if (!user) throw error(404, 'User not found'); // Shows +error.svelte
	return { user };
};
```

**Component error (not ideal):**

```svelte
<!-- +page.svelte - Don't do this -->
<script>
	let { data } = $props();

	// If data.user is undefined, component just shows nothing
	// No error boundary triggered
</script>

<h1>{data.user.name}</h1> <!-- Might crash if user undefined -->
```

**Best practice:** Validate and throw errors in `load` functions, not
components.

## Fallback Error Handling

Always have a root `+error.svelte`:

```svelte
<!-- src/routes/+error.svelte -->
<script>
	import { page } from '$app/stores';
	import { dev } from '$app/environment';
</script>

<h1>Oops! Something went wrong</h1>

{#if dev}
	<!-- Show details in dev mode -->
	<pre>{JSON.stringify($page.error, null, 2)}</pre>
{:else}
	<!-- Generic message in production -->
	<p>We're sorry, but something unexpected happened.</p>
{/if}

<a href="/">Go home</a>
```

## Testing Error Boundaries

```typescript
// +page.server.ts
export const load = async ({ url }) => {
	// Test error page in dev
	if (url.searchParams.has('test-error')) {
		throw error(500, 'Test error');
	}

	return {};
};
```

Visit `http://localhost:5173/page?test-error` to see error boundary.

## Key Takeaways

1. ✅ Place `+error.svelte` ABOVE failing routes
2. ✅ Errors bubble up to nearest error boundary
3. ✅ Always have a root `src/routes/+error.svelte`
4. ✅ Throw errors in `load` functions, not components
5. ✅ Use specific status codes (401, 403, 404, 500)
6. ✅ Customize error pages per section (blog, admin, etc.)
7. ✅ Use `handleError` hook for logging/monitoring
8. ✅ Show detailed errors in dev, generic in production
