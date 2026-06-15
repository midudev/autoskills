# Form Actions

## Basic Pattern

Form actions live in `+page.server.ts` and handle form submissions:

```typescript
// +page.server.ts
import { fail, redirect } from '@sveltejs/kit';
import type { Actions } from './$types';

export const actions: Actions = {
	default: async ({ request }) => {
		const data = await request.formData();
		const email = data.get('email');
		const password = data.get('password');

		if (!email) {
			return fail(400, { email, missing: true });
		}

		await login(email, password);
		throw redirect(303, '/dashboard');
	},
};
```

```svelte
<!-- +page.svelte -->
<script>
	let { form } = $props(); // Contains return value from action
</script>

<form method="POST">
	<input name="email" value={form?.email ?? ''} />
	{#if form?.missing}
		<p class="error">Email is required</p>
	{/if}

	<button>Login</button>
</form>
```

## Named Actions

```typescript
export const actions: Actions = {
	login: async ({ request }) => {
		// Handle login
	},

	register: async ({ request }) => {
		// Handle registration
	},
};
```

```svelte
<form method="POST" action="?/login">...</form>
<form method="POST" action="?/register">...</form>
```

## Return Values

### Option 1: fail() - Show Error to User

```typescript
import { fail } from '@sveltejs/kit';

export const actions = {
	default: async ({ request }) => {
		const data = await request.formData();

		if (!isValid(data)) {
			return fail(400, {
				error: 'Invalid data',
				fields: Object.fromEntries(data), // Preserve input
			});
		}

		// Success - no return needed
	},
};
```

### Option 2: redirect() - Navigate After Success

```typescript
import { redirect } from '@sveltejs/kit';

export const actions = {
	default: async ({ request }) => {
		await processForm(request);
		throw redirect(303, '/success'); // MUST throw
	},
};
```

### Option 3: error() - Fatal Error

```typescript
import { error } from '@sveltejs/kit';

export const actions = {
	default: async ({ request }) => {
		const user = await getCurrentUser();

		if (!user) {
			throw error(401, 'Unauthorized'); // MUST throw
		}

		// Process...
	},
};
```

## Progressive Enhancement

Form works without JavaScript:

```svelte
<script>
	import { enhance } from '$app/forms';
</script>

<form method="POST" use:enhance>
	<!-- Works with or without JS -->
</form>
```

With custom handling:

```svelte
<form
	method="POST"
	use:enhance={({ formData, cancel }) => {
		// Before submit
		formData.append('timestamp', Date.now().toString());

		return async ({ result, update }) => {
			// After response
			if (result.type === 'success') {
				await update(); // Update form prop
			}
		};
	}}
>
	...
</form>
```

## Validation Pattern

```typescript
import { fail } from '@sveltejs/kit';
import { z } from 'zod';

const schema = z.object({
	email: z.string().email(),
	password: z.string().min(8),
});

export const actions = {
	default: async ({ request }) => {
		const data = await request.formData();
		const rawData = {
			email: data.get('email'),
			password: data.get('password'),
		};

		const result = schema.safeParse(rawData);

		if (!result.success) {
			return fail(400, {
				errors: result.error.flatten().fieldErrors,
				data: rawData,
			});
		}

		// result.data is validated
		await createUser(result.data);
		throw redirect(303, '/welcome');
	},
};
```

## Common Mistakes

### ❌ Not Throwing redirect/error

```typescript
// WRONG
export const actions = {
	default: async () => {
		redirect(303, '/home'); // DOESN'T WORK - must throw
	},
};

// RIGHT
export const actions = {
	default: async () => {
		throw redirect(303, '/home');
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
			console.error(e); // Catches redirect!
		}
	},
};

// RIGHT
export const actions = {
	default: async () => {
		try {
			await doSomething();
			throw redirect(303, '/success');
		} catch (e) {
			if (e instanceof Redirect) throw e; // Rethrow
			console.error(e);
		}
	},
};
```

### ❌ Returning non-serializable data

```typescript
// WRONG
export const actions = {
	default: async () => {
		return { date: new Date() }; // Date is not serializable
	},
};

// RIGHT
export const actions = {
	default: async () => {
		return { date: new Date().toISOString() };
	},
};
```

## File Upload

```typescript
export const actions = {
	default: async ({ request }) => {
		const data = await request.formData();
		const file = data.get('file') as File;

		if (!file || file.size === 0) {
			return fail(400, { error: 'No file uploaded' });
		}

		const bytes = await file.arrayBuffer();
		const buffer = Buffer.from(bytes);

		await saveFile(buffer, file.name);
		throw redirect(303, '/uploads');
	},
};
```

```svelte
<form method="POST" enctype="multipart/form-data">
	<input type="file" name="file" required />
	<button>Upload</button>
</form>
```

## Form Prop in Page

```svelte
<script>
	let { data, form } = $props(); // data from load, form from action
</script>

{#if form?.error}
	<div class="error">{form.error}</div>
{/if}

{#if form?.success}
	<div class="success">Success!</div>
{/if}

<form method="POST">
	<input name="email" value={form?.email ?? data.email ?? ''} />
	{#if form?.errors?.email}
		<p>{form.errors.email}</p>
	{/if}

	<button>Submit</button>
</form>
```

## Key Rules

1. ✅ Actions must be in `+page.server.ts` (not `+page.ts`)
2. ✅ ALWAYS throw `redirect()` and `error()` (not return)
3. ✅ Return `fail()` for validation errors
4. ✅ Return only serializable data
5. ✅ Don't catch redirects/errors without rethrowing
6. ✅ Use `enhance` for progressive enhancement
7. ✅ Access FormData with `data.get('fieldName')`
