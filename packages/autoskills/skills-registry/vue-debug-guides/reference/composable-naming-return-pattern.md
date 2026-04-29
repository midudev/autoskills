---
title: Follow Composable Naming Convention and Return Pattern
impact: MEDIUM
impactDescription: Inconsistent composable patterns lead to confusing APIs and reactivity issues when destructuring
type: best-practice
tags: [vue3, composables, composition-api, naming, conventions, refs]
---

# Follow Composable Naming Convention and Return Pattern

**Impact: MEDIUM** - Vue composables should follow established conventions: prefix names with "use" and return plain objects containing refs (not reactive objects). Returning reactive objects causes reactivity loss when destructuring, while inconsistent naming makes code harder to understand.

## Task Checklist

- [ ] Name composables with "use" prefix (e.g., `useMouse`, `useFetch`, `useAuth`)
- [ ] Return a plain object containing refs, not a reactive object
- [ ] Allow both destructuring and object-style access
- [ ] Document the returned refs for consumers

**Incorrect:**
```javascript
// WRONG: No "use" prefix - unclear it's a composable
export function mousePosition() {
  const x = ref(0)
  const y = ref(0)
  return { x, y }
}

// WRONG: Returning reactive object - destructuring loses reactivity
export function useMouse() {
  const state = reactive({
    x: 0,
    y: 0
  })
  // When consumer destructures: const { x, y } = useMouse()
  // x and y become plain values, not reactive!
  return state
}

// WRONG: Returning single ref directly - inconsistent API
export function useCounter() {
  const count = ref(0)
  return count  // Consumer must use .value everywhere
}
```

**Correct:**
```javascript
// CORRECT: "use" prefix and returns plain object with refs
export function useMouse() {
  const x = ref(0)
  const y = ref(0)

  function update(event) {
    x.value = event.pageX
    y.value = event.pageY
  }

  onMounted(() => window.addEventListener('mousemove', update))
  onUnmounted(() => window.removeEventListener('mousemove', update))

  // Return plain object containing refs
  return { x, y }
}

// Consumer can destructure and keep reactivity
const { x, y } = useMouse()
watch(x, (newX) => console.log('x changed:', newX))  // Works!

// Or use as object if preferred
const mouse = useMouse()
console.log(mouse.x.value)
```

## Using reactive() Wrapper for Auto-Unwrapping

If consumers prefer auto-unwrapping (no `.value`), they can wrap the result:

```javascript
import { reactive } from 'vue'
import { useMouse } from './composables/useMouse'

// Wrapping in reactive() links the refs
const mouse = reactive(useMouse())

// Now access without .value
console.log(mouse.x)  // Auto-unwrapped, still reactive

// But DON'T destructure from this!
const { x } = reactive(useMouse())  // WRONG: loses reactivity again
```

## Pattern: Returning Both State and Actions

```javascript
// Composable with state AND methods
export function useCounter(initialValue = 0) {
  const count = ref(initialValue)
  const doubleCount = computed(() => count.value * 2)

  function increment() {
    count.value++
  }

  function decrement() {
    count.value--
  }

  function reset() {
    count.value = initialValue
  }

  // Return all refs and functions in plain object
  return {
    count,
    doubleCount,
    increment,
    decrement,
    reset
  }
}

// Usage
const { count, doubleCount, increment, reset } = useCounter(10)
```

## Naming Convention Examples

| Good Name | Bad Name | Reason |
|-----------|----------|--------|
| `useFetch` | `fetch` | Conflicts with native fetch |
| `useAuth` | `authStore` | "Store" implies Pinia/Vuex |
| `useLocalStorage` | `localStorage` | Conflicts with native API |
| `useFormValidation` | `validateForm` | Sounds like a one-shot function |
| `useWindowSize` | `getWindowSize` | "get" implies synchronous getter |

## Reference
- [Vue.js Composables - Conventions and Best Practices](https://vuejs.org/guide/reusability/composables.html#conventions-and-best-practices)
- [Vue.js Composables - Return Values](https://vuejs.org/guide/reusability/composables.html#return-values)
