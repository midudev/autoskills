---
title: Non-Template Content Is Implicitly Default Slot Content
impact: LOW
impactDescription: Unexpected content placement when mixing named slots with loose content
type: gotcha
tags: [vue3, slots, named-slots, default-slot, implicit-behavior]
---

# Non-Template Content Is Implicitly Default Slot Content

**Impact: LOW** - When using named slots, any top-level content not wrapped in a `<template>` tag is automatically treated as default slot content. This implicit behavior can cause confusion about where content will render.

## Task Checklist

- [ ] Understand that loose content goes to the default slot
- [ ] Use explicit `<template #default>` when clarity matters
- [ ] Keep slot content organization intentional

**The Implicit Behavior:**
```vue
<script setup>
import BaseLayout from './BaseLayout.vue'
</script>

<template>
  <BaseLayout>
    <template #header>
      <h1>Page Title</h1>
    </template>

    <!-- These are IMPLICITLY in the default slot -->
    <p>First paragraph of main content.</p>
    <p>Second paragraph of main content.</p>

    <template #footer>
      <p>Footer content</p>
    </template>
  </BaseLayout>
</template>
```

The two `<p>` elements are automatically placed in `<slot>` (the default slot) in the child component.

**Equivalent Explicit Version:**
```vue
<template>
  <BaseLayout>
    <template #header>
      <h1>Page Title</h1>
    </template>

    <!-- Explicit default slot -->
    <template #default>
      <p>First paragraph of main content.</p>
      <p>Second paragraph of main content.</p>
    </template>

    <template #footer>
      <p>Footer content</p>
    </template>
  </BaseLayout>
</template>
```

## When Implicit Behavior Causes Confusion

**Scattered Content:**
```vue
<template>
  <BaseLayout>
    <template #header>
      <h1>Title</h1>
    </template>

    <p>Content A</p>  <!-- Goes to default slot -->

    <template #sidebar>
      <nav>Navigation</nav>
    </template>

    <p>Content B</p>  <!-- Also goes to default slot! -->

    <template #footer>
      <p>Footer</p>
    </template>

    <p>Content C</p>  <!-- Also goes to default slot! -->
  </BaseLayout>
</template>
```

All three `<p>` elements end up in the default slot together, which may not be the intended order or grouping.

**Clearer with Explicit Default:**
```vue
<template>
  <BaseLayout>
    <template #header>
      <h1>Title</h1>
    </template>

    <template #default>
      <p>Content A</p>
      <p>Content B</p>
      <p>Content C</p>
    </template>

    <template #sidebar>
      <nav>Navigation</nav>
    </template>

    <template #footer>
      <p>Footer</p>
    </template>
  </BaseLayout>
</template>
```

## Best Practices

| Scenario | Recommendation |
|----------|---------------|
| Only default slot used | Implicit is fine |
| Mixed named + default slots | Consider explicit `#default` |
| Complex layouts | Always use explicit templates |
| Team/shared codebase | Prefer explicit for clarity |

## The Child Component

```vue
<!-- BaseLayout.vue -->
<template>
  <div class="layout">
    <header>
      <slot name="header"></slot>
    </header>

    <aside>
      <slot name="sidebar"></slot>
    </aside>

    <main>
      <!-- All implicit content ends up here -->
      <slot></slot>
    </main>

    <footer>
      <slot name="footer"></slot>
    </footer>
  </div>
</template>
```

## Reference
- [Vue.js Slots - Named Slots](https://vuejs.org/guide/components/slots.html#named-slots)
