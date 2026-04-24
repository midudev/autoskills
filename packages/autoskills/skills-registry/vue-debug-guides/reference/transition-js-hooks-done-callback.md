---
title: JavaScript Transition Hooks Require done() Callback with css="false"
impact: HIGH
impactDescription: Without calling done(), JavaScript-only transitions complete immediately, skipping the animation entirely
type: gotcha
tags: [vue3, transition, javascript, animation, hooks, gsap, done-callback]
---

# JavaScript Transition Hooks Require done() Callback with css="false"

**Impact: HIGH** - When using JavaScript-only transitions (with `:css="false"`), the `@enter` and `@leave` hooks **must** call the `done()` callback to signal when the animation completes. Without calling `done()`, Vue considers the transition finished immediately, causing elements to appear/disappear without animation.

This is especially important when using animation libraries like GSAP, Anime.js, or the Web Animations API.

## Task Checklist

- [ ] When using `:css="false"`, always call `done()` in `@enter` and `@leave` hooks
- [ ] Call `done()` when your JavaScript animation completes (in the `onComplete` callback)
- [ ] Remember: `done()` is optional when CSS handles the transition, but **required** with `:css="false"`
- [ ] Use `:css="false"` to prevent CSS rules from interfering with JS animations

**Problematic Code:**
```vue
<template>
  <!-- BAD: No done() callback - animation is skipped! -->
  <Transition :css="false" @enter="onEnter" @leave="onLeave">
    <div v-if="show" class="box">Content</div>
  </Transition>
</template>

<script setup>
import gsap from 'gsap'

function onEnter(el) {
  // Animation starts but Vue doesn't wait for it!
  gsap.from(el, {
    opacity: 0,
    y: 50,
    duration: 0.5
  })
  // Missing done() call - element appears with no animation
}

function onLeave(el) {
  gsap.to(el, {
    opacity: 0,
    y: -50,
    duration: 0.5
  })
  // Missing done() call - element removed immediately!
}
</script>
```

**Correct Code:**
```vue
<template>
  <!-- GOOD: done() callback signals animation completion -->
  <Transition :css="false" @enter="onEnter" @leave="onLeave">
    <div v-if="show" class="box">Content</div>
  </Transition>
</template>

<script setup>
import gsap from 'gsap'

function onEnter(el, done) {
  gsap.from(el, {
    opacity: 0,
    y: 50,
    duration: 0.5,
    onComplete: done  // Tell Vue animation is complete
  })
}

function onLeave(el, done) {
  gsap.to(el, {
    opacity: 0,
    y: -50,
    duration: 0.5,
    onComplete: done  // Element removed after animation
  })
}
</script>
```

## Why Use `:css="false"`?

1. **Prevents CSS interference**: Vue won't add transition classes that might conflict
2. **Slight performance benefit**: Skips CSS transition detection
3. **Clearer intent**: Makes it explicit that JS controls the animation

```vue
<template>
  <!-- Without :css="false", Vue adds v-enter-active etc. classes -->
  <!-- These can interfere with your JS animation timing -->
  <Transition @enter="onEnter" @leave="onLeave">
    <div v-if="show">May have CSS conflicts</div>
  </Transition>

  <!-- With :css="false", no classes added - full JS control -->
  <Transition :css="false" @enter="onEnter" @leave="onLeave">
    <div v-if="show">Pure JS animation</div>
  </Transition>
</template>
```

## Complete JavaScript Transition Example

```vue
<template>
  <Transition
    :css="false"
    @before-enter="onBeforeEnter"
    @enter="onEnter"
    @after-enter="onAfterEnter"
    @enter-cancelled="onEnterCancelled"
    @before-leave="onBeforeLeave"
    @leave="onLeave"
    @after-leave="onAfterLeave"
    @leave-cancelled="onLeaveCancelled"
  >
    <div v-if="show" class="animated-box">Content</div>
  </Transition>
</template>

<script setup>
import gsap from 'gsap'
import { ref } from 'vue'

const show = ref(false)
let enterAnimation = null
let leaveAnimation = null

function onBeforeEnter(el) {
  // Set initial state before animation
  el.style.opacity = 0
  el.style.transform = 'translateY(50px)'
}

function onEnter(el, done) {
  // Store animation reference for potential cancellation
  enterAnimation = gsap.to(el, {
    opacity: 1,
    y: 0,
    duration: 0.5,
    ease: 'power2.out',
    onComplete: done  // REQUIRED with :css="false"
  })
}

function onAfterEnter(el) {
  // Cleanup after enter completes
  enterAnimation = null
}

function onEnterCancelled() {
  // Handle interruption (e.g., user toggles quickly)
  if (enterAnimation) {
    enterAnimation.kill()
    enterAnimation = null
  }
}

function onBeforeLeave(el) {
  // Set state before leaving
}

function onLeave(el, done) {
  leaveAnimation = gsap.to(el, {
    opacity: 0,
    y: -50,
    duration: 0.5,
    ease: 'power2.in',
    onComplete: done  // REQUIRED with :css="false"
  })
}

function onAfterLeave(el) {
  leaveAnimation = null
}

function onLeaveCancelled() {
  if (leaveAnimation) {
    leaveAnimation.kill()
    leaveAnimation = null
  }
}
</script>
```

## Using Web Animations API

```vue
<script setup>
function onEnter(el, done) {
  const animation = el.animate([
    { opacity: 0, transform: 'scale(0.9)' },
    { opacity: 1, transform: 'scale(1)' }
  ], {
    duration: 300,
    easing: 'ease-out'
  })

  animation.onfinish = done  // Call done when animation ends
}

function onLeave(el, done) {
  const animation = el.animate([
    { opacity: 1, transform: 'scale(1)' },
    { opacity: 0, transform: 'scale(0.9)' }
  ], {
    duration: 300,
    easing: 'ease-in'
  })

  animation.onfinish = done
}
</script>
```

## Common Mistakes

```javascript
// WRONG: Calling done() immediately instead of after animation
function onEnter(el, done) {
  gsap.from(el, { opacity: 0, duration: 0.5 })
  done() // Called immediately - animation skipped!
}

// WRONG: Forgetting done() parameter
function onEnter(el) {  // No 'done' parameter
  gsap.from(el, {
    opacity: 0,
    onComplete: done  // Error: done is not defined!
  })
}

// CORRECT: Pass done to animation callback
function onEnter(el, done) {
  gsap.from(el, {
    opacity: 0,
    duration: 0.5,
    onComplete: done  // Called after 0.5s
  })
}
```

## Reference
- [Vue.js Transition - JavaScript Hooks](https://vuejs.org/guide/built-ins/transition.html#javascript-hooks)
- [GSAP with Vue](https://gsap.com/resources/vue/)
