---
title: Keep Props Stable to Minimize Child Re-renders
impact: HIGH
impactDescription: Passing changing props to list items causes ALL children to re-render unnecessarily
type: efficiency
tags: [vue3, performance, props, v-for, re-renders, optimization]
---

# Keep Props Stable to Minimize Child Re-renders

**Impact: HIGH** - When props passed to child components change, Vue must re-render those components. Passing derived values like `activeId` to every list item causes all items to re-render when activeId changes, even if only one item's active state actually changed.

Move comparison logic to the parent and pass the boolean result instead. This is one of the most impactful update performance optimizations in Vue.

## Task Checklist

- [ ] Avoid passing parent-level state that all children compare against (like `activeId`)
- [ ] Pre-compute derived boolean props in the parent (like `:active="item.id === activeId"`)
- [ ] Profile re-renders using Vue DevTools to identify prop stability issues
- [ ] Consider this pattern especially critical for large lists

**Incorrect:**
```vue
<template>
  <!-- BAD: activeId changes -> ALL 100 ListItems re-render -->
  <ListItem
    v-for="item in list"
    :key="item.id"
    :id="item.id"
    :active-id="activeId"
  />
</template>

<script setup>
import { ref } from 'vue'

const list = ref([/* 100 items */])
const activeId = ref(null)

// When activeId changes from 1 to 2:
// - ListItem 1 needs to re-render (was active, now not)
// - ListItem 2 needs to re-render (was not active, now active)
// - All other 98 ListItems ALSO re-render because activeId prop changed!
</script>
```

```vue
<!-- ListItem.vue - receives activeId and compares internally -->
<template>
  <div :class="{ active: id === activeId }">
    {{ id }}
  </div>
</template>

<script setup>
defineProps({
  id: Number,
  activeId: Number  // This prop changes for ALL items
})
</script>
```

**Correct:**
```vue
<template>
  <!-- GOOD: Only items whose :active actually changed will re-render -->
  <ListItem
    v-for="item in list"
    :key="item.id"
    :id="item.id"
    :active="item.id === activeId"
  />
</template>

<script setup>
import { ref } from 'vue'

const list = ref([/* 100 items */])
const activeId = ref(null)

// When activeId changes from 1 to 2:
// - ListItem 1: :active changed from true to false -> re-renders
// - ListItem 2: :active changed from false to true -> re-renders
// - All other 98 ListItems: :active is still false -> NO re-render!
</script>
```

```vue
<!-- ListItem.vue - receives pre-computed boolean -->
<template>
  <div :class="{ active }">
    {{ id }}
  </div>
</template>

<script setup>
defineProps({
  id: Number,
  active: Boolean  // This only changes for items that truly changed
})
</script>
```

## Common Patterns That Cause Prop Instability

```vue
<!-- BAD: Passing index that could shift -->
<Item
  v-for="(item, index) in items"
  :key="item.id"
  :index="index"
  :total="items.length"  <!-- Changes when list changes -->
/>

<!-- BAD: Passing entire selection set -->
<Item
  v-for="item in items"
  :key="item.id"
  :selected-ids="selectedIds"  <!-- All items re-render on any selection -->
/>

<!-- GOOD: Pre-compute the boolean -->
<Item
  v-for="item in items"
  :key="item.id"
  :selected="selectedIds.includes(item.id)"
/>
```

## Performance Impact Example

| Scenario | Props Changed | Components Re-rendered |
|----------|---------------|------------------------|
| 100 items, pass `activeId` | 100 | 100 (all) |
| 100 items, pass `:active` boolean | 2 | 2 (only changed) |
| 1000 items, pass `activeId` | 1000 | 1000 (all) |
| 1000 items, pass `:active` boolean | 2 | 2 (only changed) |

## Reference
- [Vue.js Performance - Props Stability](https://vuejs.org/guide/best-practices/performance.html#props-stability)
