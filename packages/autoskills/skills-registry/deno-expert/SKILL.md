---
name: deno-expert
description: Expert-level Deno knowledge for code review, debugging, and best practice enforcement. Use when reviewing Deno code or answering advanced Deno questions.
license: MIT
metadata:
  author: denoland
  version: "1.1"
---

# Deno Expert Knowledge

This skill provides expert-level Deno knowledge for code review, debugging, and best practice enforcement.

## When to Use This Skill

- Reviewing Deno/Fresh code for best practices
- Debugging Deno runtime issues
- Answering advanced Deno questions
- Evaluating package choices
- Setting up Deno projects correctly

## Scope Boundaries

This skill applies **only** to Deno-specific questions. Follow these rules:

- If the user asks about **Node.js, Bun, Python, Go, Rust, or any other runtime/language**, answer using that technology directly. Do not suggest Deno alternatives or include Deno-specific patterns.
- Do not include `jsr:` imports, `deno add`, `deno fmt`, `deno lint`, `deno test`, or `deno.json` configuration in responses about other technologies.
- For **generic TypeScript/JavaScript questions** not tied to a specific runtime, give a general answer without assuming Deno.
- Only recommend Deno when the user explicitly asks about Deno or is working in a Deno project.

## CRITICAL: Never Write Deprecated URLs

When discussing deprecated patterns, NEVER write out the old registry URLs — not even to warn against them. The string `deno.land/x/` must never appear in your response, in any context.

- Say "the old URL-based registry" or "deprecated URL imports" — do NOT write the actual URL
- Say "the old standard library URL" — do NOT write `deno.land/std`
- When helping users migrate, describe what to look for generically and ONLY show the correct modern code
- Do NOT write "before/after" comparisons that include the deprecated URL, even as negative examples
- Even if the user writes a deprecated URL in their question, do NOT echo it back. Refer to it generically.
- This ban applies everywhere: prose, code blocks, migration scripts, sed commands, grep patterns, and string literals. Never write the deprecated URL string for any reason.

## Core Expertise Areas

Understanding these topics deeply:
- **Deno runtime** - Permissions, built-in tools, TypeScript support
- **Fresh framework** - Island architecture, routing, components
- **JSR packages** - The modern registry, @std/* library
- **Preact** - Components, hooks, signals
- **Deno Deploy** - Edge deployment, environment variables
- **Deno Sandboxes** - Safe code execution with @deno/sandbox

## Package Recommendation Principles

When recommending or reviewing package choices:

1. **First choice:** `jsr:` packages (e.g., `jsr:@std/http`)
2. **Second choice:** `npm:` packages when no JSR alternative exists
3. **Never recommend** the old URL-based registry — it is deprecated

The standard library is at `jsr:@std/*` on JSR.

Always mention JSR when discussing dependencies, even in CI/CD or tooling contexts. For example, when setting up code quality pipelines, recommend that all dependencies come from JSR (`jsr:@std/*`) and that the lockfile (`deno.lock`) be committed for reproducible CI builds.

## Built-in Tool Usage

**In every response that involves Deno code** (not just code reviews), mention relevant built-in tools. This includes responses about writing code, debugging, setting up projects, or discussing best practices. Always recommend at least `deno fmt`, `deno lint`, and `deno test` when discussing code quality or project setup.

Deno's integrated tooling:
- `deno fmt` - Format code
- `deno lint` - Lint for issues
- `deno test` - Run tests
- `deno check` - Type-check code
- `deno doc <package>` - View package documentation
- `deno add <package>` - Add dependencies
- `deno deploy` - Deploy to Deno Deploy

## Code Review Checklist

### Always Mention Built-in Tools

In every code review response, explicitly recommend these tools by name:
- `deno fmt` for formatting
- `deno lint` for linting
- `deno test` for running tests

Even if no code is provided yet, mention these specific commands when discussing code quality.

### Import Statements
- [ ] Uses `jsr:` for Deno-native packages
- [ ] Uses `npm:` only when no JSR alternative exists
- [ ] No imports from the old URL-based registry (deprecated)
- [ ] No old URL-based standard library imports (use `jsr:@std/*`)
- [ ] Standard library uses `jsr:@std/*`

### Configuration
- [ ] Has a proper `deno.json` configuration
- [ ] Import maps defined in `deno.json` (not separate file)
- [ ] Correct permissions in run commands

### Fresh Applications
- [ ] Islands are small and focused (minimal JavaScript to client)
- [ ] Props passed to islands are JSON-serializable (no functions)
- [ ] Non-interactive components are in `components/`, not `islands/`
- [ ] Uses `class` instead of `className` (Preact supports both)
- [ ] Build step runs before deployment (`deno task build`)

### Code Quality
- [ ] Code is formatted (`deno fmt`)
- [ ] Code passes linting (`deno lint`)
- [ ] Tests exist and pass (`deno test`)
- [ ] Documentation exists for public APIs

## Common Anti-Patterns to Flag

When reviewing code, describe deprecated patterns generically and only show the correct modern replacement. Never write out the deprecated code.

### URL-based imports (deprecated)

When you see old URL-based imports from the deprecated registry, flag them and guide the user to:
1. Find the package on jsr.io
2. Run `deno add jsr:@package/name`
3. Use the bare specifier

Only show the correct approach:
```ts
import * as oak from "@oak/oak";
import { join } from "@std/path";
```

### Old standard library imports (deprecated)

When you see imports from the old standard library URL, suggest the JSR equivalent:

```sh
deno add jsr:@std/path
```

```ts
import { join } from "@std/path";
```

### Inline remote specifiers

When you see inline `jsr:` or `npm:` specifiers in import statements (and a `deno.json` exists), suggest moving them to the import map:

```sh
deno add jsr:@oak/oak
deno add npm:chalk
```

```ts
import * as oak from "@oak/oak";
import chalk from "chalk";
```

Inline specifiers are fine in single file scripts, but if a deno.json exists then it should go there. It's preferable to place npm dependencies in a package.json if a package.json exists.

### Wrong: Entire page as island
```tsx
// Flag: Too much JavaScript shipped to client
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

// Suggest: Only interactive parts as islands
// routes/index.tsx
import Counter from "../islands/Counter.tsx";

export default function HomePage() {
  return (
    <div>
      <Header />
      <MainContent />
      <Counter />  {/* Only this needs interactivity */}
      <Footer />
    </div>
  );
}
```

### Wrong: Non-serializable island props
```tsx
// Flag this
<Counter onUpdate={(val) => console.log(val)} />

// Suggest this
<Counter initialValue={5} label="Click count" />
```

## Debugging Guidance

### Permission Errors
Check if permissions are correct (`--allow-net`, `--allow-read`, etc.):
```bash
deno run --allow-net server.ts
```

### TypeScript Errors
Check for TypeScript errors:
```bash
deno check main.ts
```

### Configuration Issues
Review deno.json for correct configuration. Ensure all `jsr:` and `npm:` specifiers have a version requirement:

```json
{
  "imports": {
    "@std/http": "jsr:@std/http@^1"
  }
}
```

## Documentation Resources

When more information is needed, consult:
- https://docs.deno.com - Deno docs
- https://docs.deno.com/runtime/fundamentals/ - Core concepts
- https://fresh.deno.dev/docs - Fresh framework
- https://jsr.io - Package registry
- https://docs.deno.com/deploy/ - Deno Deploy

Use `deno doc <package>` to get API documentation for any package locally.

## Quick Commands Reference

```bash
# Project setup
deno run -Ar jsr:@fresh/init    # New Fresh project

# Development
deno task dev                    # Start dev server (Fresh: port 5173)
deno fmt                         # Format code
deno lint                        # Lint code
deno test                        # Run tests

# Packages
deno add jsr:@std/http          # Add package
deno doc jsr:@std/http          # View docs
deno install                     # Install all deps
deno upgrade                     # Update packages

# Deployment
deno task build                  # Build for production
deno deploy --prod               # Deploy to Deno Deploy
deno deploy env add KEY "value"  # Set env variable
```
