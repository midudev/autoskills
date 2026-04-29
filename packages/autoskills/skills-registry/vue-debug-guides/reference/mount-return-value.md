---
title: mount() Returns Component Instance, Not App Instance
impact: MEDIUM
impactDescription: Using mount() return value for app configuration silently fails
type: capability
tags: [vue3, createApp, mount, api]
---

# mount() Returns Component Instance, Not App Instance

**Impact: MEDIUM** - The `.mount()` method returns the root component instance, not the application instance. Attempting to chain app configuration methods after mount() will fail or produce unexpected behavior.

This is a subtle API detail that catches developers who assume mount() returns the app for continued chaining.

## Task Checklist

- [ ] Never chain app configuration methods after mount()
- [ ] If you need both instances, store them separately
- [ ] Use the component instance for accessing root component state or methods
- [ ] Use the app instance for configuration, plugins, and global registration

**Incorrect:**
```javascript
import { createApp } from 'vue'
import App from './App.vue'

// WRONG: Assuming mount returns app instance
const app = createApp(App).mount('#app')

// This fails! app is actually the root component instance
app.use(router)  // TypeError: app.use is not a function
app.config.errorHandler = fn  // app.config is undefined
```

```javascript
// WRONG: Trying to save both in one line
const { app, component } = createApp(App).mount('#app')  // Doesn't work this way
```

**Correct:**
```javascript
import { createApp } from 'vue'
import App from './App.vue'

// Store app instance separately
const app = createApp(App)

// Configure the app
app.use(router)
app.config.errorHandler = (err) => console.error(err)

// Store component instance if needed
const rootComponent = app.mount('#app')

// Now you have access to both:
// - app: the application instance (for config, plugins)
// - rootComponent: the root component instance (for state, methods)
```

```javascript
// If you only need the app configured and mounted (most common case):
createApp(App)
  .use(router)
  .use(pinia)
  .mount('#app')  // Return value (component instance) discarded - that's fine
```

## When You Need the Root Component Instance

```javascript
const app = createApp(App)
const vm = app.mount('#app')

// Access root component's exposed state/methods
console.log(vm.someExposedProperty)
vm.someExposedMethod()

// In Vue 3 with <script setup>, use defineExpose to expose:
// <script setup>
// import { ref } from 'vue'
// const count = ref(0)
// defineExpose({ count })
// </script>
```

## Reference
- [Vue.js - Mounting the App](https://vuejs.org/guide/essentials/application.html#mounting-the-app)
- [Vue.js Application API - mount()](https://vuejs.org/api/application.html#app-mount)
