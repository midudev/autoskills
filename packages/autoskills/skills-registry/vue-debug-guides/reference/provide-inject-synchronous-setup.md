---
title: Provide Must Be Called Synchronously During Setup
impact: HIGH
impactDescription: Calling provide() asynchronously or conditionally may fail silently or cause inconsistent injection behavior
type: gotcha
tags: [vue3, provide-inject, composition-api, async, setup]
---

# Provide Must Be Called Synchronously During Setup

**Impact: HIGH** - The `provide()` function must be called synchronously during the component's `setup()` phase. Calling it asynchronously (inside callbacks, promises, or after await) will fail silently, and descendant components will not receive the provided value.

## Task Checklist

- [ ] Always call `provide()` at the top level of `setup()` or `<script setup>`
- [ ] Never call `provide()` inside async callbacks or after await statements
- [ ] For async data, provide a ref first, then update its value later
- [ ] Use immediate `provide()` with reactive containers for dynamic data

## The Gotcha: Async Provide Fails Silently

**Wrong - Provide after async operation:**
```vue
<script setup>
import { provide } from 'vue'

// WRONG: provide() called after await - will NOT work
onMounted(async () => {
  const userData = await fetchUser()
  provide('user', userData) // Silent failure!
})
</script>
```

**Wrong - Provide inside callback:**
```vue
<script setup>
import { provide } from 'vue'

// WRONG: provide() inside callback - will NOT work
setTimeout(() => {
  provide('config', { theme: 'dark' }) // Silent failure!
}, 0)
</script>
```

**Wrong - Provide after await in setup:**
```vue
<script setup>
import { provide } from 'vue'

const response = await fetch('/api/config')
const config = await response.json()

// WRONG: This is after an await, setup context may be lost
provide('config', config) // May not work reliably
</script>
```

## Solution: Provide Synchronously, Update Async

**Correct - Provide ref immediately, update later:**
```vue
<script setup>
import { provide, ref, onMounted } from 'vue'

// Provide immediately with initial value
const user = ref(null)
const isLoading = ref(true)
const error = ref(null)

provide('userState', {
  user,
  isLoading,
  error
})

// Update the ref values asynchronously
onMounted(async () => {
  try {
    const userData = await fetchUser()
    user.value = userData
  } catch (e) {
    error.value = e
  } finally {
    isLoading.value = false
  }
})
</script>
```

```vue
<!-- Consumer component -->
<script setup>
import { inject } from 'vue'

const { user, isLoading, error } = inject('userState')
</script>

<template>
  <div v-if="isLoading">Loading...</div>
  <div v-else-if="error">Error: {{ error.message }}</div>
  <div v-else>Welcome, {{ user?.name }}</div>
</template>
```

## Pattern: Async Data Provider

Create a reusable pattern for async-provided data:

```vue
<!-- AsyncDataProvider.vue -->
<script setup>
import { provide, ref, onMounted, watch } from 'vue'

const props = defineProps({
  fetchFn: {
    type: Function,
    required: true
  },
  provideKey: {
    type: [String, Symbol],
    required: true
  },
  immediate: {
    type: Boolean,
    default: true
  }
})

const data = ref(null)
const isLoading = ref(false)
const error = ref(null)

async function load() {
  isLoading.value = true
  error.value = null

  try {
    data.value = await props.fetchFn()
  } catch (e) {
    error.value = e
  } finally {
    isLoading.value = false
  }
}

// Provide synchronously
provide(props.provideKey, {
  data,
  isLoading,
  error,
  reload: load
})

// Fetch asynchronously
if (props.immediate) {
  onMounted(load)
}
</script>

<template>
  <slot />
</template>
```

Usage:

```vue
<template>
  <AsyncDataProvider
    :fetch-fn="() => api.getUser(userId)"
    provide-key="userData"
  >
    <UserProfile />
  </AsyncDataProvider>
</template>
```

## Why This Happens

Vue's `provide()` relies on the current component instance context, which is only available synchronously during setup. After setup completes:

1. The setup context is cleared
2. `provide()` can't find the current instance
3. The call fails silently (no error thrown)

## Checking for Setup Context

You can verify if setup context is available:

```js
import { getCurrentInstance } from 'vue'

function debugProvide(key, value) {
  const instance = getCurrentInstance()

  if (!instance) {
    console.error(
      `provide() called outside setup context. ` +
      `Key: ${String(key)}. This will fail silently.`
    )
    return
  }

  provide(key, value)
}
```

## App-Level Provide (Exception)

`app.provide()` can be called anytime during app initialization:

```js
// main.js
import { createApp } from 'vue'
import App from './App.vue'

const app = createApp(App)

// This works - app-level provide
app.provide('appConfig', { version: '1.0.0' })

// Even async is OK at app level before mount
fetchConfig().then(config => {
  app.provide('apiConfig', config)
  app.mount('#app')
})
```

But once the app is mounted, `app.provide()` should not be called.

## Reference
- [Vue.js Composition API - provide()](https://vuejs.org/api/composition-api-dependency-injection.html#provide)
- [Vue.js Provide/Inject Guide](https://vuejs.org/guide/components/provide-inject.html)
