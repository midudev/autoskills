# Changelog

## [0.2.3](https://github.com/midudev/autoskills/releases/tag/v0.2.3) (2026-04-04)

### ✨ Features

- refactor: add test helpers and reduce duplication across test files `[fdbb7af](https://github.com/midudev/autoskills/commit/fdbb7af)`
- feat: add Three.js and @react-three/fiber. `[6d5ac16](https://github.com/midudev/autoskills/commit/6d5ac16)`
- feat: add support for deno.json and deno.jsonc in workspace resolution and technology detection `[7d92dd1](https://github.com/midudev/autoskills/commit/7d92dd1)`
- docs: add Clerk and Spring Boot to supported technologies `[d5998e0](https://github.com/midudev/autoskills/commit/d5998e0)`
- feat: add Kiro agent support `[d5016c5](https://github.com/midudev/autoskills/commit/d5016c5)`
- feat: add clerk router skill to nextjs-clerk combo `[bec0f69](https://github.com/midudev/autoskills/commit/bec0f69)`
- feat: add Clerk authentication detection and skills `[abfd4e5](https://github.com/midudev/autoskills/commit/abfd4e5)`

### 🐛 Bug Fixes

- style: fix oxfmt formatting `[4566573](https://github.com/midudev/autoskills/commit/4566573)`

### 📦 Other Changes

- refactor: use if-return instead of switch in bumpVersion `[4ffb3d0](https://github.com/midudev/autoskills/commit/4ffb3d0)`
- refactor: extract log/write aliases to replace console.log and process.stdout.write `[3a8961f](https://github.com/midudev/autoskills/commit/3a8961f)`
- Merge pull request #30 from pedrocastellanos/feat-add-threejs-react-three `[9aa3b4d](https://github.com/midudev/autoskills/commit/9aa3b4d)`
- Merge pull request #32 from John7bigo/feat/read-deno-json `[980e8f1](https://github.com/midudev/autoskills/commit/980e8f1)`
- Merge pull request #27 from Railly/feat/add-icons-and-docs `[4f4e61d](https://github.com/midudev/autoskills/commit/4f4e61d)`
- chore: lint and format before release `[e63bada](https://github.com/midudev/autoskills/commit/e63bada)`

## [0.2.2](https://github.com/midudev/autoskills/releases/tag/v0.2.2) (2026-04-01)

### ✨ Features

- feat: simplificar la salida de detección de Cloudflare en pruebas de CLI `[cf190bd](https://github.com/midudev/autoskills/commit/cf190bd)`
- feat: mejorar la visualización en multiSelect al agregar separación entre grupos `[b11997d](https://github.com/midudev/autoskills/commit/b11997d)`
- feat: actualizar iconos en la salida de CLI para mejorar la legibilidad `[0c25238](https://github.com/midudev/autoskills/commit/0c25238)`
- feat: mejorar la visualización de etiquetas de habilidades en la salida de CLI `[41b0d48](https://github.com/midudev/autoskills/commit/41b0d48)`
- feat: implementar rollback en caso de fallos durante el proceso de release `[013702f](https://github.com/midudev/autoskills/commit/013702f)`

## [0.2.1](https://github.com/midudev/autoskills/releases/tag/v0.2.1) (2026-04-01)

### ✨ Features

- feat: auto-detect installed agents when no -a flag is provided `[0b6c88c](https://github.com/midudev/autoskills/commit/0b6c88c)`
- feat: add Prisma, Stripe, Hono, Vitest, Drizzle, NestJS and Tauri to skills map `[ba11178](https://github.com/midudev/autoskills/commit/ba11178)`
- Add Svelte skills to skills-map `[a212de1](https://github.com/midudev/autoskills/commit/a212de1)`
- feat: update SKILLS_MAP to include new Angular skills `[d33c8db](https://github.com/midudev/autoskills/commit/d33c8db)`

### 📦 Other Changes

- Refactor transition properties in global.css for improved readability `[f1836fa](https://github.com/midudev/autoskills/commit/f1836fa)`
- Merge pull request #15 from vgpastor/feat/auto-detect-agents `[4ad60cc](https://github.com/midudev/autoskills/commit/4ad60cc)`
- Merge pull request #13 from PMFrancisco/feat/add-js-ecosystem-skills `[62a2879](https://github.com/midudev/autoskills/commit/62a2879)`

## [0.2.0](https://github.com/midudev/autoskills/releases/tag/v0.2.0) (2026-03-31)

### ✨ Features

- feat: add Java/Spring Boot detection and extract skills map to dedicated file `[90bd791](https://github.com/midudev/autoskills/commit/90bd791)`
- feat: add monorepo workspace detection support `[85e14cd](https://github.com/midudev/autoskills/commit/85e14cd)`
- feat(autoskills): detect Kotlin Multiplatform and Android via Gradle `[4efd5c9](https://github.com/midudev/autoskills/commit/4efd5c9)`
- Update autoskills package to version 0.1.6 and add release script `[92216ec](https://github.com/midudev/autoskills/commit/92216ec)`
- Add CHANGELOG.md for autoskills package `[03127c4](https://github.com/midudev/autoskills/commit/03127c4)`

### 🐛 Bug Fixes

- fix: hide combo source labels from skill list display `[138a895](https://github.com/midudev/autoskills/commit/138a895)`
- fix: Windows installer by making the npx spawn options platform-aware. `[b661b88](https://github.com/midudev/autoskills/commit/b661b88)`

### 📦 Other Changes

- Enhance release script documentation with JSDoc comments. Added detailed descriptions for changelog generation and update functions to improve clarity and maintainability. `[dbab11d](https://github.com/midudev/autoskills/commit/dbab11d)`
- Enhance documentation with JSDoc comments across multiple files. Added detailed descriptions for functions in index.mjs, installer.mjs, lib.mjs, ui.mjs, and release.mjs to improve code clarity and maintainability. `[595bfa0](https://github.com/midudev/autoskills/commit/595bfa0)`
- merge: resolve conflicts with main branch `[97c4cef](https://github.com/midudev/autoskills/commit/97c4cef)`
- merge: resolve conflicts with main branch `[9505993](https://github.com/midudev/autoskills/commit/9505993)`
- Merge pull request #10 from dieguedev/main `[31d4727](https://github.com/midudev/autoskills/commit/31d4727)`
- Merge pull request #6 from sebastiansandoval27/main `[70ca7fb](https://github.com/midudev/autoskills/commit/70ca7fb)`
- Merge pull request #3 from AlvaroMinarro/feat/kmp-android-detection `[2381250](https://github.com/midudev/autoskills/commit/2381250)`
- refactor(lib.mjs): Replace outdated tailwind-v4-shadcn SKILL `[d7e01a8](https://github.com/midudev/autoskills/commit/d7e01a8)`
- Enhance agent installation support in autoskills CLI `[0f90d9b](https://github.com/midudev/autoskills/commit/0f90d9b)`

## [0.1.6](https://github.com/midudev/autoskills/releases/tag/v0.1.6) (2026-03-30)

### 🐛 Bug Fixes

- Fix Windows npx spawn in installer `[ec48abb](https://github.com/midudev/autoskills/commit/ec48abb)`

## [0.1.5](https://github.com/midudev/autoskills/releases/tag/v0.1.5) (2026-03-30)

### 🐛 Bug Fixes

- Correct repository URL `[6f82a1a](https://github.com/midudev/autoskills/commit/6f82a1a)`

## [0.1.4](https://github.com/midudev/autoskills/releases/tag/v0.1.4) (2026-03-30)

### 📦 Other Changes

- Add README.md for autoskills package `[0471cfb](https://github.com/midudev/autoskills/commit/0471cfb)`

## [0.1.3](https://github.com/midudev/autoskills/releases/tag/v0.1.3) (2026-03-30)

### ✨ Features

- Add WordPress detection and enhance web frontend identification `[3804a8d](https://github.com/midudev/autoskills/commit/3804a8d)`
- Add Node.js and Express detection with backend skills `[f68da3c](https://github.com/midudev/autoskills/commit/f68da3c)`
- Add Deno detection with 6 skills `[393fc9e](https://github.com/midudev/autoskills/commit/393fc9e)`
- Add Bun detection and support for URL-based skills `[ae69f8c](https://github.com/midudev/autoskills/commit/ae69f8c)`
- Add GSAP, Pinia, Cloudflare smart detection and new skills `[0687302](https://github.com/midudev/autoskills/commit/0687302)`
- Add Pinia, Astro and oxlint skills support `[747bfc8](https://github.com/midudev/autoskills/commit/747bfc8)`
- Detect Vercel and Cloudflare from Astro adapters `[7d1be35](https://github.com/midudev/autoskills/commit/7d1be35)`
- Add gray color support to autoskills CLI `[a0b26ce](https://github.com/midudev/autoskills/commit/a0b26ce)`
- Add pink color support and sponsor message in CLI output `[6d21987](https://github.com/midudev/autoskills/commit/6d21987)`
- Enhance autoskills CLI with version display and improved technology listing `[506ad14](https://github.com/midudev/autoskills/commit/506ad14)`
- Enhance autoskills CLI with improved color handling and multi-select functionality `[b09044c](https://github.com/midudev/autoskills/commit/b09044c)`

### 📦 Other Changes

- Add LICENSE file and update project license to CC BY-NC 4.0 `[9301e31](https://github.com/midudev/autoskills/commit/9301e31)`
- Replace Tailwind skill with tailwind-css-patterns `[beffb9d](https://github.com/midudev/autoskills/commit/beffb9d)`
- Refactor CLI into modular files `[6a7c76c](https://github.com/midudev/autoskills/commit/6a7c76c)`
- Update CLI banner formatting `[aee0b13](https://github.com/midudev/autoskills/commit/aee0b13)`
- Apply oxlint fixes and oxfmt formatting across codebase `[54e69c3](https://github.com/midudev/autoskills/commit/54e69c3)`
- Remove assertion for 'skills.sh' in CLI tests `[72c193a](https://github.com/midudev/autoskills/commit/72c193a)`

## [0.1.1](https://github.com/midudev/autoskills/releases/tag/v0.1.1) (2026-03-29)

### ✨ Features

- Enhance autoskills CLI with new white color function and improved multi-select rendering `[e2c2891](https://github.com/midudev/autoskills/commit/e2c2891)`

### 📦 Other Changes

- Refactor repos to individual skills with combo detection `[52ba1bc](https://github.com/midudev/autoskills/commit/52ba1bc)`
- Update tests for skills-based API and combo detection `[5a885f4](https://github.com/midudev/autoskills/commit/5a885f4)`

## [0.1.0](https://github.com/midudev/autoskills/releases/tag/v0.1.0) (2026-03-25)

### 🎉 Initial Release

- Add autoskills CLI package `[336fc45](https://github.com/midudev/autoskills/commit/336fc45)`