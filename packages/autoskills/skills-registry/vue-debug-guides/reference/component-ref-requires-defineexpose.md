---
title: Component Refs Require defineExpose with Script Setup
impact: HIGH
impactDescription: Parent components cannot access child ref properties unless explicitly exposed
type: gotcha
tags: [vue3, template-refs, script-setup, defineExpose, component-communication]
---

# Component Refs Require defineExpose with Script Setup

**Impact: HIGH** - Components using `<script setup>` are private by default. A parent component using a template ref to access a child will get an empty object unless the child explicitly exposes properties using `defineExpose()`. This is a fundamental change from Options API behavior.

This catches many developers off-guard when migrating from Options API, where `this.$refs.child` gave full access to the child instance.

## Task Checklist

- [ ] Use `defineExpose()` to explicitly expose properties/methods to parent refs
- [ ] Only expose what's necessary - keep component internals private
- [ ] Document exposed APIs as they form your component's public interface
- [ ] Prefer props/emit for parent-child communication; use refs sparingly
- [ ] Call defineExpose before any await operation (see async caveat)

**Incorrect:**
```vue
<!-- ChildComponent.vue -->
<script setup>
import { ref } from 'vue'

const count = ref(0)
const internalState = ref('private')

function increment() {
  count.value++
}

function reset() {
  count.value = 0
}

// WRONG: Nothing exposed - parent ref sees empty object
</script>

<template>
  <div>{{ count }}</div>
</template>
```

```vue
<!-- ParentComponent.vue -->
<script setup>
import { ref, onMounted } from 'vue'
import ChildComponent from './ChildComponent.vue'

const childRef = ref(null)

onMounted(() => {
  // WRONG: childRef.value is {} - empty object!
  console.log(childRef.value.count) // undefined
  childRef.value.increment() // TypeError: not a function
})
</script>

<template>
  <ChildComponent ref="childRef" />
</template>
```

**Correct:**
```vue
<!-- ChildComponent.vue -->
<script setup>
import { ref } from 'vue'

const count = ref(0)
const internalState = ref('private') // Keep this private

function increment() {
  count.value++
}

function reset() {
  count.value = 0
}

// CORRECT: Explicitly expose public API
defineExpose({
  count,      // Expose the ref
  increment,  // Expose methods
  reset
  // internalState NOT exposed - stays private
})
</script>

<template>
  <div>{{ count }}</div>
</template>
```

```vue
<!-- ParentComponent.vue -->
<script setup>
import { ref, onMounted } from 'vue'
import ChildComponent from './ChildComponent.vue'

const childRef = ref(null)

onMounted(() => {
  // CORRECT: Can access exposed properties
  console.log(childRef.value.count) // 0
  childRef.value.increment() // Works!

  // internalState is not accessible (private)
  console.log(childRef.value.internalState) // undefined
})
</script>

<template>
  <ChildComponent ref="childRef" />
</template>
```

```vue
<!-- Input wrapper example - exposing native element -->
<script setup>
import { ref } from 'vue'

const inputEl = ref(null)

// Expose the native input for parent to access (e.g., for focus)
defineExpose({
  focus: () => inputEl.value?.focus(),
  blur: () => inputEl.value?.blur(),
  // Or expose the element directly
  el: inputEl
})
</script>

<template>
  <input ref="inputEl" v-bind="$attrs" />
</template>
```

```javascript
// Options API equivalent using expose option
export default {
  expose: ['count', 'increment', 'reset'],
  data() {
    return {
      count: 0,
      internalState: 'private'
    }
  },
  methods: {
    increment() { this.count++ },
    reset() { this.count = 0 }
  }
}
```

## Best Practice Reminder

Component refs create tight coupling between parent and child. Prefer standard patterns:

```vue
<!-- PREFERRED: Use props and emit for communication -->
<script setup>
const props = defineProps(['modelValue'])
const emit = defineEmits(['update:modelValue'])
</script>

<!-- Only use refs for imperative actions like focus(), scrollTo(), etc. -->
```

## Reference
- [Vue.js Component Refs](https://vuejs.org/guide/essentials/template-refs.html#ref-on-component)
- [Script Setup - defineExpose](https://vuejs.org/api/sfc-script-setup.html#defineexpose)
