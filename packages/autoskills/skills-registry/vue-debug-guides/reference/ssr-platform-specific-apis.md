---
title: Guard Platform-Specific APIs in Universal SSR Code
impact: HIGH
impactDescription: Accessing browser-only APIs on server causes crashes; Node.js APIs fail in browser
type: gotcha
tags: [vue3, ssr, browser-api, nodejs, universal, isomorphic, server-side-rendering]
---

# Guard Platform-Specific APIs in Universal SSR Code

**Impact: HIGH** - SSR applications run the same code on both server (Node.js) and client (browser). Browser APIs like `window`, `document`, and `localStorage` don't exist in Node.js and will throw `ReferenceError`. Similarly, Node.js APIs like `fs` and `process` aren't available in browsers.

Universal/isomorphic code must guard platform-specific API access or use libraries that work on both platforms.

## Task Checklist

- [ ] Never access `window`, `document`, `navigator` in `setup()` or `created()`
- [ ] Move browser API access to `onMounted()` lifecycle hook
- [ ] Use `typeof window !== 'undefined'` guard when needed outside lifecycle
- [ ] Use cross-platform libraries for common functionality (fetch, storage)
- [ ] Use Nuxt's `process.client` / `process.server` guards in Nuxt projects

## Common Browser APIs That Break SSR

| API | Node.js Behavior |
|-----|-----------------|
| `window` | `ReferenceError: window is not defined` |
| `document` | `ReferenceError: document is not defined` |
| `localStorage` / `sessionStorage` | `ReferenceError` |
| `navigator` | `ReferenceError` |
| `location` | `ReferenceError` |
| `history` | `ReferenceError` |
| `alert` / `confirm` / `prompt` | `ReferenceError` |
| `requestAnimationFrame` | `ReferenceError` |
| `IntersectionObserver` | `ReferenceError` |
| `ResizeObserver` | `ReferenceError` |

**Incorrect - Crashes on Server:**
```javascript
// WRONG: These run during setup/SSR - crashes in Node.js
const width = ref(window.innerWidth)
const theme = localStorage.getItem('theme')
const userAgent = navigator.userAgent
```

```vue
<script setup>
import { ref } from 'vue'

// WRONG: Runs on server, crashes
const scrollY = ref(window.scrollY)

// WRONG: document doesn't exist on server
document.title = 'My Page'
</script>
```

**Correct - Use onMounted:**
```vue
<script setup>
import { ref, onMounted, onUnmounted } from 'vue'

// Safe defaults that work on server
const width = ref(0)
const theme = ref('light')
const scrollY = ref(0)

onMounted(() => {
  // Browser APIs only accessed after mount (client-only)
  width.value = window.innerWidth
  theme.value = localStorage.getItem('theme') || 'light'
  scrollY.value = window.scrollY

  // Event listeners safe in mounted
  window.addEventListener('resize', handleResize)
  window.addEventListener('scroll', handleScroll)
})

onUnmounted(() => {
  window.removeEventListener('resize', handleResize)
  window.removeEventListener('scroll', handleScroll)
})

function handleResize() {
  width.value = window.innerWidth
}

function handleScroll() {
  scrollY.value = window.scrollY
}
</script>
```

**Correct - Guard with typeof:**
```javascript
// When you need to check outside lifecycle hooks
function getStoredValue(key, defaultValue) {
  if (typeof window !== 'undefined' && window.localStorage) {
    return localStorage.getItem(key) ?? defaultValue
  }
  return defaultValue
}

// Composable with SSR awareness
export function useMediaQuery(query) {
  const matches = ref(false)

  // Only run on client
  if (typeof window !== 'undefined') {
    const mediaQuery = window.matchMedia(query)
    matches.value = mediaQuery.matches

    // Setup listener in lifecycle
    onMounted(() => {
      const handler = (e) => { matches.value = e.matches }
      mediaQuery.addEventListener('change', handler)
      onUnmounted(() => mediaQuery.removeEventListener('change', handler))
    })
  }

  return matches
}
```

## Nuxt.js Guards

```vue
<script setup>
// Nuxt provides process.client and process.server
if (process.client) {
  // Only runs in browser
  window.analytics.track('page_view')
}

if (process.server) {
  // Only runs on server
  console.log('Rendering on server')
}
</script>
```

```vue
<template>
  <!-- ClientOnly component for client-only rendering -->
  <ClientOnly>
    <BrowserOnlyChart :data="chartData" />
    <template #fallback>
      <ChartSkeleton />
    </template>
  </ClientOnly>
</template>
```

## Cross-Platform Libraries

Use libraries that abstract platform differences:

```javascript
// Fetch - works in both Node.js 18+ and browsers
const response = await fetch('/api/data')

// For older Node.js, use node-fetch or axios
import axios from 'axios'
const { data } = await axios.get('/api/data')
```

```javascript
// Universal cookie handling
import Cookies from 'js-cookie' // Client only
import { parse } from 'cookie' // Works both

// In Nuxt, use useCookie()
const token = useCookie('auth-token')
```

## Common Node.js APIs That Break in Browser

| API | Browser Behavior |
|-----|-----------------|
| `fs` | Module not found |
| `path` | Module not found |
| `process` (full) | Undefined or limited |
| `Buffer` | Undefined (unless polyfilled) |
| `__dirname` / `__filename` | Undefined |
| `require()` | Undefined in ES modules |

**Incorrect:**
```javascript
// WRONG: Node.js APIs in universal code
import fs from 'fs'
const config = JSON.parse(fs.readFileSync('./config.json'))
```

**Correct - Separate Server Code:**
```javascript
// server/utils.js - Server-only file
import fs from 'fs'
export function loadConfig() {
  return JSON.parse(fs.readFileSync('./config.json'))
}

// app.js - Universal code uses API instead
const config = await fetch('/api/config').then(r => r.json())
```

## Environment Detection Utility

```javascript
// utils/environment.js
export const isClient = typeof window !== 'undefined'
export const isServer = !isClient

export const isBrowser = isClient && typeof document !== 'undefined'
export const isNode = typeof process !== 'undefined' &&
                      process.versions?.node != null

// Usage
import { isClient, isServer } from '@/utils/environment'

if (isClient) {
  // Browser-specific code
}
```

## Third-Party Library Issues

Some libraries auto-access browser APIs on import:

```javascript
// WRONG: Library accesses window on import
import SomeChartLibrary from 'some-chart-library'
// ^ Crashes on server if library does: const x = window.something
```

**Correct - Dynamic Import:**
```vue
<script setup>
import { defineAsyncComponent } from 'vue'

// Dynamic import only loads on client
const Chart = defineAsyncComponent(() =>
  import('some-chart-library').then(m => m.ChartComponent)
)
</script>

<template>
  <ClientOnly>
    <Chart :data="data" />
  </ClientOnly>
</template>
```

## Reference
- [Vue.js SSR - Platform-Specific APIs](https://vuejs.org/guide/scaling-up/ssr.html#access-to-platform-specific-apis)
- [Nuxt ClientOnly Component](https://nuxt.com/docs/api/components/client-only)
- [MDN: Web APIs](https://developer.mozilla.org/en-US/docs/Web/API)
