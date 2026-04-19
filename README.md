<div align="center">

<a href="https://autoskills.sh">
<img src="https://autoskills.sh/og.jpg" alt="autoskills" />
</a>

# autoskills

**One command. Your entire AI skill stack. Installed.**

[autoskills.sh](https://autoskills.sh)

</div>

Scans your project, detects your tech stack, and installs the best AI agent skills from [skills.sh](https://skills.sh) automatically.

```bash
npx autoskills
```

## How it works

1. Run `npx autoskills` in your project root
2. Your `package.json`, Gradle files, and config files are scanned to detect technologies
3. The best matching AI agent skills are installed via [skills.sh](https://skills.sh)
4. If Claude Code is targeted, a `CLAUDE.md` summary is generated from the installed markdown files in `.claude/skills`

That's it. No config needed.

## Claude Code summary

If `claude-code` is auto-detected or passed with `-a`, `autoskills` also writes a `CLAUDE.md` file in your project root with a quick summary of the markdown files installed for Claude Code.

## Options

```
-y, --yes       Skip confirmation prompt
--dry-run       Show what would be installed without installing
-h, --help      Show help message
```

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
