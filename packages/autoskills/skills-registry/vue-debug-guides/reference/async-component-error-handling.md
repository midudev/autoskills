# Async Component Error Handling

## Rule

Always configure error handling for async components using `errorComponent` and/or `onError` callback. Without proper error handling, failed component loads can leave the UI in an undefined state with no user feedback.

## Why This Matters

Network failures, timeouts, and server errors are common in production. Without error handling, users see blank spaces or broken UIs with no indication of what went wrong or how to recover.

## Bad Code

```vue
<script setup>
import { defineAsyncComponent } from 'vue'

// No error handling - fails silently
const AsyncWidget = defineAsyncComponent(() =>
  import('./Widget.vue')
)
</script>
```

```vue
<script setup>
import { defineAsyncComponent } from 'vue'

// isLoading never becomes false on error - infinite spinner
const isLoading = ref(true)
const Widget = defineAsyncComponent({
  loader: () => import('./Widget.vue').finally(() => {
    isLoading.value = false  // Only runs on success
  })
})
</script>
```

## Good Code

```vue
<script setup>
import { defineAsyncComponent } from 'vue'
import LoadingSpinner from './LoadingSpinner.vue'
import ErrorDisplay from './ErrorDisplay.vue'

const AsyncWidget = defineAsyncComponent({
  loader: () => import('./Widget.vue'),
  loadingComponent: LoadingSpinner,
  errorComponent: ErrorDisplay,
  delay: 200,    // Prevent loading flicker
  timeout: 10000 // Show error after 10 seconds
})
</script>
```

```vue
<script setup>
import { defineAsyncComponent } from 'vue'

// With retry logic using onError
const AsyncWidget = defineAsyncComponent({
  loader: () => import('./Widget.vue'),
  loadingComponent: LoadingSpinner,
  errorComponent: ErrorDisplay,
  onError(error, retry, fail, attempts) {
    if (attempts <= 3) {
      // Retry up to 3 times
      retry()
    } else {
      // Give up and show error component
      fail()
    }
  }
})
</script>
```

```vue
<script setup>
import { defineAsyncComponent } from 'vue'

// Fallback component pattern - catch in loader
const AsyncWidget = defineAsyncComponent(() =>
  import('./Widget.vue').catch(() => import('./WidgetFallback.vue'))
)
</script>
```

## onError Callback Parameters

The `onError` callback receives four arguments:

| Parameter | Type | Description |
|-----------|------|-------------|
| `error` | `Error` | The error that caused the load to fail |
| `retry` | `Function` | Call to retry loading the component |
| `fail` | `Function` | Call to give up and show errorComponent |
| `attempts` | `number` | Number of load attempts so far |

## Key Points

1. Always provide an `errorComponent` for production applications
2. Use `timeout` to prevent indefinite loading states
3. Consider retry logic with `onError` for transient network issues
4. The `delay` option (default 200ms) prevents loading flicker on fast networks
5. Use the fallback pattern (`.catch()` in loader) when you want a seamless degradation

## SSR Warning

Using `onError` with SSR can cause issues in some configurations, potentially leading to infinite loading. Test thoroughly in SSR environments.

## References

- [Vue.js Async Components Documentation](https://vuejs.org/guide/components/async)
- [Handling Async Components' loading errors](https://awad.dev/blog/handling-async-component-loading-errors/)
