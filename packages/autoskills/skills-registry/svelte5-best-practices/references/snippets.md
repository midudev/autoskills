# Svelte 5 Snippets Reference

## Table of Contents
- [Replacing Slots with Snippets](#replacing-slots-with-snippets)
- [Rendering with @render](#rendering-with-render)

---

## Replacing Slots with Snippets

Svelte 5 replaces `<slot>` with snippets - a more powerful and type-safe composition primitive.

### Default Content (children)

**Svelte 4:**
```svelte
<div class="card"><slot /></div>
```

**Svelte 5:**
```svelte
<script>
  let { children } = $props();
</script>

<div class="card">{@render children?.()}</div>
```

### Named Slots to Named Snippets

**Svelte 4:**
```svelte
<header><slot name="header" /></header>
<main><slot /></main>
<footer><slot name="footer" /></footer>

<!-- Usage -->
<Layout>
  <h1 slot="header">Title</h1>
  <p>Content</p>
  <span slot="footer">Footer</span>
</Layout>
```

**Svelte 5:**
```svelte
<script>
  let { header, children, footer } = $props();
</script>

<header>{@render header?.()}</header>
<main>{@render children?.()}</main>
<footer>{@render footer?.()}</footer>

<!-- Usage -->
<Layout>
  {#snippet header()}<h1>Title</h1>{/snippet}
  <p>Content</p>
  {#snippet footer()}<span>Footer</span>{/snippet}
</Layout>
```

### Slot Props to Snippet Parameters

**Svelte 4:**
```svelte
<ul>
  {#each items as item}
    <li><slot {item} /></li>
  {/each}
</ul>

<List {items} let:item>
  <span>{item.name}</span>
</List>
```

**Svelte 5:**
```svelte
<script>
  let { items, children } = $props();
</script>

<ul>
  {#each items as item}
    <li>{@render children?.(item)}</li>
  {/each}
</ul>

<List {items}>
  {#snippet children(item)}
    <span>{item.name}</span>
  {/snippet}
</List>
```

### Slot Fallback to Snippet Fallback

```svelte
<script>
  let { children } = $props();
</script>

{#if children}
  {@render children()}
{:else}
  <p>Default content</p>
{/if}
```

### Defining Snippets Within Components

```svelte
<script>
  let items = $state([
    { id: 1, name: 'Item 1', type: 'normal' },
    { id: 2, name: 'Item 2', type: 'featured' }
  ]);
</script>

{#snippet normalItem(item)}
  <li>{item.name}</li>
{/snippet}

{#snippet featuredItem(item)}
  <li class="featured">*** {item.name} ***</li>
{/snippet}

<ul>
  {#each items as item}
    {#if item.type === 'featured'}
      {@render featuredItem(item)}
    {:else}
      {@render normalItem(item)}
    {/if}
  {/each}
</ul>
```

### TypeScript Typing

```svelte
<script lang="ts">
  import type { Snippet } from 'svelte';

  interface Item { id: number; name: string; }

  interface Props {
    header?: Snippet;
    children: Snippet<[item: Item]>;
    footer?: Snippet;
  }

  let { header, children, footer }: Props = $props();
</script>
```

---

## Rendering with @render

Snippets must be rendered using `{@render}`. Optional snippets need null-safe calling.

### Basic Snippet Rendering

```svelte
<script>
  let { children } = $props();
</script>

<div>{@render children()}</div>
```

### Optional Snippets

Always use optional chaining for snippets that might not be provided:

```svelte
<script>
  let { children } = $props();
</script>

{@render children?.()}
```

### Conditional Rendering

```svelte
<script>
  let { header, children, footer } = $props();
</script>

{#if header}
  <header>{@render header()}</header>
{/if}

<main>{@render children?.()}</main>

{#if footer}
  <footer>{@render footer()}</footer>
{/if}
```

### Rendering with Arguments

```svelte
<script>
  let { items, itemTemplate } = $props();
</script>

<ul>
  {#each items as item, index}
    <li>{@render itemTemplate(item, index)}</li>
  {/each}
</ul>

<!-- Usage -->
<List {items}>
  {#snippet itemTemplate(item, index)}
    <span>{index + 1}. {item.name}</span>
  {/snippet}
</List>
```

### Rendering Multiple Times

Snippets can be rendered multiple times:

```svelte
<script>
  let { icon } = $props();
</script>

<button>
  {@render icon?.()}
  <span>Click me</span>
  {@render icon?.()}
</button>
```

### Rendering Dynamic Snippets

```svelte
<script>
  let { normalView, editView, isEditing } = $props();
  let currentView = $derived(isEditing ? editView : normalView);
</script>

{@render currentView?.()}
```

### TypeScript with @render

```svelte
<script lang="ts">
  import type { Snippet } from 'svelte';

  interface Props {
    children: Snippet;
    header?: Snippet;
    row: Snippet<[data: { id: number; name: string }]>;
  }

  let { children, header, row }: Props = $props();
</script>

{@render header?.()}
{@render children()}
{@render row({ id: 1, name: 'Test' })}
```

### Passing Snippets to Child Components

```svelte
<!-- Wrapper.svelte -->
<script>
  import Inner from './Inner.svelte';
  let { itemRenderer } = $props();
</script>

<Inner {itemRenderer} />

<!-- Inner.svelte -->
<script>
  let { itemRenderer } = $props();
</script>

{#each items as item}
  {@render itemRenderer?.(item)}
{/each}
```
