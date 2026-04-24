---
title: defineExpose Must Be Called Before Any Await
impact: HIGH
impactDescription: Properties exposed after await are inaccessible to parent component refs
type: gotcha
tags: [vue3, script-setup, defineExpose, async, component-refs]
---

# defineExpose Must Be Called Before Any Await

**Impact: HIGH** - In `<script setup>`, if you call `defineExpose()` after an `await` statement, the exposed properties will NOT be accessible to parent components using template refs. This is a subtle async timing issue that causes silent failures.

The compiler transforms top-level await, and code after await runs in a different execution context where defineExpose cannot properly register with the component instance.

## Task Checklist

- [ ] Always call defineExpose() at the top of script setup, before any await
- [ ] If async data is needed in exposed methods, fetch it separately
- [ ] Structure code so expose declarations come first
- [ ] Test parent ref access when using async setup

**Incorrect:**
```vue
<!-- ChildComponent.vue -->
<script setup>
import { ref } from 'vue'

const data = ref(null)
const count = ref(0)

function increment() {
  count.value++
}

// WRONG: await before defineExpose
const response = await fetch('/api/data')
data.value = await response.json()

// BROKEN: This won't work - called after await!
defineExpose({
  count,
  increment,
  data
})
</script>

<template>
  <div>{{ data }}</div>
</template>
```

```vue
<!-- ParentComponent.vue -->
<script setup>
import { ref, onMounted } from 'vue'
import ChildComponent from './ChildComponent.vue'

const childRef = ref(null)

onMounted(() => {
  // FAILS: All exposed properties are undefined!
  console.log(childRef.value.count) // undefined
  childRef.value.increment() // TypeError
})
</script>

<template>
  <Suspense>
    <ChildComponent ref="childRef" />
  </Suspense>
</template>
```

**Correct:**
```vue
<!-- ChildComponent.vue -->
<script setup>
import { ref } from 'vue'

const data = ref(null)
const count = ref(0)

function increment() {
  count.value++
}

// CORRECT: defineExpose BEFORE any await
defineExpose({
  count,
  increment,
  data
})

// Now safe to use await
const response = await fetch('/api/data')
data.value = await response.json()
</script>

<template>
  <div>{{ data }}</div>
</template>
```

```vue
<!-- Alternative: Separate async logic from expose -->
<script setup>
import { ref, onMounted } from 'vue'

const data = ref(null)
const loading = ref(true)

function getData() {
  return data.value
}

async function refreshData() {
  loading.value = true
  const response = await fetch('/api/data')
  data.value = await response.json()
  loading.value = false
}

// CORRECT: No await at top level - defineExpose always works
defineExpose({
  data,
  getData,
  refreshData,
  loading
})

// Trigger async load in lifecycle hook instead
onMounted(() => {
  refreshData()
})
</script>

<template>
  <div v-if="loading">Loading...</div>
  <div v-else>{{ data }}</div>
</template>
```

```vue
<!-- If you must use top-level await, define expose first -->
<script setup>
import { ref } from 'vue'

const user = ref(null)
const posts = ref([])

// CORRECT: All expose calls come first
defineExpose({
  user,
  posts,
  refresh: () => loadData()
})

// Now safe to await
async function loadData() {
  const [userRes, postsRes] = await Promise.all([
    fetch('/api/user'),
    fetch('/api/posts')
  ])
  user.value = await userRes.json()
  posts.value = await postsRes.json()
}

// Top-level await after defineExpose is safe
await loadData()
</script>
```

## Why This Happens

Vue's compiler transforms `<script setup>` with top-level await into an async setup function. The component instance context is only available synchronously before the first await. After await, the execution resumes outside that context, making defineExpose ineffective.

```javascript
// What the compiler roughly generates:
async setup() {
  const count = ref(0)

  // Context available here
  await fetch(...)  // Suspends execution

  // Context lost after resuming
  defineExpose({ count }) // Too late!
}
```

## Reference
- [Vue.js Script Setup - defineExpose](https://vuejs.org/api/sfc-script-setup.html#defineexpose)
- [Vue.js Async Components](https://vuejs.org/guide/components/async.html)
