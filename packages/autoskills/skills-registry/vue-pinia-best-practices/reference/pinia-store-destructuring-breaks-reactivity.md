---
title: Use storeToRefs When Destructuring Pinia Stores
impact: HIGH
impactDescription: Destructuring Pinia stores directly breaks reactivity - state changes won't trigger UI updates
type: gotcha
tags: [vue3, pinia, state-management, reactivity, destructuring]
---

# Use storeToRefs When Destructuring Pinia Stores

**Impact: HIGH** - Pinia stores are wrapped with `reactive`, so destructuring them directly extracts non-reactive values. Changes to the store won't be reflected in your component, causing stale UI and confusing bugs.

This is one of the most common mistakes when using Pinia, especially for developers coming from Vuex or other state management libraries.

## Task Checklist

- [ ] Never destructure state or getters directly from a Pinia store
- [ ] Use `storeToRefs()` to extract reactive state and getters
- [ ] Destructure actions directly (they don't need reactivity)
- [ ] Remember: `storeToRefs` is for state/getters, direct destructure is for actions

## The Problem: Direct Destructuring

```vue
<script setup>
import { useUserStore } from '@/stores/user'

const userStore = useUserStore()

// WRONG: Direct destructuring breaks reactivity
const { name, email, isLoggedIn } = userStore

// Later, when store updates...
userStore.login({ name: 'John', email: 'john@example.com' })

// name and email are still the OLD values!
// UI won't update because these are no longer reactive
console.log(name) // undefined (or initial value)
</script>

<template>
  <!-- This won't update when store changes -->
  <div>{{ name }}</div>
</template>
```

## The Solution: Use storeToRefs

```vue
<script setup>
import { storeToRefs } from 'pinia'
import { useUserStore } from '@/stores/user'

const userStore = useUserStore()

// CORRECT: Use storeToRefs for state and getters
const { name, email, isLoggedIn } = storeToRefs(userStore)

// Actions can be destructured directly (they're just functions)
const { login, logout } = userStore

// Now when the store updates...
login({ name: 'John', email: 'john@example.com' })

// name and email are reactive refs that update automatically
console.log(name.value) // 'John'
</script>

<template>
  <!-- This updates reactively -->
  <div>{{ name }}</div>
  <button @click="logout">Logout</button>
</template>
```

## Understanding Why This Happens

Pinia stores are reactive objects (like `reactive()`). When you destructure:

```javascript
const store = useCounterStore()
// store is a reactive Proxy

const { count } = store
// count is now just a primitive number (0), not reactive
// It's like doing: const count = 0

// vs with storeToRefs
const { count } = storeToRefs(store)
// count is now a ref that stays connected to the store
// It's like: const count = computed(() => store.count)
```

## Complete Pattern: State, Getters, and Actions

```vue
<script setup>
import { storeToRefs } from 'pinia'
import { useCartStore } from '@/stores/cart'

const cartStore = useCartStore()

// State and getters: USE storeToRefs
const {
  items,           // state
  itemCount,       // getter
  totalPrice,      // getter
  isEmpty          // getter
} = storeToRefs(cartStore)

// Actions: destructure directly
const {
  addItem,
  removeItem,
  clearCart
} = cartStore
</script>

<template>
  <div v-if="isEmpty">Cart is empty</div>
  <div v-else>
    <p>{{ itemCount }} items - ${{ totalPrice }}</p>
    <ul>
      <li v-for="item in items" :key="item.id">
        {{ item.name }}
        <button @click="removeItem(item.id)">Remove</button>
      </li>
    </ul>
    <button @click="clearCart">Clear All</button>
  </div>
</template>
```

## Alternative: Don't Destructure

If you prefer, you can avoid destructuring entirely:

```vue
<script setup>
import { useUserStore } from '@/stores/user'

const userStore = useUserStore()
// Use userStore.name, userStore.login(), etc. directly
</script>

<template>
  <div>{{ userStore.name }}</div>
  <button @click="userStore.logout()">Logout</button>
</template>
```

This works fine but is more verbose for stores used frequently in the template.

## Common Mistake: Mixing storeToRefs with Actions

```vue
<script setup>
import { storeToRefs } from 'pinia'
import { useUserStore } from '@/stores/user'

const userStore = useUserStore()

// WRONG: Don't include actions in storeToRefs
// Actions are just functions and storeToRefs will skip them anyway
const { name, login } = storeToRefs(userStore)
// login is undefined! Actions aren't included in storeToRefs result

// CORRECT: Separate state/getters from actions
const { name } = storeToRefs(userStore)
const { login } = userStore
</script>
```

## TypeScript Tip

With TypeScript, the types work correctly:

```typescript
import { storeToRefs } from 'pinia'
import { useUserStore } from '@/stores/user'

const userStore = useUserStore()

// name is Ref<string>, email is Ref<string>
const { name, email } = storeToRefs(userStore)

// login is (credentials: Credentials) => Promise<void>
const { login } = userStore
```

## Reference
- [Pinia - Destructuring from a Store](https://pinia.vuejs.org/core-concepts/#destructuring-from-a-store)
- [Pinia API - storeToRefs](https://pinia.vuejs.org/api/modules/pinia.html#storetorefs)
