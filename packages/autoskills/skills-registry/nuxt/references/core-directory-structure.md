---
name: directory-structure
description: Nuxt project folder structure, conventions, and file organization
---

# Directory Structure

Nuxt uses conventions-based directory structure. Understanding it is key to effective development.

## Standard Project Structure

```
my-nuxt-app/
├── app/                    # Application source (can be at root level)
│   ├── app.vue             # Root component
│   ├── app.config.ts       # App configuration (runtime)
│   ├── error.vue           # Error page
│   ├── components/         # Auto-imported Vue components
│   ├── composables/        # Auto-imported composables
│   ├── layouts/            # Layout components
│   ├── middleware/         # Route middleware
│   ├── pages/              # File-based routing
│   ├── plugins/            # Vue plugins
│   └── utils/              # Auto-imported utilities
├── assets/                 # Build-processed assets (CSS, images)
├── public/                 # Static assets (served as-is)
├── server/                 # Server-side code
│   ├── api/                # API routes (/api/*)
│   ├── routes/             # Server routes
│   ├── middleware/         # Server middleware
│   ├── plugins/            # Nitro plugins
│   └── utils/              # Server utilities (auto-imported)
├── content/                # Content files (@nuxt/content)
├── layers/                 # Local layers (auto-scanned)
├── modules/                # Local modules
├── nuxt.config.ts          # Nuxt configuration
├── package.json
└── tsconfig.json
```

## Key Directories

### `app/` Directory

Contains all application code. Can also be at root level (without `app/` folder).

```ts
// nuxt.config.ts - customize source directory
export default defineNuxtConfig({
  srcDir: 'src/', // Change from 'app/' to 'src/'
})
```

### `app/components/`

Vue components auto-imported by name:

```
components/
├── Button.vue           → <Button />
├── Card.vue             → <Card />
├── base/
│   └── Button.vue       → <BaseButton />
├── ui/
│   ├── Input.vue        → <UiInput />
│   └── Modal.vue        → <UiModal />
└── TheHeader.vue        → <TheHeader />
```

**Lazy loading**: Prefix with `Lazy` for dynamic import:

```vue
<template>
  <LazyHeavyChart v-if="showChart" />
</template>
```

**Client/Server only**:

```
components/
├── Comments.client.vue  → Only rendered on client
└── ServerData.server.vue → Only rendered on server
```

### `app/composables/`

Vue composables auto-imported (top-level files only):

```
composables/
├── useAuth.ts           → useAuth()
├── useFoo.ts            → useFoo()
└── nested/
    └── utils.ts         → NOT auto-imported
```

Re-export nested composables:

```ts
// composables/index.ts
export { useHelper } from './nested/utils'
```

### `app/pages/`

File-based routing:

```
pages/
├── index.vue            → /
├── about.vue            → /about
├── blog/
│   ├── index.vue        → /blog
│   └── [slug].vue       → /blog/:slug
├── users/
│   └── [id]/
│       └── profile.vue  → /users/:id/profile
├── [...slug].vue        → /* (catch-all)
├── [[optional]].vue     → /:optional? (optional param)
└── (marketing)/         → Route group (not in URL)
    └── pricing.vue      → /pricing
```

**Pages are optional**: Without `pages/`, no vue-router is included.

### `app/layouts/`

Layout components wrapping pages:

```
layouts/
├── default.vue          → Default layout
├── admin.vue            → Admin layout
└── blank.vue            → No layout
```

```vue
<!-- layouts/default.vue -->
<template>
  <div>
    <TheHeader />
    <slot />
    <TheFooter />
  </div>
</template>
```

Use in pages:

```vue
<script setup>
definePageMeta({
  layout: 'admin',
  // layout: false // Disable layout
})
</script>
```

### `app/middleware/`

Route middleware:

```
middleware/
├── auth.ts              → Named middleware
├── admin.ts             → Named middleware
└── logger.global.ts     → Global middleware (runs on every route)
```

### `app/plugins/`

Nuxt plugins (auto-registered):

```
plugins/
├── 01.analytics.ts      → Order with number prefix
├── 02.auth.ts
├── vue-query.client.ts  → Client-only plugin
└── server-init.server.ts → Server-only plugin
```

### `server/` Directory

Nitro server code:

```
server/
├── api/
│   ├── users.ts         → GET /api/users
│   ├── users.post.ts    → POST /api/users
│   └── users/[id].ts    → /api/users/:id
├── routes/
│   └── sitemap.xml.ts   → /sitemap.xml
├── middleware/
│   └── auth.ts          → Runs on every request
├── plugins/
│   └── db.ts            → Server startup plugins
└── utils/
    └── db.ts            → Auto-imported server utilities
```

### `public/` Directory

Static assets served at root URL:

```
public/
├── favicon.ico          → /favicon.ico
├── robots.txt           → /robots.txt
└── images/
    └── logo.png         → /images/logo.png
```

### `assets/` Directory

Build-processed assets:

```
assets/
├── css/
│   └── main.css
├── images/
│   └── hero.png
└── fonts/
    └── custom.woff2
```

Reference in components:

```vue
<template>
  <img src="~/assets/images/hero.png" />
</template>

<style>
@import '~/assets/css/main.css';
</style>
```

## Special Files

| File | Purpose |
|------|---------|
| `app.vue` | Root component (optional with pages/) |
| `app.config.ts` | Runtime app configuration |
| `error.vue` | Custom error page |
| `nuxt.config.ts` | Build-time configuration |
| `.nuxtignore` | Ignore files from Nuxt |
| `.env` | Environment variables |

## File Naming Conventions

| Pattern | Meaning |
|---------|---------|
| `[param]` | Dynamic route parameter |
| `[[param]]` | Optional parameter |
| `[...slug]` | Catch-all route |
| `(group)` | Route group (not in URL) |
| `.client.vue` | Client-only component |
| `.server.vue` | Server-only component |
| `.global.ts` | Global middleware |

<!-- 
Source references:
- https://nuxt.com/docs/directory-structure
- https://nuxt.com/docs/directory-structure/app
- https://nuxt.com/docs/directory-structure/server
-->
