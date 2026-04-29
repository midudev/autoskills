---
title: Unmount Hooks May Not Fire Inside Transitions During Fast Replacement
impact: MEDIUM
impactDescription: Components inside transitions can be destroyed without unmount hooks firing under race conditions
type: gotcha
tags: [vue3, lifecycle, transition, onUnmounted, unmounted, cleanup, race-condition]
---

# Unmount Hooks May Not Fire Inside Transitions During Fast Replacement

**Impact: MEDIUM** - When a component inside a `<transition>` is replaced by another component during the transition's loading phase, the unmount hooks (`onBeforeUnmount`, `onUnmounted`) may not be called even though the component is removed from the DOM. This can cause memory leaks and resource leaks from unclean side effects.

This is a known edge case that occurs when the timing is specific - if a parent component with a child inside a transition is replaced while the child is still mounting. The child's mount hooks fire, but unmount hooks never do.

## Task Checklist

- [ ] Be aware that unmount hooks are not 100% guaranteed inside transitions
- [ ] For critical cleanup, consider alternative cleanup strategies
- [ ] Use `mode="out-in"` on transitions to ensure old component fully unmounts before new mounts
- [ ] For essential resources, consider cleanup at parent component level
- [ ] Test component replacement scenarios during development

**Problematic Scenario:**
```vue
<!-- Parent component with lazy-loaded child in transition -->
<template>
  <transition>
    <Suspense>
      <component :is="currentComponent" />
    </Suspense>
  </transition>
</template>
```

```javascript
// Child component - unmount hooks may not fire if parent changes quickly
export default {
  setup() {
    const socket = new WebSocket('wss://example.com')

    onMounted(() => {
      console.log('Mounted - this will run')
      socket.connect()
    })

    onUnmounted(() => {
      // WARNING: This may NOT run if component is inside transition
      // and parent navigates away during mounting phase!
      console.log('Unmounted - might not run')
      socket.close()
    })
  }
}
```

**Safer Patterns:**
```vue
<!-- SAFER: Use out-in mode to ensure proper sequencing -->
<template>
  <transition mode="out-in">
    <component :is="currentComponent" :key="currentKey" />
  </transition>
</template>
```

```javascript
// SAFER: Cleanup at parent level for critical resources
// Parent component
export default {
  setup() {
    const childSocket = ref(null)

    // Parent controls resource lifecycle
    provide('registerSocket', (socket) => {
      childSocket.value = socket
    })

    onUnmounted(() => {
      // Parent ensures cleanup even if child unmount hook doesn't fire
      childSocket.value?.close()
    })
  }
}

// Child component
export default {
  setup() {
    const registerSocket = inject('registerSocket')
    const socket = new WebSocket('wss://example.com')

    // Register with parent for backup cleanup
    registerSocket(socket)

    onMounted(() => {
      socket.connect()
    })

    onUnmounted(() => {
      socket.close() // Still attempt cleanup here
    })
  }
}
```

```javascript
// SAFER: Use AbortController pattern for cancellable operations
export default {
  setup() {
    const abortController = new AbortController()

    onMounted(() => {
      fetch('/api/data', { signal: abortController.signal })
        .then(handleData)
        .catch(err => {
          if (err.name !== 'AbortError') {
            handleError(err)
          }
        })
    })

    onUnmounted(() => {
      // If this doesn't fire, request continues but response is ignored
      // Not a memory leak - just potentially wasted network call
      abortController.abort()
    })
  }
}
```

## Testing for This Issue

```javascript
// Test by rapidly switching components during async loading
async function testUnmountHooks() {
  // Mount component A (has async setup)
  await mountComponent('A')

  // Immediately switch to B before A finishes mounting
  await mountComponent('B')

  // Check if A's unmount hooks fired
  // They may not have!
}
```

## Reference
- [Vue.js GitHub Issue #6260](https://github.com/vuejs/core/issues/6260)
- [Vue.js Transition](https://vuejs.org/guide/built-ins/transition.html)
- [Vue.js Lifecycle Hooks](https://vuejs.org/guide/essentials/lifecycle.html)
