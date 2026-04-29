---
title: Use markRaw() for Objects That Should Never Be Reactive
impact: MEDIUM
impactDescription: Library instances, DOM nodes, and complex objects cause overhead and bugs when wrapped in Vue proxies
type: efficiency
tags: [vue3, reactivity, markRaw, performance, external-libraries, dom]
---

# Use markRaw() for Objects That Should Never Be Reactive

**Impact: MEDIUM** - Vue's `markRaw()` tells the reactivity system to never wrap an object in a Proxy. Use it for library instances, DOM nodes, class instances with internal state, and complex objects that Vue shouldn't track. This prevents unnecessary proxy overhead and avoids subtle bugs from double-proxying.

Without `markRaw()`, placing these objects inside reactive state causes Vue to wrap them in Proxies, which can break library internals, cause identity issues, and waste memory on objects that don't need change tracking.

## Task Checklist

- [ ] Use `markRaw()` for third-party library instances (maps, charts, editors)
- [ ] Use `markRaw()` for DOM elements stored in reactive state
- [ ] Use `markRaw()` for class instances that manage their own state
- [ ] Use `markRaw()` for large static data that will never change
- [ ] Remember: markRaw only affects the root level - nested objects may still be proxied

**Incorrect:**
```javascript
import { reactive, ref } from 'vue'
import mapboxgl from 'mapbox-gl'
import * as monaco from 'monaco-editor'

// WRONG: Library instances wrapped in Proxy
const state = reactive({
  map: new mapboxgl.Map({ container: 'map' }),  // Proxied!
  editor: monaco.editor.create(element, {}),    // Proxied!
})

// Problems:
// 1. Library's internal this references may break
// 2. Unnecessary memory overhead
// 3. Methods may not work correctly through proxy
// 4. Performance degradation

// WRONG: DOM elements in reactive state
const elements = reactive({
  container: document.getElementById('app'),  // Proxied DOM node!
})
```

**Correct:**
```javascript
import { reactive, markRaw, shallowRef } from 'vue'
import mapboxgl from 'mapbox-gl'
import * as monaco from 'monaco-editor'

// CORRECT: Mark library instances as raw
const state = reactive({
  map: markRaw(new mapboxgl.Map({ container: 'map' })),
  editor: markRaw(monaco.editor.create(element, {})),
})

// CORRECT: Or use shallowRef for mutable references
const map = shallowRef(null)
onMounted(() => {
  map.value = markRaw(new mapboxgl.Map({ container: 'map' }))
})

// CORRECT: Large static data
const geoJsonData = markRaw(await fetch('/huge-geojson.json').then(r => r.json()))
const state = reactive({
  mapData: geoJsonData  // Won't be proxied
})
```

**Class instances with internal state:**
```javascript
import { markRaw, reactive } from 'vue'

class WebSocketManager {
  constructor(url) {
    this.socket = new WebSocket(url)
    this.listeners = new Map()
  }

  on(event, callback) {
    this.listeners.set(event, callback)
  }
}

// CORRECT: Mark class instance
const wsManager = markRaw(new WebSocketManager('ws://example.com'))

const state = reactive({
  connection: wsManager  // Won't be proxied
})

// Can still use the instance normally
state.connection.on('message', handleMessage)
```

**Gotcha: markRaw only affects root level:**
```javascript
import { markRaw, reactive } from 'vue'

const rawObject = markRaw({
  nested: { value: 1 }  // This nested object is NOT marked raw
})

const state = reactive({
  data: rawObject
})

// rawObject itself won't be proxied
// But if you access nested objects through a reactive parent:
const container = reactive({ raw: rawObject })
// container.raw.nested might still be proxied in some cases

// SAFER: Use shallowRef for the container
import { shallowRef } from 'vue'
const safeContainer = shallowRef(rawObject)
```

**Combining with shallowRef for best results:**
```javascript
import { shallowRef, markRaw, onMounted, onUnmounted } from 'vue'

// Pattern: shallowRef + markRaw for external library instances
export function useMapbox(containerId) {
  const map = shallowRef(null)

  onMounted(() => {
    const instance = new mapboxgl.Map({
      container: containerId,
      style: 'mapbox://styles/mapbox/streets-v11'
    })

    // Mark raw to prevent any proxy wrapping
    map.value = markRaw(instance)
  })

  onUnmounted(() => {
    map.value?.remove()
  })

  return { map }
}
```

## Reference
- [Vue.js markRaw() API](https://vuejs.org/api/reactivity-advanced.html#markraw)
- [Vue.js Reducing Reactivity Overhead](https://vuejs.org/guide/best-practices/performance.html#reduce-reactivity-overhead-for-large-immutable-structures)
- [Vue.js Reactivity in Depth](https://vuejs.org/guide/extras/reactivity-in-depth.html)
