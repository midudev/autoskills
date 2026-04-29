# Fallthrough Attributes Overwrite Explicit Attributes in Vue 3

## Rule

In Vue 3, fallthrough attributes overwrite explicitly set attributes on the root element (except `class` and `style` which are merged). This is a breaking change from Vue 2. To preserve explicit attribute values, use `inheritAttrs: false` and manually bind `$attrs` before the explicit attribute.

## Why This Matters

- Silent behavior change from Vue 2 to Vue 3
- Can cause unexpected attribute values in migrated codebases
- Only `class` and `style` merge intelligently; other attributes are overwritten
- Affects component composition patterns and wrapper components

## Bad Code

```vue
<!-- Parent.vue -->
<template>
  <Child msg="Passed from Parent" />
</template>

<!-- Child.vue - UNEXPECTED BEHAVIOR -->
<template>
  <GrandChild msg="Set in Child" />
</template>

<!--
  Vue 3 Result: GrandChild receives msg="Passed from Parent"
  The fallthrough attribute OVERWRITES the explicit one!

  Vue 2 Result: GrandChild receives msg="Set in Child"
  The explicit attribute took precedence
-->
```

### Another common case with data attributes

```vue
<!-- Parent.vue -->
<template>
  <Button data-testid="parent-button" />
</template>

<!-- Button.vue - WRONG: explicit data-testid is overwritten -->
<template>
  <button data-testid="submit-btn">Submit</button>
</template>

<!-- Result: <button data-testid="parent-button">Submit</button> -->
<!-- The component's intended test ID is lost! -->
```

## Good Code

### Option 1: Control attribute order with inheritAttrs: false

```vue
<!-- Child.vue - CORRECT: Control attribute precedence -->
<script setup>
defineOptions({
  inheritAttrs: false
})
</script>

<template>
  <!-- v-bind="$attrs" FIRST, then explicit attribute -->
  <GrandChild v-bind="$attrs" msg="Set in Child" />
</template>

<!--
  Result: GrandChild receives msg="Set in Child"
  Explicit attribute overrides fallthrough because it comes last
-->
```

### Option 2: Exclude specific attrs from fallthrough

```vue
<script setup>
import { computed, useAttrs } from 'vue'

defineOptions({
  inheritAttrs: false
})

const attrs = useAttrs()

// Filter out attributes you want to control explicitly
const filteredAttrs = computed(() => {
  const { msg, ...rest } = attrs
  return rest
})
</script>

<template>
  <GrandChild v-bind="filteredAttrs" msg="Set in Child" />
</template>
```

### Option 3: For wrapper components, declare as prop

```vue
<!-- Button.vue - BEST: Declare attributes you need to control -->
<script setup>
const props = defineProps({
  dataTestid: {
    type: String,
    default: 'submit-btn'
  }
})

defineOptions({
  inheritAttrs: false
})
</script>

<template>
  <button :data-testid="dataTestid" v-bind="$attrs">
    <slot />
  </button>
</template>
```

## Class and Style Are Special

Unlike other attributes, `class` and `style` merge rather than overwrite:

```vue
<!-- Parent.vue -->
<template>
  <Button class="large" style="color: red" />
</template>

<!-- Button.vue -->
<template>
  <button class="btn" style="padding: 10px">Submit</button>
</template>

<!--
  Result: <button class="btn large" style="padding: 10px; color: red">
  Both classes and styles are MERGED, not overwritten
-->
```

## Vue 2 to Vue 3 Migration Checklist

When migrating components that rely on attribute precedence:

1. Identify components that set explicit attributes on root elements
2. Check if parent components pass the same attributes
3. If explicit values should take precedence:
   - Add `inheritAttrs: false`
   - Use `v-bind="$attrs"` before explicit attributes

## References

- [Fallthrough Attributes](https://vuejs.org/guide/components/attrs.html)
- [Vue 3 Migration Guide - Attribute Coercion Behavior](https://v3-migration.vuejs.org/breaking-changes/)
- [Vue Fallthrough Attributes behaviour changes from Vue 2 to Vue 3](https://lukes.tips/posts/vue-3-fallthough-attributes-changes/)
