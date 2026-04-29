---
title: VNodes Must Be Unique in Render Functions
impact: HIGH
impactDescription: Reusing vnode references causes rendering bugs and unexpected behavior
type: gotcha
tags: [vue3, render-function, vnode, composition-api]
---

# VNodes Must Be Unique in Render Functions

**Impact: HIGH** - Reusing the same vnode reference multiple times in a render function tree causes rendering bugs, where only one instance appears or updates behave unexpectedly.

Every vnode in a component's render tree must be unique. You cannot use the same vnode object multiple times. If you need to render the same element multiple times, create each vnode separately using a factory function or by calling `h()` in a loop.

## Task Checklist

- [ ] Never store a vnode in a variable and use it multiple times in the same tree
- [ ] Use a factory function or `.map()` to create multiple similar vnodes
- [ ] Each `h()` call creates a new vnode, so call it for each instance needed
- [ ] Be especially careful when extracting vnode creation into helper functions

**Incorrect:**
```javascript
import { h } from 'vue'

export default {
  setup() {
    return () => {
      // WRONG: Same vnode reference used twice
      const p = h('p', 'Hello')
      return h('div', [p, p]) // Bug! Duplicate vnode reference
    }
  }
}
```

```javascript
import { h } from 'vue'

export default {
  setup() {
    return () => {
      // WRONG: Reusing vnode in different parts of tree
      const icon = h('span', { class: 'icon' }, '★')
      return h('div', [
        h('button', [icon, ' Save']),    // Uses icon
        h('button', [icon, ' Delete'])   // Reuses same icon - Bug!
      ])
    }
  }
}
```

**Correct:**
```javascript
import { h } from 'vue'

export default {
  setup() {
    return () => {
      // CORRECT: Create new vnode for each use
      return h('div', [
        h('p', 'Hello'),
        h('p', 'Hello')
      ])
    }
  }
}
```

```javascript
import { h } from 'vue'

export default {
  setup() {
    return () => {
      // CORRECT: Factory function creates new vnode each time
      const createIcon = () => h('span', { class: 'icon' }, '★')
      return h('div', [
        h('button', [createIcon(), ' Save']),
        h('button', [createIcon(), ' Delete'])
      ])
    }
  }
}
```

```javascript
import { h } from 'vue'

export default {
  setup() {
    return () => {
      // CORRECT: Using map to create multiple vnodes
      return h('div',
        Array.from({ length: 20 }).map(() => h('p', 'Hello'))
      )
    }
  }
}
```

```javascript
import { h } from 'vue'

export default {
  setup() {
    const items = ['Apple', 'Banana', 'Cherry']

    return () => h('ul',
      // CORRECT: Each iteration creates a new vnode
      items.map((item, index) =>
        h('li', { key: index }, item)
      )
    )
  }
}
```

## Why VNodes Must Be Unique

VNodes are lightweight JavaScript objects that Vue's virtual DOM algorithm uses for diffing and patching. When the same vnode reference appears multiple times:
- Vue cannot differentiate between the instances
- The diffing algorithm produces incorrect results
- Only one instance may render, or updates may corrupt the DOM

Each vnode maintains its own identity and position in the tree, which is essential for:
- Correct DOM patching during updates
- Proper lifecycle hook execution
- Accurate key-based reconciliation in lists

## Reference
- [Vue.js Render Functions - Vnodes Must Be Unique](https://vuejs.org/guide/extras/render-function.html#vnodes-must-be-unique)
