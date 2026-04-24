---
title: Always Pass v-for Data to Components via Props
impact: MEDIUM
impactDescription: Components have isolated scope - v-for iteration data is not automatically available inside child components
type: gotcha
tags: [vue3, v-for, components, props, list-rendering]
---

# Always Pass v-for Data to Components via Props

**Impact: MEDIUM** - Vue components have isolated scope by design. When using `v-for` to render components, the iteration variable (e.g., `item`) is NOT automatically available inside the child component. You must explicitly pass the data through props.

This isolation is intentional - it keeps components reusable and their data dependencies explicit. Forgetting to pass props results in `undefined` data or errors about missing properties.

## Task Checklist

- [ ] Always bind iteration data to component props explicitly
- [ ] Pass both the item and index if the component needs them
- [ ] Always include a unique `:key` when rendering components with v-for
- [ ] Define corresponding props in the child component to receive the data

**Incorrect:**
```html
<!-- WRONG: Component cannot access 'todo' - it's not in scope -->
<TodoItem v-for="todo in todos" :key="todo.id" />

<!-- Inside TodoItem.vue: this.todo or todo is undefined! -->
```

```html
<!-- WRONG: Key provided but no data passed -->
<UserCard
  v-for="user in users"
  :key="user.id"
/>
<!-- UserCard has no user data to display -->
```

**Correct:**
```html
<!-- CORRECT: Explicitly pass the item as a prop -->
<TodoItem
  v-for="todo in todos"
  :key="todo.id"
  :todo="todo"
/>
```

```html
<!-- CORRECT: Pass multiple pieces of data -->
<UserCard
  v-for="(user, index) in users"
  :key="user.id"
  :user="user"
  :index="index"
  :is-first="index === 0"
/>
```

```vue
<!-- Child component: UserCard.vue -->
<script setup>
defineProps({
  user: {
    type: Object,
    required: true
  },
  index: {
    type: Number,
    required: true
  },
  isFirst: {
    type: Boolean,
    default: false
  }
})
</script>

<template>
  <div class="user-card">
    <span>{{ index + 1 }}. {{ user.name }}</span>
    <span v-if="isFirst">(First User)</span>
  </div>
</template>
```

## Why Explicit Props?

1. **Clear data flow**: Makes dependencies explicit and traceable
2. **Reusability**: Components work anywhere, not just inside specific v-for loops
3. **Type safety**: Props can be validated with type and required checks
4. **Maintainability**: Easier to understand what data a component needs

## Reference
- [Vue.js List Rendering - v-for with Components](https://vuejs.org/guide/essentials/list.html#v-for-with-a-component)
