// ── Skills Map ────────────────────────────────────────────────

export const SKILLS_MAP = [
  {
    id: "react",
    name: "React",
    detect: {
      packages: ["react", "react-dom"],
    },
    skills: [
      "vercel-labs/agent-skills/vercel-react-best-practices",
      "vercel-labs/agent-skills/vercel-composition-patterns",
    ],
  },
  {
    id: "nextjs",
    name: "Next.js",
    detect: {
      packages: ["next"],
      configFiles: ["next.config.js", "next.config.mjs", "next.config.ts"],
    },
    skills: [
      "vercel-labs/next-skills/next-best-practices",
      "vercel-labs/next-skills/next-cache-components",
      "vercel-labs/next-skills/next-upgrade",
    ],
  },
  {
    id: "vue",
    name: "Vue",
    detect: {
      packages: ["vue"],
    },
    skills: [
      "hyf0/vue-skills/vue-best-practices",
      "hyf0/vue-skills/vue-debug-guides",
      "antfu/skills/vue",
      "antfu/skills/vue-best-practices",
    ],
  },
  {
    id: "nuxt",
    name: "Nuxt",
    detect: {
      packages: ["nuxt"],
      configFiles: ["nuxt.config.js", "nuxt.config.ts"],
    },
    skills: ["antfu/skills/nuxt"],
  },
  {
    id: "pinia",
    name: "Pinia",
    detect: {
      packages: ["pinia"],
    },
    skills: ["vuejs-ai/skills/vue-pinia-best-practices"],
  },
  {
    id: "svelte",
    name: "Svelte",
    detect: {
      packages: ["svelte", "@sveltejs/kit"],
      configFiles: ["svelte.config.js"],
    },
    skills: [
      "ejirocodes/agent-skills/svelte5-best-practices",
      "sveltejs/ai-tools/svelte-code-writer",
    ],
  },
  {
    id: "angular",
    name: "Angular",
    detect: {
      packages: ["@angular/core"],
      configFiles: ["angular.json"],
    },
    skills: [
      "angular/skills/angular-developer",
      "angular/angular/reference-core",
      "angular/angular/reference-signal-forms",
      "angular/angular/reference-compiler-cli",
      "angular/angular/adev-writing-guide",
      "angular/angular/PR Review",
    ],
  },
  {
    id: "astro",
    name: "Astro",
    detect: {
      packages: ["astro"],
      configFiles: ["astro.config.mjs", "astro.config.js", "astro.config.ts"],
    },
    skills: ["astrolicious/agent-skills/astro"],
  },
  {
    id: "tailwind",
    name: "Tailwind CSS",
    detect: {
      packages: ["tailwindcss", "@tailwindcss/vite"],
      configFiles: ["tailwind.config.js", "tailwind.config.ts", "tailwind.config.cjs"],
    },
    skills: ["giuseppe-trisciuoglio/developer-kit/tailwind-css-patterns"],
  },
  {
    id: "shadcn",
    name: "shadcn/ui",
    detect: {
      configFiles: ["components.json"],
    },
    skills: ["shadcn/ui/shadcn"],
  },
  {
    id: "typescript",
    name: "TypeScript",
    detect: {
      packages: ["typescript"],
      configFiles: ["tsconfig.json"],
    },
    skills: ["wshobson/agents/typescript-advanced-types"],
  },
  {
    id: "supabase",
    name: "Supabase",
    detect: {
      packages: ["@supabase/supabase-js", "@supabase/ssr"],
    },
    skills: ["supabase/agent-skills/supabase-postgres-best-practices"],
  },
  {
    id: "neon",
    name: "Neon Postgres",
    detect: {
      packages: ["@neondatabase/serverless"],
    },
    skills: ["neondatabase/agent-skills/neon-postgres"],
  },
  {
    id: "playwright",
    name: "Playwright",
    detect: {
      packages: ["@playwright/test", "playwright"],
      configFiles: ["playwright.config.ts", "playwright.config.js"],
    },
    skills: ["currents-dev/playwright-best-practices-skill/playwright-best-practices"],
  },
  {
    id: "expo",
    name: "Expo",
    detect: {
      packages: ["expo"],
    },
    skills: [
      "expo/skills/building-native-ui",
      "expo/skills/native-data-fetching",
      "expo/skills/upgrading-expo",
      "expo/skills/expo-tailwind-setup",
      "expo/skills/expo-dev-client",
      "expo/skills/expo-deployment",
      "expo/skills/expo-cicd-workflows",
      "expo/skills/expo-api-routes",
      "expo/skills/use-dom",
    ],
  },
  {
    id: "react-native",
    name: "React Native",
    detect: {
      packages: ["react-native"],
    },
    skills: ["sleekdotdesign/agent-skills/sleek-design-mobile-apps"],
  },
  {
    id: "kotlin-multiplatform",
    name: "Kotlin Multiplatform",
    detect: {
      configFileContent: {
        scanGradleLayout: true,
        patterns: [
          'kotlin("multiplatform")',
          "org.jetbrains.kotlin.multiplatform",
          'id("org.jetbrains.kotlin.multiplatform")',
          "kotlin-multiplatform",
        ],
      },
    },
    skills: [
      "Kotlin/kotlin-agent-skills/kotlin-tooling-cocoapods-spm-migration",
      "Kotlin/kotlin-agent-skills/kotlin-tooling-agp9-migration",
    ],
  },
  {
    id: "android",
    name: "Android",
    detect: {
      configFileContent: {
        scanGradleLayout: true,
        patterns: [
          "com.android.application",
          "com.android.library",
          'id("com.android.application")',
          'id("com.android.library")',
          "com.android.kotlin.multiplatform.library",
        ],
      },
    },
    skills: [
      "krutikJain/android-agent-skills/android-kotlin-core",
      "krutikJain/android-agent-skills/android-compose-foundations",
      "krutikJain/android-agent-skills/android-architecture-clean",
      "krutikJain/android-agent-skills/android-di-hilt",
      "krutikJain/android-agent-skills/android-gradle-build-logic",
      "krutikJain/android-agent-skills/android-coroutines-flow",
      "krutikJain/android-agent-skills/android-networking-retrofit-okhttp",
      "krutikJain/android-agent-skills/android-testing-unit",
    ],
  },
  {
    id: "remotion",
    name: "Remotion",
    detect: {
      packages: ["remotion", "@remotion/cli"],
    },
    skills: ["remotion-dev/skills/remotion-best-practices"],
  },
  {
    id: "clerk",
    name: "Clerk",
    detect: {
      packages: ["@clerk/nextjs", "@clerk/remix", "@clerk/astro", "@clerk/express", "@clerk/fastify", "@clerk/nuxt", "@clerk/vue", "@clerk/react", "@clerk/expo", "@clerk/tanstack-react-start", "@clerk/react-router", "@clerk/chrome-extension", "@clerk/backend"],
      packagePatterns: [/^@clerk\//],
    },
    skills: [
      "clerk/skills/clerk",
      "clerk/skills/clerk-setup",
      "clerk/skills/clerk-custom-ui",
      "clerk/skills/clerk-nextjs-patterns",
      "clerk/skills/clerk-orgs",
      "clerk/skills/clerk-webhooks",
      "clerk/skills/clerk-testing",
    ],
  },
  {
    id: "better-auth",
    name: "Better Auth",
    detect: {
      packages: ["better-auth"],
    },
    skills: [
      "better-auth/skills/better-auth-best-practices",
      "better-auth/skills/email-and-password-best-practices",
      "better-auth/skills/organization-best-practices",
      "better-auth/skills/two-factor-authentication-best-practices",
    ],
  },
  {
    id: "turborepo",
    name: "Turborepo",
    detect: {
      packages: ["turbo"],
      configFiles: ["turbo.json"],
    },
    skills: ["vercel/turborepo/turborepo"],
  },
  {
    id: "vite",
    name: "Vite",
    detect: {
      packages: ["vite"],
      configFiles: ["vite.config.js", "vite.config.ts", "vite.config.mjs"],
    },
    skills: ["antfu/skills/vite"],
  },
  {
    id: "azure",
    name: "Azure",
    detect: {
      packagePatterns: [/^@azure\//],
    },
    skills: [
      "microsoft/github-copilot-for-azure/azure-deploy",
      "microsoft/github-copilot-for-azure/azure-ai",
      "microsoft/github-copilot-for-azure/azure-cost-optimization",
      "microsoft/github-copilot-for-azure/azure-diagnostics",
    ],
  },
  {
    id: "vercel-ai",
    name: "Vercel AI SDK",
    detect: {
      packages: ["ai", "@ai-sdk/openai", "@ai-sdk/anthropic", "@ai-sdk/google"],
    },
    skills: ["vercel/ai/ai-sdk"],
  },
  {
    id: "elevenlabs",
    name: "ElevenLabs",
    detect: {
      packages: ["elevenlabs"],
    },
    skills: ["inferen-sh/skills/elevenlabs-tts", "inferen-sh/skills/elevenlabs-music"],
  },
  {
    id: "vercel-deploy",
    name: "Vercel",
    detect: {
      configFiles: ["vercel.json", ".vercel"],
      packages: ["vercel", "@astrojs/vercel"],
    },
    skills: ["vercel-labs/agent-skills/deploy-to-vercel"],
  },
  {
    id: "cloudflare",
    name: "Cloudflare",
    detect: {
      packages: ["wrangler", "@cloudflare/workers-types", "@astrojs/cloudflare"],
      configFiles: ["wrangler.toml", "wrangler.json", "wrangler.jsonc"],
    },
    skills: [
      "cloudflare/skills/cloudflare",
      "cloudflare/skills/wrangler",
      "cloudflare/skills/workers-best-practices",
      "cloudflare/skills/web-perf",
      "openai/skills/cloudflare-deploy",
    ],
  },
  {
    id: "cloudflare-durable-objects",
    name: "Durable Objects",
    detect: {
      configFileContent: {
        files: ["wrangler.json", "wrangler.jsonc", "wrangler.toml"],
        patterns: ["durable_objects"],
      },
    },
    skills: ["cloudflare/skills/durable-objects"],
  },
  {
    id: "cloudflare-agents",
    name: "Cloudflare Agents",
    detect: {
      packages: ["agents"],
    },
    skills: [
      "cloudflare/skills/agents-sdk",
      "cloudflare/skills/building-mcp-server-on-cloudflare",
      "cloudflare/skills/sandbox-sdk",
    ],
  },
  {
    id: "cloudflare-ai",
    name: "Cloudflare AI",
    detect: {
      packages: ["@cloudflare/ai"],
      configFileContent: {
        files: ["wrangler.json", "wrangler.jsonc"],
        patterns: ['"ai"'],
      },
    },
    skills: ["cloudflare/skills/building-ai-agent-on-cloudflare"],
  },
  {
    id: "aws",
    name: "AWS",
    detect: {
      packagePatterns: [/^@aws-sdk\//, /^aws-cdk/],
    },
    skills: [],
  },
  {
    id: "swiftui",
    name: "SwiftUI",
    detect: {
      configFiles: ["Package.swift"],
    },
    skills: ["avdlee/swiftui-agent-skill/swiftui-expert-skill"],
  },
  {
    id: "oxlint",
    name: "oxlint",
    detect: {
      packages: ["oxlint"],
      configFiles: [".oxlintrc.json", "oxlint.config.ts"],
    },
    skills: ["delexw/claude-code-misc/oxlint"],
  },
  {
    id: "gsap",
    name: "GSAP",
    detect: {
      packages: ["gsap"],
    },
    skills: [
      "greensock/gsap-skills/gsap-core",
      "greensock/gsap-skills/gsap-scrolltrigger",
      "greensock/gsap-skills/gsap-performance",
      "greensock/gsap-skills/gsap-plugins",
      "greensock/gsap-skills/gsap-timeline",
      "greensock/gsap-skills/gsap-utils",
      "greensock/gsap-skills/gsap-frameworks",
    ],
  },
  {
    id: "bun",
    name: "Bun",
    detect: {
      configFiles: ["bun.lockb", "bun.lock", "bunfig.toml"],
    },
    skills: ["https://bun.sh/docs"],
  },
  {
    id: "node",
    name: "Node.js",
    detect: {
      configFiles: ["package-lock.json", "yarn.lock", "pnpm-lock.yaml", ".nvmrc", ".node-version"],
    },
    skills: [
      "wshobson/agents/nodejs-backend-patterns",
      "sickn33/antigravity-awesome-skills/nodejs-best-practices",
    ],
  },
  {
    id: "express",
    name: "Express",
    detect: {
      packages: ["express"],
    },
    skills: [],
  },
  {
    id: "deno",
    name: "Deno",
    detect: {
      configFiles: ["deno.json", "deno.jsonc", "deno.lock"],
    },
    skills: [
      "denoland/skills/deno-expert",
      "denoland/skills/deno-guidance",
      "denoland/skills/deno-frontend",
      "denoland/skills/deno-deploy",
      "denoland/skills/deno-sandbox",
      "mindrally/skills/deno-typescript",
    ],
  },
  {
    id: "wordpress",
    name: "WordPress",
    detect: {
      configFiles: ["wp-config.php", "wp-login.php"],
      packagePatterns: [/^@wordpress\//],
      configFileContent: {
        files: ["composer.json", "style.css"],
        patterns: ["johnpbloch/wordpress", "wpackagist", "Theme Name:"],
      },
    },
    skills: [
      "wordpress/agent-skills/wp-plugin-development",
      "wordpress/agent-skills/wp-rest-api",
      "wordpress/agent-skills/wp-block-themes",
      "wordpress/agent-skills/wp-block-development",
      "wordpress/agent-skills/wp-performance",
      "wordpress/agent-skills/wordpress-router",
      "wordpress/agent-skills/wp-project-triage",
      "wordpress/agent-skills/wp-wpcli-and-ops",
    ],
  },
  {
    id: "java",
    name: "Java",
    detect: {
      configFiles: ["pom.xml"],
      configFileContent: {
        scanGradleLayout: true,
        patterns: [
          "sourceCompatibility",
          "targetCompatibility",
          "JavaVersion",
          'id("java")',
          "id 'java'",
          'id("java-library")',
          "id 'java-library'",
        ],
      },
    },
    skills: [
      "github/awesome-copilot/java-docs",
      "affaan-m/everything-claude-code/java-coding-standards",
    ],
  },
  {
    id: "springboot",
    name: "Spring Boot",
    detect: {
      configFiles: [
        "src/main/resources/application.properties",
        "src/main/resources/application.yml",
        "src/main/resources/application.yaml",
      ],
      configFileContent: {
        files: ["pom.xml"],
        patterns: ["spring-boot-starter", "org.springframework.boot"],
      },
    },
    skills: ["github/awesome-copilot/java-springboot"],
  },
  {
    id: "prisma",
    name: "Prisma",
    detect: {
      packages: ["prisma", "@prisma/client"],
    },
    skills: [
      "prisma/skills/prisma-database-setup",
      "prisma/skills/prisma-client-api",
      "prisma/skills/prisma-cli",
      "prisma/skills/prisma-postgres",
    ],
  },
  {
    id: "stripe",
    name: "Stripe",
    detect: {
      packages: ["stripe", "@stripe/stripe-js", "@stripe/react-stripe-js"],
    },
    skills: ["stripe/ai/stripe-best-practices", "stripe/ai/upgrade-stripe"],
  },
  {
    id: "hono",
    name: "Hono",
    detect: {
      packages: ["hono"],
    },
    skills: ["yusukebe/hono-skill/hono"],
  },
  {
    id: "vitest",
    name: "Vitest",
    detect: {
      packages: ["vitest"],
      configFiles: ["vitest.config.ts", "vitest.config.js", "vitest.config.mts"],
    },
    skills: ["antfu/skills/vitest"],
  },
  {
    id: "drizzle",
    name: "Drizzle ORM",
    detect: {
      packages: ["drizzle-orm", "drizzle-kit"],
    },
    skills: ["bobmatnyc/claude-mpm-skills/drizzle-orm"],
  },
  {
    id: "nestjs",
    name: "NestJS",
    detect: {
      packages: ["@nestjs/core"],
    },
    skills: ["kadajett/agent-nestjs-skills/nestjs-best-practices"],
  },
  {
    id: "tauri",
    name: "Tauri",
    detect: {
      packages: ["@tauri-apps/api", "@tauri-apps/cli"],
      configFiles: ["src-tauri/tauri.conf.json"],
    },
    skills: ["nodnarbnitram/claude-code-extensions/tauri-v2"],
  },
];

// ── Combo Skills Map (cross-technology) ──────────────────────

export const COMBO_SKILLS_MAP = [
  {
    id: "expo-tailwind",
    name: "Expo + Tailwind CSS",
    requires: ["expo", "tailwind"],
    skills: ["expo/skills/expo-tailwind-setup"],
  },
  {
    id: "nextjs-supabase",
    name: "Next.js + Supabase",
    requires: ["nextjs", "supabase"],
    skills: ["supabase/agent-skills/supabase-postgres-best-practices"],
  },
  {
    id: "react-native-expo",
    name: "React Native + Expo",
    requires: ["react-native", "expo"],
    skills: [
      "expo/skills/building-native-ui",
      "sleekdotdesign/agent-skills/sleek-design-mobile-apps",
    ],
  },
  {
    id: "nextjs-vercel-ai",
    name: "Next.js + Vercel AI SDK",
    requires: ["nextjs", "vercel-ai"],
    skills: ["vercel/ai/ai-sdk", "vercel-labs/next-skills/next-best-practices"],
  },
  {
    id: "nextjs-playwright",
    name: "Next.js + Playwright",
    requires: ["nextjs", "playwright"],
    skills: ["currents-dev/playwright-best-practices-skill/playwright-best-practices"],
  },
  {
    id: "react-shadcn",
    name: "React + shadcn/ui",
    requires: ["react", "shadcn"],
    skills: ["shadcn/ui/shadcn", "vercel-labs/agent-skills/vercel-react-best-practices"],
  },
  {
    id: "tailwind-shadcn",
    name: "Tailwind CSS + shadcn/ui",
    requires: ["tailwind", "shadcn"],
    skills: ["secondsky/claude-skills/tailwind-v4-shadcn"],
  },
  {
    id: "gsap-react",
    name: "GSAP + React",
    requires: ["gsap", "react"],
    skills: ["greensock/gsap-skills/gsap-react"],
  },
  {
    id: "cloudflare-vite",
    name: "Cloudflare + Vite",
    requires: ["cloudflare", "vite"],
    skills: ["cloudflare/vinext/migrate-to-vinext"],
  },
  {
    id: "node-express",
    name: "Node.js + Express",
    requires: ["node", "express"],
    skills: ["aj-geddes/useful-ai-prompts/nodejs-express-server"],
  },
  {
    id: "nextjs-clerk",
    name: "Next.js + Clerk",
    requires: ["nextjs", "clerk"],
    skills: [
      "clerk/skills/clerk-nextjs-patterns",
      "clerk/skills/clerk-setup",
      "clerk/skills/clerk",
    ],
  },
];

// ── Frontend Detection ────────────────────────────────────────

export const FRONTEND_PACKAGES = [
  "react",
  "vue",
  "svelte",
  "astro",
  "next",
  "@angular/core",
  "solid-js",
  "lit",
  "preact",
  "nuxt",
  "@sveltejs/kit",
];

export const FRONTEND_BONUS_SKILLS = [
  "anthropics/skills/frontend-design",
  "addyosmani/web-quality-skills/accessibility",
  "addyosmani/web-quality-skills/seo",
];

// ── Agent Folder Map ─────────────────────────────────────────

/**
 * Maps well-known agent home directory folder names to their `skills` CLI agent identifiers.
 * Only the most common agents are included; `.agents` (universal) is handled separately.
 */
export const AGENT_FOLDER_MAP = {
  ".claude": "claude-code",
  ".cursor": "cursor",
  ".cline": "cline",
  ".codex": "codex",
  ".antigravity": "antigravity",
  ".augment": "augment",
  ".copilot": "github-copilot",
  ".gemini": "gemini-cli",
  ".junie": "junie",
  ".amp": "amp",
  ".supermaven": "supermaven",
  ".codebuddy": "codebuddy",
  ".continue": "continue",
};

export const WEB_FRONTEND_EXTENSIONS = new Set([
  ".html",
  ".htm",
  ".css",
  ".scss",
  ".sass",
  ".less",
  ".vue",
  ".svelte",
  ".jsx",
  ".tsx",
  ".twig",
  ".tpl",
  ".ejs",
  ".hbs",
  ".pug",
  ".njk",
]);
