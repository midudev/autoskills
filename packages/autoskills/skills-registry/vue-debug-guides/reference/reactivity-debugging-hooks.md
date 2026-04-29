---
title: Use Debug Hooks to Trace Reactivity Issues
impact: MEDIUM
impactDescription: Debug hooks help identify which dependencies trigger re-renders and watcher executions
type: efficiency
tags: [vue3, reactivity, debugging, computed, watch, development]
---

# Use Debug Hooks to Trace Reactivity Issues

**Impact: MEDIUM** - Vue provides debug hooks (`onTrack`, `onTrigger`, `renderTracked`, `renderTriggered`) that help identify exactly which reactive dependencies are being tracked and which mutations trigger re-execution. These are invaluable for debugging performance issues and unexpected re-renders.

Debug hooks only work in development mode and are stripped in production builds. Use them to understand why a computed property, watcher, or component is re-executing.

## Task Checklist

- [ ] Use `onTrack` and `onTrigger` options on computed/watch for granular debugging
- [ ] Use `onRenderTracked` and `onRenderTriggered` lifecycle hooks for component render debugging
- [ ] Add `debugger` statements inside hooks to pause execution and inspect state
- [ ] Remove or comment out debug hooks before production (they're no-ops but add clutter)

> **Note:** `onTrack` and `onTrigger` are development-only hooks. They are stripped from production builds and may not fire in test environments (e.g., Vitest, Jest) depending on how Vue is bundled. If you need to verify reactivity behavior in tests, use direct assertions on reactive state changes rather than relying on these debug callbacks.

**Debugging computed properties:**
```javascript
import { ref, computed } from 'vue'

const count = ref(0)
const doubled = computed(() => count.value * 2, {
  onTrack(event) {
    // Called when a dependency is tracked
    // event.target = the reactive object
    // event.key = the property being accessed
    debugger
    console.log('Tracking:', event)
  },
  onTrigger(event) {
    // Called when a dependency mutation triggers re-computation
    debugger
    console.log('Triggered by:', event)
  }
})
```

**Debugging watchers:**
```javascript
import { ref, watch, watchEffect } from 'vue'

const source = ref(0)

// With watch()
watch(source, (newVal, oldVal) => {
  console.log('Changed:', oldVal, '->', newVal)
}, {
  onTrack(e) {
    debugger // Pause to see what's being tracked
  },
  onTrigger(e) {
    debugger // Pause to see what triggered the watcher
  }
})

// With watchEffect()
watchEffect(() => {
  console.log('Source is:', source.value)
}, {
  onTrack(e) {
    console.log('Tracking dependency:', e.key)
  },
  onTrigger(e) {
    console.log('Triggered by:', e.key, 'mutation')
  }
})
```

**Debugging component renders:**
```vue
<script setup>
import { onRenderTracked, onRenderTriggered, ref } from 'vue'

const count = ref(0)

// Called for every reactive dependency accessed during render
onRenderTracked((event) => {
  console.log('Render tracked:', event.key, 'from', event.target)
  debugger // Pause to inspect which dependencies are tracked
})

// Called when a reactive dependency triggers re-render
onRenderTriggered((event) => {
  console.log('Render triggered by:', event.key)
  console.log('Old value:', event.oldValue)
  console.log('New value:', event.newValue)
  debugger // Pause to see exactly what caused the re-render
})
</script>
```

**Options API equivalent:**
```javascript
export default {
  data() {
    return { count: 0 }
  },
  renderTracked(event) {
    console.log('Dependency tracked during render:', event)
    debugger
  },
  renderTriggered(event) {
    console.log('Re-render triggered by:', event)
    debugger
  }
}
```

**Debug event properties:**
```javascript
// The event object contains:
{
  effect: ReactiveEffect,  // The effect being debugged
  target: object,          // The reactive object
  type: 'get' | 'set' | 'add' | 'delete' | 'clear',
  key: string | symbol,    // The property being accessed/mutated
  oldValue: any,           // Previous value (for onTrigger)
  newValue: any            // New value (for onTrigger)
}
```

## Reference
- [Vue.js Reactivity in Depth - Debugging](https://vuejs.org/guide/extras/reactivity-in-depth.html#reactivity-debugging)
- [Vue.js computed() API](https://vuejs.org/api/reactivity-core.html#computed)
- [Vue.js onRenderTracked()](https://vuejs.org/api/composition-api-lifecycle.html#onrendertracked)
