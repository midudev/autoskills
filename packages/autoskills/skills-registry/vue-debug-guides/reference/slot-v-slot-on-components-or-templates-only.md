---
title: v-slot Can Only Be Used on Components or Template Tags
impact: HIGH
impactDescription: Using v-slot on HTML elements causes compilation errors
type: gotcha
tags: [vue3, slots, v-slot, compilation-error, common-mistake]
---

# v-slot Can Only Be Used on Components or Template Tags

**Impact: HIGH** - The `v-slot` directive (and its shorthand `#`) can only be used on Vue components or `<template>` tags. Using it on native HTML elements like `<div>` or `<span>` causes a Vue compilation error.

## Task Checklist

- [ ] Only use `v-slot` on component elements or `<template>` tags
- [ ] When using default scoped slot shorthand, apply to the component itself
- [ ] For named slots, always use `<template #name>` syntax

**Incorrect:**
```vue
<template>
  <!-- BAD: v-slot on a native HTML element -->
  <div v-slot:header>
    <h1>Title</h1>
  </div>

  <!-- BAD: Shorthand on HTML element -->
  <span #default="{ item }">
    {{ item.name }}
  </span>

  <!-- BAD: v-slot inside a plain HTML element -->
  <div>
    <p v-slot:content>Some text</p>
  </div>
</template>
```

These cause the error: `v-slot can only be used on components or <template> tags`

**Correct:**
```vue
<template>
  <!-- GOOD: v-slot on component element (default scoped slot) -->
  <MyComponent v-slot="{ item }">
    {{ item.name }}
  </MyComponent>

  <!-- GOOD: Named slots use template tags -->
  <BaseLayout>
    <template #header>
      <h1>Title</h1>
    </template>

    <template #default>
      <p>Main content</p>
    </template>

    <template #footer>
      <p>Footer content</p>
    </template>
  </BaseLayout>

  <!-- GOOD: Shorthand on component for default slot -->
  <FancyList #default="{ item }">
    <div>{{ item.name }}</div>
  </FancyList>
</template>
```

## Common Scenarios

### Wrapping Slot Content in HTML
If you need HTML wrappers around slot content, put them inside the template:

```vue
<!-- WRONG -->
<MyComponent>
  <div v-slot:header class="header-wrapper">
    <h1>Title</h1>
  </div>
</MyComponent>

<!-- CORRECT -->
<MyComponent>
  <template #header>
    <div class="header-wrapper">
      <h1>Title</h1>
    </div>
  </template>
</MyComponent>
```

### Multiple v-slot on Same Element
Another error occurs when you have multiple v-slot directives - only the first is recognized:

```vue
<!-- BAD: Multiple v-slot directives -->
<MyComponent v-slot:header v-slot:footer>
  Content
</MyComponent>

<!-- GOOD: Separate template for each slot -->
<MyComponent>
  <template #header>Header</template>
  <template #footer>Footer</template>
</MyComponent>
```

## Valid v-slot Locations

| Element Type | v-slot Allowed? | Example |
|--------------|-----------------|---------|
| Component | Yes | `<MyComponent v-slot="props">` |
| `<template>` | Yes | `<template #header>` |
| `<div>` | No | Compilation error |
| `<span>` | No | Compilation error |
| Any HTML element | No | Compilation error |

## Reference
- [Vue.js Slots](https://vuejs.org/guide/components/slots.html)
- [DeepScan - vue-misused-v-slot](https://deepscan.io/docs/rules/vue-misused-v-slot)
