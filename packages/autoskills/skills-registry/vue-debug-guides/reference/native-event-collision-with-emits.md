---
title: Declaring Native Event Names in Emits Blocks Native Listeners
impact: MEDIUM
impactDescription: Declaring native events like 'click' in emits prevents native DOM event listeners from working
type: gotcha
tags: [vue3, emits, native-events, click, event-collision]
---

# Declaring Native Event Names in Emits Blocks Native Listeners

**Impact: MEDIUM** - When you declare a native DOM event name (like `click`, `input`, `focus`) in your component's `emits` option, listeners for that event will ONLY respond to your component's `emit()` calls. They will no longer respond to the actual native DOM events on the root element.

This can cause unexpected behavior where clicks seem to stop working on your component.

## Task Checklist

- [ ] Understand that declaring native event names changes listener behavior
- [ ] Always emit the event when you declare it
- [ ] Don't declare native events if you want fallthrough behavior
- [ ] Test click/input handling after adding emits declarations

## The Problem

**Incorrect - Declaring but not emitting:**
```vue
<!-- ClickableCard.vue -->
<script setup>
// Declared 'click' but never emit it!
const emit = defineEmits(['click', 'select'])
</script>

<template>
  <div class="card">
    <slot></slot>
  </div>
</template>
```

```vue
<!-- Parent.vue -->
<template>
  <!-- This NEVER fires! Native clicks are blocked -->
  <ClickableCard @click="handleClick">
    Click me
  </ClickableCard>
</template>
```

**Why it fails:**
1. `click` is declared in `emits`
2. Vue treats `@click` as a component event listener
3. Native click on the `<div>` doesn't trigger component event
4. Since `emit('click')` is never called, handler never fires

## The Solution

**Option 1: Emit the event explicitly:**
```vue
<!-- ClickableCard.vue -->
<script setup>
const emit = defineEmits(['click', 'select'])
</script>

<template>
  <!-- Explicitly emit click when div is clicked -->
  <div class="card" @click="emit('click', $event)">
    <slot></slot>
  </div>
</template>
```

**Option 2: Don't declare native events (use fallthrough):**
```vue
<!-- ClickableCard.vue -->
<script setup>
// Only declare custom events, not native ones
const emit = defineEmits(['select', 'custom-action'])
</script>

<template>
  <!-- Native @click from parent falls through to this div -->
  <div class="card">
    <slot></slot>
  </div>
</template>
```

```vue
<!-- Parent.vue -->
<template>
  <!-- Native click falls through and works -->
  <ClickableCard @click="handleClick">
    Click me
  </ClickableCard>
</template>
```

## Native Events Affected

This applies to any native DOM event you might declare:

| Event | Behavior When Declared |
|-------|----------------------|
| `click` | Only responds to `emit('click')`, not native clicks |
| `input` | Only responds to `emit('input')`, not native input |
| `change` | Only responds to `emit('change')`, not native change |
| `focus` | Only responds to `emit('focus')`, not native focus |
| `blur` | Only responds to `emit('blur')`, not native blur |
| `submit` | Only responds to `emit('submit')`, not native form submit |
| `keydown` | Only responds to `emit('keydown')`, not native keydown |

## When This Is Intentional

Sometimes you WANT to intercept native events:

```vue
<!-- CustomInput.vue -->
<script setup>
// Intentionally intercept 'input' to transform the value
const emit = defineEmits(['input', 'update:modelValue'])

function handleInput(event) {
  const transformedValue = event.target.value.toUpperCase()
  emit('input', transformedValue) // Emit transformed value, not raw event
  emit('update:modelValue', transformedValue)
}
</script>

<template>
  <input @input="handleInput" />
</template>
```

Here, declaring `input` is correct because you want to intercept and transform the native event before passing it to the parent.

## Debugging Tips

If your click handlers aren't firing:

1. Check if the event is declared in `emits`
2. If declared, ensure you're calling `emit('click')` somewhere
3. If you want native behavior, remove from `emits` declaration
4. Use Vue DevTools to see which events are being emitted

```vue
<script setup>
const emit = defineEmits(['click'])

function handleClick(event) {
  console.log('Native click received, now emitting component event')
  emit('click', event)
}
</script>

<template>
  <div @click="handleClick">Click me</div>
</template>
```

## Reference
- [Vue.js Component Events](https://vuejs.org/guide/components/events.html)
- [Vue.js Fallthrough Attributes](https://vuejs.org/guide/components/attrs.html)
