---
title: Boolean Props Default to false, Not undefined
impact: MEDIUM
impactDescription: TypeScript expects optional boolean to be undefined but Vue defaults it to false, causing type confusion
type: gotcha
tags: [vue3, typescript, props, boolean, defineProps]
---

# Boolean Props Default to false, Not undefined

**Impact: MEDIUM** - When using type-based `defineProps`, optional boolean props (marked with `?`) behave differently than TypeScript expects. Vue treats boolean props specially: an absent boolean prop defaults to `false`, not `undefined`. This can cause confusion when TypeScript thinks the type is `boolean | undefined`.

## Task Checklist

- [ ] Understand that Vue's boolean casting makes absent booleans `false`
- [ ] Use `withDefaults()` to be explicit about boolean defaults
- [ ] Consider using non-boolean types if `undefined` is a meaningful state
- [ ] Document this Vue-specific behavior for your team

## The Gotcha

```vue
<script setup lang="ts">
interface Props {
  disabled?: boolean  // TypeScript sees: boolean | undefined
}

const props = defineProps<Props>()

// TypeScript thinks props.disabled could be undefined
if (props.disabled === undefined) {
  console.log('This will NEVER run!')
  // Vue's boolean casting means disabled is false, not undefined
}
</script>

<template>
  <!-- When used without the prop -->
  <MyComponent />
  <!-- disabled is false, NOT undefined -->
</template>
```

## Why This Happens

Vue has special "boolean casting" behavior inherited from HTML boolean attributes:

```vue
<!-- All of these make disabled = true -->
<MyComponent disabled />
<MyComponent :disabled="true" />
<MyComponent disabled="" />

<!-- This makes disabled = false (NOT undefined) -->
<MyComponent />

<!-- Explicit false -->
<MyComponent :disabled="false" />
```

This is by design to match how HTML works:
```html
<!-- HTML: presence means true, absence means false -->
<button disabled>Can't click</button>
<button>Can click</button>
```

## Solutions

### Solution 1: Be Explicit with withDefaults

Make your intention clear:

```vue
<script setup lang="ts">
interface Props {
  disabled?: boolean
}

// Explicitly document the default
const props = withDefaults(defineProps<Props>(), {
  disabled: false  // Now it's clear this defaults to false
})
</script>
```

### Solution 2: Use a Three-State Type

If you actually need to distinguish "not set" from "explicitly false":

```vue
<script setup lang="ts">
interface Props {
  // Use a union type instead of optional boolean
  state?: 'enabled' | 'disabled' | undefined

  // Or use undefined explicitly
  toggleState?: boolean | undefined
}

const props = withDefaults(defineProps<Props>(), {
  state: undefined,  // Can actually be undefined
  toggleState: undefined
})

// Now you can check for undefined
if (props.state === undefined) {
  // Use parent's state
} else if (props.state === 'disabled') {
  // Explicitly disabled
}
</script>
```

### Solution 3: Use null for "Not Set"

```vue
<script setup lang="ts">
interface Props {
  // null = not set, false = explicitly off, true = explicitly on
  selected: boolean | null
}

const props = withDefaults(defineProps<Props>(), {
  selected: null
})

// Three distinct states
if (props.selected === null) {
  console.log('Selection not specified')
} else if (props.selected) {
  console.log('Selected')
} else {
  console.log('Explicitly not selected')
}
</script>
```

## Boolean Casting Order

Vue also has special behavior when Boolean and String are both valid:

```typescript
// Order matters in runtime declaration!
defineProps({
  // Boolean first: empty string becomes true
  disabled: [Boolean, String]
})

// <MyComponent disabled /> → disabled = true
// <MyComponent disabled="" /> → disabled = true
```

```typescript
defineProps({
  // String first: empty string stays as string
  disabled: [String, Boolean]
})

// <MyComponent disabled /> → disabled = ''
// <MyComponent disabled="" /> → disabled = ''
```

With type-based declaration, Boolean always takes priority for absent props.

## Common Bug Pattern

```vue
<!-- Parent.vue -->
<script setup lang="ts">
const userPreferences = ref({
  darkMode: undefined as boolean | undefined
})

// Fetch preferences...
onMounted(async () => {
  userPreferences.value = await fetchPreferences()
})
</script>

<template>
  <!-- Bug: undefined becomes false, not "inherit system preference" -->
  <ThemeToggle :darkMode="userPreferences.darkMode" />
</template>
```

**Fix:**

```vue
<script setup lang="ts">
const userPreferences = ref<{
  darkMode: boolean | null
}>({
  darkMode: null  // Use null for "not yet loaded"
})
</script>

<template>
  <!-- Now ThemeToggle can distinguish between null and false -->
  <ThemeToggle :darkMode="userPreferences.darkMode" />
</template>
```

## TypeScript Type Accuracy

The Vue type system handles this, but it can be confusing:

```typescript
interface Props {
  disabled?: boolean
}

const props = defineProps<Props>()

// At compile time: boolean | undefined
// At runtime: boolean (never undefined due to Vue's boolean casting)

// TypeScript is technically "wrong" here, but the withDefaults usage
// or explicit false default can help align expectations
```

## Reference
- [Vue.js Props - Boolean Casting](https://vuejs.org/guide/components/props.html#boolean-casting)
- [GitHub Issue: Boolean props default to false](https://github.com/vuejs/core/issues/8576)
- [TypeScript Vue 3 Props](https://madewithlove.com/blog/typescript-vue-3-and-strongly-typed-props/)
