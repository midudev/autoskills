---
title: defineEmits Must Be Used at Top Level of script setup
impact: HIGH
impactDescription: Using defineEmits inside functions causes compilation errors - macros must be at module scope
type: gotcha
tags: [vue3, defineEmits, script-setup, macros, composition-api]
---

# defineEmits Must Be Used at Top Level of script setup

**Impact: HIGH** - The `defineEmits()` macro can only be used directly within `<script setup>` at the top level. It cannot be placed inside functions, conditionals, or any other nested scope. Vue's compiler hoists these macros to module scope during compilation.

This applies to all Vue macros: `defineProps`, `defineEmits`, `defineExpose`, `defineOptions`, and `defineSlots`.

## Task Checklist

- [ ] Place `defineEmits()` directly in `<script setup>`, not inside functions
- [ ] Do not wrap macro calls in conditionals or loops
- [ ] Do not reference local variables in macro arguments
- [ ] Store the emit function and reuse it throughout the component

## The Problem

**Incorrect - Inside a function:**
```vue
<script setup>
function useEvents() {
  // ERROR: defineEmits cannot be used inside a function
  const emit = defineEmits(['submit', 'cancel'])
  return emit
}

const emit = useEvents() // This fails at compile time
</script>
```

**Incorrect - Inside a conditional:**
```vue
<script setup>
if (someCondition) {
  // ERROR: Cannot use defineEmits in conditional
  const emit = defineEmits(['eventA'])
} else {
  const emit = defineEmits(['eventB'])
}
</script>
```

**Incorrect - Referencing local variables:**
```vue
<script setup>
const eventNames = ['submit', 'cancel']

// ERROR: Cannot reference local variables
const emit = defineEmits(eventNames)
</script>
```

## Correct Usage

**Correct - Top level declaration:**
```vue
<script setup>
// CORRECT: defineEmits at top level of script setup
const emit = defineEmits(['submit', 'cancel', 'update'])

function handleSubmit() {
  emit('submit', data)
}

function handleCancel() {
  emit('cancel')
}
</script>
```

**Correct - With TypeScript types:**
```vue
<script setup lang="ts">
// CORRECT: Type-based declaration at top level
const emit = defineEmits<{
  submit: [data: FormData]
  cancel: []
  'update:modelValue': [value: string]
}>()

function handleSubmit(data: FormData) {
  emit('submit', data)
}
</script>
```

**Correct - Using constant arrays (compile-time constant):**
```vue
<script setup>
// CORRECT: Literal array is fine
const emit = defineEmits(['submit', 'cancel'])
</script>
```

## Why This Restriction Exists

Vue's compiler processes `<script setup>` macros at compile time, not runtime. The arguments must be statically analyzable so Vue can:

1. Generate the correct component options
2. Provide TypeScript type inference
3. Enable IDE support for event autocompletion
4. Validate emitted events

Since the macro is hoisted out of `<script setup>` during compilation, it cannot access anything that only exists at runtime.

## Using emit in Composables

If you want to share emit logic in a composable, pass the emit function as an argument:

**Correct - Pass emit to composable:**
```vue
<script setup>
const emit = defineEmits(['submit', 'cancel', 'validate'])

// Pass emit to composable
const { handleSubmit, handleCancel } = useFormEvents(emit)
</script>
```

```js
// composables/useFormEvents.js
export function useFormEvents(emit) {
  function handleSubmit(data) {
    emit('submit', data)
  }

  function handleCancel() {
    emit('cancel')
  }

  return { handleSubmit, handleCancel }
}
```

## ESLint Rule

The `eslint-plugin-vue` provides the `vue/valid-define-emits` rule that catches these errors:

```js
// eslint.config.js
export default [
  {
    rules: {
      'vue/valid-define-emits': 'error'
    }
  }
]
```

This rule reports:
- `defineEmits` used inside functions
- `defineEmits` referencing local variables
- Multiple `defineEmits` calls in the same component
- `defineEmits` used outside `<script setup>`

## Reference
- [Vue.js SFC script setup](https://vuejs.org/api/sfc-script-setup.html#defineprops-defineemits)
- [ESLint vue/valid-define-emits](https://eslint.vuejs.org/rules/valid-define-emits)
