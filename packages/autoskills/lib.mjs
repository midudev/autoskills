import { readFileSync, existsSync } from "node:fs";
import { join } from "node:path";

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
    skills: [],
  },
  {
    id: "angular",
    name: "Angular",
    detect: {
      packages: ["@angular/core"],
      configFiles: ["angular.json"],
    },
    skills: [],
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
    skills: ["wshobson/agents/tailwind-design-system"],
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
    id: "remotion",
    name: "Remotion",
    detect: {
      packages: ["remotion", "@remotion/cli"],
    },
    skills: ["remotion-dev/skills/remotion-best-practices"],
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
      configFiles: ["vercel.json"],
      packages: ["vercel"],
    },
    skills: ["vercel-labs/agent-skills/deploy-to-vercel"],
  },
  {
    id: "cloudflare",
    name: "Cloudflare",
    detect: {
      packages: ["wrangler", "@cloudflare/workers-types"],
      configFiles: ["wrangler.toml", "wrangler.json"],
    },
    skills: [],
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
];

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

export const FRONTEND_BONUS_SKILLS = ["anthropics/skills/frontend-design"];

// ── Detection ─────────────────────────────────────────────────

export function readPackageJson(dir) {
  const pkgPath = join(dir, "package.json");
  if (!existsSync(pkgPath)) return null;
  try {
    return JSON.parse(readFileSync(pkgPath, "utf-8"));
  } catch {
    return null;
  }
}

export function getAllPackageNames(pkg) {
  if (!pkg) return [];
  return [...Object.keys(pkg.dependencies || {}), ...Object.keys(pkg.devDependencies || {})];
}

export function detectTechnologies(projectDir) {
  const pkg = readPackageJson(projectDir);
  const allPackages = getAllPackageNames(pkg);
  const detected = [];

  for (const tech of SKILLS_MAP) {
    let found = false;

    if (tech.detect.packages) {
      found = tech.detect.packages.some((p) => allPackages.includes(p));
    }

    if (!found && tech.detect.packagePatterns) {
      found = tech.detect.packagePatterns.some((pattern) =>
        allPackages.some((p) => pattern.test(p)),
      );
    }

    if (!found && tech.detect.configFiles) {
      found = tech.detect.configFiles.some((f) => existsSync(join(projectDir, f)));
    }

    if (found) {
      detected.push(tech);
    }
  }

  const isFrontend = allPackages.some((p) => FRONTEND_PACKAGES.includes(p));

  const detectedIds = detected.map((t) => t.id);
  const combos = detectCombos(detectedIds);

  return { detected, isFrontend, combos };
}

export function detectCombos(detectedIds) {
  return COMBO_SKILLS_MAP.filter((combo) => combo.requires.every((id) => detectedIds.includes(id)));
}

// ── Helpers ──────────────────────────────────────────────────

export function parseSkillPath(skill) {
  const parts = skill.split("/");
  return {
    repo: parts.slice(0, 2).join("/"),
    skillName: parts.slice(2).join("/"),
    full: skill,
  };
}

// ── Skill Collection ─────────────────────────────────────────

export function collectSkills(detected, isFrontend, combos = []) {
  const seen = new Set();
  const skills = [];

  function addSkill(skill, source) {
    if (!seen.has(skill)) {
      seen.add(skill);
      skills.push({ skill, sources: [source] });
    } else {
      const existing = skills.find((s) => s.skill === skill);
      if (existing && !existing.sources.includes(source)) {
        existing.sources.push(source);
      }
    }
  }

  for (const tech of detected) {
    for (const skill of tech.skills) {
      addSkill(skill, tech.name);
    }
  }

  for (const combo of combos) {
    for (const skill of combo.skills) {
      addSkill(skill, combo.name);
    }
  }

  if (isFrontend) {
    for (const skill of FRONTEND_BONUS_SKILLS) {
      addSkill(skill, "Frontend");
    }
  }

  return skills;
}
