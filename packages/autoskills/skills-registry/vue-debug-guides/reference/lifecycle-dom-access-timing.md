---
title: Access DOM Only After Mounted Hook
impact: HIGH
impactDescription: Accessing DOM elements before mounted causes undefined errors and silent failures
type: capability
tags: [vue3, vue2, lifecycle, dom, mounted, created, beforeMount, template-refs]
---

# Access DOM Only After Mounted Hook

**Impact: HIGH** - Attempting to access DOM elements or `this.$el` in `created` or `beforeMount` hooks fails because the component's template has not yet been rendered to the DOM. This leads to undefined errors, null references, and failed third-party library initializations.

The component's DOM is only available starting from the `mounted` hook (Options API) or after `onMounted` runs (Composition API). Before this point, `this.$el` is undefined and template refs are null.

## Task Checklist

- [ ] Perform DOM manipulations only in `mounted`/`onMounted` or later
- [ ] Initialize DOM-dependent libraries (charts, maps, editors) in mounted
- [ ] Use `created` for data initialization and API calls (non-DOM operations)
- [ ] Access template refs only after mounted
- [ ] Use `$nextTick` if you need DOM after reactive data changes

**Incorrect:**
```javascript
// WRONG: Accessing DOM in created hook
export default {
  created() {
    // DOM doesn't exist yet!
    console.log(this.$el) // undefined
    this.$el.querySelector('.chart') // Error: Cannot read property 'querySelector' of undefined

    // Third-party library initialization fails
    new Chart(document.getElementById('myChart')) // Element doesn't exist yet
  }
}
```

```javascript
// WRONG: Accessing DOM in beforeMount
export default {
  beforeMount() {
    // Still too early - template is compiled but not mounted
    console.log(this.$el) // undefined in Vue 3
    this.$refs.myInput.focus() // Error: Cannot read property 'focus' of undefined
  }
}
```

```vue
<!-- WRONG: Accessing template ref synchronously in setup -->
<script setup>
import { ref } from 'vue'

const myInput = ref(null)

// This runs during setup, before mounting
myInput.value.focus() // Error: Cannot read property 'focus' of null
</script>

<template>
  <input ref="myInput" />
</template>
```

**Correct:**
```javascript
// CORRECT: Use created for data, mounted for DOM
export default {
  data() {
    return { chartData: null }
  },
  async created() {
    // Data fetching is fine in created
    this.chartData = await fetchChartData()
  },
  mounted() {
    // Now the DOM exists and is safe to access
    console.log(this.$el) // <div>...</div>

    // Initialize DOM-dependent libraries
    this.chart = new Chart(this.$refs.chartCanvas, {
      data: this.chartData
    })
  }
}
```

```vue
<!-- CORRECT: Access template refs in onMounted -->
<script setup>
import { ref, onMounted } from 'vue'

const myInput = ref(null)

onMounted(() => {
  // DOM is now available
  myInput.value.focus() // Works!
})
</script>

<template>
  <input ref="myInput" />
</template>
```

```javascript
// CORRECT: Using $nextTick for DOM access after data changes
export default {
  methods: {
    async addItem() {
      this.items.push(newItem)

      // Wait for Vue to update the DOM
      await this.$nextTick()

      // Now the new element exists in DOM
      this.$refs.list.lastElementChild.scrollIntoView()
    }
  }
}
```

## Vue 3 Composition API Pattern

```vue
<script setup>
import { ref, onMounted, nextTick } from 'vue'

const listRef = ref(null)
const items = ref([])

onMounted(() => {
  // Safe to access DOM here
  listRef.value.style.height = '400px'
})
</script>
```

## Vue 3.5+ useTemplateRef Pattern

```vue
<script setup>
import { useTemplateRef, onMounted } from 'vue'

// Vue 3.5+ recommended approach - decouples ref name from variable name
const input = useTemplateRef('my-input')

onMounted(() => {
  input.value.focus()
})
</script>

<template>
  <input ref="my-input" />
</template>
```

## Composition API with nextTick

```vue
<script setup>
import { ref, nextTick } from 'vue'

const listRef = ref(null)
const items = ref([])

async function addItem(item) {
  items.value.push(item)

  // Wait for DOM update after reactive change
  await nextTick()

  // Now new item is in DOM
  listRef.value.lastElementChild.focus()
}
</script>

<template>
  <ul ref="listRef">
    <li v-for="item in items" :key="item.id">{{ item.name }}</li>
  </ul>
</template>
```

## Common Third-Party Libraries

```javascript
// CORRECT: Initialize in mounted
export default {
  mounted() {
    // Chart.js
    this.chart = new Chart(this.$refs.canvas, config)

    // Leaflet maps
    this.map = L.map(this.$refs.mapContainer).setView([51.505, -0.09], 13)

    // Monaco Editor
    this.editor = monaco.editor.create(this.$refs.editorContainer, options)

    // Video.js
    this.player = videojs(this.$refs.videoElement)
  },
  beforeUnmount() {
    // Don't forget cleanup!
    this.chart?.destroy()
    this.map?.remove()
    this.editor?.dispose()
    this.player?.dispose()
  }
}
```

## Reference
- [Vue.js Lifecycle Hooks](https://vuejs.org/guide/essentials/lifecycle.html)
- [Vue.js Template Refs](https://vuejs.org/guide/essentials/template-refs.html)
- [Vue.js nextTick](https://vuejs.org/api/general.html#nexttick)
