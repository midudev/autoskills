---
name: cli-commands
description: Nuxt CLI commands for development, building, and project management
---

# CLI Commands

Nuxt provides CLI commands via `nuxi` (or `npx nuxt`) for development, building, and project management.

## Project Initialization

### Create New Project

```bash
# Interactive project creation
npx nuxi@latest init my-app

# With specific package manager
npx nuxi@latest init my-app --packageManager pnpm

# With modules
npx nuxi@latest init my-app --modules "@nuxt/ui,@nuxt/image"

# From template
npx nuxi@latest init my-app --template v3

# Skip module selection prompt
npx nuxi@latest init my-app --no-modules
```

**Options:**
| Option | Description |
|--------|-------------|
| `-t, --template` | Template name |
| `--packageManager` | npm, pnpm, yarn, or bun |
| `-M, --modules` | Modules to install (comma-separated) |
| `--gitInit` | Initialize git repository |
| `--no-install` | Skip installing dependencies |

## Development

### Start Dev Server

```bash
# Start development server (default: http://localhost:3000)
npx nuxt dev

# Custom port
npx nuxt dev --port 4000

# Open in browser
npx nuxt dev --open

# Listen on all interfaces (for mobile testing)
npx nuxt dev --host 0.0.0.0

# With HTTPS
npx nuxt dev --https

# Clear console on restart
npx nuxt dev --clear

# Create public tunnel
npx nuxt dev --tunnel
```

**Options:**
| Option | Description |
|--------|-------------|
| `-p, --port` | Port to listen on |
| `-h, --host` | Host to listen on |
| `-o, --open` | Open in browser |
| `--https` | Enable HTTPS |
| `--tunnel` | Create public tunnel (via untun) |
| `--qr` | Show QR code for mobile |
| `--clear` | Clear console on restart |

**Environment Variables:**
- `NUXT_PORT` or `PORT` - Default port
- `NUXT_HOST` or `HOST` - Default host

## Building

### Production Build

```bash
# Build for production
npx nuxt build

# Build with prerendering
npx nuxt build --prerender

# Build with specific preset
npx nuxt build --preset node-server
npx nuxt build --preset cloudflare-pages
npx nuxt build --preset vercel

# Build with environment
npx nuxt build --envName staging
```

Output is created in `.output/` directory.

### Static Generation

```bash
# Generate static site (prerenders all routes)
npx nuxt generate
```

Equivalent to `nuxt build --prerender`. Creates static HTML files for deployment to static hosting.

### Preview Production Build

```bash
# Preview after build
npx nuxt preview

# Custom port
npx nuxt preview --port 4000
```

## Utilities

### Prepare (Type Generation)

```bash
# Generate TypeScript types and .nuxt directory
npx nuxt prepare
```

Run after cloning or when types are missing.

### Type Check

```bash
# Run TypeScript type checking
npx nuxt typecheck
```

### Analyze Bundle

```bash
# Analyze production bundle
npx nuxt analyze
```

Opens visual bundle analyzer.

### Cleanup

```bash
# Remove generated files (.nuxt, .output, node_modules/.cache)
npx nuxt cleanup
```

### Info

```bash
# Show environment info (useful for bug reports)
npx nuxt info
```

### Upgrade

```bash
# Upgrade Nuxt to latest version
npx nuxt upgrade

# Upgrade to nightly release
npx nuxt upgrade --nightly
```

## Module Commands

### Add Module

```bash
# Add a Nuxt module
npx nuxt module add @nuxt/ui
npx nuxt module add @nuxt/image
```

Installs and adds to `nuxt.config.ts`.

### Build Module (for module authors)

```bash
# Build a Nuxt module
npx nuxt build-module
```

## DevTools

```bash
# Enable DevTools globally
npx nuxt devtools enable

# Disable DevTools
npx nuxt devtools disable
```

## Common Workflows

### Development

```bash
# Install dependencies and start dev
pnpm install
pnpm dev  # or npx nuxt dev
```

### Production Deployment

```bash
# Build and preview locally
pnpm build
pnpm preview

# Or for static hosting
pnpm generate
```

### After Cloning

```bash
# Install deps and prepare types
pnpm install
npx nuxt prepare
```

## Environment-specific Builds

```bash
# Development build
npx nuxt build --envName development

# Staging build
npx nuxt build --envName staging

# Production build (default)
npx nuxt build --envName production
```

Corresponds to `$development`, `$env.staging`, `$production` in `nuxt.config.ts`.

## Layer Extension

```bash
# Dev with additional layer
npx nuxt dev --extends ./base-layer

# Build with layer
npx nuxt build --extends ./base-layer
```

<!-- 
Source references:
- https://nuxt.com/docs/api/commands/dev
- https://nuxt.com/docs/api/commands/build
- https://nuxt.com/docs/api/commands/generate
- https://nuxt.com/docs/api/commands/init
-->
