---
title: TransitionGroup FLIP Animations Do Not Work With Inline Elements
impact: MEDIUM
impactDescription: Move animations silently fail on inline elements, causing items to jump
type: gotcha
tags: [vue3, transition-group, animation, flip, css, display, inline-block]
---

# TransitionGroup FLIP Animations Do Not Work With Inline Elements

**Impact: MEDIUM** - The FLIP (First, Last, Invert, Play) animation technique that Vue uses for `<TransitionGroup>` move transitions does not work with elements that have `display: inline`. The move animation will silently fail, and items will jump to their new positions instead of smoothly transitioning.

This is a CSS limitation, not a Vue bug. CSS transforms (which FLIP uses internally) do not apply to inline elements per the CSS specification.

## Task Checklist

- [ ] Ensure list items are not `display: inline` elements
- [ ] Use `display: inline-block` or `display: block` for list items
- [ ] Use flexbox or grid containers which make children block-level
- [ ] Check if inherited styles are setting `display: inline`

**Incorrect - Inline elements break move animations:**
```vue
<template>
  <!-- BROKEN: span elements are inline by default -->
  <TransitionGroup name="tag" tag="div" class="tag-container">
    <span v-for="tag in tags" :key="tag.id" class="tag">
      {{ tag.name }}
    </span>
  </TransitionGroup>
</template>

<style>
.tag-move {
  transition: transform 0.3s ease;
  /* This won't work because spans are inline! */
}
</style>
```

**Correct - Use inline-block:**
```vue
<template>
  <TransitionGroup name="tag" tag="div" class="tag-container">
    <span v-for="tag in tags" :key="tag.id" class="tag">
      {{ tag.name }}
    </span>
  </TransitionGroup>
</template>

<style>
.tag {
  display: inline-block; /* REQUIRED for FLIP animations */
}

.tag-move {
  transition: transform 0.3s ease;
}
</style>
```

**Correct - Use flexbox container:**
```vue
<template>
  <TransitionGroup name="tag" tag="div" class="tag-container">
    <span v-for="tag in tags" :key="tag.id" class="tag">
      {{ tag.name }}
    </span>
  </TransitionGroup>
</template>

<style>
.tag-container {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

/* Flex children are block-level, FLIP works automatically */
.tag-move {
  transition: transform 0.3s ease;
}
</style>
```

**Correct - Use block elements:**
```vue
<template>
  <!-- div elements are block by default -->
  <TransitionGroup name="item" tag="div">
    <div v-for="item in items" :key="item.id" class="item">
      {{ item.name }}
    </div>
  </TransitionGroup>
</template>

<style>
.item-move {
  transition: transform 0.3s ease;
}
</style>
```

## Why Inline Elements Don't Work

Per CSS specifications, the `transform` property does not apply to inline boxes. Since FLIP animations use CSS transforms to animate element positions:

```css
/* Vue internally applies something like this during move */
.item {
  transform: translateX(-50px) translateY(-20px);
  /* Then transitions to transform: none */
}
```

This transform is ignored on inline elements, so no animation occurs.

## Elements That Are Inline by Default

Be aware of these common inline elements that need `display: inline-block`:

- `<span>`
- `<a>`
- `<em>`, `<strong>`, `<i>`, `<b>`
- `<code>`, `<kbd>`
- `<label>`
- `<button>` (inline-block by default, but verify)

## Move Animations Also Require Transform Transition

The `.move` class must have `transform` in its `transition` property:

```css
/* CORRECT */
.list-move {
  transition: transform 0.3s ease;
}

/* ALSO CORRECT */
.list-move {
  transition: all 0.3s ease; /* 'all' includes transform */
}

/* WRONG - transform not included */
.list-move {
  transition: opacity 0.3s ease; /* Move won't animate! */
}
```

## Reference
- [Vue.js TransitionGroup Move Transitions](https://vuejs.org/guide/built-ins/transition-group.html#move-transitions)
- [MDN CSS Transform - Formal Definition](https://developer.mozilla.org/en-US/docs/Web/CSS/transform#formal_definition)
