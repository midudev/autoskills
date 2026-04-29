---
title: Return Render Function from setup(), Not Direct VNodes
impact: HIGH
impactDescription: Returning a vnode directly from setup makes it static; returning a function enables reactive updates
type: gotcha
tags: [vue3, render-function, composition-api, setup, reactivity]
---

# Return Render Function from setup(), Not Direct VNodes

**Impact: HIGH** - When using render functions with the Composition API, you must return a function that returns vnodes, not the vnodes directly. Returning vnodes directly creates a static render that never updates when reactive state changes.

## Task Checklist

- [ ] Always return an arrow function from setup() when using render functions
- [ ] Never return h() calls directly from setup()
- [ ] Ensure reactive values are accessed inside the returned function

**Incorrect:**
```js
import { h, ref } from 'vue'

export default {
  setup() {
    const count = ref(0)
    const increment = () => count.value++

    // WRONG: Returns a static vnode, created once
    // Clicking the button updates count.value, but the DOM never changes!
    return h('div', [
      h('p', `Count: ${count.value}`),  // Captures count.value at setup time (0)
      h('button', { onClick: increment }, 'Increment')
    ])
  }
}
```

**Correct:**
```js
import { h, ref } from 'vue'

export default {
  setup() {
    const count = ref(0)
    const increment = () => count.value++

    // CORRECT: Returns a render function
    // Vue calls this function on every reactive update
    return () => h('div', [
      h('p', `Count: ${count.value}`),  // Re-evaluated each render
      h('button', { onClick: increment }, 'Increment')
    ])
  }
}
```

## Why This Happens

```js
// What Vue does internally:

// WRONG approach - setup runs once:
const result = setup()
// result is a vnode { type: 'div', children: [...] }
// Vue renders this once, then has no way to re-render

// CORRECT approach - setup returns a function:
const renderFn = setup()
// renderFn is () => h('div', ...)
// Vue calls renderFn() on mount
// Vue calls renderFn() again whenever dependencies change
```

## Common Mistake: Mixing Template and Render Function

```vue
<script setup>
import { h, ref } from 'vue'

const count = ref(0)

// WRONG: Can't use render functions in script setup with templates
// This h() call does nothing
const node = h('div', count.value)
</script>

<template>
  <!-- Template is used, render function is ignored -->
  <div>{{ count }}</div>
</template>
```

If you need a render function with Composition API, don't use `<script setup>`:

```vue
<script>
import { h, ref } from 'vue'

export default {
  setup() {
    const count = ref(0)
    return () => h('div', count.value)
  }
}
</script>
<!-- No template - render function is used -->
```

## Exposing Values While Using Render Functions

```js
import { h, ref } from 'vue'

export default {
  setup(props, { expose }) {
    const count = ref(0)
    const reset = () => { count.value = 0 }

    // Expose methods for parent refs
    expose({ reset })

    // Still return the render function
    return () => h('div', count.value)
  }
}
```

## With Slots

```js
import { h, ref } from 'vue'

export default {
  setup(props, { slots }) {
    const count = ref(0)

    return () => h('div', [
      h('p', `Count: ${count.value}`),
      // Slots must also be called inside the render function
      slots.default?.()
    ])
  }
}
```

## Reference
- [Vue.js Render Functions with Composition API](https://vuejs.org/guide/extras/render-function.html#render-functions-jsx)
- [Vue.js Composition API setup()](https://vuejs.org/api/composition-api-setup.html)
