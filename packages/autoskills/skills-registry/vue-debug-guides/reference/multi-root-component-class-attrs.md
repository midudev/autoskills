# Multi-Root Component Class Attribute Inheritance

## Rule

When a Vue 3 component has multiple root elements, class and style bindings from the parent will NOT automatically fall through. You must explicitly bind `$attrs.class` or `$attrs.style` to the target element.

## Why This Matters

- Vue 3 components can have multiple root elements (fragments)
- Unlike single-root components, multi-root components have no automatic attribute fallthrough
- Without explicit handling, classes and styles passed from parent are silently ignored
- Vue will emit a runtime warning, but styles/classes simply won't apply

## Bad Code

```vue
<!-- ChildComponent.vue - WRONG: classes from parent won't apply -->
<template>
  <header>Header</header>
  <main>Content</main>
  <footer>Footer</footer>
</template>

<!-- Parent usage -->
<ChildComponent class="my-custom-class" />
<!-- Result: my-custom-class is NOT applied to any element -->
```

## Good Code

```vue
<!-- ChildComponent.vue - CORRECT: explicitly bind $attrs.class -->
<template>
  <header>Header</header>
  <main :class="$attrs.class" :style="$attrs.style">Content</main>
  <footer>Footer</footer>
</template>

<!-- Or bind all attrs to one element -->
<template>
  <header>Header</header>
  <main v-bind="$attrs">Content</main>
  <footer>Footer</footer>
</template>
```

## Accessing $attrs in script setup

```vue
<script setup>
import { useAttrs } from 'vue'
const attrs = useAttrs()
// attrs.class and attrs.style are available
</script>

<template>
  <header>Header</header>
  <main :class="attrs.class">Content</main>
  <footer>Footer</footer>
</template>
```

## Disabling Automatic Inheritance

For single-root components where you want to control attribute placement:

```vue
<script>
export default {
  inheritAttrs: false
}
</script>

<script setup>
import { useAttrs } from 'vue'
const attrs = useAttrs()
</script>

<template>
  <div class="wrapper">
    <input v-bind="attrs" />
  </div>
</template>
```

## Vue 2 to Vue 3 Migration Note

In Vue 2, `$attrs` did NOT include `class` and `style`. In Vue 3, `$attrs` contains ALL attributes including `class` and `style`. This is a breaking change that affects how you handle attribute forwarding.

## References

- [Fallthrough Attributes](https://vuejs.org/guide/components/attrs.html)
- [Vue 3 Migration Guide - $attrs includes class & style](https://v3-migration.vuejs.org/breaking-changes/attrs-includes-class-style)
