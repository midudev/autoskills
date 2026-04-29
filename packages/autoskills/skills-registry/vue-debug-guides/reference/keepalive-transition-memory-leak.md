---
title: KeepAlive with Transition Memory Leak
impact: MEDIUM
impactDescription: Combining KeepAlive with Transition can cause memory leaks in certain Vue versions
type: gotcha
tags: [vue3, keepalive, transition, memory-leak, animation]
---

# KeepAlive with Transition Memory Leak

**Impact: MEDIUM** - There is a known memory leak when using `<Transition>` and `<KeepAlive>` together. Component instances may not be properly freed from memory when combining these features.

## Task Checklist

- [ ] Test memory behavior when using KeepAlive + Transition together
- [ ] Consider if transition animation is necessary with cached components
- [ ] Use browser DevTools Memory tab to verify no leak
- [ ] Keep Vue updated to get latest bug fixes

## The Problem

```vue
<template>
  <!-- Known memory leak combination in some Vue versions -->
  <Transition name="fade">
    <KeepAlive>
      <component :is="currentView" />
    </KeepAlive>
  </Transition>
</template>
```

When switching between components repeatedly:
- Component instances accumulate in memory
- References prevent garbage collection
- Memory usage grows with each switch

## Diagnosis

Use Chrome DevTools to detect the leak:

1. Open DevTools > Memory tab
2. Take heap snapshot
3. Switch between components 10+ times
4. Take another heap snapshot
5. Compare: look for growing VueComponent count

## Workarounds

### Option 1: Remove Transition if Not Essential

```vue
<template>
  <!-- No memory leak without Transition -->
  <KeepAlive :max="5">
    <component :is="currentView" />
  </KeepAlive>
</template>
```

### Option 2: Use CSS Animations Instead

```vue
<template>
  <KeepAlive :max="5">
    <component
      :is="currentView"
      :class="{ 'fade-enter': isTransitioning }"
    />
  </KeepAlive>
</template>

<style>
.fade-enter {
  animation: fadeIn 0.3s ease-in;
}

@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}
</style>
```

### Option 3: Use Strict Cache Limits

If you must use both, minimize impact with strict limits:

```vue
<template>
  <Transition name="fade" mode="out-in">
    <KeepAlive :max="3">
      <component :is="currentView" />
    </KeepAlive>
  </Transition>
</template>
```

### Option 4: Key-Based Cache Invalidation

Force fresh instances when needed:

```vue
<script setup>
import { ref, computed } from 'vue'

const currentView = ref('Dashboard')
const cacheKey = ref(0)

function switchViewFresh(view) {
  currentView.value = view
  cacheKey.value++ // Force new instance
}
</script>

<template>
  <Transition name="fade" mode="out-in">
    <KeepAlive :max="3">
      <component :is="currentView" :key="cacheKey" />
    </KeepAlive>
  </Transition>
</template>
```

## Keep Vue Updated

This is a known issue tracked in Vue's GitHub repository. Memory leak fixes are periodically released, so ensure you're on the latest Vue version:

```bash
npm update vue
```

## Key Points

1. **Known issue** - Memory leaks with KeepAlive + Transition are documented
2. **Test in DevTools** - Use Memory tab to verify your specific usage
3. **Consider alternatives** - CSS animations may work without the leak
4. **Set strict `max`** - Limit cache size to cap memory impact
5. **Keep Vue updated** - Bug fixes are released periodically

## Reference
- [GitHub Issue #9842: Memory leak with transition and keep-alive](https://github.com/vuejs/vue/issues/9842)
- [GitHub Issue #9840: Memory leak with transition and keep-alive](https://github.com/vuejs/vue/issues/9840)
- [Vue.js KeepAlive Documentation](https://vuejs.org/guide/built-ins/keep-alive.html)
