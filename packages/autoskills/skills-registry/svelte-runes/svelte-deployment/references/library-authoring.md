# Library Authoring

## Package.json Setup

```json
{
	"name": "my-svelte-library",
	"version": "1.0.0",
	"svelte": "./dist/index.js",
	"types": "./dist/index.d.ts",
	"exports": {
		".": {
			"types": "./dist/index.d.ts",
			"svelte": "./dist/index.js"
		}
	},
	"files": ["dist"],
	"keywords": ["svelte"],
	"peerDependencies": {
		"svelte": "^5.0.0"
	}
}
```

**Critical:** Include BOTH:

1. `svelte` in `keywords` array
2. `svelte` in `peerDependencies` or `dependencies`

## Using svelte-package

```bash
pnpm add -D @sveltejs/package
```

```json
{
	"scripts": {
		"package": "svelte-kit sync && svelte-package"
	}
}
```

```javascript
// svelte.config.js
import adapter from '@sveltejs/adapter-auto';

export default {
	kit: {
		adapter: adapter(),
	},
	package: {
		source: './src/lib',
		dir: 'dist',
	},
};
```

## Directory Structure

```
my-library/
├── src/
│   └── lib/
│       ├── index.ts          # Main export
│       ├── Button.svelte
│       └── utils.ts
├── package.json
└── svelte.config.js
```

## Exports Pattern

```typescript
// src/lib/index.ts
export { default as Button } from './Button.svelte';
export { default as Input } from './Input.svelte';
export * from './utils.js';
```

## TypeScript Support

```json
// tsconfig.json
{
	"extends": "./.svelte-kit/tsconfig.json",
	"compilerOptions": {
		"declaration": true,
		"declarationDir": "./dist"
	}
}
```

## Publishing Checklist

1. ✅ `svelte` in keywords
2. ✅ `svelte` in peerDependencies
3. ✅ Exports field configured
4. ✅ Types exported
5. ✅ `files` array includes dist/
6. ✅ Test with `pnpm pack` before publishing
