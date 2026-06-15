# @attach Patterns

> Available in Svelte 5.29+

## Why @attach Over use: Actions?

Attachments are **fully reactive**. When dependencies change, the attachment
re-runs automatically. Actions don't do this - they only run once on mount.

```svelte
<!-- use: - runs ONCE, ignores content changes -->
<button use:tooltip={content}>Won't update</button>

<!-- @attach - re-runs when content changes -->
<button {@attach tooltip(content)}>Updates!</button>
```

## Pattern 1: Third-Party Library Integration

The most common use case - integrating DOM-manipulating libraries like image
zoom, tooltips, editors, etc.

### ImageZoom Example

```svelte
<script>
	import ImageZoom from 'js-image-zoom';

	const options = { width: 400, zoomWidth: 500 };

	function useZoom(dom) {
		new ImageZoom(dom, options);
		return () => {
			console.log('cleaning up');
		};
	}
</script>

<figure {@attach useZoom}>
	<img src="photo.jpg" alt="zoomable photo" />
</figure>
```

### Tippy.js Tooltips

```svelte
<script>
	import tippy from 'tippy.js';

	function tooltip(content) {
		return (element) => {
			const instance = tippy(element, { content });
			return instance.destroy;
		};
	}

	let tip = $state('Hello!');
</script>

<!-- Tooltip content updates reactively -->
<button {@attach tooltip(tip)}>Hover me</button>

<input bind:value={tip} placeholder="Change tooltip" />
```

## Pattern 2: Canvas Drawing

Perfect for canvas where you need reactive updates without recreating the
context.

```svelte
<script>
	let color = $state('#ff0000');
	let size = $state(50);
</script>

<canvas
	width="200"
	height="200"
	{@attach (canvas) => {
		const ctx = canvas.getContext('2d');

		// This inner effect re-runs on color/size change
		// but canvas context is preserved
		$effect(() => {
			ctx.clearRect(0, 0, canvas.width, canvas.height);
			ctx.fillStyle = color;
			ctx.fillRect(
				(canvas.width - size) / 2,
				(canvas.height - size) / 2,
				size,
				size
			);
		});
	}}
/>

<input type="color" bind:value={color} />
<input type="range" bind:value={size} min="10" max="100" />
```

## Pattern 3: Component Pass-Through

Attachments automatically pass through wrapper components when you spread props.
This enables "augmented element" patterns.

```svelte
<!-- Button.svelte -->
<script>
	let { children, ...props } = $props();
</script>

<button {...props}>
	{@render children?.()}
</button>
```

```svelte
<!-- App.svelte -->
<script>
	import Button from './Button.svelte';
	import { tooltip } from './attachments.js';
</script>

<!-- The attachment passes through to the inner <button>! -->
<Button {@attach tooltip('Click me for help')}>
	Help
</Button>
```

## Pattern 4: Attachment Factories

Factory functions return attachment implementations, enabling parameterized
behavior.

```svelte
<script>
	function highlight(color) {
		return (element) => {
			const original = element.style.backgroundColor;
			element.style.backgroundColor = color;

			return () => {
				element.style.backgroundColor = original;
			};
		};
	}

	let isActive = $state(false);
</script>

<!-- Attachment recreates when isActive changes -->
{#if isActive}
	<div {@attach highlight('yellow')}>Highlighted!</div>
{/if}
```

## Pattern 5: Avoiding Expensive Re-runs

For expensive setup work, pass data via accessor function and read it in a child
effect.

```svelte
<script>
	function expensiveChart(getData) {
		return (node) => {
			// Expensive - runs ONCE
			const chart = createComplexChart(node);

			// Cheap - re-runs on data change
			$effect(() => {
				chart.update(getData());
			});

			return () => chart.destroy();
		};
	}

	let data = $state([1, 2, 3]);
</script>

<!-- Pass accessor function, not the data directly -->
<div {@attach expensiveChart(() => data)}>Chart</div>
```

## Pattern 6: Converting Legacy Actions

Use `fromAction` to convert existing action libraries to attachments.

```svelte
<script>
	import { fromAction } from 'svelte/attachments';
	import { someAction } from 'some-legacy-library';

	const attached = fromAction(someAction);
</script>

<!-- Now works as an attachment with full reactivity -->
<div {@attach attached(options)}>...</div>
```

## Pattern 7: Multiple Attachments

Elements can have any number of attachments.

```svelte
<button
	{@attach tooltip('Help text')}
	{@attach trackClicks}
	{@attach highlight(isActive ? 'yellow' : 'transparent')}
>
	Multi-attached button
</button>
```

## Pattern 8: Inline Attachments

For one-off cases, define attachments inline.

```svelte
<div
	{@attach (el) => {
		console.log('mounted:', el);
		return () => console.log('unmounted');
	}}
>
	Lifecycle logging
</div>
```

## Pattern 9: DOM-Controlling Libraries (ProseMirror, etc.)

For libraries that want to control their own DOM segment, combine @attach with
the imperative component API.

```svelte
<script>
	import { mount, unmount } from 'svelte';
	import MyComponent from './MyComponent.svelte';

	function proseMirrorNodeView(node) {
		return (dom) => {
			// ProseMirror controls this DOM node
			// but we can mount Svelte components inside it
			const component = mount(MyComponent, {
				target: dom,
				props: { data: node.attrs }
			});

			return () => unmount(component);
		};
	}
</script>
```

## Pattern 10: Registering Elements with Global State

Use @attach to register DOM elements with state classes. This avoids $effect
sync loops and is cleaner than bind:this chains.

```ts
// modal-state.svelte.ts
class ModalState {
  dialog: HTMLDialogElement | null = null;
  input: HTMLInputElement | null = null;
  is_open = $state(false);

  // Attach functions return cleanup
  register = (el: HTMLDialogElement) => {
    this.dialog = el;
    return () => {
      this.dialog = null;
    };
  };

  register_input = (el: HTMLInputElement) => {
    this.input = el;
    return () => {
      this.input = null;
    };
  };

  open() {
    if (!this.dialog?.open) {
      this.is_open = true;
      this.dialog?.showModal();
      this.input?.focus();
    }
  }

  close() {
    this.is_open = false;
    this.dialog?.close();
  }

  toggle() {
    this.is_open ? this.close() : this.open();
  }
}

export const modal_state = new ModalState();
```

```svelte
<!-- Modal.svelte -->
<script>
	import { modal_state } from './modal-state.svelte';
</script>

<dialog
	{@attach modal_state.register}
	onclose={modal_state.close}
>
	<input {@attach modal_state.register_input} />
</dialog>
```

```svelte
<!-- Anywhere else - no component ref needed -->
<script>
	import { modal_state } from './modal-state.svelte';
</script>

<button onclick={modal_state.toggle}>Open Modal</button>
```

**Benefits:**

- No $effect needed for state/DOM sync
- State controls element directly via imperative methods
- Clean cleanup on unmount
- Any component can open/close without bind:this chains
- Avoids event loops from `dialog.close()` firing `onclose`

## When to Still Use `use:` Actions

- Legacy code/libraries not yet updated
- When you specifically DON'T want re-runs on argument change
- Simple one-time DOM setup with no reactive dependencies
