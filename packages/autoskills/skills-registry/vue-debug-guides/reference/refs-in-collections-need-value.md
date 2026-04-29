---
title: Refs in Arrays and Collections Require .value
impact: MEDIUM
impactDescription: Refs inside reactive arrays, Maps, or Sets are NOT auto-unwrapped like in reactive objects
type: capability
tags: [vue3, reactivity, ref, arrays, collections, unwrapping]
---

# Refs in Arrays and Collections Require .value

**Impact: MEDIUM** - Unlike when a ref is a property of a reactive object, refs inside reactive arrays, Maps, and Sets are NOT automatically unwrapped. You must access them with `.value`, and forgetting this leads to silent bugs.

Vue only auto-unwraps refs when they are properties of reactive objects. When refs are elements in arrays or values in Maps/Sets, they remain as ref objects and require explicit `.value` access.

## Task Checklist

- [ ] Always use `.value` when accessing refs stored in reactive arrays
- [ ] Always use `.value` when accessing refs stored in reactive Maps or Sets
- [ ] Consider storing plain values instead of refs in collections to avoid confusion
- [ ] Be aware of this when iterating over arrays containing refs

**Incorrect:**
```javascript
import { ref, reactive } from 'vue'

const books = reactive([ref('Vue 3 Guide')])
const counts = reactive(new Map([['clicks', ref(0)]]))

// WRONG: Refs in arrays are NOT unwrapped
console.log(books[0])        // Ref object, not 'Vue 3 Guide'
books[0] = 'New Title'       // Replaces the ref, doesn't update it!

// WRONG: Refs in Maps are NOT unwrapped
console.log(counts.get('clicks'))     // Ref object, not 0
counts.get('clicks')++                // Does nothing useful
```

**Correct:**
```javascript
import { ref, reactive } from 'vue'

const books = reactive([ref('Vue 3 Guide')])
const counts = reactive(new Map([['clicks', ref(0)]]))

// CORRECT: Use .value for refs in arrays
console.log(books[0].value)    // 'Vue 3 Guide'
books[0].value = 'New Title'   // Updates the ref's value

// CORRECT: Use .value for refs in Maps
console.log(counts.get('clicks').value)  // 0
counts.get('clicks').value++             // Increments to 1
```

```javascript
// ALTERNATIVE: Just store plain values in collections (simpler)
const books = reactive(['Vue 3 Guide', 'Vuex Handbook'])
const counts = reactive(new Map([['clicks', 0]]))

// No .value needed - but changes to individual items aren't independently reactive
console.log(books[0])            // 'Vue 3 Guide'
console.log(counts.get('clicks')) // 0

// Mutations still trigger reactivity through the reactive wrapper
books[0] = 'New Title'           // Works
counts.set('clicks', counts.get('clicks') + 1)  // Works
```

```vue
<template>
  <!-- In templates, refs in arrays also need special handling -->
  <div v-for="(book, index) in books" :key="index">
    <!-- If book is a ref, you'd need: -->
    {{ book.value }}

    <!-- Or use computed to unwrap them first -->
  </div>
</template>
```

## Reference
- [Vue.js Reactivity Fundamentals - Caveat in Arrays and Collections](https://vuejs.org/guide/essentials/reactivity-fundamentals.html#caveat-in-arrays-and-collections)
