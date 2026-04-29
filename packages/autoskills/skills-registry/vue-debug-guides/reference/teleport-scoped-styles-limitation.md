---
title: Scoped Styles May Not Apply to Teleported Content
impact: MEDIUM
impactDescription: Scoped styles can fail to apply to teleported elements due to data attribute limitations
type: gotcha
tags: [vue3, teleport, scoped-styles, css]
---

# Scoped Styles May Not Apply to Teleported Content

**Impact: MEDIUM** - When using scoped styles with Teleport, the styles may not apply correctly to teleported elements. This is a known limitation related to how Vue's scoped style attributes work with elements rendered outside the component's DOM tree.

## Task Checklist

- [ ] Test scoped styles on teleported content
- [ ] Use `:deep()` selector or non-scoped styles for teleported content
- [ ] Consider CSS modules as an alternative
- [ ] Keep teleported content styles in a separate non-scoped style block

**Problem - Scoped Styles Not Applied:**
```vue
<template>
  <Teleport to="body">
    <div class="modal">
      <p class="modal-text">This text may not be styled!</p>
    </div>
  </Teleport>
</template>

<style scoped>
/* These styles may NOT apply to teleported content */
.modal {
  background: white;
  padding: 20px;
}

.modal-text {
  color: blue;  /* May not work */
}
</style>
```

**Solution 1 - Use Non-Scoped Styles for Teleported Content:**
```vue
<template>
  <Teleport to="body">
    <div class="my-modal">
      <p class="my-modal-text">This text will be styled</p>
    </div>
  </Teleport>
</template>

<style scoped>
/* Component-specific styles */
.button { color: blue; }
</style>

<style>
/* Non-scoped styles for teleported content */
/* Use specific class names to avoid conflicts */
.my-modal {
  background: white;
  padding: 20px;
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}

.my-modal-text {
  color: blue;
}
</style>
```

**Solution 2 - Use :deep() Selector:**
```vue
<template>
  <Teleport to="body">
    <div class="modal">
      <p class="modal-text">Styled with :deep()</p>
    </div>
  </Teleport>
</template>

<style scoped>
:deep(.modal) {
  background: white;
  padding: 20px;
}

:deep(.modal-text) {
  color: blue;
}
</style>
```

**Solution 3 - CSS Modules:**
```vue
<template>
  <Teleport to="body">
    <div :class="$style.modal">
      <p :class="$style.modalText">Styled with CSS modules</p>
    </div>
  </Teleport>
</template>

<style module>
.modal {
  background: white;
  padding: 20px;
}

.modalText {
  color: blue;
}
</style>
```

## Multi-Root Components with Teleport

Using Teleport as one of multiple root nodes causes additional issues:

```vue
<template>
  <!-- Multi-root component -->
  <button @click="open = true">Open</button>
  <Teleport to="body">
    <div class="modal">Content</div>
  </Teleport>
</template>

<!-- Warning: class/style attributes may not be inherited -->
```

Pass classes explicitly to avoid inheritance issues:

```vue
<template>
  <button @click="open = true">Open</button>
  <Teleport to="body">
    <div :class="['modal', $attrs.class]" :style="$attrs.style">
      Content
    </div>
  </Teleport>
</template>
```

## Best Practice: Dedicated Modal Styles

Create a dedicated stylesheet for modal/overlay components:

```css
/* modal-styles.css */
.modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
}

.modal-content {
  background: white;
  border-radius: 8px;
  padding: 24px;
  max-width: 500px;
  width: 90%;
}
```

```vue
<script setup>
import './modal-styles.css'
</script>

<template>
  <Teleport to="body">
    <div v-if="open" class="modal-overlay">
      <div class="modal-content">
        <slot />
      </div>
    </div>
  </Teleport>
</template>
```

## Reference
- [Vue.js SFC CSS Features - Scoped CSS](https://vuejs.org/api/sfc-css-features.html#scoped-css)
- [GitHub Issue #2047 - Scoped styles and teleport](https://github.com/vuejs/core/issues/2047)
