---
title: Template Refs Are Null Until Mounted
impact: HIGH
impactDescription: Accessing template ref before mount or after unmount causes runtime errors
type: gotcha
tags: [vue3, typescript, template-refs, lifecycle, null-safety]
---

# Template Refs Are Null Until Mounted

**Impact: HIGH** - Template refs have an initial value of `null` and remain null until the component mounts. They can also become null again if the referenced element is removed by `v-if`. Always account for this in TypeScript with union types and optional chaining.

## Task Checklist

- [ ] Always type template refs with `| null` union
- [ ] Only access refs inside `onMounted` or after
- [ ] Use optional chaining (`?.`) when accessing ref properties
- [ ] Handle `v-if` scenarios where ref can become null again
- [ ] Consider using `useTemplateRef` in Vue 3.5+

## The Problem

```vue
<script setup lang="ts">
import { ref } from 'vue'

// WRONG: Doesn't account for null
const inputRef = ref<HTMLInputElement>()

// WRONG: Will crash if accessed before mount
inputRef.value.focus()  // Error: Cannot read properties of null

// WRONG: Accessed in setup, element doesn't exist yet
console.log(inputRef.value.value)  // Error!
</script>

<template>
  <input ref="inputRef" />
</template>
```

## The Solution

```vue
<script setup lang="ts">
import { ref, onMounted } from 'vue'

// CORRECT: Include null in the type
const inputRef = ref<HTMLInputElement | null>(null)

// CORRECT: Access in onMounted when DOM exists
onMounted(() => {
  inputRef.value?.focus()  // Safe with optional chaining
})

// CORRECT: Guard before accessing
function focusInput() {
  if (inputRef.value) {
    inputRef.value.focus()
  }
}
</script>

<template>
  <input ref="inputRef" />
</template>
```

## Vue 3.5+: useTemplateRef

Vue 3.5 introduces `useTemplateRef` with better type inference:

```vue
<script setup lang="ts">
import { useTemplateRef, onMounted } from 'vue'

// Type is automatically inferred for static refs
const inputRef = useTemplateRef<HTMLInputElement>('input')

onMounted(() => {
  inputRef.value?.focus()
})
</script>

<template>
  <input ref="input" />
</template>
```

## Handling v-if Scenarios

Refs can become `null` when elements are conditionally rendered:

```vue
<script setup lang="ts">
import { ref, watch } from 'vue'

const showModal = ref(false)
const modalRef = ref<HTMLDivElement | null>(null)

// WRONG: Assuming ref always exists after first mount
function closeModal() {
  modalRef.value.classList.remove('open')  // May be null!
}

// CORRECT: Always guard access
function closeModal() {
  modalRef.value?.classList.remove('open')
}

// CORRECT: Watch for ref changes
watch(modalRef, (newRef) => {
  if (newRef) {
    // Modal element just mounted
    newRef.focus()
  }
  // If null, modal was unmounted
})
</script>

<template>
  <div v-if="showModal" ref="modalRef" class="modal">
    Modal content
  </div>
</template>
```

## Component Refs

For component refs, use `InstanceType`:

```vue
<script setup lang="ts">
import { ref, onMounted } from 'vue'
import ChildComponent from './ChildComponent.vue'

// Component ref with null
const childRef = ref<InstanceType<typeof ChildComponent> | null>(null)

onMounted(() => {
  // Access exposed methods/properties
  childRef.value?.exposedMethod()
})
</script>

<template>
  <ChildComponent ref="childRef" />
</template>
```

Remember: Child components must use `defineExpose` to expose methods:

```vue
<!-- ChildComponent.vue -->
<script setup lang="ts">
function exposedMethod() {
  console.log('Called from parent')
}

defineExpose({
  exposedMethod
})
</script>
```

## Multiple Refs with v-for

```vue
<script setup lang="ts">
import { ref, onMounted } from 'vue'

const items = ref(['a', 'b', 'c'])

// Array of refs for v-for
const itemRefs = ref<(HTMLLIElement | null)[]>([])

onMounted(() => {
  // Access specific item
  itemRefs.value[0]?.focus()

  // Iterate safely
  itemRefs.value.forEach(el => {
    el?.classList.add('mounted')
  })
})
</script>

<template>
  <ul>
    <li
      v-for="(item, index) in items"
      :key="item"
      :ref="el => { itemRefs[index] = el as HTMLLIElement }"
    >
      {{ item }}
    </li>
  </ul>
</template>
```

## Async Operations and Refs

Be careful with async operations:

```vue
<script setup lang="ts">
import { ref, onMounted } from 'vue'

const containerRef = ref<HTMLDivElement | null>(null)

onMounted(async () => {
  // containerRef.value exists here

  await fetchData()

  // CAREFUL: Component might have unmounted during await
  // Always re-check before accessing
  if (containerRef.value) {
    containerRef.value.scrollTop = 0
  }
})
</script>
```

## Type Guard Pattern

Create a reusable type guard for cleaner code:

```typescript
// utils/refs.ts
export function assertRef<T>(
  ref: Ref<T | null>,
  message = 'Ref is not available'
): asserts ref is Ref<T> {
  if (ref.value === null) {
    throw new Error(message)
  }
}

// Usage in component
function mustFocus() {
  assertRef(inputRef, 'Input element not mounted')
  inputRef.value.focus()  // TypeScript knows it's not null here
}
```

## Reference
- [Vue.js TypeScript with Composition API - Template Refs](https://vuejs.org/guide/typescript/composition-api.html#typing-template-refs)
- [Vue.js Template Refs](https://vuejs.org/guide/essentials/template-refs.html)
