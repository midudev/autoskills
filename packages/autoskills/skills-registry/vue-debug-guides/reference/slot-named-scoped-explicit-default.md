---
title: Use Explicit Default Template When Mixing Named and Scoped Slots
impact: HIGH
impactDescription: Mixing v-slot on component with named slots inside causes ambiguous scope and compilation errors
type: gotcha
tags: [vue3, slots, scoped-slots, named-slots, compilation-error]
---

# Use Explicit Default Template When Mixing Named and Scoped Slots

**Impact: HIGH** - When a component uses both the default scoped slot and named slots, you must use an explicit `<template #default>` for the default slot. Using `v-slot` directly on the component while having nested named slot templates causes scope ambiguity and compilation errors.

## Task Checklist

- [ ] When using named slots alongside a default slot with props, always use explicit `<template #default>`
- [ ] Never mix `v-slot` on the component element with `<template #name>` inside
- [ ] Keep slot scope clear and unambiguous

**Incorrect:**
```vue
<script setup>
import MyComponent from './MyComponent.vue'
</script>

<template>
  <!-- BAD: v-slot on component + named template inside causes ambiguity -->
  <MyComponent v-slot="{ message }">
    <p>{{ message }}</p>

    <template #footer>
      <!-- Ambiguous: Is 'message' available here? Vue can't determine -->
      <p>Footer: {{ message }}</p>
    </template>
  </MyComponent>
</template>
```

This causes a compilation error because Vue cannot determine:
1. Whether `message` from the default slot should be available in the footer slot
2. Which scope applies to the non-template content

**Correct:**
```vue
<script setup>
import MyComponent from './MyComponent.vue'
</script>

<template>
  <!-- GOOD: Explicit template for each slot with clear scope -->
  <MyComponent>
    <template #default="{ message }">
      <p>{{ message }}</p>
    </template>

    <template #footer>
      <!-- Clear: footer slot has its own scope, no access to default's 'message' -->
      <p>Footer content here</p>
    </template>
  </MyComponent>
</template>
```

**Correct - When Footer Also Has Props:**
```vue
<script setup>
import MyComponent from './MyComponent.vue'
</script>

<template>
  <MyComponent>
    <template #default="{ message }">
      <p>{{ message }}</p>
    </template>

    <template #footer="{ year }">
      <!-- Each slot receives its own props -->
      <p>Copyright {{ year }}</p>
    </template>
  </MyComponent>
</template>
```

## The Rule

When you have **any** named slots (`<template #name>`), always use explicit templates for **all** slots, including the default slot. This makes scope boundaries clear and prevents compilation errors.

| Pattern | Valid? | Notes |
|---------|--------|-------|
| `v-slot` on component only | Yes | Single default scoped slot |
| Named templates only | Yes | Multiple named slots |
| `v-slot` on component + named templates | No | Ambiguous scope |
| All explicit templates | Yes | Clear scope for each slot |

## Reference
- [Vue.js Slots - Named Scoped Slots](https://vuejs.org/guide/components/slots.html#named-scoped-slots)
