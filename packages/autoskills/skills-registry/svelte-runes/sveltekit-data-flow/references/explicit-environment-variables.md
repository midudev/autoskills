# Explicit Environment Variables

Verified against sveltejs/kit#15934 on 2026-06-08.

SvelteKit has an experimental explicit environment variable mode. It replaces implicit `$env/*` imports with a typed, validated registry.

Enable it in Kit config:

```ts
// vite.config.ts
import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';

export default defineConfig({
	plugins: [
		sveltekit({
			experimental: {
				explicitEnvironmentVariables: true
			}
		})
	]
});
```

Define variables in `src/env.ts` or `src/env.js`:

```ts
import { defineEnvVars } from '@sveltejs/kit/hooks';
import * as v from 'valibot';

export const variables = defineEnvVars({
	POSTGRES_URL: {},
	GOOGLE_ANALYTICS_ID: {
		public: true,
		schema: v.pipe(v.string(), v.regex(/G-[A-Z0-9]+/))
	},
	SHOW_DEBUGGING_OVERLAY: {
		public: true,
		static: true,
		description: 'Show an FPS meter in the corner of the page',
		schema: v.pipe(
			v.optional(v.string(), ''),
			v.transform((str) => str !== '')
		)
	}
});
```

Use the generated modules:

```ts
import { POSTGRES_URL } from '$app/env/private';
import { GOOGLE_ANALYTICS_ID } from '$app/env/public';
```

## Rules

- Private variables are server-only; never import `$app/env/private` in client-reachable code.
- Public variables are sent to the client; mark only safe values as `public: true`.
- `static: true` variables are evaluated at build time and can support dead-code elimination.
- Missing variables fail at startup, or at build time for static variables.
- Schemas may use any Standard Schema library (`valibot`, `zod`, `arktype`, etc.).
- Types and hover docs are inferred from the registry.
- This is experimental in Kit 2; the direction for Kit 3 is to remove `$env/*` and `$app/environment` in favor of `$app/env/*`.
