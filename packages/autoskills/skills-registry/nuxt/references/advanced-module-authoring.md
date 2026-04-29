---
name: module-authoring
description: Complete guide to creating publishable Nuxt modules with best practices
---

# Module Authoring

This guide covers creating publishable Nuxt modules with proper structure, type safety, and best practices.

## Module Structure

Recommended structure for a publishable module:

```
my-nuxt-module/
├── src/
│   ├── module.ts          # Module entry
│   └── runtime/
│       ├── components/    # Vue components
│       ├── composables/   # Composables
│       ├── plugins/       # Nuxt plugins
│       └── server/        # Server handlers
├── playground/            # Development app
├── package.json
└── tsconfig.json
```

## Module Definition

### Basic Module with Type-safe Options

```ts
// src/module.ts
import { defineNuxtModule, createResolver, addPlugin, addComponent, addImports } from '@nuxt/kit'

export interface ModuleOptions {
  prefix?: string
  apiKey: string
  enabled?: boolean
}

export default defineNuxtModule<ModuleOptions>({
  meta: {
    name: 'my-module',
    configKey: 'myModule',
    compatibility: {
      nuxt: '>=3.0.0',
    },
  },
  defaults: {
    prefix: 'My',
    enabled: true,
  },
  setup(options, nuxt) {
    if (!options.enabled) return

    const { resolve } = createResolver(import.meta.url)

    // Module setup logic here
  },
})
```

### Using `.with()` for Strict Type Inference

When you need TypeScript to infer that default values are always present:

```ts
import { defineNuxtModule } from '@nuxt/kit'

interface ModuleOptions {
  apiKey: string
  baseURL: string
  timeout?: number
}

export default defineNuxtModule<ModuleOptions>().with({
  meta: {
    name: '@nuxtjs/my-api',
    configKey: 'myApi',
  },
  defaults: {
    baseURL: 'https://api.example.com',
    timeout: 5000,
  },
  setup(resolvedOptions, nuxt) {
    // resolvedOptions.baseURL is guaranteed to be string (not undefined)
    // resolvedOptions.timeout is guaranteed to be number (not undefined)
  },
})
```

## Adding Runtime Assets

### Components

```ts
import { addComponent, addComponentsDir, createResolver } from '@nuxt/kit'

export default defineNuxtModule({
  setup() {
    const { resolve } = createResolver(import.meta.url)

    // Single component
    addComponent({
      name: 'MyButton',
      filePath: resolve('./runtime/components/MyButton.vue'),
    })

    // Component directory with prefix
    addComponentsDir({
      path: resolve('./runtime/components'),
      prefix: 'My',
      pathPrefix: false,
    })
  },
})
```

### Composables and Auto-imports

```ts
import { addImports, addImportsDir, createResolver } from '@nuxt/kit'

export default defineNuxtModule({
  setup() {
    const { resolve } = createResolver(import.meta.url)

    // Single import
    addImports({
      name: 'useMyUtil',
      from: resolve('./runtime/composables/useMyUtil'),
    })

    // Directory of composables
    addImportsDir(resolve('./runtime/composables'))
  },
})
```

### Plugins

```ts
import { addPlugin, addPluginTemplate, createResolver } from '@nuxt/kit'

export default defineNuxtModule({
  setup(options) {
    const { resolve } = createResolver(import.meta.url)

    // Static plugin file
    addPlugin({
      src: resolve('./runtime/plugins/myPlugin'),
      mode: 'client', // 'client', 'server', or 'all'
    })

    // Dynamic plugin with generated code
    addPluginTemplate({
      filename: 'my-module-plugin.mjs',
      getContents: () => `
import { defineNuxtPlugin } from '#app/nuxt'

export default defineNuxtPlugin({
  name: 'my-module',
  setup() {
    const config = ${JSON.stringify(options)}
    // Plugin logic
  }
})`,
    })
  },
})
```

## Server Extensions

### Server Handlers

```ts
import { addServerHandler, addServerScanDir, createResolver } from '@nuxt/kit'

export default defineNuxtModule({
  setup() {
    const { resolve } = createResolver(import.meta.url)

    // Single handler
    addServerHandler({
      route: '/api/my-endpoint',
      handler: resolve('./runtime/server/api/my-endpoint'),
    })

    // Scan entire server directory (api/, routes/, middleware/, utils/)
    addServerScanDir(resolve('./runtime/server'))
  },
})
```

### Server Composables

```ts
import { addServerImports, addServerImportsDir, createResolver } from '@nuxt/kit'

export default defineNuxtModule({
  setup() {
    const { resolve } = createResolver(import.meta.url)

    // Single server import
    addServerImports({
      name: 'useServerUtil',
      from: resolve('./runtime/server/utils/useServerUtil'),
    })

    // Server composables directory
    addServerImportsDir(resolve('./runtime/server/composables'))
  },
})
```

### Nitro Plugin

```ts
import { addServerPlugin, createResolver } from '@nuxt/kit'

export default defineNuxtModule({
  setup() {
    const { resolve } = createResolver(import.meta.url)
    addServerPlugin(resolve('./runtime/server/plugin'))
  },
})
```

```ts
// runtime/server/plugin.ts
import { defineNitroPlugin } from 'nitropack/runtime'

export default defineNitroPlugin((nitroApp) => {
  nitroApp.hooks.hook('request', (event) => {
    console.log('Request:', event.path)
  })
})
```

## Templates and Virtual Files

### Generate Virtual Files

```ts
import { addTemplate, addTypeTemplate, addServerTemplate, createResolver } from '@nuxt/kit'

export default defineNuxtModule({
  setup(options, nuxt) {
    const { resolve } = createResolver(import.meta.url)

    // Client/build virtual file (accessible via #build/my-config.mjs)
    addTemplate({
      filename: 'my-config.mjs',
      getContents: () => `export default ${JSON.stringify(options)}`,
    })

    // Type declarations
    addTypeTemplate({
      filename: 'types/my-module.d.ts',
      getContents: () => `
declare module '#my-module' {
  export interface Config {
    apiKey: string
  }
}`,
    })

    // Nitro virtual file (accessible in server routes)
    addServerTemplate({
      filename: '#my-module/config.mjs',
      getContents: () => `export const config = ${JSON.stringify(options)}`,
    })
  },
})
```

### Access Virtual Files

```ts
// In runtime plugin
// @ts-expect-error - virtual file
import config from '#build/my-config.mjs'

// In server routes
import { config } from '#my-module/config.js'
```

## Extending Pages and Routes

```ts
import { extendPages, extendRouteRules, addRouteMiddleware, createResolver } from '@nuxt/kit'

export default defineNuxtModule({
  setup() {
    const { resolve } = createResolver(import.meta.url)

    // Add pages
    extendPages((pages) => {
      pages.push({
        name: 'my-page',
        path: '/my-route',
        file: resolve('./runtime/pages/MyPage.vue'),
      })
    })

    // Add route rules (caching, redirects, etc.)
    extendRouteRules('/api/**', {
      cache: { maxAge: 60 },
    })

    // Add middleware
    addRouteMiddleware({
      name: 'my-middleware',
      path: resolve('./runtime/middleware/myMiddleware'),
      global: true,
    })
  },
})
```

## Module Dependencies

Declare dependencies on other modules with version constraints:

```ts
export default defineNuxtModule({
  meta: {
    name: 'my-module',
  },
  moduleDependencies: {
    '@nuxtjs/tailwindcss': {
      version: '>=6.0.0',
      // Set defaults (user can override)
      defaults: {
        exposeConfig: true,
      },
      // Force specific options
      overrides: {
        viewer: false,
      },
    },
    '@nuxtjs/i18n': {
      optional: true, // Won't fail if not installed
      defaults: {
        defaultLocale: 'en',
      },
    },
  },
  setup() {
    // Dependencies are guaranteed to be set up before this runs
  },
})
```

### Dynamic Dependencies

```ts
moduleDependencies(nuxt) {
  const deps: Record<string, any> = {
    '@nuxtjs/tailwindcss': { version: '>=6.0.0' },
  }

  if (nuxt.options.ssr) {
    deps['@nuxtjs/html-validator'] = { optional: true }
  }

  return deps
}
```

## Lifecycle Hooks

Requires `meta.name` and `meta.version`:

```ts
export default defineNuxtModule({
  meta: {
    name: 'my-module',
    version: '1.2.0',
  },
  onInstall(nuxt) {
    // First-time setup
    console.log('Module installed for the first time')
  },
  onUpgrade(nuxt, options, previousVersion) {
    // Version upgrade migrations
    console.log(`Upgrading from ${previousVersion}`)
  },
  setup(options, nuxt) {
    // Regular setup runs every build
  },
})
```

## Extending Configuration

```ts
export default defineNuxtModule({
  setup(options, nuxt) {
    // Add CSS
    nuxt.options.css.push('my-module/styles.css')

    // Add runtime config
    nuxt.options.runtimeConfig.public.myModule = {
      apiUrl: options.apiUrl,
    }

    // Extend Vite config
    nuxt.options.vite.optimizeDeps ||= {}
    nuxt.options.vite.optimizeDeps.include ||= []
    nuxt.options.vite.optimizeDeps.include.push('some-package')

    // Add build transpile
    nuxt.options.build.transpile.push('my-package')
  },
})
```

## Using Hooks

```ts
export default defineNuxtModule({
  // Declarative hooks
  hooks: {
    'components:dirs': (dirs) => {
      dirs.push({ path: '~/extra' })
    },
  },

  setup(options, nuxt) {
    // Programmatic hooks
    nuxt.hook('pages:extend', (pages) => {
      // Modify pages
    })

    nuxt.hook('imports:extend', (imports) => {
      imports.push({ name: 'myHelper', from: 'my-package' })
    })

    nuxt.hook('nitro:config', (config) => {
      // Modify Nitro config
    })

    nuxt.hook('vite:extendConfig', (config) => {
      // Modify Vite config
    })
  },
})
```

## Path Resolution

```ts
import { createResolver, resolvePath, findPath } from '@nuxt/kit'

export default defineNuxtModule({
  async setup(options, nuxt) {
    // Resolver relative to module
    const { resolve } = createResolver(import.meta.url)

    const pluginPath = resolve('./runtime/plugin')

    // Resolve with extensions and aliases
    const entrypoint = await resolvePath('@some/package')

    // Find first existing file
    const configPath = await findPath([
      resolve('./config.ts'),
      resolve('./config.js'),
    ])
  },
})
```

## Module Package.json

```json
{
  "name": "my-nuxt-module",
  "version": "1.0.0",
  "type": "module",
  "exports": {
    ".": {
      "import": "./dist/module.mjs",
      "require": "./dist/module.cjs"
    }
  },
  "main": "./dist/module.cjs",
  "module": "./dist/module.mjs",
  "types": "./dist/types.d.ts",
  "files": ["dist"],
  "scripts": {
    "dev": "nuxi dev playground",
    "build": "nuxt-module-build build",
    "prepare": "nuxt-module-build build --stub"
  },
  "dependencies": {
    "@nuxt/kit": "^3.0.0"
  },
  "devDependencies": {
    "@nuxt/module-builder": "latest",
    "nuxt": "^3.0.0"
  }
}
```

## Disabling Modules

Users can disable a module via config key:

```ts
// nuxt.config.ts
export default defineNuxtConfig({
  // Disable entirely
  myModule: false,

  // Or with options
  myModule: {
    enabled: false,
  },
})
```

## Development Workflow

1. **Create module**: `npx nuxi init -t module my-module`
2. **Develop**: `npm run dev` (runs playground)
3. **Build**: `npm run build`
4. **Test**: `npm run test`

## Best Practices

- Use `createResolver(import.meta.url)` for all path resolution
- Prefix components to avoid naming conflicts
- Make options type-safe with `ModuleOptions` interface
- Use `moduleDependencies` instead of `installModule`
- Provide sensible defaults for all options
- Add compatibility requirements in `meta.compatibility`
- Use virtual files for dynamic configuration
- Separate client/server plugins appropriately

<!--
Source references:
- https://nuxt.com/docs/api/kit/modules
- https://nuxt.com/docs/api/kit/components
- https://nuxt.com/docs/api/kit/autoimports
- https://nuxt.com/docs/api/kit/plugins
- https://nuxt.com/docs/api/kit/templates
- https://nuxt.com/docs/api/kit/nitro
- https://nuxt.com/docs/api/kit/pages
- https://nuxt.com/docs/api/kit/resolving
-->
