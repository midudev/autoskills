# Component Libraries

## Bits UI

Headless, unstyled, accessible components for Svelte.

```bash
pnpm add bits-ui
```

```svelte
<script>
	import { Button } from 'bits-ui';
</script>

<Button.Root class="my-button">Click me</Button.Root>
```

**Key features:**

- Fully unstyled - bring your own CSS
- Accessible by default (ARIA, keyboard nav)
- Composable compound components

**Docs:** [bits-ui.com](https://bits-ui.com)

---

## Ark UI

Full-featured component library with Svelte support.

```bash
pnpm add @ark-ui/svelte
```

```svelte
<script>
	import { Dialog } from '@ark-ui/svelte';
</script>

<Dialog.Root>
	<Dialog.Trigger>Open</Dialog.Trigger>
	<Dialog.Backdrop />
	<Dialog.Positioner>
		<Dialog.Content>
			<Dialog.Title>Title</Dialog.Title>
			<Dialog.Description>Description</Dialog.Description>
			<Dialog.CloseTrigger>Close</Dialog.CloseTrigger>
		</Dialog.Content>
	</Dialog.Positioner>
</Dialog.Root>
```

**Docs:** [ark-ui.com](https://ark-ui.com)

---

## Melt UI

Low-level primitives (builders) for maximum flexibility.

```bash
pnpm add @melt-ui/svelte
```

```svelte
<script>
	import { createDialog } from '@melt-ui/svelte';

	const {
		elements: { trigger, portalled, overlay, content, title, close },
		states: { open },
	} = createDialog();
</script>

<button use:melt={$trigger}>Open</button>

{#if $open}
	<div use:melt={$portalled}>
		<div use:melt={$overlay} />
		<div use:melt={$content}>
			<h2 use:melt={$title}>Title</h2>
			<button use:melt={$close}>Close</button>
		</div>
	</div>
{/if}
```

**Key difference:** Melt uses builders (functions) instead of
components.

**Docs:** [melt-ui.com](https://melt-ui.com)

---

## Which to Choose?

| Library | Style    | Approach   | Best For            |
| ------- | -------- | ---------- | ------------------- |
| Bits UI | Unstyled | Components | Quick accessible UI |
| Ark UI  | Unstyled | Components | Feature-rich apps   |
| Melt UI | Unstyled | Builders   | Maximum control     |

All three work with Svelte 5 runes.
