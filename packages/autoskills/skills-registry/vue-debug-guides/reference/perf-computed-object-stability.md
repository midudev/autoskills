---
title: Return Stable Object References from Computed Properties
impact: MEDIUM
impactDescription: Computed properties returning new objects trigger effects even when values haven't meaningfully changed
type: efficiency
tags: [vue3, computed, performance, reactivity, vue3.4]
---

# Return Stable Object References from Computed Properties

**Impact: MEDIUM** - In Vue 3.4+, computed properties only trigger effects when their value changes. However, if a computed returns a new object each time, Vue cannot detect that the values inside are the same. This causes unnecessary effect re-runs.

For primitive values, Vue 3.4+ handles this automatically. For objects, manually compare and return the previous value when nothing meaningful has changed.

## Task Checklist

- [ ] For computed properties returning primitives, Vue 3.4+ handles stability automatically
- [ ] For computed properties returning objects, compare with previous value and return old reference if unchanged
- [ ] Always perform the full computation before comparing (to track dependencies correctly)
- [ ] Consider if you really need to return an object, or if primitives would suffice

**Incorrect:**
```vue
<script setup>
import { ref, computed, watchEffect } from 'vue'

const count = ref(0)

// BAD: Returns new object every time, always triggers effects
const stats = computed(() => {
  return {
    isEven: count.value % 2 === 0,
    doubleValue: count.value * 2
  }
})

watchEffect(() => {
  console.log('Stats changed:', stats.value)
  // Logs on EVERY count change, even when isEven hasn't changed
  // count: 0 -> 2 -> 4: isEven is always true, but effect runs each time
})
</script>
```

**Correct:**
```vue
<script setup>
import { ref, computed, watchEffect } from 'vue'

const count = ref(0)

// GOOD (Vue 3.4+): Primitive computed - automatic stability
const isEven = computed(() => count.value % 2 === 0)

watchEffect(() => {
  console.log('isEven:', isEven.value)
  // Only logs when isEven actually changes (0, 2, 4 won't re-trigger)
})

// GOOD (Vue 3.4+): Manual comparison for object returns
const stats = computed((oldValue) => {
  // Step 1: Always compute the new value first (to track dependencies)
  const newValue = {
    isEven: count.value % 2 === 0,
    category: count.value < 10 ? 'small' : 'large'
  }

  // Step 2: Compare with previous value
  if (oldValue &&
      oldValue.isEven === newValue.isEven &&
      oldValue.category === newValue.category) {
    return oldValue  // Return old reference - no effect triggers
  }

  return newValue
})

watchEffect(() => {
  console.log('Stats changed:', stats.value)
  // Now only logs when isEven or category actually changes
})
</script>
```

## Primitive vs Object Computed Behavior (Vue 3.4+)

```javascript
import { ref, computed, watchEffect } from 'vue'

const count = ref(0)

// PRIMITIVE: Vue automatically detects value hasn't changed
const isEven = computed(() => count.value % 2 === 0)

watchEffect(() => console.log(isEven.value))  // true

count.value = 2  // isEven still true - NO log
count.value = 4  // isEven still true - NO log
count.value = 3  // isEven now false - logs: false

// OBJECT: New reference every time (without manual comparison)
const obj = computed(() => ({ isEven: count.value % 2 === 0 }))

watchEffect(() => console.log(obj.value))  // { isEven: true }

count.value = 2  // Logs again! New object reference
count.value = 4  // Logs again! New object reference
```

## Advanced: Deep Object Comparison

```javascript
import { ref, computed } from 'vue'
import { isEqual } from 'lodash-es'  // For deep comparison

const filters = ref({ category: 'all', sortBy: 'date', page: 1 })

// For complex objects, use deep comparison
const activeFilters = computed((oldValue) => {
  const newValue = {
    ...filters.value,
    hasFilters: filters.value.category !== 'all' || filters.value.sortBy !== 'date'
  }

  // Deep compare for complex objects
  if (oldValue && isEqual(oldValue, newValue)) {
    return oldValue
  }

  return newValue
})
```

## Important: Always Compute Before Comparing

```javascript
// BAD: Early return prevents dependency tracking
const optimized = computed((oldValue) => {
  if (oldValue && someCondition) {
    return oldValue  // Dependencies not tracked!
  }
  return computeExpensiveValue()
})

// GOOD: Compute first, then compare
const optimized = computed((oldValue) => {
  const newValue = computeExpensiveValue()  // Always track dependencies
  if (oldValue && newValue === oldValue) {
    return oldValue
  }
  return newValue
})
```

## Reference
- [Vue.js Performance - Computed Stability](https://vuejs.org/guide/best-practices/performance.html#computed-stability)
- [Vue.js Computed Properties](https://vuejs.org/guide/essentials/computed.html)
