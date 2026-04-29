---
title: Never Use .passive and .prevent Together
impact: HIGH
impactDescription: Conflicting modifiers cause .prevent to be ignored and trigger browser warnings
type: gotcha
tags: [vue3, events, modifiers, scroll, touch, performance]
---

# Never Use .passive and .prevent Together

**Impact: HIGH** - The `.passive` modifier tells the browser you will NOT call `preventDefault()`, while `.prevent` does exactly that. Using them together causes `.prevent` to be ignored and triggers browser console warnings. This is a logical contradiction that leads to broken event handling.

## Task Checklist

- [ ] Never combine `.passive` and `.prevent` on the same event
- [ ] Use `.passive` for scroll/touch events where you want better performance
- [ ] Use `.prevent` when you need to stop the default browser action
- [ ] If you need conditional prevention, handle it in JavaScript without `.passive`

**Incorrect:**
```html
<!-- WRONG: Conflicting modifiers -->
<template>
  <div @scroll.passive.prevent="handleScroll">
    <!-- .prevent will be IGNORED -->
    <!-- Browser shows warning -->
  </div>
</template>
```

```html
<!-- WRONG: On touch events -->
<template>
  <div @touchstart.passive.prevent="handleTouch">
    <!-- Cannot prevent default - passive already promised not to -->
  </div>
</template>
```

```html
<!-- WRONG: On wheel events -->
<template>
  <div @wheel.passive.prevent="handleWheel">
    <!-- Broken: will scroll anyway despite .prevent -->
  </div>
</template>
```

**Correct:**
```html
<!-- CORRECT: Use .passive for performance (no prevention needed) -->
<template>
  <div @scroll.passive="handleScroll">
    <!-- Good for scroll tracking without blocking -->
  </div>
</template>
```

```html
<!-- CORRECT: Use .prevent when you need to prevent default -->
<template>
  <form @submit.prevent="handleSubmit">
    <!-- Correctly prevents form submission -->
  </form>
</template>
```

```html
<!-- CORRECT: For touch events where you need to prevent -->
<template>
  <div @touchmove="handleTouchMove">
    <!-- Handle prevention conditionally in JS -->
  </div>
</template>

<script setup>
function handleTouchMove(event) {
  if (shouldPreventScroll.value) {
    event.preventDefault()
  }
  // ... handle touch
}
</script>
```

## Understanding .passive

```javascript
// .passive tells the browser:
// "I promise I won't call preventDefault()"

// This allows the browser to:
// 1. Start scrolling immediately without waiting for JS
// 2. Improve scroll performance, especially on mobile
// 3. Reduce jank and stuttering

// Equivalent to:
element.addEventListener('scroll', handler, { passive: true })
```

## When to Use .passive

```html
<!-- Good use cases for .passive -->

<!-- Scroll tracking analytics -->
<div @scroll.passive="trackScrollPosition">

<!-- Touch gesture detection (no prevention needed) -->
<div @touchmove.passive="detectGesture">

<!-- Wheel event monitoring -->
<div @wheel.passive="monitorWheel">
```

## When to Use .prevent (Without .passive)

```html
<!-- Good use cases for .prevent -->

<!-- Form submission -->
<form @submit.prevent="handleSubmit">

<!-- Link clicks with custom navigation -->
<a @click.prevent="navigate">

<!-- Preventing context menu -->
<div @contextmenu.prevent="showCustomMenu">
```

## Browser Warning

When you combine `.passive` and `.prevent`, the browser console shows:
```
[Intervention] Unable to preventDefault inside passive event listener
due to target being treated as passive.
```

## Reference
- [Vue.js Event Handling - Event Modifiers](https://vuejs.org/guide/essentials/event-handling.html#event-modifiers)
- [MDN - Improving scroll performance with passive listeners](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener#improving_scrolling_performance_with_passive_listeners)
