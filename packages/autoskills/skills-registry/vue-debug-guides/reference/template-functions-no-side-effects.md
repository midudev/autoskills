---
title: Template Functions Must Be Pure Without Side Effects
impact: MEDIUM
impactDescription: Functions with side effects in templates cause unpredictable behavior on every re-render
type: efficiency
tags: [vue3, template, functions, performance, side-effects]
---

# Template Functions Must Be Pure Without Side Effects

**Impact: MEDIUM** - Functions called in templates execute on every component re-render. Functions with side effects (modifying data, API calls, logging) will cause unpredictable behavior, performance issues, and difficult-to-debug bugs.

Template expressions including function calls are evaluated whenever the component updates. This makes them unsuitable for operations that should only happen once or that modify state.

## Task Checklist

- [ ] Keep template functions pure (same input = same output)
- [ ] Never modify reactive state inside template functions
- [ ] Never make API calls or async operations in template functions
- [ ] Move side effects to event handlers, watchers, or lifecycle hooks
- [ ] Use computed properties for derived values instead of functions when possible
- [ ] Avoid expensive computations; use computed properties for caching

**Incorrect:**
```vue
<template>
  <!-- BAD: Modifies state on every render -->
  <p>{{ incrementAndGet() }}</p>

  <!-- BAD: API call on every render -->
  <div>{{ fetchUserName() }}</div>

  <!-- BAD: Logging side effect -->
  <span>{{ logAndFormat(date) }}</span>

  <!-- BAD: Expensive computation without caching -->
  <ul>
    <li v-for="item in filterAndSort(items)" :key="item.id">
      {{ item.name }}
    </li>
  </ul>

  <!-- BAD: Random values change on every render -->
  <p>{{ getRandomGreeting() }}</p>
</template>

<script setup>
import { ref } from 'vue'

const count = ref(0)
const items = ref([/* large array */])

// BAD: Has side effect - modifies state
function incrementAndGet() {
  count.value++  // Side effect!
  return count.value
}

// BAD: Async operation in template
async function fetchUserName() {
  const res = await fetch('/api/user')  // Side effect!
  return (await res.json()).name
}

// BAD: Logging is a side effect
function logAndFormat(date) {
  console.log('Formatting date:', date)  // Side effect!
  return new Date(date).toLocaleDateString()
}

// BAD: Expensive, runs every render without caching
function filterAndSort(items) {
  return items
    .filter(i => i.active)
    .sort((a, b) => a.name.localeCompare(b.name))
}

// BAD: Non-deterministic
function getRandomGreeting() {
  const greetings = ['Hello', 'Hi', 'Hey']
  return greetings[Math.floor(Math.random() * greetings.length)]
}
</script>
```

**Correct:**
```vue
<template>
  <!-- OK: Pure formatting function -->
  <p>Count: {{ count }}</p>
  <button @click="increment">Increment</button>

  <!-- OK: Data fetched via lifecycle/watcher -->
  <div>{{ userName }}</div>

  <!-- OK: Pure function, no side effects -->
  <span>{{ formatDate(date) }}</span>

  <!-- OK: Computed property caches result -->
  <ul>
    <li v-for="item in filteredAndSortedItems" :key="item.id">
      {{ item.name }}
    </li>
  </ul>

  <!-- OK: Random value set once -->
  <p>{{ greeting }}</p>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'

const count = ref(0)
const userName = ref('')
const date = ref(new Date())
const items = ref([/* large array */])

// Side effects in event handlers
function increment() {
  count.value++
}

// Fetch data in lifecycle hook
onMounted(async () => {
  const res = await fetch('/api/user')
  userName.value = (await res.json()).name
})

// Pure function - same input, same output
function formatDate(date) {
  return new Date(date).toLocaleDateString()
}

// Computed property - cached, only recalculates when dependencies change
const filteredAndSortedItems = computed(() => {
  return items.value
    .filter(i => i.active)
    .sort((a, b) => a.name.localeCompare(b.name))
})

// Set random value once, not on every render
const greetings = ['Hello', 'Hi', 'Hey']
const greeting = ref(greetings[Math.floor(Math.random() * greetings.length)])
</script>
```

## Pure Function Guidelines

A pure function:
1. Given the same inputs, always returns the same output
2. Does not modify any external state
3. Does not perform I/O operations (network, console, file system)
4. Does not depend on mutable external state

```javascript
// PURE - safe for templates
function formatCurrency(amount, currency = 'USD') {
  return new Intl.NumberFormat('en-US', { style: 'currency', currency }).format(amount)
}

function fullName(first, last) {
  return `${first} ${last}`
}

function isExpired(date) {
  return new Date(date) < new Date()
}

// IMPURE - unsafe for templates
function logAndReturn(value) {
  console.log(value)  // I/O
  return value
}

function getFromLocalStorage(key) {
  return localStorage.getItem(key)  // External state
}

function updateAndReturn(obj, key, value) {
  obj[key] = value  // Mutation
  return obj
}
```

## Reference
- [Vue.js Template Syntax - Calling Functions](https://vuejs.org/guide/essentials/template-syntax.html#calling-functions)
- [Vue.js Computed Properties](https://vuejs.org/guide/essentials/computed.html)
