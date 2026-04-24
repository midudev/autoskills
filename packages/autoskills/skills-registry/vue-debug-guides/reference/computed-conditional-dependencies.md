---
title: Ensure All Dependencies Are Accessed in Computed Properties
impact: HIGH
impactDescription: Conditional logic can prevent dependency tracking causing stale computed values
type: capability
tags: [vue3, computed, reactivity, dependency-tracking, gotcha]
---

# Ensure All Dependencies Are Accessed in Computed Properties

**Impact: HIGH** - Vue tracks computed property dependencies by monitoring which reactive properties are accessed during execution. If conditional logic prevents a property from being accessed on the first run, Vue won't track it as a dependency, causing the computed property to not update when that property changes.

This is a subtle but common source of bugs, especially with short-circuit evaluation (`&&`, `||`) and early returns.

## Task Checklist

- [ ] Access all reactive dependencies before any conditional logic
- [ ] Be cautious with short-circuit operators (`&&`, `||`) that may skip property access
- [ ] Store all dependencies in variables at the start of the computed getter
- [ ] Test computed properties with different initial states

**Incorrect:**
```vue
<script setup>
import { ref, computed } from 'vue'

const isEnabled = ref(false)
const data = ref('important data')

// BAD: If isEnabled is false initially, data.value is never accessed
// Vue won't track 'data' as a dependency!
const result = computed(() => {
  if (!isEnabled.value) {
    return 'disabled'
  }
  return data.value  // This dependency may not be tracked
})

// BAD: Short-circuit prevents second access
const password = ref('')
const confirmPassword = ref('')

const isValid = computed(() => {
  // If password is empty, confirmPassword is never accessed
  return password.value && password.value === confirmPassword.value
})

// BAD: Early return prevents dependency access
const user = ref(null)
const permissions = ref(['read', 'write'])

const canEdit = computed(() => {
  if (!user.value) {
    return false  // permissions.value never accessed when user is null
  }
  return permissions.value.includes('write')
})
</script>
```

**Correct:**
```vue
<script setup>
import { ref, computed } from 'vue'

const isEnabled = ref(false)
const data = ref('important data')

// GOOD: Access all dependencies first
const result = computed(() => {
  const enabled = isEnabled.value
  const currentData = data.value  // Always accessed

  if (!enabled) {
    return 'disabled'
  }
  return currentData
})

// GOOD: Access both values before comparison
const password = ref('')
const confirmPassword = ref('')

const isValid = computed(() => {
  const pwd = password.value
  const confirm = confirmPassword.value  // Always accessed

  return pwd && pwd === confirm
})

// GOOD: Access all reactive sources upfront
const user = ref(null)
const permissions = ref(['read', 'write'])

const canEdit = computed(() => {
  const currentUser = user.value
  const currentPermissions = permissions.value  // Always accessed

  if (!currentUser) {
    return false
  }
  return currentPermissions.includes('write')
})
</script>
```

## The Dependency Tracking Mechanism

Vue's reactivity system works by tracking which reactive properties are accessed when a computed property runs:

```javascript
// How Vue tracks dependencies (simplified):
// 1. Start tracking
// 2. Run the getter function
// 3. Record every .value or reactive property access
// 4. Stop tracking

const computed = computed(() => {
  // Vue starts tracking here
  if (conditionA.value) {      // conditionA is tracked
    return valueB.value        // valueB is ONLY tracked if conditionA is true
  }
  return 'default'             // If conditionA is false, valueB is NOT tracked!
})
```

## Pattern: Destructure All Dependencies First

```javascript
// GOOD PATTERN: Destructure/access everything at the top
const result = computed(() => {
  // Access all potential dependencies
  const { user, settings, items } = toRefs(store)
  const userVal = user.value
  const settingsVal = settings.value
  const itemsVal = items.value

  // Now use conditional logic safely
  if (!userVal) return []
  if (!settingsVal.enabled) return []
  return itemsVal.filter(i => i.active)
})
```

## Reference
- [Vue.js Reactivity in Depth](https://vuejs.org/guide/extras/reactivity-in-depth.html)
- [GitHub Discussion: Dependency collection gotcha with conditionals](https://github.com/vuejs/Discussion/issues/15)
