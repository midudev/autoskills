---
title: Do Not Rely on Internal VNode Properties
impact: MEDIUM
impactDescription: Using undocumented vnode properties causes code to break on Vue updates
type: gotcha
tags: [vue3, render-function, vnode, internal-api]
---

# Do Not Rely on Internal VNode Properties

**Impact: MEDIUM** - The `VNode` interface contains many internal properties used by Vue's rendering system. Relying on any properties other than the documented public ones will cause your code to break when Vue's internal implementation changes.

Only use the documented vnode properties: `type`, `props`, `children`, and `key`. All other properties are internal implementation details that may change without notice between Vue versions.

## Task Checklist

- [ ] Only access documented vnode properties: `type`, `props`, `children`, `key`
- [ ] Never access properties like `el`, `component`, `shapeFlag`, `patchFlag`, etc.
- [ ] If you need DOM element access, use template refs instead
- [ ] Treat vnodes as opaque data structures for rendering, not inspection

**Incorrect:**
```javascript
import { h } from 'vue'

export default {
  setup(props, { slots }) {
    return () => {
      const slotContent = slots.default?.()

      // WRONG: Accessing internal properties
      if (slotContent?.[0]?.el) {
        // el is an internal property
        console.log(slotContent[0].el.tagName)
      }

      // WRONG: Using shapeFlag internal property
      if (slotContent?.[0]?.shapeFlag & 1) {
        // This is internal implementation
      }

      return h('div', slotContent)
    }
  }
}
```

```javascript
// WRONG: Inspecting component instance via vnode
const vnode = h(MyComponent)
console.log(vnode.component) // Internal property
console.log(vnode.appContext) // Internal property
```

**Correct:**
```javascript
import { h } from 'vue'

export default {
  setup(props, { slots }) {
    return () => {
      const slotContent = slots.default?.()

      // CORRECT: Only use documented properties
      if (slotContent?.[0]) {
        const vnode = slotContent[0]
        console.log(vnode.type)     // Safe: element type or component
        console.log(vnode.props)    // Safe: props object
        console.log(vnode.children) // Safe: children
        console.log(vnode.key)      // Safe: key prop
      }

      return h('div', slotContent)
    }
  }
}
```

```javascript
import { h, ref, onMounted } from 'vue'

export default {
  setup() {
    // CORRECT: Use template refs for DOM access
    const divRef = ref(null)

    onMounted(() => {
      // Safe way to access DOM element
      console.log(divRef.value.tagName)
    })

    return () => h('div', { ref: divRef }, 'Content')
  }
}
```

## Documented VNode Properties

| Property | Type | Description |
|----------|------|-------------|
| `type` | `string \| Component` | Element tag name or component definition |
| `props` | `object \| null` | Props passed to the vnode |
| `children` | `any` | Child vnodes, text, or slots |
| `key` | `string \| number \| null` | Key for list rendering |

## Safe VNode Inspection Patterns

```javascript
import { h, isVNode } from 'vue'

export default {
  setup(props, { slots }) {
    return () => {
      const children = slots.default?.() || []

      // Safe: Check if something is a vnode
      children.forEach(child => {
        if (isVNode(child)) {
          // Safe: Check vnode type
          if (typeof child.type === 'string') {
            console.log('Element:', child.type)
          } else if (typeof child.type === 'object') {
            console.log('Component:', child.type.name)
          }

          // Safe: Read props
          if (child.props?.class) {
            console.log('Has class:', child.props.class)
          }
        }
      })

      return h('div', children)
    }
  }
}
```

## Why This Matters

Vue's internal vnode structure may change for:
- Performance optimizations
- New feature implementations
- Bug fixes
- Tree-shaking improvements

Code relying on internal properties will break silently or throw errors when upgrading Vue versions. The documented properties are part of Vue's public API and are guaranteed to remain stable.

## Reference
- [Vue.js Render Function APIs](https://vuejs.org/api/render-function.html)
- [Vue.js Render Functions - The Virtual DOM](https://vuejs.org/guide/extras/render-function.html#the-virtual-dom)
