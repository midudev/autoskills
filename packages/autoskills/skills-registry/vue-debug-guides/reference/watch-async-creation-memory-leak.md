---
title: Watchers Created Asynchronously Must Be Manually Stopped
impact: HIGH
impactDescription: Async-created watchers are not bound to component lifecycle and cause memory leaks
type: capability
tags: [vue3, watch, watchers, async, memory-leak, lifecycle, cleanup]
---

# Watchers Created Asynchronously Must Be Manually Stopped

**Impact: HIGH** - Watchers created inside async callbacks (setTimeout, Promise.then, async/await) are not automatically bound to the component instance. They continue running after the component unmounts, causing memory leaks and errors.

Always manually stop watchers that are created asynchronously, or restructure your code to create watchers synchronously with conditional logic.

## Task Checklist

- [ ] Create watchers synchronously in setup() or lifecycle hooks when possible
- [ ] If async creation is unavoidable, store and call the unwatch function
- [ ] Use `onUnmounted` to clean up async-created watchers
- [ ] Consider using conditional logic inside a sync watcher instead
- [ ] Watch for this pattern in setTimeout, Promise callbacks, and after await

**Incorrect:**
```vue
<script setup>
import { ref, watch, watchEffect, onMounted } from 'vue'

const data = ref(null)

// BAD: Watcher created in setTimeout won't auto-stop
onMounted(() => {
  setTimeout(() => {
    watchEffect(() => {
      console.log(data.value)  // Keeps running after unmount!
    })
  }, 1000)
})

// BAD: Watcher created after await won't auto-stop
onMounted(async () => {
  await loadInitialData()

  // This watcher is NOT bound to component lifecycle
  watch(data, (newVal) => {
    processData(newVal)  // Memory leak!
  })
})

// BAD: Watcher in Promise callback
fetch('/api/config').then(() => {
  watch(data, () => {
    // Leaks memory!
  })
})
</script>
```

**Correct:**
```vue
<script setup>
import { ref, watch, watchEffect, onMounted, onUnmounted } from 'vue'

const data = ref(null)
const isDataLoaded = ref(false)
let asyncWatcherCleanup = null

// CORRECT: Synchronous watcher with conditional logic
watch(
  data,
  (newVal) => {
    if (isDataLoaded.value && newVal) {
      processData(newVal)
    }
  }
)

onMounted(async () => {
  await loadInitialData()
  isDataLoaded.value = true
})

// CORRECT: Manual cleanup for async-created watcher
onMounted(() => {
  setTimeout(() => {
    const unwatch = watchEffect(() => {
      console.log(data.value)
    })

    // Store for cleanup
    asyncWatcherCleanup = unwatch
  }, 1000)
})

onUnmounted(() => {
  // Clean up async watcher
  if (asyncWatcherCleanup) {
    asyncWatcherCleanup()
  }
})
</script>
```

## Preferred Pattern: Conditional Watch Logic

```vue
<script setup>
import { ref, watch, onMounted } from 'vue'

const config = ref(null)
const userData = ref(null)

// BEST: Create watcher synchronously, handle async condition inside
watch(
  userData,
  (newData) => {
    // Only process when config is loaded
    if (config.value && newData) {
      applyUserSettings(config.value, newData)
    }
  }
)

onMounted(async () => {
  config.value = await fetchConfig()
  // Watcher will start processing once config is loaded
})
</script>
```

## Using watchEffect with Conditional Logic

```vue
<script setup>
import { ref, watchEffect, onMounted } from 'vue'

const apiData = ref(null)
const isReady = ref(false)

// GOOD: Synchronous watchEffect with condition
watchEffect(() => {
  if (isReady.value && apiData.value) {
    // This pattern avoids async watcher creation
    doSomethingWithData(apiData.value)
  }
})

onMounted(async () => {
  apiData.value = await fetchData()
  isReady.value = true
})
</script>
```

## Tracking Multiple Async Watchers

```vue
<script setup>
import { ref, watch, onUnmounted } from 'vue'

const unwatchers = []

function createDynamicWatcher(source, callback) {
  const unwatch = watch(source, callback)
  unwatchers.push(unwatch)
  return unwatch
}

// Clean up all dynamic watchers
onUnmounted(() => {
  unwatchers.forEach(unwatch => unwatch())
})
</script>
```

## Reference
- [Vue.js Watchers - Stopping a Watcher](https://vuejs.org/guide/essentials/watchers.html#stopping-a-watcher)
