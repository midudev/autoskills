---
title: Provide/Inject Values Are Not Reactive by Default
impact: HIGH
impactDescription: Provided primitive values lose reactivity, causing injecting components to not update when the source value changes
type: gotcha
tags: [vue3, provide-inject, reactivity, composition-api, options-api]
---

# Provide/Inject Values Are Not Reactive by Default

**Impact: HIGH** - A common misconception is that provide/inject automatically maintains reactivity. By default, provided primitive values are NOT reactive. If the provided value changes in the provider, injecting components will NOT be updated.

## Task Checklist

- [ ] Always wrap primitive values in `ref()` before providing
- [ ] Use `computed()` in Options API `provide()` for reactive data
- [ ] Never destructure refs when providing - pass the ref directly
- [ ] Understand that provided refs are NOT auto-unwrapped in injectors

## The Gotcha: Primitives Lose Reactivity

**Wrong - Primitive loses reactivity:**
```vue
<!-- Provider.vue -->
<script setup>
import { ref, provide } from 'vue'

const count = ref(0)

// WRONG: Providing the unwrapped value loses reactivity
provide('count', count.value) // Provides 0, not a reactive value

function increment() {
  count.value++ // Injector will NOT see this change
}
</script>
```

```vue
<!-- Injector.vue -->
<script setup>
import { inject } from 'vue'

const count = inject('count') // Gets 0, forever static
</script>

<template>
  <!-- This will always show 0 -->
  <div>Count: {{ count }}</div>
</template>
```

**Correct - Provide the ref itself:**
```vue
<!-- Provider.vue -->
<script setup>
import { ref, provide } from 'vue'

const count = ref(0)

// CORRECT: Provide the ref, not the value
provide('count', count)

function increment() {
  count.value++ // Injector WILL see this change
}
</script>
```

```vue
<!-- Injector.vue -->
<script setup>
import { inject } from 'vue'

// The ref is injected as-is, maintaining reactivity
const count = inject('count')
</script>

<template>
  <!-- Access .value in script, auto-unwrapped in template -->
  <div>Count: {{ count }}</div>
</template>
```

## Options API: Use computed() for Reactivity

In Options API, the `provide` option with plain properties is NOT reactive:

**Wrong - Options API without computed:**
```js
export default {
  data() {
    return {
      message: 'Hello'
    }
  },
  // WRONG: This is NOT reactive
  provide() {
    return {
      message: this.message // Provides 'Hello' as a static string
    }
  }
}
```

**Correct - Use computed() in Options API:**
```js
import { computed } from 'vue'

export default {
  data() {
    return {
      message: 'Hello'
    }
  },
  provide() {
    return {
      // CORRECT: Wrap in computed for reactivity
      message: computed(() => this.message)
    }
  }
}
```

## Understanding Ref Behavior in Inject

When you provide a ref, it is injected as-is and NOT auto-unwrapped:

```vue
<!-- Provider.vue -->
<script setup>
import { ref, provide } from 'vue'

const user = ref({ name: 'John' })
provide('user', user)
</script>
```

```vue
<!-- Injector.vue -->
<script setup>
import { inject } from 'vue'

const user = inject('user')

// In script, access with .value
console.log(user.value.name) // 'John'

function updateName(newName) {
  user.value.name = newName // Works, but mutations should be in provider
}
</script>

<template>
  <!-- In template, auto-unwrapped at top level -->
  <div>{{ user.name }}</div>
</template>
```

## Providing Reactive Objects

Reactive objects (created with `reactive()`) maintain reactivity when provided:

```vue
<!-- Provider.vue -->
<script setup>
import { reactive, provide } from 'vue'

const state = reactive({
  count: 0,
  message: 'Hello'
})

provide('state', state)
</script>
```

```vue
<!-- Injector.vue -->
<script setup>
import { inject } from 'vue'

const state = inject('state')
// state.count and state.message are reactive
</script>
```

## Common Mistake: Destructuring Breaks Reactivity

**Wrong - Destructuring provided reactive state:**
```vue
<script setup>
import { inject } from 'vue'

// WRONG: Destructuring loses reactivity
const { count, message } = inject('state')
// count and message are now static values
</script>
```

**Correct - Keep the reference intact:**
```vue
<script setup>
import { inject, toRefs } from 'vue'

const state = inject('state')
// Use state.count and state.message directly

// Or use toRefs if you need destructured reactive refs
const { count, message } = toRefs(state)
</script>
```

## Debugging Tip

If your injected value isn't updating:

1. Check if you provided `ref.value` instead of `ref`
2. Check if you destructured a reactive object
3. In Options API, ensure you used `computed()`
4. Use Vue DevTools to inspect the provided values

## Reference
- [Vue.js Provide/Inject - Working with Reactivity](https://vuejs.org/guide/components/provide-inject.html#working-with-reactivity)
- [How to make provide/inject reactive - LogRocket Blog](https://blog.logrocket.com/how-to-make-provide-inject-reactive/)
- [GitHub Issue: Inject/Provide is not reactive](https://github.com/vuejs/vue/issues/7017)
