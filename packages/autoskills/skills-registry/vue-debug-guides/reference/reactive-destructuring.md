---
title: Never Destructure reactive() Objects Directly
impact: HIGH
impactDescription: Destructuring reactive objects breaks reactivity - changes won't trigger updates
type: capability
tags: [vue3, reactivity, reactive, composition-api, destructuring]
---

# Never Destructure reactive() Objects Directly

**Impact: HIGH** - Destructuring a `reactive()` object breaks the reactive connection. Updates to destructured variables won't trigger UI updates, leading to stale data display.

Vue's `reactive()` uses JavaScript Proxies to track property access. When you destructure, you extract primitive values from the proxy, losing the reactive connection. This is especially dangerous when destructuring from composables or imported state.

## Task Checklist

- [ ] Never destructure reactive objects directly if you need reactivity
- [ ] Use `toRefs()` to convert reactive object properties to refs before destructuring
- [ ] Consider using `ref()` instead of `reactive()` to avoid this pitfall entirely
- [ ] When importing state from composables, check if it's reactive before destructuring

**Incorrect:**
```javascript
import { reactive } from 'vue'

const state = reactive({
  count: 0,
  name: 'Vue'
})

// WRONG: Destructuring breaks reactivity
const { count, name } = state

// These updates work on the original state...
state.count++  // state.count is now 1

// ...but the destructured variables are NOT updated
console.log(count)  // Still 0! Lost reactivity
```

```javascript
// WRONG: Destructuring from a composable
function useCounter() {
  const state = reactive({ count: 0 })
  return state
}

const { count } = useCounter()  // count is now a non-reactive primitive
```

**Correct:**
```javascript
import { reactive, toRefs } from 'vue'

const state = reactive({
  count: 0,
  name: 'Vue'
})

// CORRECT: Use toRefs() to maintain reactivity
const { count, name } = toRefs(state)

state.count++
console.log(count.value)  // 1 - Reactivity preserved! (note: now needs .value)
```

```javascript
// CORRECT: Return toRefs from composables
function useCounter() {
  const state = reactive({ count: 0 })
  return toRefs(state)  // Now safe to destructure
}

const { count } = useCounter()  // count is now a ref, reactivity preserved
```

```javascript
// ALTERNATIVE: Just use ref() to avoid the issue entirely
import { ref } from 'vue'

const count = ref(0)
const name = ref('Vue')

// No destructuring needed, no gotchas
```

## Reference
- [Vue.js Reactivity Fundamentals - reactive()](https://vuejs.org/guide/essentials/reactivity-fundamentals.html#reactive)
- [Vue.js Reactivity API - toRefs()](https://vuejs.org/api/reactivity-utilities.html#torefs)
