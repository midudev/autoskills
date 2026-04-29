---
title: Clean Up Async Operations in Watchers to Prevent Race Conditions
impact: HIGH
impactDescription: Stale async requests can overwrite newer data, causing incorrect UI state and hard-to-debug issues
type: capability
tags: [vue3, watch, watchers, async, cleanup, race-condition, abort]
---

# Clean Up Async Operations in Watchers to Prevent Race Conditions

**Impact: HIGH** - When a watched value changes rapidly, multiple async operations run concurrently. Without cleanup, a slow earlier request can complete after a faster later request, overwriting current data with stale results.

Always use `onWatcherCleanup` or the `onCleanup` callback parameter to cancel pending async operations when the watcher re-runs or the component unmounts.

## Task Checklist

- [ ] Use `onWatcherCleanup()` or `onCleanup` parameter in async watchers
- [ ] Use `AbortController` to cancel pending fetch requests
- [ ] Cancel any setTimeout/setInterval calls in cleanup
- [ ] Invalidate previous async operation results with flags
- [ ] Consider debouncing rapid changes before fetching

**Incorrect:**
```javascript
import { ref, watch } from 'vue'

const searchQuery = ref('')
const results = ref([])

// BAD: Race condition - slow request for "a" can finish after fast request for "ab"
watch(searchQuery, async (query) => {
  if (query) {
    const response = await fetch(`/api/search?q=${query}`)
    results.value = await response.json()  // May overwrite newer results!
  }
})

// BAD: No cleanup for timeouts
watch(searchQuery, (query) => {
  // Previous timeout keeps running even when query changes
  setTimeout(() => {
    performExpensiveSearch(query)
  }, 500)
})
```

**Correct:**
```javascript
import { ref, watch, onWatcherCleanup } from 'vue'

const searchQuery = ref('')
const results = ref([])
const loading = ref(false)

// CORRECT: Using onWatcherCleanup (Vue 3.5+)
watch(searchQuery, async (query) => {
  if (!query) {
    results.value = []
    return
  }

  const controller = new AbortController()

  // Register cleanup to abort on re-run or unmount
  onWatcherCleanup(() => {
    controller.abort()
  })

  loading.value = true
  try {
    const response = await fetch(`/api/search?q=${query}`, {
      signal: controller.signal
    })
    results.value = await response.json()
  } catch (err) {
    if (err.name !== 'AbortError') {
      console.error('Search failed:', err)
    }
  } finally {
    loading.value = false
  }
})
```

## Using onCleanup Parameter

```javascript
import { ref, watch } from 'vue'

const userId = ref(1)
const userData = ref(null)

// CORRECT: Using onCleanup callback parameter
watch(userId, (newId, oldId, onCleanup) => {
  const controller = new AbortController()

  fetch(`/api/users/${newId}`, { signal: controller.signal })
    .then(res => res.json())
    .then(data => {
      userData.value = data
    })
    .catch(err => {
      if (err.name !== 'AbortError') {
        console.error(err)
      }
    })

  onCleanup(() => {
    controller.abort()
  })
})
```

## Cleanup with Timeouts

```javascript
import { ref, watch, onWatcherCleanup } from 'vue'

const input = ref('')

// CORRECT: Cancel previous timeout on new input
watch(input, (value) => {
  const timeoutId = setTimeout(() => {
    performExpensiveOperation(value)
  }, 300)

  onWatcherCleanup(() => {
    clearTimeout(timeoutId)
  })
})
```

## Invalidation Flag Pattern

```javascript
import { ref, watch } from 'vue'

const id = ref(1)
const data = ref(null)

// CORRECT: Invalidation flag for non-abortable operations
watch(id, async (newId, oldId, onCleanup) => {
  let cancelled = false

  onCleanup(() => {
    cancelled = true
  })

  const result = await someNonAbortableAsyncOperation(newId)

  // Check if this watch run is still valid
  if (!cancelled) {
    data.value = result
  }
})
```

## watchEffect Cleanup

```javascript
import { ref, watchEffect, onWatcherCleanup } from 'vue'

const resourceId = ref('abc')

watchEffect(async () => {
  const id = resourceId.value
  const controller = new AbortController()

  onWatcherCleanup(() => {
    controller.abort()
  })

  const data = await fetchResource(id, { signal: controller.signal })
  processData(data)
})
```

## Reference
- [Vue.js Watchers - Callback Flush Timing](https://vuejs.org/guide/essentials/watchers.html#callback-flush-timing)
- [Vue.js Watchers - Side Effect Cleanup](https://vuejs.org/api/reactivity-core.html#watcheffect)
