---
title: Include Parentheses When Calling Store Methods in Templates
impact: MEDIUM
impactDescription: Omitting parentheses on store method calls loses the correct 'this' context, causing unexpected behavior
type: gotcha
tags: [vue3, state-management, reactive, methods, templates, this-binding]
---

# Include Parentheses When Calling Store Methods in Templates

**Impact: MEDIUM** - When calling methods on a reactive store object in Vue templates, you must include parentheses (even without arguments) to ensure the method is called with the correct `this` context. Without parentheses, `this` inside the method may not refer to the store.

This is a subtle gotcha that can cause hard-to-debug issues with hand-rolled reactive stores.

## Task Checklist

- [ ] Always use parentheses when calling store methods in templates: `@click="store.increment()"`
- [ ] Avoid passing store methods as bare references: `@click="store.increment"` is problematic
- [ ] Consider using arrow functions or Pinia (which handles this automatically)
- [ ] Test store method calls work correctly with `this` references

## The Problem

```javascript
// store.js
import { reactive } from 'vue'

export const store = reactive({
  count: 0,
  increment() {
    this.count++  // 'this' should refer to the store
  }
})
```

```vue
<template>
  <!-- WRONG: Without parentheses, 'this' binding may be lost -->
  <button @click="store.increment">
    {{ store.count }}
  </button>
</template>
```

When you write `@click="store.increment"` (without parentheses), Vue passes the method as a callback to the event handler. The method gets called without being bound to the store object, so `this` inside `increment()` may be `undefined` or the global object instead of the store.

## The Solution

```vue
<template>
  <!-- CORRECT: With parentheses, method is called with correct context -->
  <button @click="store.increment()">
    {{ store.count }}
  </button>
</template>
```

With parentheses, you're telling Vue to call `store.increment()` directly, which preserves the `this` context as the store object.

## Why This Happens

In JavaScript, when you reference a method without calling it, you get the function itself without its binding:

```javascript
const store = {
  count: 0,
  increment() {
    this.count++
  }
}

// With parentheses - correct context
store.increment()  // this === store ✓

// Without parentheses - getting the function
const fn = store.increment
fn()  // this === undefined (in strict mode) ✗
```

Vue's event handler behavior:
- `@click="store.increment"` - Vue receives `store.increment` as a function and calls it later
- `@click="store.increment()"` - Vue evaluates `store.increment()` when the event fires

## Alternative Solutions

### 1. Use Arrow Functions in the Template

```vue
<template>
  <button @click="() => store.increment()">
    {{ store.count }}
  </button>
</template>
```

### 2. Bind Methods in the Store Definition

```javascript
// store.js
import { reactive } from 'vue'

const state = reactive({
  count: 0
})

// Methods defined separately, arrow functions don't have 'this' issues
export const store = {
  get count() { return state.count },
  increment: () => { state.count++ }
}
```

### 3. Use Pinia (Recommended)

Pinia handles method binding correctly:

```javascript
// stores/counter.js
import { defineStore } from 'pinia'

export const useCounterStore = defineStore('counter', {
  state: () => ({ count: 0 }),
  actions: {
    increment() {
      this.count++  // Pinia ensures 'this' is correct
    }
  }
})
```

```vue
<script setup>
import { useCounterStore } from '@/stores/counter'
const counter = useCounterStore()
</script>

<template>
  <!-- Both work correctly with Pinia -->
  <button @click="counter.increment">Works</button>
  <button @click="counter.increment()">Also works</button>
</template>
```

### 4. Wrap in a Local Function

```vue
<script setup>
import { store } from './store'

// Wrap store method to ensure correct binding
function increment() {
  store.increment()
}
</script>

<template>
  <!-- Now safe to use without parentheses -->
  <button @click="increment">
    {{ store.count }}
  </button>
</template>
```

## When This Matters

This gotcha specifically affects:
- Hand-rolled reactive stores using `reactive()`
- Methods that reference `this` inside them
- Direct method references in templates without parentheses

It does NOT affect:
- Pinia stores (methods are auto-bound)
- Arrow function methods (no `this` binding)
- Methods that don't use `this`
- Method calls with parentheses

## Quick Reference

| Pattern | Safe? | Notes |
|---------|-------|-------|
| `@click="store.method()"` | Yes | Explicit call preserves context |
| `@click="store.method"` | No* | Context may be lost |
| `@click="() => store.method()"` | Yes | Arrow wrapper preserves context |
| `@click="localMethod"` | Yes | Component methods are auto-bound |
| Pinia: `@click="store.action"` | Yes | Pinia handles binding |

*Only problematic if the method uses `this`

## Reference
- [Vue.js State Management - Tip on Method Binding](https://vuejs.org/guide/scaling-up/state-management.html#simple-state-management-with-reactivity-api)
- [MDN - this in JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/this)
