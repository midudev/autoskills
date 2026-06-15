# PWA Setup with SvelteKit

## Basic PWA with Workbox

```bash
pnpm add -D workbox-precaching
```

### Service Worker

```typescript
// src/service-worker.ts
/// <reference lib="webworker" />
import { precacheAndRoute } from 'workbox-precaching';

declare const self: ServiceWorkerGlobalScope;

precacheAndRoute(self.__WB_MANIFEST);
```

### Manifest

```json
// static/manifest.json
{
	"name": "My App",
	"short_name": "App",
	"start_url": "/",
	"display": "standalone",
	"background_color": "#ffffff",
	"theme_color": "#ff3e00",
	"icons": [
		{
			"src": "/icon-192.png",
			"sizes": "192x192",
			"type": "image/png"
		},
		{
			"src": "/icon-512.png",
			"sizes": "512x512",
			"type": "image/png"
		}
	]
}
```

### HTML Head

```svelte
<!-- src/app.html -->
<head>
	<link rel="manifest" href="/manifest.json" />
	<meta name="theme-color" content="#ff3e00" />
	<link rel="apple-touch-icon" href="/icon-192.png" />
</head>
```

### SvelteKit Config

```javascript
// svelte.config.js
import adapter from '@sveltejs/adapter-static';

export default {
	kit: {
		adapter: adapter({
			fallback: 'index.html',
		}),
		serviceWorker: {
			register: true,
		},
	},
};
```

## Offline-First Strategy

```typescript
// src/service-worker.ts
import { precacheAndRoute } from 'workbox-precaching';
import { registerRoute } from 'workbox-routing';
import { NetworkFirst, CacheFirst } from 'workbox-strategies';

declare const self: ServiceWorkerGlobalScope;

// Precache static assets
precacheAndRoute(self.__WB_MANIFEST);

// Cache API responses
registerRoute(
	({ url }) => url.pathname.startsWith('/api/'),
	new NetworkFirst({
		cacheName: 'api-cache',
	}),
);

// Cache images
registerRoute(
	({ request }) => request.destination === 'image',
	new CacheFirst({
		cacheName: 'image-cache',
	}),
);
```

## Testing PWA

1. Build: `pnpm build`
2. Preview: `pnpm preview`
3. Open DevTools → Application → Service Workers
4. Check "Offline" to test offline behavior
