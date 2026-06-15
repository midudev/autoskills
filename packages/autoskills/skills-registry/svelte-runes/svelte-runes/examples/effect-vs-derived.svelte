<!--
  EXAMPLE: When to use $derived vs $effect

  This demonstrates the key difference:
  - $derived: For computed values (data transformation)
  - $effect: For side effects (logging, DOM, external APIs)
-->

<script lang="ts">
	let count = $state(0);

	// ✅ CORRECT: Use $derived for computed values
	let doubled = $derived(count * 2);
	let tripled = $derived(count * 3);
	let message = $derived(
		count === 0 ? 'Zero' : count > 10 ? 'High' : 'Low',
	);

	// ✅ CORRECT: Use $effect for side effects
	$effect(() => {
		// Side effect: Logging
		console.log(`Count changed to ${count}`);

		// Side effect: Update document title
		document.title = `Count: ${count}`;

		// Side effect: Save to localStorage
		localStorage.setItem('count', String(count));
	});

	// ✅ CORRECT: $effect with cleanup
	$effect(() => {
		const interval = setInterval(() => {
			console.log('Current count:', count);
		}, 1000);

		// Cleanup function (runs when effect re-runs or component unmounts)
		return () => clearInterval(interval);
	});

	// ❌ WRONG: Don't use $effect for derived state
	// let wrongDoubled = $state(0);
	// $effect(() => {
	//   wrongDoubled = count * 2;  // BAD - use $derived!
	// });

	// ❌ WRONG: Don't update dependencies in $effect
	// $effect(() => {
	//   count++;  // INFINITE LOOP!
	// });

	function increment() {
		count++;
	}

	function decrement() {
		count--;
	}

	function reset() {
		count = 0;
	}
</script>

<div>
	<h2>$derived vs $effect Demo</h2>

	<div class="counter">
		<button onclick={decrement}>-</button>
		<span>{count}</span>
		<button onclick={increment}>+</button>
		<button onclick={reset}>Reset</button>
	</div>

	<div class="computed">
		<h3>Computed Values ($derived)</h3>
		<p>Doubled: {doubled}</p>
		<p>Tripled: {tripled}</p>
		<p>Message: {message}</p>
	</div>

	<div class="effects">
		<h3>Side Effects ($effect)</h3>
		<ul>
			<li>Check console for log output</li>
			<li>Check document title</li>
			<li>Check localStorage (key: 'count')</li>
		</ul>
	</div>

	<div class="guidelines">
		<h3>When to Use Each</h3>

		<h4>Use $derived when:</h4>
		<ul>
			<li>Transforming data (multiply, format, filter)</li>
			<li>Computing values based on other state</li>
			<li>Value is used in template</li>
			<li>Need read-only computed property</li>
		</ul>

		<h4>Use $effect when:</h4>
		<ul>
			<li>Logging or analytics</li>
			<li>Updating external state (localStorage, DOM)</li>
			<li>Fetching data</li>
			<li>Setting up subscriptions (intervals, listeners)</li>
			<li>Any operation with side effects</li>
		</ul>
	</div>
</div>

<style>
	.counter {
		display: flex;
		gap: 1rem;
		align-items: center;
		margin: 1rem 0;
	}

	button {
		padding: 0.5rem 1rem;
		font-size: 1rem;
		cursor: pointer;
	}

	.counter span {
		font-size: 2rem;
		font-weight: bold;
		min-width: 3rem;
		text-align: center;
	}

	.computed,
	.effects,
	.guidelines {
		margin: 2rem 0;
		padding: 1rem;
		border: 1px solid #ccc;
		border-radius: 0.5rem;
	}

	h3 {
		margin-top: 0;
	}

	h4 {
		margin-bottom: 0.5rem;
	}

	ul {
		margin-top: 0.5rem;
	}
</style>
