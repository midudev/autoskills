---
title: Use import.meta.glob for Dynamic Component Registration in Vite
impact: MEDIUM
impactDescription: require.context from Webpack doesn't work in Vite projects
type: gotcha
tags: [vue3, component-registration, vite, dynamic-import, migration, webpack]
---

# Use import.meta.glob for Dynamic Component Registration in Vite

**Impact: MEDIUM** - When migrating from Webpack to Vite or starting a new Vite project, the `require.context` pattern for dynamically registering components won't work. Vite uses `import.meta.glob` instead. Using the wrong approach will cause build errors or runtime failures.

## Task Checklist

- [ ] Replace `require.context` with `import.meta.glob` in Vite projects
- [ ] Update component registration patterns when migrating from Vue CLI to Vite
- [ ] Use `{ eager: true }` for synchronous loading when needed
- [ ] Handle async components appropriately with `defineAsyncComponent`

**Incorrect (Webpack pattern - doesn't work in Vite):**
```javascript
// main.js - WRONG for Vite
import { createApp } from 'vue'
import App from './App.vue'

const app = createApp(App)

// This Webpack-specific API doesn't exist in Vite
const requireComponent = require.context(
  './components/base',
  false,
  /Base[A-Z]\w+\.vue$/
)

requireComponent.keys().forEach(fileName => {
  const componentConfig = requireComponent(fileName)
  const componentName = fileName
    .split('/')
    .pop()
    .replace(/\.\w+$/, '')

  app.component(componentName, componentConfig.default || componentConfig)
})

app.mount('#app')
```

**Correct (Vite pattern):**
```javascript
// main.js - Correct for Vite
import { createApp } from 'vue'
import App from './App.vue'

const app = createApp(App)

// Vite's glob import - eager loading for synchronous registration
const modules = import.meta.glob('./components/base/Base*.vue', { eager: true })

for (const path in modules) {
  // Extract component name from path: './components/base/BaseButton.vue' -> 'BaseButton'
  const componentName = path.split('/').pop().replace('.vue', '')
  app.component(componentName, modules[path].default)
}

app.mount('#app')
```

## Lazy Loading with Async Components

```javascript
// main.js - Lazy loading variant
import { createApp, defineAsyncComponent } from 'vue'
import App from './App.vue'

const app = createApp(App)

// Without { eager: true }, returns functions that return Promises
const modules = import.meta.glob('./components/base/Base*.vue')

for (const path in modules) {
  const componentName = path.split('/').pop().replace('.vue', '')
  // Wrap in defineAsyncComponent for lazy loading
  app.component(componentName, defineAsyncComponent(modules[path]))
}

app.mount('#app')
```

## Glob Pattern Examples

```javascript
// All .vue files in a directory (not recursive)
import.meta.glob('./components/*.vue', { eager: true })

// All .vue files recursively
import.meta.glob('./components/**/*.vue', { eager: true })

// Specific naming pattern
import.meta.glob('./components/Base*.vue', { eager: true })

// Multiple patterns
import.meta.glob([
  './components/Base*.vue',
  './components/App*.vue'
], { eager: true })

// Exclude patterns
import.meta.glob('./components/**/*.vue', {
  eager: true,
  ignore: ['**/*.test.vue', '**/*.spec.vue']
})
```

## TypeScript Support

```typescript
// main.ts - with proper typing
import { createApp, Component } from 'vue'
import App from './App.vue'

const app = createApp(App)

const modules = import.meta.glob<{ default: Component }>(
  './components/base/Base*.vue',
  { eager: true }
)

for (const path in modules) {
  const componentName = path.split('/').pop()!.replace('.vue', '')
  app.component(componentName, modules[path].default)
}

app.mount('#app')
```

## Migration Checklist (Webpack to Vite)

| Webpack | Vite |
|---------|------|
| `require.context(dir, recursive, regex)` | `import.meta.glob(pattern, options)` |
| Synchronous by default | Use `{ eager: true }` for sync |
| `.keys()` returns array | Returns object with paths as keys |
| Returns module directly | Access via `.default` for ES modules |

## Reference
- [Vite - Glob Import](https://vitejs.dev/guide/features.html#glob-import)
- [Vue.js Component Registration](https://vuejs.org/guide/components/registration.html)
