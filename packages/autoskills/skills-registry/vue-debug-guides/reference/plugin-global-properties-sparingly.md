# Use Global Properties Sparingly in Plugins

## Rule

When using `app.config.globalProperties` in Vue plugins, use them sparingly and with clear naming conventions. Excessive global properties lead to confusion, naming conflicts, and debugging difficulties.

## Why This Matters

1. **Implicit dependencies**: Global properties make component dependencies invisible, making code harder to understand and maintain.

2. **Naming collisions**: Multiple plugins may try to use the same property name (e.g., `$http`, `$api`), causing silent overwrites.

3. **Debugging difficulty**: When issues arise, tracing back to which plugin provides a global property is challenging.

4. **IDE limitations**: Global properties may not have proper autocomplete or type checking without careful configuration.

5. **Testing complexity**: Global state is harder to mock and isolate in unit tests.

## Bad Practice

```typescript
// Too many global properties from various plugins
app.config.globalProperties.$http = axios
app.config.globalProperties.$api = apiClient
app.config.globalProperties.$auth = authService
app.config.globalProperties.$translate = i18n.translate
app.config.globalProperties.$format = formatters
app.config.globalProperties.$utils = utilities
app.config.globalProperties.$config = appConfig
app.config.globalProperties.$logger = logger

// In component - where did all these come from?
export default {
  mounted() {
    this.$logger.info('Mounted')
    const data = await this.$http.get(this.$config.apiUrl)
    this.$api.process(this.$utils.transform(data))
  }
}
```

## Good Practice

```typescript
// Use provide/inject for most functionality
export default {
  install(app, options) {
    // Provide services via injection
    app.provide('api', apiClient)
    app.provide('auth', authService)
    app.provide('i18n', i18n)

    // Reserve globalProperties for truly global template helpers
    // that are used extensively in templates across the app
    app.config.globalProperties.$t = i18n.translate  // Common convention
  }
}

// In component - explicit dependencies
<script setup>
import { inject } from 'vue'

const api = inject('api')
const auth = inject('auth')
</script>

<template>
  <!-- $t is acceptable for common template-only usage -->
  <h1>{{ $t('welcome') }}</h1>
</template>
```

## Naming Conventions

If you do use globalProperties:

1. **Use `$` prefix**: This is the Vue convention and avoids conflicts with component data/methods
2. **Use unique prefixes for your library**: e.g., `$myLib_translate` for third-party plugins
3. **Document all global properties**: Keep a central registry of what each plugin provides

```typescript
// Good: namespaced to avoid conflicts
app.config.globalProperties.$myPlugin = {
  translate: (key) => /* ... */,
  format: (value) => /* ... */
}

// Usage
{{ $myPlugin.translate('key') }}
```

## Auditing Global Properties

You can inspect all global properties for debugging:

```typescript
console.log(app.config.globalProperties)
```

## When Global Properties Are Acceptable

1. **Template-only utilities** used very frequently (like `$t` for translations)
2. **Legacy migration** when transitioning from Vue 2
3. **Libraries that need Options API compatibility** (but prefer also providing inject)

## References

- [Vue.js Plugins Documentation](https://vuejs.org/guide/reusability/plugins.html)
- [Vue.js Global Properties](https://vuejs.org/api/application.html#app-config-globalproperties)
