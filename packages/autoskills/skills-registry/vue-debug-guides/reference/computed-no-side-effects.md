---
title: Computed Property Getters Must Be Side-Effect Free
impact: HIGH
impactDescription: Side effects in computed getters break reactivity and cause unpredictable behavior
type: efficiency
tags: [vue3, computed, reactivity, side-effects, best-practices]
---

# Computed Property Getters Must Be Side-Effect Free

**Impact: HIGH** - Computed getter functions should only perform pure computation. Side effects in computed getters break Vue's reactivity model and cause bugs that are difficult to trace.

Computed properties are designed to declaratively describe how to derive a value from other reactive state. They are not meant to perform actions or modify state.

## Task Checklist

- [ ] Never mutate other reactive state inside a computed getter
- [ ] Never make async requests or API calls inside a computed getter
- [ ] Never perform DOM mutations inside a computed getter
- [ ] Use watchers for reacting to state changes with side effects
- [ ] Use event handlers for user-triggered actions

**Incorrect:**
```vue
<script setup>
import { ref, computed } from 'vue'

const items = ref([])
const count = ref(0)
const lastFetch = ref(null)

// BAD: Mutates other state
const doubledCount = computed(() => {
  count.value++  // Side effect - modifying state!
  return count.value * 2
})

// BAD: Makes async request
const userData = computed(async () => {
  const response = await fetch('/api/user')  // Side effect - API call!
  return response.json()
})

// BAD: Modifies DOM
const highlightedItems = computed(() => {
  document.title = `${items.value.length} items`  // Side effect - DOM mutation!
  return items.value.filter(i => i.highlighted)
})

// BAD: Writes to external state
const processedData = computed(() => {
  lastFetch.value = new Date()  // Side effect - modifying state!
  return items.value.map(i => i.name)
})
</script>
```

**Correct:**
```vue
<script setup>
import { ref, computed, watch, onMounted } from 'vue'

const items = ref([])
const count = ref(0)
const userData = ref(null)

// GOOD: Pure computation only
const doubledCount = computed(() => {
  return count.value * 2
})

// GOOD: Use lifecycle hook for initial fetch
onMounted(async () => {
  const response = await fetch('/api/user')
  userData.value = await response.json()
})

// GOOD: Pure filtering
const highlightedItems = computed(() => {
  return items.value.filter(i => i.highlighted)
})

// GOOD: Use watcher for side effects
watch(items, (newItems) => {
  document.title = `${newItems.length} items`
}, { immediate: true })

// Increment count through event handler, not computed
function increment() {
  count.value++
}
</script>
```

## What Counts as a Side Effect

| Side Effect Type | Example | Alternative |
|-----------------|---------|-------------|
| State mutation | `otherRef.value = x` | Use watcher |
| API calls | `fetch()`, `axios()` | Use watcher or lifecycle hook |
| DOM manipulation | `document.title = x` | Use watcher |
| Console logging | `console.log()` | Remove or use watcher |
| Storage access | `localStorage.setItem()` | Use watcher |
| Timer setup | `setTimeout()` | Use lifecycle hook |

## Reference
- [Vue.js Computed Properties - Getters Should Be Side-Effect Free](https://vuejs.org/guide/essentials/computed.html#getters-should-be-side-effect-free)
