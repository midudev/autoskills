---
title: Template Ref Unwrapping Only Works for Top-Level Properties
impact: MEDIUM
impactDescription: Nested refs in template expressions render as [object Object] instead of their values
type: capability
tags: [vue3, reactivity, ref, template, unwrapping]
---

# Template Ref Unwrapping Only Works for Top-Level Properties

**Impact: MEDIUM** - Vue only auto-unwraps refs that are top-level properties in the template render context. Nested refs (refs inside objects) are NOT unwrapped in expressions, causing `[object Object]` rendering or calculation errors.

This caveat trips up developers when they store refs inside reactive objects or plain objects and try to use them in template expressions like `{{ object.count + 1 }}`.

## Task Checklist

- [ ] Keep refs at the top level of your setup return or script setup
- [ ] Destructure nested refs to top-level variables before using in expressions
- [ ] Be aware that text interpolation `{{ object.ref }}` DOES unwrap, but expressions `{{ object.ref + 1 }}` do NOT
- [ ] Consider restructuring data to avoid nested refs in templates

**Incorrect:**
```vue
<script setup>
import { ref } from 'vue'

const count = ref(0)
const object = { id: ref(1) }
</script>

<template>
  <!-- WRONG: Nested ref in expression - does NOT unwrap -->
  <p>ID + 1 = {{ object.id + 1 }}</p>
  <!-- Renders: "ID + 1 = [object Object]1" -->

  <!-- Surprisingly, plain interpolation DOES work -->
  <p>ID = {{ object.id }}</p>
  <!-- Renders: "ID = 1" (unwrapped because it's the final expression) -->
</template>
```

**Correct:**
```vue
<script setup>
import { ref } from 'vue'

const count = ref(0)
const object = { id: ref(1) }

// SOLUTION 1: Destructure to top-level
const { id } = object
</script>

<template>
  <!-- CORRECT: Top-level ref unwraps in all expressions -->
  <p>Count + 1 = {{ count + 1 }}</p>
  <!-- Renders: "Count + 1 = 1" -->

  <!-- CORRECT: Destructured ref is now top-level -->
  <p>ID + 1 = {{ id + 1 }}</p>
  <!-- Renders: "ID + 1 = 2" -->
</template>
```

```vue
<script setup>
import { ref, computed } from 'vue'

const object = { id: ref(1) }

// SOLUTION 2: Use computed for derived values
const idPlusOne = computed(() => object.id.value + 1)
</script>

<template>
  <!-- CORRECT: Computed handles the .value access -->
  <p>ID + 1 = {{ idPlusOne }}</p>
</template>
```

```vue
<script setup>
import { reactive } from 'vue'

// SOLUTION 3: Use reactive object instead (refs inside reactive auto-unwrap)
const object = reactive({ id: 1 })
</script>

<template>
  <!-- CORRECT: Plain reactive property works in expressions -->
  <p>ID + 1 = {{ object.id + 1 }}</p>
</template>
```

```javascript
// WHY this happens:
// - Template compilation only adds .value to top-level identifiers
// - {{ count + 1 }} compiles to: count.value + 1
// - {{ object.id + 1 }} compiles to: object.id + 1 (no .value added!)
// - Plain {{ object.id }} has special handling for display purposes
```

## Reference
- [Vue.js Reactivity Fundamentals - Caveat when Unwrapping in Templates](https://vuejs.org/guide/essentials/reactivity-fundamentals.html#caveat-when-unwrapping-in-templates)
