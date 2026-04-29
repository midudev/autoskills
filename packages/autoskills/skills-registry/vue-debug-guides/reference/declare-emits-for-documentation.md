---
title: Always Declare Emits for Documentation and Validation
impact: MEDIUM
impactDescription: Undeclared emits cause warnings, break TypeScript inference, and prevent event validation
type: best-practice
tags: [vue3, emits, defineEmits, component-events, typescript, documentation]
---

# Always Declare Emits for Documentation and Validation

**Impact: MEDIUM** - Declaring emitted events with `defineEmits()` or the `emits` option is technically optional, but strongly recommended. Without declarations, Vue shows runtime warnings, TypeScript can't infer event types, and you lose the ability to validate event payloads.

Declared emits also serve as self-documentation, making it immediately clear what events a component can emit.

## Task Checklist

- [ ] Use `defineEmits()` in `<script setup>` to declare all events
- [ ] Use `emits` option when not using `<script setup>`
- [ ] Add TypeScript types for event payloads
- [ ] Consider adding validation functions for complex payloads
- [ ] Document the purpose of each event

## The Warning

When you emit without declaring:

```vue
<script setup>
// No defineEmits declaration
function handleClick() {
  emit('select', item) // Vue warns in dev mode
}
</script>
```

Vue warns:
```
[Vue warn]: Component emitted event "select" but it is neither declared
in the emits option nor as an "onSelect" prop.
```

## Basic Declaration

**Correct - Array syntax:**
```vue
<script setup>
const emit = defineEmits(['submit', 'cancel', 'update'])

function handleSubmit() {
  emit('submit', formData)
}

function handleCancel() {
  emit('cancel')
}
</script>
```

**Correct - Options API:**
```js
export default {
  emits: ['submit', 'cancel', 'update'],

  methods: {
    handleSubmit() {
      this.$emit('submit', this.formData)
    }
  }
}
```

## TypeScript Typed Emits

**Correct - Type-based declaration (recommended for TypeScript):**
```vue
<script setup lang="ts">
interface User {
  id: number
  name: string
}

const emit = defineEmits<{
  submit: [data: FormData]
  cancel: []
  'update:modelValue': [value: string]
  select: [user: User, index: number]
}>()

// Now TypeScript enforces correct payloads
emit('submit', formData) // OK
emit('submit') // Error: Expected 1 argument
emit('select', user) // Error: Expected 2 arguments
emit('unknown') // Error: Unknown event
</script>
```

**Alternative syntax (Vue 3.3+):**
```vue
<script setup lang="ts">
const emit = defineEmits<{
  (e: 'submit', data: FormData): void
  (e: 'cancel'): void
  (e: 'update:modelValue', value: string): void
}>()
</script>
```

## Event Validation

You can validate event payloads at runtime:

**Correct - Validation functions:**
```vue
<script setup>
const emit = defineEmits({
  // No validation, just declaration
  cancel: null,

  // Validate payload
  submit: (payload) => {
    if (!payload.email) {
      console.warn('Submit event requires email')
      return false
    }
    return true
  },

  // Validate with type checking
  click: (id) => typeof id === 'number'
})
</script>
```

Returning `false` from a validator logs a console warning but doesn't prevent the event from being emitted.

## Benefits of Declaring Emits

### 1. Fallthrough Attribute Separation

Without declaration, native event listeners fall through to the root element:

```vue
<!-- ParentComponent.vue -->
<ChildComponent @click="handleClick" />
```

```vue
<!-- ChildComponent.vue - WITHOUT emits declaration -->
<template>
  <!-- Native click listener falls through to button -->
  <button>Click me</button>
</template>
```

With declaration, Vue knows it's a component event:

```vue
<script setup>
// Now Vue knows 'click' is a component event, not native
const emit = defineEmits(['click'])
</script>
```

### 2. Self-Documentation

```vue
<script setup>
// Clear contract: this component emits these events
const emit = defineEmits<{
  'row-click': [row: TableRow]
  'row-select': [row: TableRow, selected: boolean]
  'page-change': [page: number]
  'sort-change': [column: string, direction: 'asc' | 'desc']
}>()
</script>
```

### 3. IDE Support

With declarations, your IDE can:
- Autocomplete event names when using the component
- Show event payload types
- Warn about typos in event names
- Navigate to event definitions

## $emit in Template vs emit in Script

```vue
<script setup>
// $emit is available in template, but...
// emit() is needed in <script setup>
const emit = defineEmits(['submit'])

function handleSubmit() {
  // $emit doesn't work here - use emit()
  emit('submit', data)
}
</script>

<template>
  <!-- $emit works in template -->
  <button @click="$emit('submit', data)">Submit</button>

  <!-- Or use the declared emit function -->
  <button @click="emit('submit', data)">Submit</button>
</template>
```

## Reference
- [Vue.js Component Events - Declaring Emitted Events](https://vuejs.org/guide/components/events.html#declaring-emitted-events)
- [Vue.js Component Events - Events Validation](https://vuejs.org/guide/components/events.html#events-validation)
- [Vue 3 Migration - emits Option](https://v3-migration.vuejs.org/breaking-changes/emits-option)
