# SSR & Hydration

## The Problem

SvelteKit runs on server (SSR) then hydrates in browser. Code using
browser APIs (`window`, `document`, `localStorage`) fails on server.

## Solution: Check for Browser

```typescript
import { browser } from '$app/environment';

// In load function
export const load = async () => {
	const theme = browser ? localStorage.getItem('theme') : 'light';
	return { theme };
};
```

```svelte
<!-- In component -->
<script>
	import { browser } from '$app/environment';
	import { onMount } from 'svelte';

	let data = $state(null);

	// Option 1: Use browser check
	if (browser) {
		data = localStorage.getItem('data');
	}

	// Option 2: Use onMount (only runs in browser)
	onMount(() => {
		data = localStorage.getItem('data');
	});

	// Option 3: Use $effect with browser check
	$effect(() => {
		if (browser) {
			data = localStorage.getItem('data');
		}
	});
</script>
```

## Common Mistakes

### ❌ Using window Without Check

```typescript
// WRONG - fails on server
export const load = async () => {
	const width = window.innerWidth; // ERROR on server
	return { width };
};

// RIGHT
import { browser } from '$app/environment';

export const load = async () => {
	const width = browser ? window.innerWidth : 1024;
	return { width };
};
```

### ❌ Accessing DOM in Load

```typescript
// WRONG
export const load = async () => {
	const el = document.getElementById('root'); // ERROR on server
};

// RIGHT - Do DOM stuff in onMount
export const load = async () => {
	return {};
};
// Then in component:
onMount(() => {
	const el = document.getElementById('root');
});
```

## Disable SSR (Not Recommended)

```typescript
// +page.ts
export const ssr = false; // Disables SSR for this page
```

Only use when absolutely necessary (e.g., heavy Canvas/WebGL).
