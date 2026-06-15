---
name: svelte-template-directives
# prettier-ignore
description: "Svelte template directive guidance. Use when working with snippets, attachments, dynamic HTML, declaration tags, debugging tags, or global DOM events."
metadata:
  last_updated: "2026-05-31"
  verified_against: "Svelte 5 official docs and sveltejs/svelte#18282"
---

# Svelte Template Directives

## @attach (Svelte 5.29+)

**The reactive alternative to `use:` actions.** Re-runs when dependencies
change, passes through components via spread, supports cleanup functions.

```svelte
<script>
	import ImageZoom from 'js-image-zoom';

	function useZoom(options) {
		return (element) => {
			new ImageZoom(element, options);
			return () => console.log('cleanup');
		};
	}
</script>

<!-- Re-runs if options changes (use: wouldn't!) -->
<figure {@attach useZoom({ width: 400 })}>
	<img src="photo.jpg" alt="zoomable" />
</figure>
```

## Quick Reference

| Directive                   | Purpose                        | Reactive? |
| --------------------------- | ------------------------------ | --------- |
| `{@attach}`                 | DOM manipulation, 3rd-party    | Yes       |
| `{@html}`                   | Render raw HTML strings        | Yes       |
| `{@render}`                 | Render snippets                | Yes       |
| `{let ...}` / `{const ...}` | Local declarations in markup   | N/A       |
| `{@debug}`                  | Pause debugger on value change | N/A       |
| `{#each (key)}`             | Keyed iteration (always key!)  | Yes       |
| `<svelte:window>`           | Window event listeners         | N/A       |

## @attach vs use: Actions

| Feature               | `use:`  | `@attach`           |
| --------------------- | ------- | ------------------- |
| Re-runs on arg change | No      | **Yes**             |
| Composable            | Limited | **Fully**           |
| Pass through props    | Manual  | **Auto via spread** |
| Convert legacy        | N/A     | `fromAction()`      |

## Reference Files

- [attach-patterns.md](references/attach-patterns.md) - Real-world @attach
  examples
- [other-directives.md](references/other-directives.md) - @html, @render,
  declaration tags, @debug

## Notes

- `@attach` requires Svelte 5.29+
- Use `fromAction` from `svelte/attachments` to convert legacy actions
- Attachments pass through wrapper components when you spread props
- Always use keyed each blocks — never use index as key
- Use `<svelte:window>`/`<svelte:document>` for global events, not `$effect`
- Use `{const ...}` / `{let ...}` declaration tags for local markup variables; `{@const ...}` is legacy syntax.
- **Last verified:** 2026-05-31

<!--
PROGRESSIVE DISCLOSURE GUIDELINES:
- Keep this file ~50 lines total (max ~150 lines)
- Use 1-2 code blocks only (recommend 1)
- Keep description <200 chars for Level 1 efficiency
- Move detailed docs to references/ for Level 3 loading
- This is Level 2 - quick reference ONLY, not a manual
-->
