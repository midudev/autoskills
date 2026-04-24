---
name: components-auto-imports
description: Auto-imported components, lazy loading, and hydration strategies
---

# Components Auto-imports

Nuxt automatically imports Vue components from `app/components/` directory.

## Basic Auto-imports

```
components/
├── Button.vue         → <Button />
├── Card.vue           → <Card />
└── AppHeader.vue      → <AppHeader />
```

```vue
<template>
  <!-- No imports needed -->
  <AppHeader />
  <Card>
    <Button>Click me</Button>
  </Card>
</template>
```

## Naming Conventions

### Nested Directory Names

Component names include directory path:

```
components/
├── base/
│   └── Button.vue       → <BaseButton />
├── form/
│   ├── Input.vue        → <FormInput />
│   └── Select.vue       → <FormSelect />
└── ui/
    └── modal/
        └── Dialog.vue   → <UiModalDialog />
```

### Disable Path Prefix

```ts
// nuxt.config.ts
export default defineNuxtConfig({
  components: [
    {
      path: '~/components',
      pathPrefix: false, // Use filename only
    },
  ],
})
```

With `pathPrefix: false`:
```
components/base/Button.vue → <Button />
```

## Lazy Loading

Prefix with `Lazy` for dynamic imports:

```vue
<script setup lang="ts">
const showChart = ref(false)
</script>

<template>
  <!-- Component code loaded only when rendered -->
  <LazyHeavyChart v-if="showChart" />
  <button @click="showChart = true">Show Chart</button>
</template>
```

Benefits:
- Reduces initial bundle size
- Code-splits component into separate chunk
- Loads on-demand

## Lazy Hydration Strategies

Control when lazy components become interactive:

### `hydrate-on-visible`

Hydrate when component enters viewport:

```vue
<template>
  <LazyComments hydrate-on-visible />
</template>
```

### `hydrate-on-idle`

Hydrate when browser is idle:

```vue
<template>
  <LazyAnalytics hydrate-on-idle />
</template>
```

### `hydrate-on-interaction`

Hydrate on user interaction:

```vue
<template>
  <!-- Hydrates on click, focus, or pointerenter -->
  <LazyDropdown hydrate-on-interaction />

  <!-- Specific event -->
  <LazyTooltip hydrate-on-interaction="mouseover" />
</template>
```

### `hydrate-on-media-query`

Hydrate when media query matches:

```vue
<template>
  <LazyMobileMenu hydrate-on-media-query="(max-width: 768px)" />
</template>
```

### `hydrate-after`

Hydrate after delay (milliseconds):

```vue
<template>
  <LazyAds :hydrate-after="3000" />
</template>
```

### `hydrate-when`

Hydrate on condition:

```vue
<script setup lang="ts">
const isReady = ref(false)
</script>

<template>
  <LazyEditor :hydrate-when="isReady" />
</template>
```

### `hydrate-never`

Never hydrate (static only):

```vue
<template>
  <LazyStaticFooter hydrate-never />
</template>
```

### Hydration Event

```vue
<template>
  <LazyChart hydrate-on-visible @hydrated="onChartReady" />
</template>

<script setup>
function onChartReady() {
  console.log('Chart is now interactive')
}
</script>
```

## Client/Server Components

### Client-only (`.client.vue`)

```
components/
└── BrowserChart.client.vue
```

```vue
<template>
  <!-- Only rendered in browser -->
  <BrowserChart />
</template>
```

### Server-only (`.server.vue`)

```
components/
└── ServerMarkdown.server.vue
```

```vue
<template>
  <!-- Rendered on server, not hydrated -->
  <ServerMarkdown :content="markdown" />
</template>
```

Requires experimental flag:

```ts
// nuxt.config.ts
export default defineNuxtConfig({
  experimental: {
    componentIslands: true,
  },
})
```

### Paired Components

```
components/
├── Comments.client.vue  # Browser version
└── Comments.server.vue  # SSR version
```

Server version renders during SSR, client version takes over after hydration.

## Dynamic Components

```vue
<script setup lang="ts">
import { SomeComponent } from '#components'

const dynamicComponent = resolveComponent('MyButton')
</script>

<template>
  <component :is="dynamicComponent" />
  <component :is="SomeComponent" />
</template>
```

## Direct Imports

Bypass auto-imports when needed:

```vue
<script setup lang="ts">
import { LazyMountainsList, NuxtLink } from '#components'
</script>
```

## Custom Directories

```ts
// nuxt.config.ts
export default defineNuxtConfig({
  components: [
    { path: '~/components/ui', prefix: 'Ui' },
    { path: '~/components/forms', prefix: 'Form' },
    '~/components', // Default, should come last
  ],
})
```

## Global Components

Register globally (creates async chunks):

```ts
// nuxt.config.ts
export default defineNuxtConfig({
  components: {
    global: true,
    dirs: ['~/components'],
  },
})
```

Or use `.global.vue` suffix:

```
components/
└── Icon.global.vue  → Available globally
```

## Disabling Component Auto-imports

```ts
// nuxt.config.ts
export default defineNuxtConfig({
  components: {
    dirs: [], // Disable auto-imports
  },
})
```

## Library Authors

Register components from npm package:

```ts
// my-ui-lib/nuxt.ts
import { addComponentsDir, createResolver, defineNuxtModule } from '@nuxt/kit'

export default defineNuxtModule({
  setup() {
    const resolver = createResolver(import.meta.url)

    addComponentsDir({
      path: resolver.resolve('./components'),
      prefix: 'MyUi',
    })
  },
})
```

<!-- 
Source references:
- https://nuxt.com/docs/directory-structure/app/components
- https://nuxt.com/docs/guide/concepts/auto-imports#auto-imported-components
-->
