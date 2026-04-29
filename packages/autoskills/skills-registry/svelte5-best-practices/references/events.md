# Svelte 5 Events Reference

## Table of Contents
- [Event Handler Syntax](#event-handler-syntax)
- [Callback Props Pattern](#callback-props-pattern)
- [Context API](#context-api)

---

## Event Handler Syntax

Svelte 5 replaces `on:click` directive syntax with standard HTML attribute syntax `onclick`.

### Basic Event Handlers

**Svelte 4:**
```svelte
<button on:click={handleClick}>Click</button>
<input on:input={handleInput} />
<form on:submit={handleSubmit}>...</form>
```

**Svelte 5:**
```svelte
<button onclick={handleClick}>Click</button>
<input oninput={handleInput} />
<form onsubmit={handleSubmit}>...</form>
```

### Event Modifiers Migration

Event modifiers no longer exist. Use wrapper functions:

**Svelte 4:**
```svelte
<form on:submit|preventDefault={handleSubmit}>...</form>
<button on:click|stopPropagation={handleClick}>...</button>
```

**Svelte 5:**
```svelte
<script>
  function handleSubmit(event) {
    event.preventDefault();
    // ... handle form
  }

  function handleClick(event) {
    event.stopPropagation();
    // ... handle click
  }
</script>

<form onsubmit={handleSubmit}>...</form>
<button onclick={handleClick}>...</button>
```

### Capture, Passive, and NonPassive

```svelte
<!-- Capture phase -->
<div onclickcapture={handleCapture}>
  <button onclick={handleClick}>Click</button>
</div>

<!-- Passive listener -->
<div ontouchstartpassive={handleTouch}>...</div>

<!-- Non-passive -->
<div ontouchmovenonpassive={(e) => e.preventDefault()}>...</div>
```

### Inline Handlers

```svelte
<button onclick={() => count++}>Count: {count}</button>
<input oninput={(e) => name = e.target.value} />
```

### Event Handler Shorthand

```svelte
<script>
  function onclick(event) {
    console.log('Clicked!', event);
  }
</script>

<button {onclick}>Click</button>
```

### Spreading Event Handlers

```svelte
<script>
  let handlers = {
    onclick: () => console.log('clicked'),
    onmouseenter: () => console.log('entered'),
    onmouseleave: () => console.log('left')
  };
</script>

<button {...handlers}>Hover or Click</button>
```

### Multiple Handlers for Same Event

In Svelte 5, combine logic into one handler:

```svelte
<script>
  function handleClick(event) {
    handler1(event);
    handler2(event);
  }
</script>

<button onclick={handleClick}>...</button>
```

### TypeScript Event Typing

```svelte
<script lang="ts">
  function handleClick(event: MouseEvent) {
    console.log(event.clientX, event.clientY);
  }

  function handleInput(event: Event) {
    const target = event.target as HTMLInputElement;
    console.log(target.value);
  }

  function handleSubmit(event: SubmitEvent) {
    event.preventDefault();
    const formData = new FormData(event.currentTarget as HTMLFormElement);
  }
</script>
```

---

## Callback Props Pattern

Svelte 5 deprecates `createEventDispatcher` in favor of callback props for component-to-parent communication.

### Basic Event Pattern

**Svelte 4:**
```svelte
<!-- Button.svelte -->
<script>
  import { createEventDispatcher } from 'svelte';
  const dispatch = createEventDispatcher();
</script>

<button on:click={() => dispatch('click', { timestamp: Date.now() })}>Click</button>

<!-- Parent.svelte -->
<Button on:click={(e) => console.log(e.detail)} />
```

**Svelte 5:**
```svelte
<!-- Button.svelte -->
<script>
  let { onclick } = $props();
</script>

<button onclick={() => onclick?.({ timestamp: Date.now() })}>Click</button>

<!-- Parent.svelte -->
<Button onclick={(data) => console.log(data)} />
```

### Multiple Callbacks

```svelte
<!-- Dialog.svelte -->
<script>
  let { onconfirm, oncancel, onclose } = $props();
</script>

<dialog>
  <button onclick={() => onconfirm?.()}>Confirm</button>
  <button onclick={() => oncancel?.()}>Cancel</button>
  <button onclick={() => onclose?.()}>X</button>
</dialog>

<!-- Parent.svelte -->
<Dialog
  onconfirm={() => save()}
  oncancel={() => reset()}
  onclose={() => visible = false}
/>
```

### Typed Callbacks with TypeScript

```svelte
<script lang="ts">
  interface Props {
    value?: string;
    onsearch?: (query: string) => void;
    onchange?: (value: string) => void;
    onclear?: () => void;
  }

  let { value = '', onsearch, onchange, onclear }: Props = $props();

  function handleInput(e: Event) {
    const newValue = (e.target as HTMLInputElement).value;
    value = newValue;
    onchange?.(newValue);
  }
</script>
```

### Forwarding Native Events

```svelte
<script lang="ts">
  import type { MouseEventHandler } from 'svelte/elements';

  interface Props {
    onclick?: MouseEventHandler<HTMLButtonElement>;
    children: import('svelte').Snippet;
  }

  let { onclick, children, ...rest }: Props = $props();
</script>

<button {onclick} {...rest}>{@render children()}</button>
```

---

## Context API

Context functions must be called synchronously during component initialization.

### Correct Context Usage

```svelte
<script>
  import { setContext, getContext } from 'svelte';

  // These run during initialization - CORRECT
  setContext('theme', 'dark');
  const theme = getContext('theme');

  // INCORRECT - in $effect or callback
  // $effect(() => { setContext('theme', 'dark'); }); // ERROR
</script>
```

### Reactive Context Values

Pass `$state` objects for reactive context:

```svelte
<!-- Provider.svelte -->
<script>
  import { setContext } from 'svelte';

  let theme = $state('light');

  setContext('theme', {
    get current() { return theme; },
    toggle() { theme = theme === 'light' ? 'dark' : 'light'; }
  });

  let { children } = $props();
</script>

{@render children()}

<!-- Consumer.svelte -->
<script>
  import { getContext } from 'svelte';
  const themeContext = getContext('theme');
</script>

<p>Theme: {themeContext.current}</p>
<button onclick={themeContext.toggle}>Toggle</button>
```

### Type-Safe Context Pattern

```ts
// context.ts
import { setContext, getContext } from 'svelte';

const THEME_KEY = Symbol('theme');

interface ThemeContext {
  current: 'light' | 'dark';
  toggle: () => void;
}

export function setThemeContext(context: ThemeContext) {
  setContext(THEME_KEY, context);
}

export function getThemeContext(): ThemeContext {
  const context = getContext<ThemeContext>(THEME_KEY);
  if (!context) throw new Error('Theme context not found');
  return context;
}
```

### Avoid Generic Keys

```svelte
<script>
  // Option 1: Symbol
  const USER_KEY = Symbol('user');
  setContext(USER_KEY, userData);

  // Option 2: Unique string
  setContext('myapp:user', userData);

  // Option 3: Object key
  const userKey = {};
  setContext(userKey, userData);
</script>
```

### hasContext Check

```svelte
<script>
  import { hasContext, getContext } from 'svelte';

  const hasTheme = hasContext('theme');
  const theme = hasTheme ? getContext('theme') : { current: 'light' };
</script>
```

### Context Boundaries

Context flows down the component tree:

```svelte
<!-- Parent.svelte -->
<script>
  import { getContext, setContext } from 'svelte';
  const level = getContext('level'); // 0
  setContext('level', level + 1); // Override for children
</script>

<Child /> <!-- Will see level = 1 -->
```
