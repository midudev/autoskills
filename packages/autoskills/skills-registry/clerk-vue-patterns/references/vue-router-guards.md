# Vue Router Guards

For plain Vue (without Nuxt), protect routes using navigation guards.

## Global Before Guard

```ts
// router/index.ts
import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/', component: Home },
    { path: '/sign-in', component: SignIn },
    { path: '/dashboard', component: Dashboard, meta: { requiresAuth: true } },
  ],
})

router.beforeEach(async (to) => {
  if (!to.meta.requiresAuth) return true

  const { userId } = useAuth()

  if (!userId.value) return '/sign-in'
  return true
})
```

## Per-Route Guard with In-Component Guard

```vue
<script setup lang="ts">
import { useAuth } from '@clerk/vue'
import { useRouter } from 'vue-router'
import { watchEffect } from 'vue'

const { isSignedIn, isLoaded } = useAuth()
const router = useRouter()

watchEffect(() => {
  if (isLoaded.value && !isSignedIn.value) {
    router.replace('/sign-in')
  }
})
</script>
```

## Org-Gated Route

```ts
router.beforeEach(async (to) => {
  if (!to.meta.requiresOrg) return true

  const { userId } = useAuth()
  const { organization } = useOrganization()

  if (!userId.value) return '/sign-in'
  if (!organization.value) return '/select-org'
  return true
})
```

## CRITICAL

- Call composables outside of the guard function body if possible — `useAuth()` is reactive and works outside components in Vue 3 (when called in setup context or at module level after plugin install)
- `isLoaded` must be true before trusting `isSignedIn` — guard may fire before Clerk initializes
- For Nuxt, prefer `middleware/` instead of manual router guards
