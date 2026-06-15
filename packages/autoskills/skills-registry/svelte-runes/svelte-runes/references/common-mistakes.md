# Common Mistakes: Anti-Patterns and Fixes

## Top 10 Svelte 5 Mistakes

### 1. Using $effect for Derived State ❌

**WRONG:**

```svelte
<script>
	let count = $state(0);
	let doubled = $state(0);

	$effect(() => {
		doubled = count * 2; // BAD - use $derived!
	});
</script>
```

**RIGHT:**

```svelte
<script>
	let count = $state(0);
	let doubled = $derived(count * 2); // GOOD - computed value
</script>
```

**Why:** `$effect` runs after DOM updates and is for side effects.
`$derived` is optimized for computed values.

---

### 1b. Using $effect When Event Handler Works ❌

**WRONG:**

```svelte
<script>
	let count = $state(0);
	let lastClicked = $state(null);

	$effect(() => {
		// BAD - reacting to count change just to log
		console.log(`Count is now ${count}`);
	});
</script>

<button onclick={() => count++}>Increment</button>
```

**RIGHT:**

```svelte
<script>
	let count = $state(0);

	function increment() {
		count++;
		console.log(`Count is now ${count}`); // Side effect in handler
	}
</script>

<button onclick={increment}>Increment</button>
```

**Why:** Per Svelte docs: "If you can put your side effects in an event
handler, that's almost always preferable." Event handlers are predictable
and run once per action.

---

### 1c. Using $effect to Sync Linked Values ❌

**WRONG:**

```svelte
<script>
	let celsius = $state(0);
	let fahrenheit = $state(32);

	// Two effects trying to sync each other - fragile!
	$effect(() => {
		fahrenheit = (celsius * 9) / 5 + 32;
	});

	$effect(() => {
		celsius = ((fahrenheit - 32) * 5) / 9;
	});
</script>

<input type="number" bind:value={celsius} />
<input type="number" bind:value={fahrenheit} />
```

**RIGHT - Use oninput callbacks:**

```svelte
<script>
	let celsius = $state(0);
	let fahrenheit = $state(32);

	function updateFromCelsius(e) {
		celsius = +e.target.value;
		fahrenheit = (celsius * 9) / 5 + 32;
	}

	function updateFromFahrenheit(e) {
		fahrenheit = +e.target.value;
		celsius = ((fahrenheit - 32) * 5) / 9;
	}
</script>

<input type="number" value={celsius} oninput={updateFromCelsius} />
<input type="number" value={fahrenheit} oninput={updateFromFahrenheit} />
```

**Why:** Per Svelte docs, avoid effects for "connecting one value to
another". Use `oninput` callbacks or function bindings instead.

---

### 1d. Using $effect to Sync Async Data into Form State ❌

**WRONG:**

```svelte
<script>
	let query = $derived(get_item({ id }))
	let name = $state('')

	// BAD — $effect as escape hatch to sync query → form state
	$effect(() => {
		if (query.ready) name = query.current.name
	})
</script>

<input bind:value={name} />
```

**RIGHT — Gate child component behind `.ready`:**

```svelte
<!-- Parent.svelte -->
<script>
	let query = $derived(get_item({ id }))
</script>

{#if !query.ready}
	<Skeleton />
{:else}
	<EditForm item={query.current} />
{/if}
```

```svelte
<!-- EditForm.svelte -->
<script>
	let { item } = $props()
	// svelte-ignore state_referenced_locally
	let form = $state({ name: item.name }) // init from prop at mount
</script>

<input bind:value={form.name} />
```

**Why:** The child component initializes `$state` from props once at
mount time. No `$effect` needed, no `state_unsafe_mutation` warning.
This is the standard pattern for editable forms backed by async data.

---

### 2. Reassigning $derived Values ⚠️

**Note:** As of Svelte 5.25+, `$derived` CAN be reassigned, but will
recalculate when dependencies change.

**CONFUSING (works but not recommended):**

```svelte
<script>
	let count = $state(0);
	let doubled = $derived(count * 2);

	function reset() {
		doubled = 0; // Temporarily overrides, but recalculates when count changes
	}
</script>
```

**CLEARER - Use const for read-only:**

```svelte
<script>
	let count = $state(0);
	const doubled = $derived(count * 2); // const = truly read-only

	function reset() {
		count = 0; // Update source, derived updates automatically
	}
</script>
```

**Why:** While reassignment is allowed, it's clearer to update the
source state. Use `const` to enforce read-only behavior.

---

### 3. Optional Chaining Breaks Effect Reactivity ❌

**WRONG:**

```svelte
<script>
	let particles = $state(undefined);
	let scheme = $state('dark');

	$effect(() => {
		// If particles is undefined, scheme is NEVER read!
		// Effect won't re-run when scheme changes
		particles?.updateScheme(scheme);
	});
</script>
```

**RIGHT:**

```svelte
<script>
	let particles = $state(undefined);
	let scheme = $state('dark');

	$effect(() => {
		// Read scheme first to create dependency
		const currentScheme = scheme;
		if (particles) {
			particles.updateScheme(currentScheme);
		}
	});
</script>
```

**Why:** JavaScript short-circuits optional chaining. If `particles`
is nullish, `scheme` is never evaluated, so no dependency is created.

---

### 4. Creating Infinite Loops in $effect ❌

**WRONG:**

```svelte
<script>
	let count = $state(0);

	$effect(() => {
		count++; // INFINITE LOOP - effect triggers itself!
	});
</script>
```

**RIGHT - Don't update dependencies**

```svelte
<script>
	let count = $state(0);
	let log = $state([]);

	$effect(() => {
		log.push(count); // Updates different state
	});
</script>
```

**RIGHT - Use untrack() to read without subscribing**

```svelte
<script>
	import { untrack } from 'svelte';

	let count = $state(0);

	$effect(() => {
		console.log('Effect ran');
		// Read count without creating dependency
		const current = untrack(() => count);
		// Now updating count won't re-trigger this effect
	});
</script>
```

**Why:** `$effect` runs when any accessed `$state` changes. Updating
that state creates a loop. Use `untrack()` to read state without
creating a dependency.

---

### 4b. Using $effect to Sync State with DOM Elements ❌

**WRONG - Dialog sync via effect:**

```svelte
<script>
	let is_open = $state(false);
	let dialog_element = $state<HTMLDialogElement>();

	$effect(() => {
		if (is_open) {
			dialog_element?.showModal();
		} else {
			dialog_element?.close(); // Fires 'close' event → handler → loop!
		}
	});
</script>

<dialog bind:this={dialog_element} onclose={() => is_open = false}>
```

**Why it fails:** `dialog.close()` fires the native `close` event, which
triggers your handler, which may cause loops or double-firing.

**RIGHT - State class with @attach:**

```ts
// state.svelte.ts
class DialogState {
	dialog: HTMLDialogElement | null = null;
	is_open = $state(false);

	register = (el: HTMLDialogElement) => {
		this.dialog = el;
		return () => {
			this.dialog = null;
		};
	};

	open() {
		if (!this.dialog?.open) {
			this.is_open = true;
			this.dialog?.showModal();
		}
	}

	close() {
		this.is_open = false;
		this.dialog?.close();
	}
}
```

```svelte
<!-- Component.svelte -->
<dialog {@attach dialog_state.register} onclose={dialog_state.close}>
```

**Why:** Per Svelte docs, "$effect is best thought of as an escape hatch"
and "you should not update state inside effects". Use @attach to register
elements with state, then call DOM methods directly.

---

### 4c. Using Runes Inside Functions ❌

**WRONG:**

```svelte
<script>
	function createCounter() {
		let count = $state(0); // ERROR - runes must be top-level!
		return count;
	}

	const counter = createCounter();
</script>
```

**RIGHT - Option 1: Top-level runes**

```svelte
<script>
	let count = $state(0);
</script>
```

**RIGHT - Option 2: Reactive class fields**

```svelte
<script>
	class Counter {
		count = $state(0); // OK in class fields
	}

	const counter = new Counter();
</script>
```

**Why:** Runes must be statically analyzable at compile time. Use
classes for encapsulation.

---

### 5. Understanding Deep Reactivity in Svelte 5 ✅

**GOOD NEWS: Deep reactivity works by default!**

```svelte
<script>
	let user = $state({ profile: { name: 'Alex' } });

	function updateName() {
		user.profile.name = 'Bo'; // This DOES trigger reactivity!
	}
</script>

<p>{user.profile.name}</p> <!-- Will update correctly -->
```

**Why:** `$state()` creates deep reactive proxies by default. Nested
mutations trigger updates.

**When to use $state.raw() instead:**

```svelte
<script>
	// For large, immutable data structures where you don't need reactivity
	let config = $state.raw(hugeConfigObject); // Skip deep proxy overhead for performance

	// For data you'll fully replace, not mutate
	let apiResponse = $state.raw(data); // Will replace entire object later
</script>
```

**Why:** Use `$state.raw()` for **performance optimization** when you
don't need deep reactivity, not because deep reactivity doesn't work.

---

### 6. Using Derived Logic Outside `$derived` ❌

**WRONG:**

```svelte
<script>
	let count = $state(0);
	let doubled = count * 2; // Won't update when count changes
</script>
```

**RIGHT:**

```svelte
<script>
	let count = $state(0);
	const doubled = $derived(count * 2);
</script>

<button onclick={() => count++}>
	{count} / {doubled}
</button>
```

**Why:** Values derived from reactive state must use `$derived` or `$derived.by`.

---

### 7. Forgetting $state for Reactive Variables ❌

**WRONG:**

```svelte
<script>
	let count = 0; // Not reactive in Svelte 5!
</script>

<button onclick={() => count++}>{count}</button>
<!-- UI won't update! -->
```

**RIGHT:**

```svelte
<script>
	let count = $state(0); // Reactive
</script>

<button onclick={() => count++}>{count}</button>
```

**Why:** Plain variables aren't reactive in Svelte 5. Must use $state.

---

### 8. Not Using $bindable for Two-Way Binding ❌

**WRONG:**

```svelte
<!-- Child.svelte -->
<script>
	let { value } = $props(); // Not bindable!
</script>

<input bind:value />

<!-- Parent.svelte -->
<Child bind:value={text} />
<!-- ERROR - value is not bindable -->
```

**RIGHT:**

```svelte
<!-- Child.svelte -->
<script>
	let { value = $bindable() } = $props(); // Make it bindable
</script>

<input bind:value />

<!-- Parent.svelte -->
<Child bind:value={text} />
<!-- Works! -->
```

**Why:** Props must explicitly declare they're bindable with
$bindable().

---

### 9. Forgetting {@render} for Children ❌

**WRONG:**

```svelte
<script>
	let { children } = $props();
</script>

<div>{children}</div> <!-- Won't render! Shows [object Object] -->
```

**RIGHT:**

```svelte
<script>
	let { children } = $props();
</script>

<div>{@render children()}</div> <!-- Renders children -->
```

**Why:** Children is a snippet, not a value. Must use {@render}.

---

### 10. Putting Event Logic in `$effect` ❌

**WRONG:**

```svelte
<script>
	let clicked = $state(false);

	$effect(() => {
		if (clicked) submit();
	});
</script>

<button onclick={() => clicked = true}>Submit</button>
```

**RIGHT:**

```svelte
<button onclick={submit}>Submit</button>
```

**Why:** User-triggered work belongs in event handlers. Reserve `$effect` for synchronization with external systems.

---

## Array and Object Mutations Work!

Svelte 5 has **deep reactivity** - array and object mutations trigger
updates:

### Arrays - All Methods Work

```svelte
<script>
	let items = $state([1, 2, 3]);

	function addItem() {
		items.push(4); // ✅ Works! Triggers reactivity
		// OR
		items[items.length] = 5; // ✅ Also works!
		// OR
		items = [...items, 6]; // ✅ Also works!
	}
</script>
```

### Nested Arrays - Also Work!

```svelte
<script>
	let data = $state({ items: [1, 2, 3], nested: { arr: [10, 20] } });

	function addItem() {
		data.items.push(4); // ✅ Works! Deep reactivity
	}

	function addNested() {
		data.nested.arr.push(30); // ✅ Works! Deeply reactive
	}
</script>
```

**All mutations trigger UI updates** because `$state()` creates deep
proxies.

## Performance Mistakes

### 1. Using $state When You Don't Need Reactivity

**UNNECESSARY:**

```svelte
<script>
	const API_URL = $state('https://api.example.com'); // Doesn't change!
</script>
```

**BETTER:**

```svelte
<script>
	const API_URL = 'https://api.example.com'; // Plain const
</script>
```

### 2. Using $state.raw for Performance

**When you have large immutable data:**

```svelte
<script>
	// Deep proxy has overhead for large objects
	let bigConfig = $state(hugeImmutableObject); // Slower

	// Skip proxies for data you don't mutate
	let bigConfig = $state.raw(hugeImmutableObject); // Faster
</script>
```

**Use $state.raw() when:**

- Data is large and immutable
- You'll replace entire object, not mutate it
- Performance is critical

**Don't use $state.raw() when:**

- You need to mutate nested properties
- Data is small/medium sized

### 3. Unnecessary $derived

**UNNECESSARY:**

```svelte
<script>
	let { count } = $props();
	let doubled = $derived(count * 2); // Used only once
</script>

<p>{doubled}</p>
```

**SIMPLER:**

```svelte
<script>
	let { count } = $props();
</script>

<p>{count * 2}</p> <!-- Inline is fine -->
```

## TypeScript Mistakes

### 1. Not Typing Props

**WRONG:**

```svelte
<script lang="ts">
	let { name, age } = $props(); // No types!
</script>
```

**RIGHT:**

```svelte
<script lang="ts">
	interface Props {
		name: string;
		age: number;
	}

	let { name, age }: Props = $props();
</script>
```

### 2. Wrong Bindable Type

**WRONG:**

```svelte
<script lang="ts">
	let { value = $bindable() }: { value: string } = $props();
	//                                   ^^^^^^ Should be optional
</script>
```

**RIGHT:**

```svelte
<script lang="ts">
	let { value = $bindable('') }: { value?: string } = $props();
	//                                       ^ Optional
</script>
```

## Error Messages and Fixes

### "Cannot access 'count' before initialization"

**Cause:** Using rune inside function or wrong order

```svelte
<!-- WRONG -->
<script>
  const doubled = count * 2;
  let count = $state(0);
</script>

<!-- RIGHT -->
<script>
  let count = $state(0);
  const doubled = $derived(count * 2);
</script>
```

### "Cannot read properties of undefined (reading '$effect')"

**Cause:** Using rune outside component scope

```svelte
<!-- WRONG -->
<script context="module">
	let count = $state(0); // ERROR - not in component scope
</script>

<!-- RIGHT -->
<script>
	let count = $state(0); // OK
</script>
```

### "bind:value is not available on this component"

**Cause:** Forgot $bindable

**Fix:** Add `$bindable()` to prop definition

## Best Practices Summary

1. ✅ **Prefer event handlers** over `$effect` for side effects
2. ✅ Use `$derived` for computed values, not `$effect`
3. ✅ Use `@attach` for DOM element operations
4. ✅ Don't update dependencies inside `$effect`
5. ✅ Keep runes at component top-level
6. ✅ Use consistent Svelte 5 syntax (no mixing)
7. ✅ Wrap reactive variables with `$state()`
8. ✅ Use `$bindable()` for two-way binding
9. ✅ Use `{@render children()}` not `{children}`
10. ✅ Put user-triggered work directly in event handlers
11. ✅ Remember: `$effect` doesn't run during SSR

## Debugging: $inspect.trace

`$inspect.trace` is a debugging tool for reactivity. Add it as the first
line of an `$effect` or `$derived.by` to trace dependencies and discover
which one triggered an update.

```svelte
<script>
	let count = $state(0);
	let name = $state('world');

	$effect(() => {
		$inspect.trace('greeting effect');
		console.log(`Hello ${name}, count is ${count}`);
	});

	const message = $derived.by(() => {
		$inspect.trace('message derived');
		return `${name}: ${count}`;
	});
</script>
```

**When to use:**

- Something is not updating when it should
- An effect or derived is running more often than expected
- You need to identify which dependency triggered a re-run

**Note:** Remove `$inspect.trace` before production — it's for debugging
only, like `{@debug}`.
