---
name: svelte-deployment
# IMPORTANT: Keep description on ONE line for agent compatibility
# prettier-ignore
description: "Svelte deployment guidance. Use for adapters, Vite config, pnpm setup, library authoring, PWA, or production builds."
metadata:
  last_updated: "2026-06-08"
  verified_against: "Svelte 5/Kit docs, sveltejs/kit#15934, SvelteKit Vite-plugin config post"
---

# Svelte Deployment

## Quick Start

**SvelteKit config:** Prefer putting Kit options in `vite.config.ts` via `sveltekit({ ... })`. `svelte.config.js` is optional in Kit 2 and will not be read by Kit 3.

**pnpm 10+:** Add prepare script (postinstall disabled by default):

```json
{
	"scripts": {
		"prepare": "svelte-kit sync"
	}
}
```

**Vite config example:**

```ts
// vite.config.ts
import { sveltekit } from '@sveltejs/kit/vite';
import adapter from '@sveltejs/adapter-vercel';
import { defineConfig } from 'vite';

export default defineConfig({
	plugins: [
		sveltekit({
			adapter: adapter(),
			compilerOptions: { experimental: { async: true } },
			experimental: { remoteFunctions: true }
		})
	]
});
```

## Adapters

```bash
# Static site
pnpm add -D @sveltejs/adapter-static

# Node server
pnpm add -D @sveltejs/adapter-node

# Cloudflare
pnpm add -D @sveltejs/adapter-cloudflare
```

## Reference Files

- [library-authoring.md](references/library-authoring.md) - Publishing
  Svelte packages
- [pwa-setup.md](references/pwa-setup.md) - Offline-first with workbox
- [cloudflare-gotchas.md](references/cloudflare-gotchas.md) -
  Streaming issues

## Notes

- Cloudflare may strip `Transfer-Encoding: chunked` (breaks streaming)
- Library authors: include `svelte` in keywords AND peerDependencies
- Single-file bundle: `kit.output.bundleStrategy: 'single'`
- VS Code/svelte-check/SvelteKit can read Kit config from the Vite plugin via `@sveltejs/load-config`.
- **Last verified:** 2026-06-08

<!--
PROGRESSIVE DISCLOSURE GUIDELINES:
- Keep this file ~50 lines total (max ~150 lines)
- Use 1-2 code blocks only (recommend 1)
- Keep description <200 chars for Level 1 efficiency
- Move detailed docs to references/ for Level 3 loading
- This is Level 2 - quick reference ONLY, not a manual
-->
