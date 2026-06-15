# Other Template Directives

## {@html ...}

Renders raw HTML strings. **Use with caution** - never render untrusted content.

```svelte
<script>
	let htmlContent = '<strong>Bold</strong> and <em>italic</em>';
</script>

{@html htmlContent}
```

### Security Warning

Always sanitize user-provided HTML:

```svelte
<script>
	import DOMPurify from 'dompurify';

	let userContent = $state('');
	const sanitized = $derived(DOMPurify.sanitize(userContent));
</script>

{@html sanitized}
```

### Common Use Cases

- Rendering markdown converted to HTML
- CMS content with formatting
- Syntax-highlighted code blocks

## {@render ...}

Renders snippets - Svelte 5's replacement for slots.

```svelte
<script>
	let { header, children } = $props();
</script>

<div class="card">
	{#if header}
		<header>{@render header()}</header>
	{/if}
	<main>{@render children?.()}</main>
</div>
```

### With Parameters

Snippets can receive parameters:

```svelte
<script>
	let { row } = $props();
	let items = $state([{ name: 'Apple' }, { name: 'Banana' }]);
</script>

{#each items as item}
	{@render row(item)}
{/each}
```

```svelte
<!-- Usage -->
<List>
	{#snippet row(item)}
		<li>{item.name}</li>
	{/snippet}
</List>
```

### Optional Snippets

Use optional chaining for optional snippets:

```svelte
{@render footer?.()}
```

## Declaration tags: `{let ...}` / `{const ...}`

Declares local variables within markup. Useful in `{#each}` and `{#if}`.
Use `let` or `const` only; `var`, `function`, and trailing semicolons are invalid.
`{@const ...}` is legacy syntax.

```svelte
{#each items as item}
	{const full_name = `${item.first_name} ${item.last_name}`}
	{const is_long_name = full_name.length > 20}

	<div class={[{ truncate: is_long_name }]}>
		{full_name}
	</div>
{/each}
```

### Why Use Declaration Tags?

- Avoids recalculating values multiple times in a block
- Makes complex expressions more readable
- Scoped to the block - doesn't pollute component scope

## {@debug ...}

Pauses execution and opens devtools when specified values change.

```svelte
<script>
	let count = $state(0);
	let items = $state([]);
</script>

{@debug count, items}

<button onclick={() => count++}>Increment</button>
```

### Tips

- Remove `{@debug}` before production
- Use with specific variables, not entire objects
- Combine with browser devtools for best debugging experience

### Debug Without Variables

```svelte
{@debug}
```

Pauses on every update (rarely useful, but available).

## Keyed Each Blocks

Per official Svelte best practices: always use keyed each blocks for
better performance.

### Basic Keyed Each

```svelte
{#each items as item (item.id)}
	<div>{item.name}</div>
{/each}
```

**Key must uniquely identify the object.** Do NOT use the index:

```svelte
<!-- WRONG - index as key -->
{#each items as item, i (i)}
	<div>{item.name}</div>
{/each}

<!-- RIGHT - unique identifier -->
{#each items as item (item.id)}
	<div>{item.name}</div>
{/each}
```

### Why Keys Matter

Without keys, Svelte updates existing DOM nodes in place when the array
changes. With keys, Svelte can surgically insert, remove, or reorder
items instead.

**Without key:** Removing item 2 from [A, B, C] updates node 2 to show
C's data and removes the last node.

**With key:** Removing item B actually removes B's DOM node, leaving A
and C untouched.

### Avoid Destructuring with bind

Per best practices: avoid destructuring if you need to mutate the item.

```svelte
<!-- WRONG - destructured value is disconnected from original -->
{#each items as { count } (item.id)}
	<input bind:value={count} /> <!-- Won't update the original item -->
{/each}

<!-- RIGHT - reference the item directly -->
{#each items as item (item.id)}
	<input bind:value={item.count} /> <!-- Updates the original -->
{/each}
```

## Window and Document Events

Per official best practices: use `<svelte:window>` and
`<svelte:document>` for window/document event listeners. Avoid
`onMount` or `$effect` for this.

```svelte
<svelte:window onkeydown={handleKeydown} onscroll={handleScroll} />
<svelte:document onvisibilitychange={handleVisibility} />
```

### Common Events

```svelte
<!-- Keyboard shortcuts -->
<svelte:window onkeydown={(e) => {
	if (e.key === 'Escape') closeModal();
	if (e.ctrlKey && e.key === 's') { e.preventDefault(); save(); }
}} />

<!-- Online/offline detection -->
<svelte:window ononline={() => status = 'online'} onoffline={() => status = 'offline'} />

<!-- Responsive design -->
<svelte:window
	bind:innerWidth={width}
	bind:innerHeight={height}
/>
```

### Bindable Window Properties

```svelte
<svelte:window
	bind:innerWidth
	bind:innerHeight
	bind:scrollX
	bind:scrollY
	bind:online
/>
```

**Why not $effect:** `<svelte:window>` automatically cleans up listeners
when the component is destroyed. No manual cleanup needed.
