---
title: defineProps Cannot Access Variables from script setup
impact: MEDIUM
impactDescription: Variables declared in script setup are not accessible inside defineProps arguments
type: gotcha
tags: [vue3, props, script-setup, defineProps, compiler]
---

# defineProps Cannot Access Variables from script setup

**Impact: MEDIUM** - Code inside the `defineProps()` argument cannot access other variables declared in `<script setup>`. The entire expression is moved to an outer function scope when compiled, making local variables inaccessible.

This commonly surprises developers trying to use imported constants or computed validation logic.

## Task Checklist

- [ ] Define validation constants outside `<script setup>` or in a separate file
- [ ] Import constants before using them in defineProps
- [ ] Use external type definitions for TypeScript props
- [ ] For dynamic validation, use watchers instead of prop validators

**Incorrect:**
```vue
<script setup>
import { ref } from 'vue'

// These are in <script setup> scope
const VALID_SIZES = ['sm', 'md', 'lg']
const maxLength = ref(100)

defineProps({
  size: {
    type: String,
    // WRONG: VALID_SIZES is not accessible here
    validator: (v) => VALID_SIZES.includes(v)  // ReferenceError!
  },
  name: {
    type: String,
    // WRONG: Cannot access refs
    validator: (v) => v.length <= maxLength.value  // ReferenceError!
  }
})
</script>
```

**Correct:**
```vue
<script>
// Define constants in regular <script> block (module scope)
export const VALID_SIZES = ['sm', 'md', 'lg']
export const MAX_LENGTH = 100
</script>

<script setup>
// Now accessible in defineProps
defineProps({
  size: {
    type: String,
    validator: (v) => VALID_SIZES.includes(v)  // Works!
  },
  name: {
    type: String,
    validator: (v) => v.length <= MAX_LENGTH  // Works!
  }
})
</script>
```

## Pattern: Import from External File

```javascript
// validation.js
export const VALID_SIZES = ['sm', 'md', 'lg']
export const VALID_COLORS = ['red', 'blue', 'green']
export const sizeValidator = (v) => VALID_SIZES.includes(v)
```

```vue
<script setup>
import { VALID_SIZES, VALID_COLORS, sizeValidator } from './validation'

// Imported values ARE accessible
defineProps({
  size: {
    type: String,
    validator: sizeValidator
  },
  color: {
    type: String,
    validator: (v) => VALID_COLORS.includes(v)
  }
})
</script>
```

## Pattern: Dual Script Blocks

```vue
<script>
// Regular script for module-level declarations
const options = {
  themes: ['light', 'dark', 'system'],
  defaults: {
    theme: 'light',
    size: 'md'
  }
}
</script>

<script setup>
// options is accessible here
const props = defineProps({
  theme: {
    type: String,
    default: options.defaults.theme,
    validator: (v) => options.themes.includes(v)
  }
})
</script>
```

## TypeScript: External Type Definitions

```typescript
// types.ts
export interface UserProps {
  name: string
  email: string
  age?: number
}
```

```vue
<script setup lang="ts">
import type { UserProps } from './types'

// Type imports work fine
const props = defineProps<UserProps>()
</script>
```

## Why This Happens

Vue's compiler transforms `<script setup>` code. The `defineProps()` call is extracted and moved to component options at compile time, before the setup function runs:

```javascript
// Your code:
const MY_CONST = 'value'
defineProps({ prop: { default: MY_CONST } })

// Compiled (simplified):
export default {
  props: { prop: { default: MY_CONST } },  // MY_CONST doesn't exist here!
  setup() {
    const MY_CONST = 'value'  // Defined too late
  }
}
```

## Reference
- [Vue.js Script Setup - defineProps](https://vuejs.org/api/sfc-script-setup.html#defineprops-defineemits)
