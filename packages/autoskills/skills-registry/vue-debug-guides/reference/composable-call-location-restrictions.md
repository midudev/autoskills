---
title: Call Composables Only in Setup Context Synchronously
impact: HIGH
impactDescription: Composables called outside setup context or asynchronously fail to register lifecycle hooks and may cause memory leaks
type: gotcha
tags: [vue3, composables, composition-api, setup, async, lifecycle]
---

# Call Composables Only in Setup Context Synchronously

**Impact: HIGH** - Composables must be called synchronously within `<script setup>`, the `setup()` function, or lifecycle hooks. Calling composables asynchronously (after await), in callbacks, or outside component context prevents Vue from associating lifecycle hooks with the component instance, causing silent failures.

This is critical because composables often register `onMounted` and `onUnmounted` hooks internally. If called in the wrong context, these hooks are never registered, leading to uninitialized state or memory leaks.

## Task Checklist

- [ ] Call all composables at the top level of `<script setup>` or `setup()`
- [ ] Never call composables inside async callbacks, setTimeout, or Promise.then
- [ ] Never call composables conditionally (if/else) - call unconditionally and handle the condition inside
- [ ] Never call composables inside loops - restructure to call once with array data
- [ ] Exception: Composables CAN be called in lifecycle hooks like `onMounted`

**Incorrect:**
```vue
<script setup>
import { useFetch } from './composables/useFetch'
import { useAuth } from './composables/useAuth'

// WRONG: Composable called after await
const config = await loadConfig()
const { data } = useFetch(config.apiUrl)  // Lifecycle hooks won't register!

// WRONG: Composable called conditionally
if (someCondition) {
  const { user } = useAuth()  // Inconsistent hook registration!
}

// WRONG: Composable called in callback
setTimeout(() => {
  const { data } = useFetch('/api/delayed')  // No component context!
}, 1000)

// WRONG: Composable called in loop
for (const url of urls) {
  const { data } = useFetch(url)  // Creates multiple instances incorrectly
}
</script>
```

**Correct:**
```vue
<script setup>
import { ref, onMounted } from 'vue'
import { useFetch } from './composables/useFetch'
import { useAuth } from './composables/useAuth'

// CORRECT: Call composables synchronously at top level
const { user, isAuthenticated } = useAuth()
const apiUrl = ref('/api/default')
const { data, execute } = useFetch(apiUrl)

// Handle async config loading differently
onMounted(async () => {
  const config = await loadConfig()
  apiUrl.value = config.apiUrl  // Update the ref, composable reacts
})

// CORRECT: Handle condition inside, not outside
const showUserData = computed(() => isAuthenticated.value && someCondition)

// CORRECT: For multiple URLs, use a different pattern
const urls = ref(['/api/a', '/api/b', '/api/c'])
const results = ref([])

// Either fetch in onMounted or use a composable designed for arrays
onMounted(async () => {
  results.value = await Promise.all(urls.value.map(url => fetch(url)))
})
</script>
```

## Exception: Calling in Lifecycle Hooks

Composables CAN be called inside lifecycle hooks because Vue maintains the component context:

```vue
<script setup>
import { onMounted } from 'vue'
import { useEventListener } from '@vueuse/core'

// CORRECT: Called in lifecycle hook - component context is available
onMounted(() => {
  // This works because we're still in the component's execution context
  useEventListener(document, 'visibilitychange', handleVisibility)
})
</script>
```

## Special Case: Async Setup in `<script setup>`

Top-level await in `<script setup>` is special - Vue's compiler automatically preserves context:

```vue
<script setup>
import { useFetch } from './composables/useFetch'

// CORRECT: Top-level await in <script setup> preserves context
// Vue compiler handles this specially
const config = await loadConfig()
const { data } = useFetch(config.apiUrl)  // This works!

// But nested awaits still break context:
async function initLater() {
  await delay(1000)
  const { data } = useFetch('/api/late')  // WRONG: This won't work!
}
</script>
```

## Why This Matters

When you call a composable, Vue needs to know which component instance to associate it with. This association happens through an internal "current instance" that's only set during synchronous setup execution.

```javascript
// Inside a composable
export function useFetch(url) {
  const data = ref(null)

  // These need the current component instance!
  onMounted(() => { /* ... */ })
  onUnmounted(() => { /* cleanup */ })

  // If called outside setup context, Vue can't find the instance
  // and these hooks are silently ignored
  return { data }
}
```

## Reference
- [Vue.js Composables - Usage Restrictions](https://vuejs.org/guide/reusability/composables.html#usage-restrictions)
- [Vue.js Composition API - Setup Context](https://vuejs.org/api/composition-api-setup.html)
