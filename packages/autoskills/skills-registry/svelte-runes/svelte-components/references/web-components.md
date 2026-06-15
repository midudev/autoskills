# Web Components with Svelte

## Basic Setup

```javascript
// svelte.config.js
export default {
	compilerOptions: {
		customElement: true, // Enable for entire project
	},
};
```

Or per-component:

```svelte
<svelte:options customElement="my-element" />

<script>
	let { name = 'World' } = $props();
</script>

<p>Hello {name}!</p>
```

## Gotchas

### 1. Self-Closing Tags

Svelte 5 requires closing tags. This affects custom elements:

```svelte
<!-- WRONG -->
<my-element />

<!-- RIGHT -->
<my-element></my-element>
```

### 2. Nested HTML in Options

`<option>` with nested HTML causes compiler errors:

```svelte
<!-- WRONG - compiler error -->
<select>
	<option><div>Rich content</div></option>
</select>

<!-- WORKAROUND - use snippets -->
{#snippet optionContent()}
	<div>Rich content</div>
{/snippet}

<select>
	<option>{@render optionContent()}</option>
</select>
```

### 3. Shadow DOM Styling

Styles are scoped to shadow DOM by default:

```svelte
<svelte:options customElement="styled-button" />

<button>
	<slot />
</button>

<style>
	/* Only affects this component's shadow DOM */
	button {
		background: blue;
	}
</style>
```

## Exposing Props as Attributes

```svelte
<svelte:options
	customElement={{
		tag: 'my-counter',
		props: {
			count: { reflect: true, type: 'Number' },
		},
	}}
/>

<script>
	let { count = 0 } = $props();
</script>

<button onclick={() => count++}>{count}</button>
```

## Events

Dispatch custom events:

```svelte
<svelte:options customElement="event-button" />

<script>
	import { createEventDispatcher } from 'svelte';
	const dispatch = createEventDispatcher();
</script>

<button onclick={() => dispatch('clicked', { time: Date.now() })}>
	Click me
</button>
```

```html
<!-- Usage -->
<event-button></event-button>
<script>
	document
		.querySelector('event-button')
		.addEventListener('clicked', (e) => console.log(e.detail));
</script>
```

## Library Distribution

For library authors:

```json
// package.json
{
	"svelte": "./dist/index.js",
	"exports": {
		".": {
			"svelte": "./dist/index.js"
		}
	},
	"keywords": ["svelte"],
	"peerDependencies": {
		"svelte": "^5.0.0"
	}
}
```

**Important:** Always include `svelte` in keywords and
peerDependencies.
