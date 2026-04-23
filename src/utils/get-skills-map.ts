export async function getSkillsMap() {
  const { SKILLS_MAP } = await import("../../packages/autoskills/skills-map.ts");

  const popularityOrder = [
    "typescript",
    "zod",
    "react-hook-form",
    "react",
    "nextjs",
    "node",
    "tailwind",
    "vue",
    "angular",
    "vite",
    "astro",
    "nuxt",
    "svelte",
    "expo",
    "react-native",
    "bun",
    "deno",
    "supabase",
    "cloudflare",
    "cloudflare-agents",
    "cloudflare-durable-objects",
    "cloudflare-ai",
    "terraform",
    "vercel-deploy",
    "vercel-ai",
    "shadcn",
    "playwright",
    "turborepo",
    "better-auth",
    "clerk",
    "pinia",
    "neon",
    "remotion",
    "gsap",
    "oxlint",
    "express",
    "go",
    "swiftui",
    "azure",
    "aws",
    "elevenlabs",
    "kotlin-multiplatform",
    "android",
    "java",
    "springboot",
    "threejs",
  ];

  const skillsMap = [...SKILLS_MAP].sort((a: any, b: any) => {
    const ai = popularityOrder.indexOf(a.id);
    const bi = popularityOrder.indexOf(b.id);
    return (ai === -1 ? Infinity : ai) - (bi === -1 ? Infinity : bi);
  });

  return { skillsMap }

}