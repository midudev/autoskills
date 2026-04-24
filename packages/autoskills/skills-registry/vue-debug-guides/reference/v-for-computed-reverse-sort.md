---
title: Copy Arrays Before reverse() or sort() in Computed Properties
impact: MEDIUM
impactDescription: reverse() and sort() mutate the original array, causing unintended side effects in computed getters
type: gotcha
tags: [vue3, v-for, computed, array, mutation, list-rendering]
---

# Copy Arrays Before reverse() or sort() in Computed Properties

**Impact: MEDIUM** - The `reverse()` and `sort()` methods mutate the original array in-place. When used directly in a computed property getter, this causes the source array to be modified, leading to infinite reactivity loops or incorrect data state.

Computed properties should be pure - they calculate a value without side effects. Mutating the source data inside a computed getter violates this principle and causes unpredictable behavior.

## Task Checklist

- [ ] Always create a copy of the array before calling `reverse()` or `sort()` in computed properties
- [ ] Use spread operator `[...array]` or `Array.from(array)` or `array.slice()` to copy
- [ ] This applies to any in-place mutation method used in computed getters
- [ ] Consider using `toSorted()` and `toReversed()` (ES2023) which return new arrays

**Incorrect:**
```javascript
const numbers = ref([1, 2, 3, 4, 5])

// WRONG: Mutates the original array
const reversedNumbers = computed(() => {
  return numbers.value.reverse()  // Modifies numbers.value!
})

// WRONG: Same issue with sort
const sortedItems = computed(() => {
  return items.value.sort((a, b) => a.name.localeCompare(b.name))
})
```

**Correct:**
```javascript
const numbers = ref([1, 2, 3, 4, 5])

// CORRECT: Create a copy first with spread operator
const reversedNumbers = computed(() => {
  return [...numbers.value].reverse()
})

// CORRECT: Create a copy before sorting
const sortedItems = computed(() => {
  return [...items.value].sort((a, b) => a.name.localeCompare(b.name))
})

// CORRECT: Using slice() to copy
const reversedNumbers = computed(() => {
  return numbers.value.slice().reverse()
})

// CORRECT: ES2023 non-mutating methods (if supported)
const reversedNumbers = computed(() => {
  return numbers.value.toReversed()
})

const sortedItems = computed(() => {
  return items.value.toSorted((a, b) => a.price - b.price)
})
```

## Also Applies to Methods Used in Templates

When using methods to filter/sort in nested v-for loops, the same rule applies:

```javascript
// CORRECT: Method that doesn't mutate
function getSortedChildren(parent) {
  return [...parent.children].sort((a, b) => a.order - b.order)
}
```

```html
<ul v-for="parent in parents" :key="parent.id">
  <li v-for="child in getSortedChildren(parent)" :key="child.id">
    {{ child.name }}
  </li>
</ul>
```

## Reference
- [Vue.js List Rendering - Displaying Filtered/Sorted Results](https://vuejs.org/guide/essentials/list.html#displaying-filtered-sorted-results)
