---
title: RouterView Transitions Always Apply Despite Missing appear Prop
impact: LOW
impactDescription: Initial page load with RouterView triggers transition animation even without the appear prop due to async navigation
type: gotcha
tags: [vue3, transition, vue-router, appear, initial-load, navigation]
---

# RouterView Transitions Always Apply Despite Missing appear Prop

**Impact: LOW** - When using `<Transition>` with Vue Router's `<RouterView>`, the enter transition animation runs on initial page load even if you haven't added the `appear` prop. This differs from normal Transition behavior where `appear` is required for initial render animations. This happens because Vue Router's navigations are asynchronous, causing the component to mount after the initial render.

## Task Checklist

- [ ] Be aware that RouterView transitions always animate on initial load
- [ ] If you want NO animation on initial load, you need to handle this explicitly
- [ ] Don't add `appear` prop expecting it to change behavior - it's already effectively enabled
- [ ] Consider whether initial animation is desired for your UX

**Expected Behavior (Normal Transition):**
```vue
<template>
  <!-- Without appear: No animation on initial render -->
  <Transition name="fade">
    <div v-if="show">Content</div>
  </Transition>

  <!-- With appear: Animates on initial render -->
  <Transition name="fade" appear>
    <div v-if="show">Content</div>
  </Transition>
</template>
```

**RouterView Behavior (Different!):**
```vue
<template>
  <!-- RouterView transitions ALWAYS animate on initial load -->
  <!-- The appear prop has no effect here -->
  <RouterView v-slot="{ Component }">
    <Transition name="fade">
      <component :is="Component" />
    </Transition>
  </RouterView>
</template>

<!--
On initial page load:
1. Vue renders the app
2. Router resolves the route (async)
3. Component mounts AFTER initial render
4. Enter transition triggers (as if toggled from v-if="false" to v-if="true")
-->
```

## Why This Happens

Vue Router navigations are asynchronous. The sequence is:

1. Vue application mounts with empty RouterView
2. Router resolves the initial route
3. Route component is inserted into RouterView
4. This insertion triggers the enter transition

Since the component wasn't present in the initial render and is "inserted" afterward, Vue treats it as a normal enter transition, not an initial render.

## If You Want to Disable Initial Animation

```vue
<template>
  <RouterView v-slot="{ Component }">
    <Transition :name="isInitialLoad ? '' : 'fade'" mode="out-in">
      <component :is="Component" />
    </Transition>
  </RouterView>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'

const isInitialLoad = ref(true)
const router = useRouter()

// After first navigation completes, enable transitions
router.isReady().then(() => {
  // Small delay to ensure initial render is complete
  setTimeout(() => {
    isInitialLoad.value = false
  }, 0)
})
</script>
```

## Alternative: Use CSS to Skip First Animation

```vue
<template>
  <RouterView v-slot="{ Component }">
    <Transition name="fade" mode="out-in">
      <component :is="Component" :class="{ 'skip-initial': isInitialLoad }" />
    </Transition>
  </RouterView>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const isInitialLoad = ref(true)
const router = useRouter()

router.isReady().then(() => {
  isInitialLoad.value = false
})
</script>

<style>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

/* Skip animation on initial load */
.skip-initial.fade-enter-active {
  transition: none;
}
</style>
```

## Standard RouterView Transition Pattern

If you're fine with initial animation (often desired), use the standard pattern:

```vue
<template>
  <RouterView v-slot="{ Component, route }">
    <Transition :name="route.meta.transition || 'fade'" mode="out-in">
      <component :is="Component" :key="route.path" />
    </Transition>
  </RouterView>
</template>

<style>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

/* Route-specific transitions via meta */
.slide-enter-active,
.slide-leave-active {
  transition: transform 0.3s ease;
}

.slide-enter-from {
  transform: translateX(100%);
}

.slide-leave-to {
  transform: translateX(-100%);
}
</style>
```

```javascript
// router.js
const routes = [
  {
    path: '/',
    component: Home
  },
  {
    path: '/about',
    component: About,
    meta: { transition: 'slide' }  // Custom transition for this route
  }
]
```

## Reference
- [Vue Router Transitions](https://router.vuejs.org/guide/advanced/transitions.html)
- [Vue.js Transition appear](https://vuejs.org/guide/built-ins/transition.html#transition-on-appear)
