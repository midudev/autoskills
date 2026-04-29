---
title: Use resolveComponent for String Component Names in Render Functions
impact: HIGH
impactDescription: String component names don't work in Vue 3 render functions; causes silent failures or runtime errors
type: gotcha
tags: [vue3, render-function, components, resolveComponent, migration]
---

# Use resolveComponent for String Component Names in Render Functions

**Impact: HIGH** - In Vue 2, render functions could use string names for globally or locally registered components. In Vue 3, you must either import components directly or use `resolveComponent()`. Using string names causes components to render as HTML elements or fail silently.

## Task Checklist

- [ ] Import components directly when possible (preferred)
- [ ] Use `resolveComponent()` for dynamically registered components
- [ ] Use `resolveDynamicComponent()` for `<component :is="">` equivalent
- [ ] Call `resolveComponent()` inside `setup()` or the render function
- [ ] Handle the case when component is not found

**Incorrect:**
```js
import { h } from 'vue'

export default {
  render() {
    // WRONG: String names don't resolve to components
    return h('div', [
      h('my-component', { value: 1 }),  // Renders <my-component> HTML element!
      h('router-link', { to: '/' }, 'Home')  // Also fails
    ])
  }
}
```

**Correct (Direct Import - Preferred):**
```js
import { h } from 'vue'
import MyComponent from './MyComponent.vue'
import { RouterLink } from 'vue-router'

export default {
  render() {
    return h('div', [
      h(MyComponent, { value: 1 }),
      h(RouterLink, { to: '/' }, () => 'Home')
    ])
  }
}
```

**Correct (resolveComponent for Registered Components):**
```js
import { h, resolveComponent } from 'vue'

export default {
  components: {
    MyComponent: () => import('./MyComponent.vue')
  },

  setup() {
    // Resolve inside setup - component context is available
    const MyComponent = resolveComponent('MyComponent')

    return () => h('div', [
      h(MyComponent, { value: 1 })
    ])
  }
}

// Or resolve inside render function
export default {
  render() {
    const MyComponent = resolveComponent('MyComponent')
    const RouterLink = resolveComponent('RouterLink')

    return h('div', [
      h(MyComponent, { value: 1 }),
      h(RouterLink, { to: '/' }, () => 'Home')
    ])
  }
}
```

## When to Use Each Approach

| Approach | Use When |
|----------|----------|
| Direct Import | Component is known at build time (most common) |
| `resolveComponent()` | Component is registered globally or locally by name |
| `resolveComponent()` | Dynamic component selection from registered set |

## Handling Missing Components

```js
import { h, resolveComponent } from 'vue'

export default {
  setup() {
    // resolveComponent returns the component or the string name if not found
    const DynamicComponent = resolveComponent('MaybeRegistered')

    // Check if resolution succeeded
    if (typeof DynamicComponent === 'string') {
      console.warn(`Component "${DynamicComponent}" not found`)
    }

    return () => h(DynamicComponent, { value: 1 })
  }
}
```

## Dynamic Component Selection

```js
import { h, resolveComponent, computed } from 'vue'

export default {
  props: ['componentName'],

  setup(props) {
    // For truly dynamic components, resolve in render function
    return () => {
      const Component = resolveComponent(props.componentName)
      return h(Component, { /* props */ })
    }
  }
}
```

For the equivalent of `<component :is="componentName">`, use `resolveDynamicComponent`:

```js
import { h, resolveDynamicComponent } from 'vue'

export default {
  props: ['componentType'],
  setup(props) {
    return () => {
      // Resolves string names, component objects, or built-in elements
      const component = resolveDynamicComponent(props.componentType)
      return h(component, { /* props */ })
    }
  }
}
```

## Practical Example: Tab Component

```js
import { h, resolveComponent, ref } from 'vue'

export default {
  setup() {
    const currentTab = ref('TabA')
    const tabs = ['TabA', 'TabB', 'TabC']

    return () => h('div', [
      // Tab buttons
      h('div', { class: 'tabs' },
        tabs.map(tab =>
          h('button', {
            key: tab,
            class: { active: currentTab.value === tab },
            onClick: () => currentTab.value = tab
          }, tab)
        )
      ),

      // Dynamic component based on current tab
      h(resolveComponent(currentTab.value))
    ])
  }
}
```

## Resolving Built-in Components

For built-in components like `<Transition>` or `<KeepAlive>`, import them directly from Vue:

```js
import { h, Transition, KeepAlive, Teleport, Suspense } from 'vue'

export default {
  setup() {
    return () => h(Transition, { name: 'fade' }, () =>
      h('div', 'Content')
    )
  }
}
```

## Resolving Directives

Similar pattern for custom directives:

```js
import { h, resolveDirective, withDirectives } from 'vue'

export default {
  render() {
    const vFocus = resolveDirective('focus')

    return withDirectives(
      h('input', { type: 'text' }),
      [[vFocus]]
    )
  }
}
```

## Migration from Vue 2

```js
// Vue 2 (worked with registered components)
render(h) {
  return h('my-component', { props: { value: 1 } })
}

// Vue 3 (must resolve or import)
import { h, resolveComponent } from 'vue'

render() {
  const MyComponent = resolveComponent('my-component')
  return h(MyComponent, { value: 1 })  // Note: props go directly, not in 'props' key
}
```

## Reference
- [Vue 3 Migration - Render Function API](https://v3-migration.vuejs.org/breaking-changes/render-function-api.html)
- [Vue.js Render Function API - resolveComponent](https://vuejs.org/api/render-function.html#resolvecomponent)
