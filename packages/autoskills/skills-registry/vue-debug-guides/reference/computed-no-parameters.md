---
title: Computed Properties Cannot Accept Parameters
impact: MEDIUM
impactDescription: Attempting to pass arguments to computed properties fails or defeats caching
type: capability
tags: [vue3, computed, methods, parameters, common-mistake]
---

# Computed Properties Cannot Accept Parameters

**Impact: MEDIUM** - Computed properties are designed to derive values from reactive state without parameters. Attempting to pass arguments defeats the caching mechanism or causes errors. Use methods or computed properties that return functions instead.

## Task Checklist

- [ ] Use methods when you need to pass parameters
- [ ] Consider if the parameter can be reactive state instead
- [ ] If you must parameterize, understand that returning a function loses caching benefits
- [ ] Prefer method calls in templates for parameterized operations

**Incorrect:**
```vue
<template>
  <!-- BAD: Computed properties don't accept parameters like this -->
  <p>{{ filteredItems('active') }}</p>
  <p>{{ formattedPrice(100, 'USD') }}</p>
</template>

<script setup>
import { ref, computed } from 'vue'

const items = ref([/* ... */])

// BAD: This won't work as expected
// Computed is called once, not per parameter
const filteredItems = computed((status) => {  // status will be undefined or previous value
  return items.value.filter(i => i.status === status)
})
</script>
```

```vue
<script>
export default {
  data() {
    return { items: [/* ... */] }
  },
  computed: {
    // BAD: Computed doesn't receive arguments
    filteredItems(status) {  // 'status' is actually 'this' or undefined
      return this.items.filter(i => i.status === status)
    }
  }
}
</script>
```

**Correct:**
```vue
<template>
  <!-- GOOD: Use method for parameterized operations -->
  <p>{{ getFilteredItems('active') }}</p>
  <p>{{ formatPrice(100, 'USD') }}</p>

  <!-- GOOD: Or use computed with reactive filter state -->
  <select v-model="statusFilter">
    <option value="active">Active</option>
    <option value="inactive">Inactive</option>
  </select>
  <p>{{ filteredItems }}</p>
</template>

<script setup>
import { ref, computed } from 'vue'

const items = ref([/* ... */])
const statusFilter = ref('active')

// GOOD: Method for parameterized operations
function getFilteredItems(status) {
  return items.value.filter(i => i.status === status)
}

function formatPrice(amount, currency) {
  return new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency
  }).format(amount)
}

// GOOD: Computed with reactive parameter
const filteredItems = computed(() => {
  return items.value.filter(i => i.status === statusFilter.value)
})
</script>
```

## Workaround: Computed Returning a Function

If you need something computed-like with parameters, you can return a function. **However, this defeats the caching benefit:**

```vue
<template>
  <p>{{ getItemsByStatus('active') }}</p>
</template>

<script setup>
import { ref, computed } from 'vue'

const items = ref([/* ... */])

// This works but provides NO caching benefit
// The inner function runs every time it's called
const getItemsByStatus = computed(() => {
  return (status) => items.value.filter(i => i.status === status)
})

// This is essentially equivalent to just using a method
// Only useful if you need to compose with other computed properties
</script>
```

## When to Use Each Approach

| Scenario | Approach | Caching |
|----------|----------|---------|
| Fixed filter based on reactive state | Computed | Yes |
| Dynamic filter passed as argument | Method | No |
| Filter options from user selection | Computed + reactive param | Yes |
| Formatting with variable parameters | Method | No |
| Composed derivation with argument | Computed returning function | Partial |

## Make Parameters Reactive

The best pattern is often to make the "parameter" a reactive value:

```vue
<script setup>
import { ref, computed } from 'vue'

const items = ref([/* ... */])

// Instead of passing 'status' as a parameter:
const currentStatus = ref('active')

// Make a computed that uses the reactive status
const filteredItems = computed(() => {
  return items.value.filter(i => i.status === currentStatus.value)
})

// Change the filter by updating the ref
function filterByStatus(status) {
  currentStatus.value = status
}
</script>
```

## Reference
- [Vue.js Computed Properties](https://vuejs.org/guide/essentials/computed.html)
- [Vue.js Methods](https://vuejs.org/guide/essentials/reactivity-fundamentals.html#declaring-methods)
