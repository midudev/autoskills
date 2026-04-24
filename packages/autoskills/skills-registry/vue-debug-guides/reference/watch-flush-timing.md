---
title: Use flush post When Accessing Updated DOM in Watchers
impact: MEDIUM
impactDescription: Default watcher timing runs before DOM updates, causing stale DOM reads
type: capability
tags: [vue3, watch, watchers, flush, DOM, timing, post]
---

# Use flush: 'post' When Accessing Updated DOM in Watchers

**Impact: MEDIUM** - By default, watcher callbacks run before the component's DOM is updated. If you access the DOM in a watcher callback, you'll see the pre-update state. Use `flush: 'post'` or `watchPostEffect` when you need to access the updated DOM.

## Task Checklist

- [ ] Use `{ flush: 'post' }` when reading DOM after reactive state changes
- [ ] Use `watchPostEffect()` as a shorthand for `watchEffect` with flush: 'post'
- [ ] Avoid `{ flush: 'sync' }` unless absolutely necessary (performance impact)
- [ ] Remember default timing is ideal for most non-DOM operations

**Incorrect:**
```vue
<script setup>
import { ref, watch, watchEffect } from 'vue'

const count = ref(0)
const listItems = ref(['a', 'b', 'c'])

// BAD: DOM shows old value when this runs
watch(count, () => {
  // Element still shows the OLD count value
  const el = document.querySelector('.counter')
  console.log('DOM shows:', el.textContent)  // Old value!
})

// BAD: List DOM not yet updated
watchEffect(() => {
  console.log('Items:', listItems.value.length)
  // DOM still has old number of list items
  const items = document.querySelectorAll('.list-item')
  console.log('DOM items:', items.length)  // Old count!
})
</script>

<template>
  <div class="counter">{{ count }}</div>
  <ul>
    <li v-for="item in listItems" :key="item" class="list-item">
      {{ item }}
    </li>
  </ul>
</template>
```

**Correct:**
```vue
<script setup>
import { ref, watch, watchEffect, watchPostEffect } from 'vue'

const count = ref(0)
const listItems = ref(['a', 'b', 'c'])

// CORRECT: flush: 'post' runs after DOM update
watch(
  count,
  () => {
    const el = document.querySelector('.counter')
    console.log('DOM shows:', el.textContent)  // Correct new value!
  },
  { flush: 'post' }
)

// CORRECT: watchPostEffect shorthand
watchPostEffect(() => {
  console.log('Items:', listItems.value.length)
  const items = document.querySelectorAll('.list-item')
  console.log('DOM items:', items.length)  // Matches listItems.length!
})

// CORRECT: Using watchEffect with flush option
watchEffect(
  () => {
    // Access reactive state and DOM together
    const expectedCount = listItems.value.length
    const actualCount = document.querySelectorAll('.list-item').length
    console.log(`Expected: ${expectedCount}, Actual: ${actualCount}`)
  },
  { flush: 'post' }
)
</script>

<template>
  <div class="counter">{{ count }}</div>
  <ul>
    <li v-for="item in listItems" :key="item" class="list-item">
      {{ item }}
    </li>
  </ul>
</template>
```

## Flush Timing Options

```javascript
import { watch, watchEffect, watchPostEffect, watchSyncEffect } from 'vue'

// Default: 'pre' - runs before component DOM update
watch(source, callback)  // Same as { flush: 'pre' }

// Post: runs after component DOM update
watch(source, callback, { flush: 'post' })
watchPostEffect(callback)  // Shorthand

// Sync: runs immediately when reactive value changes
// USE WITH CAUTION - no batching, fires on every mutation
watch(source, callback, { flush: 'sync' })
watchSyncEffect(callback)  // Shorthand
```

## When to Use Each Flush Timing

| Timing | Use Case |
|--------|----------|
| `'pre'` (default) | Logic that doesn't need DOM access |
| `'post'` | Reading or measuring updated DOM |
| `'sync'` | Debug logging, simple boolean flags only |

## Sync Watcher Warning

```javascript
import { ref, watch } from 'vue'

const items = ref([1, 2, 3])

// DANGEROUS: Fires for EVERY array mutation
watch(
  items,
  () => {
    console.log('Changed!')  // Called 3 times for push, push, push
  },
  { flush: 'sync' }
)

// This triggers the watcher 3 times synchronously
items.value.push(4)
items.value.push(5)
items.value.push(6)

// Better: Use default flush which batches updates
watch(items, () => {
  console.log('Changed!')  // Called once after all mutations
}, { deep: true })
```

## Practical Example: Auto-scroll

```vue
<script setup>
import { ref, watchPostEffect } from 'vue'

const messages = ref([])
const containerRef = ref(null)

// Auto-scroll to bottom when new messages arrive
watchPostEffect(() => {
  // Access messages.value to track it
  const msgCount = messages.value.length

  // DOM is updated, safe to scroll
  if (containerRef.value && msgCount > 0) {
    containerRef.value.scrollTop = containerRef.value.scrollHeight
  }
})

function addMessage(text) {
  messages.value.push({ text, timestamp: Date.now() })
}
</script>

<template>
  <div ref="containerRef" class="messages">
    <div v-for="msg in messages" :key="msg.timestamp">
      {{ msg.text }}
    </div>
  </div>
</template>
```

## Reference
- [Vue.js Watchers - Callback Flush Timing](https://vuejs.org/guide/essentials/watchers.html#callback-flush-timing)
