---
title: Template Ref Array Order Not Guaranteed in v-for
impact: MEDIUM
impactDescription: Refs collected from v-for may not match source array order, causing index-based bugs
type: gotcha
tags: [vue3, template-refs, v-for, arrays, ordering]
---

# Template Ref Array Order Not Guaranteed in v-for

**Impact: MEDIUM** - When using template refs inside `v-for`, Vue collects the element references into an array. However, this array does NOT guarantee the same order as the source array. Relying on index-based access can lead to subtle bugs.

This caveat is not obvious and can cause hard-to-debug issues when you assume the ref array matches your data order.

> **Warning: `useTemplateRef()` does NOT work with v-for refs in Vue 3.5**
>
> The `useTemplateRef()` API returns `null` when used with refs inside `v-for`. This is a known limitation. You must use the legacy pattern with `ref()` and a matching template ref name:
>
> ```ts
> // Does NOT work with v-for - returns null
> const itemRefs = useTemplateRef('items')
>
> // Works with v-for - use this pattern instead
> const items = ref([])  // name must match ref="items" in template
> ```
>
> The examples in this rule show `useTemplateRef()` for illustration, but in practice you should use the legacy `ref()` pattern for v-for scenarios until this limitation is addressed.

## Task Checklist

- [ ] Never assume ref array indices match source data array indices
- [ ] Use data attributes or other identifiers to correlate refs with data
- [ ] Consider function refs for complex scenarios requiring ordered access
- [ ] Test with dynamic list operations (add, remove, reorder) to verify behavior

**Incorrect:**
```vue
<script setup>
import { ref, useTemplateRef, onMounted } from 'vue'

const items = ref(['First', 'Second', 'Third'])
const itemRefs = useTemplateRef('items')

onMounted(() => {
  // WRONG: Assuming itemRefs[0] corresponds to items[0]
  // The order is NOT guaranteed to match!
  items.value.forEach((item, index) => {
    console.log(`${item}: `, itemRefs.value[index]) // May be wrong element!
  })
})
</script>

<template>
  <ul>
    <li v-for="item in items" ref="items" :key="item">
      {{ item }}
    </li>
  </ul>
</template>
```

**Correct:**
```vue
<script setup>
import { ref, useTemplateRef, onMounted } from 'vue'

const items = ref([
  { id: 1, text: 'First' },
  { id: 2, text: 'Second' },
  { id: 3, text: 'Third' }
])
const itemRefs = useTemplateRef('items')

onMounted(() => {
  // CORRECT: Use data attributes to identify elements
  itemRefs.value.forEach(el => {
    const id = el.dataset.id
    const item = items.value.find(i => i.id === Number(id))
    console.log(`${item.text}: `, el)
  })
})
</script>

<template>
  <ul>
    <li
      v-for="item in items"
      ref="items"
      :key="item.id"
      :data-id="item.id"
    >
      {{ item.text }}
    </li>
  </ul>
</template>
```

```vue
<script setup>
import { ref, onMounted, onBeforeUpdate } from 'vue'

const items = ref(['First', 'Second', 'Third'])
const itemRefs = ref(new Map())

// CORRECT: Use function refs for precise control
function setItemRef(el, item) {
  if (el) {
    itemRefs.value.set(item, el)
  } else {
    itemRefs.value.delete(item)
  }
}

// Reset before each update to handle removed items
onBeforeUpdate(() => {
  itemRefs.value.clear()
})

onMounted(() => {
  // Access refs by their associated data item
  items.value.forEach(item => {
    const el = itemRefs.value.get(item)
    console.log(`${item}: `, el)
  })
})
</script>

<template>
  <ul>
    <li
      v-for="item in items"
      :key="item"
      :ref="(el) => setItemRef(el, item)"
    >
      {{ item }}
    </li>
  </ul>
</template>
```

```vue
<script setup>
import { ref, useTemplateRef, onMounted } from 'vue'

const items = ref(['First', 'Second', 'Third'])
const itemRefs = useTemplateRef('items')

// CORRECT: If order matters, sort refs by DOM position
onMounted(() => {
  const sortedRefs = [...itemRefs.value].sort((a, b) => {
    // Sort by DOM order using compareDocumentPosition
    return a.compareDocumentPosition(b) & Node.DOCUMENT_POSITION_FOLLOWING ? -1 : 1
  })

  // Now sortedRefs matches visual/DOM order
  sortedRefs.forEach((el, index) => {
    console.log(`Position ${index}: `, el.textContent)
  })
})
</script>

<template>
  <ul>
    <li v-for="item in items" ref="items" :key="item">
      {{ item }}
    </li>
  </ul>
</template>
```

## Reference
- [Vue.js Template Refs - Refs inside v-for](https://vuejs.org/guide/essentials/template-refs.html#refs-inside-v-for)
