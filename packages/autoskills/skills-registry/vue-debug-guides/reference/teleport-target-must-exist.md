---
title: Teleport Target Must Exist Before Mount
impact: HIGH
impactDescription: Teleport will fail silently or throw errors if target element doesn't exist when component mounts
type: gotcha
tags: [vue3, teleport, modal, dom, lifecycle]
---

# Teleport Target Must Exist Before Mount

**Impact: HIGH** - The teleport `to` target must already exist in the DOM when the `<Teleport>` component is mounted. If the target doesn't exist, Vue will throw an error and the teleported content won't render.

This is a common source of bugs when using modals, tooltips, or other teleported UI elements, especially when targeting Vue-rendered elements.

## Task Checklist

- [ ] Ensure teleport target exists in the DOM before `<Teleport>` mounts
- [ ] Place teleport containers (e.g., `#modals`, `#tooltips`) in `index.html` outside the Vue app
- [ ] If targeting Vue-rendered elements, ensure they mount before the Teleport
- [ ] Use Vue 3.5+ `defer` prop when target is rendered later in the same component tree

**Incorrect:**
```vue
<template>
  <!-- ERROR: Target doesn't exist yet when Teleport mounts -->
  <Teleport to="#modal-container">
    <div class="modal">Modal content</div>
  </Teleport>

  <!-- Target is defined after the Teleport -->
  <div id="modal-container"></div>
</template>
```

**Correct - Option 1: External container in index.html:**
```html
<!-- index.html -->
<body>
  <div id="app"></div>
  <!-- Container exists before Vue app mounts -->
  <div id="modals"></div>
  <div id="tooltips"></div>
</body>
```

```vue
<template>
  <!-- Safe: #modals exists before any Vue component mounts -->
  <Teleport to="#modals">
    <div v-if="showModal" class="modal">Modal content</div>
  </Teleport>
</template>
```

**Correct - Option 2: Teleport to body:**
```vue
<template>
  <!-- Safe: body always exists -->
  <Teleport to="body">
    <div v-if="showModal" class="modal">Modal content</div>
  </Teleport>
</template>
```

**Correct - Option 3: Vue 3.5+ defer prop:**
```vue
<template>
  <!-- Works in Vue 3.5+: defer resolves target after other parts mount -->
  <Teleport defer to="#late-container">
    <div class="modal">Modal content</div>
  </Teleport>

  <!-- Target rendered later in template -->
  <div id="late-container"></div>
</template>
```

## Defer Prop Limitations (Vue 3.5+)

The `defer` prop only waits for elements rendered in the **same mount/update tick**:

```vue
<template>
  <!-- ERROR: defer won't help if target mounts asynchronously -->
  <Teleport defer to="#async-container">
    <div>Content</div>
  </Teleport>

  <!-- If this component loads asynchronously, defer won't work -->
  <Suspense>
    <AsyncComponent />  <!-- Contains #async-container -->
  </Suspense>
</template>
```

## Common Patterns

### Recommended: Centralized Teleport Containers
```html
<!-- index.html -->
<body>
  <div id="app"></div>

  <!-- Teleport destinations outside Vue app -->
  <div id="modals" aria-live="polite"></div>
  <div id="notifications" aria-live="assertive"></div>
  <div id="tooltips"></div>
</body>
```

## Reference
- [Vue.js Teleport - Using with Vue-rendered Targets](https://vuejs.org/guide/built-ins/teleport.html#using-with-vue-rendered-targets)
- [Vue.js Teleport - Deferred Teleport](https://vuejs.org/guide/built-ins/teleport.html#deferred-teleport)
