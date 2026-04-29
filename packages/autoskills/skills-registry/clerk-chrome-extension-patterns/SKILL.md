---
name: clerk-chrome-extension-patterns
description: 'Chrome Extension auth with @clerk/chrome-extension -- popup/sidepanel
  setup, syncHost for OAuth/SAML via web app, createClerkClient for service workers
  and headless extensions, stable CRX ID. Triggers on: Chrome extension auth, Plasmo
  clerk, popup sign-in, syncHost, background service worker token, createClerkClient,
  headless extension.'
license: MIT
allowed-tools: WebFetch
metadata:
  author: clerk
  version: 2.0.0
  inputs:
  - name: PLASMO_PUBLIC_CLERK_PUBLISHABLE_KEY
    description: Clerk publishable key (Plasmo prefix for public env vars)
    required: true
  - name: CLERK_FRONTEND_API
    description: Clerk frontend API URL (https://YOUR_FRONTEND_API_URL)
    required: true
  references:
  - references/sync-host.md
  - references/create-clerk-client.md
  - references/content-scripts.md
  - references/headless-extension.md
---

# Chrome Extension Patterns

## CRITICAL RULES

1. OAuth (Google, GitHub, etc.) and SAML are NOT supported in popups or side panels -- use `syncHost` to delegate auth to your web app
2. Email links (magic links) don't work in popups -- the popup closes when the user clicks outside, resetting sign-in state
3. Side panels don't auto-refresh auth state -- users must close and reopen the side panel after signing in via the web app
4. Service workers and content scripts have NO access to Clerk React hooks -- use `createClerkClient()` or message passing
5. Extension URLs use `chrome-extension://` not `http://` -- all redirect URLs must use `chrome.runtime.getURL('.')`
6. Without a stable CRX ID, every rebuild breaks auth -- configure `key` in manifest BEFORE deploying
7. Content scripts cannot use Clerk directly due to origin restrictions -- Clerk enforces strict allowed origins
8. Bot protection must be DISABLED in Clerk Dashboard -- Cloudflare bot detection is not supported in extension environments

## Authentication Options

| Method | Popup | Side Panel | syncHost (with web app) |
|--------|-------|------------|------------------------|
| Email + OTP | Yes | Yes | Yes |
| Email + Link | No | No | Yes |
| Email + Password | Yes | Yes | Yes |
| Username + Password | Yes | Yes | Yes |
| SMS + OTP | Yes | Yes | Yes |
| OAuth (Google, GitHub, etc.) | **NO** | **NO** | **YES** |
| SAML | **NO** | **NO** | **YES** |
| Passkeys | Yes | Yes | Yes |
| Google One Tap | No | No | Yes |
| Web3 | No | No | Yes |

## Quick Start (Plasmo)

```bash
npx create-plasmo --with-tailwindcss --with-src my-extension
cd my-extension
npm install @clerk/chrome-extension
```

Enable **Native API** in Clerk Dashboard under Native applications. Required for all extension integrations.

`.env.development`:
```
PLASMO_PUBLIC_CLERK_PUBLISHABLE_KEY=pk_test_...
CLERK_FRONTEND_API=https://your-app.clerk.accounts.dev
```

`src/popup.tsx`:
```tsx
import { ClerkProvider, Show, SignInButton, SignUpButton, UserButton } from '@clerk/chrome-extension'

const PUBLISHABLE_KEY = process.env.PLASMO_PUBLIC_CLERK_PUBLISHABLE_KEY
const EXTENSION_URL = chrome.runtime.getURL('.')

if (!PUBLISHABLE_KEY) {
  throw new Error('Missing PLASMO_PUBLIC_CLERK_PUBLISHABLE_KEY')
}

function IndexPopup() {
  return (
    <ClerkProvider
      publishableKey={PUBLISHABLE_KEY}
      afterSignOutUrl={`${EXTENSION_URL}/popup.html`}
      signInFallbackRedirectUrl={`${EXTENSION_URL}/popup.html`}
      signUpFallbackRedirectUrl={`${EXTENSION_URL}/popup.html`}
    >
      <Show when="signed-out">
        <SignInButton mode="modal" />
        <SignUpButton mode="modal" />
      </Show>
      <Show when="signed-in">
        <UserButton />
      </Show>
    </ClerkProvider>
  )
}

export default IndexPopup
```

Use `mode="modal"` for `SignInButton` -- navigating to a separate page breaks the popup flow.

## syncHost -- Sync Auth with Web App

Use this when you need OAuth, SAML, or want the extension to reflect sign-in from your web app.

**How it works**: The extension reads the Clerk session cookie from your web app's domain via `host_permissions`.

**Step 1 -- Environment variables:**

`.env.development`:
```
PLASMO_PUBLIC_CLERK_PUBLISHABLE_KEY=pk_test_...
CLERK_FRONTEND_API=https://your-app.clerk.accounts.dev
PLASMO_PUBLIC_CLERK_SYNC_HOST=http://localhost
```

`.env.production`:
```
PLASMO_PUBLIC_CLERK_PUBLISHABLE_KEY=pk_live_...
CLERK_FRONTEND_API=https://clerk.your-domain.com
PLASMO_PUBLIC_CLERK_SYNC_HOST=https://clerk.your-domain.com
```

**Step 2 -- Add `syncHost` prop:**

```tsx
const SYNC_HOST = process.env.PLASMO_PUBLIC_CLERK_SYNC_HOST

<ClerkProvider
  publishableKey={PUBLISHABLE_KEY}
  syncHost={SYNC_HOST}
  afterSignOutUrl="/"
  routerPush={(to) => navigate(to)}
  routerReplace={(to) => navigate(to, { replace: true })}
>
```

**Step 3 -- Configure `host_permissions` in `package.json`:**

```json
{
  "manifest": {
    "key": "$CRX_PUBLIC_KEY",
    "permissions": ["cookies", "storage"],
    "host_permissions": [
      "$PLASMO_PUBLIC_CLERK_SYNC_HOST/*",
      "$CLERK_FRONTEND_API/*"
    ]
  }
}
```

**Step 4 -- Add extension ID to web app's allowed origins via Clerk API:**

```bash
curl -X PATCH https://api.clerk.com/v1/instance \
  -H "Authorization: Bearer YOUR_SECRET_KEY" \
  -H "Content-type: application/json" \
  -d '{"allowed_origins": ["chrome-extension://YOUR_EXTENSION_ID"]}'
```

**Hide unsupported auth methods in popup when using syncHost:**

```tsx
<SignIn
  appearance={{
    elements: {
      socialButtonsRoot: 'plasmo-hidden',
      dividerRow: 'plasmo-hidden',
    },
  }}
/>
```

Full guide: `references/sync-host.md`

## createClerkClient() for Vanilla JS / Service Workers

Import from `@clerk/chrome-extension/client` (not `@clerk/chrome-extension`).

**Background service worker** (`src/background/index.ts`):

```typescript
import { createClerkClient } from '@clerk/chrome-extension/client'

const publishableKey = process.env.PLASMO_PUBLIC_CLERK_PUBLISHABLE_KEY

async function getToken(): Promise<string | null> {
  const clerk = await createClerkClient({
    publishableKey,
    background: true,
  })
  if (!clerk.session) return null
  return await clerk.session.getToken()
}

chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
  getToken()
    .then((token) => sendResponse({ token }))
    .catch((error) => {
      console.error('[Background] Error:', JSON.stringify(error))
      sendResponse({ token: null })
    })
  return true
})
```

The `background: true` flag keeps sessions fresh even when popup/sidepanel is closed. Without it, tokens expire after 60 seconds.

**Popup with vanilla JS** (`src/popup.ts`):

```typescript
import { createClerkClient } from '@clerk/chrome-extension/client'

const EXTENSION_URL = chrome.runtime.getURL('.')
const POPUP_URL = `${EXTENSION_URL}popup.html`

const clerk = createClerkClient({ publishableKey })

clerk.load({
  afterSignOutUrl: POPUP_URL,
  signInForceRedirectUrl: POPUP_URL,
  signUpForceRedirectUrl: POPUP_URL,
  allowedRedirectProtocols: ['chrome-extension:'],
}).then(() => {
  clerk.addListener(render)
  render()
})
```

Full guide: `references/create-clerk-client.md`

## Headless Extension (no popup, no side panel)

For extensions that run entirely in the background and sync with a web app.

Uses `syncHost` + `createClerkClient` with `background: true` to read auth state from the web app's cookies.

```typescript
import { createClerkClient } from '@clerk/chrome-extension/client'

const publishableKey = process.env.PLASMO_PUBLIC_CLERK_PUBLISHABLE_KEY
const syncHost = process.env.PLASMO_PUBLIC_CLERK_SYNC_HOST

async function getAuthenticatedUser() {
  const clerk = await createClerkClient({
    publishableKey,
    syncHost,
    background: true,
  })
  return clerk.user
}
```

Requires `host_permissions` for the sync host domain in `package.json`.

Full guide: `references/headless-extension.md`

## Content Scripts

Content scripts run in an isolated JavaScript world injected into web pages. **Clerk cannot be used directly** -- origin restrictions prevent it.

Use message passing to request auth state from the background service worker:

```typescript
// content.ts
async function getToken(): Promise<string | null> {
  return new Promise((resolve) => {
    chrome.runtime.sendMessage({ type: 'GET_TOKEN' }, (response) => {
      resolve(response?.token ?? null)
    })
  })
}

async function main() {
  const token = await getToken()
  if (!token) return
  // use token for authenticated API calls
}

main()
```

Full guide: `references/content-scripts.md`

## Stable CRX ID

Without a pinned key, Chrome derives the CRX ID from a random key at build time. This rotates every rebuild, breaking allowed origins.

**Option A -- Plasmo Itero (recommended):**
1. Visit [Plasmo Itero Generate Keypairs](https://itero.plasmo.com/ext/generate-keypairs)
2. Click "Generate KeyPairs" -- save Private Key securely, copy Public Key and CRX ID

**Option B -- OpenSSL:**
```bash
openssl genrsa -out key.pem 2048
# Use Plasmo Itero to convert or extract the public key in correct format
```

**`.env.chrome`:**
```
CRX_PUBLIC_KEY="<PUBLIC KEY from Itero>"
```

**`package.json`:**
```json
{
  "manifest": {
    "key": "$CRX_PUBLIC_KEY",
    "permissions": ["cookies", "storage"],
    "host_permissions": [
      "http://localhost/*",
      "$CLERK_FRONTEND_API/*"
    ]
  }
}
```

Add `chrome-extension://YOUR_STABLE_CRX_ID` to Clerk Dashboard > Allowed Origins.

## Token Cache (persist across popup closes)

```tsx
const tokenCache = {
  async getToken(key: string) {
    const result = await chrome.storage.local.get(key)
    return result[key] ?? null
  },
  async saveToken(key: string, token: string) {
    await chrome.storage.local.set({ [key]: token })
  },
  async clearToken(key: string) {
    await chrome.storage.local.remove(key)
  },
}

<ClerkProvider publishableKey={PUBLISHABLE_KEY} tokenCache={tokenCache}>
```

| Storage type | Scope | Clears on |
|---|---|---|
| `chrome.storage.local` | Device | Uninstall or manual clear |
| `chrome.storage.session` | Session | Browser close |
| `chrome.storage.sync` | All devices | Uninstall (size-limited, 8KB) |
| `localStorage` | Popup only | Popup close -- do not use for auth |

## Common Pitfalls

| Symptom | Cause | Fix |
|---------|-------|-----|
| Redirect loop on sign-in | Missing CRX URL in ClerkProvider props | Set `afterSignOutUrl`, `signInFallbackRedirectUrl` |
| OAuth button not working | OAuth not supported in popup | Use `syncHost` to delegate to web app |
| Auth state stale after web app sign-in | `syncHost` not configured | Add `syncHost` prop + `host_permissions` |
| Side panel shows signed-out after web sign-in | Known limitation | User must close and reopen the side panel |
| Background can't get token after 60s | Session expired, no background refresh | Use `createClerkClient({ background: true })` |
| Content script can't access Clerk | Isolated world + origin restrictions | Use message passing to background service worker |
| Auth breaks after rebuild | CRX ID rotated | Configure stable key via `.env.chrome` |
| `PLASMO_PUBLIC_` var undefined | Wrong env file | Use `.env.development`, not `.env` |
| Bot protection errors | Cloudflare not supported in extensions | Disable bot protection in Clerk Dashboard |
| Token cache not persisting | Using `localStorage` in popup | Use `chrome.storage.local` or pass `tokenCache` prop |

## Plan Requirements

| Feature | Plan |
|---------|------|
| Basic popup auth (email/password, OTP) | Free |
| Passkeys | Free |
| syncHost | Requires Pro (custom domain) |
| OAuth through syncHost | Pro + OAuth configured on web app |
| SAML through syncHost | Enterprise |
| Bot protection | N/A -- must be disabled for extensions |

## See Also

- `clerk-setup` - Initial Clerk install
- `clerk-custom-ui` - Custom flows & appearance
