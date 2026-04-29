---
title: TransitionGroup Move Animation Requires Position Absolute on Leaving Items
impact: HIGH
impactDescription: Without position absolute, surrounding items jump instead of smoothly animating
type: gotcha
tags: [vue3, transition-group, animation, move-transition, css, list-animation]
---

# TransitionGroup Move Animation Requires Position Absolute on Leaving Items

**Impact: HIGH** - When items are added or removed from a list with `<TransitionGroup>`, surrounding items will instantly "jump" to their new positions instead of smoothly animating. This creates a jarring user experience and is one of the most common mistakes with list animations.

The fix is to set `position: absolute` on the `leave-active` class so leaving items are taken out of the layout flow, allowing other items to smoothly animate into their new positions.

## Task Checklist

- [ ] Add `.list-move` class (or `.[name]-move`) for smooth repositioning
- [ ] Set `position: absolute` on `.list-leave-active` class
- [ ] Ensure the parent container has `position: relative` if needed
- [ ] Test with rapid add/remove operations to verify smooth animations

**Incorrect - Items jump instead of moving:**
```vue
<template>
  <TransitionGroup name="list" tag="ul">
    <li v-for="item in items" :key="item.id">
      {{ item.name }}
    </li>
  </TransitionGroup>
</template>

<style>
/* INCOMPLETE: Missing move class and position absolute */
.list-enter-active,
.list-leave-active {
  transition: all 0.5s ease;
}

.list-enter-from,
.list-leave-to {
  opacity: 0;
  transform: translateX(30px);
}
</style>
```

**Correct - Smooth move transitions:**
```vue
<template>
  <TransitionGroup name="list" tag="ul">
    <li v-for="item in items" :key="item.id">
      {{ item.name }}
    </li>
  </TransitionGroup>
</template>

<style>
/* CORRECT: Full set of classes for smooth animations */

/* Apply transition to moving elements */
.list-move,
.list-enter-active,
.list-leave-active {
  transition: all 0.5s ease;
}

.list-enter-from,
.list-leave-to {
  opacity: 0;
  transform: translateX(30px);
}

/* CRITICAL: Take leaving items out of layout flow */
.list-leave-active {
  position: absolute;
}
</style>
```

## Why This Works

The FLIP animation technique Vue uses internally needs to calculate element positions. When an item leaves:

1. Without `position: absolute`: The leaving item still occupies space in the DOM
2. Other items can't move until the leaving item is fully removed
3. Result: Items snap to new positions after leave animation completes

With `position: absolute`:

1. Leaving item is removed from normal layout flow immediately
2. Other items can begin moving into the vacated space
3. Result: Leaving animation and move animation happen simultaneously

## Visual Diagram

```
Without position: absolute:
[A] [B] [C] [D]  <- Remove B
[A]     [C] [D]  <- B fading out, C/D waiting
[A] [C] [D]      <- B gone, C/D jump instantly

With position: absolute:
[A] [B] [C] [D]  <- Remove B
[A][B][C] [D]    <- B fading (absolute), C/D sliding left
[A] [C] [D]      <- Smooth completion
```

## Additional Considerations

**Container Width:** When using `position: absolute`, items may need explicit widths:

```css
.list-leave-active {
  position: absolute;
  width: 100%; /* Or specific width to maintain layout during leave */
}
```

**Stacking Context:** Leaving items with `position: absolute` may stack above other elements:

```css
.list-leave-active {
  position: absolute;
  z-index: -1; /* Optional: put behind other items */
}
```

## Reference
- [Vue.js TransitionGroup Move Transitions](https://vuejs.org/guide/built-ins/transition-group.html#move-transitions)
- [FLIP Animation Technique](https://aerotwist.com/blog/flip-your-animations/)
