---
title: Use Key Attribute to Force Re-render Animations
impact: MEDIUM
impactDescription: Without key attributes, Vue reuses DOM elements and animation libraries like AutoAnimate cannot detect changes to animate
type: gotcha
tags: [vue3, animation, key, autoanimate, rerender, dom]
---

# Use Key Attribute to Force Re-render Animations

**Impact: MEDIUM** - Vue optimizes performance by reusing DOM elements when possible. However, this optimization can prevent animation libraries (like AutoAnimate) from detecting changes, because the element is updated in place rather than re-created. Adding a `:key` attribute forces Vue to treat changed elements as new, triggering proper animations.

## Task Checklist

- [ ] Add `:key` to elements that should animate when their content changes
- [ ] Use unique, changing values for keys (not indices)
- [ ] For route transitions, add `:key="$route.fullPath"` to `<router-view>`
- [ ] Apply `v-auto-animate` to the parent element of keyed children

**Problematic Code:**
```vue
<template>
  <!-- BAD: Text changes but no animation occurs -->
  <div v-auto-animate>
    <p>{{ message }}</p>  <!-- No key - element is reused -->
  </div>

  <!-- BAD: Image source changes but no animation -->
  <div v-auto-animate>
    <img :src="imageUrl" />  <!-- No key - element is reused -->
  </div>

  <!-- BAD: Route changes don't animate -->
  <router-view v-auto-animate />  <!-- No key -->
</template>

<script setup>
import { ref } from 'vue'

const message = ref('Hello')
const imageUrl = ref('/images/photo1.jpg')

// Changing these won't trigger animations because
// Vue updates the existing elements rather than replacing them
</script>
```

**Correct Code:**
```vue
<template>
  <!-- GOOD: Key forces re-render, triggering animation -->
  <div v-auto-animate>
    <p :key="message">{{ message }}</p>
  </div>

  <!-- GOOD: Image animates when source changes -->
  <div v-auto-animate>
    <img :key="imageUrl" :src="imageUrl" />
  </div>

  <!-- GOOD: Route changes animate properly -->
  <router-view :key="$route.fullPath" v-auto-animate />
</template>

<script setup>
import { ref } from 'vue'

const message = ref('Hello')
const imageUrl = ref('/images/photo1.jpg')

// Now changing these will trigger animations
function updateMessage() {
  message.value = 'World'  // Triggers enter animation for new <p>
}
</script>
```

## Why This Works

When Vue sees a `:key` change:
1. It considers the old element and new element as different
2. The old element is removed (triggering leave animation)
3. A new element is created (triggering enter animation)

Without `:key`:
1. Vue sees the same element type in the same position
2. It updates the element's properties in place
3. No DOM addition/removal occurs, so no animation triggers

## Common Use Cases

### Animating Text Content Changes

```vue
<template>
  <div v-auto-animate>
    <h1 :key="title">{{ title }}</h1>
    <p :key="description">{{ description }}</p>
  </div>
</template>
```

### Animating Dynamic Components

```vue
<template>
  <div v-auto-animate>
    <component :is="currentComponent" :key="currentComponent" />
  </div>
</template>
```

### Animating Route Transitions

```vue
<template>
  <router-view v-slot="{ Component, route }">
    <div v-auto-animate>
      <component :is="Component" :key="route.fullPath" />
    </div>
  </router-view>
</template>
```

## With Vue's Built-in Transition

The same principle applies to Vue's `<Transition>` component:

```vue
<template>
  <!-- GOOD: Key triggers transition on content change -->
  <Transition name="fade" mode="out-in">
    <p :key="message">{{ message }}</p>
  </Transition>

  <!-- GOOD: Different keys for conditional content -->
  <Transition name="fade" mode="out-in">
    <div v-if="isLoading" key="loading">Loading...</div>
    <div v-else key="content">{{ content }}</div>
  </Transition>
</template>
```

## Caution: Performance Implications

Using `:key` forces full component re-creation. For frequently changing data:
- The entire component tree under the keyed element is destroyed and recreated
- Any component state is lost
- Consider whether the animation is worth the performance cost

```vue
<!-- Be cautious with complex components -->
<ComplexDashboard :key="refreshTrigger" />
<!-- This destroys and recreates the entire dashboard! -->
```

## Reference
- [Vue.js Animation Techniques](https://vuejs.org/guide/extras/animation.html)
- [AutoAnimate with Vue](https://auto-animate.formkit.com/#usage-vue)
- [Vue.js v-for with key](https://vuejs.org/guide/essentials/list.html#maintaining-state-with-key)
