# Svelte 5 Runes Reference

## Table of Contents
- [$state - Reactive State](#state---reactive-state)
- [$derived - Computed Values](#derived---computed-values)
- [$effect - Side Effects](#effect---side-effects)
- [$props - Component Props](#props---component-props)
- [$bindable - Two-Way Binding](#bindable---two-way-binding)
- [$inspect - Debugging](#inspect---debugging)

---

## $state - Reactive State

In Svelte 5, plain `let` declarations are no longer automatically reactive. Use `$state()` for reactive state.

### Basic Usage

```svelte
<script>
  let count = $state(0);
</script>

<button onclick={() => count++}>
  Clicks: {count}
</button>
```

### Object and Array State

Objects and arrays are deeply reactive by default:

```svelte
<script>
  let user = $state({ name: 'Alice', age: 30 });
  let items = $state(['apple', 'banana']);
</script>

<button onclick={() => user.age++}>Age: {user.age}</button>
<button onclick={() => items.push('cherry')}>Items: {items.length}</button>
```

### Class State

```svelte
<script>
  class Counter {
    count = $state(0);
    increment() { this.count++; }
  }
  const counter = new Counter();
</script>

<button onclick={() => counter.increment()}>{counter.count}</button>
```

### Raw State (Opt-out of Deep Reactivity)

```svelte
<script>
  let items = $state.raw([1, 2, 3]);

  // This WON'T trigger an update:
  items.push(4);

  // This WILL trigger an update:
  items = [...items, 4];
</script>
```

---

## $derived - Computed Values

Replaces `$:` reactive statements for computed values.

### Basic Usage

```svelte
<script>
  let count = $state(0);
  let doubled = $derived(count * 2);
  let quadrupled = $derived(doubled * 2);
</script>
```

### Complex Derivations with $derived.by

```svelte
<script>
  let items = $state([1, 2, 3, 4, 5]);
  let filter = $state('even');

  let filteredItems = $derived.by(() => {
    if (filter === 'even') return items.filter(n => n % 2 === 0);
    return items.filter(n => n % 2 !== 0);
  });
</script>
```

### Deriving from Props

```svelte
<script>
  let { firstName, lastName } = $props();
  let fullName = $derived(`${firstName} ${lastName}`);
</script>
```

### $derived vs $effect

Use `$derived` for computing values, `$effect` for side effects:

```svelte
<script>
  let count = $state(0);

  // CORRECT: Use $derived for computed values
  let doubled = $derived(count * 2);

  // INCORRECT: Don't use $effect to set derived values
  // let doubled;
  // $effect(() => { doubled = count * 2; }); // Anti-pattern!
</script>
```

---

## $effect - Side Effects

Runs code when component mounts and when dependencies change. Requires cleanup for subscriptions.

### Basic Effect with Cleanup

```svelte
<script>
  let count = $state(0);

  $effect(() => {
    const interval = setInterval(() => count++, 1000);
    return () => clearInterval(interval); // Cleanup
  });
</script>
```

### DOM Event Listeners

```svelte
<script>
  let mouseX = $state(0);
  let mouseY = $state(0);

  $effect(() => {
    function handleMouseMove(event) {
      mouseX = event.clientX;
      mouseY = event.clientY;
    }
    window.addEventListener('mousemove', handleMouseMove);
    return () => window.removeEventListener('mousemove', handleMouseMove);
  });
</script>
```

### External Subscriptions

```svelte
<script>
  let { userId } = $props();
  let userData = $state(null);

  $effect(() => {
    const unsubscribe = database.subscribe(`users/${userId}`, (data) => {
      userData = data;
    });
    return () => unsubscribe();
  });
</script>
```

### $effect.pre for Pre-DOM Updates

```svelte
<script>
  let div;
  let messages = $state([]);

  $effect.pre(() => {
    if (div) {
      const shouldScroll = div.scrollTop + div.clientHeight >= div.scrollHeight - 20;
      if (shouldScroll) {
        tick().then(() => { div.scrollTop = div.scrollHeight; });
      }
    }
  });
</script>
```

### Untracked Dependencies

```svelte
<script>
  import { untrack } from 'svelte';

  let count = $state(0);
  let logCount = $state(0);

  $effect(() => {
    // Only runs when count changes, not logCount
    console.log(count, untrack(() => logCount));
  });
</script>
```

---

## $props - Component Props

Replaces `export let` for declaring component props.

### Basic Usage

```svelte
<script>
  let { name, count = 0, disabled = false } = $props();
</script>
```

### Rest Props Pattern

```svelte
<script>
  let { class: className, children, ...restProps } = $props();
</script>

<div class={className} {...restProps}>
  {@render children?.()}
</div>
```

### Renaming Reserved Words

```svelte
<script>
  let {
    class: className,  // 'class' is reserved
    for: htmlFor,      // 'for' is reserved
    ...rest
  } = $props();
</script>
```

### TypeScript Props

```svelte
<script lang="ts">
  interface Props {
    name: string;
    count?: number;
    onClick?: (event: MouseEvent) => void;
  }

  let { name, count = 0, onClick }: Props = $props();
</script>
```

### Props with Children

```svelte
<script lang="ts">
  import type { Snippet } from 'svelte';

  interface Props {
    title: string;
    children: Snippet;
    footer?: Snippet;
  }

  let { title, children, footer }: Props = $props();
</script>

<article>
  <h1>{title}</h1>
  <main>{@render children()}</main>
  {#if footer}<footer>{@render footer()}</footer>{/if}
</article>
```

---

## $bindable - Two-Way Binding

Props must be explicitly marked with `$bindable()` to support `bind:`.

### Basic Usage

```svelte
<!-- Input.svelte -->
<script>
  let { value = $bindable() } = $props();
</script>

<input bind:value />

<!-- Parent.svelte -->
<script>
  import Input from './Input.svelte';
  let name = $state('');
</script>

<Input bind:value={name} />
```

### Bindable with Default Value

```svelte
<script>
  let { value = $bindable('default') } = $props();
</script>
```

### Multiple Bindable Props

```svelte
<script>
  let {
    value = $bindable(''),
    checked = $bindable(false),
    selected = $bindable(null)
  } = $props();
</script>
```

### TypeScript with Bindable

```svelte
<script lang="ts">
  interface Props {
    value: string;
    disabled?: boolean;
  }

  let { value = $bindable(''), disabled = false }: Props = $props();
</script>
```

---

## $inspect - Debugging

Development-only debugging that logs values when they change. Stripped in production.

### Basic Usage

```svelte
<script>
  let count = $state(0);
  $inspect(count); // Logs every time count changes
</script>
```

### Multiple Values

```svelte
<script>
  let name = $state('Alice');
  let age = $state(30);
  $inspect(name, age);
</script>
```

### Custom Logging with $inspect.with

```svelte
<script>
  let user = $state({ name: 'Alice', age: 30 });

  $inspect.with((type, ...values) => {
    if (type === 'init') console.log('Initial value:', values);
    else console.log('Updated to:', values);
  }, user);
</script>
```

### Debugging with Breakpoints

```svelte
<script>
  let data = $state({ x: 0, y: 0 });

  $inspect.with((type, value) => {
    if (type === 'update' && value.x > 100) debugger;
  }, data);
</script>
```
