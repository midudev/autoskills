---
title: Select Element iOS Bug - Always Include Disabled Placeholder Option
impact: HIGH
impactDescription: On iOS, users cannot select the first option if v-model initial value doesn't match any option
type: capability
tags: [vue3, v-model, forms, select, ios, mobile, accessibility]
---

# Select Element iOS Bug - Always Include Disabled Placeholder Option

**Impact: HIGH** - When a `<select>` element's v-model initial value doesn't match any option, iOS renders it as "unselected" and users CANNOT select the first item. iOS doesn't fire a change event when selecting an already-visually-selected option, leaving users stuck.

This is a platform-specific bug that only manifests on iOS Safari. Desktop browsers and Android handle this gracefully, making it easy to miss during development. The fix is simple: always include a disabled placeholder option.

## Task Checklist

- [ ] Always add a disabled placeholder option with empty value to select elements
- [ ] Ensure v-model initial value is empty string to match the placeholder
- [ ] Test select inputs on iOS devices or simulators
- [ ] Consider this for any user-facing forms, especially on mobile-first apps

**Problem - iOS users cannot select first option:**
```html
<script setup>
import { ref } from 'vue'

// Initial value is empty string, doesn't match any option
const selected = ref('')
</script>

<template>
  <!-- PROBLEM: On iOS, "Apple" appears selected but user cannot actually select it -->
  <!-- Tapping "Apple" does nothing because iOS doesn't fire change event -->
  <select v-model="selected">
    <option value="apple">Apple</option>
    <option value="banana">Banana</option>
    <option value="orange">Orange</option>
  </select>

  <!-- selected remains '' even though "Apple" appears highlighted -->
</template>
```

**Solution - Add disabled placeholder option:**
```html
<script setup>
import { ref } from 'vue'

const selected = ref('')  // Matches the placeholder option
</script>

<template>
  <!-- CORRECT: Disabled placeholder ensures user must actively select -->
  <select v-model="selected">
    <option disabled value="">Please select a fruit</option>
    <option value="apple">Apple</option>
    <option value="banana">Banana</option>
    <option value="orange">Orange</option>
  </select>
</template>
```

```html
<!-- Variant with required attribute for form validation -->
<select v-model="selected" required>
  <option disabled value="">-- Select an option --</option>
  <option value="a">Option A</option>
  <option value="b">Option B</option>
</select>
```

```html
<!-- If you MUST have a pre-selected default, set the initial value to match -->
<script setup>
import { ref } from 'vue'

// Set initial value to match an actual option
const country = ref('us')  // Pre-selects "United States"
</script>

<template>
  <select v-model="country">
    <option value="us">United States</option>
    <option value="uk">United Kingdom</option>
    <option value="ca">Canada</option>
  </select>
</template>
```

## Reference
- [Vue.js Form Input Bindings - Select](https://vuejs.org/guide/essentials/forms.html#select)
