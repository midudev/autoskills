# Svelte 5 Performance Reference

## Table of Contents
- [Universal Reactivity](#universal-reactivity)
- [Avoiding Over-Reactivity](#avoiding-over-reactivity)
- [Preventing Load Waterfalls](#preventing-load-waterfalls)
- [Streaming Non-Critical Data](#streaming-non-critical-data)
- [Component Testing](#component-testing)

---

## Universal Reactivity

Svelte 5 allows runes in `.svelte.js` or `.svelte.ts` files for shared state outside components.

### Shared Counter State

```ts
// counter.svelte.ts
export const counter = $state({ count: 0 });

export function increment() { counter.count++; }
export function decrement() { counter.count--; }
export function reset() { counter.count = 0; }
```

```svelte
<script>
  import { counter, increment } from './counter.svelte';
</script>

<p>Count: {counter.count}</p>
<button onclick={increment}>+</button>
```

### Object State with Getters

```ts
// user.svelte.ts
const state = $state<User>({ firstName: '', lastName: '', email: '' });

export const user = {
  get firstName() { return state.firstName; },
  set firstName(v: string) { state.firstName = v; },
  get fullName() { return `${state.firstName} ${state.lastName}`; },
  get isValid() { return state.firstName && state.email.includes('@'); }
};
```

### Reactive Class Pattern

```ts
// todo.svelte.ts
class TodoStore {
  items = $state<Todo[]>([]);
  filter = $state<'all' | 'active' | 'completed'>('all');

  get filtered() {
    switch (this.filter) {
      case 'active': return this.items.filter(t => !t.done);
      case 'completed': return this.items.filter(t => t.done);
      default: return this.items;
    }
  }

  add(text: string) {
    this.items.push({ id: Date.now(), text, done: false });
  }
}

export const todos = new TodoStore();
```

### Important Notes

1. **File extension matters**: Must use `.svelte.js` or `.svelte.ts`
2. **No $derived in module scope**: Use getters for derived values
3. **SSR caution**: Avoid initializing browser-only state at module level

---

## Avoiding Over-Reactivity

Common mistakes with runes can cause unnecessary re-renders, infinite loops, or degraded performance.

### Anti-Pattern 1: Using $effect to Set Derived Values

**WRONG:**
```svelte
<script>
  let count = $state(0);
  let doubled = $state(0);
  $effect(() => { doubled = count * 2; }); // Anti-pattern!
</script>
```

**CORRECT:**
```svelte
<script>
  let count = $state(0);
  let doubled = $derived(count * 2);
</script>
```

### Anti-Pattern 2: Circular Dependencies

**WRONG:**
```svelte
<script>
  let a = $state(1);
  let b = $state(2);

  $effect(() => {
    if (a > 10) b = 0;
    if (b > 10) a = 0; // Triggers the effect again!
  });
</script>
```

**CORRECT: Use separate effects or event handlers**

### Anti-Pattern 3: Not Using untrack

**WRONG:**
```svelte
<script>
  let count = $state(0);
  let log = $state([]);

  $effect(() => {
    log.push(`Count is ${count}`); // log change triggers re-run!
  });
</script>
```

**CORRECT:**
```svelte
<script>
  import { untrack } from 'svelte';

  let count = $state(0);
  let log = $state([]);

  $effect(() => {
    untrack(() => { log.push(`Count is ${count}`); });
  });
</script>
```

### Anti-Pattern 4: Heavy Computations in $derived

**WRONG:**
```svelte
<script>
  let items = $state([/* thousands */]);
  let filter = $state('');

  let filtered = $derived(
    items.filter(item => JSON.stringify(item).includes(filter))
  );
</script>
```

**CORRECT: Debounce expensive computations**
```svelte
<script>
  let filter = $state('');
  let debouncedFilter = $state('');

  $effect(() => {
    const timeout = setTimeout(() => { debouncedFilter = filter; }, 300);
    return () => clearTimeout(timeout);
  });

  let filtered = $derived(
    items.filter(item => item.name.includes(debouncedFilter))
  );
</script>
```

### Anti-Pattern 5: Effect for DOM Manipulation

**WRONG:**
```svelte
<script>
  let visible = $state(false);
  let element;

  $effect(() => {
    if (element) element.style.display = visible ? 'block' : 'none';
  });
</script>
```

**CORRECT:**
```svelte
{#if visible}<div>Content</div>{/if}
<!-- Or -->
<div class:hidden={!visible}>Content</div>
```

### Performance Tips

1. Use `$derived` over `$effect` for computed values
2. Debounce expensive reactive computations
3. Use `untrack` to prevent unnecessary dependencies
4. Group related state into objects
5. Let Svelte handle DOM updates

---

## Preventing Load Waterfalls

Sequential API calls multiply latency. Use parallel requests and streaming.

### Anti-Pattern: Waterfall

**WRONG (3 seconds total):**
```ts
export const load = async ({ fetch }) => {
  const user = await fetch('/api/user').then(r => r.json());     // 1s
  const posts = await fetch(`/api/users/${user.id}/posts`).then(r => r.json()); // 1s
  const comments = await fetch('/api/comments').then(r => r.json()); // 1s
  return { user, posts, comments };
};
```

### Pattern 1: Parallel with Promise.all

**CORRECT (1 second total):**
```ts
export const load = async ({ fetch }) => {
  const [user, posts, comments] = await Promise.all([
    fetch('/api/user').then(r => r.json()),
    fetch('/api/posts').then(r => r.json()),
    fetch('/api/comments').then(r => r.json())
  ]);
  return { user, posts, comments };
};
```

### Pattern 2: Partial Dependencies

```ts
export const load = async ({ fetch }) => {
  const user = await fetch('/api/user').then(r => r.json());

  const [posts, followers] = await Promise.all([
    fetch(`/api/users/${user.id}/posts`).then(r => r.json()),
    fetch(`/api/users/${user.id}/followers`).then(r => r.json())
  ]);

  return { user, posts, followers };
};
```

### Pattern 3: Streaming Non-Critical Data

```ts
export const load = async ({ fetch }) => {
  const user = await fetch('/api/user').then(r => r.json());

  return {
    user,
    recommendations: fetch('/api/recommendations').then(r => r.json()),
    analytics: fetch('/api/analytics').then(r => r.json())
  };
};
```

### Performance Comparison

| Pattern | 3 APIs x 1s each |
|---------|------------------|
| Sequential | 3 seconds |
| Parallel (Promise.all) | 1 second |
| Streaming | 0s initial, streams rest |

---

## Streaming Non-Critical Data

Return promises from load functions to stream non-essential data after initial page render.

### Basic Streaming

**WRONG (blocks on slow data):**
```ts
export const load = async ({ fetch }) => {
  const user = await fetch('/api/user').then(r => r.json());     // 100ms
  const analytics = await fetch('/api/analytics').then(r => r.json()); // 2000ms
  return { user, analytics }; // Page blocked for 2.1 seconds
};
```

**CORRECT (stream slow data):**
```ts
export const load = async ({ fetch }) => {
  const user = await fetch('/api/user').then(r => r.json());
  const analytics = fetch('/api/analytics').then(r => r.json()); // Don't await

  return {
    user,      // Available in 100ms
    analytics  // Streams when ready
  };
};
```

### Component Handling

```svelte
<script lang="ts">
  import type { PageProps } from './$types';
  let { data }: PageProps = $props();
</script>

<header><h1>Welcome, {data.user.name}</h1></header>

<aside>
  {#await data.analytics}
    <div class="skeleton">Loading analytics...</div>
  {:then analytics}
    <div class="analytics">
      <p>Page views: {analytics.views}</p>
    </div>
  {:catch}
    <div class="error">Failed to load analytics</div>
  {/await}
</aside>
```

### When to Stream

| Data Type | Stream? | Reason |
|-----------|---------|--------|
| User info | No | Critical for layout |
| Main content | No | Users came for this |
| Analytics | Yes | Not user-facing |
| Recommendations | Yes | Supplementary |
| Comments | Maybe | Important but can load later |

---

## Component Testing

Svelte 5 components with runes require proper Vitest configuration.

### Option 1: Vitest Browser Mode (Recommended)

```ts
// vitest.config.ts
import { defineConfig } from 'vitest/config';
import { svelte } from '@sveltejs/vite-plugin-svelte';

export default defineConfig({
  plugins: [svelte()],
  test: {
    browser: {
      enabled: true,
      provider: 'playwright',
      name: 'chromium'
    }
  }
});
```

### Option 2: JSDOM with @testing-library/svelte

```ts
// vitest.config.ts
import { defineConfig } from 'vitest/config';
import { svelte } from '@sveltejs/vite-plugin-svelte';

export default defineConfig({
  plugins: [svelte({ hot: !process.env.VITEST })],
  test: {
    environment: 'jsdom',
    include: ['src/**/*.{test,spec}.{js,ts}'],
    globals: true
  }
});
```

### Basic Component Test

```ts
import { render, screen, fireEvent } from '@testing-library/svelte';
import { expect, test } from 'vitest';
import Counter from './Counter.svelte';

test('increments count when clicked', async () => {
  render(Counter);

  const button = screen.getByRole('button');
  expect(button).toHaveTextContent('Count: 0');

  await fireEvent.click(button);
  expect(button).toHaveTextContent('Count: 1');
});
```

### Testing Props

```ts
test('renders with custom name', () => {
  render(Greeting, { props: { name: 'Alice' } });
  expect(screen.getByText('Hello, Alice!')).toBeInTheDocument();
});
```

### Testing Callbacks

```ts
import { vi } from 'vitest';

test('calls onclick callback when clicked', async () => {
  const handleClick = vi.fn();
  render(Button, { props: { onclick: handleClick } });

  await fireEvent.click(screen.getByRole('button'));
  expect(handleClick).toHaveBeenCalledTimes(1);
});
```

### Testing Async Components

```ts
import { waitFor } from '@testing-library/svelte';

test('loads and displays user data', async () => {
  global.fetch = vi.fn().mockResolvedValue({
    ok: true,
    json: () => Promise.resolve({ name: 'Alice' })
  });

  render(UserProfile, { props: { userId: '123' } });
  expect(screen.getByText('Loading...')).toBeInTheDocument();

  await waitFor(() => {
    expect(screen.getByText('Alice')).toBeInTheDocument();
  });
});
```
