<div align="center">

<a href="https://autoskills.sh">
<img src="https://autoskills.sh/og.jpg" alt="autoskills" />
</a>

# autoskills

**One command. Your entire AI skill stack. Installed.**

[autoskills.sh](https://autoskills.sh)

</div>

Scans your project, detects your tech stack, and installs curated AI agent skills automatically.

```bash
npx autoskills
```

## How it works

1. Run `npx autoskills` in your project root
2. Your `package.json`, Gradle files, and config files are scanned to detect technologies
3. The best matching AI agent skills are selected from the audited autoskills registry
4. Only the selected skill files are downloaded from the registry and verified before writing them locally

That's it. No config needed.

## Security model

`autoskills` does not install directly from random upstream repositories at runtime.

Skills are synced by maintainers into the repository-local autoskills registry, scanned for prompt-injection and supply-chain risks, and recorded with SHA-256 hashes in a manifest. When you run `autoskills`, the CLI downloads only the skills your project needs from that curated registry, verifies every file against the manifest, and writes a `skills-lock.json` entry with the installed source and bundle hash.

This keeps the package small while avoiding live downloads from third-party skill sources during installation.

## Options

```
-y, --yes             Skip confirmation prompt
--dry-run             Show what would be installed without installing
--json                Emit structured JSON (with --dry-run or subcommands)
--from-spec <path>    Detect tech from a markdown spec file (any extension)
--scan-docs           Auto-scan CLAUDE.md / AGENTS.md / README.md in the project
--show-specgen-prompt Print the shipped spec-generator prompt to stdout
--copy-specgen-prompt Copy the shipped spec-generator prompt to the OS clipboard
-h, --help            Show help message
```

> `--from-spec` and `--scan-docs` parse **code fences** (`json`, `bash`/`sh`/`shell`/`zsh`, `yaml`/`yml`/`toml`, `ruby`/`gemfile`) plus content under **stack headings** (`## Tech Stack`, `## Stack`, `## Dependencies`, `## Built With`, `## Technologies`). Under a heading we accept dash/numbered bullets, GFM tables, and comma-separated inline lists. Decorated headings (`## 2. Tech Stack`, `## 🚀 Stack`, `## **Dependencies**`) are recognized. Markdown tables outside a stack heading are ignored. See [Markdown scanner](./packages/autoskills/README.md#markdown-scanner-opt-in) for details.

## LLM-driven mode

Beyond structural detection, `autoskills` exposes atomic subcommands so an external LLM CLI (Claude Code, Cursor, Codex) can reason over your requirement and produce a parseable spec:

```bash
npx autoskills list --json             # full catalog
npx autoskills --show-specgen-prompt   # spec-generator prompt to stdout
npx autoskills --copy-specgen-prompt   # spec-generator prompt to clipboard
```

**Spec-doc flow:** run `--copy-specgen-prompt` (or `--show-specgen-prompt`), paste it under your requirement in any LLM chat, and the LLM writes `docs/specs-initial.md` for you to feed back via `autoskills --from-spec`.

What you actually type in the LLM chat — describe the project, not the stack. The LLM picks the techs.

If your chat has a `bash` tool (Claude Code, Cursor, Codex), one message is enough:

```text
I'm building an internal task manager for a small remote team.
Users sign in, create tasks, assign them to teammates, and see live
updates when someone changes status. Web + mobile-friendly, free-tier
deploy, end-to-end typed.

Run `autoskills --show-specgen-prompt` and follow the instructions it prints.
```

In any chat (no tools required), paste the prompt under your requirement:

```text
I'm building an internal task manager for a small remote team.
Users sign in, create tasks, assign them to teammates, and see live
updates when someone changes status. We want it on the web and
mobile-friendly. Need to ship a working demo this week, deploy
on a free tier, and keep the codebase typed end-to-end.

<paste the output of `autoskills --copy-specgen-prompt` here>
```

See the [package README](./packages/autoskills/README.md#subcommands-for-llm-integration) for the full workflow.

## Supported Technologies

Built to work across modern frontend, backend, mobile, cloud, and media stacks.

- **Frameworks & UI:** React, Next.js, Vue, Nuxt, Svelte, Angular, Astro, Tailwind CSS, shadcn/ui, GSAP, Three.js
- **Languages & Runtimes:** TypeScript, Node.js, Go, Bun, Deno, Dart
- **Backend & APIs:** Express, Hono, NestJS, Spring Boot
- **Mobile & Desktop:** Expo, React Native, Flutter, SwiftUI, Android, Kotlin Multiplatform, Tauri, Electron
- **Data & Storage:** Supabase, Neon, Prisma, Drizzle ORM, Zod, React Hook Form
- **Auth & Billing:** Better Auth, Clerk, Stripe
- **Testing:** Vitest, Playwright
- **Cloud & Infrastructure:** Vercel, Vercel AI SDK, Cloudflare, Durable Objects, Cloudflare Agents, Cloudflare AI, AWS, Azure, Terraform
- **Tooling:** Turborepo, Vite, oxlint
- **Media & AI:** Remotion, ElevenLabs

## Requirements

Node.js >= 22

## License

[CC BY-NC 4.0](./LICENSE) — [midudev](https://midu.dev)
