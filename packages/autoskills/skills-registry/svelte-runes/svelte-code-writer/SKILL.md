---
name: svelte-code-writer
# prettier-ignore
description: "Svelte code writing and validation workflow. Use when creating, editing, reviewing, or debugging .svelte, .svelte.ts, or .svelte.js files."
metadata:
  last_updated: "2026-05-14"
  verified_against: "Svelte 5 official skills and current local skill refresh"
---

<!-- Inspired by the official Svelte AI `svelte-code-writer` skill: https://svelte.dev/docs/ai/skills -->

# Svelte Code Writer

Use this workflow when creating, editing, reviewing, or debugging Svelte files.

## Workflow

1. Load `svelte-core-bestpractices` for baseline Svelte 5 rules.
2. Load deeper local skills as needed: `svelte-runes`, `svelte-template-directives`, `svelte-styling`, `sveltekit-data-flow`, or `sveltekit-structure`.
3. Check relevant official docs when syntax or behavior is uncertain.
4. Validate changed Svelte files before finalizing.

## Official Svelte CLI Helpers

List documentation sections:

```bash
npx @sveltejs/mcp list-sections
```

Fetch relevant documentation sections:

```bash
npx @sveltejs/mcp get-documentation "$state,$derived,$effect"
```

Analyze a Svelte file:

```bash
npx @sveltejs/mcp svelte-autofixer ./src/lib/Component.svelte
```

If a project uses async Svelte features, include `--async`:

```bash
npx @sveltejs/mcp svelte-autofixer ./src/lib/Component.svelte --async
```

## Notes

- Prefer checking docs for exact syntax over guessing.
- Escape `$` when passing inline rune code through a shell.
- Run validation on every changed `.svelte`, `.svelte.ts`, and `.svelte.js` file when practical.
- **Last verified:** 2026-05-14
