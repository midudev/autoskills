---
name: built-in-components
description: NuxtLink, NuxtPage, NuxtLayout, and other built-in Nuxt components
---

# Built-in Components

Nuxt provides several built-in components for common functionality.

## NuxtLink

Optimized link component with prefetching:

```vue
<template>
  <!-- Basic usage -->
  <NuxtLink to="/about">About</NuxtLink>

  <!-- With route object -->
  <NuxtLink :to="{ name: 'posts-id', params: { id: 1 } }">Post 1</NuxtLink>

  <!-- External link (opens in new tab) -->
  <NuxtLink to="https://nuxt.com" external>Nuxt</NuxtLink>

  <!-- Disable prefetching -->
  <NuxtLink to="/heavy-page" :prefetch="false">Heavy Page</NuxtLink>

  <!-- Replace history instead of push -->
  <NuxtLink to="/page" replace>Replace</NuxtLink>

  <!-- Custom active class -->
  <NuxtLink
    to="/dashboard"
    active-class="text-primary"
    exact-active-class="font-bold"
  >
    Dashboard
  </NuxtLink>
</template>
```

## NuxtPage

Renders the current page component (used in layouts):

```vue
<!-- app/app.vue -->
<template>
  <NuxtLayout>
    <NuxtPage />
  </NuxtLayout>
</template>
```

With page transitions:

```vue
<template>
  <NuxtPage :transition="{ name: 'fade', mode: 'out-in' }" />
</template>
```

Pass props to page:

```vue
<template>
  <NuxtPage :page-key="route.fullPath" :foobar="123" />
</template>
```

## NuxtLayout

Controls layout rendering:

```vue
<!-- app/app.vue -->
<template>
  <NuxtLayout>
    <NuxtPage />
  </NuxtLayout>
</template>
```

Dynamic layout:

```vue
<template>
  <NuxtLayout :name="layout">
    <NuxtPage />
  </NuxtLayout>
</template>

<script setup>
const layout = computed(() => isAdmin ? 'admin' : 'default')
</script>
```

Layout with transitions:

```vue
<template>
  <NuxtLayout :transition="{ name: 'slide', mode: 'out-in' }">
    <NuxtPage />
  </NuxtLayout>
</template>
```

## NuxtLoadingIndicator

Progress bar for page navigation:

```vue
<!-- app/app.vue -->
<template>
  <NuxtLoadingIndicator
    color="repeating-linear-gradient(to right, #00dc82 0%, #34cdfe 50%, #0047e1 100%)"
    :height="3"
    :duration="2000"
    :throttle="200"
  />
  <NuxtLayout>
    <NuxtPage />
  </NuxtLayout>
</template>
```

## NuxtErrorBoundary

Catch and handle errors in child components:

```vue
<template>
  <NuxtErrorBoundary @error="handleError">
    <ComponentThatMightFail />

    <template #error="{ error, clearError }">
      <div class="error">
        <p>Something went wrong: {{ error.message }}</p>
        <button @click="clearError">Try again</button>
      </div>
    </template>
  </NuxtErrorBoundary>
</template>

<script setup>
function handleError(error) {
  console.error('Error caught:', error)
}
</script>
```

## ClientOnly

Render content only on client-side:

```vue
<template>
  <ClientOnly>
    <!-- Browser-only component -->
    <BrowserOnlyChart :data="chartData" />

    <template #fallback>
      <p>Loading chart...</p>
    </template>
  </ClientOnly>
</template>
```

## DevOnly

Render content only in development:

```vue
<template>
  <DevOnly>
    <DebugPanel />
  </DevOnly>
</template>
```

## NuxtIsland

Server components (experimental):

```vue
<template>
  <NuxtIsland name="HeavyComponent" :props="{ data: complexData }" />
</template>
```

## NuxtImg and NuxtPicture

Optimized images (requires `@nuxt/image` module):

```vue
<template>
  <!-- Basic optimized image -->
  <NuxtImg src="/images/hero.jpg" width="800" height="600" />

  <!-- Responsive with srcset -->
  <NuxtImg
    src="/images/hero.jpg"
    sizes="sm:100vw md:50vw lg:400px"
    :modifiers="{ format: 'webp' }"
  />

  <!-- Art direction with picture -->
  <NuxtPicture
    src="/images/hero.jpg"
    :img-attrs="{ alt: 'Hero image' }"
  />
</template>
```

## Teleport

Render content outside component tree:

```vue
<template>
  <button @click="showModal = true">Open Modal</button>

  <Teleport to="body">
    <div v-if="showModal" class="modal">
      <p>Modal content</p>
      <button @click="showModal = false">Close</button>
    </div>
  </Teleport>
</template>
```

For SSR, use `<ClientOnly>` with Teleport:

```vue
<template>
  <ClientOnly>
    <Teleport to="#teleports">
      <Modal />
    </Teleport>
  </ClientOnly>
</template>
```

## NuxtRouteAnnouncer

Accessibility: announces page changes to screen readers:

```vue
<!-- app/app.vue -->
<template>
  <NuxtRouteAnnouncer />
  <NuxtLayout>
    <NuxtPage />
  </NuxtLayout>
</template>
```

<!-- 
Source references:
- https://nuxt.com/docs/api/components/nuxt-link
- https://nuxt.com/docs/api/components/nuxt-page
- https://nuxt.com/docs/api/components/nuxt-layout
- https://nuxt.com/docs/api/components/client-only
-->
