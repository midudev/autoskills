---
title: Top-Level await in script setup Preserves Component Context
impact: HIGH
impactDescription: Misunderstanding async context causes lifecycle hooks and watchers to silently fail
type: gotcha
tags: [vue3, composition-api, script-setup, async, await, suspense]
---

# Top-Level await in script setup Preserves Component Context

**Impact: HIGH** - In `<script setup>`, top-level `await` statements preserve component context (allowing lifecycle hooks and watchers after `await`), but this is a special case. Nested async functions or callbacks lose context, causing lifecycle hooks to silently fail.

Vue's compiler automatically injects context restoration after each top-level await in `<script setup>`. This doesn't apply to `setup()` function or nested async contexts.

## Task Checklist

- [ ] Understand that top-level await in `<script setup>` is specially handled
- [ ] Never register lifecycle hooks in nested async functions
- [ ] Use `<Suspense>` when using async `<script setup>` components
- [ ] In regular `setup()`, never use await before lifecycle hook registration
- [ ] Register hooks synchronously, then do async work inside them

**Top-Level await Works (script setup only):**
```vue
<script setup>
import { ref, onMounted, watch } from 'vue'

// This is TOP-LEVEL await - Vue compiler preserves context
const config = await fetchConfig()  // OK!

// These hooks work because Vue restored context
onMounted(() => {
  console.log('This will run!')  // Works
})

watch(someRef, () => {
  console.log('This will track!')  // Works
})

// Another top-level await - still OK
const data = await fetchData(config.apiUrl)  // OK!

// Still works after multiple awaits
onMounted(() => {
  console.log('This also runs!')  // Works
})
</script>

<!-- IMPORTANT: Parent must use Suspense -->
<template>
  <Suspense>
    <AsyncComponent />
  </Suspense>
</template>
```

**Nested Async Breaks Context:**
```vue
<script setup>
import { ref, onMounted, watch } from 'vue'

// WRONG: Nested async function - context lost after await
async function initializeData() {
  const config = await fetchConfig()

  // BUG: This hook will NOT be registered!
  // We're no longer in the synchronous setup context
  onMounted(() => {
    console.log('This will NEVER run!')  // Silent failure
  })

  // BUG: This watcher won't auto-dispose on unmount
  watch(someRef, () => {
    console.log('Memory leak - not cleaned up!')
  })
}

// Calling the async function
initializeData()  // Hooks inside won't work!

// WRONG: Callbacks also lose context
setTimeout(async () => {
  await delay(100)
  onMounted(() => {
    console.log('Never runs!')  // Silent failure
  })
}, 0)
</script>
```

**Correct Patterns:**
```vue
<script setup>
import { ref, onMounted, watch } from 'vue'

const data = ref(null)
const config = ref(null)

// CORRECT: Register hooks synchronously FIRST
onMounted(async () => {
  // Then do async work INSIDE the hook
  config.value = await fetchConfig()
  data.value = await fetchData(config.value.apiUrl)
})

// CORRECT: Watchers registered synchronously
watch(config, async (newConfig) => {
  if (newConfig) {
    data.value = await fetchData(newConfig.apiUrl)
  }
})

// Or use top-level await for initial data
const initialConfig = await fetchConfig()  // OK - top level
config.value = initialConfig

onMounted(() => {
  console.log('Works!')  // Context preserved by compiler
})
</script>
```

**setup() Function (Not script setup):**
```javascript
// In regular setup(), await ALWAYS breaks context
export default {
  async setup() {
    const data = ref(null)

    // WRONG: Hooks after await won't register
    const config = await fetchConfig()

    onMounted(() => {
      console.log('Never runs!')  // Silent failure!
    })

    return { data }
  }
}

// CORRECT: Register hooks before any await
export default {
  async setup() {
    const data = ref(null)

    // Register hooks FIRST (synchronous)
    onMounted(async () => {
      const config = await fetchConfig()
      data.value = await fetchData(config)
    })

    // Now you can await if needed
    // But hooks must be registered before this point

    return { data }
  }
}
```

## Why This Happens

```javascript
// Vue tracks the "current component instance" during setup
// This is like a global variable that gets set and cleared

// During synchronous setup:
function setup() {
  currentInstance = this  // Vue sets this

  onMounted(cb)  // Uses currentInstance to register

  // After await, JavaScript resumes in a microtask
  await something()

  // currentInstance is now null or different!
  onMounted(cb)  // Can't find the instance - silently fails
}

// <script setup> compiler adds restoration:
// After each await, it injects: setCurrentInstance(savedInstance)
```

## Suspense Requirement

```vue
<!-- When using async script setup, parent needs Suspense -->
<template>
  <Suspense>
    <!-- Async component with top-level await -->
    <AsyncChild />

    <!-- Optional: Loading state -->
    <template #fallback>
      <LoadingSpinner />
    </template>
  </Suspense>
</template>
```

## Reference
- [Composition API FAQ - Async Setup](https://vuejs.org/guide/extras/composition-api-faq.html)
- [Composables - Async Without Await](https://antfu.me/posts/async-with-composition-api)
- [Suspense](https://vuejs.org/guide/built-ins/suspense.html)
