---
title: v-model Does Not Update During IME Composition
impact: MEDIUM
impactDescription: v-model won't capture intermediate input for Chinese, Japanese, Korean and other IME languages
type: capability
tags: [vue3, v-model, forms, input, ime, internationalization, i18n, cjk]
---

# v-model Does Not Update During IME Composition

**Impact: MEDIUM** - When users type in languages that require an Input Method Editor (Chinese, Japanese, Korean, etc.), v-model won't update until the composition is complete. This breaks real-time validation, character counters, and live search features for international users.

IME (Input Method Editor) allows users to compose complex characters by typing multiple keystrokes. During this composition phase, v-model deliberately waits until the user confirms their selection before updating. This is usually desired, but can break features that need every keystroke.

## Task Checklist

- [ ] Test forms with IME input if your app serves CJK (Chinese, Japanese, Korean) users
- [ ] For real-time features (live search, character counters), use manual event binding instead of v-model
- [ ] Consider both behaviors when designing - sometimes waiting for composition completion IS correct
- [ ] Document expected behavior for international users

**Problem - v-model waits for composition:**
```html
<script setup>
import { ref } from 'vue'

const searchQuery = ref('')
const charCount = ref(0)
</script>

<template>
  <!-- PROBLEM: During IME composition, searchQuery won't update -->
  <!-- Chinese user types "ni hao" -> sees no results until they press space/enter -->
  <input v-model="searchQuery" placeholder="Live search...">
  <p>{{ searchQuery.length }} characters</p>

  <!-- Character counter stays at 0 during IME input -->
</template>
```

**Solution - Manual event binding for real-time updates:**
```html
<script setup>
import { ref } from 'vue'

const searchQuery = ref('')

// This captures EVERY input event, including during IME composition
function handleInput(event) {
  searchQuery.value = event.target.value
}
</script>

<template>
  <!-- CORRECT: Manual binding captures all input, including IME composition -->
  <input
    :value="searchQuery"
    @input="handleInput"
    placeholder="Live search..."
  >
  <p>{{ searchQuery.length }} characters</p>
</template>
```

```html
<!-- Shorter inline version -->
<input
  :value="searchQuery"
  @input="event => searchQuery = event.target.value"
>
```

**When v-model behavior IS correct:**
```html
<!-- For form submission, waiting for composition IS usually better -->
<!-- User expects to confirm their character selection before it's "official" -->
<input v-model="formName" placeholder="Enter your name">

<!-- The final composed characters will be submitted, not intermediate states -->
```

## Reference
- [Vue.js Form Input Bindings](https://vuejs.org/guide/essentials/forms.html)
