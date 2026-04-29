---
title: Use Getter Function When Watching Reactive Object Properties
impact: HIGH
impactDescription: Watching reactive properties directly passes a primitive value, causing the watcher to never trigger
type: capability
tags: [vue3, watch, watchers, reactive, getter, common-mistake]
---

# Use Getter Function When Watching Reactive Object Properties

**Impact: HIGH** - Directly watching a property of a reactive object passes a primitive value to `watch()`, not a reactive reference. The watcher will never trigger because primitives are not reactive.

When you need to watch a specific property of a reactive object, always wrap it in a getter function `() => obj.property`.

## Task Checklist

- [ ] Always use getter functions when watching properties of reactive objects
- [ ] Remember that `watch(obj.count, ...)` passes the current value, not a reactive reference
- [ ] For refs, you can watch directly: `watch(myRef, ...)`
- [ ] For entire reactive objects, you can watch directly (creates implicit deep watcher)

**Incorrect:**
```javascript
import { reactive, watch } from 'vue'

const state = reactive({ count: 0, name: 'Vue' })

// WRONG: Passes the number 0 to watch(), not a reactive reference
// This watcher will NEVER fire!
watch(state.count, (newCount) => {
  console.log(`Count changed to: ${newCount}`)
})

// WRONG: Same problem with string property
watch(state.name, (newName) => {
  console.log(`Name changed to: ${newName}`)
})
```

**Correct:**
```javascript
import { reactive, watch } from 'vue'

const state = reactive({ count: 0, name: 'Vue' })

// CORRECT: Use a getter function
watch(
  () => state.count,
  (newCount, oldCount) => {
    console.log(`Count changed from ${oldCount} to ${newCount}`)
  }
)

// CORRECT: Multiple properties with getter
watch(
  () => state.name,
  (newName) => {
    console.log(`Name changed to: ${newName}`)
  }
)

// CORRECT: Watching derived values
watch(
  () => state.count * 2,
  (doubledCount) => {
    console.log(`Doubled count: ${doubledCount}`)
  }
)
```

## Watching Multiple Properties

```javascript
import { reactive, watch } from 'vue'

const state = reactive({ firstName: 'John', lastName: 'Doe' })

// Watch multiple properties with array of getters
watch(
  [() => state.firstName, () => state.lastName],
  ([newFirst, newLast], [oldFirst, oldLast]) => {
    console.log(`Name changed from ${oldFirst} ${oldLast} to ${newFirst} ${newLast}`)
  }
)
```

## When Direct Watching Works

```javascript
import { ref, reactive, watch } from 'vue'

const count = ref(0)
const state = reactive({ nested: { value: 1 } })

// CORRECT: Refs can be watched directly
watch(count, (newVal) => {
  console.log(`Count: ${newVal}`)
})

// CORRECT: Entire reactive objects create implicit deep watcher
watch(state, (newState) => {
  // Fires on any nested change
  // Note: newState === oldState (same object reference)
})
```

## Reference
- [Vue.js Watchers - Watch Source Types](https://vuejs.org/guide/essentials/watchers.html#watch-source-types)
