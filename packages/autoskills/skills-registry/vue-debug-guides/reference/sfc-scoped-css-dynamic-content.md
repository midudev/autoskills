---
title: Scoped CSS Does Not Apply to Dynamically Added Content
impact: HIGH
impactDescription: Programmatically inserted DOM elements won't receive scoped style data attributes, causing styles to fail silently
type: gotcha
tags: [vue3, sfc, scoped-css, dynamic-content, v-html]
---

# Scoped CSS Does Not Apply to Dynamically Added Content

**Impact: HIGH** - Vue's scoped CSS works by adding data attributes to elements at compile time. Content added dynamically at runtime (via `v-html`, JavaScript DOM manipulation, or third-party libraries) won't have these attributes, so scoped styles won't apply.

## Task Checklist

- [ ] For `v-html` content, use `:deep()` selectors or unscoped styles
- [ ] Avoid programmatic DOM manipulation; prefer Vue's reactive template system
- [ ] When DOM manipulation is unavoidable, use global styles with unique class prefixes
- [ ] Consider CSS modules for content that mixes static and dynamic elements

**Problematic Code:**
```vue
<script setup>
import { ref } from 'vue'

const htmlContent = ref('<p class="dynamic">This is dynamic content</p>')
</script>

<template>
  <div class="container">
    <div v-html="htmlContent"></div>
  </div>
</template>

<style scoped>
/* BAD: Won't apply to the dynamic <p> element! */
.dynamic {
  color: red;
  font-weight: bold;
}
</style>
```

**Correct Code:**
```vue
<script setup>
import { ref } from 'vue'

const htmlContent = ref('<p class="dynamic">This is dynamic content</p>')
</script>

<template>
  <div class="container">
    <div v-html="htmlContent"></div>
  </div>
</template>

<style scoped>
/* GOOD: Use :deep() for v-html content */
.container :deep(.dynamic) {
  color: red;
  font-weight: bold;
}
</style>
```

## Why This Happens

Vue scoped CSS adds a unique data attribute (e.g., `data-v-7ba5bd90`) to:
1. All elements in the component's template (at compile time)
2. All CSS selectors

```html
<!-- What Vue generates at compile time -->
<div class="container" data-v-7ba5bd90>
  <div data-v-7ba5bd90>
    <!-- v-html content is inserted at runtime WITHOUT the attribute -->
    <p class="dynamic">This is dynamic content</p>
  </div>
</div>
```

```css
/* Generated scoped CSS */
.dynamic[data-v-7ba5bd90] { color: red; }
/* ^ Won't match because the dynamic <p> doesn't have data-v-7ba5bd90 */
```

## Alternative: Global Styles with Unique Prefix

```vue
<script setup>
import { ref } from 'vue'
const htmlContent = ref('<p class="my-component-dynamic">Dynamic text</p>')
</script>

<template>
  <div class="my-component">
    <div v-html="htmlContent"></div>
  </div>
</template>

<!-- Use unscoped styles with unique prefixes -->
<style>
.my-component .my-component-dynamic {
  color: red;
}
</style>
```

## Programmatic DOM Manipulation

When using third-party libraries that manipulate the DOM:

```vue
<script setup>
import { ref, onMounted } from 'vue'

const editorRef = ref(null)

onMounted(() => {
  // Third-party editor that injects its own DOM elements
  initRichEditor(editorRef.value)
})
</script>

<template>
  <div class="editor-wrapper">
    <div ref="editorRef"></div>
  </div>
</template>

<style scoped>
/* BAD: Won't reach injected editor elements */
.editor-toolbar { ... }
.editor-content { ... }
</style>

<style>
/* GOOD: Global styles scoped by parent class */
.editor-wrapper .editor-toolbar {
  background: #f5f5f5;
}
.editor-wrapper .editor-content {
  padding: 1rem;
}
</style>
```

## Best Practice: Prefer Reactive Templates

Instead of dynamic HTML, use Vue's reactive system when possible:

```vue
<script setup>
import { ref } from 'vue'

// BAD: Dynamic HTML that needs special style handling
const badHtml = ref('<span class="highlight">text</span>')

// GOOD: Reactive data that templates handle
const items = ref([
  { text: 'Item 1', isHighlighted: true },
  { text: 'Item 2', isHighlighted: false }
])
</script>

<template>
  <!-- BAD -->
  <div v-html="badHtml"></div>

  <!-- GOOD: Scoped styles work normally -->
  <ul>
    <li
      v-for="item in items"
      :key="item.text"
      :class="{ highlight: item.isHighlighted }"
    >
      {{ item.text }}
    </li>
  </ul>
</template>

<style scoped>
/* Works perfectly with reactive template */
.highlight {
  background: yellow;
}
</style>
```

## Reference
- [Vue.js Scoped CSS](https://vuejs.org/api/sfc-css-features.html#scoped-css)
- [GitHub Issue: Scoped CSS not applied for programmatically added elements](https://github.com/vuejs/vue/issues/7649)
