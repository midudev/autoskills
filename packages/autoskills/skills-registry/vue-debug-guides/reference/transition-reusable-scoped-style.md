---
title: Avoid Scoped Styles in Reusable Transition Components
impact: MEDIUM
impactDescription: Scoped styles in transition wrapper components won't apply to slotted content, breaking the transition animation
type: gotcha
tags: [vue3, transition, scoped-css, slot, reusable-component]
---

# Avoid Scoped Styles in Reusable Transition Components

**Impact: MEDIUM** - When creating reusable transition wrapper components, using `<style scoped>` will prevent the transition CSS classes from applying to slotted content. Scoped styles only affect elements directly in the component's template, not content passed through slots. Your transition animations will silently fail.

## Task Checklist

- [ ] In reusable transition components, use `<style>` without `scoped`
- [ ] Alternatively, use unique class name prefixes to avoid global conflicts
- [ ] Or use CSS modules with `:global()` for transition classes
- [ ] Test that transitions work when component is used in different contexts

**Problematic Code:**
```vue
<!-- MyFadeTransition.vue -->
<template>
  <Transition name="my-fade">
    <slot />
  </Transition>
</template>

<!-- BAD: Scoped styles won't apply to slot content! -->
<style scoped>
.my-fade-enter-active,
.my-fade-leave-active {
  transition: opacity 0.3s ease;
}

.my-fade-enter-from,
.my-fade-leave-to {
  opacity: 0;
}
</style>
```

```vue
<!-- Parent component using the transition -->
<template>
  <MyFadeTransition>
    <div v-if="show">This won't animate!</div>
  </MyFadeTransition>
</template>

<!--
The <div> is slotted content, so .my-fade-* classes
applied by Vue won't match the scoped CSS selectors
-->
```

**Correct Code:**
```vue
<!-- MyFadeTransition.vue -->
<template>
  <Transition name="my-fade">
    <slot />
  </Transition>
</template>

<!-- GOOD: Unscoped styles apply to any element -->
<style>
.my-fade-enter-active,
.my-fade-leave-active {
  transition: opacity 0.3s ease;
}

.my-fade-enter-from,
.my-fade-leave-to {
  opacity: 0;
}
</style>
```

## Alternative: Use Unique Prefixed Class Names

To avoid global style conflicts, use distinctive prefixes:

```vue
<!-- FadeTransition.vue -->
<template>
  <Transition name="v-fade-transition">
    <slot />
  </Transition>
</template>

<style>
/* Unique prefix reduces collision risk */
.v-fade-transition-enter-active,
.v-fade-transition-leave-active {
  transition: opacity 0.3s ease;
}

.v-fade-transition-enter-from,
.v-fade-transition-leave-to {
  opacity: 0;
}
</style>
```

## Alternative: CSS Modules with :global()

```vue
<!-- FadeTransition.vue -->
<template>
  <Transition name="fade">
    <slot />
  </Transition>
</template>

<style module>
/* Use :global() for transition classes */
:global(.fade-enter-active),
:global(.fade-leave-active) {
  transition: opacity 0.3s ease;
}

:global(.fade-enter-from),
:global(.fade-leave-to) {
  opacity: 0;
}
</style>
```

## Alternative: Custom Transition Classes

Use the custom class props to apply scoped classes:

```vue
<!-- FadeTransition.vue -->
<template>
  <Transition
    :enter-active-class="$style.enterActive"
    :leave-active-class="$style.leaveActive"
    :enter-from-class="$style.enterFrom"
    :leave-to-class="$style.leaveTo"
  >
    <slot />
  </Transition>
</template>

<style module>
.enterActive,
.leaveActive {
  transition: opacity 0.3s ease;
}

.enterFrom,
.leaveTo {
  opacity: 0;
}
</style>
```

## Complete Reusable Transition Component Example

```vue
<!-- transitions/SlideTransition.vue -->
<template>
  <Transition
    name="slide"
    :mode="mode"
    :appear="appear"
    @before-enter="$emit('before-enter', $event)"
    @enter="$emit('enter', $event)"
    @after-enter="$emit('after-enter', $event)"
    @before-leave="$emit('before-leave', $event)"
    @leave="$emit('leave', $event)"
    @after-leave="$emit('after-leave', $event)"
  >
    <slot />
  </Transition>
</template>

<script setup>
defineProps({
  mode: {
    type: String,
    default: 'out-in',
    validator: (v) => ['out-in', 'in-out', ''].includes(v)
  },
  appear: {
    type: Boolean,
    default: false
  }
})

defineEmits([
  'before-enter', 'enter', 'after-enter',
  'before-leave', 'leave', 'after-leave'
])
</script>

<!-- Unscoped so styles apply to slotted content -->
<style>
.slide-enter-active,
.slide-leave-active {
  transition: transform 0.3s ease, opacity 0.3s ease;
}

.slide-enter-from {
  opacity: 0;
  transform: translateX(-20px);
}

.slide-leave-to {
  opacity: 0;
  transform: translateX(20px);
}
</style>
```

Usage:
```vue
<template>
  <SlideTransition>
    <div v-if="show" class="content">
      This will properly animate!
    </div>
  </SlideTransition>
</template>
```

## Why This Happens

Vue's scoped styles work by adding a unique data attribute (e.g., `data-v-7ba5bd90`) to elements and selectors:

```css
/* What you write */
.my-fade-enter-active { ... }

/* What Vue generates (scoped) */
.my-fade-enter-active[data-v-7ba5bd90] { ... }
```

Slotted content comes from the parent component and gets the parent's data attribute, not the transition component's attribute. So the selectors never match.

## Reference
- [Vue.js Reusable Transitions](https://vuejs.org/guide/built-ins/transition.html#reusable-transitions)
- [Vue.js Scoped CSS](https://vuejs.org/api/sfc-css-features.html#scoped-css)
