---
title: v-model Ignores Initial HTML Attributes
impact: HIGH
impactDescription: v-model ignores value, checked, and selected HTML attributes - initial state must be set in JavaScript
type: capability
tags: [vue3, v-model, forms, input, checkbox, select, initialization]
---

# v-model Ignores Initial HTML Attributes

**Impact: HIGH** - Setting initial values via HTML `value`, `checked`, or `selected` attributes has no effect when using v-model. The form will appear empty or in an unexpected state, confusing users and potentially causing data loss.

Vue's v-model always treats the bound JavaScript state as the single source of truth. Any initial attributes in the HTML are completely ignored. This is a common mistake when migrating from plain HTML forms or when copying HTML templates.

## Task Checklist

- [ ] Never rely on HTML `value`, `checked`, or `selected` attributes when using v-model
- [ ] Always declare initial values in JavaScript using `ref()` or `reactive()`
- [ ] When migrating plain HTML forms to Vue, move all default values to JavaScript state
- [ ] Audit existing forms for hardcoded HTML default values that may be silently ignored

**Incorrect:**
```html
<script setup>
import { ref } from 'vue'

const username = ref('')  // Empty!
const isSubscribed = ref(false)  // Not checked!
const country = ref('')  // No default selection!
</script>

<template>
  <!-- WRONG: These HTML attributes are completely ignored -->
  <input v-model="username" value="default_user">

  <input type="checkbox" v-model="isSubscribed" checked>

  <select v-model="country">
    <option value="us" selected>United States</option>
    <option value="uk">United Kingdom</option>
  </select>
</template>
```

**Correct:**
```html
<script setup>
import { ref } from 'vue'

// CORRECT: Set initial values in JavaScript
const username = ref('default_user')
const isSubscribed = ref(true)
const country = ref('us')
</script>

<template>
  <!-- HTML attributes not needed - JavaScript state controls everything -->
  <input v-model="username">

  <input type="checkbox" v-model="isSubscribed">

  <select v-model="country">
    <option value="us">United States</option>
    <option value="uk">United Kingdom</option>
  </select>
</template>
```

```javascript
// Options API equivalent
export default {
  data() {
    return {
      username: 'default_user',
      isSubscribed: true,
      country: 'us'
    }
  }
}
```

## Reference
- [Vue.js Form Input Bindings](https://vuejs.org/guide/essentials/forms.html)
