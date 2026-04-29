---
title: Avoid Mutating Methods on Arrays in Computed Properties
impact: HIGH
impactDescription: Array mutating methods in computed modify source data causing unexpected behavior
type: capability
tags: [vue3, computed, arrays, mutation, sort, reverse]
---

# Avoid Mutating Methods on Arrays in Computed Properties

**Impact: HIGH** - JavaScript array methods like `reverse()`, `sort()`, `splice()`, `push()`, `pop()`, `shift()`, and `unshift()` mutate the original array. Using them directly on reactive arrays inside computed properties will modify your source data, causing unexpected side effects and bugs.

## Task Checklist

- [ ] Always create a copy of arrays before using mutating methods
- [ ] Use spread operator `[...array]` or `slice()` to copy arrays
- [ ] Prefer non-mutating alternatives when available
- [ ] Be aware which array methods mutate vs return new arrays

**Incorrect:**
```vue
<script setup>
import { ref, computed } from 'vue'

const items = ref([3, 1, 4, 1, 5, 9, 2, 6])
const users = ref([
  { name: 'Alice', age: 30 },
  { name: 'Bob', age: 25 }
])

// BAD: sort() mutates the original array!
const sortedItems = computed(() => {
  return items.value.sort((a, b) => a - b)
})

// BAD: reverse() mutates the original array!
const reversedItems = computed(() => {
  return items.value.reverse()
})

// BAD: Both arrays now point to the same mutated data
// items.value and sortedItems.value are the SAME array
// items.value and reversedItems.value are the SAME array

// BAD: Chained mutations
const sortedUsers = computed(() => {
  return users.value.sort((a, b) => a.age - b.age)
})
</script>

<template>
  <!-- Original array is corrupted! -->
  <div>Original: {{ items }}</div>
  <div>Sorted: {{ sortedItems }}</div>
</template>
```

**Correct:**
```vue
<script setup>
import { ref, computed } from 'vue'

const items = ref([3, 1, 4, 1, 5, 9, 2, 6])
const users = ref([
  { name: 'Alice', age: 30 },
  { name: 'Bob', age: 25 }
])

// GOOD: Spread operator creates a copy first
const sortedItems = computed(() => {
  return [...items.value].sort((a, b) => a - b)
})

// GOOD: slice() also creates a copy
const reversedItems = computed(() => {
  return items.value.slice().reverse()
})

// GOOD: Copy before sorting objects
const sortedUsers = computed(() => {
  return [...users.value].sort((a, b) => a.age - b.age)
})

// GOOD: Use toSorted() (ES2023) - non-mutating
const sortedItemsModern = computed(() => {
  return items.value.toSorted((a, b) => a - b)
})

// GOOD: Use toReversed() (ES2023) - non-mutating
const reversedItemsModern = computed(() => {
  return items.value.toReversed()
})
</script>

<template>
  <!-- Original array stays intact -->
  <div>Original: {{ items }}</div>
  <div>Sorted: {{ sortedItems }}</div>
  <div>Reversed: {{ reversedItems }}</div>
</template>
```

## Mutating vs Non-Mutating Array Methods

| Mutating (Avoid in Computed) | Non-Mutating (Safe) |
|------------------------------|---------------------|
| `sort()` | `toSorted()` (ES2023) |
| `reverse()` | `toReversed()` (ES2023) |
| `splice()` | `toSpliced()` (ES2023) |
| `push()` | `concat()` |
| `pop()` | `slice(0, -1)` |
| `shift()` | `slice(1)` |
| `unshift()` | `[item, ...array]` |
| `fill()` | `map()` with new values |

## ES2023 Non-Mutating Alternatives

Modern JavaScript (ES2023) provides non-mutating versions of common array methods:

```javascript
// These return NEW arrays, safe for computed properties
const sorted = array.toSorted((a, b) => a - b)
const reversed = array.toReversed()
const spliced = array.toSpliced(1, 2, 'new')
const withReplaced = array.with(0, 'newFirst')
```

## Deep Copy for Nested Arrays

For arrays of objects where you might mutate nested properties:

```javascript
const items = ref([{ name: 'A', values: [1, 2, 3] }])

// Shallow copy - nested arrays still shared
const copied = computed(() => [...items.value])

// Deep copy if you need to mutate nested structures
const deepCopied = computed(() => {
  return JSON.parse(JSON.stringify(items.value))
  // Or use structuredClone():
  // return structuredClone(items.value)
})
```

## Reference
- [Vue.js Computed Properties - Avoid Mutating Computed Value](https://vuejs.org/guide/essentials/computed.html#avoid-mutating-computed-value)
- [MDN Array Methods](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)
