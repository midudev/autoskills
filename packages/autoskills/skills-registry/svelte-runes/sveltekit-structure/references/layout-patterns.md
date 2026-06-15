# Layout Patterns

## Basic Layout

```svelte
<!-- src/routes/+layout.svelte -->
<script>
	let { children } = $props();
</script>

<header>Header</header>
<main>{@render children()}</main>
<footer>Footer</footer>
```

**Key points:**

- Must declare `children` in `$props()`
- Use `{@render children()}` to render nested content
- Root layout wraps ALL pages

## Nested Layouts

Layouts inherit from parent layouts:

```
src/routes/
├── +layout.svelte          # Root layout (all pages)
└── dashboard/
    ├── +layout.svelte      # Dashboard layout (dashboard pages only)
    └── +page.svelte        # Uses both layouts
```

**Result:** Root layout wraps dashboard layout wraps page.

**Rendering order:**

```
Root +layout.svelte
  └─ Dashboard +layout.svelte
      └─ +page.svelte
```

### Example: Nested Layout Pattern

```svelte
<!-- src/routes/+layout.svelte -->
<script>
	let { children } = $props();
</script>

<div class="app">
	<nav>Global Nav</nav>
	{@render children()}
</div>
```

```svelte
<!-- src/routes/dashboard/+layout.svelte -->
<script>
	let { children } = $props();
</script>

<div class="dashboard">
	<aside>Dashboard Sidebar</aside>
	<main>{@render children()}</main>
</div>
```

```svelte
<!-- src/routes/dashboard/+page.svelte --><h1>Dashboard Home</h1>
```

**Rendered HTML structure:**

```html
<div class="app">
	<nav>Global Nav</nav>
	<div class="dashboard">
		<aside>Dashboard Sidebar</aside>
		<main>
			<h1>Dashboard Home</h1>
		</main>
	</div>
</div>
```

## Layout Groups

Use `(groups)` to organize without affecting URLs:

```
src/routes/
├── (marketing)/
│   ├── +layout.svelte      # Marketing layout
│   ├── about/+page.svelte  # /about (uses marketing layout)
│   └── pricing/+page.svelte # /pricing (uses marketing layout)
│
└── (app)/
    ├── +layout.svelte      # App layout
    ├── dashboard/+page.svelte  # /dashboard (uses app layout)
    └── settings/+page.svelte   # /settings (uses app layout)
```

**Key points:**

- Parentheses make groups invisible in URLs
- `/about` route, NOT `/(marketing)/about`
- Different layouts for different sections
- Useful for authentication boundaries

### Example: Marketing vs App Layouts

```svelte
<!-- src/routes/(marketing)/+layout.svelte -->
<script>
	let { children } = $props();
</script>

<header class="marketing-header">
	<nav>
		<a href="/">Home</a>
		<a href="/about">About</a>
		<a href="/login">Login</a>
	</nav>
</header>

{@render children()}

<footer>© 2024 Company</footer>
```

```svelte
<!-- src/routes/(app)/+layout.svelte -->
<script>
	let { children, data } = $props();
</script>

<header class="app-header">
	<nav>
		<a href="/dashboard">Dashboard</a>
		<a href="/settings">Settings</a>
		<span>Welcome, {data.user.name}</span>
	</nav>
</header>

{@render children()}
```

## Reset Layout

Use `@` in filename to break layout inheritance:

**NOT RECOMMENDED** - This feature is deprecated in SvelteKit 2+.

Instead, use layout groups to create separate hierarchies:

```
src/routes/
├── +layout.svelte          # Root layout (for most pages)
├── (app)/
│   └── +layout.svelte      # App layout
└── (public)/
    └── +layout.svelte      # Public layout (completely separate)
```

## Layout with Data Loading

```svelte
<!-- src/routes/+layout.server.ts -->
export const load = async ({ locals }) => {
	// Available to all child routes
	return {
		user: locals.user,
	};
};
```

```svelte
<!-- src/routes/+layout.svelte -->
<script>
	let { children, data } = $props();
</script>

<header>
	{#if data.user}
		<span>Welcome, {data.user.name}</span>
	{:else}
		<a href="/login">Login</a>
	{/if}
</header>

{@render children()}
```

## Conditional Layout Content

```svelte
<!-- +layout.svelte -->
<script>
	import { page } from '$app/stores';
	let { children } = $props();
</script>

{#if !$page.url.pathname.startsWith('/admin')}
	<header>Public Header</header>
{/if}

{@render children()}

{#if !$page.url.pathname.includes('/checkout')}
	<footer>Footer</footer>
{/if}
```

**Better approach:** Use layout groups instead of conditionals.

## Protected Layouts

```typescript
// src/routes/(app)/+layout.server.ts
import { redirect } from '@sveltejs/kit';

export const load = async ({ locals }) => {
	if (!locals.user) {
		throw redirect(303, '/login');
	}

	return {
		user: locals.user,
	};
};
```

All routes under `(app)` group now require authentication.

## Sharing Layout State

```svelte
<!-- src/routes/+layout.svelte -->
<script>
	import { setContext } from 'svelte';
	let { children, data } = $props();

	// Share state with all descendant components
	setContext('user', data.user);
</script>

{@render children()}
```

```svelte
<!-- Any child component -->
<script>
	import { getContext } from 'svelte';
	const user = getContext('user');
</script>

<p>Hello, {user.name}</p>
```

## Layout Slot Props (Snippets)

```svelte
<!-- src/routes/dashboard/+layout.svelte -->
<script>
	let { children, header } = $props();
</script>

<div class="dashboard">
	<aside>Sidebar</aside>
	<div class="content">
		{#if header}
			<header>{@render header()}</header>
		{/if}
		<main>{@render children()}</main>
	</div>
</div>
```

```svelte
<!-- src/routes/dashboard/+page.svelte -->
{#snippet header()}
	<h1>Custom Dashboard Header</h1>
{/snippet}

<p>Dashboard content</p>
```

## Common Patterns

### Pattern 1: Auth Boundary

```
src/routes/
├── +layout.svelte           # Root (no auth)
├── (public)/
│   ├── +layout.svelte       # Public layout (landing pages)
│   ├── +page.svelte         # /
│   └── about/+page.svelte   # /about
└── (protected)/
    ├── +layout.server.ts    # Check auth, redirect if not logged in
    ├── +layout.svelte       # Protected layout (app UI)
    ├── dashboard/+page.svelte  # /dashboard
    └── settings/+page.svelte   # /settings
```

### Pattern 2: Multi-tenant with Shared Root

```
src/routes/
├── +layout.svelte           # Root layout (shared)
├── admin/
│   ├── +layout.svelte       # Admin layout
│   └── users/+page.svelte   # /admin/users
└── client/
    ├── +layout.svelte       # Client layout
    └── projects/+page.svelte # /client/projects
```

### Pattern 3: Progressive Enhancement

```svelte
<!-- src/routes/+layout.svelte -->
<script>
	import { page } from '$app/stores';
	import { navigating } from '$app/stores';
	let { children } = $props();
</script>

<div class="app">
	{#if $navigating}
		<div class="loading-bar"></div>
	{/if}

	{@render children()}
</div>

<style>
	.loading-bar {
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 3px;
		background: blue;
		animation: loading 1s ease-in-out;
	}
</style>
```

## Layout Best Practices

1. ✅ Keep root layout minimal (shared across ALL pages)
2. ✅ Use layout groups for separate sections
3. ✅ Load shared data in layout's load function
4. ✅ Use context for sharing state with descendants
5. ✅ Avoid too many nested layouts (max 2-3 levels)
6. ✅ Don't put auth logic in root layout (use groups)
7. ✅ Remember: layouts share data DOWN, not UP
8. ❌ Avoid conditionals in layouts (use groups instead)

## Debugging Layouts

```svelte
<!-- src/routes/+layout.svelte -->
<script>
	import { page } from '$app/stores';
	let { children } = $props();

	$effect(() => {
		console.log('Current route:', $page.url.pathname);
		console.log('Layout data:', $page.data);
	});
</script>

{@render children()}
```

## Key Takeaways

- Layouts wrap all child routes
- Nested layouts create hierarchy (root → section → page)
- Groups `(name)` organize without affecting URLs
- Load data in `+layout.server.ts` to share with children
- Use context to share reactive state
- Keep layouts simple and focused
