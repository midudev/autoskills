---
title: Specify Transition Type When Mixing CSS Transitions and Animations
impact: MEDIUM
impactDescription: Vue may detect the wrong transition end event when both CSS transitions and animations are applied, causing timing issues
type: gotcha
tags: [vue3, transition, animation, css, type, timing]
---

# Specify Transition Type When Mixing CSS Transitions and Animations

**Impact: MEDIUM** - When you have both CSS transitions and CSS animations applied to the same element (for example, a Vue-triggered animation combined with a hover transition effect), Vue cannot automatically determine which end event to listen for. You must explicitly tell Vue which type to prioritize using the `type` attribute with a value of either `"animation"` or `"transition"`.

## Task Checklist

- [ ] Check if your element has both `transition` and `animation` CSS properties
- [ ] Determine which timing should control when Vue considers the transition complete
- [ ] Add `type="animation"` or `type="transition"` to the `<Transition>` component
- [ ] The type should match whichever animation/transition is longer or more important

**Problematic Code:**
```vue
<template>
  <!-- BAD: Both transition and animation present, Vue might pick wrong end event -->
  <Transition name="bounce">
    <div v-if="show" class="box">
      Hover me for additional effect
    </div>
  </Transition>
</template>

<style>
/* Vue-triggered CSS animation */
.bounce-enter-active {
  animation: bounce-in 0.5s;
}

.bounce-leave-active {
  animation: bounce-out 0.3s;
}

@keyframes bounce-in {
  0% { transform: scale(0); }
  50% { transform: scale(1.2); }
  100% { transform: scale(1); }
}

@keyframes bounce-out {
  0% { transform: scale(1); }
  100% { transform: scale(0); }
}

/* Additional hover transition on same element */
.box {
  transition: background-color 0.2s ease, box-shadow 0.2s ease;
}

.box:hover {
  background-color: #f0f0f0;
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}
</style>
```

**Correct Code:**
```vue
<template>
  <!-- GOOD: Explicitly specify that animation controls timing -->
  <Transition name="bounce" type="animation">
    <div v-if="show" class="box">
      Hover me for additional effect
    </div>
  </Transition>
</template>

<style>
/* Vue-triggered CSS animation - this is what we care about */
.bounce-enter-active {
  animation: bounce-in 0.5s;
}

.bounce-leave-active {
  animation: bounce-out 0.3s;
}

@keyframes bounce-in {
  0% { transform: scale(0); }
  50% { transform: scale(1.2); }
  100% { transform: scale(1); }
}

@keyframes bounce-out {
  0% { transform: scale(1); }
  100% { transform: scale(0); }
}

/* Additional hover transition - unrelated to Vue transition timing */
.box {
  transition: background-color 0.2s ease, box-shadow 0.2s ease;
}

.box:hover {
  background-color: #f0f0f0;
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}
</style>
```

## When to Use Each Type

### Use `type="animation"` when:
- Your enter/leave effects use `@keyframes` animations
- The animation is longer than any transitions
- You want precise control over multi-step animations

```vue
<Transition name="fancy" type="animation">
  <div v-if="show" class="animated-element" />
</Transition>

<style>
.fancy-enter-active {
  animation: fancy-entrance 1s ease-out;
}

.animated-element {
  /* This shorter transition should not affect timing */
  transition: color 0.2s;
}
</style>
```

### Use `type="transition"` when:
- Your enter/leave effects use CSS `transition` property
- You have decorative animations that shouldn't affect timing

```vue
<Transition name="slide" type="transition">
  <div v-if="show" class="sliding-element" />
</Transition>

<style>
.slide-enter-active,
.slide-leave-active {
  transition: transform 0.3s ease;
}

.slide-enter-from,
.slide-leave-to {
  transform: translateX(-100%);
}

/* Decorative infinite animation should not affect timing */
.sliding-element {
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.8; }
}
</style>
```

## Common Symptoms Without Type Specification

1. Transition ends too early (element snaps to final position)
2. Transition hangs or takes too long to complete
3. Element disappears before animation finishes
4. CSS classes remain applied after transition should be complete

## Reference
- [Vue.js Transition Documentation](https://vuejs.org/guide/built-ins/transition.html#css-based-transitions)
