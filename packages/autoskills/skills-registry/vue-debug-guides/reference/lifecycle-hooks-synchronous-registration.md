---
title: Register Lifecycle Hooks Synchronously During Setup
impact: HIGH
impactDescription: Asynchronously registered lifecycle hooks will never execute
type: capability
tags: [vue3, composition-api, lifecycle, onMounted, onUnmounted, async, setup]
---

# Register Lifecycle Hooks Synchronously During Setup

**Impact: HIGH** - Lifecycle hooks registered asynchronously (e.g., inside setTimeout, after await) will never be called because Vue cannot associate them with the component instance. This leads to silent failures where expected initialization or cleanup code never runs.

In Vue 3's Composition API, lifecycle hooks like `onMounted`, `onUnmounted`, `onUpdated`, etc. must be registered synchronously during component setup. The hook registration doesn't need to be lexically inside `setup()` or `<script setup>`, but the call stack must be synchronous and originate from within setup.

## Task Checklist

- [ ] Register all lifecycle hooks at the top level of setup() or `<script setup>`
- [ ] Never register hooks inside setTimeout, setInterval, or Promise callbacks
- [ ] When calling composables that use lifecycle hooks, call them synchronously
- [ ] Hooks CAN be in external functions if called synchronously from setup

**Incorrect:**
```javascript
// WRONG: Hook registered asynchronously - will NEVER execute
import { onMounted } from 'vue'

export default {
  async setup() {
    // After await, we're in a different call stack
    const data = await fetchInitialData()

    // This hook will NOT be registered!
    onMounted(() => {
      console.log('This will never run')
    })
  }
}
```

```javascript
// WRONG: Hook registered in setTimeout - will NEVER execute
import { onMounted } from 'vue'

export default {
  setup() {
    setTimeout(() => {
      // This is asynchronous - hook won't be registered!
      onMounted(() => {
        initializeChart()
      })
    }, 100)
  }
}
```

```javascript
// WRONG: Hook registered in Promise callback
import { onMounted } from 'vue'

export default {
  setup() {
    fetchConfig().then(() => {
      // Asynchronous! This will silently fail
      onMounted(() => {
        applyConfig()
      })
    })
  }
}
```

**Correct:**
```javascript
// CORRECT: Hook registered synchronously at top level
import { onMounted, ref } from 'vue'

export default {
  setup() {
    const data = ref(null)

    // Register hook synchronously FIRST
    onMounted(async () => {
      // Async operations are fine INSIDE the hook
      data.value = await fetchInitialData()
      initializeChart()
    })

    return { data }
  }
}
```

```vue
<!-- CORRECT: <script setup> - hooks at top level -->
<script setup>
import { onMounted, onUnmounted, ref } from 'vue'

const isReady = ref(false)

// These are synchronous during script setup execution
onMounted(() => {
  isReady.value = true
})

onUnmounted(() => {
  cleanup()
})
</script>
```

```javascript
// CORRECT: Hook in external function called synchronously from setup
import { onMounted, onUnmounted } from 'vue'

function useWindowResize(callback) {
  // This is fine - it's called synchronously from setup
  onMounted(() => {
    window.addEventListener('resize', callback)
  })

  onUnmounted(() => {
    window.removeEventListener('resize', callback)
  })
}

export default {
  setup() {
    // Composable called synchronously - hooks will be registered
    useWindowResize(handleResize)
  }
}
```

## Multiple Hooks Are Allowed

```javascript
// CORRECT: You can register the same hook multiple times
import { onMounted } from 'vue'

export default {
  setup() {
    // Both will run, in order of registration
    onMounted(() => {
      initializeA()
    })

    onMounted(() => {
      initializeB()
    })
  }
}
```

## Reference
- [Vue.js Lifecycle Hooks](https://vuejs.org/guide/essentials/lifecycle.html)
- [Composition API Lifecycle Hooks](https://vuejs.org/api/composition-api-lifecycle.html)
