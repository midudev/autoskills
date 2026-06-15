---
name: svelte-core-bestpractices
# prettier-ignore
description: "Svelte 5 core best practices. Use when creating, editing, or reviewing .svelte, .svelte.ts, or .svelte.js files. Routes to deeper Svelte skills."
metadata:
  last_updated: "2026-05-31"
  verified_against: "Svelte 5 official docs and sveltejs/svelte#18282"
---

<!-- Inspired by the official Svelte AI `svelte-core-bestpractices` skill: https://svelte.dev/docs/ai/skills -->

# Svelte Core Best Practices

Use this as the baseline for any Svelte 5 component/module work, then load the focused skill for details.

## Core Rules

- Use runes mode for new code: `$state`, `$derived`, `$effect`, `$props`, `$bindable`.
- Only use `$state` for values that affect template output, `$derived`, or `$effect`.
- Use `$state.raw` for large objects/arrays that are replaced wholesale, especially API payloads.
- Prefer `$derived`/`$derived.by` over writing state inside `$effect`.
- Treat props as changing over time; derive values from props with `$derived`.
- Use `onclick={...}` and other event properties, not legacy event directives.
- Use snippets and `{@render ...}` for component content.
- Use `{let ...}` / `{const ...}` declaration tags for local markup variables; `{@const ...}` is legacy syntax.
- Use keyed `{#each}` blocks; never use array indexes as keys.
- Use CSS custom properties and `style:` for dynamic styling.
- Prefer class arrays/objects in `class={...}` for conditional classes.
- Use `createContext` for typed context instead of module-level shared state.
- Use `{@attach ...}` for DOM/third-party integrations tied to an element.

## Load Deeper Skills

- Reactivity, props, bindable state → `svelte-runes`
- Snippets, `{@attach}`, global events, each blocks → `svelte-template-directives`
- Scoped CSS, custom properties, classes → `svelte-styling`
- Component libraries, forms, web components → `svelte-components`
- SvelteKit load/actions/routing/errors → `sveltekit-data-flow`, `sveltekit-structure`
- Remote functions → `sveltekit-remote-functions`
- Deployment/build/library/PWA → `svelte-deployment`

## Notes

- Effects do not run on the server; don't wrap effect bodies in `if (browser)`.
- Use `$inspect.trace(label)` to debug unexpected reactivity.
- Async Svelte features require the relevant experimental config.
- **Last verified:** 2026-05-31
