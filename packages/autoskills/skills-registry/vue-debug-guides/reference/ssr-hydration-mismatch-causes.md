---
title: Understand and Fix SSR Hydration Mismatches
impact: HIGH
impactDescription: Hydration mismatches cause visual flickering, performance loss, and broken functionality
type: gotcha
tags: [vue3, ssr, hydration, debugging, nuxt, server-side-rendering]
---

# Understand and Fix SSR Hydration Mismatches

**Impact: HIGH** - Hydration mismatches occur when the HTML rendered on the client differs from what the server rendered. Vue attempts to recover by discarding and re-rendering mismatched nodes, causing performance degradation, visual flickering, and potentially broken event handlers.

Understanding the common causes helps you prevent and debug these issues effectively.

## Task Checklist

- [ ] Validate HTML structure for proper nesting (no div in p, no nested a tags)
- [ ] Move random value generation to onMounted or use seeded randoms
- [ ] Format dates/times on client side only
- [ ] Use `data-allow-mismatch` (Vue 3.5+) for intentional mismatches
- [ ] Check for browser-modified HTML in dev tools

## Cause 1: Invalid HTML Nesting

Browsers auto-correct invalid HTML, creating different DOM than Vue expects.

**Incorrect:**
```vue
<template>
  <!-- WRONG: <div> cannot be inside <p> -->
  <p>
    <div>This will break hydration</div>
  </p>

  <!-- WRONG: <a> cannot be inside <a> -->
  <a href="/parent">
    <a href="/child">Nested link</a>
  </a>

  <!-- WRONG: Block elements in inline elements -->
  <span>
    <div>Block in inline</div>
  </span>
</template>
```

Browser converts the first example to:
```html
<p></p>
<div>This will break hydration</div>
<p></p>
```

**Correct:**
```vue
<template>
  <!-- CORRECT: Use appropriate nesting -->
  <div>
    <div>This works fine</div>
  </div>

  <!-- CORRECT: Single link with event handling -->
  <a href="/parent" @click="handleParentClick">
    <span @click.stop="handleChildClick">Nested action</span>
  </a>

  <!-- CORRECT: Block element wrapper -->
  <div>
    <div>Block in block</div>
  </div>
</template>
```

## Cause 2: Random Values in Render

Server and client generate different random values.

**Incorrect:**
```vue
<template>
  <!-- WRONG: Different ID on server vs client -->
  <div :id="'field-' + Math.random()">
    Form field
  </div>

  <!-- WRONG: Random order differs -->
  <div v-for="item in shuffledItems" :key="item.id">
    {{ item.name }}
  </div>
</template>

<script setup>
import { computed } from 'vue'

const items = [/* ... */]

// WRONG: Random shuffle runs differently on server and client
const shuffledItems = computed(() =>
  [...items].sort(() => Math.random() - 0.5)
)
</script>
```

**Correct - Client-Only Random:**
```vue
<template>
  <div :id="fieldId">
    Form field
  </div>

  <div v-for="item in displayItems" :key="item.id">
    {{ item.name }}
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const items = [/* ... */]

// CORRECT: Start with deterministic value
const fieldId = ref('field-default')
const displayItems = ref(items) // Original order on server

onMounted(() => {
  // Randomize only on client
  fieldId.value = 'field-' + Math.random().toString(36).slice(2)
  displayItems.value = [...items].sort(() => Math.random() - 0.5)
})
</script>
```

**Correct - Seeded Random:**
```javascript
// utils/seededRandom.js
export function createSeededRandom(seed) {
  return function() {
    seed = (seed * 9301 + 49297) % 233280
    return seed / 233280
  }
}

// Use same seed on server and client
const seed = 12345 // Could be based on user ID, page, etc.
const random = createSeededRandom(seed)
```

## Cause 3: Timezone and Date Differences

Server may be in different timezone than client.

**Incorrect:**
```vue
<template>
  <!-- WRONG: Server time != client time -->
  <span>{{ new Date().toLocaleTimeString() }}</span>

  <!-- WRONG: Server formats dates in server's timezone -->
  <span>{{ formatDate(article.createdAt) }}</span>
</template>

<script setup>
function formatDate(date) {
  return new Date(date).toLocaleDateString()
}
</script>
```

**Correct:**
```vue
<template>
  <!-- CORRECT: Render placeholder, update on client -->
  <span>{{ displayTime || 'Loading...' }}</span>

  <!-- CORRECT: Use UTC or defer to client -->
  <span>{{ formattedDate }}</span>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'

const props = defineProps(['article'])
const displayTime = ref(null)
const isClient = ref(false)

onMounted(() => {
  displayTime.value = new Date().toLocaleTimeString()
  isClient.value = true
})

// CORRECT: Server renders UTC, client converts to local
const formattedDate = computed(() => {
  if (!props.article?.createdAt) return ''

  if (isClient.value) {
    // Client: user's local timezone
    return new Date(props.article.createdAt).toLocaleDateString()
  } else {
    // Server: consistent UTC format
    return new Date(props.article.createdAt).toISOString().split('T')[0]
  }
})
</script>
```

## Cause 4: Browser Extensions and Modifications

Browser extensions can inject content into the DOM.

**Mitigation:**
```vue
<template>
  <!-- Use data-allow-mismatch for areas extensions might modify -->
  <head data-allow-mismatch>
    <title>{{ pageTitle }}</title>
  </head>
</template>
```

## Vue 3.5+ Suppressing Intentional Mismatches

```vue
<template>
  <!-- Suppress specific mismatch types -->
  <div data-allow-mismatch="text">
    {{ clientOnlyText }}
  </div>

  <!-- Suppress all mismatches for this element -->
  <div data-allow-mismatch>
    <ComplexClientComponent />
  </div>
</template>
```

Valid `data-allow-mismatch` values:
- `text` - Text content mismatches
- `children` - Child element mismatches
- `class` - Class attribute mismatches
- `style` - Style attribute mismatches
- `attribute` - Other attribute mismatches
- (no value) - All mismatches

## Debugging Hydration Mismatches

```javascript
// Enable detailed hydration mismatch warnings in development
// vite.config.js
export default {
  define: {
    __VUE_PROD_HYDRATION_MISMATCH_DETAILS__: true
  }
}
```

```vue
<script setup>
import { onMounted } from 'vue'

// Debug: Compare server HTML with client expectation
onMounted(() => {
  const serverHTML = document.getElementById('app').innerHTML
  console.log('Server rendered:', serverHTML)
})
</script>
```

## Common Error Messages

| Error | Likely Cause |
|-------|--------------|
| "Hydration text content mismatch" | Different text on server/client (dates, random) |
| "Hydration children mismatch" | Invalid HTML nesting, conditional rendering |
| "Hydration attribute mismatch" | Dynamic attributes with different values |
| "Hydration node mismatch" | Completely different elements rendered |

## Reference
- [Vue.js SSR Guide - Hydration Mismatch](https://vuejs.org/guide/scaling-up/ssr.html#hydration-mismatch)
- [Nuxt Hydration Best Practices](https://nuxt.com/docs/guide/best-practices/hydration)
- [data-allow-mismatch RFC](https://github.com/vuejs/core/pull/9562)
