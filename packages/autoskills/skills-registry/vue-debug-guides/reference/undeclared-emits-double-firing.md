---
title: Undeclared Emits Cause Double Event Firing
impact: HIGH
impactDescription: Native events re-emitted without declaration fire twice - once from emit() and once from native listener on root element
type: gotcha
tags: [vue3, emits, defineEmits, events, native-events, fallthrough]
---

# Undeclared Emits Cause Double Event Firing

**Impact: HIGH** - When a component re-emits a native DOM event (like `click`) without declaring it in `emits`, the event can fire twice. This happens because undeclared event listeners become part of `$attrs` and fall through to the root element, where they listen for native events while your `emit()` call also fires.

This is a common bug when wrapping native elements or migrating from Vue 2 to Vue 3.

## Task Checklist

- [ ] Declare all emitted events in `defineEmits()` or `emits` option
- [ ] Pay special attention when re-emitting native events (click, input, change, etc.)
- [ ] Check for double firing if component wraps native elements
- [ ] Understand that undeclared listeners fall through to `$attrs`

## The Problem

**Incorrect - Undeclared emit causes double firing:**
```vue
<!-- MyButton.vue -->
<script setup>
// NO defineEmits declaration!
</script>

<template>
  <!-- Native click listener from parent falls through to button -->
  <!-- PLUS we re-emit click -->
  <button @click="$emit('click', $event)">
    <slot></slot>
  </button>
</template>
```

```vue
<!-- Parent.vue -->
<template>
  <!-- This handler fires TWICE on each click! -->
  <MyButton @click="handleClick">Click me</MyButton>
</template>

<script setup>
function handleClick() {
  console.log('clicked') // Logs twice!
}
</script>
```

**What happens:**
1. User clicks the button
2. Native click event fires on the button element
3. `@click` falls through to button (because 'click' isn't in emits), triggering `handleClick`
4. The button's `@click="$emit('click', $event)"` also fires, emitting a component event
5. Parent's `@click="handleClick"` receives the emitted event, triggering `handleClick` again

## The Solution

**Correct - Declare the emit:**
```vue
<!-- MyButton.vue -->
<script setup>
// Declare 'click' as a component event
const emit = defineEmits(['click'])
</script>

<template>
  <!-- Now @click="handleClick" in parent only listens to emit() -->
  <button @click="emit('click', $event)">
    <slot></slot>
  </button>
</template>
```

```vue
<!-- Parent.vue -->
<template>
  <!-- Now fires only once -->
  <MyButton @click="handleClick">Click me</MyButton>
</template>
```

When you declare `click` in `emits`:
- Vue knows `@click` on the component is listening for a component event
- The listener does NOT fall through to the root element
- Only your explicit `emit('click')` triggers the parent's handler

## Options API Version

**Correct - Using emits option:**
```vue
<script>
export default {
  emits: ['click', 'input', 'change'],

  methods: {
    handleClick(event) {
      this.$emit('click', event)
    }
  }
}
</script>
```

## Common Scenarios

### Wrapping Form Inputs

```vue
<!-- CustomInput.vue -->
<script setup>
// Declare all events you re-emit
const emit = defineEmits(['input', 'change', 'focus', 'blur'])
</script>

<template>
  <input
    @input="emit('input', $event)"
    @change="emit('change', $event)"
    @focus="emit('focus', $event)"
    @blur="emit('blur', $event)"
  />
</template>
```

### Wrapper Components

```vue
<!-- IconButton.vue -->
<script setup>
const emit = defineEmits(['click'])
</script>

<template>
  <button @click="emit('click', $event)">
    <Icon :name="icon" />
    <slot></slot>
  </button>
</template>
```

## Alternative: Don't Re-emit, Let It Fall Through

If your component has a single root element and you want native event behavior:

```vue
<!-- MyButton.vue -->
<script setup>
// Don't declare 'click' - let it fall through naturally
const emit = defineEmits(['custom-action'])
</script>

<template>
  <!-- Native @click from parent falls through to this button -->
  <button>
    <slot></slot>
  </button>
</template>
```

```vue
<!-- Parent.vue -->
<template>
  <!-- This native click falls through to the button -->
  <MyButton @click="handleClick">Click me</MyButton>
</template>
```

This works because:
- You don't re-emit 'click' explicitly
- The native click listener falls through to the single root button
- Native click fires once when button is clicked

## Debugging Double Firing

```vue
<script setup>
function handleClick(event) {
  console.log('Event type:', event?.type)
  console.log('Is native:', event instanceof Event)
  console.trace('Click handler called')
}
</script>
```

If you see two stack traces with different origins, you have the double-firing issue.

## Reference
- [Vue 3 Migration - emits Option](https://v3-migration.vuejs.org/breaking-changes/emits-option)
- [Vue.js Component Events](https://vuejs.org/guide/components/events.html)
- [Vue.js Fallthrough Attributes](https://vuejs.org/guide/components/attrs.html)
