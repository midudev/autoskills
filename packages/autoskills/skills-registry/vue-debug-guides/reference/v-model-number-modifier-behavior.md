---
title: v-model.number Uses parseFloat Not valueAsNumber
impact: MEDIUM
impactDescription: .number modifier returns empty string for empty input and uses parseFloat, not native valueAsNumber
type: capability
tags: [vue3, v-model, forms, input, number, type-coercion, modifiers]
---

# v-model.number Uses parseFloat Not valueAsNumber

**Impact: MEDIUM** - The `.number` modifier doesn't behave like the native `valueAsNumber` property. It returns an empty string (not NaN) for empty inputs, and uses `parseFloat()` which has different parsing rules. This can cause unexpected type issues in calculations and validations.

Understanding these differences is crucial when working with numeric forms, especially for calculations, min/max validation, or when interfacing with APIs that expect strict number types.

## Task Checklist

- [ ] Expect empty string (not 0 or NaN) when input is cleared with `.number` modifier
- [ ] Handle the empty string case in your validation and calculations
- [ ] Remember `.number` uses parseFloat - "123abc" becomes 123, not NaN
- [ ] For strict numeric parsing, add custom validation

**Key Differences:**

| Scenario | `.number` modifier | Native `valueAsNumber` |
|----------|-------------------|----------------------|
| Empty input | `''` (empty string) | `NaN` |
| `"123"` | `123` | `123` |
| `"123.45"` | `123.45` | `123.45` |
| `"123abc"` | `123` | `NaN` |
| `"abc"` | `'abc'` (original string) | `NaN` |

**Problem - Unexpected types:**
```html
<script setup>
import { ref, computed } from 'vue'

const price = ref(0)
const quantity = ref(1)

const total = computed(() => {
  // PROBLEM: price might be '' (empty string) when input is cleared
  return price.value * quantity.value  // '' * 1 = 0, but typeof is still number
})

function validatePrice() {
  // PROBLEM: This check fails when input is empty
  if (typeof price.value !== 'number') {
    // Never enters here! '' is still treated as "processed"
  }

  // PROBLEM: parseFloat("$100") returns NaN, but "100abc" returns 100
}
</script>

<template>
  <input v-model.number="price" type="number">
  <!-- When user clears input, price.value becomes '' not 0 or NaN -->
</template>
```

**Solution - Handle empty string explicitly:**
```html
<script setup>
import { ref, computed } from 'vue'

const price = ref(0)
const quantity = ref(1)

const total = computed(() => {
  // CORRECT: Handle empty string case
  const priceNum = price.value === '' ? 0 : price.value
  return priceNum * quantity.value
})

// Or use a wrapper computed for safer access
const safePrice = computed(() => {
  if (price.value === '' || price.value === null) return 0
  return Number(price.value) || 0
})
</script>

<template>
  <input v-model.number="price" type="number" min="0">
  <p>Total: ${{ total.toFixed(2) }}</p>
</template>
```

**Solution - Custom input handling for strict parsing:**
```html
<script setup>
import { ref } from 'vue'

const price = ref(0)

function handlePriceInput(event) {
  const value = event.target.value

  // Strict parsing - only accept valid numbers
  const parsed = parseFloat(value)

  if (value === '') {
    price.value = 0  // Or null, depending on your needs
  } else if (!isNaN(parsed) && isFinite(parsed)) {
    // Additional check: ensure entire string is numeric
    if (/^-?\d*\.?\d+$/.test(value.trim())) {
      price.value = parsed
    }
  }
  // Invalid input - keep previous value
}
</script>

<template>
  <!-- Manual binding for strict numeric control -->
  <input
    :value="price"
    @input="handlePriceInput"
    type="number"
  >
</template>
```

## Reference
- [Vue.js Form Input Bindings - .number](https://vuejs.org/guide/essentials/forms.html#number)
