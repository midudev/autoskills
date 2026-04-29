# Fallthrough Event Listeners Are Additive

## Rule

When an event listener is passed to a component as a fallthrough attribute, it is added to the root element's existing listeners of the same type - both will trigger. This is different from props where values are replaced. Be aware that both the component's internal handler and the parent's handler will execute.

## Why This Matters

- Developers may expect event listeners to override like props
- Both handlers execute, which can cause double submissions, duplicate API calls
- Order of execution: internal handler first, then fallthrough handler
- This is actually useful for composition but can cause bugs if unexpected

## Bad Code

```vue
<!-- BaseButton.vue - Potential double-action bug -->
<template>
  <button @click="internalClick">
    <slot />
  </button>
</template>

<script setup>
const emit = defineEmits(['action'])

function internalClick() {
  // This runs first
  emit('action')
  console.log('Internal click handler')
}
</script>

<!-- Parent.vue -->
<template>
  <BaseButton @click="parentClick">Submit</BaseButton>
</template>

<script setup>
function parentClick() {
  // This ALSO runs (after internal)
  submitForm()  // Might cause double submission!
  console.log('Parent click handler')
}
</script>

<!--
  RESULT: Both handlers fire!
  Console output:
  1. "Internal click handler"
  2. "Parent click handler"

  If both trigger API calls, you get duplicate requests
-->
```

## Good Code

### Option 1: Prevent fallthrough with inheritAttrs: false

```vue
<!-- BaseButton.vue - Control event handling explicitly -->
<script setup>
defineOptions({
  inheritAttrs: false
})

const emit = defineEmits(['click'])

function handleClick(event) {
  // Component controls all click behavior
  console.log('Handled internally')
  emit('click', event)  // Explicitly forward if needed
}
</script>

<template>
  <button @click="handleClick">
    <slot />
  </button>
</template>
```

### Option 2: Document the additive behavior

```vue
<!-- BaseButton.vue - Design for composition -->
<script setup>
/**
 * BaseButton - A composable button component
 *
 * Note: Click handlers passed to this component are ADDITIVE.
 * The internal handler runs first, then any parent @click handler.
 * Use @action event if you only want to respond to the action.
 */
const emit = defineEmits(['action'])

function internalClick() {
  // Internal logic (e.g., ripple effect, analytics)
  emit('action')
}
</script>

<template>
  <button @click="internalClick">
    <slot />
  </button>
</template>

<!-- Parent.vue - Use the custom event instead -->
<template>
  <!-- Use @action, not @click, to avoid double handling -->
  <BaseButton @action="handleAction">Submit</BaseButton>
</template>
```

### Option 3: Use stopPropagation if needed

```vue
<!-- BaseButton.vue - Stop event propagation when needed -->
<script setup>
const props = defineProps({
  stopPropagation: Boolean
})

function handleClick(event) {
  if (props.stopPropagation) {
    event.stopPropagation()
  }
  // Internal handling...
}
</script>

<template>
  <button @click="handleClick">
    <slot />
  </button>
</template>
```

## Using Additive Behavior Intentionally

The additive behavior can be useful for extending functionality:

```vue
<!-- EnhancedButton.vue - Leveraging additive listeners -->
<template>
  <button
    @click="trackClick"
    @focus="trackFocus"
  >
    <slot />
  </button>
</template>

<script setup>
function trackClick() {
  analytics.track('button_click')
  // Parent's @click will also run - that's intentional!
}

function trackFocus() {
  analytics.track('button_focus')
}
</script>

<!-- Parent.vue -->
<template>
  <!-- Both analytics AND form submission happen -->
  <EnhancedButton @click="submitForm">Submit</EnhancedButton>
</template>
```

## Execution Order

```vue
<script setup>
// Component
function componentHandler() {
  console.log('1. Component handler (first)')
}
</script>

<template>
  <button @click="componentHandler">Click</button>
</template>

<!-- Parent passes @click -->
<!-- Execution order:
     1. componentHandler (defined in component)
     2. parentHandler (passed as fallthrough)
-->
```

## Best Practices

1. **For UI components**: Use `inheritAttrs: false` and emit custom events
2. **For HOCs/wrappers**: Document that listeners are additive
3. **For analytics/tracking**: Leverage additive behavior intentionally
4. **Avoid side effects**: Don't assume your handler is the only one running

## References

- [Fallthrough Attributes - v-on Listener Inheritance](https://vuejs.org/guide/components/attrs.html#v-on-listener-inheritance)
- [Component Events](https://vuejs.org/guide/components/events.html)
