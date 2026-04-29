# Tailwind CSS Dynamic Class Generation

## Rule

Never construct Tailwind CSS class names dynamically using string concatenation or template literals. Tailwind's build process cannot detect dynamically generated class names, causing styles to be missing in production.

## Why This Matters

- Tailwind uses static analysis at build time to determine which CSS classes to include
- Dynamically constructed class names (e.g., `bg-${color}-500`) are invisible to Tailwind's scanner
- Classes work in development with JIT but fail silently in production builds
- This is a common source of "it works locally but not in production" bugs

## Bad Code

```vue
<script setup>
const props = defineProps({
  color: String, // 'red', 'blue', 'green'
  size: String   // 'sm', 'md', 'lg'
})
</script>

<template>
  <!-- WRONG: Tailwind cannot detect these classes -->
  <div :class="`bg-${color}-500 text-${size}`">
    Content
  </div>

  <!-- WRONG: String concatenation -->
  <div :class="'p-' + padding">
    Content
  </div>

  <!-- WRONG: Template literal in array -->
  <div :class="[`gap-x-${spacing}`]">
    Content
  </div>
</template>
```

## Good Code

```vue
<script setup>
const props = defineProps({
  color: String,
  size: String
})

// Use a mapping object with complete class names
const colorClasses = {
  red: 'bg-red-500',
  blue: 'bg-blue-500',
  green: 'bg-green-500'
}

const sizeClasses = {
  sm: 'text-sm p-2',
  md: 'text-base p-4',
  lg: 'text-lg p-6'
}
</script>

<template>
  <!-- CORRECT: Full class names that Tailwind can detect -->
  <div :class="[colorClasses[color], sizeClasses[size]]">
    Content
  </div>
</template>
```

## Using Conditional Objects

```vue
<script setup>
const props = defineProps({
  variant: String // 'primary', 'secondary', 'danger'
})
</script>

<template>
  <!-- CORRECT: All class names are complete strings -->
  <button :class="{
    'bg-blue-500 hover:bg-blue-600': variant === 'primary',
    'bg-gray-500 hover:bg-gray-600': variant === 'secondary',
    'bg-red-500 hover:bg-red-600': variant === 'danger'
  }">
    Click me
  </button>
</template>
```

## Safelist for Truly Dynamic Classes

If you must use dynamic classes, add them to Tailwind's safelist:

```javascript
// tailwind.config.js
module.exports = {
  safelist: [
    'bg-red-500',
    'bg-blue-500',
    'bg-green-500',
    // Or use patterns (use sparingly - increases bundle size)
    {
      pattern: /bg-(red|blue|green)-(100|500|900)/
    }
  ]
}
```

## Alternative: CSS Custom Properties

For truly dynamic values, use CSS custom properties:

```vue
<script setup>
const props = defineProps({
  customColor: String // Any hex color
})
</script>

<template>
  <!-- Use CSS variable for truly dynamic values -->
  <div
    class="dynamic-bg"
    :style="{ '--dynamic-color': customColor }"
  >
    Content
  </div>
</template>

<style>
.dynamic-bg {
  background-color: var(--dynamic-color);
}
</style>
```

## References

- [Tailwind CSS Dynamic Class Names](https://tailwindcss.com/docs/content-configuration#dynamic-class-names)
- [Tailwind Safelist](https://tailwindcss.com/docs/content-configuration#safelisting-classes)
