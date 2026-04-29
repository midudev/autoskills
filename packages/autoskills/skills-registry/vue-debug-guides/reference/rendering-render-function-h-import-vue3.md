---
title: Import h Globally in Vue 3 Render Functions
impact: HIGH
impactDescription: Vue 3 requires explicit h import; using Vue 2 patterns causes runtime errors
type: gotcha
tags: [vue3, render-function, migration, h, vnode, breaking-change]
---

# Import h Globally in Vue 3 Render Functions

**Impact: HIGH** - In Vue 2, the `h` function (createElement) was passed as an argument to render functions. In Vue 3, `h` must be explicitly imported from 'vue'. Using Vue 2 patterns causes runtime errors.

## Task Checklist

- [ ] Import `h` from 'vue' at the top of files using render functions
- [ ] Remove the `h` parameter from render function signatures
- [ ] Update all render functions when migrating from Vue 2

**Incorrect (Vue 2 pattern - broken in Vue 3):**
```js
// WRONG: Vue 2 pattern - h is not passed as argument in Vue 3
export default {
  render(h) {  // h is undefined in Vue 3!
    return h('div', [
      h('span', 'Hello')
    ])
  }
}

// WRONG: Using createElement alias from Vue 2
export default {
  render(createElement) {  // Also undefined
    return createElement('div', 'Hello')
  }
}
```

**Correct (Vue 3 pattern):**
```js
// CORRECT: Import h from vue
import { h } from 'vue'

export default {
  render() {
    return h('div', [
      h('span', 'Hello')
    ])
  }
}
```

## With Composition API

```js
import { h, ref } from 'vue'

export default {
  setup() {
    const count = ref(0)

    // Return a render function from setup
    return () => h('div', [
      h('button', { onClick: () => count.value++ }, `Count: ${count.value}`)
    ])
  }
}
```

## With script setup (Not Recommended)

```vue
<script setup>
import { h, ref } from 'vue'

const count = ref(0)

// Cannot return render function from script setup
// Must use a separate render option or template
</script>

<!-- script setup typically uses templates, not render functions -->
<template>
  <div>
    <button @click="count++">Count: {{ count }}</button>
  </div>
</template>
```

If you need render functions with `<script setup>`, use the `render` option:

```vue
<script>
import { h, ref } from 'vue'

export default {
  setup() {
    const count = ref(0)
    return () => h('button', { onClick: () => count.value++ }, count.value)
  }
}
</script>
```

## Component Resolution Change

In Vue 3, you must also explicitly resolve components:

**Incorrect:**
```js
// Vue 2: Could use string names for registered components
render(h) {
  return h('my-component', { props: { value: 1 } })
}
```

**Correct:**
```js
import { h, resolveComponent } from 'vue'

export default {
  render() {
    // Must resolve component by name
    const MyComponent = resolveComponent('my-component')
    return h(MyComponent, { value: 1 })
  }
}

// Or import the component directly (preferred)
import { h } from 'vue'
import MyComponent from './MyComponent.vue'

export default {
  render() {
    return h(MyComponent, { value: 1 })
  }
}
```

## Why This Changed

Vue 3's `h` is globally importable to:
1. Enable tree-shaking (unused features can be removed)
2. Support better TypeScript inference
3. Allow use outside of component context

## Reference
- [Vue 3 Migration Guide - Render Function API](https://v3-migration.vuejs.org/breaking-changes/render-function-api.html)
- [Vue.js Render Functions & JSX](https://vuejs.org/guide/extras/render-function.html)
