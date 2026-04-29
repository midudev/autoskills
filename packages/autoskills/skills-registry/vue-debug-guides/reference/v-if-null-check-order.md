---
title: Check for Null/Undefined Before Accessing Properties in v-if
impact: MEDIUM
impactDescription: Accessing properties on null/undefined causes runtime errors and crashes
type: capability
tags: [vue3, conditional-rendering, v-if, null-check, defensive-programming]
---

# Check for Null/Undefined Before Accessing Properties in v-if

**Impact: MEDIUM** - Accessing properties on null or undefined objects in `v-if` conditions causes "Cannot read property of undefined" runtime errors. This commonly occurs when data is loaded asynchronously or when optional object properties are accessed without null checks.

## Task Checklist

- [ ] Always check that an object exists before accessing its properties
- [ ] Use optional chaining (?.) in Vue 3 templates for cleaner null checks
- [ ] Consider using computed properties for complex conditional logic
- [ ] Handle loading states explicitly rather than relying on undefined checks

**Incorrect:**
```html
<!-- WRONG: Accessing property before checking object exists -->
<template>
  <div v-if="user.isAdmin">
    Admin Panel
  </div>
  <!-- Error if user is null/undefined: Cannot read property 'isAdmin' of undefined -->
</template>
```

```html
<!-- WRONG: Nested property access without checks -->
<template>
  <div v-if="order.customer.address.city === 'NYC'">
    Local delivery available
  </div>
  <!-- Error if any level is undefined -->
</template>
```

```html
<!-- WRONG: Array access without existence check -->
<template>
  <div v-if="items[0].name === 'Featured'">
    {{ items[0].description }}
  </div>
  <!-- Error if items is empty array -->
</template>
```

**Correct:**
```html
<!-- CORRECT: Check object exists first with && -->
<template>
  <div v-if="user && user.isAdmin">
    Admin Panel
  </div>
</template>
```

```html
<!-- CORRECT: Optional chaining (Vue 3) -->
<template>
  <div v-if="user?.isAdmin">
    Admin Panel
  </div>
</template>
```

```html
<!-- CORRECT: Optional chaining for nested properties -->
<template>
  <div v-if="order?.customer?.address?.city === 'NYC'">
    Local delivery available
  </div>
</template>
```

```html
<!-- CORRECT: Array length check before access -->
<template>
  <div v-if="items.length > 0 && items[0].name === 'Featured'">
    {{ items[0].description }}
  </div>

  <!-- Or with optional chaining -->
  <div v-if="items?.[0]?.name === 'Featured'">
    {{ items[0].description }}
  </div>
</template>
```

```html
<!-- CORRECT: Explicit loading state handling -->
<template>
  <div v-if="isLoading">Loading...</div>
  <div v-else-if="error">Error: {{ error.message }}</div>
  <div v-else-if="user">
    <h1>Welcome, {{ user.name }}</h1>
    <div v-if="user.isAdmin">Admin Panel</div>
  </div>
  <div v-else>No user data</div>
</template>
```

## Using Computed Properties for Complex Checks

```javascript
// CORRECT: Move complex checks to computed properties
<script setup>
import { computed } from 'vue'

const props = defineProps(['user', 'permissions'])

const canAccessAdmin = computed(() => {
  return props.user?.isAdmin &&
         props.permissions?.includes('admin_panel') &&
         !props.user?.isDisabled
})

const userDisplayName = computed(() => {
  return props.user?.profile?.displayName ||
         props.user?.name ||
         'Anonymous'
})
</script>

<template>
  <div v-if="canAccessAdmin">
    Admin Panel
  </div>
  <span>{{ userDisplayName }}</span>
</template>
```

## Common Async Data Pattern

```javascript
// CORRECT: Handle async data loading properly
<script setup>
import { ref, onMounted } from 'vue'

const user = ref(null)
const isLoading = ref(true)
const error = ref(null)

onMounted(async () => {
  try {
    user.value = await fetchUser()
  } catch (e) {
    error.value = e
  } finally {
    isLoading.value = false
  }
})
</script>

<template>
  <div v-if="isLoading">Loading user...</div>
  <div v-else-if="error">Failed to load user</div>
  <div v-else-if="user">
    <!-- Safe to access user properties here -->
    <h1>{{ user.name }}</h1>
    <p v-if="user.bio">{{ user.bio }}</p>
  </div>
</template>
```

## Reference
- [Vue.js Conditional Rendering](https://vuejs.org/guide/essentials/conditional.html)
- [MDN - Optional Chaining](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Optional_chaining)
