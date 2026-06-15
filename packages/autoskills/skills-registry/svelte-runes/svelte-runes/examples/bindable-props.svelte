<!--
  EXAMPLE: $bindable Props - Two-Way Binding

  This shows proper examples of creating bindable components.
  The commented sections show how to create actual component files.
-->

<script lang="ts">
	// Demo state
	let name = $state("");
	let email = $state("");
	let isEnabled = $state(false);
	let count = $state(0);

	let formValid = $derived(name.length > 0 && email.includes("@"));
</script>

<div class="demo">
	<h2>$bindable Props Demo</h2>

	<div class="form">
		<h3>Interactive Form</h3>

		<div class="field">
			<label>
				Name
				<input type="text" bind:value={name} />
			</label>
		</div>

		<div class="field">
			<label>
				Email
				<input type="email" bind:value={email} />
			</label>
		</div>

		<div class="field">
			<label>
				<input type="checkbox" bind:checked={isEnabled} />
				Enable feature
			</label>
		</div>

		<div class="field">
			<button onclick={() => count++}>Count: {count}</button>
		</div>

		<p class={{ valid: formValid, invalid: !formValid }}>
			Form is {formValid ? "valid" : "invalid"}
		</p>
	</div>

	<div class="state-display">
		<h3>Current State</h3>
		<pre>{JSON.stringify(
				{ name, email, isEnabled, count, formValid },
				null,
				2,
			)}</pre>
	</div>

	<div class="guidelines">
		<h3>Creating Bindable Components</h3>

		<h4>1. TextInput Component (with $bindable)</h4>
		<pre><code
				>&lt;!-- TextInput.svelte --&gt;
&lt;script lang="ts"&gt;
  interface Props &#123;
    value?: string;
    label: string;
  &#125;

  let &#123; value = $bindable(''), label &#125;: Props = $props();
&lt;/script&gt;

&lt;label&gt;
  &#123;label&#125;
  &lt;input type="text" bind:value /&gt;
&lt;/label&gt;

&lt;!-- Usage --&gt;
&lt;TextInput bind:value=&#123;name&#125; label="Name" /&gt;</code
			></pre>

		<h4>2. Counter Component (callback pattern - no $bindable)</h4>
		<pre><code
				>&lt;!-- Counter.svelte --&gt;
&lt;script lang="ts"&gt;
  interface Props &#123;
    count: number;
    onIncrement: () =&gt; void;
  &#125;

  let &#123; count, onIncrement &#125;: Props = $props();
&lt;/script&gt;

&lt;button onclick=&#123;onIncrement&#125;&gt;Count: &#123;count&#125;&lt;/button&gt;

&lt;!-- Usage --&gt;
&lt;Counter &#123;count&#125; onIncrement=&#123;() =&gt; count++&#125; /&gt;</code
			></pre>

		<h4>When to Use $bindable</h4>
		<ul>
			<li>✅ Form input wrappers</li>
			<li>✅ Parent needs to read AND write</li>
			<li>✅ Two-way data flow is natural</li>
			<li>❌ Parent only reads (use callback)</li>
			<li>❌ Need validation (use callback)</li>
		</ul>

		<h4>Decision Tree</h4>
		<pre>Parent needs to read child state?
├─ No → Pass callbacks
└─ Yes → Parent needs to UPDATE child?
    ├─ No → Callback (onChange)
    └─ Yes → Use $bindable()</pre>
	</div>
</div>

<style>
	.demo {
		max-width: 800px;
		margin: 0 auto;
		padding: 2rem;
	}

	.form {
		margin: 2rem 0;
		padding: 1rem;
		border: 1px solid #ccc;
		border-radius: 0.5rem;
	}

	.field {
		margin: 1rem 0;
	}

	label {
		display: flex;
		align-items: center;
		gap: 0.5rem;
		font-weight: 500;
	}

	input[type="text"],
	input[type="email"] {
		padding: 0.5rem;
		font-size: 1rem;
		border: 1px solid #ccc;
		border-radius: 0.25rem;
		flex: 1;
	}

	input[type="checkbox"] {
		width: 1.25rem;
		height: 1.25rem;
	}

	button {
		padding: 0.5rem 1rem;
		font-size: 1rem;
		cursor: pointer;
		background: #007bff;
		color: white;
		border: none;
		border-radius: 0.25rem;
	}

	button:hover {
		background: #0056b3;
	}

	.valid {
		color: green;
		font-weight: bold;
	}

	.invalid {
		color: red;
		font-weight: bold;
	}

	.state-display {
		margin: 2rem 0;
		padding: 1rem;
		background: #f5f5f5;
		border-radius: 0.5rem;
	}

	.state-display pre {
		margin: 0;
		overflow-x: auto;
	}

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
		margin: 1rem 0 0.5rem 0;
	}

	pre {
		background: #f5f5f5;
		padding: 1rem;
		border-radius: 0.25rem;
		overflow-x: auto;
	}

	code {
		font-family: "Courier New", monospace;
		font-size: 0.9rem;
	}

	ul {
		margin: 0.5rem 0;
	}
</style>
