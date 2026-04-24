---
name: tailwind-v4-shadcn
description: |
  Production-tested setup for Tailwind CSS v4 with shadcn/ui, Vite, and React.

  Use when: initializing React projects with Tailwind v4, setting up shadcn/ui,
  implementing dark mode, debugging CSS variable issues, fixing theme switching,
  migrating from Tailwind v3, or encountering color/theming problems.

  Covers: @theme inline pattern, CSS variable architecture, dark mode with
  ThemeProvider, component composition, vite.config setup, common v4 gotchas,
  and production-tested patterns.

  Keywords: Tailwind v4, shadcn/ui, @tailwindcss/vite, @theme inline, dark mode,
  CSS variables, hsl() wrapper, components.json, React theming, theme switching,
  colors not working, variables broken, theme not applying, @plugin directive,
  typography plugin, forms plugin, prose class, @tailwindcss/typography,
  @tailwindcss/forms
license: MIT
---

# Tailwind v4 + shadcn/ui Production Stack

**Production-tested**: WordPress Auditor (https://wordpress-auditor.webfonts.workers.dev)
**Last Updated**: 2025-12-04
**Status**: Production Ready ✅

## Table of Contents
1. [Before You Start](#-before-you-start-read-this)
2. [Quick Start](#quick-start-5-minutes---follow-this-exact-order)
3. [Four-Step Architecture](#the-four-step-architecture-critical)
4. [Dark Mode Setup](#dark-mode-setup)
5. [Critical Rules](#critical-rules-must-follow)
6. [Semantic Color Tokens](#semantic-color-tokens)
7. [Common Issues & Fixes](#common-issues--quick-fixes)
8. [File Templates](#file-templates)
9. [Setup Checklist](#complete-setup-checklist)
10. [Advanced Topics](#advanced-topics)
11. [Dependencies](#dependencies)
12. [Tailwind v4 Plugins](#tailwind-v4-plugins)
13. [Reference Documentation](#reference-documentation)
14. [When to Load References](#when-to-load-references)

---

## ⚠️ BEFORE YOU START (READ THIS!)

**CRITICAL FOR AI AGENTS**: If you're Claude Code helping a user set up Tailwind v4:

1. **Explicitly state you're using this skill** at the start of the conversation
2. **Reference patterns from the skill** rather than general knowledge
3. **Prevent known issues** listed in `reference/common-gotchas.md`
4. **Don't guess** - if unsure, check the skill documentation

**USER ACTION REQUIRED**: Tell Claude to check this skill first!

Say: **"I'm setting up Tailwind v4 + shadcn/ui - check the tailwind-v4-shadcn skill first"**

### Why This Matters (Real-World Results)

**Without skill activation:**
- ❌ Setup time: ~5 minutes
- ❌ Errors encountered: 2-3 (tw-animate-css, duplicate @layer base)
- ❌ Manual fixes needed: 2+ commits
- ❌ Token usage: ~65k
- ❌ User confidence: Required debugging

**With skill activation:**
- ✅ Setup time: ~1 minute
- ✅ Errors encountered: 0
- ✅ Manual fixes needed: 0
- ✅ Token usage: ~20k (70% reduction)
- ✅ User confidence: Instant success

### Known Issues This Skill Prevents

1. **tw-animate-css import error** (deprecated in v4)
2. **Duplicate @layer base blocks** (shadcn init adds its own)
3. **Wrong template selection** (vanilla TS vs React)
4. **Missing post-init cleanup** (incompatible CSS rules)
5. **Wrong plugin syntax** (using @import or require() instead of @plugin directive)

All of these are handled automatically when the skill is active.

---

## Quick Start (5 Minutes - Follow This Exact Order)

### 1. Install Dependencies

```bash
bun add tailwindcss @tailwindcss/vite
# or: npm install tailwindcss @tailwindcss/vite

bun add -d @types/node

# Note: Using pnpm for shadcn init due to known Bun compatibility issues
# (bunx has "Script not found" and postinstall/msw problems)
pnpm dlx shadcn@latest init
```

### 2. Configure Vite

```typescript
// vite.config.ts
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'
import path from 'path'

export default defineConfig({
  plugins: [react(), tailwindcss()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src')
    }
  }
})
```

### 3. Update components.json

```json
{
  "tailwind": {
    "config": "",              // ← CRITICAL: Empty for v4
    "css": "src/index.css",
    "cssVariables": true
  }
}
```

### 4. Delete tailwind.config.ts

```bash
rm tailwind.config.ts  # v4 doesn't use this file
```

---

## The Four-Step Architecture (CRITICAL)

This pattern is **mandatory** - skipping steps will break your theme.

### Step 1: Define CSS Variables at Root Level

```css
/* src/index.css */
@import "tailwindcss";

:root {
  --background: hsl(0 0% 100%);      /* ← hsl() wrapper required */
  --foreground: hsl(222.2 84% 4.9%);
  --primary: hsl(221.2 83.2% 53.3%);
  /* ... all light mode colors */
}

.dark {
  --background: hsl(222.2 84% 4.9%);
  --foreground: hsl(210 40% 98%);
  --primary: hsl(217.2 91.2% 59.8%);
  /* ... all dark mode colors */
}
```

**Critical Rules:**
- ✅ Define at root level (NOT inside `@layer base`)
- ✅ Use `hsl()` wrapper on all color values
- ✅ Use `.dark` for dark mode (NOT `.dark { @theme { } }`)

### Step 2: Map Variables to Tailwind Utilities

```css
@theme inline {
  --color-background: var(--background);
  --color-foreground: var(--foreground);
  --color-primary: var(--primary);
  /* ... map ALL CSS variables */
}
```

**Why This Is Required:**
- Generates utility classes (`bg-background`, `text-primary`)
- Without this, `bg-primary` etc. won't exist

### Step 3: Apply Base Styles

```css
@layer base {
  body {
    background-color: var(--background);  /* NO hsl() here */
    color: var(--foreground);
  }
}
```

**Critical Rules:**
- ✅ Reference variables directly: `var(--background)`
- ❌ Never double-wrap: `hsl(var(--background))`

### Step 4: Result - Automatic Dark Mode

```tsx
<div className="bg-background text-foreground">
  {/* No dark: variants needed - theme switches automatically */}
</div>
```

---

## Dark Mode Setup

### 1. Create ThemeProvider

See `reference/dark-mode.md` for full implementation or use template:

```typescript
// Copy from: templates/theme-provider.tsx
```

### 2. Wrap Your App

```typescript
// src/main.tsx
import { ThemeProvider } from '@/components/theme-provider'

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <ThemeProvider defaultTheme="dark" storageKey="vite-ui-theme">
      <App />
    </ThemeProvider>
  </React.StrictMode>,
)
```

### 3. Add Theme Toggle

```bash
pnpm dlx shadcn@latest add dropdown-menu
```

See `reference/dark-mode.md` for ModeToggle component code.

---

## Critical Rules (MUST FOLLOW)

### ✅ Always Do:

1. **Wrap color values with `hsl()` in `:root` and `.dark`**
   ```css
   --background: hsl(0 0% 100%);  /* ✅ Correct */
   ```

2. **Use `@theme inline` to map all CSS variables**
   ```css
   @theme inline {
     --color-background: var(--background);
   }
   ```

3. **Set `"tailwind.config": ""` in components.json**
   ```json
   { "tailwind": { "config": "" } }
   ```

4. **Delete `tailwind.config.ts` if it exists**

5. **Use `@tailwindcss/vite` plugin (NOT PostCSS)**

6. **Use `cn()` for conditional classes**
   ```typescript
   import { cn } from "@/lib/utils"
   <div className={cn("base", isActive && "active")} />
   ```

### ❌ Never Do:

1. **Put `:root` or `.dark` inside `@layer base`**
   ```css
   /* WRONG */
   @layer base {
     :root { --background: hsl(...); }
   }
   ```

2. **Use `.dark { @theme { } }` pattern**
   ```css
   /* WRONG - v4 doesn't support nested @theme */
   .dark {
     @theme {
       --color-primary: hsl(...);
     }
   }
   ```

3. **Double-wrap colors**
   ```css
   /* WRONG */
   body {
     background-color: hsl(var(--background));
   }
   ```

4. **Use `tailwind.config.ts` for theme colors**
   ```typescript
   /* WRONG - v4 ignores this */
   export default {
     theme: {
       extend: {
         colors: { primary: 'hsl(var(--primary))' }
       }
     }
   }
   ```

5. **Use `@apply` directive (deprecated in v4)**

6. **Use `dark:` variants for semantic colors**
   ```tsx
   /* WRONG */
   <div className="bg-primary dark:bg-primary-dark" />

   /* CORRECT */
   <div className="bg-primary" />
   ```

---

## Semantic Color Tokens

Always use semantic names for colors:

```css
:root {
  --destructive: hsl(0 84.2% 60.2%);        /* Red - errors, critical */
  --success: hsl(142.1 76.2% 36.3%);        /* Green - success states */
  --warning: hsl(38 92% 50%);               /* Yellow - warnings */
  --info: hsl(221.2 83.2% 53.3%);           /* Blue - info, primary */
}
```

**Usage:**
```tsx
<div className="bg-destructive text-destructive-foreground">Critical</div>
<div className="bg-success text-success-foreground">Success</div>
<div className="bg-warning text-warning-foreground">Warning</div>
<div className="bg-info text-info-foreground">Info</div>
```

---

## Common Issues & Quick Fixes

| Symptom | Cause | Fix |
|---------|-------|-----|
| `bg-primary` doesn't work | Missing `@theme inline` mapping | Add `@theme inline` block |
| Colors all black/white | Double `hsl()` wrapping | Use `var(--color)` not `hsl(var(--color))` |
| Dark mode not switching | Missing ThemeProvider | Wrap app in `<ThemeProvider>` |
| Build fails | `tailwind.config.ts` exists | Delete the file |
| Text invisible | Wrong contrast colors | Check color definitions in `:root`/`.dark` |

See `reference/common-gotchas.md` for complete troubleshooting guide.

---

## File Templates

All templates are available in the `templates/` directory:

- **index.css** - Complete CSS setup with all color variables
- **components.json** - shadcn/ui v4 configuration
- **vite.config.ts** - Vite + Tailwind plugin setup
- **tsconfig.app.json** - TypeScript with path aliases
- **theme-provider.tsx** - Dark mode provider with localStorage
- **utils.ts** - `cn()` utility for class merging

Copy these files to your project and customize as needed.

---

## Complete Setup Checklist

- [ ] Vite + React + TypeScript project created
- [ ] `@tailwindcss/vite` installed (NOT postcss)
- [ ] `vite.config.ts` uses `tailwindcss()` plugin
- [ ] `tsconfig.json` has path aliases configured
- [ ] `components.json` exists with `"config": ""`
- [ ] NO `tailwind.config.ts` file exists
- [ ] `src/index.css` follows v4 pattern:
  - [ ] `:root` and `.dark` at root level (not in @layer)
  - [ ] Colors wrapped with `hsl()`
  - [ ] `@theme inline` maps all variables
  - [ ] `@layer base` uses unwrapped variables
- [ ] Theme provider installed and wrapping app
- [ ] Dark mode toggle component created
- [ ] Test theme switching works in browser

---

## Advanced Topics

Load `references/advanced-usage.md` for advanced patterns including:

- **Custom Colors**: Add semantic colors beyond default palette
- **v3 Migration**: See `references/migration-guide.md` for complete guide
- **Component Best Practices**: Semantic tokens, cn() utility, composition patterns

**Quick Example:**
```css
:root { --brand: hsl(280 65% 60%); }
@theme inline { --color-brand: var(--brand); }
```
Usage: `<div className="bg-brand">Branded</div>`

For detailed patterns and component composition examples, load `references/advanced-usage.md`.

---

## Dependencies

### ✅ Install These

```json
{
  "dependencies": {
    "tailwindcss": "^4.1.17",
    "@tailwindcss/vite": "^4.1.17",
    "clsx": "^2.1.1",
    "tailwind-merge": "^3.3.1",
    "@radix-ui/react-*": "latest",
    "lucide-react": "^0.554.0",
    "react": "^19.2.0",
    "react-dom": "^19.2.0"
  },
  "devDependencies": {
    "@types/node": "^24.10.1",
    "@vitejs/plugin-react": "^5.1.1",
    "vite": "^7.2.4",
    "typescript": "~5.9.3"
  }
}
```

### ❌ NEVER Install These (Deprecated in v4)

```bash
# These packages will cause build errors:
bun add tailwindcss-animate  # ❌ Deprecated
# or: npm install tailwindcss-animate  # ❌ Deprecated

bun add tw-animate-css      # ❌ Doesn't exist
```

**If you see import errors for these packages**, remove them and use native CSS animations or `@tailwindcss/motion` instead.

---

## Tailwind v4 Plugins

Tailwind v4 supports official plugins using the `@plugin` directive in CSS.

**Quick Example:**
```css
@import "tailwindcss";
@plugin "@tailwindcss/typography";
@plugin "@tailwindcss/forms";
```

**Common Error:**
❌ WRONG: `@import "@tailwindcss/typography"` (doesn't work)
✅ CORRECT: `@plugin "@tailwindcss/typography"` (use @plugin directive)

**Built-in Features:** Container queries are now core (no `@tailwindcss/container-queries` plugin needed).

Load `references/plugins-reference.md` for complete documentation including Typography plugin (prose classes), Forms plugin, installation steps, and common plugin errors.

---

## Reference Documentation

For deeper understanding, see:

- **common-gotchas.md** - All the ways it can break (and fixes)
- **dark-mode.md** - Complete dark mode implementation
- **migration-guide.md** - Migrating hardcoded colors to CSS variables
- **plugins-reference.md** - Official Tailwind v4 plugins (Typography, Forms)
- **advanced-usage.md** - Custom colors and advanced patterns

---

## When to Load References

Load reference files based on user's specific needs:

### Load `references/common-gotchas.md` when:
- User reports "colors not working" or "bg-primary doesn't exist"
- Dark mode not switching properly
- Build fails with Tailwind errors
- User encounters any CSS/configuration issue
- Debugging theme problems

### Load `references/dark-mode.md` when:
- User asks to implement dark mode
- Theme switching not working
- Need ThemeProvider component code
- Questions about system theme detection

### Load `references/migration-guide.md` when:
- Migrating from Tailwind v3 to v4
- User has hardcoded colors to migrate
- Questions about v3 → v4 changes
- Need migration checklist

### Load `references/plugins-reference.md` when:
- User needs Typography plugin (prose class)
- User needs Forms plugin
- Questions about @plugin directive
- Plugin installation errors

### Load `references/advanced-usage.md` when:
- User asks about custom colors beyond defaults
- Need advanced component patterns
- Questions about component best practices
- Component composition questions

---

## Official Documentation

- **shadcn/ui Vite Setup**: https://ui.shadcn.com/docs/installation/vite
- **shadcn/ui Tailwind v4 Guide**: https://ui.shadcn.com/docs/tailwind-v4
- **shadcn/ui Dark Mode (Vite)**: https://ui.shadcn.com/docs/dark-mode/vite
- **Tailwind v4 Docs**: https://tailwindcss.com/docs
- **shadcn/ui Theming**: https://ui.shadcn.com/docs/theming

---

## Production Example

This skill is based on the WordPress Auditor project:
- **Live**: https://wordpress-auditor.webfonts.workers.dev
- **Stack**: Vite + React 19 + Tailwind v4 + shadcn/ui + Cloudflare Workers
- **Dark Mode**: Full system/light/dark support
- **Version**: Tailwind v4.1.17 + shadcn/ui latest (Nov 2025)

All patterns in this skill have been validated in production.

---

**Questions? Issues?**

1. Check `reference/common-gotchas.md` first
2. Verify all steps in the 4-step architecture
3. Ensure `components.json` has `"config": ""`
4. Delete `tailwind.config.ts` if it exists
5. Check official docs: https://ui.shadcn.com/docs/tailwind-v4
