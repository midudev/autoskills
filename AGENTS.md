# AGENTS

<!-- fendo:start -->

## Supply Chain Security

This project has been hardened against supply chain attacks using [fendo](https://github.com/midudev/fendo).

### Rules for AI assistants and contributors

- **Never use `^` or `~`** in dependency version specifiers. Always pin exact versions.
- **Always commit the lockfile** (`pnpm-lock.yaml`). Never delete it or add it to `.gitignore`.
- **Install scripts are disabled**. If a new dependency requires a build step, it must be explicitly approved.
- **New package versions must be at least 1 day old** before they can be installed (release age gating is enabled).
- When adding a dependency, verify it on [npmjs.com](https://www.npmjs.com) before installing.
- Prefer well-maintained packages with verified publishers and provenance.
- Run `pnpm install` with the lockfile present — never bypass it.
- Do not add git-based or tarball URL dependencies unless explicitly approved.
- **Do not run `npm update`**, `npx npm-check-updates`, or any blind upgrade command. Review each update individually.
- **Use deterministic installs**: prefer `pnpm install --frozen-lockfile` over `pnpm install` in CI and scripts.
<!-- fendo:end -->

## Testing

- Tests use Node.js built-in test runner (`node:test`) and `node:assert/strict`.
- **Always destructure** the specific assert functions you need instead of importing the default `assert` object. Use `ok(...)` instead of `assert.ok(...)`, `strictEqual(...)` instead of `assert.strictEqual(...)`, etc.

```js
// ✅ Correct
import { ok, strictEqual, deepStrictEqual } from "node:assert/strict";

ok(value);
strictEqual(a, b);

// ❌ Wrong
import assert from "node:assert/strict";

assert.ok(value);
assert.strictEqual(a, b);
```

- Use the shared helpers from `tests/helpers.mjs` (`useTmpDir`, `writePackageJson`, `writeJson`, `writeFile`, `addWorkspace`) to avoid duplicating filesystem setup logic in tests.

## Output helpers

- **Never use `console.log` or `process.stdout.write` directly** in the CLI package (`packages/autoskills`). Use the `log` and `write` helpers exported from `colors.mjs` instead.

```js
// ✅ Correct
import { log, write } from "./colors.mjs";

log("hello");
write("raw output\n");

// ❌ Wrong
console.log("hello");
process.stdout.write("raw output\n");
```
