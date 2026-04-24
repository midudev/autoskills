---
title: Pass Slots as Functions in Render Functions, Not Direct Children
impact: HIGH
impactDescription: Passing slot content incorrectly causes slots to not render or be treated as props
type: gotcha
tags: [vue3, render-function, slots, children, vnode]
---

# Pass Slots as Functions in Render Functions, Not Direct Children

**Impact: HIGH** - When creating component vnodes with `h()`, children must be passed as slot functions, not as direct children. Passing children directly may cause them to be interpreted as props or fail to render.

## Task Checklist

- [ ] Pass slot content as functions: `{ default: () => [...] }`
- [ ] Use `null` for props when only passing slots to avoid misinterpretation
- [ ] For default slot only, a single function can be passed directly
- [ ] For named slots, use an object with slot function properties

**Incorrect:**
```js
import { h } from 'vue'
import MyComponent from './MyComponent.vue'

// WRONG: Children array may be misinterpreted
h(MyComponent, [
  h('span', 'Slot content')  // May not render as expected
])

// WRONG: Named slots as direct properties
h(MyComponent, {
  header: h('h1', 'Title'),  // This is a prop, not a slot!
  default: h('p', 'Content')  // This is also a prop
})
```

**Correct:**
```js
import { h } from 'vue'
import MyComponent from './MyComponent.vue'

// CORRECT: Default slot as function
h(MyComponent, null, {
  default: () => h('span', 'Slot content')
})

// CORRECT: Single default slot shorthand
h(MyComponent, null, () => h('span', 'Slot content'))

// CORRECT: Named slots as functions
h(MyComponent, null, {
  header: () => h('h1', 'Title'),
  default: () => h('p', 'Content'),
  footer: () => [
    h('span', 'Footer item 1'),
    h('span', 'Footer item 2')
  ]
})

// CORRECT: With props AND slots
h(MyComponent, { size: 'large' }, {
  default: () => 'Button Text'
})
```

## Why Functions?

Slots in Vue 3 are functions for lazy evaluation:

```js
// Slots are called by the child component when needed
// This enables:
// 1. Scoped slots (passing data back)
// 2. Conditional rendering (slot not called if not used)
// 3. Proper reactivity tracking

h(MyList, { items }, {
  // Scoped slot - receives data from child
  item: ({ item, index }) => h('li', `${index}: ${item.name}`)
})
```

## The null Props Gotcha

When passing only slots, always use `null` for props:

```js
// WRONG: Slots object interpreted as props!
h(MyComponent, {
  default: () => 'Hello'
})
// MyComponent receives: props.default = () => 'Hello'

// CORRECT: null signals "no props, next arg is slots"
h(MyComponent, null, {
  default: () => 'Hello'
})
// MyComponent receives slot correctly
```

## Forwarding Slots from Parent

```js
export default {
  setup(props, { slots }) {
    return () => h(ChildComponent, null, {
      // Forward all slots from parent
      ...slots,

      // Or forward specific slots
      default: slots.default,
      header: slots.header
    })
  }
}
```

## Scoped Slots in Render Functions

```js
// Parent: Receives data from child via slot props
h(DataTable, { data: items }, {
  row: (slotProps) => h('tr', [
    h('td', slotProps.item.name),
    h('td', slotProps.item.value)
  ])
})

// Child (DataTable): Calls slot with data
export default {
  props: ['data'],
  setup(props, { slots }) {
    return () => h('table', [
      h('tbody',
        props.data.map(item =>
          // Pass data to slot function
          slots.row?.({ item })
        )
      )
    ])
  }
}
```

## Common Patterns

```js
// Wrapper component forwarding slots
h('div', { class: 'wrapper' }, [
  h(InnerComponent, null, slots)
])

// Conditional slot rendering
h('div', [
  slots.header?.(),  // Optional chaining - only render if slot provided
  h('main', slots.default?.()),
  slots.footer?.()
])

// Slot with fallback content
h('div', [
  slots.default?.() ?? h('p', 'Default content when slot not provided')
])
```

## Reference
- [Vue.js Render Functions - Passing Slots](https://vuejs.org/guide/extras/render-function.html#passing-slots)
- [Vue.js Render Functions - Children](https://vuejs.org/guide/extras/render-function.html#children)
