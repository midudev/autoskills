# autoskills — Skill Selection Guide

You are helping a user select skills for their project using autoskills.

## What is autoskills

autoskills is a CLI that installs curated AI skills (markdown instruction
bundles) for agents like Claude Code, Cursor, Cline, Codex.

You interact with autoskills via:
- `autoskills list --json`         — full catalog
- `autoskills install --only <ids>` — install specific skills
- `autoskills --dry-run --json`    — structural detection baseline

## Workflow

1. Read the user's spec or project context.
2. Run `autoskills list --json` to get the catalog.
3. Optionally run `autoskills --dry-run --json` to see what structural detection finds.
4. Match user's needs to technologies in the catalog.
5. Propose a list to the user with reasoning per skill.
6. After confirmation, run `autoskills install --only <ids>`.

## Categories (infer, not hardcoded)

- **Frontend** — UI, styling, a11y, SEO → React, Vue, Svelte, Astro, Next, Tailwind plus generalist (frontend-design, accessibility, seo).
- **Backend** — APIs, databases, auth → Express, Fastify, Hono, NestJS, Spring, ASP.NET, Rails, Prisma.
- **Mobile** — native / cross-platform → Expo, React Native, Flutter, SwiftUI.
- **DevOps / Cloud** — deploy, IaC, edge → Vercel, Cloudflare, AWS, Terraform.

## Rules

- Do not suggest skills for techs not mentioned or inferred.
- Prefer combos when both required techs are present.
- Include frontend_bonus when the project is clearly frontend.
- Match by aliases ("Next.js" → tech id `nextjs`).
- Ambiguous? Ask the user before installing.
- Always list your reasoning before proposing an install.

## Matching hints

- Prose counts: "built with React" → react.
- Negations matter: "don't want jQuery" → skip jQuery.
- Synonyms: "edge functions" → Cloudflare Workers or Vercel.
- Stack shorthands: "MERN" → mongo + express + react + node.
