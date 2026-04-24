---
name: state-management
description: useState composable and SSR-friendly state management in Nuxt
---

# State Management

Nuxt provides `useState` for SSR-friendly reactive state that persists across components.

## useState

SSR-safe replacement for `ref` that shares state across components:

```vue
<script setup lang="ts">
// State is shared by key 'counter' across all components
const counter = useState('counter', () => 0)
</script>

<template>
  <div>
    Counter: {{ counter }}
    <button @click="counter++">+</button>
    <button @click="counter--">-</button>
  </div>
</template>
```

## Creating Shared State

Define reusable state composables:

```ts
// composables/useUser.ts
export function useUser() {
  return useState<User | null>('user', () => null)
}

export function useLocale() {
  return useState('locale', () => 'en')
}
```

```vue
<script setup lang="ts">
// Same state instance everywhere
const user = useUser()
const locale = useLocale()
</script>
```

## Initializing State

Use `callOnce` to initialize state with async data:

```vue
<script setup lang="ts">
const config = useState('site-config')

await callOnce(async () => {
  config.value = await $fetch('/api/config')
})
</script>
```

## Best Practices

### ❌ Don't Define State Outside Setup

```ts
// ❌ Wrong - causes memory leaks and shared state across requests
export const globalState = ref({ user: null })
```

### ✅ Use useState Instead

```ts
// ✅ Correct - SSR-safe
export const useGlobalState = () => useState('global', () => ({ user: null }))
```

## Clearing State

```ts
// Clear specific state
clearNuxtState('counter')

// Clear multiple states
clearNuxtState(['counter', 'user'])

// Clear all state (use with caution)
clearNuxtState()
```

## With Pinia

For complex state management, use Pinia:

```bash
npx nuxi module add pinia
```

```ts
// stores/counter.ts
export const useCounterStore = defineStore('counter', {
  state: () => ({
    count: 0,
  }),
  actions: {
    increment() {
      this.count++
    },
  },
})
```

```ts
// stores/user.ts (Composition API style)
export const useUserStore = defineStore('user', () => {
  const user = ref<User | null>(null)
  const isLoggedIn = computed(() => !!user.value)

  async function login(credentials: Credentials) {
    user.value = await $fetch('/api/login', {
      method: 'POST',
      body: credentials,
    })
  }

  return { user, isLoggedIn, login }
})
```

```vue
<script setup lang="ts">
const counterStore = useCounterStore()
const userStore = useUserStore()

// Initialize store data once
await callOnce(async () => {
  await userStore.fetchUser()
})
</script>
```

## Advanced: Locale Example

```ts
// composables/useLocale.ts
export function useLocale() {
  return useState('locale', () => useDefaultLocale().value)
}

export function useDefaultLocale(fallback = 'en-US') {
  const locale = ref(fallback)

  if (import.meta.server) {
    const reqLocale = useRequestHeaders()['accept-language']?.split(',')[0]
    if (reqLocale) locale.value = reqLocale
  }
  else if (import.meta.client) {
    const navLang = navigator.language
    if (navLang) locale.value = navLang
  }

  return locale
}
```

## State Serialization

`useState` values are serialized to JSON. Avoid:

- Functions
- Classes
- Symbols
- Circular references

```ts
// ❌ Won't work
useState('fn', () => () => console.log('hi'))
useState('instance', () => new MyClass())

// ✅ Works
useState('data', () => ({ name: 'John', age: 30 }))
useState('items', () => ['a', 'b', 'c'])
```

<!-- 
Source references:
- https://nuxt.com/docs/getting-started/state-management
- https://nuxt.com/docs/api/composables/use-state
- https://nuxt.com/docs/api/utils/clear-nuxt-state
-->
