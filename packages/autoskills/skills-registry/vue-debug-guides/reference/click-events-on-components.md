---
title: Click Events on Custom Components Require Emit or Fallthrough
impact: HIGH
impactDescription: Native click events on custom components won't work without proper emit declaration or attribute fallthrough
type: gotcha
tags: [vue3, events, components, emit, click, migration]
---

# Click Events on Custom Components Require Emit or Fallthrough

**Impact: HIGH** - Unlike native HTML elements, custom Vue components don't automatically forward native DOM events like `click`. You must either emit the event explicitly, rely on attribute fallthrough to a single root element, or use the `.native` modifier (Vue 2 only, removed in Vue 3). This is a common source of confusion and migration issues.

## Task Checklist

- [ ] Declare emitted events using `defineEmits` in child components
- [ ] Emit click events from child component when needed
- [ ] Understand that single-root components automatically forward attrs to root
- [ ] Remove `.native` modifier when migrating from Vue 2 to Vue 3
- [ ] For multi-root components, explicitly bind `$attrs` or emit events

**Incorrect:**
```html
<!-- WRONG: Expecting native click to work on custom component -->
<template>
  <MyButton @click="handleClick">Click me</MyButton>
  <!-- This may not work as expected! -->
</template>
```

```html
<!-- WRONG: Vue 2 .native modifier doesn't exist in Vue 3 -->
<template>
  <MyButton @click.native="handleClick">Click me</MyButton>
  <!-- Error in Vue 3: .native modifier removed -->
</template>
```

```html
<!-- WRONG: Multi-root component with no attr binding -->
<!-- MyButton.vue -->
<template>
  <span>Icon</span>
  <button>{{ label }}</button>
  <!-- No root element to receive click! -->
</template>
```

**Correct:**
```html
<!-- CORRECT: Child component emits the click event -->
<!-- MyButton.vue -->
<template>
  <button @click="$emit('click', $event)">
    <slot></slot>
  </button>
</template>

<script setup>
defineEmits(['click'])
</script>

<!-- Parent.vue -->
<template>
  <MyButton @click="handleClick">Click me</MyButton>
</template>
```

```html
<!-- CORRECT: Single root element with automatic fallthrough -->
<!-- MyButton.vue -->
<template>
  <button>
    <slot></slot>
  </button>
  <!-- @click from parent automatically falls through to button -->
</template>

<!-- Parent.vue -->
<template>
  <MyButton @click="handleClick">Click me</MyButton>
</template>
```

```html
<!-- CORRECT: Multi-root component with explicit $attrs binding -->
<!-- MyButton.vue -->
<template>
  <span>Icon</span>
  <button v-bind="$attrs">
    <slot></slot>
  </button>
</template>

<script setup>
defineOptions({
  inheritAttrs: false
})
</script>
```

## Component Events Don't Bubble

```javascript
// Important: Component-emitted events do NOT bubble
// You can only listen to events from direct children

// WRONG: Trying to catch grandchild events
<GrandParent @child-event="handle">  <!-- Won't receive! -->
  <Parent>
    <Child @click="$emit('child-event')" />
  </Parent>
</GrandParent>

// CORRECT: Each level must relay the event
<GrandParent @child-event="handle">
  <Parent @child-event="$emit('child-event', $event)">
    <Child @click="$emit('child-event')" />
  </Parent>
</GrandParent>
```

## Vue 3 Native Event Behavior

```javascript
// In Vue 3, if you declare an event in emits:
defineEmits(['click'])

// Then @click on the component ONLY listens to emitted events
// NOT native click events

// If you don't declare 'click' in emits:
defineEmits(['custom-event'])

// Then @click on single-root component will:
// 1. Fall through to root element as native listener
// 2. Fire on native click
```

## Composition API Emit Pattern

```vue
<script setup>
// Define what events this component emits
const emit = defineEmits(['click', 'update', 'delete'])

function handleClick(event) {
  // Do component logic
  processClick()

  // Then emit to parent
  emit('click', event)
}
</script>

<template>
  <button @click="handleClick">
    <slot></slot>
  </button>
</template>
```

## Migration from Vue 2

```html
<!-- Vue 2: Used .native for native events on components -->
<MyComponent @click.native="handleClick" />

<!-- Vue 3: Remove .native, ensure component handles the event -->
<MyComponent @click="handleClick" />

<!-- Make sure MyComponent either:
     1. Has single root that receives fallthrough attrs
     2. Explicitly emits 'click' event
     3. Uses v-bind="$attrs" on intended element -->
```

## Reference
- [Vue.js Component Events](https://vuejs.org/guide/components/events.html)
- [Vue.js Fallthrough Attributes](https://vuejs.org/guide/components/attrs.html)
- [Vue 3 Migration - .native Modifier Removed](https://v3-migration.vuejs.org/breaking-changes/v-on-native-modifier-removed.html)
