---
title: Avoid Comparing Reactive Objects with === Operator
impact: HIGH
impactDescription: Reactive proxies have different identity than original objects - comparison bugs are silent and hard to debug
type: gotcha
tags: [vue3, reactivity, proxy, comparison, debugging, identity]
---

# Avoid Comparing Reactive Objects with === Operator

**Impact: HIGH** - Vue's `reactive()` returns a Proxy wrapper that has a different identity than the original object. Using `===` to compare reactive objects can lead to silent bugs where comparisons unexpectedly return `false`.

When you wrap an object with `reactive()`, the returned proxy is NOT equal to the original object. Additionally, accessing nested objects from a reactive object returns new proxy wrappers each time, which can cause identity comparison issues.

## Task Checklist

- [ ] Never compare reactive object instances with `===` directly
- [ ] Use unique identifiers (ID, UUID) for object comparison instead
- [ ] Use `toRaw()` on both sides when identity comparison is absolutely necessary
- [ ] Consider using primitive identifiers from database records for comparison

**Incorrect:**
```javascript
import { reactive } from 'vue'

const original = { id: 1, name: 'Item' }
const state = reactive(original)

// BUG: Always returns false - proxy !== original
if (state === original) {
  console.log('Same object') // Never executes
}

// BUG: Nested object comparison fails
const items = reactive([{ id: 1 }, { id: 2 }])
const item = items[0]

// Later...
if (items[0] === item) {
  // May or may not work depending on Vue's proxy caching
}

// BUG: Comparing items from different reactive sources
const listA = reactive([{ id: 1 }])
const listB = reactive([{ id: 1 }])
if (listA[0] === listB[0]) {
  // Never true, even though they represent the same data
}
```

**Correct:**
```javascript
import { reactive, toRaw } from 'vue'

const original = { id: 1, name: 'Item' }
const state = reactive(original)

// CORRECT: Use toRaw() for identity comparison
if (toRaw(state) === original) {
  console.log('Same underlying object') // Works!
}

// BEST: Use unique identifiers instead
const items = reactive([
  { id: 'uuid-1', name: 'Item 1' },
  { id: 'uuid-2', name: 'Item 2' }
])

function findItem(targetId) {
  return items.find(item => item.id === targetId)
}

function isSelected(item) {
  return selectedId.value === item.id // Compare IDs, not objects
}

// CORRECT: For Set/Map operations, use primitive keys
const selectedIds = reactive(new Set())
selectedIds.add(item.id)  // Use ID, not object
selectedIds.has(item.id)  // Check by ID
```

```javascript
// When you must compare objects, use toRaw on both sides
import { toRaw, isReactive } from 'vue'

function areEqual(a, b) {
  const rawA = isReactive(a) ? toRaw(a) : a
  const rawB = isReactive(b) ? toRaw(b) : b
  return rawA === rawB
}
```

## Reference
- [Vue.js Reactivity in Depth](https://vuejs.org/guide/extras/reactivity-in-depth.html)
- [Vue.js toRaw() API](https://vuejs.org/api/reactivity-advanced.html#toraw)
