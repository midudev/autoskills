# Install Plugins Before Mounting the App

## Rule

All plugins must be installed using `app.use()` BEFORE calling `app.mount()`. Installing plugins after the app is mounted can lead to reactivity issues, missing dependencies, and unexpected behavior.

## Why This Matters

1. **Hidden dependencies**: Components may render before plugins they depend on are available, causing runtime errors.

2. **Reactivity issues**: Late plugin installation can cause subtle reactivity problems where provided values aren't properly reactive.

3. **Initialization order**: Many plugins (like vue-router, pinia) need to set up state before any component renders.

4. **Ecosystem complexity**: Adding plugins after mount can cause issues with Vue's internal ecosystem and hydration in SSR scenarios.

## Bad Practice

```typescript
import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import i18nPlugin from './plugins/i18n'

const app = createApp(App)

// Mounting first - plugins not yet available!
app.mount('#app')

// Installing after mount - TOO LATE!
app.use(router)
app.use(i18nPlugin, { locale: 'en' })
```

## Good Practice

```typescript
import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import { createPinia } from 'pinia'
import i18nPlugin from './plugins/i18n'

const app = createApp(App)

// Install all plugins BEFORE mounting
app.use(createPinia())
app.use(router)
app.use(i18nPlugin, { locale: 'en' })

// Mount LAST
app.mount('#app')
```

## Plugin Installation Order

The order of `app.use()` calls can matter when plugins depend on each other:

```typescript
const app = createApp(App)

// 1. State management first (other plugins might need it)
app.use(createPinia())

// 2. Router (may depend on state)
app.use(router)

// 3. Other plugins (may depend on router or state)
app.use(authPlugin)
app.use(i18nPlugin, { locale: 'en' })

// 4. Mount last
app.mount('#app')
```

## Async Plugin Installation

If you need to perform async operations before mounting:

```typescript
import { createApp } from 'vue'
import App from './App.vue'
import { loadPlugins } from './plugins'

async function bootstrap() {
  const app = createApp(App)

  // Await async plugin setup
  const i18nPlugin = await loadI18nMessages()

  // Install all plugins
  app.use(i18nPlugin)

  // Mount after everything is ready
  app.mount('#app')
}

bootstrap()
```

## Duplicate Installation Protection

Vue's `app.use()` automatically prevents duplicate plugin installation:

```typescript
app.use(myPlugin)
app.use(myPlugin) // This second call is ignored - no double installation

// This is handled internally by Vue, providing a safety net
```

## Common Symptoms of Late Plugin Installation

- `inject()` returns `undefined` unexpectedly
- Router navigation guards not firing
- Store state not reactive
- Template errors about undefined global properties
- Hydration mismatches in SSR

## References

- [Vue.js Plugins Documentation](https://vuejs.org/guide/reusability/plugins.html)
- [Vue.js Application API](https://vuejs.org/api/application.html)
- [Vue 3 Migration Guide - Global API](https://v3-migration.vuejs.org/breaking-changes/global-api.html)
