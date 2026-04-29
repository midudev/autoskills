---
title: Always Provide Unique Keys in v-for Loops
impact: HIGH
impactDescription: Missing or improper keys cause hard-to-debug bugs when list items have state, components, or animations
type: gotcha
tags: [vue3, v-for, list-rendering, key, state, components]
---

# Always Provide Unique Keys in v-for Loops

**Impact: HIGH** - Without proper keys, Vue cannot track element identity when lists change. This causes component state loss, incorrect animations, form input values jumping between items, and bugs that are extremely difficult to debug.

The `key` attribute tells Vue how your data relates to the DOM elements it renders. When data ordering changes (via sort, filter, add, or remove), Vue uses keys to determine what to update, remove, or create. Without unique keys, Vue reuses DOM elements in-place which can cause one item's state to incorrectly appear on another item.

## Task Checklist

- [ ] Always provide `:key` with unique, stable identifiers (database IDs, UUIDs)
- [ ] Never use array index as key - indices shift when items are added/removed
- [ ] Use primitive values only (strings or numbers) - never use objects as keys
- [ ] On `<template v-for>`, place the key on the `<template>` tag itself (Vue 3 change)
- [ ] When using components in v-for, keys are mandatory, not optional

**Incorrect:**
```html
<!-- WRONG: No key provided -->
<li v-for="item in items">{{ item.name }}</li>

<!-- WRONG: Using array index as key - shifts when list changes -->
<li v-for="(item, index) in items" :key="index">
  <input v-model="item.value" />
</li>

<!-- WRONG: Object as key -->
<li v-for="item in items" :key="item">{{ item.name }}</li>

<!-- WRONG (Vue 3): Key on child instead of template -->
<template v-for="item in items">
  <li :key="item.id">{{ item.name }}</li>
</template>
```

```javascript
// Bug demonstration: Using index as key
// Initial: ['Alice', 'Bob', 'Charlie'] at indices [0, 1, 2]
// After removing 'Bob': ['Alice', 'Charlie'] at indices [0, 1]
// Charlie now has index 1, so Vue reuses Bob's DOM/component state for Charlie!
```

**Correct:**
```html
<!-- CORRECT: Unique identifier as key -->
<li v-for="item in items" :key="item.id">
  {{ item.name }}
</li>

<!-- CORRECT: With components -->
<MyComponent
  v-for="item in items"
  :key="item.id"
  :item="item"
/>

<!-- CORRECT (Vue 3): Key on template tag -->
<template v-for="item in items" :key="item.id">
  <li>{{ item.name }}</li>
  <span>{{ item.description }}</span>
</template>

<!-- CORRECT: With stateful elements -->
<div v-for="user in users" :key="user.id">
  <input v-model="user.email" />
  <select v-model="user.role">
    <option value="admin">Admin</option>
    <option value="user">User</option>
  </select>
</div>
```

## When Keys Are Critical

Keys are absolutely required when v-for loops contain:
- Components with local state
- Form elements (`<input>`, `<select>`, `<textarea>`)
- Elements with initialization logic (mounted/created hooks)
- Animations or transitions
- Direct DOM manipulation

## Reference
- [Vue.js List Rendering - Key](https://vuejs.org/guide/essentials/list.html#maintaining-state-with-key)
- [Vue 3 Migration Guide - Key on Template](https://v3-migration.vuejs.org/breaking-changes/key-attribute)
