---
title: Deep Watch Callback Receives Same Object Reference for Old and New Values
impact: MEDIUM
impactDescription: Comparing oldValue and newValue in deep watchers is misleading since they reference the same object
type: capability
tags: [vue3, watch, watchers, deep, oldValue, newValue, object-reference]
---

# Deep Watch Callback Receives Same Object Reference for Old and New Values

**Impact: MEDIUM** - When using deep watchers on reactive objects, both `newValue` and `oldValue` in the callback point to the same object reference. They will always be equal for nested mutations because Vue doesn't clone the object before mutation.

Don't rely on comparing `newValue` to `oldValue` in deep watchers for detecting what changed. Instead, track specific values or implement your own diffing.

## Task Checklist

- [ ] Don't compare newValue === oldValue in deep watchers to detect changes
- [ ] For change detection, watch specific properties instead
- [ ] If you need old values, manually snapshot before changes
- [ ] Consider using a serialization approach for complex diffing needs
- [ ] The values differ only when the entire object is replaced

**Incorrect:**
```javascript
import { reactive, watch } from 'vue'

const state = reactive({
  user: {
    name: 'John',
    preferences: { theme: 'dark' }
  }
})

// BAD: Trying to compare old and new values
watch(
  () => state.user,
  (newUser, oldUser) => {
    // This comparison is ALWAYS true for nested mutations!
    if (newUser === oldUser) {
      console.log('Same reference!')  // Always logs for nested changes
    }

    // This also won't work - they're the same object
    if (newUser.name !== oldUser.name) {
      console.log('Name changed')  // Never logs for nested mutations
    }
  },
  { deep: true }
)

// When this happens:
state.user.name = 'Jane'
// Both newUser and oldUser are { name: 'Jane', preferences: { theme: 'dark' } }
```

**Correct:**
```javascript
import { reactive, watch, ref } from 'vue'

const state = reactive({
  user: {
    name: 'John',
    preferences: { theme: 'dark' }
  }
})

// CORRECT: Watch specific properties you care about
watch(
  () => state.user.name,
  (newName, oldName) => {
    console.log(`Name changed from "${oldName}" to "${newName}"`)
    // oldName and newName are primitives, work correctly
  }
)

// CORRECT: Watch multiple specific properties
watch(
  [() => state.user.name, () => state.user.preferences.theme],
  ([newName, newTheme], [oldName, oldTheme]) => {
    if (newName !== oldName) {
      console.log(`Name: ${oldName} -> ${newName}`)
    }
    if (newTheme !== oldTheme) {
      console.log(`Theme: ${oldTheme} -> ${newTheme}`)
    }
  }
)
```

## Manual Snapshot Pattern

```javascript
import { reactive, watch, ref } from 'vue'

const state = reactive({ count: 0, items: [] })

// Keep a manual snapshot for comparison
const previousSnapshot = ref(JSON.stringify(state))

watch(
  state,
  (newState) => {
    const currentSnapshot = JSON.stringify(newState)

    if (currentSnapshot !== previousSnapshot.value) {
      const oldData = JSON.parse(previousSnapshot.value)
      console.log('Old:', oldData)
      console.log('New:', newState)

      // Update snapshot for next comparison
      previousSnapshot.value = currentSnapshot
    }
  },
  { deep: true }
)
```

## When Old and New Values Differ

```javascript
import { reactive, watch } from 'vue'

const state = reactive({
  currentUser: { name: 'John' }
})

watch(
  () => state.currentUser,
  (newUser, oldUser) => {
    // THESE DIFFER when the object itself is replaced
    console.log('Old:', oldUser)  // { name: 'John' }
    console.log('New:', newUser)  // { name: 'Jane' }
  },
  { deep: true }
)

// Object replacement - old and new are different
state.currentUser = { name: 'Jane' }

// vs. Mutation - old and new are the same reference
// state.currentUser.name = 'Jane'
```

## Using Getter Returns New Object

```javascript
import { reactive, watch } from 'vue'

const state = reactive({
  user: { firstName: 'John', lastName: 'Doe' }
})

// CORRECT: Getter returns new object, so old/new comparison works
watch(
  () => ({ ...state.user }),  // Shallow clone
  (newUser, oldUser) => {
    // Now these are different objects
    console.log('Changed from', oldUser, 'to', newUser)
  },
  { deep: true }
)
```

## Reference
- [Vue.js Watchers - Deep Watchers](https://vuejs.org/guide/essentials/watchers.html#deep-watchers)
