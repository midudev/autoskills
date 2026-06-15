# Reactivity Patterns: When to Use Each Rune

## Decision Matrix

| Need                 | Use                    | Why                                    |
| -------------------- | ---------------------- | -------------------------------------- |
| Mutable state        | `$state()`             | Base reactive variable                 |
| Computed value       | `$derived()`           | Auto-updates when dependencies change  |
| Complex computation  | `$derived.by()`        | Use function body for multi-line logic |
| Large immutable data | `$state.raw()`         | Skip deep reactivity for performance   |
| Read-only snapshot   | `$state.snapshot()`    | Get plain JS value, no proxy           |
| Side effect          | `$effect()`            | Run code when dependencies change      |
| Pre-DOM effect       | `$effect.pre()`        | Run before DOM updates                 |
| Accept props         | `$props()`             | Declare component props                |
| Bindable prop        | `$bindable()`          | Allow parent to bind to prop           |
| Reactive class field | `$state` (class field) | Reactive property in class             |

## $effect Decision Hierarchy

**$effect is an escape hatch.** Before using it, ask:

```
Need to react to state change?
├─ Can use event handler? → USE EVENT HANDLER (preferred)
├─ Is it a computed value? → USE $derived
├─ Is it DOM-specific? → USE @attach
└─ External side effect? → USE $effect (with cleanup)
```

**Why this order matters:**

- **Event handlers** - Run once per user action, predictable timing
- **$derived** - Lazy, garbage-collectable, can be created anywhere
- **@attach** - Lifecycle tied to element, auto-cleanup
- **$effect** - Eager, requires lifecycle management, runs after DOM

## $state - Mutable Reactive State

**Use when:** You need a variable that changes and triggers UI updates

```svelte
<script>
	let count = $state(0); // Primitive
	let user = $state({ name: 'Alex', profile: { age: 30 } }); // Object (DEEP reactive)
	let items = $state([1, 2, 3]); // Array (DEEP reactive)
</script>
```

**Key points:**

- Must be top-level in component
- Objects/arrays are **deeply reactive** by default - nested mutations
  trigger updates
- Mutate nested properties directly: `user.profile.age = 31` ✅
  (works!)
- Reassigning also works: `user = { ...user, name: 'Bo' }` ✅

## $derived - Computed Values

**Use when:** Value is calculated from other state

```svelte
<script>
	let count = $state(0);
	let doubled = $derived(count * 2); // Simple computation
	let message = $derived.by(() => {
		// Complex computation
		if (count === 0) return 'Zero';
		return count > 10 ? 'High' : 'Low';
	});
</script>
```

**Key points:**

- **Can be overridden** - Reassignment allowed (but will recalculate
  on dependency change)
- Use `const` to make truly read-only:
  `const doubled = $derived(count * 2)`
- Auto-tracks dependencies
- Use `$derived.by()` for multi-line logic
- Lazy - only computes when accessed

## $effect - Side Effects (Escape Hatch)

**Use when:** You need external side effects that can't be handled by
event handlers, $derived, or @attach.

```svelte
<script>
	let count = $state(0);

	$effect(() => {
		console.log(`Count changed to ${count}`);
		document.title = `Count: ${count}`;
	});
</script>
```

**Legitimate use cases:**

- Logging/analytics
- Updating external state (localStorage, document.title)
- Setting up/tearing down subscriptions (WebSocket, intervals)
- Third-party library integration (when @attach isn't suitable)

**Key points:**

- **Eager execution** - Runs whenever dependencies change, until destroyed
- **Lifecycle-bound** - Can only be created in effect roots (components)
- **Runs after DOM** - Not before (use `$effect.pre` for pre-DOM)
- **No SSR** - Effects don't run during server-side rendering
- Return cleanup function: `return () => cleanup()`
- Don't update state that effect depends on (infinite loop!)

**Why $derived is preferred for computed values:**

- $derived is **lazy** - only computes when accessed
- $derived is **garbage-collectable** - no lifecycle management needed
- $effect is **eager** - keeps running until destroyed

## $effect.pre - Pre-DOM Effects

**Use when:** You need to run before DOM updates

```svelte
<script>
	let element = $state(null);

	$effect.pre(() => {
		// Runs BEFORE DOM updates
		// Useful for measuring DOM before changes
	});
</script>
```

## $props - Component Props

**Use when:** Component accepts props from parent

```svelte
<script>
	let { name, age = 18, ...rest } = $props(); // Destructure with defaults
	// OR
	let props = $props(); // Access as props.name, props.age
</script>

<p>{name} is {age} years old</p>
```

**Key points:**

- Use for all component props
- Supports defaults and rest props
- Props are reactive automatically

## $bindable - Bindable Props

**Use when:** Parent should be able to bind to this prop

```svelte
<!-- Child.svelte -->
<script>
  let { value = $bindable() } = $props();
</script>

<input bind:value />

<!-- Parent.svelte -->
<script>
  let text = $state('');
</script>

<Child bind:value={text} />
<p>You typed: {text}</p>
```

**Key points:**

- Makes prop two-way bindable
- Parent can use `bind:propName`
- Provide default: `$bindable('default')`

## Common Anti-Patterns

### ❌ Using $effect for derived state

```svelte
<!-- WRONG -->
<script>
  let count = $state(0);
  let doubled = $state(0);

  $effect(() => {
    doubled = count * 2;  // BAD - use $derived!
  });
</script>

<!-- RIGHT -->
<script>
  let count = $state(0);
  let doubled = $derived(count * 2);  // GOOD
</script>
```

### ⚠️ Reassigning $derived (Svelte 5.25+)

```svelte
<!-- WORKS but may be confusing -->
<script>
	let count = $state(0);
	let doubled = $derived(count * 2);

	function reset() {
		doubled = 0; // Temporarily overrides, but recalculates when count changes
	}
</script>

<!-- CLEARER - Use const to prevent reassignment -->
<script>
	let count = $state(0);
	const doubled = $derived(count * 2); // const = truly read-only

	function reset() {
		// doubled = 0; // TypeScript error - cannot reassign const
	}
</script>
```

**Note:** As of Svelte 5.25+, `$derived` values CAN be reassigned, but
they'll recalculate when dependencies change. Use `const` to make them
truly read-only.

### ❌ Infinite loops in $effect

```svelte
<!-- WRONG -->
<script>
	let count = $state(0);

	$effect(() => {
		count++; // INFINITE LOOP - effect updates count, triggers effect...
	});
</script>
```

### ❌ Using runes inside functions

```svelte
<!-- WRONG -->
<script>
	function createCounter() {
		let count = $state(0); // ERROR - runes must be top-level
		return count;
	}
</script>
```

## Performance: $state vs $state.raw

Use `$state.raw()` for **performance optimization** when you don't
need reactivity:

```svelte
<script>
	// Large immutable config (never changes)
	let config = $state.raw(hugeConfigObject); // No proxy overhead

	// Data you'll replace entirely, not mutate
	let apiData = $state.raw(data);
	// Later: apiData = newData; (full replacement)

	// If you WILL mutate nested properties, use $state:
	let user = $state({ profile: { name: 'Alex' } });
	user.profile.name = 'Bo'; // Works with deep reactivity
</script>
```

**When to use $state.raw():**

- Large, immutable data structures (config, constants)
- Data you'll fully replace, not incrementally mutate
- Performance-critical scenarios where proxies are expensive

**When NOT to use $state.raw():**

- You need to mutate the object and see UI updates
- Data structures are small/medium sized

## Getting Plain Values: $state.snapshot

Extract plain JavaScript values from proxies:

```svelte
<script>
	let user = $state({ name: 'Alex', age: 30 });

	function saveToAPI() {
		const plain = $state.snapshot(user); // Get plain object
		fetch('/api/users', {
			body: JSON.stringify(plain),
		});
	}
</script>
```

## createSubscriber - External Observables

Use `createSubscriber` from `svelte/reactivity` to observe external state
without `$effect`. Per official best practices: use this instead of
`$effect` when you need to observe something external to Svelte.

```ts
import { createSubscriber } from 'svelte/reactivity';

function createLocationStore() {
	let location = window.location.href;

	const subscribe = createSubscriber((update) => {
		const handler = () => {
			location = window.location.href;
			update();
		};
		window.addEventListener('popstate', handler);
		return () => window.removeEventListener('popstate', handler);
	});

	return {
		get href() {
			subscribe();
			return location;
		}
	};
}
```

**When to use:** Wrapping browser APIs, third-party event emitters, or
any external source that doesn't integrate with Svelte's reactivity
natively.
