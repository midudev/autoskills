# Suspense Has No Built-in Error Handling

## Rule

`<Suspense>` does not provide error handling via the component itself. You must implement error handling using `errorCaptured` option or `onErrorCaptured()` hook in a parent component to catch async errors.

## Why This Matters

Without explicit error handling, async errors in suspended components will propagate uncaught, potentially crashing the application or leaving users stuck on loading states. Unlike React's Error Boundaries, Vue's Suspense requires manual error boundary implementation.

## Bad Code

```vue
<script setup>
// No error handling - async errors will propagate uncaught
</script>

<template>
  <Suspense>
    <AsyncComponent />
    <template #fallback>
      Loading...
    </template>
  </Suspense>
</template>
```

## Good Code

```vue
<script setup>
import { ref, onErrorCaptured } from 'vue'
import AsyncComponent from './AsyncComponent.vue'

const error = ref(null)

onErrorCaptured((err) => {
  error.value = err
  return false // Prevent error from propagating further
})
</script>

<template>
  <div v-if="error" class="error-state">
    <p>Something went wrong: {{ error.message }}</p>
    <button @click="error = null">Retry</button>
  </div>

  <Suspense v-else>
    <AsyncComponent />
    <template #fallback>
      Loading...
    </template>
  </Suspense>
</template>
```

## Reusable Error Boundary Pattern

```vue
<!-- ErrorBoundary.vue -->
<script setup>
import { ref, onErrorCaptured } from 'vue'

const props = defineProps({
  fallback: {
    type: String,
    default: 'Something went wrong'
  }
})

const emit = defineEmits(['error'])

const error = ref(null)

onErrorCaptured((err, instance, info) => {
  error.value = { err, instance, info }
  emit('error', { err, instance, info })
  return false
})

const reset = () => {
  error.value = null
}

defineExpose({ reset })
</script>

<template>
  <slot v-if="!error" />
  <slot v-else name="error" :error="error" :reset="reset">
    <div class="error-boundary">
      {{ fallback }}
      <button @click="reset">Retry</button>
    </div>
  </slot>
</template>
```

```vue
<!-- Usage -->
<template>
  <ErrorBoundary @error="logError">
    <Suspense>
      <AsyncDashboard />
      <template #fallback>Loading dashboard...</template>
    </Suspense>

    <template #error="{ error, reset }">
      <DashboardError :error="error" @retry="reset" />
    </template>
  </ErrorBoundary>
</template>
```

## Key Points

1. Always wrap `<Suspense>` with error handling logic in production
2. Use `onErrorCaptured` for Composition API or `errorCaptured` option for Options API
3. Return `false` from the error handler to stop propagation
4. Consider creating a reusable `ErrorBoundary` component to reduce boilerplate
5. Provide a way for users to retry failed operations

## References

- [Vue.js Suspense Documentation](https://vuejs.org/guide/built-ins/suspense#error-handling)
- [Vue.js onErrorCaptured](https://vuejs.org/api/composition-api-lifecycle#onerrorcaptured)
