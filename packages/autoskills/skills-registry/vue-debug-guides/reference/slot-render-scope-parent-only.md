---
title: Slot Content Only Has Access to Parent Component Scope
impact: HIGH
impactDescription: Attempting to access child component data in slot content results in undefined values or errors
type: gotcha
tags: [vue3, slots, scope, reactivity, common-mistake]
---

# Slot Content Only Has Access to Parent Component Scope

**Impact: HIGH** - Slot content is compiled in the parent component's scope and cannot access data defined in the child component. This follows JavaScript's lexical scoping rules and is a common source of confusion.

When you provide content for a slot, that content is defined in your parent template and can only access data available in the parent component. The child component's internal state is not accessible unless explicitly passed via scoped slots.

## Task Checklist

- [ ] Remember that slot content is compiled in parent scope
- [ ] Never try to access child component data directly in slot content
- [ ] Use scoped slots when child data needs to be exposed to parent
- [ ] Check that all template expressions reference data available in the current component

**Incorrect:**
```vue
<!-- Parent.vue -->
<script setup>
import SubmitButton from './SubmitButton.vue'
</script>

<template>
  <!-- BAD: Trying to access child's buttonText - this will be undefined -->
  <SubmitButton>{{ buttonText }}</SubmitButton>

  <!-- BAD: Trying to access child's isLoading state -->
  <SubmitButton>
    <span v-if="isLoading">Loading...</span>
    <span v-else>Submit</span>
  </SubmitButton>
</template>
```

```vue
<!-- SubmitButton.vue (Child) -->
<script setup>
import { ref } from 'vue'

const buttonText = ref('Click me')  // Not accessible in parent's slot content
const isLoading = ref(false)        // Not accessible in parent's slot content
</script>

<template>
  <button>
    <slot></slot>
  </button>
</template>
```

**Correct - Use Scoped Slots:**
```vue
<!-- SubmitButton.vue (Child) - Expose data via slot props -->
<script setup>
import { ref } from 'vue'

const buttonText = ref('Click me')
const isLoading = ref(false)
</script>

<template>
  <button>
    <!-- Pass child data as slot props -->
    <slot :text="buttonText" :loading="isLoading"></slot>
  </button>
</template>
```

```vue
<!-- Parent.vue -->
<script setup>
import SubmitButton from './SubmitButton.vue'
</script>

<template>
  <!-- GOOD: Receive child data via scoped slot -->
  <SubmitButton v-slot="{ text, loading }">
    <span v-if="loading">Loading...</span>
    <span v-else>{{ text }}</span>
  </SubmitButton>
</template>
```

**Correct - Use Parent Data:**
```vue
<!-- Parent.vue -->
<script setup>
import { ref } from 'vue'
import SubmitButton from './SubmitButton.vue'

// Define data in parent where slot content is compiled
const message = ref('Submit Form')
const isSubmitting = ref(false)
</script>

<template>
  <!-- GOOD: Using parent's own data in slot content -->
  <SubmitButton>
    <span v-if="isSubmitting">Processing...</span>
    <span v-else>{{ message }}</span>
  </SubmitButton>
</template>
```

## The Function Analogy

Think of slots as function parameters:

```javascript
// Slot content is like a callback defined in parent scope
function Parent() {
  const parentData = 'Hello'

  // This callback can only see parentData, not childData
  Child((slotProps) => {
    return parentData + (slotProps?.text || '')
  })
}

function Child(slotCallback) {
  const childData = 'World'  // Not visible to callback

  // Must explicitly pass data via slot props
  return slotCallback({ text: childData })
}
```

## Reference
- [Vue.js Slots - Render Scope](https://vuejs.org/guide/components/slots.html#render-scope)
