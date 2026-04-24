---
title: Use Deep Selectors for Styling Child Component Elements
impact: HIGH
impactDescription: Scoped styles cannot target elements inside child components without deep selectors, leading to silently broken styles
type: gotcha
tags: [vue3, sfc, scoped-css, deep-selector, child-components]
---

# Use Deep Selectors for Styling Child Component Elements

**Impact: HIGH** - When using scoped CSS in Vue SFCs, styles do not penetrate into child components. Without using deep selectors (`:deep()`), your styles will silently fail to apply to elements rendered by child components or third-party libraries.

## Task Checklist

- [ ] Use `:deep()` selector to style elements inside child components
- [ ] Never use deprecated `>>>` or `/deep/` selectors (Vue 3 only supports `:deep()`)
- [ ] Scope deep selectors to a parent class when possible to limit impact
- [ ] Consider using unscoped styles or CSS modules for heavily nested styling

**Problematic Code:**
```vue
<template>
  <div class="container">
    <ThirdPartyDatePicker />
  </div>
</template>

<style scoped>
/* BAD: These styles won't apply to elements inside ThirdPartyDatePicker */
.container .date-input {
  border-color: blue;
}

.container .calendar-popup {
  background: white;
}
</style>
```

**Correct Code:**
```vue
<template>
  <div class="container">
    <ThirdPartyDatePicker />
  </div>
</template>

<style scoped>
/* GOOD: Use :deep() to style child component elements */
.container :deep(.date-input) {
  border-color: blue;
}

.container :deep(.calendar-popup) {
  background: white;
}

/* Also correct: deep selector at root level */
:deep(.date-picker-wrapper) {
  padding: 1rem;
}
</style>
```

## How Scoped CSS Works

Vue scoped CSS adds a unique data attribute to all elements in the component's template and appends it to CSS selectors:

```vue
<!-- Template output -->
<div class="container" data-v-7ba5bd90>
  <!-- Child component elements DON'T get data-v-7ba5bd90 -->
  <div class="date-input">...</div>
</div>
```

```css
/* Generated scoped CSS */
.container[data-v-7ba5bd90] .date-input[data-v-7ba5bd90] { ... }
/* ^ This won't match because .date-input doesn't have the attribute */
```

## Vue 3 Deep Selector Syntax

```vue
<style scoped>
/* Vue 3 recommended syntax */
.parent :deep(.child-class) {
  color: red;
}

/* DEPRECATED - don't use these in Vue 3 */
.parent >>> .child-class { }   /* Won't work in SCSS */
.parent /deep/ .child-class { } /* Deprecated */
.parent ::v-deep .child-class { } /* Old syntax */
</style>
```

## Scoping Deep Selectors for Safety

Always scope `:deep()` to a parent selector to limit its reach:

```vue
<style scoped>
/* BAD: Affects ALL .btn elements in child components globally */
:deep(.btn) {
  background: blue;
}

/* GOOD: Only affects .btn inside .my-component */
.my-component :deep(.btn) {
  background: blue;
}
</style>
```

## Child Component Root Element Exception

Note: A child component's root element IS affected by parent scoped CSS. This is intentional for layout purposes:

```vue
<!-- Parent.vue -->
<template>
  <ChildComponent class="styled-child" />
</template>

<style scoped>
/* This WILL work - targets child's root element */
.styled-child {
  margin: 1rem;
  border: 1px solid gray;
}
</style>
```

## Performance Consideration

Using `:deep()` with element selectors can be slower:

```vue
<style scoped>
/* SLOWER: Element selector with deep */
.container :deep(p) {
  color: red;
}

/* FASTER: Class selector with deep */
.container :deep(.paragraph) {
  color: red;
}
</style>
```

## Reference
- [Vue.js Scoped CSS - Deep Selectors](https://vuejs.org/api/sfc-css-features.html#deep-selectors)
- [Vue Loader Scoped CSS](https://vue-loader.vuejs.org/guide/scoped-css.html)
