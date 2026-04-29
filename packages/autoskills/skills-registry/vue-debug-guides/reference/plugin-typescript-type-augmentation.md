# Proper TypeScript Type Augmentation for Plugins

## Rule

When creating Vue plugins that add global properties, you MUST properly augment TypeScript types. The augmentation file MUST contain at least one top-level `import` or `export` statement to be treated as a module.

## Why This Matters

1. **Without module syntax, types are overwritten**: If your augmentation file isn't a module, it will OVERWRITE Vue's types instead of augmenting them, breaking type checking for the entire application.

2. **Type safety**: Proper augmentation enables autocomplete and type checking for plugin-provided properties.

3. **IDE support**: Developers get proper IntelliSense for global properties like `this.$translate`.

4. **Error prevention**: Catch typos and incorrect usage at compile time rather than runtime.

## Critical Rule: Module Syntax Required

```typescript
// BAD - This OVERWRITES Vue types instead of augmenting!
// types/vue.d.ts
declare module 'vue' {
  interface ComponentCustomProperties {
    $translate: (key: string) => string
  }
}

// GOOD - The export {} makes this a module, so it AUGMENTS types
// types/vue.d.ts
export {}  // This line is CRITICAL!

declare module 'vue' {
  interface ComponentCustomProperties {
    $translate: (key: string) => string
  }
}
```

## Complete Plugin Type Augmentation Example

```typescript
// plugins/i18n.ts
import type { App, InjectionKey } from 'vue'

export interface I18nOptions {
  locale: string
  messages: Record<string, Record<string, string>>
}

export interface I18nInstance {
  translate: (key: string) => string
  locale: string
}

export const i18nInjectionKey: InjectionKey<I18nInstance> = Symbol('i18n')

export function createI18n(options: I18nOptions) {
  const i18n: I18nInstance = {
    translate(key: string) {
      return options.messages[options.locale]?.[key] ?? key
    },
    locale: options.locale
  }

  return {
    install(app: App) {
      // For Composition API
      app.provide(i18nInjectionKey, i18n)

      // For Options API / templates
      app.config.globalProperties.$t = i18n.translate
      app.config.globalProperties.$i18n = i18n
    }
  }
}

// types/i18n.d.ts (or in the same file after export)
export {}

declare module 'vue' {
  interface ComponentCustomProperties {
    $t: (key: string) => string
    $i18n: I18nInstance
  }
}
```

## Alternative: Augment @vue/runtime-core

Some plugins augment `@vue/runtime-core` instead of `vue`:

```typescript
// types/global.d.ts
export {}

declare module '@vue/runtime-core' {
  interface ComponentCustomProperties {
    $myPlugin: MyPluginInstance
  }
}
```

Both approaches work, but `'vue'` is more common in application code.

## Ensure tsconfig.json Includes the Declaration File

```json
{
  "compilerOptions": {
    // ...
  },
  "include": [
    "src/**/*.ts",
    "src/**/*.vue",
    "types/**/*.d.ts"  // Include your declaration files
  ]
}
```

## For Library Authors: package.json Types Field

If publishing a plugin as a package:

```json
{
  "name": "my-vue-plugin",
  "types": "./dist/types/index.d.ts",
  "exports": {
    ".": {
      "types": "./dist/types/index.d.ts",
      "import": "./dist/index.mjs"
    }
  }
}
```

## Common Errors and Solutions

### Error: Property '$xyz' does not exist on type

1. Check that your `.d.ts` file has `export {}` or an import statement
2. Verify the file is included in `tsconfig.json`
3. Restart your TypeScript language server (VS Code: Cmd+Shift+P > "Restart TS Server")

### Error: Types work in some components but not others

This often happens when using Vetur instead of Volar. If you're on Vue 3, switch to Volar (Vue - Official extension).

### Error in Options API but not Composition API

Global properties on `this` require proper augmentation of `ComponentCustomProperties`. The Composition API uses `inject()` which is typed separately.

## References

- [Vue.js TypeScript with Options API](https://vuejs.org/guide/typescript/options-api.html)
- [TypeScript Module Augmentation](https://www.typescriptlang.org/docs/handbook/declaration-merging.html#module-augmentation)
- [Vue.js Plugins Documentation](https://vuejs.org/guide/reusability/plugins.html)
