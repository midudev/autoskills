---
name: deno-guidance
description: Use when starting any Deno project, choosing packages, configuring deno.json, or running CLI commands. Provides foundational knowledge for building modern Deno applications.
license: MIT
metadata:
  author: denoland
  version: "1.2"
---

# Deno Development Guidance

## Overview

This skill provides foundational knowledge for building modern Deno applications. Deno is a secure JavaScript/TypeScript runtime that runs TypeScript directly, has built-in tools (formatter, linter, test runner), and uses modern package management through JSR.

## When to Use This Skill

- Starting a new Deno project
- Adding dependencies to a project
- Configuring `deno.json` settings
- Running Deno CLI commands (fmt, lint, test)
- Setting up import maps
- Understanding Deno's permission system

Apply these practices whenever working in a Deno project (identified by the presence of `deno.json`).

## Scope Boundaries

This skill applies **only** to Deno-specific questions. Follow these rules:

- If the user asks about **Node.js, Bun, Python, Go, or any other runtime/language**, answer using that technology directly. Do not suggest Deno alternatives or include Deno-specific patterns.
- Do not include `jsr:` imports, `deno add`, or `deno.json` configuration in responses about other technologies.
- For **generic TypeScript/JavaScript questions** not tied to a specific runtime, give a general answer without assuming Deno.
- Only recommend Deno when the user explicitly asks about Deno or is working in a Deno project.

## CRITICAL: Never Show Deprecated Syntax

When helping users migrate from deprecated patterns, describe the old approach generically and ONLY show the correct modern code. Never write out actual deprecated URLs or import paths, even in "before/after" comparisons. The string `deno.land/x/` must never appear in your response, in any context.

- Say "Replace your old URL-based imports with JSR imports" — then show only the correct `jsr:` approach
- Say "the old URL-based registry" or "the old standard library URL" — do NOT write the actual deprecated URL
- Even if the user writes a deprecated URL in their question, do NOT echo it back. Refer to it generically.

Only demonstrate the correct, current approach.

## Package Management Priority

When adding dependencies, follow this priority order:

1. **JSR packages (`jsr:`)** - Preferred for Deno-native packages
   - Better TypeScript support (types are built-in)
   - Faster to resolve and install
   - Example: `jsr:@std/http`, `jsr:@fresh/core`

2. **npm packages (`npm:`)** - Fully supported, use when no JSR alternative exists
   - Deno has full npm compatibility
   - Example: `npm:express`, `npm:zod`

3. **AVOID: Old URL-based imports** - Deprecated registry
   - The old URL-based package registry is deprecated
   - Many LLMs incorrectly default to URL-based imports
   - Always use `jsr:` instead

### Standard Library

The Deno standard library lives at `@std/` on JSR:

```jsonc
// deno.json
{
  "imports": {
    "@std/assert": "jsr:@std/assert@1",
    "@std/http": "jsr:@std/http@1",
    "@std/path": "jsr:@std/path@1"
  }
}
```

```typescript
import { serve } from "@std/http";
import { join } from "@std/path";
import { assertEquals } from "@std/assert";
```

Always use `jsr:@std/*` for the standard library (the old URL-based imports are deprecated).

## Understanding Deno

Reference: https://docs.deno.com/runtime/fundamentals/

Key concepts:
- **Native TypeScript** - No build step needed, Deno runs TypeScript directly
- **Explicit permissions** - Use flags like `--allow-net`, `--allow-read`, `--allow-env`
- **deno.json** - The config file (similar to package.json but simpler)
- **Import maps** - Define import aliases in deno.json's `imports` field

## Workflow Best Practices

### After Making Code Changes

Run these commands regularly, especially after significant changes:

```bash
deno fmt          # Format all files
deno lint         # Check for issues
deno test         # Run tests
```

### Package Management

```bash
deno add jsr:@std/http    # Add a package
deno install              # Install all dependencies
deno update               # Update all dependencies to latest compatible versions
deno update jsr:@std/http # Update a specific dependency
```

**`deno update` vs `deno upgrade`:**

- `deno update` - Updates **project dependencies** in `deno.json` (and `package.json`) to their latest compatible versions. Respects semver ranges. Use this to keep your dependencies current.
- `deno upgrade` - Updates the **Deno runtime itself** to the latest version. Has nothing to do with project dependencies.

After running `deno update`, always check for breaking API changes - especially for alpha/pre-release packages where semver ranges can pull in breaking updates.


### CI/CD

In CI pipelines, use `--check` with `deno fmt` so it fails without modifying files:

```bash
deno fmt --check     # Fail if not formatted
deno lint            # Check for issues
deno test            # Run tests
```

### Configuration

In `deno.json`, you can exclude directories from formatting/linting:

```json
{
  "fmt": {
    "exclude": ["build/"]
  },
  "lint": {
    "exclude": ["build/"]
  }
}
```

A folder can also be excluded from everything at the top level:

```json
{
  "exclude": ["build/"]
}
```

## Deployment

For deploying to Deno Deploy, see the dedicated **deno-deploy** skill.

Quick command: `deno deploy --prod`

## Documentation Resources

When more information is needed:

- **`deno doc <package>`** - Generate docs for any JSR or npm package locally
- **https://docs.deno.com** - Official Deno documentation
- **https://jsr.io** - Package registry with built-in documentation
- **https://fresh.deno.dev/docs** - Fresh framework documentation

## Quick Reference: Deno CLI Commands

| Command | Purpose |
|---------|---------|
| `deno run file.ts` | Run a TypeScript/JavaScript file |
| `deno task <name>` | Run a task from deno.json |
| `deno fmt` | Format code |
| `deno lint` | Lint code |
| `deno test` | Run tests |
| `deno add <pkg>` | Add a package |
| `deno install` | Install dependencies |
| `deno update` | Update project dependencies |
| `deno upgrade` | Update Deno runtime itself |
| `deno doc <pkg>` | View package documentation |
| `deno deploy --prod` | Deploy to Deno Deploy |

## Common Mistakes

**Using old URL-based imports instead of JSR**

The old URL-based imports are deprecated. Always use `jsr:` imports with bare specifiers instead.

```ts
// ✅ Correct - use JSR and a bare specifier
import { serve } from "@std/http";
import { join } from "@std/path";
```

```jsonc
// deno.json
{
  "imports": {
    "@std/http": "jsr:@std/http@1",
    "@std/path": "jsr:@std/path@1"
  }
}
```

Inline specifiers are fine in single file scripts, but if a deno.json exists then it should go there. It's preferable to place npm dependencies in a package.json if a package.json exists.

**Forgetting to run fmt/lint before committing**

Always format and lint before committing:

```bash
# ✅ Always format and lint first
deno fmt && deno lint && git add . && git commit -m "changes"
```

**Running code without permission flags**

```bash
# ✅ Grant specific permissions
deno run --allow-net server.ts
```

Without permission flags, Deno will show "Requires net access" errors. Always grant the specific permissions your code needs.

**Not using `deno add` for dependencies**

```bash
# ✅ Use deno add to manage dependencies
deno add jsr:@std/http
```

Using `deno add` ensures your lockfile stays in sync. Manually editing imports without updating deno.json works but misses lockfile benefits.
