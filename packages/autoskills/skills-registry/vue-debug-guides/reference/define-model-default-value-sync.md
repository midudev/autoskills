---
title: defineModel Default Value Can Cause Parent-Child Desync
impact: HIGH
impactDescription: Default values in defineModel don't sync back to parent, causing state inconsistency
type: capability
tags: [vue3, v-model, defineModel, components, props, two-way-binding]
---

# defineModel Default Value Can Cause Parent-Child Desync

**Impact: HIGH** - When using `defineModel()` with a default value and the parent doesn't provide a value, the parent and child components will have different values. The parent's ref stays `undefined` while the child uses the default, breaking the two-way binding contract.

This subtle bug can cause confusing behavior where the parent component shows one value while the child shows another, and updates may not propagate correctly.

## Task Checklist

- [ ] Always provide initial values from the parent when using v-model
- [ ] Don't rely on defineModel defaults as the primary source of truth
- [ ] If defaults are needed, also set them in the parent component
- [ ] Test components with and without v-model props provided

**Problem - Parent and child out of sync:**
```html
<!-- ChildComponent.vue -->
<script setup>
// Default value of 1 if parent doesn't provide value
const model = defineModel({ default: 1 })
</script>

<template>
  <input v-model="model" type="number">
  <!-- Shows: 1 (from default) -->
</template>
```

```html
<!-- ParentComponent.vue -->
<script setup>
import { ref } from 'vue'
import ChildComponent from './ChildComponent.vue'

// PROBLEM: Parent ref is undefined, not synced with child's default
const myValue = ref()  // undefined
</script>

<template>
  <ChildComponent v-model="myValue" />

  <!-- DESYNC: Child shows 1, but parent shows undefined -->
  <p>Parent value: {{ myValue }}</p>  <!-- Shows: undefined -->

  <!-- Even after child changes value, parent may not update correctly -->
</template>
```

**Solution 1 - Always provide initial value from parent:**
```html
<!-- ParentComponent.vue -->
<script setup>
import { ref } from 'vue'
import ChildComponent from './ChildComponent.vue'

// CORRECT: Parent provides the initial value
const myValue = ref(1)  // Match the expected default
</script>

<template>
  <ChildComponent v-model="myValue" />
  <p>Parent value: {{ myValue }}</p>  <!-- Shows: 1, stays in sync -->
</template>
```

**Solution 2 - Child emits default on mount (if parent control not possible):**
```html
<!-- ChildComponent.vue -->
<script setup>
import { onMounted } from 'vue'

const model = defineModel({ default: 1 })

// Sync default value back to parent on mount
onMounted(() => {
  if (model.value === 1) {  // Is using default
    // Force emit to sync parent
    model.value = 1
  }
})
</script>

<template>
  <input v-model="model" type="number">
</template>
```

**Solution 3 - Use required prop or explicit undefined handling:**
```html
<!-- ChildComponent.vue -->
<script setup>
import { computed } from 'vue'

// Mark as required - TypeScript will warn if not provided
const model = defineModel({ required: true })

// Or handle undefined explicitly
const safeModel = computed({
  get: () => model.value ?? 1,  // Provide fallback
  set: (val) => { model.value = val }
})
</script>

<template>
  <input v-model="safeModel" type="number">
</template>
```

**Best Practice - Document expected initial values:**
```html
<!-- ChildComponent.vue -->
<script setup>
/**
 * @prop modelValue - The numeric value (parent should initialize to 1 or desired default)
 */
const model = defineModel({
  type: Number,
  default: 1,
  // Adding validator helps catch issues in development
  validator: (value) => {
    if (value === undefined) {
      console.warn('ChildComponent: v-model value is undefined. Provide initial value from parent.')
    }
    return true
  }
})
</script>
```

## Reference
- [Vue.js Component v-model](https://vuejs.org/guide/components/v-model.html)
- [Vue School - defineModel Guide](https://vueschool.io/articles/vuejs-tutorials/v-model-and-definemodel-a-comprehensive-guide-to-two-way-binding-in-vue-js-3/)
