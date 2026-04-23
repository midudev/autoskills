import type { Technology } from "./skills-map.ts";

export interface MarkdownMatch {
  techId: string;
  source: "code-fence" | "stack-heading";
  evidence: string;
}

interface CodeFence { lang: string; body: string; line: number }

function extractFences(content: string): CodeFence[] {
  const fences: CodeFence[] = [];
  const lines = content.split("\n");
  let i = 0;
  while (i < lines.length) {
    const m = lines[i].match(/^```(\S+)?\s*$/);
    if (m) {
      const lang = (m[1] ?? "").toLowerCase();
      const start = i + 1;
      i++;
      while (i < lines.length && !/^```\s*$/.test(lines[i])) i++;
      fences.push({ lang, body: lines.slice(start, i).join("\n"), line: start });
    }
    i++;
  }
  return fences;
}

function packagesFromJsonFence(body: string): string[] {
  try {
    const obj = JSON.parse(body);
    const deps = { ...(obj.dependencies ?? {}), ...(obj.devDependencies ?? {}) };
    return Object.keys(deps);
  } catch {
    return [];
  }
}

function matchByPackages(pkgs: string[], map: readonly Technology[]): string[] {
  const ids: string[] = [];
  for (const tech of map) {
    const required = tech.detect.packages ?? [];
    if (required.length && required.some(p => pkgs.includes(p))) ids.push(tech.id);
  }
  return ids;
}

export function scanMarkdown(content: string, skillsMap: readonly Technology[]): MarkdownMatch[] {
  const seen = new Set<string>();
  const matches: MarkdownMatch[] = [];
  const pushMatch = (techId: string, source: MarkdownMatch["source"], evidence: string) => {
    if (seen.has(techId)) return;
    seen.add(techId);
    matches.push({ techId, source, evidence });
  };

  for (const fence of extractFences(content)) {
    if (fence.lang === "json") {
      const pkgs = packagesFromJsonFence(fence.body);
      for (const id of matchByPackages(pkgs, skillsMap)) {
        pushMatch(id, "code-fence", [...fence.body].slice(0, 80).join(""));
      }
    }
    // bash / yaml / ruby / headings added in later tasks (T6-T9)
  }

  return matches;
}
