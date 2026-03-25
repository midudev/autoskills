import { readFileSync, existsSync } from 'node:fs'
import { join } from 'node:path'

// ── Skills Map ────────────────────────────────────────────────

export const SKILLS_MAP = [
  {
    id: 'react',
    name: 'React',
    detect: {
      packages: ['react', 'react-dom'],
    },
    repos: ['vercel-labs/agent-skills'],
  },
  {
    id: 'nextjs',
    name: 'Next.js',
    detect: {
      packages: ['next'],
      configFiles: ['next.config.js', 'next.config.mjs', 'next.config.ts'],
    },
    repos: ['vercel-labs/next-skills'],
  },
  {
    id: 'vue',
    name: 'Vue',
    detect: {
      packages: ['vue'],
    },
    repos: ['hyf0/vue-skills', 'antfu/skills'],
  },
  {
    id: 'nuxt',
    name: 'Nuxt',
    detect: {
      packages: ['nuxt'],
      configFiles: ['nuxt.config.js', 'nuxt.config.ts'],
    },
    repos: ['hyf0/vue-skills'],
  },
  {
    id: 'svelte',
    name: 'Svelte',
    detect: {
      packages: ['svelte', '@sveltejs/kit'],
      configFiles: ['svelte.config.js'],
    },
    repos: [],
  },
  {
    id: 'angular',
    name: 'Angular',
    detect: {
      packages: ['@angular/core'],
      configFiles: ['angular.json'],
    },
    repos: [],
  },
  {
    id: 'astro',
    name: 'Astro',
    detect: {
      packages: ['astro'],
      configFiles: ['astro.config.mjs', 'astro.config.js', 'astro.config.ts'],
    },
    repos: [],
  },
  {
    id: 'tailwind',
    name: 'Tailwind CSS',
    detect: {
      packages: ['tailwindcss', '@tailwindcss/vite'],
      configFiles: ['tailwind.config.js', 'tailwind.config.ts', 'tailwind.config.cjs'],
    },
    repos: ['wshobson/agents'],
  },
  {
    id: 'shadcn',
    name: 'shadcn/ui',
    detect: {
      configFiles: ['components.json'],
    },
    repos: ['shadcn/ui'],
  },
  {
    id: 'typescript',
    name: 'TypeScript',
    detect: {
      packages: ['typescript'],
      configFiles: ['tsconfig.json'],
    },
    repos: ['wshobson/agents'],
  },
  {
    id: 'supabase',
    name: 'Supabase',
    detect: {
      packages: ['@supabase/supabase-js', '@supabase/ssr'],
    },
    repos: ['supabase/agent-skills'],
  },
  {
    id: 'neon',
    name: 'Neon Postgres',
    detect: {
      packages: ['@neondatabase/serverless'],
    },
    repos: ['neondatabase/agent-skills'],
  },
  {
    id: 'playwright',
    name: 'Playwright',
    detect: {
      packages: ['@playwright/test', 'playwright'],
      configFiles: ['playwright.config.ts', 'playwright.config.js'],
    },
    repos: ['currents-dev/playwright-best-practices-skill'],
  },
  {
    id: 'expo',
    name: 'Expo',
    detect: {
      packages: ['expo'],
    },
    repos: ['expo/skills'],
  },
  {
    id: 'react-native',
    name: 'React Native',
    detect: {
      packages: ['react-native'],
    },
    repos: ['sleekdotdesign/agent-skills'],
  },
  {
    id: 'remotion',
    name: 'Remotion',
    detect: {
      packages: ['remotion', '@remotion/cli'],
    },
    repos: ['remotion-dev/skills'],
  },
  {
    id: 'better-auth',
    name: 'Better Auth',
    detect: {
      packages: ['better-auth'],
    },
    repos: ['better-auth/skills'],
  },
  {
    id: 'turborepo',
    name: 'Turborepo',
    detect: {
      packages: ['turbo'],
      configFiles: ['turbo.json'],
    },
    repos: ['vercel/turborepo'],
  },
  {
    id: 'vite',
    name: 'Vite',
    detect: {
      packages: ['vite'],
      configFiles: ['vite.config.js', 'vite.config.ts', 'vite.config.mjs'],
    },
    repos: ['antfu/skills'],
  },
  {
    id: 'azure',
    name: 'Azure',
    detect: {
      packagePatterns: [/^@azure\//],
    },
    repos: ['microsoft/github-copilot-for-azure', 'microsoft/azure-skills'],
  },
  {
    id: 'vercel-ai',
    name: 'Vercel AI SDK',
    detect: {
      packages: ['ai', '@ai-sdk/openai', '@ai-sdk/anthropic', '@ai-sdk/google'],
    },
    repos: ['vercel/ai'],
  },
  {
    id: 'elevenlabs',
    name: 'ElevenLabs',
    detect: {
      packages: ['elevenlabs'],
    },
    repos: ['inferen-sh/skills'],
  },
  {
    id: 'vercel-deploy',
    name: 'Vercel',
    detect: {
      configFiles: ['vercel.json'],
      packages: ['vercel'],
    },
    repos: ['vercel-labs/agent-skills'],
  },
  {
    id: 'cloudflare',
    name: 'Cloudflare',
    detect: {
      packages: ['wrangler', '@cloudflare/workers-types'],
      configFiles: ['wrangler.toml', 'wrangler.json'],
    },
    repos: [],
  },
  {
    id: 'aws',
    name: 'AWS',
    detect: {
      packagePatterns: [/^@aws-sdk\//, /^aws-cdk/],
    },
    repos: [],
  },
  {
    id: 'swiftui',
    name: 'SwiftUI',
    detect: {
      configFiles: ['Package.swift'],
    },
    repos: ['avdlee/swiftui-agent-skill'],
  },
]

export const FRONTEND_PACKAGES = [
  'react', 'vue', 'svelte', 'astro', 'next', '@angular/core',
  'solid-js', 'lit', 'preact', 'nuxt', '@sveltejs/kit',
]

export const FRONTEND_BONUS_REPOS = [
  'anthropics/skills',
]

// ── Detection ─────────────────────────────────────────────────

export function readPackageJson(dir) {
  const pkgPath = join(dir, 'package.json')
  if (!existsSync(pkgPath)) return null
  try {
    return JSON.parse(readFileSync(pkgPath, 'utf-8'))
  } catch {
    return null
  }
}

export function getAllPackageNames(pkg) {
  if (!pkg) return []
  return [
    ...Object.keys(pkg.dependencies || {}),
    ...Object.keys(pkg.devDependencies || {}),
  ]
}

export function detectTechnologies(projectDir) {
  const pkg = readPackageJson(projectDir)
  const allPackages = getAllPackageNames(pkg)
  const detected = []

  for (const tech of SKILLS_MAP) {
    let found = false

    if (tech.detect.packages) {
      found = tech.detect.packages.some((p) => allPackages.includes(p))
    }

    if (!found && tech.detect.packagePatterns) {
      found = tech.detect.packagePatterns.some((pattern) =>
        allPackages.some((p) => pattern.test(p))
      )
    }

    if (!found && tech.detect.configFiles) {
      found = tech.detect.configFiles.some((f) =>
        existsSync(join(projectDir, f))
      )
    }

    if (found) {
      detected.push(tech)
    }
  }

  const isFrontend = allPackages.some((p) => FRONTEND_PACKAGES.includes(p))
  return { detected, isFrontend }
}

// ── Repo Collection ───────────────────────────────────────────

export function collectRepos(detected, isFrontend) {
  const seen = new Set()
  const repos = []

  for (const tech of detected) {
    for (const repo of tech.repos) {
      if (!seen.has(repo)) {
        seen.add(repo)
        repos.push({ repo, sources: [tech.name] })
      } else {
        const existing = repos.find((r) => r.repo === repo)
        if (existing && !existing.sources.includes(tech.name)) {
          existing.sources.push(tech.name)
        }
      }
    }
  }

  if (isFrontend) {
    for (const repo of FRONTEND_BONUS_REPOS) {
      if (!seen.has(repo)) {
        seen.add(repo)
        repos.push({ repo, sources: ['Frontend'] })
      }
    }
  }

  return repos
}
