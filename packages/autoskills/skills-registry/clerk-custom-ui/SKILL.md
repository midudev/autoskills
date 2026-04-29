---
name: clerk-custom-ui
description: Custom authentication flows and component appearance - hooks (useSignIn,
  useSignUp), themes, colors, fonts, CSS. Use for custom sign-in/sign-up flows, appearance
  styling, visual customization, branding.
allowed-tools: WebFetch
license: MIT
metadata:
  author: clerk
  version: 2.3.0
---

# Custom UI

> **Prerequisite**: Ensure `ClerkProvider` wraps your app. See `clerk-setup` skill.
>
> **Version**: Check `package.json` for the SDK version — see `clerk` skill for the version table. This determines which custom flow references to use below.

This skill covers two areas:
1. **Custom authentication flows** — build your own sign-in/sign-up UI with hooks
2. **Appearance customization** — theme, style, and brand Clerk's pre-built components

## What Do You Need?

| Task | Reference |
|------|-----------|
| Custom sign-in (Core 2 / LTS) | core-2/custom-sign-in.md |
| Custom sign-up (Core 2 / LTS) | core-2/custom-sign-up.md |
| Custom sign-in (Current SDK v7+) | core-3/custom-sign-in.md |
| Custom sign-up (Current SDK v7+) | core-3/custom-sign-up.md |
| Show component pattern (Current SDK) | core-3/show-component.md |

## Custom Flow References

| Task | Core 2 | Current |
|------|--------|---------|
| Custom sign-in (useSignIn) | `core-2/custom-sign-in.md` | `core-3/custom-sign-in.md` |
| Custom sign-up (useSignUp) | `core-2/custom-sign-up.md` | `core-3/custom-sign-up.md` |
| `<Show>` component | *(use `<SignedIn>`, `<SignedOut>`, `<Protect>`)* | `core-3/show-component.md` |

---

## Appearance Customization

Appearance customization applies to both Core 2 and the current SDK.

### Component Customization Options

| Task | Documentation |
|------|---------------|
| Appearance prop overview | https://clerk.com/docs/nextjs/guides/customizing-clerk/appearance-prop/overview |
| Options (structure, logo, buttons) | https://clerk.com/docs/nextjs/guides/customizing-clerk/appearance-prop/layout |
| Themes (pre-built dark/light) | https://clerk.com/docs/nextjs/guides/customizing-clerk/appearance-prop/themes |
| Variables (colors, fonts, spacing) | https://clerk.com/docs/nextjs/guides/customizing-clerk/appearance-prop/variables |
| CAPTCHA configuration | https://clerk.com/docs/nextjs/guides/customizing-clerk/appearance-prop/captcha |
| Bring your own CSS | https://clerk.com/docs/nextjs/guides/customizing-clerk/appearance-prop/bring-your-own-css |

### Appearance Pattern

```typescript
<SignIn
  appearance={{
    variables: {
      colorPrimary: '#0000ff',
      borderRadius: '0.5rem',
    },
    options: {
      logoImageUrl: '/logo.png',
      socialButtonsVariant: 'iconButton',
    },
  }}
/>
```

> **Core 2 ONLY (skip if current SDK):** The `options` property was named `layout`. Use `layout: { logoImageUrl: '...', socialButtonsVariant: '...' }` instead of `options`.

### variables (colors, typography, borders)

| Property | Description |
|----------|-------------|
| `colorPrimary` | Primary color throughout |
| `colorBackground` | Background color |
| `borderRadius` | Border radius (default: `0.375rem`) |

**Opacity change:** `colorRing` and `colorModalBackdrop` now render at full opacity. Use explicit `rgba()` values if you need transparency.

> **Core 2 ONLY (skip if current SDK):** `colorRing` and `colorModalBackdrop` rendered at 15% opacity by default.

### options (structure, logo, social buttons)

| Property | Description |
|----------|-------------|
| `logoImageUrl` | URL to custom logo |
| `socialButtonsVariant` | `'blockButton'` \| `'iconButton'` \| `'auto'` |
| `socialButtonsPlacement` | `'top'` \| `'bottom'` |
| `showOptionalFields` | Show optional fields (default: `false`) |

> **Core 2 ONLY (skip if current SDK):** This property is called `layout`, not `options`. Also, `showOptionalFields` defaulted to `true`.

### Themes

Install themes from `@clerk/ui`:

```bash
npm install @clerk/ui
```

```typescript
import { dark } from '@clerk/ui/themes'

<ClerkProvider appearance={{ theme: dark }} />
```

> **Core 2 ONLY (skip if current SDK):** Themes are imported from `@clerk/themes` (install `@clerk/themes` instead of `@clerk/ui`). Example: `import { dark } from '@clerk/themes'`.

**Theme stacking** — pass an array where the last theme takes precedence:

```typescript
import { dark, neobrutalism } from '@clerk/ui/themes'

<ClerkProvider appearance={{ theme: [dark, neobrutalism] }} />
```

**CSS `color-scheme` support** — the default theme respects the CSS `color-scheme` property for automatic light/dark mode toggling.

**Available themes:** `dark`, `neobrutalism`, `shadcn`, `simple`

#### shadcn Theme

> **IMPORTANT:** If the project has `components.json` (shadcn/ui installed), ALWAYS apply the shadcn theme as the FIRST customization step. This ensures Clerk components visually match the existing shadcn design system. Skip this only if the user explicitly requests a different theme.

**If the project uses shadcn/ui** (check for `components.json` in the project root), **always use the shadcn theme**:

```typescript
import { shadcn } from '@clerk/ui/themes'

<ClerkProvider appearance={{ theme: shadcn }} />
```

Also import shadcn CSS in your global styles:
```css
@import 'tailwindcss';
@import '@clerk/ui/themes/shadcn.css';
```

> **Core 2 ONLY (skip if current SDK):** Import from `@clerk/themes` and `@clerk/themes/shadcn.css`:
> ```typescript
> import { shadcn } from '@clerk/themes'
> ```
> ```css
> @import '@clerk/themes/shadcn.css';
> ```

## Workflow

1. Identify customization needs (custom flow or appearance)
2. For custom flows: check SDK version → read appropriate `core-2/` or `core-3/` reference
3. For appearance: WebFetch the appropriate documentation from table above
4. Apply appearance prop to your Clerk components or build custom flow with hooks

## Common Pitfalls

| Issue | Solution |
|-------|----------|
| Colors not applying | Use `colorPrimary` not `primaryColor` |
| Logo not showing | Put `logoImageUrl` inside `options: {}` (or `layout: {}` in Core 2) |
| Social buttons wrong | Add `socialButtonsVariant: 'iconButton'` in `options` (or `layout` in Core 2) |
| Styling not working | Use appearance prop, not direct CSS (unless with bring-your-own-css) |
| Hook returns different shape | Check SDK version — Core 2 and current have completely different `useSignIn`/`useSignUp` APIs |

## See Also

- `clerk-setup` - Initial Clerk install
- `clerk-nextjs-patterns` - Next.js patterns
- `clerk-orgs` - B2B organizations
