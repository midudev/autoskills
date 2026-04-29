---
title: Always Explicitly Type Event Handlers
impact: MEDIUM
impactDescription: Without explicit typing, event parameters have implicit 'any' type causing TypeScript errors in strict mode
type: gotcha
tags: [vue3, typescript, events, dom-events, composition-api]
---

# Always Explicitly Type Event Handlers

**Impact: MEDIUM** - Native DOM event handlers in Vue components have implicit `any` type for the `event` parameter. In TypeScript strict mode, this causes errors. You must explicitly type event parameters and use type assertions for `event.target`.

## Task Checklist

- [ ] Always type the `event` parameter explicitly (e.g., `Event`, `MouseEvent`)
- [ ] Use type assertions when accessing element-specific properties
- [ ] Consider using inline handlers for simple cases
- [ ] Be aware of Vue's synthetic event system

## The Problem

```vue
<script setup lang="ts">
// WRONG: event has implicit 'any' type
function handleChange(event) {  // Error in strict mode!
  console.log(event.target.value)  // Also error: target might be null
}

// WRONG: Missing type assertion for element access
function handleInput(event: Event) {
  console.log(event.target.value)  // Error: 'value' doesn't exist on EventTarget
}
</script>

<template>
  <input @change="handleChange" @input="handleInput" />
</template>
```

## The Solution

```vue
<script setup lang="ts">
// CORRECT: Explicit Event type + type assertion
function handleChange(event: Event) {
  const target = event.target as HTMLInputElement
  console.log(target.value)
}

// CORRECT: Specific event type when needed
function handleClick(event: MouseEvent) {
  console.log(event.clientX, event.clientY)
}

function handleKeydown(event: KeyboardEvent) {
  if (event.key === 'Enter') {
    submitForm()
  }
}

function handleSubmit(event: SubmitEvent) {
  event.preventDefault()
  const formData = new FormData(event.target as HTMLFormElement)
}
</script>

<template>
  <input @change="handleChange" />
  <button @click="handleClick">Click</button>
  <input @keydown="handleKeydown" />
  <form @submit="handleSubmit">...</form>
</template>
```

## Common Event Types

| Event | Type | Common Properties |
|-------|------|-------------------|
| click, dblclick | `MouseEvent` | clientX, clientY, button |
| keydown, keyup, keypress | `KeyboardEvent` | key, code, ctrlKey, shiftKey |
| input, change | `Event` | target (needs assertion) |
| focus, blur | `FocusEvent` | relatedTarget |
| submit | `SubmitEvent` | submitter |
| drag, dragstart, drop | `DragEvent` | dataTransfer |
| wheel, scroll | `WheelEvent` | deltaX, deltaY |
| touch events | `TouchEvent` | touches, changedTouches |

## Element-Specific Type Assertions

```vue
<script setup lang="ts">
// HTMLInputElement for text, number, checkbox, radio inputs
function handleTextInput(event: Event) {
  const input = event.target as HTMLInputElement
  console.log(input.value, input.checked)
}

// HTMLSelectElement for select dropdowns
function handleSelect(event: Event) {
  const select = event.target as HTMLSelectElement
  console.log(select.value, select.selectedIndex)
}

// HTMLTextAreaElement for textareas
function handleTextarea(event: Event) {
  const textarea = event.target as HTMLTextAreaElement
  console.log(textarea.value, textarea.selectionStart)
}

// HTMLFormElement for forms
function handleFormSubmit(event: SubmitEvent) {
  event.preventDefault()
  const form = event.target as HTMLFormElement
  const formData = new FormData(form)
}
</script>
```

## Inline Event Handler Pattern

For simple cases, inline handlers with type annotations work well:

```vue
<template>
  <!-- Inline with type assertion -->
  <input
    @input="(event: Event) => {
      const input = event.target as HTMLInputElement
      searchQuery = input.value
    }"
  />

  <!-- Or with $event cast -->
  <input @input="searchQuery = ($event.target as HTMLInputElement).value" />
</template>
```

## Generic Handler Pattern

Create reusable typed handlers:

```typescript
// utils/events.ts
export function getInputValue(event: Event): string {
  return (event.target as HTMLInputElement).value
}

export function getSelectValue(event: Event): string {
  return (event.target as HTMLSelectElement).value
}

export function getCheckboxChecked(event: Event): boolean {
  return (event.target as HTMLInputElement).checked
}
```

```vue
<script setup lang="ts">
import { getInputValue, getCheckboxChecked } from '@/utils/events'

const name = ref('')
const agreed = ref(false)
</script>

<template>
  <input @input="e => name = getInputValue(e)" />
  <input type="checkbox" @change="e => agreed = getCheckboxChecked(e)" />
</template>
```

## Vue Component Events

For Vue component events (not DOM events), use `defineEmits` for type safety:

```vue
<script setup lang="ts">
const emit = defineEmits<{
  'custom-event': [data: { id: number; name: string }]
}>()

// Handler for child component event
function handleChildEvent(data: { id: number; name: string }) {
  console.log(data.id, data.name)
}
</script>

<template>
  <!-- Custom component event - properly typed -->
  <ChildComponent @custom-event="handleChildEvent" />
</template>
```

## Avoiding currentTarget vs target Confusion

```typescript
function handleClick(event: MouseEvent) {
  // target: The element that triggered the event (could be a child)
  const target = event.target as HTMLElement

  // currentTarget: The element the listener is attached to
  const currentTarget = event.currentTarget as HTMLButtonElement

  // Be explicit about which you need
  if (target.tagName === 'SPAN') {
    // Clicked on span inside button
  }
}
```

## Reference
- [Vue.js TypeScript with Composition API - Event Handlers](https://vuejs.org/guide/typescript/composition-api.html#typing-event-handlers)
- [MDN Event Reference](https://developer.mozilla.org/en-US/docs/Web/Events)
- [TypeScript DOM Types](https://github.com/microsoft/TypeScript/blob/main/lib/lib.dom.d.ts)
