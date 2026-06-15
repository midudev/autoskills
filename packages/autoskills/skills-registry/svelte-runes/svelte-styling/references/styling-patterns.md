# Svelte CSS Styling Patterns

## Scoped Styles

All CSS in `<style>` is scoped to the component automatically. Svelte adds unique class selectors at compile time.

```svelte
<h1>Hello</h1>

<style>
	h1 {
		color: blue;
	}
</style>
```

## `style:` Directive

Set individual CSS properties dynamically. Prefer this over inline style strings.

```svelte
<script>
	let color = $state('red');
	let size = $state(16);
</script>

<p style:color style:font-size="{size}px">Styled text</p>

<div style:--theme-color={color} style:--columns={3}>
	{@render children()}
</div>

<style>
	div {
		background: var(--theme-color);
		grid-template-columns: repeat(var(--columns), 1fr);
	}
</style>
```

**Why:** `style:` directives are type-checked, support shorthand, and merge cleanly with static styles.

## CSS Custom Properties for Child Components

The preferred way to style child components from a parent is to pass CSS custom properties.

```svelte
<!-- Parent.svelte -->
<Card --bg="navy" --text="white" --radius="8px" />

<!-- Card.svelte -->
<script>
	let { children } = $props();
</script>

<div class="card">
	{@render children()}
</div>

<style>
	.card {
		background: var(--bg, #fff);
		color: var(--text, #000);
		border-radius: var(--radius, 4px);
	}
</style>
```

## `:global` Selectors

Use global selectors sparingly. Prefer scoped `:global` inside a parent selector.

```svelte
<div class="wrapper">
	<LibraryComponent />
</div>

<style>
	.wrapper :global {
		h1 {
			color: red;
		}
		.library-class {
			padding: 1rem;
		}
	}
</style>
```

Avoid broad global selectors unless you are intentionally writing app-level CSS.

## Conditional Classes

Prefer class arrays/objects in the `class` attribute for conditional classes.

```svelte
<script>
	import clsx from 'clsx';

	let active = $state(false);
	let enabled = $state(true);
</script>

<button
	class={clsx('button', { active, disabled: !enabled })}
	onclick={() => active = !active}
>
	Toggle
</button>
```

You can also use arrays/objects directly where your tooling supports Svelte's class value handling:

```svelte
<div class={['card', { selected, disabled: !enabled }]}>...</div>
```

## Dynamic Styling Pattern

```svelte
<script>
	let dark = $state(false);
</script>

<div class={['panel', { dark }]} style:--bg={dark ? '#1a1a1a' : '#fff'}>
	{@render children()}
</div>

<style>
	.panel {
		background: var(--bg);
		transition: background 0.3s;
	}
</style>
```

## Best Practices Summary

1. **Scoped by default** — component `<style>` only affects that component
2. **Use `style:`** — not inline style strings for dynamic values
3. **Use CSS custom properties** — preferred for styling child components
4. **Scope `:global`** — wrap in a parent selector when possible
5. **Use class arrays/objects** — preferred for conditional classes
6. **Avoid broad `:global`** — it can leak styles across the app

**Last verified:** 2026-05-14
