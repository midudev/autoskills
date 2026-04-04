# autoskills

Auto-detect and install the best AI agent skills for your project. One command, zero config.

```bash
npx autoskills
```

`autoskills` scans your project, detects the technologies you use, and installs curated [AI agent skills](https://skills.sh) that make Cursor, Claude Code, and other AI coding assistants actually understand your stack.

## Quick Start

Run it in your project root:

```bash
npx autoskills
```

That's it. It will:

1. **Scan** your `package.json`, config files, and project structure
2. **Detect** every technology in your stack
3. **Show** an interactive selector with the best skills for your project
4. **Install** them in parallel with live progress

### Skip the prompt

```bash
npx autoskills -y
```

### Preview without installing

```bash
npx autoskills --dry-run
```

## Options

| Flag              | Description                                           |
| ----------------- | ----------------------------------------------------- |
| `-y`, `--yes`     | Skip confirmation prompt, install all detected skills |
| `--dry-run`       | Show detected skills without installing anything      |
| `-v`, `--verbose` | Show error details if any installation fails          |
| `-h`, `--help`    | Show help message                                     |

## Custom Skill Configuration

You can override or extend the built-in technology map with your own config files.

### Config locations

`autoskills` loads config from these locations and applies this priority:

1. **Built-in map**
2. **Global config**: first match in parent directories (starting one level above your current directory) using `.autoskillsrc.json|js|mjs|cjs` or `autoskills.config.js|mjs|cjs`
3. **Local config**: match in your current directory using `.autoskillsrc.json|js|mjs|cjs` or `autoskills.config.js|mjs|cjs`

If the same `id` appears multiple times, the last source wins. In practice:
**Local overrides Global, Global overrides Built-in**.

### Supported formats

- `.json` files with an array
- `.js` / `.mjs` / `.cjs` files exporting an array (`export default [...]` or `module.exports = [...]`)

### Supported filenames

Local (project directory):

- `.autoskillsrc.json`
- `.autoskillsrc.js`
- `.autoskillsrc.mjs`
- `.autoskillsrc.cjs`
- `autoskills.config.js`
- `autoskills.config.mjs`
- `autoskills.config.cjs`

Global (parent directories):

- `.autoskillsrc.json`
- `.autoskillsrc.js`
- `.autoskillsrc.mjs`
- `.autoskillsrc.cjs`
- `autoskills.config.js`
- `autoskills.config.mjs`
- `autoskills.config.cjs`

### Skill object schema

Your config file must export an **array** of objects with this shape:

| Field                                       | Type                   | Required | Notes                                                                              |
| ------------------------------------------- | ---------------------- | -------- | ---------------------------------------------------------------------------------- |
| `id`                                        | `string`               | Yes      | Unique key. If it matches a built-in tech, it fully replaces that tech definition. |
| `name`                                      | `string`               | Yes      | Display name in CLI output.                                                        |
| `detect`                                    | `object`               | Yes      | Detection rules used to detect the technology in a project.                        |
| `detect.packages`                           | `string[]`             | No       | Exact package names to match in dependencies/devDependencies.                      |
| `detect.packagePatterns`                    | `(string \| RegExp)[]` | No       | Package regex patterns. In JSON, use strings like `"^@my-org/"`.                   |
| `detect.configFiles`                        | `string[]`             | No       | File names that trigger detection.                                                 |
| `detect.configFileContent`                  | `object`               | No       | Content-based detection block.                                                     |
| `detect.configFileContent.patterns`         | `string[]`             | Yes\*    | Required if `configFileContent` is present.                                        |
| `detect.configFileContent.files`            | `string[]`             | No       | Files to inspect for `patterns`.                                                   |
| `detect.configFileContent.scanGradleLayout` | `boolean`              | No       | Enables Gradle layout scanning.                                                    |
| `skills`                                    | `string[]`             | Yes      | Skills to suggest/install for this technology.                                     |

\* Required when using `detect.configFileContent`.

### Example: local `.autoskillsrc.json`

```json
[
  {
    "id": "my-company-sdk",
    "name": "My Company SDK",
    "detect": {
      "packages": ["@my-company/sdk"],
      "configFiles": ["my-company.config.ts"]
    },
    "skills": ["my-company/agent-skills/sdk-best-practices"]
  },
  {
    "id": "react",
    "name": "React (Internal Standards)",
    "detect": {
      "packages": ["react", "react-dom"]
    },
    "skills": ["my-company/agent-skills/react-internal-standards"]
  }
]
```

### Example: global `autoskills.config.mjs` in a parent directory

```js
export default [
  {
    id: "acme-cloud",
    name: "Acme Cloud",
    detect: {
      packagePatterns: [/^@acme-cloud\//],
      configFiles: ["acme.config.json"],
    },
    skills: ["acme/agent-skills/cloud-platform"],
  },
];
```

### Merge behavior

- Matching is done by `id`
- Merge is **replace**, not deep-merge
- If `id: "react"` is defined in your config, your object replaces the built-in React object completely

### Error handling

If a config file is invalid (bad JSON, import error, validation error, permission issue), `autoskills`:

- logs a warning
- skips that config source
- continues detection with remaining valid sources

Use `--verbose` for richer CLI diagnostics when troubleshooting.

## Supported Technologies

`autoskills` detects **49+ technologies** from your `package.json`, lockfiles, Gradle files, and config files:

### Frameworks & Libraries

| Technology           | Detected from                                                                                                                                     |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| React                | `react`, `react-dom` packages                                                                                                                     |
| Next.js              | `next` package or `next.config.*`                                                                                                                 |
| Vue                  | `vue` package                                                                                                                                     |
| Nuxt                 | `nuxt` package or `nuxt.config.*`                                                                                                                 |
| Svelte               | `svelte`, `@sveltejs/kit` or `svelte.config.js`                                                                                                   |
| Angular              | `@angular/core` or `angular.json`                                                                                                                 |
| Astro                | `astro` package or `astro.config.*`                                                                                                               |
| Expo                 | `expo` package                                                                                                                                    |
| React Native         | `react-native` package                                                                                                                            |
| Kotlin Multiplatform | Gradle with KMP plugin: `kotlin("multiplatform")`, `org.jetbrains.kotlin.multiplatform`, or `kotlin-multiplatform` in `gradle/libs.versions.toml` |
| Android              | Gradle with `com.android.application`, `com.android.library`, or `com.android.kotlin.multiplatform.library`                                       |
| Remotion             | `remotion`, `@remotion/cli`                                                                                                                       |
| GSAP                 | `gsap` package                                                                                                                                    |
| Three.js             | `three`, `@react-three/fiber`, `@react-three/drei`                                                                                                |
| Express              | `express` package                                                                                                                                 |
| Hono                 | `hono` package                                                                                                                                    |
| NestJS               | `@nestjs/core` package                                                                                                                            |
| Spring Boot          | Gradle with `spring-boot-starter` or `org.springframework.boot`                                                                                   |

### Styling & UI

| Technology   | Detected from                                             |
| ------------ | --------------------------------------------------------- |
| Tailwind CSS | `tailwindcss`, `@tailwindcss/vite` or `tailwind.config.*` |
| shadcn/ui    | `components.json`                                         |

### Runtimes & Tooling

| Technology | Detected from                                                |
| ---------- | ------------------------------------------------------------ |
| TypeScript | `typescript` package or `tsconfig.json`                      |
| Node.js    | `package-lock.json`, `yarn.lock`, `pnpm-lock.yaml`, `.nvmrc` |
| Bun        | `bun.lockb`, `bun.lock`, `bunfig.toml`                       |
| Deno       | `deno.json`, `deno.jsonc`, `deno.lock`                       |
| Vite       | `vite` package or `vite.config.*`                            |
| Turborepo  | `turbo` package or `turbo.json`                              |
| Vitest     | `vitest` package or `vitest.config.*`                        |
| oxlint     | `oxlint` package or `.oxlintrc.json`                         |

### Backend & Data

| Technology    | Detected from                                            |
| ------------- | -------------------------------------------------------- |
| Supabase      | `@supabase/supabase-js`, `@supabase/ssr`                 |
| Neon Postgres | `@neondatabase/serverless`                               |
| Prisma        | `prisma`, `@prisma/client`                               |
| Drizzle ORM   | `drizzle-orm`, `drizzle-kit`                             |
| Stripe        | `stripe`, `@stripe/stripe-js`, `@stripe/react-stripe-js` |
| Better Auth   | `better-auth` package                                    |

### Authentication

| Technology | Detected from                                                                                                         |
| ---------- | --------------------------------------------------------------------------------------------------------------------- |
| Clerk      | `@clerk/nextjs`, `@clerk/react`, `@clerk/expo`, `@clerk/astro`, `@clerk/remix`, `@clerk/vue`, or any `@clerk/*` scope |

### Cloud & Deploy

| Technology        | Detected from                                        |
| ----------------- | ---------------------------------------------------- |
| Vercel            | `vercel.json`, `.vercel/`, `@astrojs/vercel`         |
| Cloudflare        | `wrangler`, `wrangler.toml`, `@astrojs/cloudflare`   |
| Cloudflare Agents | `agents` package                                     |
| Cloudflare AI     | `@cloudflare/ai` or AI binding in `wrangler.json`    |
| Durable Objects   | `durable_objects` in `wrangler.json`/`wrangler.toml` |
| Azure             | `@azure/*` packages                                  |
| AWS               | `@aws-sdk/*`, `aws-cdk*` packages                    |

### AI

| Technology    | Detected from                                                 |
| ------------- | ------------------------------------------------------------- |
| Vercel AI SDK | `ai`, `@ai-sdk/openai`, `@ai-sdk/anthropic`, `@ai-sdk/google` |
| ElevenLabs    | `elevenlabs` package                                          |

### Other

| Technology | Detected from                                                                       |
| ---------- | ----------------------------------------------------------------------------------- |
| Playwright | `@playwright/test`, `playwright` or `playwright.config.*`                           |
| SwiftUI    | `Package.swift`                                                                     |
| WordPress  | `wp-config.php`, `@wordpress/*`, `composer.json` with wpackagist, theme `style.css` |
| Tauri      | `@tauri-apps/api`, `@tauri-apps/cli` or `src-tauri/tauri.conf.json`                 |

### Web Frontend Detection

Even without a framework, `autoskills` scans your file tree for web frontend signals (`.html`, `.css`, `.scss`, `.vue`, `.svelte`, `.jsx`, `.tsx`, `.twig`, `.blade.php`, etc.) and installs skills for frontend design, accessibility, and SEO.

## Combo Detection

When multiple technologies are used together, `autoskills` detects **technology combos** and adds specialized skills for the combination:

- **Next.js + Supabase** — Supabase Postgres best practices for Next.js
- **Next.js + Vercel AI SDK** — AI SDK patterns with Next.js
- **Next.js + Playwright** — E2E testing best practices for Next.js
- **React + shadcn/ui** — shadcn component patterns with React
- **Tailwind CSS + shadcn/ui** — Tailwind v4 + shadcn integration
- **Expo + Tailwind CSS** — Tailwind setup for Expo
- **React Native + Expo** — Native UI patterns
- **GSAP + React** — GSAP animation patterns in React
- **Cloudflare + Vite** — Vinext migration guide
- **Node.js + Express** — Express server patterns

## How It Works

`autoskills` uses [skills.sh](https://skills.sh) under the hood — the open skill registry for AI coding agents. Skills are markdown files that teach AI assistants how to work with specific technologies, following best practices and patterns from the official maintainers.

The detection runs entirely locally with zero network requests until installation begins.

## Requirements

- Node.js >= 22.0.0

## License

CC-BY-NC-4.0 — Created by [@midudev](https://github.com/midudev)
