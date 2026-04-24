---
title: Use shallowRef for Dynamic Component References
impact: MEDIUM
impactDescription: Storing components in reactive() or ref() triggers Vue warnings and can cause performance issues
type: gotcha
tags: [typescript, shallowRef, dynamic-components, reactivity, performance]
---

# Use shallowRef for Dynamic Component References

**Impact: MEDIUM** - When storing Vue components in reactive state for dynamic rendering, using `ref()` or `reactive()` causes Vue warnings and unnecessary reactivity overhead. Use `shallowRef()` instead.

## Task Checklist

- [ ] Use `shallowRef` for storing component references
- [ ] Use `markRaw` when storing components in reactive objects
- [ ] Avoid wrapping component definitions with deep reactivity
- [ ] Check console for "[Vue warn]: Vue received a Component that was made a reactive object"

## The Problem

Vue components are objects with internal properties that should not be made reactive. When you store a component in `ref()` or `reactive()`, Vue traverses all properties deeply, which:

1. Triggers a console warning
2. Creates unnecessary reactive proxies
3. Can cause subtle bugs with component identity
4. Impacts performance

**Incorrect - Using ref() for components:**
```typescript
import { ref } from 'vue'
import ComponentA from './ComponentA.vue'
import ComponentB from './ComponentB.vue'

// BAD: Vue will warn about making component reactive
const currentComponent = ref(ComponentA)

function switchComponent() {
  currentComponent.value = ComponentB
}
```

**Console warning:**
```
[Vue warn]: Vue received a Component that was made a reactive object.
This can lead to unnecessary performance overhead and should be avoided
by marking the component with `markRaw` or using `shallowRef` instead of `ref`.
```

## Solution 1: Use shallowRef

`shallowRef` only makes the `.value` reference reactive, not the contents:

```typescript
import { shallowRef, type Component } from 'vue'
import ComponentA from './ComponentA.vue'
import ComponentB from './ComponentB.vue'

// CORRECT: shallowRef doesn't deep-proxy the component
const currentComponent = shallowRef<Component>(ComponentA)

function switchComponent() {
  currentComponent.value = ComponentB
}
```

```vue
<template>
  <component :is="currentComponent" />
</template>
```

## Solution 2: Use markRaw in Reactive Objects

When components are part of a larger reactive object:

```typescript
import { reactive, markRaw, type Component } from 'vue'
import TabHome from './TabHome.vue'
import TabProfile from './TabProfile.vue'
import TabSettings from './TabSettings.vue'

interface Tab {
  name: string
  component: Component
}

// CORRECT: markRaw prevents reactivity on component objects
const tabs = reactive<Tab[]>([
  { name: 'Home', component: markRaw(TabHome) },
  { name: 'Profile', component: markRaw(TabProfile) },
  { name: 'Settings', component: markRaw(TabSettings) }
])

const activeTab = shallowRef<Tab>(tabs[0])
```

```vue
<template>
  <div class="tabs">
    <button
      v-for="tab in tabs"
      :key="tab.name"
      @click="activeTab = tab"
    >
      {{ tab.name }}
    </button>
  </div>
  <component :is="activeTab.component" />
</template>
```

## TypeScript Typing

For proper TypeScript support with dynamic components:

```typescript
import { shallowRef, type Component, type DefineComponent } from 'vue'

// Generic component type
const currentComponent = shallowRef<Component | null>(null)

// Or more specific with props
interface MyComponentProps {
  title: string
}

const currentComponent = shallowRef<DefineComponent<MyComponentProps> | null>(null)
```

## Dynamic Import with shallowRef

When using dynamic imports for code splitting:

```typescript
import { shallowRef, defineAsyncComponent, type Component } from 'vue'

const currentComponent = shallowRef<Component | null>(null)

async function loadComponent(name: string) {
  const component = defineAsyncComponent(
    () => import(`./components/${name}.vue`)
  )
  currentComponent.value = component
}
```

## Component Registry Pattern

For tab systems or wizard-like interfaces:

```typescript
import { shallowRef, markRaw, type Component } from 'vue'

// Type-safe component registry
const componentRegistry = {
  home: markRaw(defineAsyncComponent(() => import('./Home.vue'))),
  about: markRaw(defineAsyncComponent(() => import('./About.vue'))),
  contact: markRaw(defineAsyncComponent(() => import('./Contact.vue')))
} as const

type ComponentKey = keyof typeof componentRegistry

const currentView = shallowRef<ComponentKey>('home')

// Computed to get current component
const currentComponent = computed(() => componentRegistry[currentView.value])
```

```vue
<template>
  <component :is="currentComponent" />
</template>
```

## When to Use Each Approach

| Scenario | Solution |
|----------|----------|
| Single dynamic component reference | `shallowRef` |
| Component in reactive array/object | `markRaw` on component |
| Component map/registry | `markRaw` each component |
| Async components | `defineAsyncComponent` + `shallowRef` |

## Common Mistakes

### Mistake 1: Using computed with ref

```typescript
// BAD: Still triggers warning
const components = ref([ComponentA, ComponentB])
const current = computed(() => components.value[index.value])

// GOOD: Use shallowRef for the array
const components = shallowRef([ComponentA, ComponentB])
```

### Mistake 2: Forgetting markRaw in map

```typescript
// BAD: Components in map become reactive
const routes = reactive(new Map([
  ['home', HomeComponent],
  ['about', AboutComponent]
]))

// GOOD: Mark each component as raw
const routes = reactive(new Map([
  ['home', markRaw(HomeComponent)],
  ['about', markRaw(AboutComponent)]
]))
```

## Reference

- [Vue.js Reactivity in Depth - Reducing Reactivity Overhead](https://vuejs.org/guide/extras/reactivity-in-depth.html#reducing-reactivity-overhead-for-large-immutable-structures)
- [Vue.js API - shallowRef](https://vuejs.org/api/reactivity-advanced.html#shallowref)
- [Vue.js API - markRaw](https://vuejs.org/api/reactivity-advanced.html#markraw)
