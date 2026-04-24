---
title: Use flush post for watchEffect with Template Refs
impact: MEDIUM
impactDescription: Default watchEffect runs before DOM updates, causing refs to be out of sync
type: gotcha
tags: [vue3, watchEffect, template-refs, flush, dom-timing]
---

# Use flush post for watchEffect with Template Refs

**Impact: MEDIUM** - By default, `watchEffect` runs before the DOM is updated. When watching template refs, this means the effect may run with stale or null ref values. Use `flush: 'post'` to ensure the effect runs after DOM updates when refs are current.

This timing issue is particularly confusing because the watcher runs, but the ref doesn't yet reflect the current DOM state.

## Task Checklist

- [ ] Use `{ flush: 'post' }` when watchEffect accesses template refs
- [ ] Alternatively, use `watchPostEffect` helper for cleaner syntax
- [ ] Still include null checks as refs can be unmounted
- [ ] Consider using `watch` with explicit ref watching instead

**Incorrect:**
```vue
<script setup>
import { ref, watchEffect } from 'vue'

const inputEl = ref(null)
const text = ref('')

// WRONG: Runs BEFORE DOM update - ref may be null or stale
watchEffect(() => {
  // On first run: inputEl.value is null (DOM not rendered yet)
  // On updates: May reference old element state
  if (inputEl.value) {
    console.log('Input value:', inputEl.value.value) // Stale!
    inputEl.value.focus()
  }
})
</script>

<template>
  <input ref="inputEl" v-model="text" />
</template>
```

```vue
<script setup>
import { ref, watchEffect } from 'vue'

const items = ref([1, 2, 3])
const itemRefs = ref([])

// WRONG: Refs array not yet populated when this runs
watchEffect(() => {
  console.log('Number of refs:', itemRefs.value.length) // Always 0!
})
</script>

<template>
  <div v-for="item in items" :key="item" :ref="el => itemRefs.value.push(el)">
    {{ item }}
  </div>
</template>
```

**Correct:**
```vue
<script setup>
import { ref, watchEffect } from 'vue'

const inputEl = ref(null)
const text = ref('')

// CORRECT: flush: 'post' runs AFTER DOM update
watchEffect(() => {
  if (inputEl.value) {
    console.log('Input value:', inputEl.value.value) // Current!
    inputEl.value.focus()
  }
}, { flush: 'post' })
</script>

<template>
  <input ref="inputEl" v-model="text" />
</template>
```

```vue
<script setup>
import { ref, watchPostEffect } from 'vue'

const inputEl = ref(null)
const showInput = ref(true)

// CORRECT: watchPostEffect is shorthand for flush: 'post'
watchPostEffect(() => {
  if (inputEl.value) {
    inputEl.value.focus()
  }
})
</script>

<template>
  <input v-if="showInput" ref="inputEl" />
</template>
```

```vue
<script setup>
import { ref, watch, onMounted } from 'vue'

const inputEl = ref(null)

// ALTERNATIVE: Use watch on the ref directly
watch(inputEl, (el) => {
  if (el) {
    el.focus()
  }
}, { flush: 'post' })

// ALTERNATIVE: For one-time setup, onMounted is sufficient
onMounted(() => {
  inputEl.value?.focus()
})
</script>

<template>
  <input ref="inputEl" />
</template>
```

```vue
<script setup>
import { useTemplateRef, watchPostEffect } from 'vue'

// Vue 3.5+ with useTemplateRef
const input = useTemplateRef('my-input')

// CORRECT: watchPostEffect with useTemplateRef
watchPostEffect(() => {
  input.value?.focus()
})
</script>

<template>
  <input ref="my-input" />
</template>
```

## Flush Options Explained

```javascript
// Default: 'pre' - runs before DOM update
watchEffect(() => { ... }) // Same as { flush: 'pre' }

// 'post' - runs after DOM update (use for refs)
watchEffect(() => { ... }, { flush: 'post' })
watchPostEffect(() => { ... }) // Shorthand

// 'sync' - runs synchronously (rarely needed, can cause issues)
watchEffect(() => { ... }, { flush: 'sync' })
watchSyncEffect(() => { ... }) // Shorthand
```

## When to Use Each Flush Mode

| Scenario | Recommended Flush |
|----------|-------------------|
| Accessing template refs | `post` |
| Reading updated DOM | `post` |
| Triggering before render | `pre` (default) |
| Performance-critical sync updates | `sync` (with caution) |

## Reference
- [Vue.js Watchers - Callback Flush Timing](https://vuejs.org/guide/essentials/watchers.html#callback-flush-timing)
- [Vue.js watchEffect API](https://vuejs.org/api/reactivity-core.html#watcheffect)
