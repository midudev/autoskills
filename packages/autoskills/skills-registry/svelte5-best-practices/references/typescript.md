# Svelte 5 TypeScript Reference

## Table of Contents
- [Props Typing](#props-typing)
- [Generic Components](#generic-components)

---

## Props Typing

`$props()` requires specific patterns for TypeScript typing.

### Basic Props Typing

**Inline typing:**
```svelte
<script lang="ts">
  let { name, count = 0 }: { name: string; count?: number } = $props();
</script>
```

**Interface typing (recommended):**
```svelte
<script lang="ts">
  interface Props {
    name: string;
    count?: number;
    disabled?: boolean;
  }

  let { name, count = 0, disabled = false }: Props = $props();
</script>
```

### Children and Snippets Typing

```svelte
<script lang="ts">
  import type { Snippet } from 'svelte';

  interface Props {
    children: Snippet;                    // Required children
    header?: Snippet;                     // Optional snippet
    row: Snippet<[data: RowData]>;       // Snippet with parameter
    cell?: Snippet<[value: string, index: number]>;  // Multiple params
  }

  interface RowData { id: number; name: string; }

  let { children, header, row, cell }: Props = $props();
</script>
```

### Callback Props Typing

```svelte
<script lang="ts">
  interface Props {
    value: string;
    onchange?: (value: string) => void;
    onsubmit?: (data: FormData) => Promise<void>;
    onclick?: (event: MouseEvent) => void;
  }

  let { value, onchange, onsubmit, onclick }: Props = $props();
</script>
```

### Rest Props with HTML Attributes

```svelte
<script lang="ts">
  import type { HTMLButtonAttributes } from 'svelte/elements';

  interface Props extends HTMLButtonAttributes {
    variant?: 'primary' | 'secondary';
    loading?: boolean;
  }

  let { variant = 'primary', loading = false, ...rest }: Props = $props();
</script>

<button class={variant} disabled={loading} {...rest}>
  {#if loading}Loading...{:else}{@render children?.()}{/if}
</button>
```

### Input Element Props

```svelte
<script lang="ts">
  import type { HTMLInputAttributes } from 'svelte/elements';

  interface Props extends Omit<HTMLInputAttributes, 'value'> {
    value?: string;
    label: string;
    error?: string;
  }

  let { value = $bindable(''), label, error, ...rest }: Props = $props();
</script>
```

### Union Type Props

```svelte
<script lang="ts">
  type ButtonVariant = 'primary' | 'secondary' | 'danger';
  type ButtonSize = 'sm' | 'md' | 'lg';

  interface Props {
    variant?: ButtonVariant;
    size?: ButtonSize;
    children: Snippet;
  }

  let { variant = 'primary', size = 'md', children }: Props = $props();
</script>

<button class="{variant} {size}">{@render children()}</button>
```

### Discriminated Union Props

```svelte
<script lang="ts">
  type Props =
    | { type: 'link'; href: string; children: Snippet }
    | { type: 'button'; onclick: () => void; children: Snippet };

  let props: Props = $props();
</script>

{#if props.type === 'link'}
  <a href={props.href}>{@render props.children()}</a>
{:else}
  <button onclick={props.onclick}>{@render props.children()}</button>
{/if}
```

---

## Generic Components

Svelte 5 uses the `generics` attribute for type-safe reusable components.

### Basic Generic Component

```svelte
<!-- List.svelte -->
<script lang="ts" generics="T">
  interface Props {
    items: T[];
    children: import('svelte').Snippet<[item: T, index: number]>;
  }

  let { items, children }: Props = $props();
</script>

<ul>
  {#each items as item, index}
    <li>{@render children(item, index)}</li>
  {/each}
</ul>

<!-- Usage -->
<script lang="ts">
  import List from './List.svelte';

  interface User { id: number; name: string; }
  let users: User[] = $state([{ id: 1, name: 'Alice' }]);
</script>

<List items={users}>
  {#snippet children(user, index)}
    <span>{index + 1}. {user.name}</span> <!-- Fully typed! -->
  {/snippet}
</List>
```

### Multiple Type Parameters

```svelte
<script lang="ts" generics="K, V">
  interface Props {
    entries: [K, V][];
    renderKey: import('svelte').Snippet<[key: K]>;
    renderValue: import('svelte').Snippet<[value: V]>;
  }

  let { entries, renderKey, renderValue }: Props = $props();
</script>

<dl>
  {#each entries as [key, value]}
    <dt>{@render renderKey(key)}</dt>
    <dd>{@render renderValue(value)}</dd>
  {/each}
</dl>
```

### Constrained Generics

```svelte
<script lang="ts" generics="T extends { id: string | number }">
  interface Props {
    items: T[];
    selected?: T;
    onselect?: (item: T) => void;
    children: import('svelte').Snippet<[item: T, isSelected: boolean]>;
  }

  let { items, selected, onselect, children }: Props = $props();
</script>

{#each items as item}
  <div
    class:selected={selected?.id === item.id}
    onclick={() => onselect?.(item)}
  >
    {@render children(item, selected?.id === item.id)}
  </div>
{/each}
```

### Generic with Default Type

```svelte
<script lang="ts" generics="T = Record<string, unknown>">
  interface Props {
    data: T[];
    columns: (keyof T)[];
  }

  let { data, columns }: Props = $props();
</script>
```

### Generic Select Component

```svelte
<script lang="ts" generics="T">
  interface Props {
    options: T[];
    value?: T;
    getLabel: (option: T) => string;
    getValue: (option: T) => string;
    onchange?: (selected: T | undefined) => void;
    placeholder?: string;
  }

  let {
    options,
    value = $bindable(),
    getLabel,
    getValue,
    onchange,
    placeholder = 'Select...'
  }: Props = $props();

  function handleChange(e: Event) {
    const selectedValue = (e.target as HTMLSelectElement).value;
    const selected = options.find(o => getValue(o) === selectedValue);
    value = selected;
    onchange?.(selected);
  }
</script>

<select onchange={handleChange}>
  <option value="">{placeholder}</option>
  {#each options as option}
    <option
      value={getValue(option)}
      selected={value && getValue(value) === getValue(option)}
    >
      {getLabel(option)}
    </option>
  {/each}
</select>
```

### Generic Async Component

```svelte
<script lang="ts" generics="T">
  import type { Snippet } from 'svelte';

  interface Props {
    promise: Promise<T>;
    loading?: Snippet;
    error?: Snippet<[error: Error]>;
    children: Snippet<[data: T]>;
  }

  let { promise, loading, error, children }: Props = $props();
</script>

{#await promise}
  {#if loading}{@render loading()}{:else}<p>Loading...</p>{/if}
{:then data}
  {@render children(data)}
{:catch err}
  {#if error}{@render error(err)}{:else}<p>Error: {err.message}</p>{/if}
{/await}
```
