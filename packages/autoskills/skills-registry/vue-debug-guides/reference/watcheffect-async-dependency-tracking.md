---
title: watchEffect Only Tracks Dependencies Before First Await
impact: HIGH
impactDescription: Dependencies accessed after await are not tracked, causing watchers to miss reactive changes
type: capability
tags: [vue3, watchEffect, watchers, async, await, dependency-tracking]
---

# watchEffect Only Tracks Dependencies Before First Await

**Impact: HIGH** - `watchEffect` automatically tracks reactive dependencies, but only during synchronous execution. Any reactive properties accessed after the first `await` statement will NOT be tracked, and changes to them won't trigger the watcher.

For async operations, either access all dependencies before the await, or use `watch` with explicit dependencies.

## Task Checklist

- [ ] Access all reactive dependencies BEFORE the first await in watchEffect
- [ ] Use `watch` with explicit source when async tracking is needed
- [ ] Store reactive values in local variables before await
- [ ] Be aware that dependencies after await are invisible to Vue

**Incorrect:**
```vue
<script setup>
import { ref, watchEffect } from 'vue'

const userId = ref(1)
const includeDetails = ref(true)
const userData = ref(null)

// BAD: includeDetails is accessed after await - NOT TRACKED!
watchEffect(async () => {
  const response = await fetch(`/api/users/${userId.value}`)
  const data = await response.json()

  // This dependency is NOT tracked - changes won't trigger re-run
  if (includeDetails.value) {
    userData.value = { ...data, details: await fetchDetails(data.id) }
  } else {
    userData.value = data
  }
})

// BAD: Multiple dependencies after await
watchEffect(async () => {
  await someAsyncSetup()

  // None of these are tracked!
  console.log(optionA.value)  // Not tracked
  console.log(optionB.value)  // Not tracked
  doSomething(optionC.value)  // Not tracked
})
</script>
```

**Correct:**
```vue
<script setup>
import { ref, watchEffect, watch } from 'vue'

const userId = ref(1)
const includeDetails = ref(true)
const userData = ref(null)

// CORRECT: Access all dependencies before await
watchEffect(async () => {
  // Capture reactive values synchronously
  const id = userId.value
  const withDetails = includeDetails.value

  // Now these are tracked
  const response = await fetch(`/api/users/${id}`)
  const data = await response.json()

  if (withDetails) {
    userData.value = { ...data, details: await fetchDetails(data.id) }
  } else {
    userData.value = data
  }
})

// ALTERNATIVE: Use watch with explicit dependencies
watch(
  [userId, includeDetails],
  async ([id, withDetails]) => {
    const response = await fetch(`/api/users/${id}`)
    const data = await response.json()

    if (withDetails) {
      userData.value = { ...data, details: await fetchDetails(data.id) }
    } else {
      userData.value = data
    }
  },
  { immediate: true }
)
</script>
```

## Pattern: Extract Dependencies First

```vue
<script setup>
import { ref, watchEffect } from 'vue'

const filters = ref({ status: 'active', sortBy: 'name' })
const page = ref(1)
const results = ref([])

// CORRECT: Extract all needed values synchronously
watchEffect(async () => {
  // All dependencies accessed before await - all tracked!
  const { status, sortBy } = filters.value
  const currentPage = page.value

  // Now safe to do async work
  const response = await fetch(
    `/api/items?status=${status}&sort=${sortBy}&page=${currentPage}`
  )
  results.value = await response.json()
})
</script>
```

## When to Use watch Instead

```vue
<script setup>
import { ref, watch } from 'vue'

const source = ref('initial')
const option = ref('default')
const result = ref(null)

// BEST for complex async: Use watch with explicit sources
// All dependencies are explicitly declared and always tracked
watch(
  [source, option],
  async ([sourceVal, optionVal]) => {
    const data = await processAsync(sourceVal)
    result.value = applyOption(data, optionVal)
  },
  { immediate: true }
)
</script>
```

## Debugging Untracked Dependencies

```vue
<script setup>
import { ref, watchEffect } from 'vue'

const a = ref(1)
const b = ref(2)

watchEffect(async () => {
  console.log('Tracked dependency a:', a.value)  // Tracked

  await someAsyncOperation()

  console.log('Untracked dependency b:', b.value)  // NOT tracked!
  // Changing b.value won't re-run this watchEffect
})

// Test: Change a.value -> watchEffect re-runs
// Test: Change b.value -> watchEffect does NOT re-run
</script>
```

## Reference
- [Vue.js Watchers - watchEffect](https://vuejs.org/guide/essentials/watchers.html#watcheffect)
- [Vue.js API - watchEffect](https://vuejs.org/api/reactivity-core.html#watcheffect)
