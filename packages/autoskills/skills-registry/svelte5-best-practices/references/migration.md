# Svelte 4 to Svelte 5 Migration Reference

## Table of Contents
- [Migrating Reactive Statements](#migrating-reactive-statements)
- [Migrating Stores to Runes](#migrating-stores-to-runes)

---

## Migrating Reactive Statements

Svelte 5 replaces `$:` with `$derived` (for values) and `$effect` (for side effects).

### Computed Values: $: to $derived

**Svelte 4:**
```svelte
<script>
  let count = 0;
  $: doubled = count * 2;
  $: quadrupled = doubled * 2;
</script>
```

**Svelte 5:**
```svelte
<script>
  let count = $state(0);
  let doubled = $derived(count * 2);
  let quadrupled = $derived(doubled * 2);
</script>
```

### Complex Computed Values: $derived.by

**Svelte 4:**
```svelte
<script>
  let items = [];
  let filter = 'all';

  $: filteredItems = {
    if (filter === 'all') return items;
    if (filter === 'active') return items.filter(i => !i.done);
    return items.filter(i => i.done);
  };
</script>
```

**Svelte 5:**
```svelte
<script>
  let items = $state([]);
  let filter = $state('all');

  let filteredItems = $derived.by(() => {
    if (filter === 'all') return items;
    if (filter === 'active') return items.filter(i => !i.done);
    return items.filter(i => i.done);
  });
</script>
```

### Side Effects: $: to $effect

**Svelte 4:**
```svelte
<script>
  let count = 0;
  $: console.log('Count changed:', count);
  $: document.title = `Count: ${count}`;
</script>
```

**Svelte 5:**
```svelte
<script>
  let count = $state(0);

  $effect(() => { console.log('Count changed:', count); });
  $effect(() => { document.title = `Count: ${count}`; });
</script>
```

### Conditional Side Effects

**Svelte 4:**
```svelte
<script>
  let value;
  $: if (value > 100) { alert('Value too high!'); }
</script>
```

**Svelte 5:**
```svelte
<script>
  let value = $state(0);

  $effect(() => {
    if (value > 100) { alert('Value too high!'); }
  });
</script>
```

### Props Migration

**Svelte 4:**
```svelte
<script>
  export let name;
  export let count = 0;
  $: greeting = `Hello, ${name}!`;
</script>
```

**Svelte 5:**
```svelte
<script>
  let { name, count = 0 } = $props();
  let greeting = $derived(`Hello, ${name}!`);
</script>
```

### Effect with Cleanup

**Svelte 4:**
```svelte
<script>
  import { onDestroy } from 'svelte';

  let count = 0;
  let interval;

  $: {
    clearInterval(interval);
    interval = setInterval(() => console.log(count), 1000);
  }

  onDestroy(() => clearInterval(interval));
</script>
```

**Svelte 5:**
```svelte
<script>
  let count = $state(0);

  $effect(() => {
    const interval = setInterval(() => console.log(count), 1000);
    return () => clearInterval(interval); // Cleanup built-in
  });
</script>
```

### Migration Cheat Sheet

| Svelte 4 Pattern | Svelte 5 Replacement |
|------------------|----------------------|
| `let x = 0` (in component) | `let x = $state(0)` |
| `export let prop` | `let { prop } = $props()` |
| `$: derived = expr` | `let derived = $derived(expr)` |
| `$: { complex }` (value) | `let x = $derived.by(() => { ... })` |
| `$: console.log(x)` | `$effect(() => console.log(x))` |
| `$: if (x) { ... }` | `$effect(() => { if (x) { ... } })` |
| `$: document.title = x` | `$effect(() => { document.title = x })` |

### Automated Migration

```bash
npx sv migrate svelte-5
```

---

## Migrating Stores to Runes

Svelte 5 runes can replace most store use cases with simpler, more direct reactive state.

### Local Component State

**Svelte 4:**
```svelte
<script>
  import { writable } from 'svelte/store';

  const count = writable(0);
  function increment() { count.update(n => n + 1); }
</script>

<button on:click={increment}>Count: {$count}</button>
```

**Svelte 5:**
```svelte
<script>
  let count = $state(0);
  function increment() { count++; }
</script>

<button onclick={increment}>Count: {count}</button>
```

### Shared State Across Components

**Svelte 4 (stores.ts):**
```ts
import { writable } from 'svelte/store';
export const user = writable(null);
export const theme = writable('light');
```

**Svelte 5 (state.svelte.ts):**
```ts
export const user = $state<User | null>(null);
export const theme = $state({ current: 'light' as 'light' | 'dark' });

export function setTheme(newTheme: 'light' | 'dark') {
  theme.current = newTheme;
}
```

```svelte
<script>
  import { theme, setTheme } from './state.svelte';
</script>

<p>Theme: {theme.current}</p>
<button onclick={() => setTheme('dark')}>Dark Mode</button>
```

### Derived Store to $derived

**Svelte 4:**
```ts
import { writable, derived } from 'svelte/store';
export const items = writable([]);
export const completedCount = derived(items, $items =>
  $items.filter(i => i.done).length
);
```

**Svelte 5:**
```ts
// state.svelte.ts
export const items = $state<Item[]>([]);

export function getCompletedCount() {
  return items.filter(i => i.done).length;
}
```

```svelte
<script>
  import { items } from './state.svelte';
  let completedCount = $derived(items.filter(i => i.done).length);
</script>
```

### Custom Store to Reactive Class

**Svelte 4:**
```ts
function createCounter() {
  const { subscribe, set, update } = writable(0);
  return {
    subscribe,
    increment: () => update(n => n + 1),
    decrement: () => update(n => n - 1),
    reset: () => set(0)
  };
}
export const counter = createCounter();
```

**Svelte 5:**
```ts
// counter.svelte.ts
class Counter {
  value = $state(0);
  increment() { this.value++; }
  decrement() { this.value--; }
  reset() { this.value = 0; }
}

export const counter = new Counter();
```

```svelte
<script>
  import { counter } from './counter.svelte';
</script>

<p>{counter.value}</p>
<button onclick={() => counter.increment()}>+</button>
```

### Async State Pattern

**Svelte 5:**
```ts
// api.svelte.ts
export const state = $state({
  data: null as Data | null,
  loading: false,
  error: null as Error | null
});

export async function fetchData() {
  state.loading = true;
  state.error = null;

  try {
    const res = await fetch('/api/data');
    state.data = await res.json();
  } catch (e) {
    state.error = e as Error;
  } finally {
    state.loading = false;
  }
}
```

### When to Still Use Stores

1. **Library interop** - Libraries that expect Svelte stores
2. **Legacy code** - Gradual migration
3. **Observable patterns** - When you need the subscribe API
4. **Server-side rendering** - Stores have built-in SSR handling

### Store to Rune Cheat Sheet

| Store Pattern | Rune Replacement |
|---------------|------------------|
| `writable(value)` | `$state(value)` |
| `$store` (auto-subscribe) | Direct access to `$state` value |
| `store.set(x)` | `state = x` |
| `store.update(fn)` | Direct mutation or reassignment |
| `derived(store, fn)` | `$derived(fn())` in component |
| `readable(value, start)` | `$state` + `$effect` for setup |
