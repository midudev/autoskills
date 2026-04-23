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

function packagesFromShellFence(body: string): string[] {
  const pkgs: string[] = [];
  const re = /\b(?:npm|pnpm|yarn|bun)\s+(?:add|install|i)\s+([^\n]+)/g;
  let m: RegExpExecArray | null;
  while ((m = re.exec(body))) {
    // Stop at shell operators that chain another command
    const commandTail = m[1].split(/\s+(?:&&|\|\||;|\|)\s*/)[0];
    for (const tok of commandTail.split(/\s+/)) {
      if (!tok) continue;
      if (tok.startsWith("-")) continue;  // skip flags like --save-dev
      pkgs.push(tok);
    }
  }
  return pkgs;
}

function matchByPackages(pkgs: string[], map: readonly Technology[]): string[] {
  const ids: string[] = [];
  for (const tech of map) {
    const required = tech.detect.packages ?? [];
    if (required.length && required.some(p => pkgs.includes(p))) ids.push(tech.id);
  }
  return ids;
}

function matchByConfigContent(body: string, map: readonly Technology[]): string[] {
  const ids: string[] = [];
  for (const tech of map) {
    const raw = tech.detect.configFileContent;
    if (!raw) continue;
    const blocks = Array.isArray(raw) ? raw : [raw];
    const matched = blocks.some(block =>
      block.patterns.length > 0 && block.patterns.some(p => body.includes(p))
    );
    if (matched) ids.push(tech.id);
  }
  return ids;
}

function gemsFromRubyFence(body: string): string[] {
  const gems: string[] = [];
  const re = /^\s*gem\s+['"]([^'"]+)['"]/gm;
  let m: RegExpExecArray | null;
  while ((m = re.exec(body))) {
    gems.push(m[1]);
  }
  return gems;
}

function matchByGems(gems: string[], map: readonly Technology[]): string[] {
  const ids: string[] = [];
  for (const tech of map) {
    const required = tech.detect.gems ?? [];
    if (required.length && required.some(g => gems.includes(g))) ids.push(tech.id);
  }
  return ids;
}

const HEADING_RE = /^(#{1,3})\s+(Tech Stack|Stack|Dependencies|Built With|Technologies|Tecnolog[ií]as)\s*$/i;

function extractStackBlocks(content: string): { bullets: string[]; evidence: string }[] {
  const lines = content.split("\n");
  const blocks: { bullets: string[]; evidence: string }[] = [];
  for (let i = 0; i < lines.length; i++) {
    const m = lines[i].match(HEADING_RE);
    if (!m) continue;
    const level = m[1].length;
    const bullets: string[] = [];
    let j = i + 1;
    for (; j < lines.length; j++) {
      const hm = lines[j].match(/^(#{1,6})\s+/);
      if (hm && hm[1].length <= level) break;
      const bm = lines[j].match(/^\s*[-*+]\s+(.+)$/);
      if (bm) bullets.push(bm[1]);
    }
    blocks.push({ bullets, evidence: lines[i] });
    i = j - 1;
  }
  return blocks;
}

function normalizeBullet(raw: string): string {
  // 1. Drop parenthetical annotations
  // 2. Keep only the part before em-dash / en-dash / " - "
  // 3. Strip trailing version tokens (e.g. " 19", " 1.0.0")
  return raw
    .replace(/\([^)]*\)/g, "")
    .split(/\s+[—–-]\s+/)[0]
    .trim()
    .replace(/\s+\d[\w.]*$/, "")
    .trim();
}

function matchByName(phrase: string, map: readonly Technology[]): string | null {
  if (!phrase) return null;
  if (/^\d/.test(phrase)) return null; // version-only bullets
  const low = phrase.toLowerCase();
  for (const tech of map) {
    if (tech.name.toLowerCase() === low) return tech.id;
    if (tech.aliases?.some(a => a.toLowerCase() === low)) return tech.id;
  }
  return null;
}

export function scanMarkdown(content: string, skillsMap: readonly Technology[]): MarkdownMatch[] {
  const seen = new Set<string>();
  const matches: MarkdownMatch[] = [];
  const pushMatch = (techId: string, source: MarkdownMatch["source"], evidence: string) => {
    if (seen.has(techId)) return;
    seen.add(techId);
    matches.push({ techId, source, evidence });
  };

  for (const block of extractStackBlocks(content)) {
    for (const bullet of block.bullets) {
      const id = matchByName(normalizeBullet(bullet), skillsMap);
      if (id) {
        pushMatch(id, "stack-heading", [...("- " + bullet)].slice(0, 80).join(""));
      }
    }
  }

  for (const fence of extractFences(content)) {
    if (fence.lang === "json") {
      const pkgs = packagesFromJsonFence(fence.body);
      for (const id of matchByPackages(pkgs, skillsMap)) {
        pushMatch(id, "code-fence", [...fence.body].slice(0, 80).join(""));
      }
    }
    if (["bash", "sh", "shell", "zsh"].includes(fence.lang)) {
      const pkgs = packagesFromShellFence(fence.body);
      for (const id of matchByPackages(pkgs, skillsMap)) {
        const firstLine = fence.body.split("\n")[0];
        pushMatch(id, "code-fence", [...firstLine].slice(0, 80).join(""));
      }
    }

    if (["yaml", "yml", "toml"].includes(fence.lang)) {
      for (const id of matchByConfigContent(fence.body, skillsMap)) {
        pushMatch(id, "code-fence", [...fence.body].slice(0, 80).join(""));
      }
    }

    if (["ruby", "gemfile"].includes(fence.lang)) {
      const gems = gemsFromRubyFence(fence.body);
      for (const id of matchByGems(gems, skillsMap)) {
        pushMatch(id, "code-fence", [...fence.body].slice(0, 80).join(""));
      }
    }
    // dedupe + precedence finalized in T9
  }

  return matches;
}
