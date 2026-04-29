---
title: Wrap Mutable Default Values in Factory Functions
impact: HIGH
impactDescription: Without factory functions, all component instances share the same mutable reference causing cross-contamination bugs
type: gotcha
tags: [vue3, typescript, props, withDefaults, mutable-types]
---

# Wrap Mutable Default Values in Factory Functions

**Impact: HIGH** - When using `withDefaults()` with type-based props declaration, default values for mutable types (arrays and objects) MUST be wrapped in factory functions. Without this, all component instances share the same reference, causing bugs where modifying the prop in one instance affects all others.

## Task Checklist

- [ ] Always wrap array defaults in factory functions: `() => []`
- [ ] Always wrap object defaults in factory functions: `() => ({})`
- [ ] Primitive types (string, number, boolean) do NOT need factory functions
- [ ] Review existing components for this pattern

## The Problem: Shared Mutable References

**WRONG - Shared reference across instances:**
```vue
<script setup lang="ts">
interface Props {
  items?: string[]
  config?: { theme: string }
}

const props = withDefaults(defineProps<Props>(), {
  items: ['default'],           // WRONG! All instances share this array
  config: { theme: 'light' }    // WRONG! All instances share this object
})
</script>
```

When you have multiple instances of this component:
```vue
<template>
  <!-- Both share the SAME items array! -->
  <MyComponent ref="comp1" />
  <MyComponent ref="comp2" />
</template>

<script setup>
// If comp1 modifies its items, comp2's items change too!
comp1.value.items.push('new item')  // comp2 also has 'new item' now
</script>
```

## The Solution: Factory Functions

**CORRECT - Unique instance per component:**
```vue
<script setup lang="ts">
interface Props {
  items?: string[]
  config?: { theme: string }
  nested?: { data: { values: number[] } }
}

const props = withDefaults(defineProps<Props>(), {
  items: () => ['default'],                      // Factory function!
  config: () => ({ theme: 'light' }),            // Factory function!
  nested: () => ({ data: { values: [] } })       // Factory function!
})
</script>
```

## When Factory Functions Are Required

| Type | Factory Required | Example Default |
|------|-----------------|-----------------|
| `string` | No | `'hello'` |
| `number` | No | `42` |
| `boolean` | No | `false` |
| `string[]` | **Yes** | `() => []` |
| `number[]` | **Yes** | `() => [1, 2, 3]` |
| `object` | **Yes** | `() => ({})` |
| `Map` | **Yes** | `() => new Map()` |
| `Set` | **Yes** | `() => new Set()` |
| `Date` | **Yes** | `() => new Date()` |

## Complete Example

```vue
<script setup lang="ts">
interface User {
  id: string
  name: string
}

interface Props {
  // Primitives - no factory needed
  title?: string
  count?: number
  disabled?: boolean

  // Mutable types - factory required
  items?: string[]
  users?: User[]
  metadata?: Record<string, unknown>
  selectedIds?: Set<string>
}

const props = withDefaults(defineProps<Props>(), {
  // Primitives
  title: 'Default Title',
  count: 0,
  disabled: false,

  // Mutable types with factory functions
  items: () => [],
  users: () => [],
  metadata: () => ({}),
  selectedIds: () => new Set()
})
</script>
```

## Vue 3.5+ Reactive Props Destructure

Vue 3.5 introduces reactive props destructure, which handles this automatically:

```vue
<script setup lang="ts">
interface Props {
  items?: string[]
  config?: { theme: string }
}

// Vue 3.5+ - defaults work correctly without explicit factory functions
const {
  items = ['default'],        // Each instance gets its own array
  config = { theme: 'light' } // Each instance gets its own object
} = defineProps<Props>()
</script>
```

Note: Under the hood, Vue 3.5 handles the instance isolation for you.

## Common Bug Pattern

This bug often appears in list/table components:

```vue
<!-- ListItem.vue - BUGGY -->
<script setup lang="ts">
interface Props {
  selectedRows?: number[]
}

// All ListItems share the same selectedRows array!
const props = withDefaults(defineProps<Props>(), {
  selectedRows: []  // BUG: Missing factory function
})
</script>
```

Users report: "Selecting a row in one table selects it in all tables!"

**Fix:**
```typescript
const props = withDefaults(defineProps<Props>(), {
  selectedRows: () => []  // Now each instance has its own array
})
```

## Reference
- [Vue.js TypeScript with Composition API - Default Props](https://vuejs.org/guide/typescript/composition-api.html#props-default-values)
- [Vue RFC - Reactive Props Destructure](https://github.com/vuejs/rfcs/discussions/502)
