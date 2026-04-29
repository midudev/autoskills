# Suspense SSR Hydration Issues and Workarounds

## Rule

`<Suspense>` has known issues with SSR hydration, particularly with async components. During initial hydration, Suspense may not properly include child components within its "cloak of suspense," leading to hydration mismatches, flickering, or runtime crashes.

## Why This Matters

In SSR applications, hydration mismatches cause:
- Visual flickering as the client re-renders
- Loss of state in affected components
- Console warnings in development (silent failures in production)
- Potential runtime crashes in edge cases
- Poor user experience, especially on slower networks

## Bad Code

```vue
<template>
  <!-- Async component directly in Suspense can fail hydration -->
  <Suspense>
    <AsyncDashboard />
    <template #fallback>
      Loading...
    </template>
  </Suspense>
</template>

<script setup>
import { defineAsyncComponent } from 'vue'

const AsyncDashboard = defineAsyncComponent(
  () => import('./Dashboard.vue')
)
</script>
```

## Good Code

### Solution 1: Wrap Async Components with Suspense

```vue
<template>
  <!-- Each async component wrapped in its own Suspense -->
  <div class="dashboard">
    <Suspense>
      <AsyncHeader />
      <template #fallback><HeaderSkeleton /></template>
    </Suspense>

    <Suspense>
      <AsyncContent />
      <template #fallback><ContentSkeleton /></template>
    </Suspense>
  </div>
</template>
```

### Solution 2: Use ClientOnly Wrapper (Nuxt/SSR Frameworks)

```vue
<template>
  <!-- Prevent SSR for problematic async components -->
  <ClientOnly>
    <Suspense>
      <AsyncDashboard />
      <template #fallback>
        Loading dashboard...
      </template>
    </Suspense>

    <template #fallback>
      <DashboardSkeleton />
    </template>
  </ClientOnly>
</template>
```

### Solution 3: Prefetch with Proper Stale Time (with TanStack Query)

```vue
<script setup>
import { useQuery, useQueryClient } from '@tanstack/vue-query'

// IMPORTANT: All useQuery calls must be BEFORE any await
const { data, suspense } = useQuery({
  queryKey: ['dashboard'],
  queryFn: fetchDashboardData,
  staleTime: 1000 * 60 * 5, // 5 minutes - prevents refetch after hydration
})

// Wait for suspense AFTER all useQuery calls
await suspense()

// Now safe to use data
</script>
```

### Solution 4: Handle Hydration Errors Gracefully

```vue
<script setup>
import { ref, onErrorCaptured, onMounted } from 'vue'

const hydrationError = ref(false)
const isClient = ref(false)

onMounted(() => {
  isClient.value = true
})

onErrorCaptured((err) => {
  if (err.message?.includes('hydration')) {
    hydrationError.value = true
    return false
  }
})
</script>

<template>
  <div v-if="hydrationError" class="hydration-recovery">
    <!-- Force client-only re-render -->
    <Suspense v-if="isClient">
      <AsyncContent />
      <template #fallback>Recovering...</template>
    </Suspense>
  </div>

  <Suspense v-else>
    <AsyncContent />
    <template #fallback>Loading...</template>
  </Suspense>
</template>
```

## Common SSR + Suspense Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| Hydration mismatch | Async chunk not loaded in time | Wrap with Suspense or use ClientOnly |
| Empty flash on Safari | Slow chunk loading | Preload critical chunks, use skeleton |
| useQuery after await error | Vue context lost after await | Put all useQuery calls before any await |
| Immediate refetch after hydration | staleTime too low | Set appropriate staleTime value |

## Key Points

1. Suspense + SSR has known edge cases - test thoroughly
2. Safari has slower chunk loading that triggers more hydration issues
3. With data-fetching libraries, ensure queries are set up before awaiting suspense
4. Consider ClientOnly wrappers for non-critical async content
5. Set appropriate staleTime to prevent unnecessary refetches after hydration
6. Use skeleton screens that match server-rendered content structure

## References

- [Vue.js Suspense Documentation](https://vuejs.org/guide/built-ins/suspense)
- [Vue Issue #6638 - Suspense hydration](https://github.com/vuejs/core/issues/6638)
- [Vue Issue #7672 - defineAsyncComponent SSR](https://github.com/vuejs/core/issues/7672)
- [TanStack Query SSR Discussion](https://github.com/TanStack/query/discussions/4870)
