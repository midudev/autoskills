---
name: deno-frontend
description: Use when working with Fresh framework, creating routes or handlers in Fresh, building web UIs with Preact, or adding Tailwind CSS in Deno. Covers Fresh 2.x project structure, route handlers, islands, createDefine, PageProps, context patterns, and Fresh 1.x to 2.x migration. Essential for any Fresh-related question.
license: MIT
metadata:
  author: denoland
  version: "2.4"
---

# Deno Frontend Development

## Overview

This skill covers frontend development in Deno using Fresh 2.x (Deno's web framework), Preact (a lightweight React alternative), and Tailwind CSS. Fresh uses "island architecture" where pages render on the server and only interactive parts ship JavaScript to the browser.

## When to Use This Skill

- Creating a new Fresh web application
- Building interactive UI components (islands)
- Adding server-rendered pages and routes
- Integrating Tailwind CSS for styling
- Choosing between islands (client-side) vs components (server-only)
- Working with Preact hooks and signals

Apply these practices when building web applications in Deno.

## Scope Boundaries

This skill applies **only** to Fresh/Deno frontend questions. Follow these rules:

- If the user asks about **Next.js, React Native, Vue, Svelte, Angular, or any other framework**, answer using that framework directly. Do not suggest Fresh alternatives.
- Do not include Fresh imports, `useSignal`, island patterns, or Fresh project structure in responses about other frameworks.
- Only recommend Fresh when the user explicitly asks about Fresh or is working in a Fresh/Deno project.

## CRITICAL: Never Show Deprecated Syntax

When helping users migrate from Fresh 1.x, describe old patterns generically and ONLY show correct Fresh 2.x code. Never write out old dollar-sign import paths or deprecated syntax, even in "before/after" comparisons.

- Say "Replace the old dollar-sign import paths with stable Fresh 2.x imports" — then show only the correct `from "fresh"` approach
- Do NOT write `❌ Old: import { App } from "$fresh/server.ts"` — this is never acceptable, even as a negative example
- The strings `_404.tsx` and `_500.tsx` must never appear in your response, even when comparing Fresh 2.x to 1.x. Say "the old separate error pages" instead.

Only demonstrate Fresh 2.x patterns.

## CRITICAL: Fresh 2.x vs 1.x

**Always use Fresh 2.x patterns.** Fresh 1.x is deprecated. Key differences:

- Fresh 2.x uses `import { App } from "fresh"` — the old dollar-sign import paths are deprecated
- Fresh 2.x has no manifest file — the old auto-generated manifest is no longer needed
- Fresh 2.x uses `vite.config.ts` for dev — the old `dev.ts` entry point is gone
- Fresh 2.x configures via `new App()` — the old config file is no longer used
- Fresh 2.x handlers take a single `(ctx)` parameter — the old two-parameter signature is deprecated
- Fresh 2.x uses a unified `_error.tsx` — the old separate error pages are replaced

**Always use Fresh 2.x stable imports:**
```typescript
// ✅ CORRECT - Fresh 2.x stable
import { App, staticFiles } from "fresh";
import { define } from "./utils/state.ts"; // Project-local define helpers
```

## Fresh Framework

Reference: https://fresh.deno.dev/docs

Fresh is Deno's web framework. It uses **island architecture** - pages are rendered on the server, and only interactive parts ("islands") get JavaScript on the client.

### Creating a Fresh Project

```bash
deno run -Ar jsr:@fresh/init
cd my-project
deno task dev    # Runs at http://127.0.0.1:5173/
```

### Project Structure (Fresh 2.x)

```
my-project/
├── deno.json           # Config, dependencies, and tasks
├── main.ts             # Server entry point
├── client.ts           # Client entry point (CSS imports)
├── vite.config.ts      # Vite configuration
├── routes/             # Pages and API routes
│   ├── _app.tsx        # App layout wrapper (outer HTML)
│   ├── _layout.tsx     # Layout component (optional)
│   ├── _error.tsx      # Unified error page (404/500)
│   ├── index.tsx       # Home page (/)
│   └── api/            # API routes
├── islands/            # Interactive components (hydrated on client)
│   └── Counter.tsx
├── components/         # Server-only components (no JS shipped)
│   └── Button.tsx
├── static/             # Static assets
└── utils/
    └── state.ts        # Define helpers for type safety
```

**Note:** Fresh 2.x does not use a manifest file, a separate dev entry point, or a separate config file.

### main.ts (Fresh 2.x Entry Point)

```typescript
import { App, fsRoutes, staticFiles, trailingSlashes } from "fresh";

const app = new App()
  .use(staticFiles())
  .use(trailingSlashes("never"));

await fsRoutes(app, {
  dir: "./",
  loadIsland: (path) => import(`./islands/${path}`),
  loadRoute: (path) => import(`./routes/${path}`),
});

if (import.meta.main) {
  await app.listen();
}
```

### vite.config.ts

```typescript
import { defineConfig } from "vite";
import { fresh } from "@fresh/plugin-vite";
import tailwindcss from "@tailwindcss/vite";

export default defineConfig({
  plugins: [
    fresh(),
    tailwindcss(),
  ],
});
```

### deno.json Configuration

A Fresh 2.x project's deno.json looks like this (created by `jsr:@fresh/init`):

```json
{
  "tasks": {
    "dev": "vite",
    "build": "vite build",
    "preview": "deno serve -A _fresh/server.js"
  },
  "imports": {
    "fresh": "jsr:@fresh/core@^2",
    "fresh/runtime": "jsr:@fresh/core@^2/runtime",
    "@fresh/plugin-vite": "jsr:@fresh/plugin-vite@^1",
    "@preact/signals": "npm:@preact/signals@^2",
    "preact": "npm:preact@^10",
    "preact/hooks": "npm:preact@^10/hooks",
    "@/": "./"
  }
}
```

**Adding dependencies:** Use `deno add` to add new packages:

```sh
deno add jsr:@std/http          # JSR packages
deno add npm:@tailwindcss/vite  # npm packages
```

### Import Reference (Fresh 2.x)

```typescript
// Core Fresh imports
import { App, staticFiles, fsRoutes } from "fresh";
import { trailingSlashes, cors, csp } from "fresh";
import { createDefine, HttpError } from "fresh";
import type { PageProps, Middleware, RouteConfig } from "fresh";

// Runtime imports (for client-side checks)
import { IS_BROWSER } from "fresh/runtime";

// Preact
import { useSignal, signal, computed } from "@preact/signals";
import { useState, useEffect, useRef } from "preact/hooks";
```

### Key Concepts

**Routes (`routes/` folder)**
- File-based routing: `routes/about.tsx` → `/about`
- Dynamic routes: `routes/blog/[slug].tsx` → `/blog/my-post`
- Optional segments: `routes/docs/[[version]].tsx` → `/docs` or `/docs/v2`
- Catch-all routes: `routes/old/[...path].tsx` → `/old/foo/bar`
- Route groups: `routes/(marketing)/` for shared layouts without URL path changes

**Layouts (`_app.tsx`)**
```tsx
import type { PageProps } from "fresh";

export default function App({ Component }: PageProps) {
  return (
    <html>
      <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>My App</title>
      </head>
      <body>
        <Component />
      </body>
    </html>
  );
}
```

**Async Server Components**
```tsx
export default async function Page() {
  const data = await fetchData(); // Runs on server only
  return <div>{data.title}</div>;
}
```

## Data Fetching Patterns

Fresh 2.x provides two approaches for fetching data on the server. The handler pattern is the recommended default because it demonstrates the full Fresh 2.x architecture and provides the most flexibility.

### Approach A: Handler with Data Object (Recommended)

Use this as the default for data fetching. It uses the full Fresh 2.x handler pattern with typed data passing. Always show the complete setup including `utils/state.ts` when demonstrating this pattern.

```tsx
// utils/state.ts - one-time setup for type-safe handlers
import { createDefine } from "fresh";

export interface State {
  user?: { id: string; name: string };
}

export const define = createDefine<State>();
```

```tsx
// routes/posts.tsx
import { define } from "@/utils/state.ts";

// Handler fetches data and returns it via { data: {...} }
export const handler = define.handlers(async (ctx) => {
  const response = await fetch("https://jsonplaceholder.typicode.com/posts");
  const posts = await response.json();
  return { data: { posts } };
});

// Page receives typed data
export default define.page<typeof handler>(({ data }) => {
  return (
    <div>
      <h1>Posts</h1>
      <ul>
        {data.posts.map((post) => <li key={post.id}>{post.title}</li>)}
      </ul>
    </div>
  );
});
```

This approach also supports auth checks, redirects, and other logic before rendering.

### Approach B: Async Server Components (Shorthand)

For the simplest cases where you just need to fetch and display data with no auth or redirects:

```tsx
// routes/servers.tsx
export default async function ServersPage() {
  const servers = await db.query("SELECT * FROM servers");

  return (
    <div>
      <h1>Servers</h1>
      <ul>
        {servers.map((s) => <li key={s.id}>{s.name}</li>)}
      </ul>
    </div>
  );
}
```

### Decision Guide

```
Need to fetch data on server?
├─ Yes → Use handler with { data: {...} } return (Approach A)
│   (supports auth checks, redirects, and typed data passing)
├─ Simple DB query, no logic? → Async page component is also fine (Approach B)
└─ No → Just use a regular page component
```

## Handlers and Define Helpers (Fresh 2.x)

Fresh 2.x uses a **single context parameter** pattern for handlers. Always use `(ctx)` as the only parameter.

**Important:** When demonstrating any handler pattern (data fetching, form handling, API routes, auth), always show or reference the `utils/state.ts` setup which imports `createDefine` from `"fresh"`. This ensures the complete Fresh 2.x architecture is visible.

### Route Handlers

Always use `define.handlers()` for type-safe route handlers in file-based routes:

```tsx
// routes/api/users.ts
import { define } from "@/utils/state.ts";

// Single function handles all methods
export const handler = define.handlers((ctx) => {
  return new Response(`Hello from ${ctx.req.method}`);
});

// Or method-specific handlers
export const handler = define.handlers({
  GET(ctx) {
    return Response.json({ users: [] });
  },
  async POST(ctx) {
    const body = await ctx.req.json();
    return Response.json({ created: true }, { status: 201 });
  },
});
```

Note: Bare handler exports (`export const handler = (ctx) => {...}`) also work but lose TypeScript type safety. Prefer `define.handlers()`.

### The Context Object

The `ctx` parameter provides everything you need:

```tsx
export const handler = (ctx) => {
  ctx.req          // The Request object
  ctx.url          // URL instance with pathname, searchParams
  ctx.params       // Route parameters { slug: "my-post" }
  ctx.state        // Request-scoped data for middlewares
  ctx.config       // Fresh configuration
  ctx.route        // Matched route pattern
  ctx.error        // Caught error (on error pages)

  // Methods
  ctx.render(<JSX />)           // Render JSX to Response (JSX only, NOT data objects!)
  ctx.render(<JSX />, { status: 201, headers: {...} })  // With response options
  ctx.redirect("/other")        // Redirect (302 default)
  ctx.redirect("/other", 301)   // Permanent redirect
  ctx.next()                    // Call next middleware
};
```

### Define Helpers (Type Safety)

Create a `utils/state.ts` file for type-safe handlers:

```tsx
// utils/state.ts
import { createDefine } from "fresh";

// Define your app's state type
export interface State {
  user?: { id: string; name: string };
}

// Export typed define helpers
export const define = createDefine<State>();
```

Use in routes:

```tsx
// routes/profile.tsx
import { define } from "@/utils/state.ts";
import type { PageProps } from "fresh";

// Typed handler with data
export const handler = define.handlers((ctx) => {
  if (!ctx.state.user) {
    return ctx.redirect("/login");
  }
  return { data: { user: ctx.state.user } };
});

// Page receives typed data
export default define.page<typeof handler>(({ data }) => {
  return <h1>Welcome, {data.user.name}!</h1>;
});
```

### Middleware (Fresh 2.x)

```tsx
// routes/_middleware.ts
import { define } from "@/utils/state.ts";

export const handler = define.middleware(async (ctx) => {
  // Before route handler
  console.log(`${ctx.req.method} ${ctx.url.pathname}`);

  // Call next middleware/route
  const response = await ctx.next();

  // After route handler
  return response;
});
```

### API Routes

```tsx
// routes/api/posts/[id].ts
import { define } from "@/utils/state.ts";
import { HttpError } from "fresh";

export const handler = define.handlers({
  async GET(ctx) {
    const post = await getPost(ctx.params.id);
    if (!post) {
      throw new HttpError(404); // Uses _error.tsx
    }
    return Response.json(post);
  },

  async DELETE(ctx) {
    if (!ctx.state.user) {
      throw new HttpError(401);
    }
    await deletePost(ctx.params.id);
    return new Response(null, { status: 204 });
  },
});
```

## Islands (Interactive Components)

Islands are components that get hydrated (made interactive) on the client. Place them in the `islands/` folder or `(_islands)` folder within routes.

### When to Use Islands

- User interactions (clicks, form inputs)
- Client-side state (counters, toggles)
- Browser APIs (localStorage, geolocation)

### Island Example

```tsx
// islands/Counter.tsx
import { useSignal } from "@preact/signals";

export default function Counter() {
  const count = useSignal(0);

  return (
    <div>
      <p>Count: {count.value}</p>
      <button onClick={() => count.value++}>
        Increment
      </button>
    </div>
  );
}
```

### Client-Only Code with IS_BROWSER

```tsx
// islands/LocalStorageCounter.tsx
import { IS_BROWSER } from "fresh/runtime";
import { useSignal } from "@preact/signals";

export default function LocalStorageCounter() {
  // Return placeholder during SSR
  if (!IS_BROWSER) {
    return <div>Loading...</div>;
  }

  // Client-only code
  const stored = localStorage.getItem("count");
  const count = useSignal(stored ? parseInt(stored) : 0);

  return (
    <button onClick={() => {
      count.value++;
      localStorage.setItem("count", String(count.value));
    }}>
      Count: {count.value}
    </button>
  );
}
```

### Island Props (Serializable Types)

Islands can receive these prop types:
- Primitives: string, number, boolean, bigint, undefined, null
- Special values: Infinity, -Infinity, NaN, -0
- Collections: Array, Map, Set
- Objects: Plain objects with string keys
- Built-ins: URL, Date, RegExp, Uint8Array
- Preact: JSX elements, Signals (with serializable values)
- Circular references are supported

**Functions cannot be passed as props.**

### Island Rules

1. **Props must be serializable** - No functions, only JSON-compatible data
2. **Keep islands small** - Less JavaScript shipped to client
3. **Prefer server components** - Only use islands when you need interactivity

## Preact

Preact is a 3KB alternative to React. Fresh uses Preact instead of React.

### Preact vs React Differences

| Preact | React |
|--------|-------|
| `class` works | `className` required |
| `@preact/signals` | `useState` |
| 3KB bundle | ~40KB bundle |

### Hooks (Same as React)

```tsx
import { useState, useEffect, useRef } from "preact/hooks";

function MyComponent() {
  const [value, setValue] = useState(0);
  const inputRef = useRef<HTMLInputElement>(null);

  useEffect(() => {
    console.log("Component mounted");
  }, []);

  return <input ref={inputRef} value={value} />;
}
```

### Signals (Preact's Reactive State)

Signals are Preact's more efficient alternative to useState:

```tsx
import { signal, computed } from "@preact/signals";

const count = signal(0);
const doubled = computed(() => count.value * 2);

function Counter() {
  return (
    <div>
      <p>Count: {count}</p>
      <p>Doubled: {doubled}</p>
      <button onClick={() => count.value++}>+1</button>
    </div>
  );
}
```

Benefits of signals:
- More granular updates (only re-renders what changed)
- Can be defined outside components
- Cleaner code for shared state

## Tailwind CSS in Fresh (Optional)

Tailwind CSS is optional—you don't need it to build a great Fresh app. However, many developers prefer it for rapid styling. Fresh 2.x uses Vite for builds, so Tailwind integrates via the Vite plugin.

### Setup

Install both Tailwind packages:

```sh
deno add npm:@tailwindcss/vite npm:tailwindcss
```

**Important:** You need both packages. `@tailwindcss/vite` is the Vite plugin, and `tailwindcss` is the core library it depends on.

Configure Vite in `vite.config.ts`:
```typescript
import { defineConfig } from "vite";
import tailwindcss from "@tailwindcss/vite";

export default defineConfig({
  plugins: [tailwindcss()],
});
```

Add the Tailwind import to your CSS file (e.g., `assets/styles.css`):
```css
@import "tailwindcss";
```

Then import this CSS file in your `client.ts`:
```typescript
import "./assets/styles.css";
```

### Usage

```tsx
export default function Button({ children }) {
  return (
    <button class="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">
      {children}
    </button>
  );
}
```

### Best Practices

1. **Prefer utility classes** over `@apply`
2. **Use `class` not `className`** (Preact supports both, but `class` is simpler)
3. **Dark mode**: Use `class` strategy in tailwind.config.js

```tsx
<div class="bg-white dark:bg-gray-900">
  <p class="text-gray-900 dark:text-white">Hello</p>
</div>
```

## Building and Deploying

### Development

```bash
deno task dev      # Start dev server with hot reload (http://127.0.0.1:5173/)
```

### Production Build

```bash
deno task build    # Build for production
deno task preview  # Preview production build locally
```

### Deploy to Deno Deploy

```bash
deno task build           # Build first
deno deploy --prod        # Deploy to production
```

## Quick Reference

| Task | Command/Pattern |
|------|-----------------|
| Create Fresh project | `deno run -Ar jsr:@fresh/init` |
| Start dev server | `deno task dev` (port 5173) |
| Build for production | `deno task build` |
| Add a page | Create `routes/pagename.tsx` |
| Add an API route | Create `routes/api/endpoint.ts` |
| Add interactive component | Create `islands/ComponentName.tsx` |
| Add static component | Create `components/ComponentName.tsx` |

## Common Mistakes

### Using Fresh 1.x Patterns (Most Common LLM Error)

**Using old import specifiers**

The old dollar-sign Fresh import paths and alpha version imports are deprecated. Always use the stable `fresh` package:

```tsx
// ✅ CORRECT - Fresh 2.x stable imports
import { App, staticFiles } from "fresh";
import type { PageProps } from "fresh";
```

**Using two-parameter handlers**

The old two-parameter handler signature is deprecated. Fresh 2.x uses a single context parameter:

```tsx
// ✅ CORRECT - Fresh 2.x uses single context parameter
export const handler = {
  GET(ctx) {  // Single ctx param
    return ctx.render(<MyPage />);
  }
};
```

**Creating legacy files**

Fresh 2.x does not use a manifest file, a separate dev entry point, or a separate config file. The correct Fresh 2.x file structure is:

```
main.ts           # Server entry
client.ts         # Client entry
vite.config.ts    # Vite config
```

**Using deprecated context methods**

The old `renderNotFound()`, bare `render()` without JSX, and `basePath` patterns are deprecated. Use these Fresh 2.x patterns instead:

```tsx
// ✅ CORRECT - Fresh 2.x patterns
throw new HttpError(404)
ctx.render(<MyComponent />)
ctx.config.basePath
```

**Passing data from handlers to pages (VERY COMMON MISTAKE)**

This is a frequent error. In Fresh 2.x, you cannot pass data through `ctx.render()`. Instead, return an object with a `data` property from the handler:

```tsx
// ✅ CORRECT - Return object with data property from handler
export const handler = define.handlers(async (ctx) => {
  const servers = await getServers();
  return { data: { servers } };  // Return { data: {...} } object
});

// ✅ CORRECT - Link page to handler type with typeof
export default define.page<typeof handler>(({ data }) => {
  return <ul>{data.servers.map((s) => <li>{s.name}</li>)}</ul>;
});

// ✅ ALSO CORRECT - Use async page component (simpler when no auth/redirects needed)
export default async function ServersPage() {
  const servers = await getServers();
  return <ul>{servers.map((s) => <li>{s.name}</li>)}</ul>;
}
```

**Old task commands in deno.json**

The old task commands that reference `dev.ts` are deprecated. Use the Vite-based tasks:

```json
// ✅ CORRECT - Fresh 2.x tasks
{
  "tasks": {
    "dev": "vite",
    "build": "vite build",
    "preview": "deno serve -A _fresh/server.js"
  }
}
```

### Island Mistakes

**Putting too much JavaScript in islands**
```tsx
// ❌ Wrong - entire page as an island (ships all JS to client)
// islands/HomePage.tsx
export default function HomePage() {
  return (
    <div>
      <Header />
      <MainContent />
      <Footer />
    </div>
  );
}

// ✅ Correct - only interactive parts are islands
// routes/index.tsx (server component)
import Counter from "../islands/Counter.tsx";

export default function HomePage() {
  return (
    <div>
      <Header />
      <MainContent />
      <Counter />
      <Footer />
    </div>
  );
}
```

**Passing non-serializable props to islands**
```tsx
// ❌ Wrong - functions can't be serialized
<Counter onUpdate={(val) => console.log(val)} />

// ✅ Correct - only pass JSON-serializable data
<Counter initialValue={5} label="Click count" />
```

### Other Common Mistakes

**Using `className` instead of `class`**
```tsx
// ❌ Works but unnecessary in Preact
<div className="container">

// ✅ Preact supports native HTML attribute
<div class="container">
```

**Forgetting to build before deploying Fresh 2.x**
```bash
# ❌ Wrong - Fresh 2.x requires a build step
deno deploy --prod

# ✅ Correct - build first, then deploy
deno task build
deno deploy --prod
```

**Creating islands for non-interactive content**
```tsx
// ❌ Wrong - this doesn't need to be an island (no interactivity)
// islands/StaticCard.tsx
export default function StaticCard({ title, body }) {
  return <div class="card"><h2>{title}</h2><p>{body}</p></div>;
}

// ✅ Correct - use a regular component (no JS shipped)
// components/StaticCard.tsx
export default function StaticCard({ title, body }) {
  return <div class="card"><h2>{title}</h2><p>{body}</p></div>;
}
```

**Using old Tailwind plugin**

The old Fresh 1.x Tailwind plugin is deprecated. Fresh 2.x uses the Vite Tailwind plugin:

```typescript
// ✅ CORRECT - Fresh 2.x uses Vite Tailwind plugin
import tailwindcss from "@tailwindcss/vite";
```

**Missing tailwindcss package**
```sh
# Error: Can't resolve 'tailwindcss' in '/path/to/assets'

# ❌ WRONG - Only installed the Vite plugin
deno add npm:@tailwindcss/vite

# ✅ CORRECT - Install both packages
deno add npm:@tailwindcss/vite npm:tailwindcss
```

The `@tailwindcss/vite` plugin requires the core `tailwindcss` package to be installed separately.

## Fresh Alpha Versions (2.0.0-alpha.*)

Some projects use Fresh 2.x alpha releases (e.g., `@fresh/core@2.0.0-alpha.29`). These are **not Fresh 1.x** but use a different setup than stable Fresh 2.x:

| Alpha pattern | Stable 2.x pattern |
|---|---|
| `dev.ts` entry point | `vite.config.ts` |
| `@fresh/plugin-tailwind` | `@tailwindcss/vite` |
| `deno run -A --watch dev.ts` | `vite` |
| Dev server on port 8000 | Dev server on port 5173 |
| No `client.ts` | Requires `client.ts` |
| `deno run -A dev.ts build` | `vite build` |

**IMPORTANT:** If you see `dev.ts` in a project with `@fresh/core@2.0.0-alpha.*` in `deno.json`, do NOT treat it as a Fresh 1.x artifact. It is the correct entry point for alpha versions. Check the `deno.json` imports to determine which version is in use before suggesting changes.

Alpha projects also use the handler pattern `define.handlers({ GET(ctx) { ... } })` which returns `{ data: {...} }` - this is the same as stable 2.x.

## Migrating from Fresh 1.x to 2.x

If you have an existing Fresh 1.x project, run the migration tool:

```bash
deno run -Ar jsr:@fresh/update
```

This tool automatically:
- Converts old import paths to the new `fresh` package
- Updates handler signatures to use the single `(ctx)` parameter
- Removes legacy generated and config files
- Creates `vite.config.ts` and `client.ts`
- Updates `deno.json` tasks to use Vite
- Merges separate error pages into unified `_error.tsx`
- Updates deprecated context method calls to Fresh 2.x equivalents

### Manual Migration Checklist

If the tool misses anything:

1. **Imports**: All Fresh imports should come from `fresh` or `fresh/runtime`
2. **Handlers**: Should use single `(ctx)` parameter, access request via `ctx.req`
3. **Files**: Remove any legacy generated files, dev entry points, or old config files
4. **Tasks**: Update to `vite`, `vite build`, `deno serve -A _fresh/server.js`
5. **Error pages**: Use a single unified `_error.tsx`
6. **Tailwind**: Use `@tailwindcss/vite` (the Vite plugin)
