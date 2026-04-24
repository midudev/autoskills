---
title: Configure Vue App Before Calling mount()
impact: HIGH
impactDescription: App configurations after mount() are silently ignored, causing missing plugins and handlers
type: capability
tags: [vue3, createApp, mount, configuration, setup]
---

# Configure Vue App Before Calling mount()

**Impact: HIGH** - Any app configurations applied after `.mount()` is called are silently ignored. This includes error handlers, global components, directives, and plugins, leading to mysterious missing functionality.

The `.mount()` method should always be called after all app configurations and asset registrations are done. This is a critical ordering requirement that, when violated, produces no errors but causes features to silently fail.

## Task Checklist

- [ ] Register all plugins (router, store, etc.) before mount()
- [ ] Configure error handlers before mount()
- [ ] Register global components and directives before mount()
- [ ] Set all `app.config` properties before mount()
- [ ] Call `.mount()` as the final step in app initialization

**Incorrect:**
```javascript
import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

const app = createApp(App)

// WRONG: Mounting first, then configuring
app.mount('#app')

// These are silently IGNORED - app is already mounted!
app.use(router)
app.config.errorHandler = (err) => {
  console.error('Global error:', err)
}
app.component('GlobalButton', GlobalButton)
```

**Correct:**
```javascript
import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import { createPinia } from 'pinia'
import GlobalButton from './components/GlobalButton.vue'

const app = createApp(App)

// Configure everything FIRST
app.use(router)
app.use(createPinia())

// Set up error handling
app.config.errorHandler = (err, instance, info) => {
  console.error('Global error:', err)
  console.log('Component:', instance)
  console.log('Error info:', info)
}

// Register global components
app.component('GlobalButton', GlobalButton)

// Mount LAST - after all configuration is complete
app.mount('#app')
```

## Common Mistake: Chaining with Mount

```javascript
// WRONG: Chaining mount in the middle of configuration
createApp(App)
  .use(router)
  .mount('#app')  // Everything after this line is a problem
  .use(pinia)     // This doesn't even work - mount returns component instance!

// CORRECT: Either complete chain before mount, or use intermediate variable
createApp(App)
  .use(router)
  .use(pinia)
  .component('GlobalButton', GlobalButton)
  .mount('#app')  // Mount at the very end
```

## Reference
- [Vue.js - Creating a Vue Application](https://vuejs.org/guide/essentials/application.html)
- [Vue.js Application API](https://vuejs.org/api/application.html)
