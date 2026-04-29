---
title: Never Use v-if and v-for on the Same Element
impact: HIGH
impactDescription: Causes confusing precedence issues and Vue 2 to 3 migration bugs
type: capability
tags: [vue3, v-if, v-for, conditional-rendering, list-rendering, eslint]
---

# Never Use v-if and v-for on the Same Element

**Impact: HIGH** - Using `v-if` and `v-for` on the same element creates ambiguous precedence that differs between Vue 2 and Vue 3. In Vue 2, `v-for` had higher precedence; in Vue 3, `v-if` has higher precedence. This breaking change causes subtle bugs during migration and makes code intent unclear.

The ESLint rule `vue/no-use-v-if-with-v-for` enforces this best practice.

## Task Checklist

- [ ] Never place v-if and v-for on the same element
- [ ] For filtering list items: use a computed property that filters the array
- [ ] For hiding entire list: wrap with `<template v-if>` around the v-for
- [ ] Enable eslint-plugin-vue rule `vue/no-use-v-if-with-v-for`

**Incorrect:**
```html
<!-- WRONG: v-if and v-for on same element - ambiguous precedence -->
<template>
  <!-- Intent: show only active users -->
  <li v-for="user in users" v-if="user.isActive" :key="user.id">
    {{ user.name }}
  </li>
</template>
```

```html
<!-- WRONG: Hiding entire list conditionally -->
<template>
  <li v-for="user in users" v-if="shouldShowList" :key="user.id">
    {{ user.name }}
  </li>
</template>
```

```html
<!-- WRONG: Vue 3 precedence issue -->
<template>
  <!-- In Vue 3, v-if runs FIRST, so 'user' is undefined! -->
  <li v-for="user in users" v-if="user.isActive" :key="user.id">
    {{ user.name }}
  </li>
  <!-- Error: Cannot read property 'isActive' of undefined -->
</template>
```

**Correct:**
```html
<!-- CORRECT: Filter with computed property -->
<template>
  <li v-for="user in activeUsers" :key="user.id">
    {{ user.name }}
  </li>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps(['users'])

const activeUsers = computed(() =>
  props.users.filter(user => user.isActive)
)
</script>
```

```html
<!-- CORRECT: Wrap with <template v-if> for conditional list -->
<template>
  <template v-if="shouldShowList">
    <li v-for="user in users" :key="user.id">
      {{ user.name }}
    </li>
  </template>
</template>
```

```html
<!-- CORRECT: v-if inside the loop (per-item condition) -->
<template>
  <ul>
    <template v-for="user in users" :key="user.id">
      <li v-if="user.isActive">
        {{ user.name }}
      </li>
    </template>
  </ul>
</template>
```

## Vue 2 vs Vue 3 Precedence Change

```javascript
// Vue 2: v-for evaluated first
// <li v-for="user in users" v-if="user.isActive">
// Equivalent to: users.forEach(user => { if (user.isActive) render(user) })

// Vue 3: v-if evaluated first
// <li v-for="user in users" v-if="user.isActive">
// Equivalent to: if (user.isActive) users.forEach(user => render(user))
// Problem: 'user' doesn't exist yet when v-if runs!
```

## Why Computed Properties Are Better

```javascript
// Benefits of filtering via computed:
// 1. Clear separation of concerns (logic vs template)
// 2. Cached - only recalculates when dependencies change
// 3. Reusable - can be used elsewhere in component
// 4. Testable - can unit test the filtering logic
// 5. No ambiguity about intent

const activeUsers = computed(() =>
  users.value.filter(u => u.isActive)
)

// Can add more complex filtering
const filteredUsers = computed(() =>
  users.value
    .filter(u => u.isActive)
    .filter(u => u.role === selectedRole.value)
    .sort((a, b) => a.name.localeCompare(b.name))
)
```

## Reference
- [Vue.js Style Guide - Avoid v-if with v-for](https://vuejs.org/style-guide/rules-essential.html#avoid-v-if-with-v-for)
- [Vue 3 Migration Guide - v-if vs v-for Precedence](https://v3-migration.vuejs.org/breaking-changes/v-if-v-for)
- [ESLint Plugin Vue - no-use-v-if-with-v-for](https://eslint.vuejs.org/rules/no-use-v-if-with-v-for)
