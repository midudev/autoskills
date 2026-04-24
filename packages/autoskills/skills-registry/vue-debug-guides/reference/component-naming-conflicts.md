---
title: Avoid Component Naming Conflicts Between Global and Local
impact: HIGH
impactDescription: Naming conflicts cause unexpected component rendering and hard-to-debug issues
type: gotcha
tags: [vue3, component-registration, naming-conflicts, global-local, debugging]
---

# Avoid Component Naming Conflicts Between Global and Local

**Impact: HIGH** - When a global component and a local component have the same name (or resolve to the same name due to casing differences), unexpected behavior occurs. The precedence rules can be confusing, and the wrong component may render silently without any error. This is particularly problematic when using third-party component libraries.

## Task Checklist

- [ ] Use unique, prefixed names for global components (e.g., `BaseButton`, `AppHeader`)
- [ ] Check for naming conflicts when adding global components
- [ ] Explicitly alias local components if there's potential conflict
- [ ] When overriding third-party components, document and test thoroughly

**Incorrect:**
```javascript
// main.js
import { createApp } from 'vue'
import Button from './components/Button.vue'

const app = createApp(App)
app.component('Button', Button) // Global Button
```

```vue
<!-- SomeComponent.vue -->
<script setup>
// This local Button might conflict with global Button
import Button from './local/Button.vue'
</script>

<template>
  <!-- Which Button renders? Behavior may be unexpected -->
  <Button>Click me</Button>
</template>
```

```vue
<!-- Another confusing scenario -->
<script setup>
// Registering with camelCase
import MyButton from './MyButton.vue'
</script>

<template>
  <!-- Using kebab-case - might match a global 'my-button' instead -->
  <my-button>Click</my-button>
</template>
```

**Correct:**
```javascript
// main.js - use prefixes for global components
import { createApp } from 'vue'
import BaseButton from './components/BaseButton.vue'
import BaseIcon from './components/BaseIcon.vue'

const app = createApp(App)
app.component('BaseButton', BaseButton)
app.component('BaseIcon', BaseIcon)
```

```vue
<!-- SomeComponent.vue -->
<script setup>
// Local components have distinct names
import SubmitButton from './local/SubmitButton.vue'
</script>

<template>
  <!-- No ambiguity - each name is unique -->
  <BaseButton>Generic button</BaseButton>
  <SubmitButton>Submit form</SubmitButton>
</template>
```

## Explicit Aliasing for Clarity

When you intentionally want to override or have similar names, use explicit aliasing:

```vue
<script setup>
// Explicit alias to avoid confusion
import { default as LocalButton } from './Button.vue'
</script>

<template>
  <LocalButton>Local version</LocalButton>
</template>
```

```vue
<!-- Options API with explicit component name -->
<script>
import ThirdPartyModal from 'some-library'
import CustomModal from './CustomModal.vue'

export default {
  components: {
    // Explicit names prevent ambiguity
    LibraryModal: ThirdPartyModal,
    CustomModal
  }
}
</script>
```

## Resolution Order

Understanding Vue's component resolution order helps debug issues:

1. **Local registration** takes precedence over global
2. **Exact case match** takes precedence over case-insensitive match
3. Self-referencing component name (file name) has lowest priority

```vue
<!-- If all exist: GlobalButton, local Button, and file is Button.vue -->
<script setup>
import Button from './Button.vue' // Local registration
</script>

<template>
  <!-- Resolves to locally imported Button, not global -->
  <Button />
</template>
```

## Third-Party Library Conflicts

```vue
<script setup>
// Be explicit when using components from multiple libraries
import { Button as AntButton } from 'ant-design-vue'
import { Button as ElButton } from 'element-plus'
</script>

<template>
  <AntButton>Ant Design</AntButton>
  <ElButton>Element Plus</ElButton>
</template>
```

## Naming Convention Strategy

| Component Type | Naming Pattern | Example |
|----------------|---------------|---------|
| Base/Global | `Base*` or `App*` prefix | `BaseButton`, `AppHeader` |
| Domain-specific | Domain prefix | `UserCard`, `ProductList` |
| Page components | `*Page` or `*View` suffix | `HomePage`, `UserView` |
| Layout components | `*Layout` suffix | `DefaultLayout`, `AdminLayout` |

## Reference
- [Vue.js Component Registration](https://vuejs.org/guide/components/registration.html)
- [GitHub Issue: Global component naming conflicts](https://github.com/vuejs/vue/issues/4434)
