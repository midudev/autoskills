---
title: Understand Reactive Updates are Batched Per Event Loop Tick
impact: MEDIUM
impactDescription: Multiple synchronous reactive changes are batched - watchers only see the final value, not intermediate states
type: gotcha
tags: [vue3, reactivity, batching, event-loop, watchers, nextTick]
---

# Understand Reactive Updates are Batched Per Event Loop Tick

**Impact: MEDIUM** - Vue batches multiple reactive state changes that happen synchronously within the same event loop tick. Watchers and computed properties only see the final state, not intermediate values. This is an optimization, but it can be surprising if you expect watchers to fire for each individual change.

Understanding this behavior is essential for debugging scenarios where you expect to observe every state transition.

## Task Checklist

- [ ] Understand watchers fire once per tick with final value, not for each mutation
- [ ] Use `nextTick()` if you need to ensure DOM updates between state changes
- [ ] Use `flush: 'sync'` on watchers only if you absolutely need immediate execution
- [ ] For intermediate value tracking, consider logging or explicit state snapshots

**Example of batching behavior:**
```javascript
import { ref, watch } from 'vue'

const count = ref(0)

watch(count, (newValue) => {
  console.log('Count changed to:', newValue)
})

// Multiple synchronous changes in the same tick
function multipleUpdates() {
  count.value = 1
  count.value = 2
  count.value = 3
  count.value = 4
}

multipleUpdates()
// Console output: "Count changed to: 4"
// NOT: 1, 2, 3, 4 - only the final value is observed!
```

**The console logs you WON'T see:**
```javascript
const items = reactive([])

watch(items, (newItems) => {
  console.log('Items count:', newItems.length)
})

// Batch of changes
items.push('a')  // length: 1
items.push('b')  // length: 2
items.push('c')  // length: 3

// Output: "Items count: 3"
// You won't see 1, 2, 3 logged separately
```

**Using flush: 'sync' for immediate watching (use with caution):**
```javascript
import { ref, watch } from 'vue'

const count = ref(0)

// Sync watcher fires immediately on each change
watch(count, (newValue) => {
  console.log('Immediate:', newValue)
}, { flush: 'sync' })

count.value = 1  // Logs: "Immediate: 1"
count.value = 2  // Logs: "Immediate: 2"
count.value = 3  // Logs: "Immediate: 3"

// WARNING: flush: 'sync' can cause performance issues
// and creates less predictable behavior. Avoid if possible.
```

**Using nextTick to separate batches:**
```javascript
import { ref, watch, nextTick } from 'vue'

const count = ref(0)

watch(count, (newValue) => {
  console.log('Count:', newValue)
})

async function separatedUpdates() {
  count.value = 1
  await nextTick()  // Force flush
  // Output: "Count: 1"

  count.value = 2
  await nextTick()
  // Output: "Count: 2"

  count.value = 3
  // Output: "Count: 3"
}
```

**Practical example - form validation:**
```javascript
const formData = reactive({
  email: '',
  password: ''
})

const validationErrors = ref([])

// This watcher only fires once, with final form state
watch(formData, (data) => {
  // Runs once after all fields are updated
  validateForm(data)
}, { deep: true })

// When user submits, you might update multiple fields
function populateFromSavedData(saved) {
  formData.email = saved.email
  formData.password = saved.password
  // Validation runs once with both fields set
}
```

**When batching helps performance:**
```javascript
// Without batching, this would trigger 1000 watcher/render cycles
const list = reactive([])

function addManyItems() {
  for (let i = 0; i < 1000; i++) {
    list.push(i)
  }
}
// With batching: renders once with all 1000 items
// Without batching: would render 1000 times!
```

**Debugging intermediate states:**
```javascript
// If you need to observe every change for debugging:
import { ref, watch } from 'vue'

const count = ref(0)

// Method 1: Sync watcher (not recommended for production)
watch(count, (val) => console.log('DEBUG:', val), { flush: 'sync' })

// Method 2: Track history manually
const history = []
const originalSet = count.value
Object.defineProperty(count, 'value', {
  set(val) {
    history.push(val)
    originalSet.call(this, val)
  }
})
```

## Reference
- [Vue.js Reactivity in Depth](https://vuejs.org/guide/extras/reactivity-in-depth.html)
- [Vue.js Watchers - Callback Flush Timing](https://vuejs.org/guide/essentials/watchers.html#callback-flush-timing)
- [Vue.js nextTick()](https://vuejs.org/api/general.html#nexttick)
