---
title: Self-Referencing Components Use Filename as Implicit Name
impact: LOW
impactDescription: Understanding this avoids confusion with recursive components
type: gotcha
tags: [vue3, component-registration, self-reference, recursive-components, sfc]
---

# Self-Referencing Components Use Filename as Implicit Name

**Impact: LOW** - In Single-File Components (SFC), a component can reference itself in its own template using its filename as the component name. This is useful for recursive components like tree structures or nested comments. However, this implicit registration has lower priority than explicitly imported components, which can cause confusion.

## Task Checklist

- [ ] Use the filename (without extension) to self-reference a component
- [ ] Be aware that imported components take precedence over self-reference
- [ ] For clarity in recursive components, consider explicit naming

**Example:**
```vue
<!-- TreeItem.vue -->
<script setup>
defineProps({
  item: Object
})
</script>

<template>
  <div class="tree-item">
    <span>{{ item.name }}</span>
    <!-- Self-reference using filename -->
    <TreeItem
      v-for="child in item.children"
      :key="child.id"
      :item="child"
    />
  </div>
</template>
```

```vue
<!-- Comment.vue - recursive comments -->
<script setup>
defineProps({
  comment: Object
})
</script>

<template>
  <div class="comment">
    <p>{{ comment.text }}</p>
    <div class="replies" v-if="comment.replies?.length">
      <!-- Self-reference for nested replies -->
      <Comment
        v-for="reply in comment.replies"
        :key="reply.id"
        :comment="reply"
      />
    </div>
  </div>
</template>
```

## Priority: Imports Override Self-Reference

```vue
<!-- FooBar.vue -->
<script setup>
// If you import a component named FooBar, it takes precedence
import FooBar from './different/FooBar.vue'
</script>

<template>
  <!-- This renders the IMPORTED FooBar, not this file -->
  <FooBar />
</template>
```

To explicitly self-reference when there's a naming conflict:

```vue
<!-- FooBar.vue -->
<script setup>
import OtherFooBar from './different/FooBar.vue'
// No way to explicitly import "self" in script setup
// Must rename the import to avoid conflict
</script>

<template>
  <OtherFooBar />
  <!-- FooBar still refers to self (this file) because
       the import was aliased -->
  <FooBar />
</template>
```

## Options API: Explicit Name Option

```vue
<!-- RecursiveList.vue -->
<script>
export default {
  name: 'RecursiveList', // Explicit name for self-reference
  props: {
    items: Array
  }
}
</script>

<template>
  <ul>
    <li v-for="item in items" :key="item.id">
      {{ item.name }}
      <RecursiveList v-if="item.children" :items="item.children" />
    </li>
  </ul>
</template>
```

## Common Use Cases for Self-Reference

1. **Tree structures** - File explorers, org charts
2. **Nested comments** - Reddit-style comment threads
3. **Menu navigation** - Recursive dropdown menus
4. **Category hierarchies** - Product categories, taxonomies

## Avoid Infinite Recursion

```vue
<!-- TreeNode.vue -->
<script setup>
defineProps({
  node: Object,
  maxDepth: { type: Number, default: 10 },
  currentDepth: { type: Number, default: 0 }
})
</script>

<template>
  <div class="node">
    {{ node.name }}
    <!-- Guard against infinite recursion -->
    <template v-if="node.children && currentDepth < maxDepth">
      <TreeNode
        v-for="child in node.children"
        :key="child.id"
        :node="child"
        :max-depth="maxDepth"
        :current-depth="currentDepth + 1"
      />
    </template>
  </div>
</template>
```

## Reference
- [Vue.js Component Registration](https://vuejs.org/guide/components/registration.html)
