---
title: KeepAlive with Nested Routes Double Mount Issue
impact: HIGH
impactDescription: Using KeepAlive with nested Vue Router routes can cause child components to mount twice
type: gotcha
tags: [vue3, keepalive, vue-router, nested-routes, double-mount, bug]
---

# KeepAlive with Nested Routes Double Mount Issue

**Impact: HIGH** - When using `<KeepAlive>` with nested Vue Router routes, child route components may mount twice. This is a known issue that can cause duplicate API calls, broken state, and confusing behavior.

## Task Checklist

- [ ] Test nested routes thoroughly when using KeepAlive
- [ ] Avoid mixing KeepAlive with deeply nested route structures
- [ ] Use workarounds if double mount is observed
- [ ] Consider alternative caching strategies for nested routes

## The Problem

```vue
<!-- App.vue -->
<template>
  <router-view v-slot="{ Component }">
    <KeepAlive>
      <component :is="Component" />
    </KeepAlive>
  </router-view>
</template>
```

```javascript
// router.js
const routes = [
  {
    path: '/parent',
    component: Parent,
    children: [
      {
        path: 'child',
        component: Child  // This may mount TWICE!
      }
    ]
  }
]
```

**Symptoms:**
- `onMounted` called twice in child component
- Duplicate API requests
- State initialization runs twice
- Console logs appear doubled

## Diagnosis

Add logging to confirm the issue:

```vue
<!-- Child.vue -->
<script setup>
import { onMounted, onActivated } from 'vue'

let mountCount = 0

onMounted(() => {
  mountCount++
  console.log('Child mounted - count:', mountCount)
  // If you see "count: 2", you have the double mount issue
})

onActivated(() => {
  console.log('Child activated')
})
</script>
```

## Workarounds

### Option 1: Use `useActivatedRoute` Pattern

Don't use `useRoute()` directly with KeepAlive:

```vue
<script setup>
import { ref, onActivated } from 'vue'
import { useRoute } from 'vue-router'

// Problem: useRoute() can cause issues with KeepAlive
// const route = useRoute()

// Solution: Get route info in onActivated
const routeParams = ref({})

onActivated(() => {
  const route = useRoute()
  routeParams.value = { ...route.params }
})
</script>
```

### Option 2: Avoid KeepAlive for Nested Route Parents

Only cache leaf routes, not parent layouts:

```vue
<script setup>
import { computed } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()

// Only cache specific leaf routes
const cachedRoutes = computed(() => {
  // Don't cache parent routes that have children
  return ['UserProfile', 'UserSettings'] // Only leaf components
})
</script>

<template>
  <router-view v-slot="{ Component, route: currentRoute }">
    <KeepAlive :include="cachedRoutes">
      <component :is="Component" :key="currentRoute.fullPath" />
    </KeepAlive>
  </router-view>
</template>
```

### Option 3: Guard Against Double Initialization

Protect your component from double mount effects:

```vue
<script setup>
import { ref, onMounted } from 'vue'

const isInitialized = ref(false)

onMounted(() => {
  if (isInitialized.value) {
    console.warn('Double mount detected, skipping initialization')
    return
  }
  isInitialized.value = true

  // Safe to initialize
  fetchData()
  setupEventListeners()
})
</script>
```

### Option 4: Use Route-Level Cache Control

```vue
<!-- App.vue -->
<script setup>
import { computed } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()

// Define which routes should be cached in route meta
const shouldCache = computed(() => {
  return route.meta.keepAlive !== false
})
</script>

<template>
  <router-view v-slot="{ Component }">
    <KeepAlive v-if="shouldCache">
      <component :is="Component" />
    </KeepAlive>
    <component v-else :is="Component" />
  </router-view>
</template>
```

```javascript
// router.js
const routes = [
  {
    path: '/parent',
    component: Parent,
    meta: { keepAlive: false }, // Don't cache parent routes
    children: [
      {
        path: 'child',
        component: Child,
        meta: { keepAlive: true } // Cache leaf routes
      }
    ]
  }
]
```

### Option 5: Flatten Route Structure

Avoid nesting if possible:

```javascript
// Instead of nested routes
const routes = [
  // Flat structure avoids the issue
  { path: '/users', component: UserList },
  { path: '/users/:id', component: UserDetail },
  { path: '/users/:id/settings', component: UserSettings }
]
```

## Key Points

1. **Known Vue Router issue** - Double mount with KeepAlive + nested routes
2. **Watch for symptoms** - Duplicate API calls, doubled logs
3. **Avoid caching parent routes** - Only cache leaf components
4. **Add initialization guards** - Protect against double execution
5. **Test thoroughly** - This issue may not appear immediately

## Reference
- [Vue Router Issue #626: keep-alive in nested route mounted twice](https://github.com/vuejs/router/issues/626)
- [GitHub: vue3-keep-alive-component workaround](https://github.com/emiyalee1005/vue3-keep-alive-component)
- [Vue.js KeepAlive Documentation](https://vuejs.org/guide/built-ins/keep-alive.html)
