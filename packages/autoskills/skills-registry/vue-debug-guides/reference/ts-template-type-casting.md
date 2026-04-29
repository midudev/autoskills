---
title: Use Type Casting in Templates for Union Types
impact: MEDIUM
impactDescription: Template expressions with union types cause TypeScript errors even when the runtime type is known
type: gotcha
tags: [typescript, templates, type-casting, union-types, script-setup]
---

# Use Type Casting in Templates for Union Types

**Impact: MEDIUM** - When using `lang="ts"` in Vue Single File Components, template expressions get strict type checking. If a variable has a union type, you may need inline type casting to access type-specific methods or properties.

## Task Checklist

- [ ] Use `(value as Type)` syntax for type casting in templates
- [ ] Consider narrowing types in script before using in template
- [ ] Remember template type checking requires `lang="ts"` attribute
- [ ] For Vue CLI/webpack: ensure vue-loader >= 16.8.0

## The Problem

When a variable has a union type, TypeScript cannot know which specific type it is at template compile time:

**Template with type error:**
```vue
<script setup lang="ts">
// Union type: could be string OR number
let x: string | number = 1
</script>

<template>
  <!-- ERROR: Property 'toFixed' does not exist on type 'string | number' -->
  {{ x.toFixed(2) }}
</template>
```

TypeScript correctly identifies that `toFixed()` only exists on `number`, not `string`.

## Solution 1: Inline Type Casting

Use `(value as Type)` syntax directly in the template:

```vue
<script setup lang="ts">
let x: string | number = 1
</script>

<template>
  <!-- CORRECT: Cast to number to access toFixed -->
  {{ (x as number).toFixed(2) }}
</template>
```

## Solution 2: Computed Property (Preferred)

Create a computed property that narrows or transforms the type:

```vue
<script setup lang="ts">
import { ref, computed } from 'vue'

const value = ref<string | number>(1)

const formattedValue = computed(() => {
  if (typeof value.value === 'number') {
    return value.value.toFixed(2)
  }
  return value.value
})
</script>

<template>
  <!-- Clean template, type-safe logic in script -->
  {{ formattedValue }}
</template>
```

## Solution 3: Type Guard Function

Define a type guard and use it in the template:

```vue
<script setup lang="ts">
import { ref } from 'vue'

const data = ref<string | number | null>(null)

function isNumber(val: unknown): val is number {
  return typeof val === 'number'
}

function formatNumber(val: number): string {
  return val.toFixed(2)
}
</script>

<template>
  <div v-if="isNumber(data)">
    {{ formatNumber(data) }}
  </div>
  <div v-else-if="data !== null">
    {{ data }}
  </div>
</template>
```

## Common Use Cases

### API Response Data

```vue
<script setup lang="ts">
interface ApiResponse {
  status: 'success' | 'error'
  data?: UserData
  error?: string
}

const response = ref<ApiResponse | null>(null)
</script>

<template>
  <div v-if="response?.status === 'success'">
    <!-- Cast to access data safely -->
    {{ (response as { data: UserData }).data.name }}
  </div>
</template>
```

**Better approach with computed:**
```vue
<script setup lang="ts">
const userData = computed(() => {
  if (response.value?.status === 'success') {
    return response.value.data
  }
  return null
})
</script>

<template>
  <div v-if="userData">
    {{ userData.name }}
  </div>
</template>
```

### Event Handlers with Event Types

```vue
<script setup lang="ts">
function handleInput(event: Event) {
  // Cast to HTMLInputElement to access 'value'
  const value = (event.target as HTMLInputElement).value
  console.log(value)
}
</script>

<template>
  <input @input="handleInput" />
</template>
```

### Array Item Access

```vue
<script setup lang="ts">
const items = ref<(string | number)[]>([1, 'two', 3])
</script>

<template>
  <ul>
    <li v-for="item in items" :key="item">
      <!-- Cast when you know the type -->
      <span v-if="typeof item === 'number'">
        Number: {{ (item as number).toFixed(1) }}
      </span>
      <span v-else>
        String: {{ (item as string).toUpperCase() }}
      </span>
    </li>
  </ul>
</template>
```

## When Type Casting is Needed

| Scenario | Solution |
|----------|----------|
| Union types | Cast to specific type |
| Nullable types | Use optional chaining or cast after null check |
| Event targets | Cast `event.target` to specific element type |
| Array methods | Cast when TS can't narrow array item types |

## Important Notes

### Template Type Checking Requirements

Template type checking is enabled when:
1. `<script lang="ts">` or `<script setup lang="ts">` is used
2. Vue Language Server (Volar) is active in your IDE
3. For webpack: vue-loader >= 16.8.0 is required

### Avoid Excessive Casting

If you find yourself casting frequently in templates, consider:
- Moving logic to computed properties
- Using type guards in the script section
- Refactoring data structures to be more specific

## Reference

- [Vue.js TypeScript Overview - TypeScript in Templates](https://vuejs.org/guide/typescript/overview.html#typescript-in-templates)
- [Vue.js TypeScript with Composition API](https://vuejs.org/guide/typescript/composition-api.html)
