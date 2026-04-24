---
title: Cannot Mix Runtime and Type Declarations in defineEmits
impact: HIGH
impactDescription: Using both array/object syntax AND TypeScript generics in defineEmits causes compile errors
type: gotcha
tags: [vue3, defineEmits, typescript, compilation-error, script-setup]
---

# Cannot Mix Runtime and Type Declarations in defineEmits

**Impact: HIGH** - `defineEmits` supports two declaration styles: runtime (array/object syntax) and type-based (TypeScript generics). You CANNOT use both at the same time. Attempting to do so results in a compile-time error.

This is a common mistake when learning Vue 3 with TypeScript.

## Task Checklist

- [ ] Choose ONE declaration style: runtime OR type-based
- [ ] For TypeScript projects, prefer type-based declaration
- [ ] For JavaScript projects, use runtime (array/object) declaration
- [ ] Never pass arguments when using generic type parameter

## The Problem

**Incorrect - Mixing both styles:**
```vue
<script setup lang="ts">
// ERROR: Cannot use both type argument and runtime argument
const emit = defineEmits<{
  submit: [data: FormData]
}>(['submit'])  // This array argument causes the error!
</script>
```

**Compiler error:**
```
defineEmits() cannot accept both type and non-type arguments at the same time.
Use one or the other.
```

**Also incorrect:**
```vue
<script setup lang="ts">
// ERROR: Same problem with object syntax
const emit = defineEmits<{
  submit: [data: FormData]
}>({
  submit: (data) => !!data
})
</script>
```

## Correct: Type-Based Declaration (TypeScript)

```vue
<script setup lang="ts">
// CORRECT: Type argument only, no runtime argument
const emit = defineEmits<{
  submit: [data: FormData]
  cancel: []
  'update:modelValue': [value: string]
}>()

emit('submit', formData)  // TypeScript validates this
emit('cancel')
emit('unknown')  // TypeScript error: unknown event
</script>
```

**Alternative call signature syntax:**
```vue
<script setup lang="ts">
const emit = defineEmits<{
  (e: 'submit', data: FormData): void
  (e: 'cancel'): void
  (e: 'update:modelValue', value: string): void
}>()
</script>
```

## Correct: Runtime Declaration (JavaScript or Simple Cases)

**Array syntax:**
```vue
<script setup>
// CORRECT: Runtime array, no type argument
const emit = defineEmits(['submit', 'cancel', 'update:modelValue'])

emit('submit', formData)
emit('cancel')
</script>
```

**Object syntax with validation:**
```vue
<script setup>
// CORRECT: Runtime object for validation
const emit = defineEmits({
  submit: (data) => {
    if (!data?.email) {
      console.warn('Missing email')
      return false
    }
    return true
  },
  cancel: null  // No validation
})
</script>
```

## Adding Validation to Type-Based Emits

If you want TypeScript types AND runtime validation, define the validator separately:

```vue
<script setup lang="ts">
interface FormData {
  email: string
  message: string
}

// Type-based declaration for TypeScript
const emit = defineEmits<{
  submit: [data: FormData]
}>()

// Separate validation function
function emitSubmit(data: FormData) {
  if (!data.email.includes('@')) {
    console.warn('Invalid email format')
    return
  }
  emit('submit', data)
}
</script>

<template>
  <button @click="emitSubmit(formData)">Submit</button>
</template>
```

## Choosing Between Styles

| Style | Use When | Benefits |
|-------|----------|----------|
| Type-based | TypeScript project | Compile-time checking, IDE support |
| Array | JavaScript, simple events | Simple, no types needed |
| Object | Need runtime validation | Validates payloads at runtime |

**Recommendation:** In TypeScript projects, use type-based declaration. It provides the best developer experience with autocompletion and type checking.

## Same Rule Applies to defineProps

This restriction also applies to `defineProps`:

```vue
<script setup lang="ts">
// ERROR: Cannot mix
const props = defineProps<{ name: string }>({ name: String })

// CORRECT: Type-based only
const props = defineProps<{ name: string }>()

// CORRECT: Runtime only
const props = defineProps({ name: String })
</script>
```

## Reference
- [Vue.js SFC script setup - defineEmits](https://vuejs.org/api/sfc-script-setup.html#defineprops-defineemits)
- [Vue.js TypeScript with Composition API](https://vuejs.org/guide/typescript/composition-api.html#typing-component-emits)
