# Use inheritAttrs: false for Wrapper Components

## Rule

When building wrapper components where attributes should be applied to an inner element instead of the root element, always set `inheritAttrs: false` and explicitly bind `$attrs` to the target element.

## Why This Matters

- By default, Vue applies all non-prop attributes to the root element
- Wrapper components often have a non-semantic root (div wrapper, label wrapper)
- Attributes like `id`, `aria-*`, `data-*`, and event listeners should target the functional element
- Without `inheritAttrs: false`, accessibility and functionality can break

## Bad Code

```vue
<!-- BaseInput.vue - WRONG: attrs go to wrapper div, not input -->
<template>
  <div class="input-wrapper">
    <label>{{ label }}</label>
    <input type="text" />
  </div>
</template>

<script setup>
defineProps(['label'])
</script>

<!-- Parent usage -->
<BaseInput
  id="email"
  placeholder="Enter email"
  aria-describedby="email-help"
  @focus="handleFocus"
/>

<!--
  RESULT: All attrs go to the wrapper div!
  <div class="input-wrapper" id="email" placeholder="Enter email" ...>
    <label>...</label>
    <input type="text" />  <!-- No id, placeholder, or aria! -->
  </div>
-->
```

## Good Code

```vue
<!-- BaseInput.vue - CORRECT: attrs bound to input element -->
<script setup>
defineProps(['label'])

defineOptions({
  inheritAttrs: false
})
</script>

<template>
  <div class="input-wrapper">
    <label>{{ label }}</label>
    <input type="text" v-bind="$attrs" />
  </div>
</template>

<!-- Parent usage -->
<BaseInput
  id="email"
  placeholder="Enter email"
  aria-describedby="email-help"
  @focus="handleFocus"
/>

<!--
  RESULT: Attrs correctly applied to input
  <div class="input-wrapper">
    <label>...</label>
    <input type="text" id="email" placeholder="Enter email"
           aria-describedby="email-help" />
  </div>
-->
```

## Setting inheritAttrs in Different Syntaxes

### Script Setup (Vue 3.3+)

```vue
<script setup>
defineOptions({
  inheritAttrs: false
})
</script>
```

### Script Setup (Before Vue 3.3)

```vue
<script>
export default {
  inheritAttrs: false
}
</script>

<script setup>
// Your setup code here
</script>
```

### Options API

```vue
<script>
export default {
  inheritAttrs: false,
  // other options...
}
</script>
```

## Common Wrapper Component Patterns

### Form Input Wrapper

```vue
<script setup>
import { useAttrs, computed } from 'vue'

defineProps({
  label: String,
  error: String
})

defineOptions({
  inheritAttrs: false
})

const attrs = useAttrs()

// Separate class/style for wrapper vs input
const inputAttrs = computed(() => {
  const { class: _, style: __, ...rest } = attrs
  return rest
})
</script>

<template>
  <div class="form-field" :class="{ 'has-error': error }">
    <label v-if="label">{{ label }}</label>
    <input v-bind="inputAttrs" />
    <span v-if="error" class="error">{{ error }}</span>
  </div>
</template>
```

### Button with Icon Wrapper

```vue
<script setup>
defineProps({
  icon: String,
  iconPosition: {
    type: String,
    default: 'left'
  }
})

defineOptions({
  inheritAttrs: false
})
</script>

<template>
  <button class="icon-button" v-bind="$attrs">
    <span v-if="icon && iconPosition === 'left'" class="icon">{{ icon }}</span>
    <slot />
    <span v-if="icon && iconPosition === 'right'" class="icon">{{ icon }}</span>
  </button>
</template>
```

### Link Wrapper Component

```vue
<script setup>
defineProps({
  to: String,
  external: Boolean
})

defineOptions({
  inheritAttrs: false
})
</script>

<template>
  <a
    v-if="external"
    :href="to"
    target="_blank"
    rel="noopener noreferrer"
    v-bind="$attrs"
  >
    <slot />
  </a>
  <router-link v-else :to="to" v-bind="$attrs">
    <slot />
  </router-link>
</template>
```

## When NOT to Use inheritAttrs: false

- Simple components with a single semantic root element
- Components where the root element should receive all attributes
- Components that don't wrap other functional elements

```vue
<!-- SimpleCard.vue - No need for inheritAttrs: false -->
<template>
  <article class="card">
    <slot />
  </article>
</template>
<!-- Passing class, id, or data-* to the root article is fine -->
```

## References

- [Fallthrough Attributes - Disabling Attribute Inheritance](https://vuejs.org/guide/components/attrs.html#disabling-attribute-inheritance)
- [Build Advanced Components in Vue 3 using $attrs](https://www.thisdot.co/blog/build-advanced-components-in-vue-3-using-usdattrs)
