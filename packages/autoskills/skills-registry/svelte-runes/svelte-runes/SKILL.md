---
name: svelte-runes
# IMPORTANT: Keep description on ONE line for agent compatibility
# prettier-ignore
description: "Implement Svelte 5 runes correctly. Use for reactive state, props, effects, $state.raw, $derived.by, $props, and $bindable."
metadata:
  last_updated: "2026-05-14"
  verified_against: "Svelte 5 official docs and current local skill refresh"
---

# Svelte Runes

## Quick Start

**Which rune?** Props: `$props()` | Bindable: `$bindable()` |
Computed: `$derived()` | Side effect: `$effect()` | State: `$state()`

**Key rules:** Runes are top-level only. $derived can be overridden
(use `const` for read-only). Objects/arrays are deeply reactive by
default; use `$state.raw` for large data replaced wholesale.

## Example

```svelte
<script>
	let count = $state(0); // Mutable state
	const doubled = $derived(count * 2); // Computed (const = read-only)

	$effect(() => {
		console.log(`Count is ${count}`); // Side effect
	});
</script>

<button onclick={() => count++}>
	{count} (doubled: {doubled})
</button>
```

## Reference Files

- [reactivity-patterns.md](references/reactivity-patterns.md) - When
  to use each rune
- [component-api.md](references/component-api.md) - $props, $bindable
  patterns
- [snippets-vs-slots.md](references/snippets-vs-slots.md) - New
  snippet syntax
- [common-mistakes.md](references/common-mistakes.md) - Anti-patterns
  with fixes

> For `@attach` and other template directives, see the
> **svelte-template-directives** skill.

## Notes

- Use event properties like `onclick`, and `{@render children()}` in layouts
- `$derived` can be reassigned (5.25+) - use `const` for read-only
- Use `createContext` over `setContext`/`getContext` for type safety
- Use `$inspect.trace` to debug reactivity issues
- Prefer `$derived.by` for multi-line derivations
- Avoid state updates inside `$effect`; effects are an escape hatch
- Effects do not run on the server; don't wrap effect bodies in `if (browser)`
- **Last verified:** 2026-05-14

<!--
PROGRESSIVE DISCLOSURE GUIDELINES:
- Keep this file ~50 lines total (max ~150 lines)
- Use 1-2 code blocks only (recommend 1)
- Keep description <200 chars for Level 1 efficiency
- Move detailed docs to references/ for Level 3 loading
- This is Level 2 - quick reference ONLY, not a manual

LLM WORKFLOW (when editing this file):
1. Write/edit SKILL.md
2. Format (if formatter available)
3. Run: npx skills add . --list
4. If the skill is not discovered, check SKILL.md frontmatter formatting
5. Validate again to confirm
-->
