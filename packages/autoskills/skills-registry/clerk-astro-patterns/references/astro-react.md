# Astro + React Integration

Use Clerk components in React islands within Astro pages.

## Setup

Install the React integration:

```bash
npx astro add react
```

Update config:

```ts
// astro.config.mjs
import { defineConfig } from "astro/config"
import node from "@astrojs/node"
import react from "@astrojs/react"
import clerk from "@clerk/astro"

export default defineConfig({
	integrations: [clerk(), react()],
	output: "server",
	adapter: node({ mode: "standalone" }),
})
```

## Clerk Components in Astro Pages

Import from `@clerk/astro/react` (NOT `@clerk/astro/components`). Add `client:load` to hydrate:

```astro
---
// src/layouts/SiteLayout.astro
import { Show, UserButton, SignInButton } from "@clerk/astro/react"
---

<header>
  <nav>
    <Show when="signed-out" client:load>
      <SignInButton client:load mode="modal" />
    </Show>
    <Show when="signed-in" client:load>
      <UserButton client:load />
    </Show>
  </nav>
</header>
<slot />
```

`client:load` is required on every Clerk React component used in `.astro` files.

## Clerk Components in React Components

Standard React imports from `@clerk/astro/react`:

```tsx
// src/components/Header.tsx
import { SignInButton, Show, UserButton } from "@clerk/astro/react"

export default function Header() {
	return (
		<>
			<Show when="signed-out">
				<SignInButton />
			</Show>
			<Show when="signed-in">
				<UserButton />
			</Show>
		</>
	)
}
```

Use the component in an Astro page with `client:load`:

```astro
---
import Header from "../components/Header"
---

<Header client:load />
```

## Stores in React Components

Access user data with `$userStore` from `@clerk/astro/client`:

```tsx
// src/components/Username.tsx
import { useSyncExternalStore } from "react"
import { $userStore } from "@clerk/astro/client"

export default function Username() {
	const user = useSyncExternalStore($userStore.listen, $userStore.get, $userStore.get)
	return <>{user?.firstName}</>
}
```

## Key Differences

| Import | From | Use In |
|--------|------|--------|
| `SignedIn`, `SignedOut` | `@clerk/astro/components` | `.astro` files (SSR) |
| `Show`, `UserButton` | `@clerk/astro/react` | `.astro` files (with `client:load`) or `.tsx` files |
| `$userStore` | `@clerk/astro/client` | React components (via `useSyncExternalStore`) |
