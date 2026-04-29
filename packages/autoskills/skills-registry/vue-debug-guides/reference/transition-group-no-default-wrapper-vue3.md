---
title: TransitionGroup No Longer Renders Default Wrapper Element in Vue 3
impact: MEDIUM
impactDescription: Vue 2 to Vue 3 migration may break layouts relying on the default span wrapper
type: gotcha
tags: [vue3, transition-group, migration, vue2, breaking-change, wrapper-element]
---

# TransitionGroup No Longer Renders Default Wrapper Element in Vue 3

**Impact: MEDIUM** - In Vue 2, `<transition-group>` always rendered a wrapper element (default `<span>`), but in Vue 3, it renders no wrapper element by default thanks to fragment support. This breaking change can cause layout issues and broken styles when migrating from Vue 2.

If your code relies on the wrapper element for styling or layout, you must explicitly specify the `tag` prop in Vue 3.

## Task Checklist

- [ ] When migrating from Vue 2, add explicit `tag` prop to all `<TransitionGroup>` components
- [ ] Review CSS selectors that targeted the wrapper element
- [ ] Update parent component styles that expected a wrapper element
- [ ] Consider if the wrapper element is actually needed in Vue 3

**Vue 2 Behavior (wrapper element by default):**
```vue
<template>
  <transition-group name="list">
    <div v-for="item in items" :key="item.id">{{ item }}</div>
  </transition-group>
</template>

<!-- Renders as: -->
<span>  <!-- Default wrapper in Vue 2 -->
  <div>Item 1</div>
  <div>Item 2</div>
</span>
```

**Vue 3 Behavior (no wrapper by default):**
```vue
<template>
  <TransitionGroup name="list">
    <div v-for="item in items" :key="item.id">{{ item }}</div>
  </TransitionGroup>
</template>

<!-- Renders as (fragment): -->
<div>Item 1</div>
<div>Item 2</div>
<!-- No wrapper element! -->
```

**Vue 3 - Explicitly specify wrapper:**
```vue
<template>
  <!-- Use tag prop to specify wrapper element -->
  <TransitionGroup name="list" tag="ul">
    <li v-for="item in items" :key="item.id">{{ item }}</li>
  </TransitionGroup>
</template>

<!-- Renders as: -->
<ul>
  <li>Item 1</li>
  <li>Item 2</li>
</ul>
```

## Migration Scenarios

### Layout Depending on Wrapper

**Vue 2 code that breaks in Vue 3:**
```vue
<template>
  <transition-group class="grid-container" name="list">
    <div v-for="item in items" :key="item.id">{{ item }}</div>
  </transition-group>
</template>

<style>
.grid-container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
}
</style>
```

In Vue 3, the class is not applied to anything because there's no wrapper element.

**Fixed for Vue 3:**
```vue
<template>
  <TransitionGroup class="grid-container" name="list" tag="div">
    <div v-for="item in items" :key="item.id">{{ item }}</div>
  </TransitionGroup>
</template>
```

### Semantic HTML Lists

**Vue 2:**
```vue
<transition-group tag="ul" name="list">
  <li v-for="item in items" :key="item.id">{{ item }}</li>
</transition-group>
```

**Vue 3 (same syntax, but now tag is more important):**
```vue
<TransitionGroup tag="ul" name="list">
  <li v-for="item in items" :key="item.id">{{ item }}</li>
</TransitionGroup>
```

### When You Don't Need a Wrapper

Vue 3's fragment support means you might not need a wrapper at all:

```vue
<template>
  <div class="parent-with-styles">
    <!-- No tag needed if parent handles layout -->
    <TransitionGroup name="fade">
      <span v-for="item in items" :key="item.id">{{ item }}</span>
    </TransitionGroup>
  </div>
</template>

<style>
.parent-with-styles {
  display: flex;
  gap: 8px;
}
</style>
```

## In-DOM Template Syntax

When using in-DOM templates (not SFCs), remember to use kebab-case:

```html
<!-- In-DOM template -->
<transition-group tag="ul" name="list">
  <li v-for="item in items" :key="item.id">{{ item }}</li>
</transition-group>

<!-- NOT -->
<TransitionGroup tag="ul" name="list">  <!-- Won't work in DOM templates -->
```

## Reference
- [Vue 3 Migration Guide - TransitionGroup Root Element](https://v3-migration.vuejs.org/breaking-changes/transition-group.html)
- [Vue.js TransitionGroup](https://vuejs.org/guide/built-ins/transition-group.html)
