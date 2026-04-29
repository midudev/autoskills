---
title: Fix "No Active Pinia" Error - Store Setup Timing
impact: HIGH
impactDescription: Using Pinia stores before app.use(pinia) causes "getActivePinia was called but there was no active Pinia" error
type: gotcha
tags: [vue3, pinia, state-management, setup, initialization, error]
---

# Fix "No Active Pinia" Error - Store Setup Timing

**Impact: HIGH** - The error "getActivePinia() was called but there was no active Pinia" is one of the most common Pinia errors. It occurs when you try to use a store before Pinia has been installed on the Vue app, causing your application to crash.

## Task Checklist

- [ ] Ensure `app.use(pinia)` is called before `app.mount()`
- [ ] Ensure `app.use(pinia)` is called before `app.use(router)` if router guards use stores
- [ ] Never call `useXxxStore()` in module-level (top-level) code
- [ ] Only call `useXxxStore()` inside setup functions, composables, or after app initialization
- [ ] Check for `<script setup>` vs `<script>` - the latter runs too early

## The Error

```
[🍍]: "getActivePinia()" was called but there was no active Pinia.
Did you forget to install pinia?
```

## Common Cause 1: Wrong Plugin Order

```javascript
// main.js - WRONG ORDER
import { createApp } from 'vue'
import { createPinia } from 'pinia'
import router from './router'  // Router uses a store in navigation guard
import App from './App.vue'

const app = createApp(App)

// WRONG: Router is installed first, but its guards use stores
app.use(router)  // Router guard calls useAuthStore() - FAILS!
app.use(createPinia())
app.mount('#app')
```

**Fix: Install Pinia first:**

```javascript
// main.js - CORRECT ORDER
import { createApp } from 'vue'
import { createPinia } from 'pinia'
import router from './router'
import App from './App.vue'

const app = createApp(App)

// CORRECT: Pinia installed before anything that uses stores
app.use(createPinia())
app.use(router)  // Now router guards can safely use stores
app.mount('#app')
```

## Common Cause 2: Store Used at Module Level

```javascript
// api.js - WRONG: Module-level store usage
import { useAuthStore } from '@/stores/auth'

// This runs immediately when the module is imported!
const authStore = useAuthStore()  // ERROR: No active Pinia yet

export function fetchUser() {
  return fetch('/api/user', {
    headers: {
      Authorization: `Bearer ${authStore.token}`
    }
  })
}
```

**Fix: Call useStore inside functions:**

```javascript
// api.js - CORRECT: Store used inside function
import { useAuthStore } from '@/stores/auth'

export function fetchUser() {
  // Store is accessed when function is called, not when module loads
  const authStore = useAuthStore()

  return fetch('/api/user', {
    headers: {
      Authorization: `Bearer ${authStore.token}`
    }
  })
}
```

## Common Cause 3: Script Tag Missing "setup"

```vue
<!-- WRONG: <script> runs before component setup -->
<script>
import { useUserStore } from '@/stores/user'

// This runs too early, before the component is set up
const userStore = useUserStore()  // ERROR!

export default {
  // ...
}
</script>
```

**Fix: Use `<script setup>` or move to setup function:**

```vue
<!-- CORRECT: <script setup> runs at the right time -->
<script setup>
import { useUserStore } from '@/stores/user'

// This runs during component setup, Pinia is active
const userStore = useUserStore()  // Works!
</script>
```

```vue
<!-- CORRECT: Options API with setup function -->
<script>
import { useUserStore } from '@/stores/user'

export default {
  setup() {
    // Called during component initialization
    const userStore = useUserStore()  // Works!
    return { userStore }
  }
}
</script>
```

## Common Cause 4: mapStores with Parentheses

```vue
<script>
import { mapStores } from 'pinia'
import { useProductsStore } from '@/stores/products'

export default {
  computed: {
    // WRONG: Called the function instead of passing it
    ...mapStores(useProductsStore())  // ERROR!
  }
}
</script>
```

**Fix: Pass the function reference, not the result:**

```vue
<script>
import { mapStores } from 'pinia'
import { useProductsStore } from '@/stores/products'

export default {
  computed: {
    // CORRECT: Pass the function without calling it
    ...mapStores(useProductsStore)  // No parentheses!
  }
}
</script>
```

## Common Cause 5: Router Guards Before Pinia

```javascript
// router/index.js - WRONG
import { createRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const router = createRouter({ /* ... */ })

// This guard is registered immediately
router.beforeEach((to) => {
  // When this runs during app startup, Pinia might not be ready
  const authStore = useAuthStore()  // May fail!

  if (to.meta.requiresAuth && !authStore.isLoggedIn) {
    return '/login'
  }
})
```

**Fix: Use lazy store access or ensure plugin order:**

```javascript
// router/index.js - CORRECT
import { createRouter } from 'vue-router'

const router = createRouter({ /* ... */ })

router.beforeEach((to) => {
  // Dynamically import to avoid module-level execution
  const { useAuthStore } = await import('@/stores/auth')
  const authStore = useAuthStore()

  if (to.meta.requiresAuth && !authStore.isLoggedIn) {
    return '/login'
  }
})

// OR ensure main.js has correct order:
// app.use(pinia)
// app.use(router)
```

## Debugging Checklist

When you see "No active Pinia":

1. **Check main.js order**: Is `app.use(pinia)` before other plugins?
2. **Search for top-level useStore calls**: Any store usage outside functions/setup?
3. **Check script tags**: Using `<script>` instead of `<script setup>`?
4. **Check mapStores usage**: Using `useStore()` instead of `useStore`?
5. **Check import chains**: Does an early import trigger store usage?

## Safe Pattern: Conditional Store Access

```javascript
// For code that might run before Pinia is ready
import { getActivePinia } from 'pinia'

export function safelyUseStore() {
  const pinia = getActivePinia()

  if (!pinia) {
    console.warn('Pinia not initialized yet')
    return null
  }

  const { useUserStore } = await import('@/stores/user')
  return useUserStore()
}
```

## Reference
- [Vue Land FAQ - No Active Pinia](https://vue-land.github.io/faq/no-active-pinia)
- [Pinia - Using a Store Outside of a Component](https://pinia.vuejs.org/core-concepts/outside-component-usage.html)
- [Pinia - Getting Started](https://pinia.vuejs.org/getting-started.html)
