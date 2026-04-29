---
title: Template Refs Become Null When Elements Are Unmounted
impact: MEDIUM
impactDescription: Refs become null when conditionally rendered elements are removed, causing errors if not handled
type: gotcha
tags: [vue3, template-refs, v-if, watchers, conditional-rendering]
---

# Template Refs Become Null When Elements Are Unmounted

**Impact: MEDIUM** - When using template refs with `v-if`, the ref becomes `null` when the element is unmounted. Watchers and effects that access these refs must handle the null case to avoid runtime errors.

This is especially tricky with `watchEffect` since it runs automatically and may execute when the ref is null.

## Task Checklist

- [ ] Always check for null before accessing ref properties when using v-if
- [ ] In watchers, explicitly handle the null case (element unmounted or not yet mounted)
- [ ] Consider whether v-show is more appropriate if you need persistent ref access
- [ ] Use optional chaining (?.) when accessing ref properties in uncertain contexts

**Incorrect:**
```vue
<script setup>
import { ref, watchEffect } from 'vue'

const inputEl = ref(null)
const showInput = ref(true)

// WRONG: No null check - will error when v-if is false
watchEffect(() => {
  inputEl.value.focus() // TypeError when showInput is false
})
</script>

<template>
  <input v-if="showInput" ref="inputEl" />
  <button @click="showInput = !showInput">Toggle</button>
</template>
```

**Correct:**
```vue
<script setup>
import { ref, watchEffect } from 'vue'

const inputEl = ref(null)
const showInput = ref(true)

// CORRECT: Handle both mounted and unmounted states
watchEffect(() => {
  if (inputEl.value) {
    inputEl.value.focus()
  } else {
    // Element not mounted yet, or unmounted by v-if
    console.log('Input element not available')
  }
})
</script>

<template>
  <input v-if="showInput" ref="inputEl" />
  <button @click="showInput = !showInput">Toggle</button>
</template>
```

```vue
<script setup>
import { ref, watch } from 'vue'

const inputEl = ref(null)
const showInput = ref(true)

// CORRECT: Watch the ref and handle null explicitly
watch(inputEl, (el) => {
  if (el) {
    el.focus()
  }
})
</script>

<template>
  <input v-if="showInput" ref="inputEl" />
</template>
```

```vue
<script setup>
import { useTemplateRef, watchEffect } from 'vue'

// Vue 3.5+ approach
const input = useTemplateRef('my-input')

// CORRECT: Use optional chaining for safe access
watchEffect(() => {
  input.value?.focus()
})
</script>

<template>
  <input v-if="showInput" ref="my-input" />
</template>
```

```vue
<script setup>
import { ref, onMounted } from 'vue'

const inputEl = ref(null)
const showInput = ref(true)

// ALTERNATIVE: Use v-show if you need consistent ref access
// v-show keeps element in DOM, just hides it with CSS
</script>

<template>
  <!-- Element always exists in DOM, ref is never null -->
  <input v-show="showInput" ref="inputEl" />
</template>
```

## Reference
- [Vue.js Template Refs](https://vuejs.org/guide/essentials/template-refs.html)
