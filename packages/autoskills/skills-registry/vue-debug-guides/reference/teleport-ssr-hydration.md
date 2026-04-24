---
title: Handle Teleport SSR Hydration Carefully
impact: HIGH
impactDescription: Teleported content causes hydration mismatches in SSR/SSG applications
type: gotcha
tags: [vue3, teleport, ssr, nuxt, hydration]
---

# Handle Teleport SSR Hydration Carefully

**Impact: HIGH** - Teleports require special handling during SSR. The teleported content is not part of the server-rendered HTML string, causing hydration mismatches that can break the application or cause content to disappear.

This is a critical issue for Nuxt, Quasar SSR, and custom Vue SSR setups.

## Task Checklist

- [ ] Wrap Teleport in `<ClientOnly>` component (Nuxt) for client-only rendering
- [ ] Use conditional rendering based on mount state for non-Nuxt SSR
- [ ] Use `data-allow-mismatch` attribute in Vue 3.5+ when intentional
- [ ] Test SSR applications thoroughly for hydration issues

**Problem - SSR Hydration Mismatch:**
```vue
<template>
  <!-- Server renders nothing for teleported content -->
  <!-- Client expects teleported content at #modals -->
  <!-- = Hydration mismatch -->
  <Teleport to="#modals">
    <div v-if="showModal" class="modal">
      Modal content
    </div>
  </Teleport>
</template>
```

Common error messages:
```
[Vue warn]: Hydration children mismatch in <div>:
server rendered element contains fewer child nodes than client vdom.
```

**Solution 1 - Nuxt ClientOnly:**
```vue
<template>
  <button @click="showModal = true">Open Modal</button>

  <!-- Only render on client, avoiding SSR -->
  <ClientOnly>
    <Teleport to="body">
      <div v-if="showModal" class="modal">
        Modal content
      </div>
    </Teleport>
  </ClientOnly>
</template>
```

**Solution 2 - Manual Client Detection:**
```vue
<template>
  <button @click="showModal = true">Open Modal</button>

  <!-- Only render after component mounts on client -->
  <Teleport v-if="isMounted" to="body">
    <div v-if="showModal" class="modal">
      Modal content
    </div>
  </Teleport>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const showModal = ref(false)
const isMounted = ref(false)

onMounted(() => {
  isMounted.value = true
})
</script>
```

**Solution 3 - Vue 3.5+ data-allow-mismatch:**
```vue
<template>
  <!-- Suppress hydration warnings for intentional mismatches -->
  <div data-allow-mismatch>
    <Teleport to="body">
      <div v-if="showModal" class="modal">
        Modal content
      </div>
    </Teleport>
  </div>
</template>
```

## SSR with Multiple Teleports

Multiple teleports to the same target can cause additional hydration issues:

```vue
<!-- Parent.vue -->
<template>
  <!-- First teleport -->
  <Teleport to="#modals">
    <NotificationBanner />
  </Teleport>

  <ChildComponent />
</template>

<!-- ChildComponent.vue -->
<template>
  <!-- Second teleport to same target - order matters! -->
  <Teleport to="#modals">
    <Modal />
  </Teleport>
</template>
```

For SSR, ensure consistent ordering or wrap each in `ClientOnly`.

## Element Plus and UI Library SSR

Many UI libraries use Teleport internally. Element Plus components that use Teleport include:
- ElDialog
- ElDrawer
- ElTooltip
- ElDropdown
- ElSelect
- ElDatePicker

```vue
<template>
  <!-- These need special SSR handling -->
  <ClientOnly>
    <ElDialog v-model="visible">
      Dialog content
    </ElDialog>
  </ClientOnly>
</template>
```

## Known Vue Issues

- Disabled teleports in fragments can cause hydration mismatches (Vue issue #6152)
- Nested teleports may cause app to break on hydration (Vue issue #5242)

## Reference
- [Vue.js SSR - Teleports](https://vuejs.org/guide/scaling-up/ssr.html#teleports)
- [Element Plus SSR Guide](https://element-plus.org/en-US/guide/ssr.html)
- [Nuxt ClientOnly Component](https://nuxt.com/docs/api/components/client-only)
