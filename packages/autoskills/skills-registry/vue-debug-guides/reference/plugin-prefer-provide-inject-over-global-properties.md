# Prefer provide/inject Over Global Properties in Plugins

## Rule

When creating Vue plugins, prefer using `app.provide()` to make plugin functionality available to components instead of attaching properties to `app.config.globalProperties`.

## Why This Matters

1. **globalProperties don't work in setup()**: Properties attached to `globalProperties` are only accessible via `this` in Options API. They are NOT available in the Composition API's `setup()` function.

2. **Type safety**: `provide/inject` integrates better with TypeScript and requires less type augmentation boilerplate.

3. **Testability**: Injected dependencies are easier to mock in tests compared to global properties.

4. **Code clarity**: Explicit `inject()` calls make dependencies visible, while global properties can appear "magic".

5. **Scoping**: `provide/inject` follows Vue's component hierarchy, making it easier to provide different values to different parts of your app.

## Bad Practice

```typescript
// plugins/i18n.ts
export default {
  install(app, options) {
    // Attaching to globalProperties - only works with Options API
    app.config.globalProperties.$translate = (key: string) => {
      return key.split('.').reduce((o, i) => o?.[i], options)
    }
  }
}

// In component - requires type augmentation for TypeScript
// Also DOES NOT work in <script setup>
export default {
  mounted() {
    console.log(this.$translate('greeting.hello'))
  }
}
```

## Good Practice

```typescript
// plugins/i18n.ts
import type { InjectionKey, App } from 'vue'

export interface I18nOptions {
  [key: string]: string | I18nOptions
}

export interface I18n {
  translate: (key: string) => string
  options: I18nOptions
}

export const i18nKey: InjectionKey<I18n> = Symbol('i18n')

export default {
  install(app: App, options: I18nOptions) {
    const translate = (key: string): string => {
      return key.split('.').reduce((o, i) => o?.[i], options) as string ?? key
    }

    // Use provide for Composition API compatibility
    app.provide(i18nKey, { translate, options })
  }
}

// In component - works in setup() and has full type safety
<script setup lang="ts">
import { inject } from 'vue'
import { i18nKey } from '@/plugins/i18n'

const i18n = inject(i18nKey)
console.log(i18n?.translate('greeting.hello'))
</script>
```

## Hybrid Approach

If you must support both APIs (e.g., for backwards compatibility), provide both:

```typescript
export default {
  install(app: App, options: I18nOptions) {
    const i18n = {
      translate: (key: string) => /* ... */
    }

    // For Composition API
    app.provide(i18nKey, i18n)

    // For Options API (use sparingly)
    app.config.globalProperties.$i18n = i18n
  }
}
```

## TypeScript Type Augmentation (if using globalProperties)

If you must use globalProperties, you need proper type augmentation:

```typescript
// types/vue.d.ts
export {}

declare module 'vue' {
  interface ComponentCustomProperties {
    $translate: (key: string) => string
  }
}
```

**Important**: The file MUST contain `export {}` or another top-level export/import. Without it, the augmentation will OVERWRITE types instead of augmenting them.

## References

- [Vue.js Plugins Documentation](https://vuejs.org/guide/reusability/plugins.html)
- [Vue.js Provide/Inject](https://vuejs.org/guide/components/provide-inject.html)
- [TypeScript with Options API](https://vuejs.org/guide/typescript/options-api.html)
