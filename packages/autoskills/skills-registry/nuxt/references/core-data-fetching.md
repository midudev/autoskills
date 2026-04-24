---
name: data-fetching
description: useFetch, useAsyncData, and $fetch for SSR-friendly data fetching
---

# Data Fetching

Nuxt provides composables for SSR-friendly data fetching that prevent double-fetching and handle hydration.

## Overview

- `$fetch` - Basic fetch utility (use for client-side events)
- `useFetch` - SSR-safe wrapper around $fetch (use for component data)
- `useAsyncData` - SSR-safe wrapper for any async function

## useFetch

Primary composable for fetching data in components:

```vue
<script setup lang="ts">
const { data, status, error, refresh, clear } = await useFetch('/api/posts')
</script>

<template>
  <div v-if="status === 'pending'">Loading...</div>
  <div v-else-if="error">Error: {{ error.message }}</div>
  <div v-else>
    <article v-for="post in data" :key="post.id">
      {{ post.title }}
    </article>
  </div>
</template>
```

### With Options

```ts
const { data } = await useFetch('/api/posts', {
  // Query parameters
  query: { page: 1, limit: 10 },
  // Request body (for POST/PUT)
  body: { title: 'New Post' },
  // HTTP method
  method: 'POST',
  // Only pick specific fields
  pick: ['id', 'title'],
  // Transform response
  transform: (posts) => posts.map(p => ({ ...p, slug: slugify(p.title) })),
  // Custom key for caching
  key: 'posts-list',
  // Don't fetch on server
  server: false,
  // Don't block navigation
  lazy: true,
  // Don't fetch immediately
  immediate: false,
  // Default value
  default: () => [],
})
```

### Reactive Parameters

```vue
<script setup lang="ts">
const page = ref(1)
const { data } = await useFetch('/api/posts', {
  query: { page }, // Automatically refetches when page changes
})
</script>
```

### Computed URL

```vue
<script setup lang="ts">
const id = ref(1)
const { data } = await useFetch(() => `/api/posts/${id.value}`)
// Refetches when id changes
</script>
```

## useAsyncData

For wrapping any async function:

```vue
<script setup lang="ts">
const { data, error } = await useAsyncData('user', () => {
  return myCustomFetch('/user/profile')
})
</script>
```

### Multiple Requests

```vue
<script setup lang="ts">
const { data } = await useAsyncData('cart', async () => {
  const [coupons, offers] = await Promise.all([
    $fetch('/api/coupons'),
    $fetch('/api/offers'),
  ])
  return { coupons, offers }
})
</script>
```

## $fetch

For client-side events (form submissions, button clicks):

```vue
<script setup lang="ts">
async function submitForm() {
  const result = await $fetch('/api/submit', {
    method: 'POST',
    body: { name: 'John' },
  })
}
</script>
```

**Important**: Don't use `$fetch` alone in setup for initial data - it will fetch twice (server + client). Use `useFetch` or `useAsyncData` instead.

## Return Values

All composables return:

| Property | Type | Description |
|----------|------|-------------|
| `data` | `Ref<T>` | Fetched data |
| `error` | `Ref<Error>` | Error if request failed |
| `status` | `Ref<'idle' \| 'pending' \| 'success' \| 'error'>` | Request status |
| `refresh` | `() => Promise` | Refetch data |
| `execute` | `() => Promise` | Alias for refresh |
| `clear` | `() => void` | Reset data and error |

## Lazy Fetching

Don't block navigation:

```vue
<script setup lang="ts">
// Using lazy option
const { data, status } = await useFetch('/api/posts', { lazy: true })

// Or use lazy variants
const { data, status } = await useLazyFetch('/api/posts')
const { data, status } = await useLazyAsyncData('key', fetchFn)
</script>
```

## Refresh & Watch

```vue
<script setup lang="ts">
const category = ref('tech')

const { data, refresh } = await useFetch('/api/posts', {
  query: { category },
  // Auto-refresh when category changes
  watch: [category],
})

// Manual refresh
const refreshData = () => refresh()
</script>
```

## Caching

Data is cached by key. Share data across components:

```vue
<script setup lang="ts">
// In component A
const { data } = await useFetch('/api/user', { key: 'current-user' })

// In component B - uses cached data
const { data } = useNuxtData('current-user')
</script>
```

Refresh cached data globally:

```ts
// Refresh specific key
await refreshNuxtData('current-user')

// Refresh all data
await refreshNuxtData()

// Clear cached data
clearNuxtData('current-user')
```

## Interceptors

```ts
const { data } = await useFetch('/api/auth', {
  onRequest({ options }) {
    options.headers.set('Authorization', `Bearer ${token}`)
  },
  onRequestError({ error }) {
    console.error('Request failed:', error)
  },
  onResponse({ response }) {
    // Process response
  },
  onResponseError({ response }) {
    if (response.status === 401) {
      navigateTo('/login')
    }
  },
})
```

## Passing Headers (SSR)

`useFetch` automatically proxies cookies/headers from client to server. For `$fetch`:

```vue
<script setup lang="ts">
const headers = useRequestHeaders(['cookie'])
const data = await $fetch('/api/user', { headers })
</script>
```

<!-- 
Source references:
- https://nuxt.com/docs/getting-started/data-fetching
- https://nuxt.com/docs/api/composables/use-fetch
- https://nuxt.com/docs/api/composables/use-async-data
-->
