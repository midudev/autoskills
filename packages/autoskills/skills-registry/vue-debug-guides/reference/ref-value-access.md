---
title: Always Use .value When Accessing ref() in JavaScript
impact: HIGH
impactDescription: Forgetting .value causes silent failures and bugs in reactive state updates
type: capability
tags: [vue3, reactivity, ref, composition-api]
---

# Always Use .value When Accessing ref() in JavaScript

**Impact: HIGH** - Forgetting `.value` causes silent failures where state updates don't trigger reactivity, leading to hard-to-debug issues.

When using `ref()` in Vue 3's Composition API, the reactive value is wrapped in an object and must be accessed via `.value` in JavaScript code. However, in templates, Vue automatically unwraps refs so `.value` is not needed there. This inconsistency is a common source of bugs.

## Task Checklist

- [ ] Always use `.value` when reading or writing ref values in `<script>` or `.js`/`.ts` files
- [ ] Never use `.value` in `<template>` - Vue unwraps refs automatically there
- [ ] When passing refs to functions, decide whether to pass the ref object or `.value`
- [ ] Use IDE/TypeScript to catch missing `.value` errors early

**Incorrect:**
```javascript
import { ref } from 'vue'

const count = ref(0)

// These do NOT work as expected
count++           // Tries to increment the ref object, not the value
count = 5         // Reassigns the variable, loses reactivity
console.log(count) // Logs "[object Object]", not the number

const items = ref([1, 2, 3])
items.push(4)     // Error: push is not a function
```

**Correct:**
```javascript
import { ref } from 'vue'

const count = ref(0)

// Always use .value in JavaScript
count.value++           // Correctly increments to 1
count.value = 5         // Correctly sets value to 5
console.log(count.value) // Logs "5"

const items = ref([1, 2, 3])
items.value.push(4)     // Correctly adds 4 to the array
```

```vue
<template>
  <!-- In templates, NO .value needed - Vue unwraps automatically -->
  <p>{{ count }}</p>
  <button @click="count++">Increment</button>
</template>
```

## Reference
- [Vue.js Reactivity Fundamentals - ref()](https://vuejs.org/guide/essentials/reactivity-fundamentals.html#ref)
