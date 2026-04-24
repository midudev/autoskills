---
title: SFC Script Block Must Use Default Export Only
impact: HIGH
impactDescription: Named exports in SFC script blocks will fail silently or cause build errors - Vue expects exactly one default export
type: gotcha
tags: [vue3, sfc, export, script-block, composition-api]
---

# SFC Script Block Must Use Default Export Only

**Impact: HIGH** - Vue Single-File Components expect exactly one default export from the `<script>` block. Using named exports for your component will cause build failures or runtime errors because Vue's tooling is designed to process a single default-exported component definition per `.vue` file.

## Task Checklist

- [ ] Always use `export default` in `<script>` blocks (Options API)
- [ ] Use `<script setup>` which handles exports automatically (Composition API)
- [ ] Move shared utilities to separate `.js`/`.ts` files, not the component's script block
- [ ] If you need to export types, use a separate `<script>` block alongside `<script setup>`

**Problematic Code:**
```vue
<!-- MyComponent.vue -->
<script>
// BAD: Named exports don't work for the component itself
export const MyComponent = {
  data() {
    return { count: 0 }
  }
}

// BAD: Exporting multiple things from component script
export const CONSTANT = 42
export function helper() { }
</script>

<template>
  <div>{{ count }}</div>
</template>
```

**Correct Code:**
```vue
<!-- MyComponent.vue - Options API -->
<script>
// GOOD: Single default export
export default {
  data() {
    return { count: 0 }
  }
}
</script>

<template>
  <div>{{ count }}</div>
</template>
```

```vue
<!-- MyComponent.vue - Composition API with script setup -->
<script setup>
// GOOD: No export needed, component is auto-exported
import { ref } from 'vue'

const count = ref(0)
</script>

<template>
  <div>{{ count }}</div>
</template>
```

## Exporting Types Alongside Script Setup

For TypeScript, use a separate regular script block for type exports:

```vue
<script lang="ts">
// Regular script block for exports
export interface User {
  id: number
  name: string
}

export type Status = 'pending' | 'active' | 'inactive'
</script>

<script setup lang="ts">
// Setup script for component logic
import { ref } from 'vue'

const users = ref<User[]>([])
</script>

<template>
  <ul>
    <li v-for="user in users" :key="user.id">{{ user.name }}</li>
  </ul>
</template>
```

## Sharing Utilities Across Components

Don't put shared code in component script blocks. Create separate files:

```typescript
// utils/constants.ts
export const ITEMS_PER_PAGE = 20
export const API_BASE_URL = '/api/v1'

// utils/helpers.ts
export function formatDate(date: Date): string {
  return date.toLocaleDateString()
}

export function formatCurrency(amount: number): string {
  return `$${amount.toFixed(2)}`
}
```

```vue
<!-- ProductList.vue -->
<script setup>
// GOOD: Import shared utilities from external files
import { ITEMS_PER_PAGE } from '@/utils/constants'
import { formatCurrency } from '@/utils/helpers'
import { ref } from 'vue'

const products = ref([])
</script>
```

## Why This Restriction Exists

Vue's SFC compiler and build tools expect:

1. **One component per file**: The `.vue` file format is designed for single-component definitions
2. **Predictable structure**: Tools like Volar, vue-tsc, and bundler plugins assume default export
3. **Hot Module Replacement**: HMR relies on the single-component-per-file convention

```javascript
// How Vue tooling processes SFCs internally
import MyComponent from './MyComponent.vue'
// ^ Always expects the default export to be the component
```

## Common Mistake: Reusing Code via SFC Exports

```vue
<!-- BAD PATTERN: Trying to reuse code from components -->
<script>
// This won't work as expected
export const sharedLogic = () => { ... }

export default {
  // component definition
}
</script>
```

Instead, use composables:

```typescript
// composables/useSharedLogic.ts
export function useSharedLogic() {
  // Shared reactive logic
  const state = ref(0)
  const increment = () => state.value++

  return { state, increment }
}
```

```vue
<!-- ComponentA.vue -->
<script setup>
import { useSharedLogic } from '@/composables/useSharedLogic'

const { state, increment } = useSharedLogic()
</script>
```

## Reference
- [Vue.js SFC Specification](https://vuejs.org/api/sfc-spec.html)
- [Vue.js Composition API - Composables](https://vuejs.org/guide/reusability/composables.html)
