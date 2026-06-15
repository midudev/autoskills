---
name: svelte-styling
# IMPORTANT: Keep description on ONE line for agent compatibility
# prettier-ignore
description: "Svelte CSS styling patterns. Use for scoped styles, CSS custom properties, style: directive, :global, or styling child components."
metadata:
  last_updated: "2026-05-14"
  verified_against: "Svelte 5 official docs and current local skill refresh"
---

# Svelte Styling

## Quick Start

**JS vars in CSS:** Use `style:` directive to set CSS custom properties
from JavaScript.

```svelte
<script>
	let columns = $state(3);
</script>

<div style:--columns={columns}>
	{@render children()}
</div>

<style>
	div {
		display: grid;
		grid-template-columns: repeat(var(--columns), 1fr);
	}
</style>
```

## Styling Child Components

**Preferred:** Pass CSS custom properties as component props:

```svelte
<!-- Parent.svelte -->
<Child --color="red" --spacing="1rem" />

<!-- Child.svelte -->
<h1>Hello</h1>

<style>
	h1 {
		color: var(--color, blue);
		margin: var(--spacing, 0);
	}
</style>
```

**Fallback:** Use `:global` when custom properties aren't possible
(e.g., library components):

```svelte
<div>
	<LibraryComponent />
</div>

<style>
	div :global {
		h1 { color: red; }
	}
</style>
```

## Reference Files

- [styling-patterns.md](references/styling-patterns.md) - Complete CSS
  patterns and techniques

## Notes

- All `<style>` blocks are scoped to the component by default
- Use `style:` directive, not inline style strings, for dynamic values
- Prefer CSS custom properties over `:global` for child styling
- Prefer class arrays/objects in `class={...}` for conditional classes
- **Last verified:** 2026-05-14

<!--
PROGRESSIVE DISCLOSURE GUIDELINES:
- Keep this file ~50 lines total (max ~150 lines)
- Use 1-2 code blocks only (recommend 1)
- Keep description <200 chars for Level 1 efficiency
- Move detailed docs to references/ for Level 3 loading
- This is Level 2 - quick reference ONLY, not a manual
-->
