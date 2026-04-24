---
title: Suspense Overrides Async Component Loading and Error Options
impact: MEDIUM
impactDescription: Async component loading/error options are ignored under a parent Suspense, leading to missing spinners and error UIs
type: gotcha
tags: [vue3, suspense, async-components, loading, error-handling]
---

# Suspense Overrides Async Component Loading and Error Options

**Impact: MEDIUM** - When an async component renders inside a parent `<Suspense>`, its `loadingComponent`, `errorComponent`, `delay`, and `timeout` options do not run. The parent Suspense controls loading and error UX instead.

## Task Checklist

- [ ] Confirm whether the async component is inside a `<Suspense>` boundary
- [ ] Use `suspensible: false` when the component must manage its own loading/error UI
- [ ] Or move loading/error UI to the parent `<Suspense>` fallback and an error boundary (`onErrorCaptured`)
- [ ] Provide a retry path for failed loads

**Incorrect:**
```vue
<script setup>
import { defineAsyncComponent } from 'vue'

const AsyncDashboard = defineAsyncComponent({
  loader: () => import('./Dashboard.vue'),
  loadingComponent: LoadingSpinner,
  errorComponent: ErrorDisplay,
  timeout: 3000
})
</script>

<template>
  <Suspense>
    <AsyncDashboard />
    <template #fallback>Loading...</template>
  </Suspense>
</template>
```

**Correct (component handles its own states):**
```vue
<script setup>
import { defineAsyncComponent } from 'vue'

const AsyncDashboard = defineAsyncComponent({
  loader: () => import('./Dashboard.vue'),
  loadingComponent: LoadingSpinner,
  errorComponent: ErrorDisplay,
  timeout: 3000,
  suspensible: false
})
</script>

<template>
  <AsyncDashboard />
</template>
```

**Correct (parent Suspense owns loading/error UI):**
```vue
<script setup>
import { onErrorCaptured, ref } from 'vue'
import AsyncDashboard from './AsyncDashboard.vue'

const error = ref(null)

onErrorCaptured((err) => {
  error.value = err
  return false
})
</script>

<template>
  <ErrorDisplay v-if="error" :error="error" />

  <Suspense v-else>
    <AsyncDashboard />
    <template #fallback>
      <LoadingSpinner />
    </template>
  </Suspense>
</template>
```
