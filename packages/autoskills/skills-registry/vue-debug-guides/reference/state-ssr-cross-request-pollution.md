---
title: Prevent Cross-Request State Pollution in SSR Applications
impact: CRITICAL
impactDescription: Singleton stores in SSR share state across all server requests, potentially leaking user data between requests
type: gotcha
tags: [vue3, ssr, state-management, pinia, vuex, security, server-side-rendering, nuxt]
---

# Prevent Cross-Request State Pollution in SSR Applications

**Impact: CRITICAL** - In Server-Side Rendering (SSR) applications, a singleton store pattern creates a single instance that is shared across all server requests. This means data from one user's request could leak into another user's response, causing serious security and data integrity issues.

This is one of the most critical gotchas in Vue state management that can have severe production consequences.

## Task Checklist

- [ ] Never use a singleton store pattern in SSR applications
- [ ] Create a fresh store instance per request when using SSR
- [ ] Use Pinia which handles SSR state management correctly
- [ ] Test SSR state isolation with concurrent requests
- [ ] Review any global reactive state for SSR compatibility

## The Problem: Singleton State in SSR

```javascript
// store.js - DANGEROUS for SSR
import { reactive } from 'vue'

// This is a singleton - same instance for ALL requests
export const store = reactive({
  user: null,
  cart: [],
  preferences: {}
})
```

**What happens in SSR:**

1. Request A comes in for User A
2. Server sets `store.user = userA`
3. Before response completes, Request B arrives for User B
4. Request B sees `store.user = userA` (User A's data leaked!)
5. Server sets `store.user = userB`
6. Request A's response might now contain User B's data

This creates unpredictable behavior and potential security vulnerabilities.

## Solution 1: Use Pinia (Recommended)

Pinia handles SSR correctly by creating fresh store instances per request:

```javascript
// stores/user.js
import { defineStore } from 'pinia'

export const useUserStore = defineStore('user', {
  state: () => ({
    user: null,
    preferences: {}
  }),
  actions: {
    setUser(user) {
      this.user = user
    }
  }
})
```

```javascript
// main.js (or entry-server.js)
import { createPinia } from 'pinia'
import { createApp } from 'vue'
import App from './App.vue'

// For SSR: Create fresh instances per request
export function createAppInstance() {
  const app = createApp(App)
  const pinia = createPinia()

  app.use(pinia)

  return { app, pinia }
}
```

```javascript
// entry-server.js
import { createAppInstance } from './main'
import { renderToString } from 'vue/server-renderer'

export async function render(url, context) {
  // Fresh app and store instance per request
  const { app, pinia } = createAppInstance()

  // ... setup router, fetch data, etc.

  const html = await renderToString(app)

  // Serialize state for client hydration
  const state = pinia.state.value

  return { html, state }
}
```

```javascript
// entry-client.js - Hydrate from serialized state
import { createAppInstance } from './main'

const { app, pinia } = createAppInstance()

// Restore server state before mounting
if (window.__PINIA_STATE__) {
  pinia.state.value = window.__PINIA_STATE__
}

app.mount('#app')
```

## Solution 2: Factory Pattern for Hand-Rolled State

If not using Pinia, create a factory function:

```javascript
// store.js - SSR-safe with factory
import { reactive, readonly } from 'vue'

// Factory function creates fresh state per call
export function createStore() {
  const state = reactive({
    user: null,
    cart: [],
    preferences: {}
  })

  return {
    state: readonly(state),
    setUser(user) {
      state.user = user
    },
    addToCart(item) {
      state.cart.push(item)
    }
  }
}
```

```javascript
// entry-server.js
import { createStore } from './store'
import { provide } from 'vue'

export async function render(url) {
  const app = createApp(App)

  // Fresh store instance for this request only
  const store = createStore()
  app.provide('store', store)

  // ... render
}
```

## Solution 3: Context-Based State (Advanced)

For frameworks like Nuxt, use request context:

```javascript
// composables/useRequestState.js
import { useSSRContext } from 'vue'

export function useRequestState(key, initialValue) {
  if (import.meta.env.SSR) {
    const ctx = useSSRContext()
    ctx.state = ctx.state || {}

    if (!(key in ctx.state)) {
      ctx.state[key] = initialValue()
    }

    return ctx.state[key]
  }

  // Client-side: use regular reactive state
  return reactive(initialValue())
}
```

## Nuxt.js Handles This Automatically

In Nuxt 3, state isolation is handled automatically:

```javascript
// Nuxt automatically creates fresh Pinia instance per request
// You can use stores normally

export default defineNuxtPlugin(async (nuxtApp) => {
  const userStore = useUserStore()
  await userStore.fetchUser()
})
```

## Testing for State Pollution

```javascript
// test/ssr-state-isolation.test.js
import { describe, it, expect } from 'vitest'
import { render } from './entry-server'

describe('SSR State Isolation', () => {
  it('should not leak state between concurrent requests', async () => {
    // Simulate concurrent requests
    const [result1, result2] = await Promise.all([
      render('/user/1', { userId: '1' }),
      render('/user/2', { userId: '2' })
    ])

    // Each should have their own user data
    expect(result1.html).toContain('User 1')
    expect(result2.html).toContain('User 2')

    // State should not be mixed
    expect(result1.html).not.toContain('User 2')
    expect(result2.html).not.toContain('User 1')
  })
})
```

```javascript
// Alternative: Test store isolation directly
import { createApp } from './app.js'

test('requests do not share state', async () => {
  // Simulate two concurrent requests
  const { app: app1, store: store1 } = createApp()
  const { app: app2, store: store2 } = createApp()

  store1.user = { id: 1, name: 'Alice' }
  store2.user = { id: 2, name: 'Bob' }

  // Each should have its own state
  expect(store1.user.name).toBe('Alice')
  expect(store2.user.name).toBe('Bob')
})
```

## Red Flags to Watch For

```javascript
// ANY module-level reactive state is dangerous in SSR

// BAD: Module-level reactive
export const globalUser = ref(null)

// BAD: Module-level reactive object
export const appState = reactive({})

// BAD: Shared Map/Set
export const cache = new Map()

// BAD: Even plain objects can be problematic
let requestCount = 0  // Shared across requests
```

## Why Pinia is Recommended for SSR

1. **Automatic request isolation** - Fresh store instances per request
2. **Built-in state serialization** - Easy hydration on client
3. **DevTools support** - Debug state on both server and client
4. **TypeScript support** - Type-safe state management
5. **Tested patterns** - Battle-tested SSR handling

## Reference
- [Vue.js State Management - SSR Considerations](https://vuejs.org/guide/scaling-up/state-management.html#ssr-considerations)
- [Pinia SSR Guide](https://pinia.vuejs.org/ssr/)
- [Vue SSR Guide](https://vuejs.org/guide/scaling-up/ssr.html)
