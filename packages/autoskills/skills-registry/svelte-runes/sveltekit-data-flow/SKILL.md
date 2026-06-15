---
name: sveltekit-data-flow
# IMPORTANT: Keep description on ONE line for agent compatibility
# prettier-ignore
description: "SvelteKit data flow guidance. Use when working with load functions, form actions, server/client boundaries, serialization, or invalidation."
metadata:
  last_updated: "2026-06-08"
  verified_against: "Svelte 5/Kit docs and sveltejs/kit#15934"
---

# SvelteKit Data Flow

## Quick Start

**Environment variables:** Prefer explicit env vars (`src/env.ts` + `$app/env/private|public`) when the experimental flag is enabled.

**Which file?** Server-only (DB/secrets): `+page.server.ts` |
Universal (runs both): `+page.ts` | API: `+server.ts`

**Load decision:** Need server resources? → server load | Need client
APIs? → universal load

**Form actions:** Always `+page.server.ts`. Return `fail()` for
errors, throw `redirect()` to navigate, throw `error()` for failures.

## Example

```typescript
// +page.server.ts
import { fail, redirect } from '@sveltejs/kit';

export const load = async ({ locals }) => {
	const user = await db.users.get(locals.userId);
	return { user }; // Must be JSON-serializable
};

export const actions = {
	default: async ({ request }) => {
		const data = await request.formData();
		const email = data.get('email');

		if (!email) return fail(400, { email, missing: true });

		await updateEmail(email);
		throw redirect(303, '/success');
	},
};
```

## Reference Files

- [load-functions.md](references/load-functions.md) - Server vs
  universal
- [form-actions.md](references/form-actions.md) - Form handling
  patterns
- [serialization.md](references/serialization.md) - What can/can't
  serialize
- [error-redirect-handling.md](references/error-redirect-handling.md) -
  fail/redirect/error
- [client-auth-invalidation.md](references/client-auth-invalidation.md) -
  invalidateAll() after client-side auth
- [explicit-environment-variables.md](references/explicit-environment-variables.md) -
  typed, validated env vars

## Notes

- Server load → universal load via `data` param | ALWAYS
  `throw redirect()/error()`
- No class instances/functions from server load (not serializable)
- `$app/env/private` is server-only; only mark genuinely safe values as public
- **Last verified:** 2026-06-08

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
