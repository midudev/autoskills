---
title: Use URL State for Shareable Filters Instead of Stores
impact: MEDIUM
impactDescription: Storing filter/search state only in stores loses state on refresh and prevents link sharing
type: best-practice
tags: [vue3, state-management, url, router, filters, ux, vue-router]
---

# Use URL State for Shareable Filters Instead of Stores

**Impact: MEDIUM** - Storing ephemeral UI state like filters, search queries, pagination, and sorting only in Pinia or component state means users lose that state on page refresh and cannot share links to specific filtered views. This hurts user experience and SEO.

For state that represents a "view" of data, use URL query parameters instead of or alongside stores.

## Task Checklist

- [ ] Identify ephemeral UI state: filters, search, sort, pagination, tab selection
- [ ] Store such state in URL query parameters
- [ ] Sync URL state with component/store state bidirectionally
- [ ] Consider using VueUse's `useRouteQuery` for type-safe URL state
- [ ] Keep URL state minimal and human-readable

## The Problem: Store-Only State

```vue
<script setup>
import { ref } from 'vue'
import { useProductStore } from '@/stores/products'

const productStore = useProductStore()

// Filter state in component/store only
const selectedCategory = ref('all')
const priceRange = ref([0, 1000])
const sortBy = ref('newest')
const searchQuery = ref('')

// Problems with this approach:
// 1. User refreshes page → filters reset to defaults
// 2. User bookmarks page → bookmark doesn't include filter state
// 3. User shares link → friend sees unfiltered view
// 4. Back button doesn't restore previous filter state
</script>
```

## The Solution: URL-Based State

```vue
<script setup>
import { computed, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'

const route = useRoute()
const router = useRouter()

// Read filter state FROM URL
const selectedCategory = computed({
  get: () => route.query.category || 'all',
  set: (value) => updateQuery({ category: value === 'all' ? undefined : value })
})

const sortBy = computed({
  get: () => route.query.sort || 'newest',
  set: (value) => updateQuery({ sort: value === 'newest' ? undefined : value })
})

const searchQuery = computed({
  get: () => route.query.q || '',
  set: (value) => updateQuery({ q: value || undefined })
})

const page = computed({
  get: () => parseInt(route.query.page) || 1,
  set: (value) => updateQuery({ page: value === 1 ? undefined : value })
})

// Helper to update URL without full navigation
function updateQuery(newParams) {
  router.push({
    query: {
      ...route.query,
      ...newParams
    }
  })
}
</script>

<template>
  <div>
    <input v-model="searchQuery" placeholder="Search...">

    <select v-model="selectedCategory">
      <option value="all">All Categories</option>
      <option value="electronics">Electronics</option>
      <option value="clothing">Clothing</option>
    </select>

    <select v-model="sortBy">
      <option value="newest">Newest</option>
      <option value="price-low">Price: Low to High</option>
      <option value="price-high">Price: High to Low</option>
    </select>

    <!-- URL now looks like: /products?category=electronics&sort=price-low&q=phone -->
    <!-- Users can bookmark, share, and refresh without losing state -->
  </div>
</template>
```

## Using VueUse for Cleaner Code

VueUse provides `useRouteQuery` for type-safe URL state:

```vue
<script setup>
import { useRouteQuery } from '@vueuse/router'

// Automatically syncs with URL query parameters
const category = useRouteQuery('category', 'all')
const sort = useRouteQuery('sort', 'newest')
const search = useRouteQuery('q', '')
const page = useRouteQuery('page', 1, { transform: Number })
const showOutOfStock = useRouteQuery('inStock', false, { transform: Boolean })

// Arrays work too
const selectedTags = useRouteQuery('tags', [], {
  transform: (v) => Array.isArray(v) ? v : v ? [v] : []
})
</script>

<template>
  <input v-model="search" placeholder="Search...">
  <select v-model="category">...</select>
  <input type="checkbox" v-model="showOutOfStock"> Show out of stock
</template>
```

## Hybrid Approach: URL + Store

For complex state, sync URL with store:

```javascript
// stores/productFilters.js
import { defineStore } from 'pinia'
import { useRoute, useRouter } from 'vue-router'
import { watch } from 'vue'

export const useProductFiltersStore = defineStore('productFilters', () => {
  const route = useRoute()
  const router = useRouter()

  // Local reactive state
  const category = ref('all')
  const sortBy = ref('newest')
  const searchQuery = ref('')
  const page = ref(1)

  // Initialize from URL on store creation
  function initFromUrl() {
    category.value = route.query.category || 'all'
    sortBy.value = route.query.sort || 'newest'
    searchQuery.value = route.query.q || ''
    page.value = parseInt(route.query.page) || 1
  }

  // Sync state changes TO URL
  function syncToUrl() {
    router.replace({
      query: {
        category: category.value !== 'all' ? category.value : undefined,
        sort: sortBy.value !== 'newest' ? sortBy.value : undefined,
        q: searchQuery.value || undefined,
        page: page.value > 1 ? page.value : undefined
      }
    })
  }

  // Watch for URL changes (back/forward navigation)
  watch(() => route.query, initFromUrl, { immediate: true })

  // Watch for state changes and sync to URL
  watch([category, sortBy, searchQuery, page], syncToUrl)

  return {
    category,
    sortBy,
    searchQuery,
    page,
    initFromUrl
  }
})
```

## What Goes in URL vs Store

| State Type | URL | Store | Notes |
|------------|-----|-------|-------|
| Filters | Yes | Optional | Shareable, bookmarkable |
| Search query | Yes | Optional | SEO benefit |
| Pagination | Yes | Optional | Deep linking |
| Sort order | Yes | Optional | User expectation |
| Selected tab | Yes | Optional | Deep linking |
| Modal open state | Maybe | Yes | Usually not shareable |
| Form draft | No | Yes | Private, temporary |
| User session | No | Yes | Security |
| Shopping cart | No | Yes | Persistence needed |

## Benefits of URL State

1. **Shareable**: Users can share exact filtered views
2. **Bookmarkable**: Save specific searches/filters
3. **Browser history**: Back/forward works as expected
4. **SEO**: Search engines can index filtered pages
5. **Refresh-safe**: State survives page reload
6. **Deep linking**: Direct links to specific states

## Clean URL Best Practices

```javascript
// GOOD: Clean, readable URLs
/products?category=electronics&sort=price&q=phone

// AVOID: Overly complex URLs
/products?filters=%7B%22category%22%3A%22electronics%22%7D
```

```javascript
// Use defaults to keep URLs minimal
const sort = useRouteQuery('sort', 'newest')

// URL shows: /products (when using default sort)
// URL shows: /products?sort=price-low (when changed)
```

## Reference
- [VueUse - useRouteQuery](https://vueuse.org/router/useRouteQuery/)
- [Vue Router - Query Parameters](https://router.vuejs.org/guide/essentials/passing-props.html#passing-props-to-route-components)
- [Mastering Pinia - URL State](https://masteringpinia.com/blog/top-5-mistakes-to-avoid-when-using-pinia)
