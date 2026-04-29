---
title: Textarea Interpolation is One-Way Only - Use v-model for Two-Way Binding
impact: HIGH
impactDescription: Using {{ text }} inside textarea displays initial value but user input does NOT update the ref
type: capability
tags: [vue3, v-model, forms, textarea, interpolation, template]
---

# Textarea Interpolation is One-Way Only - Use v-model for Two-Way Binding

**Impact: HIGH** - Interpolation in textarea (`{{ text }}`) provides one-way binding only - it displays the initial value but user input does NOT update the ref. This creates a confusing disconnect where the textarea shows content but edits are silently lost.

Unlike v-model which provides two-way binding, interpolation only renders the initial ref value into the textarea. When users type, the ref remains unchanged, making form submissions return stale data. Always use v-model for two-way binding in textareas.

## Task Checklist

- [ ] Never use interpolation inside textarea tags
- [ ] Always use v-model for textarea two-way binding
- [ ] Search codebase for `<textarea>{{` patterns that may be silently broken
- [ ] Add linting rules to catch this pattern if possible

**Incorrect:**
```html
<script setup>
import { ref } from 'vue'

const message = ref('Hello World')
</script>

<template>
  <!-- WRONG: One-way binding only! Shows initial value but edits don't update ref -->
  <textarea>{{ message }}</textarea>

  <!-- Also WRONG: User can type but changes are lost -->
  <textarea>{{ userBio }}</textarea>

  <!-- The textarea displays content but ref never updates -->
</template>
```

**Correct:**
```html
<script setup>
import { ref } from 'vue'

const message = ref('Hello World')
</script>

<template>
  <!-- CORRECT: Use v-model for textarea -->
  <textarea v-model="message"></textarea>

  <!-- For read-only display, still use v-model or :value -->
  <textarea v-model="message" readonly></textarea>

  <!-- Or one-way binding with :value -->
  <textarea :value="message" readonly></textarea>
</template>
```

```html
<!-- With placeholder and other attributes -->
<textarea
  v-model="message"
  placeholder="Enter your message..."
  rows="5"
  maxlength="500"
></textarea>
```

## Reference
- [Vue.js Form Input Bindings - Multiline text](https://vuejs.org/guide/essentials/forms.html#multiline-text)
