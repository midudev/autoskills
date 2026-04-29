---
title: Checkbox true-value/false-value Not Submitted in Forms
impact: MEDIUM
impactDescription: true-value and false-value attributes don't affect form submission - unchecked boxes send nothing
type: capability
tags: [vue3, v-model, forms, checkbox, form-submission]
---

# Checkbox true-value/false-value Not Submitted in Forms

**Impact: MEDIUM** - Vue's `true-value` and `false-value` attributes only affect the JavaScript binding, NOT the actual form submission. Unchecked checkboxes are never included in form submissions by browsers, regardless of `false-value`.

This is a browser limitation, not a Vue issue. If you need to submit one of two values (like "yes"/"no" or "active"/"inactive"), use radio buttons instead of a checkbox.

## Task Checklist

- [ ] Don't rely on `false-value` for form submissions - it won't be sent
- [ ] Use radio buttons when you need to submit one of exactly two values
- [ ] Remember `true-value`/`false-value` are for JavaScript state only
- [ ] For form submissions with custom values, handle the transformation server-side or in submit handler

**Problem - false-value not submitted:**
```html
<script setup>
import { ref } from 'vue'

const status = ref('no')  // JavaScript value works correctly
</script>

<template>
  <form action="/api/update" method="POST">
    <!-- PROBLEM: When unchecked, nothing is submitted for this field -->
    <!-- Server receives no "status" field at all, not "no" -->
    <input
      type="checkbox"
      v-model="status"
      true-value="yes"
      false-value="no"
      name="status"
    >
    <label>Active</label>

    <!-- status.value correctly shows "yes" or "no" in Vue -->
    <!-- But form submission only sends "status=yes" when checked -->
    <!-- When unchecked, "status" field is completely missing -->
  </form>
</template>
```

**Solution 1 - Use radio buttons for two-value submission:**
```html
<script setup>
import { ref } from 'vue'

const status = ref('no')
</script>

<template>
  <form action="/api/update" method="POST">
    <!-- CORRECT: Radio buttons always submit a value -->
    <label>
      <input type="radio" v-model="status" value="yes" name="status">
      Active
    </label>
    <label>
      <input type="radio" v-model="status" value="no" name="status">
      Inactive
    </label>

    <!-- Form always submits "status=yes" or "status=no" -->
  </form>
</template>
```

**Solution 2 - Handle in submit handler (for SPA/AJAX):**
```html
<script setup>
import { ref } from 'vue'

const isActive = ref(false)

async function submitForm() {
  // Transform checkbox state to desired value before sending
  const payload = {
    status: isActive.value ? 'yes' : 'no'
  }

  await fetch('/api/update', {
    method: 'POST',
    body: JSON.stringify(payload)
  })
}
</script>

<template>
  <!-- For AJAX submission, checkbox is fine - transform in handler -->
  <input type="checkbox" v-model="isActive">
  <label>Active</label>

  <button @click="submitForm">Save</button>
</template>
```

**Solution 3 - Hidden input fallback:**
```html
<template>
  <form action="/api/update" method="POST">
    <!-- Hidden input provides fallback value -->
    <input type="hidden" name="status" value="no">
    <!-- Checkbox overrides with "yes" when checked -->
    <input type="checkbox" name="status" value="yes" v-model="isActive">
    <label>Active</label>
  </form>
</template>
```

## Reference
- [Vue.js Form Input Bindings - Checkbox](https://vuejs.org/guide/essentials/forms.html#checkbox)
