---
title: Vue Composition API Runs Once, Unlike React Hooks
impact: MEDIUM
impactDescription: Understanding this difference prevents over-engineering and React patterns that don't apply
type: gotcha
tags: [vue3, composition-api, react-hooks, setup, stale-closure]
---

# Vue Composition API Runs Once, Unlike React Hooks

**Impact: MEDIUM** - Vue's `setup()` or `<script setup>` executes only once per component instance, while React Hooks run on every render. Developers coming from React often apply patterns (dependency arrays, excessive memoization, useCallback) that are unnecessary and counterproductive in Vue.

Understanding this fundamental difference is crucial for writing idiomatic Vue code. Vue's approach eliminates entire categories of bugs (stale closures, exhaustive deps) that plague React applications.

## Task Checklist

- [ ] Don't implement "dependency arrays" - Vue tracks dependencies automatically
- [ ] Don't wrap functions in "useCallback" equivalents - not needed in Vue
- [ ] Don't use "useMemo" patterns - Vue's `computed()` handles this automatically
- [ ] Understand that closures in Vue don't go "stale" like in React
- [ ] Don't worry about "call order" - Vue composables can be conditional

**React Patterns to Avoid in Vue:**
```javascript
// These patterns are UNNECESSARY in Vue - they solve React-specific problems

// WRONG: Trying to implement dependency arrays (React pattern)
watch(
  [dep1, dep2, dep3],  // Vue tracks deps automatically in watchEffect
  () => {
    // ...
  }
)
// Unless you specifically WANT to control which deps trigger the watcher,
// prefer watchEffect() which auto-tracks

// WRONG: Memoizing callbacks like useCallback
const memoizedHandler = computed(() => {
  return () => doSomething(state.value)
})
// In Vue, just define the function normally - no memoization needed

// WRONG: Worrying about stale closures
function useData() {
  const data = ref(null)

  // In React, this could capture stale 'data' - NOT in Vue!
  // Vue refs are always current
  const handler = () => {
    console.log(data.value)  // Always gets current value
  }

  return { data, handler }
}
```

**Correct Vue Patterns:**
```javascript
import { ref, computed, watchEffect } from 'vue'

// CORRECT: Auto-dependency tracking with watchEffect
const query = ref('')
const filter = ref('all')

watchEffect(() => {
  // Vue automatically detects that this depends on query and filter
  // No dependency array needed!
  fetchResults(query.value, filter.value)
})

// CORRECT: computed() handles memoization automatically
const expensiveResult = computed(() => {
  // Only recalculates when dependencies actually change
  return heavyComputation(data.value)
})

// CORRECT: Functions don't need memoization
function handleClick() {
  count.value++
}
// Just use it directly - no useCallback wrapper needed
// <button @click="handleClick">

// CORRECT: Closures always access current values
const count = ref(0)
const message = ref('')

function logState() {
  // This always logs CURRENT values, never stale ones
  console.log(`Count: ${count.value}, Message: ${message.value}`)
}

setTimeout(() => {
  logState()  // Gets current values even if called later
}, 5000)
```

## Vue's Advantages Over React Hooks

```javascript
// 1. No stale closure problems
const count = ref(0)

onMounted(() => {
  setInterval(() => {
    // In React: would need useRef or deps array to avoid stale value
    // In Vue: count.value is always current
    console.log(count.value)
  }, 1000)
})

// 2. Composables can be conditional
if (featureEnabled) {
  const { data } = useSomeFeature()  // This is FINE in Vue!
}
// In React: "Hooks cannot be conditional" - not a problem in Vue

// 3. No exhaustive-deps linting headaches
watchEffect(() => {
  // Use any reactive values - Vue tracks them all automatically
  // No ESLint rule yelling about missing dependencies
  doSomething(a.value, b.value, c.value)
})

// 4. Child components don't need memoization by default
// Vue's reactivity system only updates what actually changed
// No need for React.memo() equivalents in most cases
```

## When Vue Patterns Differ

```javascript
// Setup runs once - so initialization happens once
<script setup>
import { ref, onMounted } from 'vue'

// This code runs ONCE when component is created
const data = ref(null)
console.log('Setup running')  // Only logs once

onMounted(() => {
  console.log('Mounted')  // Only logs once
})

// If you need something to run on every reactive change,
// use watch or watchEffect
watchEffect(() => {
  // This runs when dependencies change
  console.log('Data changed:', data.value)
})
</script>
```

## Reference
- [Composition API FAQ - Relationship with React Hooks](https://vuejs.org/guide/extras/composition-api-faq.html#relationship-with-react-hooks)
- [Reactivity Fundamentals](https://vuejs.org/guide/essentials/reactivity-fundamentals.html)
