---
title: Use Factory Functions for Non-Primitive Inject Default Values
impact: MEDIUM
impactDescription: Using object literals as default values creates shared references across all consuming components
type: gotcha
tags: [vue3, provide-inject, composition-api, memory, shared-state]
---

# Use Factory Functions for Non-Primitive Inject Default Values

**Impact: MEDIUM** - When providing default values for `inject()`, using an object literal creates a single shared reference. All components using that default will share the same object, leading to unexpected state sharing and bugs.

## Task Checklist

- [ ] Always use factory functions for object/array default values in inject
- [ ] Pass `true` as the third argument to enable factory mode in Composition API
- [ ] Use the object syntax with factory function in Options API
- [ ] Only use literal defaults for primitive values (strings, numbers, booleans)

## The Gotcha: Shared Default References

**Wrong - Object literal creates shared reference:**
```vue
<script setup>
import { inject } from 'vue'

// WRONG: All components without a provider share this SAME object
const config = inject('config', { debug: false, apiUrl: '' })

// If one component does this:
config.debug = true

// ALL other components using this default now have debug: true!
</script>
```

**Correct - Factory function creates unique instance:**
```vue
<script setup>
import { inject } from 'vue'

// CORRECT: Each component gets its own object
// Third argument `true` indicates the second arg is a factory function
const config = inject('config', () => ({ debug: false, apiUrl: '' }), true)
</script>
```

## API Explanation

The `inject()` function has multiple signatures:

```ts
// Simple default value (OK for primitives)
inject(key, defaultValue)

// Factory function for non-primitives (REQUIRED for objects/arrays)
inject(key, factoryFunction, true)
```

The third argument `true` tells Vue that the second argument is a factory function, not the default value itself.

## Examples

### Primitive Defaults (No Factory Needed)

```vue
<script setup>
import { inject } from 'vue'

// Primitives are safe without factory
const count = inject('count', 0)
const name = inject('name', 'Guest')
const enabled = inject('enabled', false)
</script>
```

### Object Defaults (Factory Required)

```vue
<script setup>
import { inject } from 'vue'

// Objects MUST use factory
const user = inject('user', () => ({
  id: null,
  name: 'Anonymous',
  preferences: {}
}), true)

const settings = inject('settings', () => ({
  theme: 'light',
  language: 'en',
  notifications: true
}), true)
</script>
```

### Array Defaults (Factory Required)

```vue
<script setup>
import { inject } from 'vue'

// Arrays MUST use factory
const items = inject('items', () => [], true)
const permissions = inject('permissions', () => ['read'], true)
</script>
```

### Class Instance Defaults (Factory Required)

```vue
<script setup>
import { inject } from 'vue'
import { Logger } from '@/utils/logger'

// Class instances MUST use factory
const logger = inject('logger', () => new Logger({ level: 'warn' }), true)
</script>
```

## Options API Syntax

In Options API, use the object syntax with a `default` factory function:

```js
export default {
  inject: {
    // Primitive - can use literal
    theme: {
      from: 'theme',
      default: 'light'
    },

    // Object - MUST use factory
    config: {
      from: 'config',
      default: () => ({ debug: false })
    },

    // Array - MUST use factory
    permissions: {
      from: 'permissions',
      default: () => []
    }
  }
}
```

## Real-World Example: Form Context

```vue
<!-- FormProvider.vue -->
<script setup>
import { provide, reactive } from 'vue'

const formContext = reactive({
  values: {},
  errors: {},
  touched: {},
  isSubmitting: false
})

provide('formContext', formContext)
</script>

<!-- FormField.vue (might be used outside FormProvider) -->
<script setup>
import { inject } from 'vue'

// Safe default that won't be shared
const formContext = inject('formContext', () => ({
  values: {},
  errors: {},
  touched: {},
  isSubmitting: false,
  // Mark as standalone mode
  isStandalone: true
}), true)

// Component works both inside and outside FormProvider
</script>
```

## TypeScript: Typing Factory Defaults

```ts
import { inject } from 'vue'
import type { InjectionKey } from 'vue'

interface Config {
  apiUrl: string
  debug: boolean
  features: string[]
}

const ConfigKey: InjectionKey<Config> = Symbol('config')

// TypeScript understands the factory return type
const config = inject(ConfigKey, () => ({
  apiUrl: 'https://api.example.com',
  debug: false,
  features: []
}), true)
```

## Common Mistake in Testing

This gotcha often appears in tests where components are rendered without providers:

```ts
// test.spec.ts
import { mount } from '@vue/test-utils'
import MyComponent from './MyComponent.vue'

// Without provider, all test instances share the wrong default
it('test 1', () => {
  const wrapper = mount(MyComponent)
  wrapper.vm.config.debug = true // Pollutes other tests!
})

it('test 2', () => {
  const wrapper = mount(MyComponent)
  // Might fail because debug is still true from test 1
})
```

**Fix: Use factory functions in the component, or provide in tests:**

```ts
it('test with provider', () => {
  const wrapper = mount(MyComponent, {
    global: {
      provide: {
        config: { debug: false, apiUrl: '' }
      }
    }
  })
})
```

## Reference
- [Vue.js inject() API Reference](https://vuejs.org/api/composition-api-dependency-injection.html#inject)
- [Vue.js Provide/Inject Guide](https://vuejs.org/guide/components/provide-inject.html)
