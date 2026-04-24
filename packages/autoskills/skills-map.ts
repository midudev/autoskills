// ── Types ─────────────────────────────────────────────────────

export interface ConfigFileContentBlock {
  files?: string[];
  patterns: string[];
  scanGradleLayout?: boolean;
  scanDotNetLayout?: boolean;
}

export interface DetectConfig {
  packages?: string[];
  packagePatterns?: RegExp[];
  configFiles?: string[];
  gems?: string[];
  configFileContent?: ConfigFileContentBlock | ConfigFileContentBlock[];
}

export interface Technology {
  id: string;
  name: string;
  detect: DetectConfig;
  skills: string[];
}

export interface ComboSkill {
  id: string;
  name: string;
  requires: string[];
  skills: string[];
}

// ── Skills Map ────────────────────────────────────────────────

export const SKILLS_MAP: Technology[] = [
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
    id: "react-hook-form",
    name: "React Hook Form",
    detect: {
      packages: ["react-hook-form"],
    },
    skills: ["pproenca/dot-skills/react-hook-form"],
  },
  {
    id: "zod",
    name: "Zod",
    detect: {
      packages: ["zod"],
    },
    skills: ["pproenca/dot-skills/zod"],
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
    id: "dart",
    name: "Dart",
    detect: {
      configFiles: ["pubspec.yaml"],
    },
    skills: ["kevmoo/dash_skills/dart-best-practices"],
  },
  {
    id: "flutter",
    name: "Flutter",
    detect: {
      configFileContent: {
        patterns: ["flutter:"],
        files: ["pubspec.yaml"],
      },
    },
    skills: [
      "jeffallan/claude-skills/flutter-expert",
      "madteacher/mad-agents-skills/flutter-animations",
      "madteacher/mad-agents-skills/flutter-testing",
    ],
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
    id: "react-router",
    name: "React Router",
    detect: {
      packages: ["react-router", "@react-router/node", "@react-router/dev", "@react-router/serve"],
    },
    skills: [],
  },
  {
    id: "tanstack-start",
    name: "TanStack Start",
    detect: {
      packages: ["@tanstack/react-start", "@tanstack/start"],
    },
    skills: ["tanstack-skills/tanstack-skills/tanstack-start"],
  },
  {
    id: "chrome-extension",
    name: "Chrome Extension",
    detect: {
      configFileContent: {
        files: ["manifest.json"],
        patterns: ["manifest_version"],
      },
    },
    skills: ["mindrally/skills/chrome-extension-development"],
  },
  {
    id: "clerk",
    name: "Clerk",
    detect: {
      packages: [
        "@clerk/nextjs",
        "@clerk/remix",
        "@clerk/astro",
        "@clerk/express",
        "@clerk/fastify",
        "@clerk/nuxt",
        "@clerk/vue",
        "@clerk/react",
        "@clerk/expo",
        "@clerk/tanstack-react-start",
        "@clerk/react-router",
        "@clerk/chrome-extension",
        "@clerk/backend",
      ],
      packagePatterns: [/^@clerk\//],
      configFileContent: [
        {
          files: ["Package.swift"],
          patterns: ["clerk/clerk-ios", "ClerkSDK"],
        },
        {
          scanGradleLayout: true,
          patterns: ["com.clerk"],
        },
      ],
    },
    skills: [
      "clerk/skills/clerk",
      "clerk/skills/clerk-setup",
      "clerk/skills/clerk-custom-ui",
      "clerk/skills/clerk-backend-api",
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
    id: "terraform",
    name: "Terraform",
    detect: {
      configFiles: [
        ".terraform.lock.hcl",
        "terraform.tfvars",
        "main.tf",
        "variables.tf",
        "outputs.tf",
      ],
    },
    skills: [
      "hashicorp/agent-skills/terraform-style-guide",
      "hashicorp/agent-skills/refactor-module",
      "hashicorp/agent-skills/terraform-stacks",
      "wshobson/agents/terraform-module-library",
    ],
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
    skills: [
      "avdlee/swiftui-agent-skill/swiftui-expert-skill",
      "avdlee/swift-concurrency-agent-skill",
      "avdlee/xcode-build-optimization-agent-skill",
      "avdlee/swift-testing-agent-skill",
      "avdlee/core-data-agent-skill",
    ],
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
    id: "threejs",
    name: "Three.js",
    detect: {
      packages: ["three"],
    },
    skills: [
      "cloudai-x/threejs-skills/threejs-animation",
      "cloudai-x/threejs-skills/threejs-fundamentals",
      "cloudai-x/threejs-skills/threejs-shaders",
      "cloudai-x/threejs-skills/threejs-geometry",
      "cloudai-x/threejs-skills/threejs-interaction",
      "cloudai-x/threejs-skills/threejs-materials",
      "cloudai-x/threejs-skills/threejs-postprocessing",
      "cloudai-x/threejs-skills/threejs-lighting",
      "cloudai-x/threejs-skills/threejs-textures",
      "cloudai-x/threejs-skills/threejs-loaders",
    ],
  },
  {
    id: "@react-three/fiber",
    name: "React Three Fiber",
    detect: {
      packages: ["@react-three/fiber"],
    },
    skills: [],
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
    id: "go",
    name: "Go",
    detect: {
      configFiles: ["go.mod", "go.work"],
    },
    skills: [
      "affaan-m/everything-claude-code/golang-patterns",
      "affaan-m/everything-claude-code/golang-testing",
    ],
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
  {
    id: "electron",
    name: "Electron",
    detect: {
      packages: ["electron"],
      configFiles: [
        "electron-builder.yml",
        "electron-builder.json",
        "electron-builder.js",
        "forge.config.js",
        "forge.config.cjs",
        "forge.config.mjs",
        "forge.config.ts",
        "electron-vite.config.ts",
        "electron-vite.config.js",
        "electron-vite.config.mjs",
        "electron-vite.config.cjs",
      ],
    },
    skills: ["vercel-labs/agent-skills/electron-best-practices"],
  },
  {
    id: "dotnet",
    name: ".NET",
    detect: {
      configFiles: [
        "global.json",
        "NuGet.Config",
        "Directory.Build.props",
        "Directory.Packages.props",
      ],
      configFileContent: {
        scanDotNetLayout: true,
        patterns: ['<Project Sdk="Microsoft.NET.Sdk'],
      },
    },
    skills: [
      "github/awesome-copilot/dotnet-best-practices",
      "github/awesome-copilot/dotnet-design-pattern-review",
      "github/awesome-copilot/dotnet-upgrade",
    ],
  },
  {
    id: "csharp",
    name: "C#",
    detect: {
      configFileContent: {
        scanDotNetLayout: true,
        patterns: ["<Project", "Microsoft.NET.Sdk"],
      },
    },
    skills: [
      "github/awesome-copilot/csharp-xunit",
      "github/awesome-copilot/csharp-async",
      "github/awesome-copilot/csharp-docs",
      "github/awesome-copilot/csharp-nunit",
      "github/awesome-copilot/csharp-mstest",
      "github/awesome-copilot/csharp-tunit",
    ],
  },
  {
    id: "aspnetcore",
    name: "ASP.NET Core",
    detect: {
      configFiles: ["appsettings.json", "appsettings.Development.json"],
      configFileContent: {
        scanDotNetLayout: true,
        patterns: ["Microsoft.NET.Sdk.Web"],
      },
    },
    skills: ["github/awesome-copilot/containerize-aspnetcore", "openai/skills/aspnet-core"],
  },
  {
    id: "aspnet-blazor",
    name: "Blazor",
    detect: {
      configFileContent: {
        scanDotNetLayout: true,
        patterns: ["Microsoft.NET.Sdk.BlazorWebAssembly", "Microsoft.AspNetCore.Components"],
      },
    },
    skills: ["github/awesome-copilot/fluentui-blazor"],
  },
  {
    id: "aspnet-minimal-api",
    name: "ASP.NET Minimal API",
    detect: {
      configFiles: ["appsettings.json"],
      configFileContent: {
        scanDotNetLayout: true,
        patterns: ["Microsoft.AspNetCore.OpenApi", "Swashbuckle.AspNetCore"],
      },
    },
    skills: [
      "github/awesome-copilot/aspnet-minimal-api-openapi",
      "dotnet/skills/minimal-api-file-upload",
    ],
  },
  {
    id: "rust",
    name: "Rust",
    detect: {
      configFiles: ["Cargo.toml"],
    },
    skills: ["apollographql/skills/rust-best-practices"],
  },
  {
    id: "ruby",
    name: "Ruby",
    detect: {
      configFiles: ["Gemfile", "Gemfile.lock", ".ruby-version", ".ruby-gemset"],
    },
    skills: ["lucianghinda/superpowers-ruby/ruby"],
  },
  {
    id: "rails",
    name: "Ruby on Rails",
    detect: {
      gems: ["rails"],
      configFiles: ["config/routes.rb", "config/application.rb", "bin/rails"],
    },
    skills: [
      "sergiodxa/agent-skills/ruby-on-rails-best-practices",
      "lucianghinda/superpowers-ruby/rails-guides",
      "igmarin/rails-agent-skills/rails-stack-conventions",
      "igmarin/rails-agent-skills/rails-code-review",
      "igmarin/rails-agent-skills/rails-migration-safety",
      "igmarin/rails-agent-skills/rails-security-review",
      "ombulabs/claude-code_rails-upgrade-skill/rails-upgrade",
    ],
  },
  {
    id: "redis-ruby",
    name: "Redis (Ruby)",
    detect: {
      gems: ["redis", "sidekiq", "resque", "redis-rails"],
    },
    skills: ["redis/agent-skills/redis-development"],
  },
  {
    id: "postgres-ruby",
    name: "PostgreSQL",
    detect: {
      gems: ["pg"],
    },
    skills: [],
  },
  {
    id: "python",
    name: "Python",
    detect: {
      configFiles: ["pyproject.toml", "requirements.txt", "setup.py", "setup.cfg", "Pipfile"],
    },
    skills: [],
  },
  {
    id: "sorbet",
    name: "Sorbet",
    detect: {
      gems: ["sorbet", "sorbet-runtime"],
      configFiles: ["sorbet/config"],
    },
    skills: [
      "DmitryPogrebnoy/ruby-agent-skills/generating-sorbet",
      "DmitryPogrebnoy/ruby-agent-skills/generating-sorbet-inline",
    ],
  },
  {
    id: "activeadmin",
    name: "ActiveAdmin",
    detect: {
      gems: ["activeadmin"],
    },
    skills: [],
  },
  {
    id: "django",
    name: "Django",
    detect: {
      configFiles: ["manage.py"],
      configFileContent: {
        files: ["pyproject.toml", "requirements.txt", "setup.py", "setup.cfg", "Pipfile"],
        patterns: ["django", "Django"],
      },
    },
    skills: [],
  },
  {
    id: "devise",
    name: "Devise",
    detect: {
      gems: ["devise"],
    },
    skills: [],
  },
  {
    id: "fastapi",
    name: "FastAPI",
    detect: {
      configFileContent: {
        files: ["pyproject.toml", "requirements.txt", "setup.py", "setup.cfg", "Pipfile"],
        patterns: ["fastapi", "FastAPI"],
      },
    },
    skills: [],
  },
  {
    id: "sidekiq",
    name: "Sidekiq",
    detect: {
      gems: ["sidekiq"],
    },
    skills: ["igmarin/rails-agent-skills/rails-background-jobs"],
  },
  {
    id: "rspec",
    name: "RSpec",
    detect: {
      gems: ["rspec", "rspec-rails"],
      configFiles: [".rspec"],
    },
    skills: [
      "igmarin/rails-agent-skills/rspec-best-practices",
      "igmarin/rails-agent-skills/rspec-service-testing",
      "lucianghinda/superpowers-ruby/test-driven-development",
    ],
  },
  {
    id: "rubocop",
    name: "RuboCop",
    detect: {
      gems: ["rubocop", "rubocop-rails"],
      configFiles: [".rubocop.yml"],
    },
    skills: [],
  },
  {
    id: "php",
    name: "PHP",
    detect: {
      configFiles: ["composer.json", "composer.lock"],
    },
    skills: ["jeffallan/claude-skills/php-pro"],
  },
  {
    id: "laravel",
    name: "Laravel",
    detect: {
      configFiles: ["artisan", "bootstrap/app.php"],
      configFileContent: {
        files: ["composer.json"],
        patterns: ['"laravel/framework"', '"illuminate/'],
      },
    },
    skills: [
      "jeffallan/claude-skills/laravel-specialist",
      "affaan-m/everything-claude-code/laravel-patterns",
    ],
  },
  {
    id: "python",
    name: "Python",
    detect: {
      configFiles: ["pyproject.toml", "requirements.txt", "setup.py", "Pipfile"],
    },
    skills: ["inferen-sh/skills/python-executor", "wshobson/agents/python-testing-patterns"],
  },
  {
    id: "fastapi",
    name: "FastAPI",
    detect: {
      configFileContent: {
        files: ["pyproject.toml", "requirements.txt", "setup.py", "Pipfile"],
        patterns: ["fastapi", "FastAPI"],
      },
    },
    skills: [
      "wshobson/agents/fastapi-templates",
      "mindrally/skills/fastapi-python",
      "jezweb/claude-skills/fastapi",
    ],
  },
  {
    id: "django",
    name: "Django",
    detect: {
      configFileContent: {
        files: ["pyproject.toml", "requirements.txt", "setup.py", "Pipfile"],
        patterns: ["django", "Django"],
      },
    },
    skills: [
      "vintasoftware/django-ai-plugins/django-expert",
      "affaan-m/everything-claude-code/django-patterns",
      "affaan-m/everything-claude-code/django-security",
    ],
  },
  {
    id: "flask",
    name: "Flask",
    detect: {
      configFileContent: {
        files: ["pyproject.toml", "requirements.txt", "setup.py", "setup.cfg", "Pipfile"],
        patterns: ["flask", "Flask"],
      },
    },
    skills: ["jezweb/claude-skills/flask", "aj-geddes/useful-ai-prompts/flask-api-development"],
  },
  {
    id: "pydantic",
    name: "Pydantic",
    detect: {
      configFileContent: {
        files: ["pyproject.toml", "requirements.txt", "setup.py", "Pipfile"],
        patterns: ["pydantic", "Pydantic"],
      },
    },
    skills: ["bobmatnyc/claude-mpm-skills/pydantic"],
  },
  {
    id: "sqlalchemy",
    name: "SQLAlchemy",
    detect: {
      configFileContent: {
        files: ["pyproject.toml", "requirements.txt", "setup.py", "Pipfile"],
        patterns: ["sqlalchemy", "SQLAlchemy"],
      },
    },
    skills: [
      "bobmatnyc/claude-mpm-skills/sqlalchemy-orm",
      "wispbit-ai/skills/sqlalchemy-alembic-expert-best-practices-code-review",
    ],
  },
  {
    id: "pytest",
    name: "Pytest",
    detect: {
      configFileContent: {
        files: ["pyproject.toml", "requirements.txt", "setup.py", "Pipfile"],
        patterns: ["pytest", "Pytest"],
      },
    },
    skills: ["wshobson/agents/python-testing-patterns"],
  },
  {
    id: "pandas",
    name: "Pandas",
    detect: {
      configFileContent: {
        files: ["pyproject.toml", "requirements.txt", "setup.py", "Pipfile"],
        patterns: ["pandas", "Pandas"],
      },
    },
    skills: [
      "jeffallan/claude-skills/pandas-pro",
      "pluginagentmarketplace/custom-plugin-python/pandas-data-analysis",
    ],
  },
  {
    id: "numpy",
    name: "NumPy",
    detect: {
      configFileContent: {
        files: ["pyproject.toml", "requirements.txt", "setup.py", "Pipfile"],
        patterns: ["numpy", "NumPy", "numpy"],
      },
    },
    skills: [
      "pluginagentmarketplace/custom-plugin-python/machine-learning",
      "pluginagentmarketplace/custom-plugin-python/pandas-data-analysis",
    ],
  },
  {
    id: "scikit-learn",
    name: "Scikit-Learn",
    detect: {
      configFileContent: {
        files: ["pyproject.toml", "requirements.txt", "setup.py", "Pipfile"],
        patterns: ["scikit-learn", "scikit_learn", "sklearn"],
      },
    },
    skills: [
      "davila7/claude-code-templates/scikit-learn",
      "davila7/claude-code-templates/senior-data-scientist",
    ],
  },
  {
    id: "celery",
    name: "Celery",
    detect: {
      configFileContent: {
        files: ["pyproject.toml", "requirements.txt", "setup.py", "Pipfile"],
        patterns: ["celery", "Celery"],
      },
    },
    skills: ["wshobson/agents/python-background-jobs"],
  },
  {
    id: "requests",
    name: "Requests",
    detect: {
      configFileContent: {
        files: ["pyproject.toml", "requirements.txt", "setup.py", "Pipfile"],
        patterns: ["requests", "Requests"],
      },
    },
    skills: ["affaan-m/everything-claude-code/python-patterns"],
  },
];

// ── Combo Skills Map (cross-technology) ──────────────────────

export const COMBO_SKILLS_MAP: ComboSkill[] = [
  {
    id: "expo-tailwind",
    name: "Expo + Tailwind CSS",
    requires: ["expo", "tailwind"],
    skills: ["expo/skills/expo-tailwind-setup"],
  },
  {
    id: "react-hook-form-zod",
    name: "React Hook Form + Zod",
    requires: ["react-hook-form", "zod"],
    skills: ["jezweb/claude-skills/react-hook-form-zod", "pproenca/dot-skills/zod"],
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
    skills: ["clerk/skills/clerk-nextjs-patterns"],
  },
  {
    id: "nuxt-clerk",
    name: "Nuxt + Clerk",
    requires: ["nuxt", "clerk"],
    skills: ["clerk/skills/clerk-nuxt-patterns"],
  },
  {
    id: "vue-clerk",
    name: "Vue + Clerk",
    requires: ["vue", "clerk"],
    skills: ["clerk/skills/clerk-vue-patterns"],
  },
  {
    id: "react-clerk",
    name: "React + Clerk",
    requires: ["react", "clerk"],
    skills: ["clerk/skills/clerk-react-patterns"],
  },
  {
    id: "astro-clerk",
    name: "Astro + Clerk",
    requires: ["astro", "clerk"],
    skills: ["clerk/skills/clerk-astro-patterns"],
  },
  {
    id: "expo-clerk",
    name: "Expo + Clerk",
    requires: ["expo", "clerk"],
    skills: ["clerk/skills/clerk-expo-patterns"],
  },
  {
    id: "react-react-three-fiber",
    name: "React + React Three Fiber",
    requires: ["threejs", "react", "@react-three/fiber"],
    skills: ["vercel-labs/json-render/react-three-fiber"],
  },
  {
    id: "react-router-clerk",
    name: "React Router + Clerk",
    requires: ["react-router", "clerk"],
    skills: [
      "clerk/skills/clerk-react-router-patterns",
      "clerk/skills/clerk-setup",
      "clerk/skills/clerk",
    ],
  },
  {
    id: "tanstack-clerk",
    name: "TanStack Start + Clerk",
    requires: ["tanstack-start", "clerk"],
    skills: [
      "clerk/skills/clerk-tanstack-patterns",
      "clerk/skills/clerk-setup",
      "clerk/skills/clerk",
    ],
  },
  {
    id: "chrome-extension-clerk",
    name: "Chrome Extension + Clerk",
    requires: ["chrome-extension", "clerk"],
    skills: [
      "clerk/skills/clerk-chrome-extension-patterns",
      "clerk/skills/clerk-setup",
      "clerk/skills/clerk",
    ],
  },
  {
    id: "swiftui-clerk",
    name: "SwiftUI + Clerk",
    requires: ["swiftui", "clerk"],
    skills: ["clerk/skills/clerk-swift", "clerk/skills/clerk-setup", "clerk/skills/clerk"],
  },
  {
    id: "android-clerk",
    name: "Android + Clerk",
    requires: ["android", "clerk"],
    skills: ["clerk/skills/clerk-android", "clerk/skills/clerk-setup", "clerk/skills/clerk"],
  },
  {
    id: "rails-rspec",
    name: "Ruby on Rails + RSpec",
    requires: ["rails", "rspec"],
    skills: [
      "igmarin/rails-agent-skills/rails-tdd-slices",
      "igmarin/rails-agent-skills/rails-bug-triage",
    ],
  },
  {
    id: "rails-sidekiq",
    name: "Ruby on Rails + Sidekiq",
    requires: ["rails", "sidekiq"],
    skills: [],
  },
];

// ── Frontend Detection ────────────────────────────────────────

export const FRONTEND_PACKAGES: Set<string> = new Set([
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
]);

export const FRONTEND_BONUS_SKILLS: string[] = [
  "anthropics/skills/frontend-design",
  "addyosmani/web-quality-skills/accessibility",
  "addyosmani/web-quality-skills/seo",
];

// ── Agent Folder Map ─────────────────────────────────────────

export const AGENT_FOLDER_MAP: Record<string, string> = {
  ".claude": "claude-code",
  ".cursor": "cursor",
  ".cline": "cline",
  ".codex": "codex",
  ".opencode": "opencode",
  ".antigravity": "antigravity",
  ".augment": "augment",
  ".copilot": "github-copilot",
  ".gemini": "gemini-cli",
  ".junie": "junie",
  ".amp": "amp",
  ".supermaven": "supermaven",
  ".codebuddy": "codebuddy",
  ".continue": "continue",
  ".kiro": "kiro-cli",
};

export const WEB_FRONTEND_EXTENSIONS: Set<string> = new Set([
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
