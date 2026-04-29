---
title: Specify Explicit Duration for Nested Transitions
impact: MEDIUM
impactDescription: Nested transitions with different timings may end prematurely when Vue detects only the root element's transition end
type: gotcha
tags: [vue3, transition, animation, duration, nested, timing]
---

# Specify Explicit Duration for Nested Transitions

**Impact: MEDIUM** - When transitioning elements that contain nested child elements with different animation timings, Vue by default listens only for the first `transitionend` or `animationend` event on the **root** transition element. This means if inner elements have longer or delayed animations, they may be cut off when the root element's transition completes.

## Task Checklist

- [ ] Identify if your transition contains nested elements with different animation durations
- [ ] Use the `:duration` prop to specify the total time Vue should wait
- [ ] Consider using separate enter and leave durations if they differ
- [ ] Test animations to ensure nested elements complete fully

**Problematic Code:**
```vue
<template>
  <!-- BAD: Inner element has longer animation that gets cut off -->
  <Transition name="nested">
    <div v-if="show" class="outer">
      <div class="inner">Hello</div>
    </div>
  </Transition>
</template>

<style>
.nested-enter-active .outer,
.nested-leave-active .outer {
  transition: opacity 0.3s ease;
}

.nested-enter-active .inner,
.nested-leave-active .inner {
  /* This 0.5s animation gets cut off at 0.3s when outer finishes! */
  transition: transform 0.5s ease 0.2s; /* 0.2s delay + 0.5s = 0.7s total */
}

.nested-enter-from .outer,
.nested-leave-to .outer {
  opacity: 0;
}

.nested-enter-from .inner,
.nested-leave-to .inner {
  transform: translateX(-30px);
}
</style>
```

**Correct Code:**
```vue
<template>
  <!-- GOOD: Explicit duration ensures all nested animations complete -->
  <Transition name="nested" :duration="700">
    <div v-if="show" class="outer">
      <div class="inner">Hello</div>
    </div>
  </Transition>
</template>

<style>
.nested-enter-active .outer,
.nested-leave-active .outer {
  transition: opacity 0.3s ease;
}

.nested-enter-active .inner,
.nested-leave-active .inner {
  /* Now this animation completes fully */
  transition: transform 0.5s ease 0.2s;
}

.nested-enter-from .outer,
.nested-leave-to .outer {
  opacity: 0;
}

.nested-enter-from .inner,
.nested-leave-to .inner {
  transform: translateX(-30px);
}
</style>
```

## Different Enter and Leave Durations

```vue
<template>
  <!-- GOOD: Separate durations for enter and leave -->
  <Transition
    name="complex"
    :duration="{ enter: 500, leave: 800 }"
  >
    <div v-if="show" class="container">
      <h1 class="title">Title</h1>
      <p class="content">Content with staggered animation</p>
    </div>
  </Transition>
</template>

<style>
/* Enter: title first, then content */
.complex-enter-active .title {
  transition: opacity 0.3s ease, transform 0.3s ease;
}

.complex-enter-active .content {
  transition: opacity 0.3s ease 0.2s, transform 0.3s ease 0.2s;
}

/* Leave: content first, then title (reverse order) */
.complex-leave-active .content {
  transition: opacity 0.3s ease, transform 0.3s ease;
}

.complex-leave-active .title {
  transition: opacity 0.5s ease 0.3s, transform 0.5s ease 0.3s;
}

.complex-enter-from .title,
.complex-enter-from .content,
.complex-leave-to .title,
.complex-leave-to .content {
  opacity: 0;
  transform: translateY(20px);
}
</style>
```

## Choreographed Staggered Animations

```vue
<template>
  <Transition name="stagger" :duration="800">
    <div v-if="show" class="card">
      <img class="card-image" src="..." />
      <h2 class="card-title">Title</h2>
      <p class="card-body">Body text...</p>
      <button class="card-action">Action</button>
    </div>
  </Transition>
</template>

<style>
/* Staggered entrance: image -> title -> body -> action */
.stagger-enter-active .card-image { transition: all 0.3s ease; }
.stagger-enter-active .card-title { transition: all 0.3s ease 0.1s; }
.stagger-enter-active .card-body { transition: all 0.3s ease 0.2s; }
.stagger-enter-active .card-action { transition: all 0.3s ease 0.3s; }
/* Total: 0.3s delay + 0.3s animation = 0.6s, but use 800ms for safety */

.stagger-enter-from .card-image,
.stagger-enter-from .card-title,
.stagger-enter-from .card-body,
.stagger-enter-from .card-action {
  opacity: 0;
  transform: translateY(10px);
}
</style>
```

## Calculating Duration

Use this formula to calculate the correct duration:
```
duration = max(delay + animation_duration) for all nested elements
```

Example:
- Element A: no delay, 300ms duration = 300ms total
- Element B: 100ms delay, 300ms duration = 400ms total
- Element C: 200ms delay, 500ms duration = 700ms total

**Required `:duration`**: 700 (or slightly higher for safety margin)

## Reference
- [Vue.js Transition - Nested Transitions](https://vuejs.org/guide/built-ins/transition.html#nested-transitions-and-explicit-transition-durations)
