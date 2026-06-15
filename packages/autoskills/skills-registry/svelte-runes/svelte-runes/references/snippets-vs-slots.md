# Snippets and Children in Svelte 5

Snippets are reusable chunks of markup. Component children are snippets passed as props and rendered with `{@render ...}`.

## Default Children

```svelte
<!-- Card.svelte -->
<script>
	let { children } = $props();
</script>

<div class="card">
	{@render children()}
</div>
```

```svelte
<!-- Usage -->
<Card>
	<p>This is card content</p>
</Card>
```

## Named Snippets

```svelte
<!-- Layout.svelte -->
<script>
	let { header, footer, children } = $props();
</script>

<div class="layout">
	<header>{@render header()}</header>
	<main>{@render children()}</main>
	<footer>{@render footer()}</footer>
</div>
```

```svelte
<!-- Usage -->
<Layout>
	{#snippet header()}
		Header content
	{/snippet}

	{#snippet footer()}
		Footer content
	{/snippet}

	Main content
</Layout>
```

## Snippet Parameters

```svelte
<!-- List.svelte -->
<script>
	let { items, children } = $props();
</script>

<ul>
	{#each items as item (item.id)}
		<li>{@render children(item)}</li>
	{/each}
</ul>
```

```svelte
<!-- Usage -->
<List items={users}>
	{#snippet children(user)}
		{user.name}
	{/snippet}
</List>
```

Parameters are explicit function arguments and work well with TypeScript.

## Optional Snippets and Fallbacks

```svelte
<script>
	let { header, children } = $props();
</script>

<div class="card">
	<h2>{@render header?.() ?? 'Default Title'}</h2>
	{@render children?.()}
</div>
```

Use optional chaining for snippets that may not be passed.

## Reusable Local Snippets

```svelte
<script>
	let items = $state(['Apple', 'Banana', 'Cherry']);
</script>

{#snippet list_item(text)}
	<li class="item">{text}</li>
{/snippet}

<ul>
	{#each items as item (item)}
		{@render list_item(item)}
	{/each}
</ul>
```

## Exportable Snippets

A top-level snippet that does not reference instance state can be exported from module context.

```svelte
<script module>
	export { icon };
</script>

{#snippet icon(name)}
	<span class="icon icon-{name}" aria-hidden="true"></span>
{/snippet}
```

## Best Practices

- Declare snippets in the template, not inside `<script>`.
- Destructure snippet props with `$props()`.
- Render snippets with `{@render snippet_name(args)}`.
- Use optional chaining for optional snippets.
- Key each blocks with stable identifiers when rendering lists.
- Keep snippets small and focused; extract a component when state/lifecycle grows.

**Last verified:** 2026-05-14
