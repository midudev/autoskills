# Cloudflare Gotchas

## Streaming Broken

**Problem:** Cloudflare may remove `Transfer-Encoding: chunked`
header, breaking HTML streaming in SvelteKit.

**Symptoms:**

- Page loads as one chunk instead of streaming
- `await` blocks don't show progressive loading
- Longer initial page load times

**Workarounds:**

1. **Disable compression** in Cloudflare dashboard (temporary)
2. **Use page rules** to bypass caching for dynamic routes
3. **Switch to Cloudflare Workers** adapter for more control

```javascript
// svelte.config.js
import adapter from '@sveltejs/adapter-cloudflare';

export default {
	kit: {
		adapter: adapter({
			routes: {
				include: ['/*'],
				exclude: ['<all>'],
			},
		}),
	},
};
```

## View Transitions Bug

**Problem:** Same-page view transitions may not work correctly.

**Fix:** Update BOTH SvelteKit AND Svelte to latest versions:

```bash
pnpm add @sveltejs/kit@latest svelte@latest
```

Both packages had related bugs that needed fixing together.

## Environment Variables

Cloudflare uses different env variable handling:

```typescript
// +page.server.ts
export const load = async ({ platform }) => {
	// Access via platform.env, not process.env
	const apiKey = platform?.env?.API_KEY;

	return { data };
};
```

## WebSocket Issues with Bun

**Problem:** Bun's WebSocket module incomplete for Cloudflare Workers.

**Workaround:** Use Node.js or tsx runner instead of Bun for
WebSocket-heavy apps.

## DNS Proxy Settings

If using Cloudflare for DNS only (gray cloud), streaming works
normally. Issues occur when traffic is proxied through Cloudflare
(orange cloud).
