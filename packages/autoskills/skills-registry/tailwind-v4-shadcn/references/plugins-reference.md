# Tailwind v4 Plugins Reference

**Purpose**: Complete guide to Tailwind v4 official plugins (Typography, Forms)
**When to Load**: User mentions prose class, Typography plugin, Forms plugin, @plugin directive, or plugin installation errors

---

## Overview

Tailwind v4 supports official plugins using the `@plugin` directive in CSS (not the v3 config file approach).

---

## Official Plugins (Tailwind Labs)

### Typography Plugin - Style Markdown/CMS Content

**When to use:** Displaying blog posts, documentation, or any HTML from Markdown/CMS.

**Installation:**
```bash
bun add -d @tailwindcss/typography
# or: npm install -D @tailwindcss/typography
```

**Configuration (v4 syntax):**
```css
/* src/index.css */
@import "tailwindcss";
@plugin "@tailwindcss/typography";
```

**Usage:**
```html
<article class="prose lg:prose-xl dark:prose-invert">
  {{ markdown_content }}
</article>
```

**Available classes:**
- `prose` - Base typography styles
- `prose-sm`, `prose-base`, `prose-lg`, `prose-xl`, `prose-2xl` - Size variants
- `dark:prose-invert` - Dark mode styles

---

### Forms Plugin - Reset Form Element Styles

**When to use:** Building custom forms without shadcn/ui components, or need consistent cross-browser form styling.

**Installation:**
```bash
bun add -d @tailwindcss/forms
# or: npm install -D @tailwindcss/forms
```

**Configuration (v4 syntax):**
```css
/* src/index.css */
@import "tailwindcss";
@plugin "@tailwindcss/forms";
```

**What it does:**
- Resets browser default form styles
- Makes form elements styleable with Tailwind utilities
- Fixes cross-browser inconsistencies for inputs, selects, checkboxes, radios

**Note:** Less critical for shadcn/ui users (they have pre-styled form components), but still useful for basic forms.

---

## Common Plugin Errors

These errors happen when using v3 syntax in v4 projects:

### Error 1: Using v3 config file syntax

**❌ WRONG (v3 config file syntax):**
```js
// tailwind.config.js
module.exports = {
  plugins: [require('@tailwindcss/typography')]
}
```

**Why it fails**: Tailwind v4 doesn't use `tailwind.config.js` for plugins.

**✅ CORRECT (v4 @plugin directive):**
```css
/* src/index.css */
@import "tailwindcss";
@plugin "@tailwindcss/typography";
```

---

### Error 2: Using @import instead of @plugin

**❌ WRONG (@import instead of @plugin):**
```css
@import "@tailwindcss/typography";  /* Doesn't work */
```

**Why it fails**: Plugins must be loaded with `@plugin`, not `@import`.

**✅ CORRECT:**
```css
@import "tailwindcss";
@plugin "@tailwindcss/typography";
@plugin "@tailwindcss/forms";
```

---

## Multiple Plugins

Load multiple plugins by adding multiple `@plugin` directives:

```css
/* src/index.css */
@import "tailwindcss";
@plugin "@tailwindcss/typography";
@plugin "@tailwindcss/forms";
```

**Order matters**: Import tailwindcss first, then plugins.

---

## Official Documentation

- Typography: https://tailwindcss.com/docs/typography-plugin
- Forms: https://tailwindcss.com/docs/plugins#official-plugins
- Tailwind v4 Plugin System: https://tailwindcss.com/blog/tailwindcss-v4-beta#css-first-configuration
