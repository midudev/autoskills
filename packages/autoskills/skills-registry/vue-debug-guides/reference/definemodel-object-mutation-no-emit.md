---
title: defineModel Object Properties Must Be Replaced, Not Mutated
impact: HIGH
impactDescription: Mutating object properties via defineModel doesn't emit update events, breaking parent sync
type: gotcha
tags: [vue3, v-model, defineModel, objects, reactivity, two-way-binding]
---

# defineModel Object Properties Must Be Replaced, Not Mutated

**Impact: HIGH** - When using `defineModel()` with objects or arrays, directly mutating nested properties like `model.value.prop = x` does NOT emit the `update:modelValue` event. The parent component never receives the change notification, causing silent sync failures.

This happens because Vue only detects when the `model.value` reference itself changes, not when properties of the object are mutated in place.

## Task Checklist

- [ ] Never mutate object properties directly: `model.value.prop = x`
- [ ] Always create a new object reference when updating: `model.value = {...model.value, prop: x}`
- [ ] For arrays, use spread or slice: `model.value = [...model.value, newItem]`
- [ ] Consider using structuredClone for deeply nested objects

**Incorrect - Mutation without event emission:**
```vue
<script setup>
// Child component with object v-model
const model = defineModel<{ name: string; age: number }>()

function updateName(newName: string) {
  // WRONG: This mutates the object in place
  // Parent receives NO update:modelValue event!
  model.value.name = newName
}

function addToList() {
  // WRONG: Push mutates the array
  model.value.items.push('new item')  // Parent not notified
}
</script>
```

**Correct - Replace object reference to trigger event:**
```vue
<script setup>
const model = defineModel<{ name: string; age: number }>()

function updateName(newName: string) {
  // CORRECT: Create new object reference
  // This triggers update:modelValue event to parent
  model.value = {
    ...model.value,
    name: newName
  }
}

function addToList() {
  // CORRECT: Create new array reference
  model.value = {
    ...model.value,
    items: [...model.value.items, 'new item']
  }
}
</script>
```

## Deep Nesting Requires Full Path Replacement

```vue
<script setup>
const model = defineModel<{
  user: {
    address: {
      city: string
    }
  }
}>()

// WRONG: Deep mutation
model.value.user.address.city = 'New York'

// CORRECT: Replace entire chain
model.value = {
  ...model.value,
  user: {
    ...model.value.user,
    address: {
      ...model.value.user.address,
      city: 'New York'
    }
  }
}

// ALTERNATIVE: Use structuredClone for complex updates
function updateCity(city: string) {
  const updated = structuredClone(model.value)
  updated.user.address.city = city
  model.value = updated  // New reference triggers event
}
</script>
```

## Race Condition Warning with Spread Operator

When multiple updates occur rapidly, earlier changes can be lost:

```vue
<script setup>
const model = defineModel<{ a: string; b: string }>()

// CAUTION: Race condition if called in same tick
function updateBothWrong() {
  model.value = { ...model.value, a: 'new-a' }  // First update
  model.value = { ...model.value, b: 'new-b' }  // May use stale model.value!
}

// CORRECT: Batch updates into single assignment
function updateBothCorrect() {
  model.value = {
    ...model.value,
    a: 'new-a',
    b: 'new-b'
  }
}
</script>
```

## Alternative: VueUse's useVModel with Deep Option

For complex objects, consider VueUse:

```vue
<script setup>
import { useVModel } from '@vueuse/core'

const props = defineProps<{ modelValue: { name: string } }>()
const emit = defineEmits(['update:modelValue'])

// Deep tracking with passive updates
const model = useVModel(props, 'modelValue', emit, { deep: true, passive: true })

// Now direct mutations work
model.value.name = 'New Name'  // Properly syncs with parent
</script>
```

## Reference
- [Vue.js Component v-model](https://vuejs.org/guide/components/v-model.html)
- [GitHub Discussion: defineModel with objects](https://github.com/orgs/vuejs/discussions/10538)
- [SIMPL Engineering: Vue defineModel Pitfalls](https://engineering.simpl.de/post/vue_definemodel/)
