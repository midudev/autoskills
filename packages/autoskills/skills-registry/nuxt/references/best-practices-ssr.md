---
name: ssr-best-practices
description: Avoiding SSR context leaks, hydration mismatches, and proper composable usage
---

# SSR Best Practices

Patterns for avoiding common SSR pitfalls: context leaks, hydration mismatches, and composable errors.

## The "Nuxt Instance Unavailable" Error

This error occurs when calling Nuxt composables outside the proper context.

### ❌ Wrong: Composable Outside Setup

```ts
// composables/bad.ts
// Called at module level - no Nuxt context!
const config = useRuntimeConfig()

export function useMyComposable() {
  return config.public.apiBase
}
```

### ✅ Correct: Composable Inside Function

```ts
// composables/good.ts
export function useMyComposable() {
  // Called inside the composable - has context
  const config = useRuntimeConfig()
  return config.public.apiBase
}
```

### Valid Contexts for Composables

Nuxt composables work in:
- `<script setup>` blocks
- `setup()` function
- `defineNuxtPlugin()` callbacks
- `defineNuxtRouteMiddleware()` callbacks

```ts
// ✅ Plugin
export default defineNuxtPlugin(() => {
  const config = useRuntimeConfig() // Works
})

// ✅ Middleware
export default defineNuxtRouteMiddleware(() => {
  const route = useRoute() // Works
})
```

## Avoid State Leaks Between Requests

### ❌ Wrong: Module-level State

```ts
// composables/bad.ts
// This state is SHARED between all requests on server!
const globalState = ref({ user: null })

export function useUser() {
  return globalState
}
```

### ✅ Correct: Use useState

```ts
// composables/good.ts
export function useUser() {
  // useState creates request-isolated state
  return useState('user', () => ({ user: null }))
}
```

### Why This Matters

On the server, module-level state persists across requests, causing:
- Data leaking between users
- Security vulnerabilities
- Memory leaks

## Hydration Mismatch Prevention

Hydration mismatches occur when server HTML differs from client render.

### ❌ Wrong: Browser APIs in Setup

```vue
<script setup>
// localStorage doesn't exist on server!
const theme = localStorage.getItem('theme') || 'light'
</script>
```

### ✅ Correct: Use SSR-safe Alternatives

```vue
<script setup>
// useCookie works on both server and client
const theme = useCookie('theme', { default: () => 'light' })
</script>
```

### ❌ Wrong: Random/Time-based Values

```vue
<template>
  <div>{{ Math.random() }}</div>
  <div>{{ new Date().toLocaleTimeString() }}</div>
</template>
```

### ✅ Correct: Use useState for Consistency

```vue
<script setup>
// Value is generated once on server, hydrated on client
const randomValue = useState('random', () => Math.random())
</script>

<template>
  <div>{{ randomValue }}</div>
</template>
```

### ❌ Wrong: Conditional Rendering on Client State

```vue
<template>
  <!-- window doesn't exist on server -->
  <div v-if="window?.innerWidth > 768">Desktop</div>
</template>
```

### ✅ Correct: Use CSS or ClientOnly

```vue
<template>
  <!-- CSS media queries work on both -->
  <div class="hidden md:block">Desktop</div>
  <div class="md:hidden">Mobile</div>

  <!-- Or use ClientOnly for JS-dependent rendering -->
  <ClientOnly>
    <ResponsiveComponent />
    <template #fallback>Loading...</template>
  </ClientOnly>
</template>
```

## Browser-only Code

### Use `import.meta.client`

```vue
<script setup>
if (import.meta.client) {
  // Only runs in browser
  window.addEventListener('scroll', handleScroll)
}
</script>
```

### Use `onMounted` for DOM Access

```vue
<script setup>
const el = ref<HTMLElement>()

onMounted(() => {
  // Safe - only runs on client after hydration
  el.value?.focus()
  initThirdPartyLib()
})
</script>
```

### Dynamic Imports for Browser Libraries

```vue
<script setup>
onMounted(async () => {
  const { Chart } = await import('chart.js')
  new Chart(canvas.value, config)
})
</script>
```

## Server-only Code

### Use `import.meta.server`

```vue
<script setup>
if (import.meta.server) {
  // Only runs on server
  const secrets = useRuntimeConfig().apiSecret
}
</script>
```

### Server Components

```vue
<!-- components/ServerData.server.vue -->
<script setup>
// This entire component only runs on server
const data = await fetchSensitiveData()
</script>

<template>
  <div>{{ data }}</div>
</template>
```

## Async Composable Patterns

### ❌ Wrong: Await Before Composable

```vue
<script setup>
await someAsyncOperation()
const route = useRoute() // May fail - context lost after await
</script>
```

### ✅ Correct: Get Context First

```vue
<script setup>
// Get all composables before any await
const route = useRoute()
const config = useRuntimeConfig()

await someAsyncOperation()
// Now safe to use route and config
</script>
```

## Plugin Best Practices

### Client-only Plugins

```ts
// plugins/analytics.client.ts
export default defineNuxtPlugin(() => {
  // Only runs on client
  initAnalytics()
})
```

### Server-only Plugins

```ts
// plugins/server-init.server.ts
export default defineNuxtPlugin(() => {
  // Only runs on server
  initServerConnections()
})
```

### Provide/Inject Pattern

```ts
// plugins/api.ts
export default defineNuxtPlugin(() => {
  const api = createApiClient()

  return {
    provide: {
      api,
    },
  }
})
```

```vue
<script setup>
const { $api } = useNuxtApp()
const data = await $api.get('/users')
</script>
```

## Third-party Library Integration

### ❌ Wrong: Import at Top Level

```vue
<script setup>
import SomeLibrary from 'browser-only-lib' // Breaks SSR
</script>
```

### ✅ Correct: Dynamic Import

```vue
<script setup>
let library: typeof import('browser-only-lib')

onMounted(async () => {
  library = await import('browser-only-lib')
  library.init()
})
</script>
```

### Use ClientOnly Component

```vue
<template>
  <ClientOnly>
    <BrowserOnlyComponent />
    <template #fallback>
      <div class="skeleton">Loading...</div>
    </template>
  </ClientOnly>
</template>
```

## Debugging SSR Issues

### Check Rendering Context

```vue
<script setup>
console.log('Server:', import.meta.server)
console.log('Client:', import.meta.client)
</script>
```

### Use Nuxt DevTools

DevTools shows payload data and hydration state.

### Common Error Messages

| Error | Cause |
|-------|-------|
| "Nuxt instance unavailable" | Composable called outside setup context |
| "Hydration mismatch" | Server/client HTML differs |
| "window is not defined" | Browser API used during SSR |
| "document is not defined" | DOM access during SSR |

<!-- 
Source references:
- https://nuxt.com/docs/guide/concepts/auto-imports#vue-and-nuxt-composables
- https://nuxt.com/docs/guide/best-practices/hydration
- https://nuxt.com/docs/getting-started/state-management#best-practices
-->
