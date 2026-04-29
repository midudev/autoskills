---
name: oxlint
description: "Run and configure oxlint — the high-performance JavaScript/TypeScript linter built on the Oxc compiler stack. Use this skill whenever working in a project that has oxlint installed (check for `oxlint` in package.json devDependencies or an `.oxlintrc.json` / `oxlint.config.ts` config file). This includes when you need to lint code after making changes, fix linting errors, configure oxlint rules/plugins, set up or modify `.oxlintrc.json`, or migrate from ESLint."
---

# Oxlint — High-Performance JS/TS Linter

Oxlint is 50-100x faster than ESLint. It ships with 690+ rules covering ESLint core, TypeScript, React, Jest, Unicorn, jsx-a11y, and more. It prioritizes high-signal correctness checks by default — things that are incorrect, unsafe, or useless — so teams can adopt it without drowning in false positives.

## Detection

Before linting, confirm the project uses oxlint by checking for any of:
- `oxlint` in `package.json` devDependencies/dependencies
- An `.oxlintrc.json` file in the project root
- An `oxlint.config.ts` file in the project root
- An `oxlint` or `lint` script in `package.json` that references `oxlint`

If none of these exist, the project doesn't use oxlint — don't run it.

## Running Oxlint

### After code changes
Run oxlint to check your work. Prefer the project's npm script if one exists:

```bash
# If package.json has a lint script using oxlint
npm run lint

# Otherwise, run directly
npx oxlint
```

### Fixing issues automatically
```bash
npx oxlint --fix
```

Use `--fix` for safe automatic fixes. Avoid `--fix-dangerously` unless the user explicitly asks for it — it can apply unsafe transformations.

### Linting specific files
After editing only a few files, you can lint just those:
```bash
npx oxlint src/components/Button.tsx src/utils/helpers.ts
```

### Interpreting output
Oxlint prints diagnostics with rule names in parentheses, e.g. `(no-unused-vars)`. When fixing:
1. Read the diagnostic message carefully — oxlint gives precise, actionable information
2. Fix the underlying code issue rather than suppressing the rule
3. Only add `// oxlint-ignore` comments as a last resort when the diagnostic is a genuine false positive

### Output formats
For CI or tooling integration:
```bash
npx oxlint --format json        # Machine-readable JSON
npx oxlint --format github      # GitHub Actions annotations
npx oxlint --format unix        # Simple one-line-per-error format
```

## Configuration

### Creating a config
```bash
npx oxlint --init
```
This generates an `.oxlintrc.json` starter config.

### Config file format (.oxlintrc.json)
The config uses JSONC (JSON with comments). Key sections:

```jsonc
{
  // Enable/disable individual rules with severity levels
  "rules": {
    "no-unused-vars": "error",
    "no-console": "warn",
    "no-plusplus": ["error", { "allowForLoopAfterthoughts": true }]
  },

  // Enable groups of related rules by category
  "categories": {
    "correctness": "error",   // Definitely-wrong code
    "suspicious": "warn",     // Probably-wrong code
    "pedantic": "off",        // Opinionated style checks
    "perf": "warn",           // Performance anti-patterns
    "style": "off",           // Cosmetic preferences
    "restriction": "off",     // Extra-strict rules (opt-in)
    "nursery": "off"          // Unstable/experimental rules
  },

  // Plugins to enable (setting this overwrites defaults, so list all you want)
  "plugins": ["typescript", "unicorn", "oxc"],

  // File-specific overrides
  "overrides": [
    {
      "files": ["**/*.test.{ts,tsx}"],
      "rules": { "no-console": "off" }
    },
    {
      "files": ["scripts/**"],
      "rules": { "no-console": "off" }
    }
  ],

  // Environment globals
  "env": {
    "browser": true,
    "node": true
  },

  // Plugin-wide settings
  "settings": {
    "react": {
      "linkComponents": [{ "name": "Link", "linkAttribute": "to" }]
    },
    "jsx-a11y": {
      "components": { "Link": "a", "Button": "button" }
    }
  },

  // Type-aware linting (requires tsconfig)
  "options": {
    "typeAware": true
  }
}
```

### Rule severity levels
- `"off"` / `"allow"` — Disable the rule
- `"warn"` — Report but don't fail the build
- `"error"` / `"deny"` — Report and exit non-zero

Unique rule names can omit plugin prefix: `"no-console"` = `"eslint/no-console"`.

### Categories
Categories group rules by intent. The recommended starting point:
- `correctness: "error"` — Always on. Catches real bugs.
- `suspicious: "warn"` — Good signal, occasionally noisy.
- Everything else: enable incrementally as the team is ready.

### Available plugins
**Enabled by default:** `typescript`, `unicorn`, `oxc`

**Opt-in (CLI flags or config):**
| Plugin | CLI flag | Purpose |
|--------|----------|---------|
| react | `--react-plugin` | React-specific rules |
| jsx-a11y | `--jsx-a11y-plugin` | Accessibility rules for JSX |
| nextjs | `--nextjs-plugin` | Next.js best practices |
| import | `--import-plugin` | Import/export validation |
| jest | `--jest-plugin` | Jest testing rules |
| vitest | `--vitest-plugin` | Vitest testing rules |
| jsdoc | `--jsdoc-plugin` | JSDoc documentation rules |
| node | `--node-plugin` | Node.js-specific rules |
| promise | `--promise-plugin` | Promise best practices |
| react-perf | `--react-perf-plugin` | React performance rules |
| vue | `--vue-plugin` | Vue.js rules |

To disable a default plugin: `--disable-typescript-plugin`, `--disable-unicorn-plugin`, `--disable-oxc-plugin`.

### Extending shared configs
```jsonc
{
  "extends": ["./configs/base.json", "./configs/frontend.json"]
}
```
Later entries override earlier ones. Paths resolve relative to the declaring config.

### Monorepo support
Oxlint supports nested configs. Each directory can have its own `.oxlintrc.json` that overrides parent settings. Disable with `--disable-nested-config` if unwanted.

## CLI Quick Reference

| Flag | What it does |
|------|-------------|
| `-c, --config=PATH` | Use a specific config file |
| `--tsconfig=PATH` | TypeScript config for path aliases |
| `--fix` | Auto-fix safe issues |
| `--fix-suggestions` | Also apply suggested fixes |
| `-A, --allow=RULE` | Suppress a rule (e.g., `-A no-console`) |
| `-W, --warn=RULE` | Warn on a rule |
| `-D, --deny=RULE` | Error on a rule |
| `--quiet` | Suppress warnings, show only errors |
| `--deny-warnings` | Treat warnings as errors (exit non-zero) |
| `--max-warnings=N` | Fail if more than N warnings |
| `-f, --format=FMT` | Output format: default, json, github, unix, etc. |
| `--ignore-pattern=PAT` | Exclude files matching pattern |
| `--type-aware` | Enable type-informed rules (needs tsconfig) |
| `--print-config` | Show resolved config (useful for debugging) |
| `--rules` | List all available rules |

Categories can also be used with `-A`/`-W`/`-D`:
```bash
npx oxlint -D correctness -W suspicious -A pedantic
```

## Suppressing rules inline

```js
// oxlint-ignore no-console -- needed for debug logging
console.log(debugInfo);

// oxlint-ignore-next-line no-unused-vars
const _placeholder = computeValue();
```

Use `oxlint-ignore` (not `eslint-disable`) — oxlint recognizes both, but prefer its native syntax.

## Migrating from ESLint

If the project is moving from ESLint to oxlint:

1. **Side-by-side approach** — Run both linters, with `eslint-plugin-oxlint` disabling rules that oxlint already covers:
   ```bash
   npm install -D eslint-plugin-oxlint
   ```
   Add it as the last plugin in your ESLint config.

2. **Full replacement** — Use `@oxlint/migrate` to convert your ESLint config:
   ```bash
   npx @oxlint/migrate
   ```
   This generates an `.oxlintrc.json` from your existing ESLint configuration.

## Supported file types

`.js`, `.mjs`, `.cjs`, `.ts`, `.mts`, `.cts`, `.jsx`, `.tsx`, `.vue`, `.svelte`, `.astro`

For `.vue`, `.svelte`, and `.astro` files, oxlint lints only the `<script>` blocks.
