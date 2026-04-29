# Do Not Use defineAsyncComponent with Vue Router

## Rule

Never use `defineAsyncComponent` when configuring Vue Router route components. Vue Router has its own lazy loading mechanism using dynamic imports directly.

## Why This Matters

Vue Router's lazy loading is specifically designed for route-level code splitting. Using `defineAsyncComponent` for routes adds unnecessary overhead and can cause unexpected behavior with navigation guards, loading states, and route transitions.

## Bad Code

```javascript
import { defineAsyncComponent } from 'vue'
import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/dashboard',
      // WRONG: Don't use defineAsyncComponent here
      component: defineAsyncComponent(() =>
        import('./views/Dashboard.vue')
      )
    },
    {
      path: '/profile',
      // WRONG: This also won't work as expected
      component: defineAsyncComponent({
        loader: () => import('./views/Profile.vue'),
        loadingComponent: LoadingSpinner
      })
    }
  ]
})
```

## Good Code

```javascript
import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/dashboard',
      // CORRECT: Use dynamic import directly
      component: () => import('./views/Dashboard.vue')
    },
    {
      path: '/profile',
      // CORRECT: Simple arrow function with import
      component: () => import('./views/Profile.vue')
    }
  ]
})
```

## Handling Loading States with Vue Router

For route-level loading states, use Vue Router's navigation guards or a global loading indicator:

```vue
<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const isLoading = ref(false)

router.beforeEach(() => {
  isLoading.value = true
})

router.afterEach(() => {
  isLoading.value = false
})
</script>

<template>
  <LoadingBar v-if="isLoading" />
  <RouterView />
</template>
```

## When to Use defineAsyncComponent

Use `defineAsyncComponent` for:
- Components loaded conditionally within a page
- Heavy components that aren't always needed
- Modal dialogs or panels that load on demand

Use Vue Router's lazy loading for:
- Route-level components (views/pages)
- Any component configured in route definitions

## Key Points

1. Vue Router and `defineAsyncComponent` are separate lazy loading mechanisms
2. Route components should use direct dynamic imports: `() => import('./View.vue')`
3. Use navigation guards for route-level loading indicators
4. `defineAsyncComponent` is for component-level lazy loading within pages

## References

- [Vue Router Lazy Loading Routes](https://router.vuejs.org/guide/advanced/lazy-loading.html)
- [Vue.js Async Components Documentation](https://vuejs.org/guide/components/async)
