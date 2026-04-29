---
title: TransitionGroup Performance with Large Lists and CSS Frameworks
impact: MEDIUM
impactDescription: TransitionGroup can cause noticeable DOM update lag when animating list changes, especially with CSS frameworks
type: gotcha
tags: [vue3, transition-group, animation, performance, list, css-framework]
---

# TransitionGroup Performance with Large Lists and CSS Frameworks

**Impact: MEDIUM** - Vue's `<TransitionGroup>` can experience significant DOM update lag when animating list changes, particularly when:
- Using CSS frameworks (Tailwind, Bootstrap, etc.)
- Performing array operations like `slice()` that change multiple items
- Working with larger lists

Without TransitionGroup, DOM updates occur instantly. With it, there can be noticeable delay before the UI reflects changes.

## Task Checklist

- [ ] For frequently updated lists, consider if transition animations are necessary
- [ ] Use CSS `content-visibility: auto` for long lists to reduce render cost
- [ ] Minimize CSS framework classes on list items during transitions
- [ ] Consider virtual scrolling for very large animated lists
- [ ] Profile with Vue DevTools to identify transition bottlenecks

**Problematic Pattern:**
```vue
<template>
  <!-- Potentially slow with large lists or complex CSS -->
  <TransitionGroup name="list" tag="ul">
    <li
      v-for="item in items"
      :key="item.id"
      class="p-4 m-2 rounded-lg shadow-md bg-gradient-to-r from-blue-500 to-purple-600
             hover:shadow-lg transition-all duration-300 ease-in-out transform hover:scale-105
             border border-gray-200 flex items-center justify-between"
    >
      {{ item.name }}
    </li>
  </TransitionGroup>
</template>

<script setup>
import { ref } from 'vue'

const items = ref([/* many items */])

// Operations like slice can cause visible lag
function removeItems() {
  items.value = items.value.slice(5)  // May lag with TransitionGroup
}
</script>

<style>
.list-move,
.list-enter-active,
.list-leave-active {
  transition: all 0.5s ease;
}
</style>
```

**Optimized Approach:**
```vue
<template>
  <!-- Simpler classes, shorter transitions -->
  <TransitionGroup name="list" tag="ul" class="relative">
    <li
      v-for="item in items"
      :key="item.id"
      class="list-item"
    >
      {{ item.name }}
    </li>
  </TransitionGroup>
</template>

<script setup>
import { ref, computed } from 'vue'

const items = ref([/* items */])

// For large batch operations, consider disabling animations temporarily
const isAnimating = ref(true)
</script>

<style>
/* Keep transition CSS simple and specific */
.list-item {
  /* Minimal styles during animation */
  padding: 1rem;
}

.list-move {
  transition: transform 0.3s ease;  /* Shorter duration */
}

.list-enter-active,
.list-leave-active {
  transition: opacity 0.2s ease, transform 0.2s ease;
}

.list-enter-from,
.list-leave-to {
  opacity: 0;
  transform: translateX(-20px);
}

/* Use will-change sparingly */
.list-enter-active {
  will-change: opacity, transform;
}

/* Absolute positioning for leaving elements prevents layout thrashing */
.list-leave-active {
  position: absolute;
  width: 100%;
}
</style>
```

## Performance Optimization Strategies

### 1. Skip Animations for Bulk Operations

```vue
<template>
  <TransitionGroup v-if="animationsEnabled" name="list" tag="ul">
    <li v-for="item in items" :key="item.id">{{ item.name }}</li>
  </TransitionGroup>

  <!-- Instant update without animations -->
  <ul v-else>
    <li v-for="item in items" :key="item.id">{{ item.name }}</li>
  </ul>
</template>

<script setup>
import { ref, nextTick } from 'vue'

const animationsEnabled = ref(true)

async function bulkUpdate(newItems) {
  // Disable animations for bulk operations
  animationsEnabled.value = false
  items.value = newItems
  await nextTick()
  animationsEnabled.value = true
}
</script>
```

### 2. Virtual Scrolling for Large Lists

```vue
<template>
  <!-- Use a virtual list library for large datasets -->
  <RecycleScroller
    :items="items"
    :item-size="50"
    key-field="id"
    v-slot="{ item }"
  >
    <div class="list-item">{{ item.name }}</div>
  </RecycleScroller>
</template>

<script setup>
import { RecycleScroller } from 'vue-virtual-scroller'
</script>
```

### 3. Reduce CSS Complexity During Transitions

```vue
<style>
/* Move complex styles to a stable wrapper */
.list-item-wrapper {
  @apply p-4 m-2 rounded-lg shadow-md bg-gradient-to-r from-blue-500 to-purple-600;
}

/* Keep animated element styles minimal */
.list-item {
  /* Only essential layout styles */
}

.list-move,
.list-enter-active,
.list-leave-active {
  /* Only animate transform/opacity - GPU accelerated */
  transition: transform 0.3s ease, opacity 0.3s ease;
}
</style>
```

### 4. Use CSS content-visibility

```css
/* For very long lists, defer rendering of off-screen items */
.list-item {
  content-visibility: auto;
  contain-intrinsic-size: 0 50px; /* Estimated height */
}
```

## When to Avoid TransitionGroup

Consider alternatives when:
- List updates are frequent (real-time data)
- List contains 100+ items
- Items have complex CSS or nested components
- Performance is critical (mobile, low-end devices)

```vue
<!-- Simple alternative: CSS-only animations on individual items -->
<ul>
  <li
    v-for="item in items"
    :key="item.id"
    class="animate-in"
  >
    {{ item.name }}
  </li>
</ul>

<style>
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(-10px); }
  to { opacity: 1; transform: translateY(0); }
}

.animate-in {
  animation: fadeIn 0.3s ease forwards;
}
</style>
```

## Reference
- [Vue.js TransitionGroup](https://vuejs.org/guide/built-ins/transition-group.html)
- [GitHub Issue: transition-group DOM update lag](https://github.com/vuejs/vue/issues/5845)
- [Vue Virtual Scroller](https://github.com/Akryum/vue-virtual-scroller)
