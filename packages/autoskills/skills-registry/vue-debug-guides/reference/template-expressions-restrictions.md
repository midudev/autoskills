---
title: Template Expressions Must Be Single Expressions
impact: MEDIUM
impactDescription: Using statements instead of expressions in templates causes compilation errors
type: capability
tags: [vue3, template, expressions, interpolation, syntax]
---

# Template Expressions Must Be Single Expressions

**Impact: MEDIUM** - Vue templates only support single JavaScript expressions, not statements. Using variable declarations, if statements, or multiple statements will cause template compilation errors.

Template interpolation `{{ }}` and directive bindings evaluate JavaScript expressions that produce a value. Statements like `if`, `for`, variable declarations, or multi-line code blocks are not allowed.

## Task Checklist

- [ ] Use only single expressions in `{{ }}` interpolation
- [ ] Use ternary operators instead of if/else statements
- [ ] Move complex logic to computed properties or methods
- [ ] Avoid variable declarations in templates
- [ ] Use `v-if`/`v-else` directives for conditional rendering

**Incorrect:**
```vue
<template>
  <!-- ERROR: Variable declaration is a statement, not expression -->
  <p>{{ var greeting = 'Hello' }}</p>
  <p>{{ let x = 1 }}</p>
  <p>{{ const name = 'Vue' }}</p>

  <!-- ERROR: if statement not allowed -->
  <p>{{ if (ok) { return message } }}</p>
  <p>{{ if (user) return user.name }}</p>

  <!-- ERROR: Multiple statements not allowed -->
  <p>{{ count++; return count }}</p>
  <p>{{ items.push(newItem); items.length }}</p>

  <!-- ERROR: for/while loops not allowed -->
  <p>{{ for (let i = 0; i < 5; i++) { } }}</p>
</template>
```

**Correct:**
```vue
<template>
  <!-- OK: Simple expressions -->
  <p>{{ message }}</p>
  <p>{{ count + 1 }}</p>
  <p>{{ items.length }}</p>

  <!-- OK: Ternary operators for conditionals -->
  <p>{{ ok ? 'YES' : 'NO' }}</p>
  <p>{{ user ? user.name : 'Guest' }}</p>
  <p>{{ score >= 60 ? 'Pass' : 'Fail' }}</p>

  <!-- OK: Method/function calls -->
  <p>{{ formatDate(date) }}</p>
  <p>{{ items.filter(i => i.active).length }}</p>

  <!-- OK: Chained expressions -->
  <p>{{ message.split('').reverse().join('') }}</p>

  <!-- OK: Template literals -->
  <p>{{ `Hello, ${name}!` }}</p>

  <!-- OK: Object/array expressions -->
  <p>{{ { name: 'Vue', version: 3 } }}</p>
</template>

<script setup>
import { ref, computed } from 'vue'

const ok = ref(true)
const message = ref('Hello')
const user = ref({ name: 'Alice' })
const score = ref(85)

// Move complex logic to computed properties
const greeting = computed(() => {
  if (user.value) {
    return `Welcome back, ${user.value.name}!`
  }
  return 'Hello, Guest!'
})

// Or use methods for reusable logic
function formatDate(date) {
  return new Date(date).toLocaleDateString()
}
</script>
```

## Use Directives for Control Flow

```vue
<template>
  <!-- Instead of if/else in expressions, use v-if/v-else -->
  <p v-if="user">Welcome, {{ user.name }}!</p>
  <p v-else>Please log in</p>

  <!-- Instead of loops in expressions, use v-for -->
  <ul>
    <li v-for="item in items" :key="item.id">{{ item.name }}</li>
  </ul>

  <!-- Conditional display without removing from DOM -->
  <p v-show="isVisible">This toggles visibility</p>
</template>
```

## Reference
- [Vue.js Template Syntax - Using JavaScript Expressions](https://vuejs.org/guide/essentials/template-syntax.html#using-javascript-expressions)
- [Vue.js Conditional Rendering](https://vuejs.org/guide/essentials/conditional.html)
