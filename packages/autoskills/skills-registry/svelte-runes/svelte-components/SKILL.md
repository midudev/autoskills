---
name: svelte-components
# IMPORTANT: Keep description on ONE line for agent compatibility
# prettier-ignore
description: "Build Svelte components. Use for Svelte custom elements, component libraries (Bits UI, Ark UI, Melt UI), form patterns, or third-party integration."
metadata:
  last_updated: "2026-05-14"
  verified_against: "Svelte 5 official docs and current local skill refresh"
---

# Svelte Components

## Quick Start

**Component libraries:** Bits UI (headless) | Ark UI | Melt UI
(primitives)

**Form trick:** Use `form` attribute when form can't wrap inputs:

```svelte
<form id="my-form" action="/submit"><!-- outside table --></form>
<table>
	<tr>
		<td><input form="my-form" name="email" /></td>
		<td><button form="my-form">Submit</button></td>
	</tr>
</table>
```

## Web Components

```javascript
// svelte.config.js
export default {
	compilerOptions: {
		customElement: true,
	},
};
```

```svelte
<!-- MyButton.svelte -->
<svelte:options customElement="my-button" />

<!-- Native <slot> is appropriate inside custom elements. -->
<button><slot /></button>
```

## Reference Files

- [component-libraries.md](references/component-libraries.md) - Bits
  UI, Ark UI setup
- [web-components.md](references/web-components.md) - Building custom
  elements
- [form-patterns.md](references/form-patterns.md) - Advanced form
  handling

## Notes

- Bits UI 1.0: flexible, unstyled, accessible components for Svelte
- Form `defaultValue` attribute enables easy form resets
- Use snippets to wrap rich HTML in custom select options
- Use snippets/`{@render}` for normal Svelte component content; native `<slot>` is for custom elements
- **Last verified:** 2026-05-14

<!--
PROGRESSIVE DISCLOSURE GUIDELINES:
- Keep this file ~50 lines total (max ~150 lines)
- Use 1-2 code blocks only (recommend 1)
- Keep description <200 chars for Level 1 efficiency
- Move detailed docs to references/ for Level 3 loading
- This is Level 2 - quick reference ONLY, not a manual
-->
