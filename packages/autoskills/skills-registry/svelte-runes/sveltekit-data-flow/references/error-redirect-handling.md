# Error & Redirect Handling: fail(), redirect(), error()

## The Three Ways to Handle Failures

| Function     | When             | Must Throw? | Use Case                              |
| ------------ | ---------------- | ----------- | ------------------------------------- |
| `fail()`     | Validation error | No (return) | Form validation errors                |
| `redirect()` | Navigate user    | **YES**     | After successful action               |
| `error()`    | Fatal error      | **YES**     | Unauthorized, not found, server error |

## fail() - Validation Errors

**Return** (don't throw) from form actions to show validation errors:

```typescript
import { fail } from '@sveltejs/kit';

export const actions = {
	default: async ({ request }) => {
		const data = await request.formData();
		const email = data.get('email');

		// Validation failed - return fail()
		if (!email || !email.includes('@')) {
			return fail(400, {
				email,
				error: 'Invalid email',
				missing: !email,
			});
		}

		// Success - process and maybe redirect
		await processEmail(email);
		throw redirect(303, '/success');
	},
};
```

```svelte
<!-- +page.svelte -->
<script>
	let { form } = $props(); // Contains fail() return value
</script>

{#if form?.error}
	<p class="error">{form.error}</p>
{/if}

<form method="POST">
	<input name="email" value={form?.email ?? ''} />

	{#if form?.missing}
		<span>Email is required</span>
	{/if}

	<button>Submit</button>
</form>
```

**Key points:**

- **Return** fail() (don't throw)
- Status code (400 = bad request)
- Return validation errors + form data to repopulate fields
- Accessible via `form` prop in page component
- Page stays on same URL

## redirect() - Navigation

**Throw** redirect() to navigate user to another page:

```typescript
import { redirect } from '@sveltejs/kit';

export const actions = {
	login: async ({ request, cookies }) => {
		const data = await request.formData();

		const user = await authenticate(data);

		if (!user) {
			return fail(401, { error: 'Invalid credentials' });
		}

		cookies.set('session', user.sessionToken, { path: '/' });

		// Success - redirect to dashboard
		throw redirect(303, '/dashboard'); // MUST throw
	},
};
```

**Status codes:**

- `303` - See Other (recommended for POST → GET redirect)
- `301` - Moved Permanently
- `302` - Found (temporary redirect)
- `307` - Temporary Redirect (preserves method)
- `308` - Permanent Redirect (preserves method)

**Use 303** for most cases (especially after form submission).

**Key points:**

- **MUST throw** (not return)
- Use status 303 for form actions
- Can redirect to external URLs
- Can use relative paths: `throw redirect(303, '..')`

## error() - Fatal Errors

**Throw** error() for unrecoverable errors (auth, not found, server
error):

```typescript
import { error } from '@sveltejs/kit';

export const load = async ({ params, locals }) => {
	const post = await db.query.posts.findFirst({
		where: eq(posts.id, params.id),
	});

	if (!post) {
		throw error(404, 'Post not found'); // MUST throw
	}

	if (post.authorId !== locals.userId) {
		throw error(403, 'Forbidden'); // MUST throw
	}

	return { post };
};
```

**Common status codes:**

- `400` - Bad Request
- `401` - Unauthorized (not logged in)
- `403` - Forbidden (logged in but no permission)
- `404` - Not Found
- `500` - Internal Server Error

**With custom error page:**

```typescript
// src/routes/posts/[id]/+page.server.ts
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
<!-- src/routes/posts/[id]/+error.svelte -->
<script>
	import { page } from '$app/stores';
</script>

<h1>{$page.status}: {$page.error.message}</h1>

{#if $page.error.postId}
	<p>Could not find post with ID: {$page.error.postId}</p>
{/if}
```

**Key points:**

- **MUST throw** (not return)
- Renders closest `+error.svelte` file
- Accessible via `$page.status` and `$page.error`
- Stops load function execution
- Use for authorization, not found, server errors

## Common Mistakes

### ❌ Not Throwing redirect()

```typescript
// WRONG
export const actions = {
	default: async () => {
		redirect(303, '/home'); // DOESN'T WORK
	},
};

// RIGHT
export const actions = {
	default: async () => {
		throw redirect(303, '/home'); // MUST throw
	},
};
```

### ❌ Not Throwing error()

```typescript
// WRONG
export const load = async () => {
	error(404, 'Not found'); // DOESN'T WORK
};

// RIGHT
export const load = async () => {
	throw error(404, 'Not found'); // MUST throw
};
```

### ❌ Throwing fail()

```typescript
// WRONG
export const actions = {
	default: async () => {
		throw fail(400, { error: 'Bad' }); // Don't throw
	},
};

// RIGHT
export const actions = {
	default: async () => {
		return fail(400, { error: 'Bad' }); // Return
	},
};
```

### ❌ Catching redirect Without Rethrowing

```typescript
// WRONG
export const actions = {
	default: async () => {
		try {
			await doSomething();
			throw redirect(303, '/success');
		} catch (e) {
			console.error(e); // Catches redirect - it won't work!
			return fail(500, { error: 'Failed' });
		}
	},
};

// RIGHT
import { isRedirect } from '@sveltejs/kit';

export const actions = {
	default: async () => {
		try {
			await doSomething();
			throw redirect(303, '/success');
		} catch (e) {
			if (isRedirect(e)) throw e; // Rethrow redirect
			console.error(e);
			return fail(500, { error: 'Failed' });
		}
	},
};
```

## Decision Tree

```
Problem in form action?
├─ Validation error (show to user) → return fail(400, { errors })
├─ Success (navigate) → throw redirect(303, '/success')
└─ Fatal error (auth, not found) → throw error(403, 'Forbidden')

Problem in load function?
├─ Data not found → throw error(404, 'Not found')
├─ Unauthorized → throw error(401, 'Unauthorized')
├─ Forbidden → throw error(403, 'Forbidden')
└─ Server error → throw error(500, 'Server error')
```

## Patterns

### Pattern 1: Validate, Process, Redirect

```typescript
export const actions = {
	create: async ({ request }) => {
		const data = await request.formData();

		// 1. Validate
		if (!isValid(data)) {
			return fail(400, { errors: getErrors(data) });
		}

		// 2. Process
		const post = await createPost(data);

		// 3. Redirect
		throw redirect(303, `/posts/${post.id}`);
	},
};
```

### Pattern 2: Check Auth, Load Data

```typescript
export const load = async ({ locals, params }) => {
	// 1. Check auth
	if (!locals.user) {
		throw error(401, 'Please log in');
	}

	// 2. Load data
	const post = await getPost(params.id);

	if (!post) {
		throw error(404, 'Post not found');
	}

	// 3. Check permission
	if (post.authorId !== locals.user.id) {
		throw error(403, 'Not your post');
	}

	return { post };
};
```

### Pattern 3: Conditional Redirect

```typescript
export const load = async ({ locals }) => {
	// Redirect if already logged in
	if (locals.user) {
		throw redirect(303, '/dashboard');
	}

	return {}; // Show login page
};
```

## Summary Table

|                      | fail()            | redirect()      | error()         |
| -------------------- | ----------------- | --------------- | --------------- |
| **Throw or return?** | Return            | **Throw**       | **Throw**       |
| **Use in**           | Form actions      | Actions & load  | Actions & load  |
| **Purpose**          | Validation errors | Navigate        | Fatal errors    |
| **Status codes**     | 400-499           | 301-308         | 400-599         |
| **Accessible via**   | `form` prop       | N/A (navigates) | `+error.svelte` |
| **Stays on page?**   | Yes               | No (navigates)  | No (error page) |
| **Example**          | Invalid email     | After save      | Not found       |

## Client-Side Navigation After Auth

When using client-side auth (e.g., Better Auth client), **always use `goto()` with `invalidateAll: true`** to ensure layout data refreshes:

```svelte
<script>
	import { goto } from '$app/navigation';
	import { auth_client } from '$lib/auth-client';

	async function handle_signin() {
		const result = await auth_client.signIn.email({ email, password });

		if (!result.error) {
			// ✅ CORRECT: invalidateAll ensures layout load functions re-run
			await goto('/dashboard', { invalidateAll: true });
		}
	}
</script>
```

### ❌ Common Mistake: Separate invalidateAll + goto

```typescript
// WRONG: Data might not refresh before navigation
await invalidateAll();
goto('/dashboard');

// ALSO WRONG: goto doesn't wait for invalidation
await invalidateAll();
await goto('/dashboard');
```

### ✅ Correct Pattern

```typescript
// RIGHT: Single call with invalidateAll option
await goto('/dashboard', { invalidateAll: true });
```

**Why this matters:** After client-side auth, cookies are set but the root layout's `load` function (which typically checks `auth.api.getSession()`) has cached data. Using `invalidateAll: true` forces all load functions to re-run with the new session cookie.

**Note:** Server-side redirects with `throw redirect()` don't have this problem because they trigger a full page load.

## Quick Checklist

- ✅ Using `return fail()` for validation errors?
- ✅ Using `throw redirect()` (not return) after success?
- ✅ Using `throw error()` (not return) for fatal errors?
- ✅ Not catching redirects/errors without rethrowing?
- ✅ Using status code 303 for POST redirects?
- ✅ Using `goto(url, { invalidateAll: true })` after client-side auth?
