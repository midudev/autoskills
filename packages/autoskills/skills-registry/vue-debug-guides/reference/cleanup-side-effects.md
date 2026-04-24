---
title: Clean Up Event Listeners and Intervals in onUnmounted
impact: HIGH
impactDescription: Failing to clean up side effects causes memory leaks and ghost event handlers
type: capability
tags: [vue3, lifecycle, memory-leak, event-listeners, intervals, cleanup]
---

# Clean Up Event Listeners and Intervals in onUnmounted

**Impact: HIGH** - Failing to clean up event listeners, intervals, timeouts, and subscriptions when a component unmounts causes memory leaks and ghost handlers that continue running, leading to performance degradation and subtle bugs in Single Page Applications.

When using custom events, timers, WebSocket connections, or third-party libraries, always clean up in `onUnmounted` (Composition API) or `unmounted` (Options API).

## Task Checklist

- [ ] Track all addEventListener calls and remove them in onUnmounted
- [ ] Clear all setInterval and setTimeout calls in onUnmounted
- [ ] Unsubscribe from external event emitters and observables
- [ ] Disconnect WebSocket connections and third-party library instances
- [ ] Use `onBeforeUnmount` if cleanup must happen before DOM removal

**Incorrect:**
```javascript
// Composition API - WRONG: No cleanup
import { onMounted } from 'vue'

export default {
  setup() {
    onMounted(() => {
      // These keep running after component unmounts!
      window.addEventListener('resize', handleResize)
      setInterval(pollServer, 5000)
      socket.on('message', handleMessage)
    })
  }
}
```

```javascript
// Options API - WRONG: No cleanup
export default {
  mounted() {
    window.addEventListener('scroll', this.handleScroll)
    this.timer = setInterval(this.refresh, 10000)
  }
  // Component unmounts, but listeners and timers persist!
}
```

**Correct:**
```javascript
// Composition API - CORRECT: Proper cleanup
import { onMounted, onUnmounted, ref } from 'vue'

export default {
  setup() {
    const intervalId = ref(null)

    const handleResize = () => {
      // handle resize
    }

    const handleMessage = (msg) => {
      // handle message
    }

    onMounted(() => {
      window.addEventListener('resize', handleResize)
      intervalId.value = setInterval(pollServer, 5000)
      socket.on('message', handleMessage)
    })

    onUnmounted(() => {
      // Clean up everything!
      window.removeEventListener('resize', handleResize)

      if (intervalId.value) {
        clearInterval(intervalId.value)
      }

      socket.off('message', handleMessage)
    })
  }
}
```

```javascript
// Options API - CORRECT: Proper cleanup
export default {
  data() {
    return {
      timer: null
    }
  },
  mounted() {
    window.addEventListener('scroll', this.handleScroll)
    this.timer = setInterval(this.refresh, 10000)
  },
  unmounted() {
    window.removeEventListener('scroll', this.handleScroll)
    if (this.timer) {
      clearInterval(this.timer)
    }
  },
  methods: {
    handleScroll() { /* ... */ },
    refresh() { /* ... */ }
  }
}
```

## Using Composable Pattern for Auto-Cleanup

```javascript
// Reusable composable with automatic cleanup
import { onMounted, onUnmounted } from 'vue'

export function useEventListener(target, event, handler) {
  onMounted(() => {
    target.addEventListener(event, handler)
  })

  onUnmounted(() => {
    target.removeEventListener(event, handler)
  })
}

export function useInterval(callback, delay) {
  let intervalId = null

  onMounted(() => {
    intervalId = setInterval(callback, delay)
  })

  onUnmounted(() => {
    if (intervalId) clearInterval(intervalId)
  })
}

// Usage - cleanup is automatic
import { useEventListener, useInterval } from './composables'

export default {
  setup() {
    useEventListener(window, 'resize', handleResize)
    useInterval(pollServer, 5000)
    // No manual cleanup needed!
  }
}
```

## VueUse Alternative

```javascript
// VueUse provides cleanup-aware composables
import { useEventListener, useIntervalFn } from '@vueuse/core'

export default {
  setup() {
    // Automatically cleaned up on unmount
    useEventListener(window, 'resize', handleResize)

    const { pause, resume } = useIntervalFn(pollServer, 5000)
    // Also provides pause/resume controls
  }
}
```

## Reference
- [Vue.js Lifecycle Hooks](https://vuejs.org/guide/essentials/lifecycle.html)
- [VueUse - useEventListener](https://vueuse.org/core/useEventListener/)
