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

export function normalizeHeadingTitle(raw: string): string {
  let s = raw.trim();
  // 1. Strip leading numbering: "2." / "1)" / "3 -" / "2:"
  s = s.replace(/^\d+\s*[.)\-:]\s+/, "");
  // 2. Strip leading non-letter decoration (emoji, punctuation) — stop at letter, *, _, [
  s = s.replace(/^[^\p{L}*_\[]+/u, "");
  // 3. Strip trailing non-letter/non-closer decoration — keep closing ) and ] so step 5 handles them
  s = s.replace(/[^\p{L}\p{N}*_)\]]+$/u, "");
  // 4. Unwrap bracket / bold / italic wrappers (single pass each, outermost first)
  s = s.replace(/^\[(.+)\]$/, "$1");
  s = s.replace(/^\*\*(.+)\*\*$/, "$1");
  s = s.replace(/^__(.+)__$/, "$1");
  s = s.replace(/^\*(.+)\*$/, "$1");
  s = s.replace(/^_(.+)_$/, "$1");
  // 5. Strip trailing paren annotation "(frontend)"
  s = s.replace(/\s*\([^)]*\)\s*$/, "");
  // 6. Strip trailing colon
  s = s.replace(/\s*:\s*$/, "");
  return s.trim();
}

const HEADING_LINE_RE = /^(#{1,3})\s+(.+?)\s*$/;
const STACK_KEYWORDS = new Set([
  "tech stack",
  "stack",
  "dependencies",
  "built with",
  "technologies",
  "tecnologías",
  "tecnologias",
]);

function isStackHeading(line: string): { level: number } | null {
  const m = line.match(HEADING_LINE_RE);
  if (!m) return null;
  const normalized = normalizeHeadingTitle(m[2]).toLowerCase();
  if (!STACK_KEYWORDS.has(normalized)) return null;
  return { level: m[1].length };
}

function extractStackBlocks(content: string): {
  bullets: string[];
  inlines: string[];
  tables: ParsedTable[];
  evidence: string;
}[] {
  const lines = content.split("\n");
  const blocks: {
    bullets: string[];
    inlines: string[];
    tables: ParsedTable[];
    evidence: string;
  }[] = [];
  for (let i = 0; i < lines.length; i++) {
    const heading = isStackHeading(lines[i]);
    if (!heading) continue;
    const level = heading.level;
    const bullets: string[] = [];
    const inlines: string[] = [];
    const tables: ParsedTable[] = [];
    let j = i + 1;
    while (j < lines.length) {
      const hm = lines[j].match(/^(#{1,6})\s+/);
      if (hm && hm[1].length <= level) break;
      const bm = lines[j].match(/^\s*(?:[-*+]|\d+[.)])\s+(.+)$/);
      if (bm) {
        bullets.push(bm[1]);
        j++;
        continue;
      }
      const tableAttempt = tryParseTable(lines, j);
      if (tableAttempt) {
        tables.push(tableAttempt.table);
        j = tableAttempt.end;
        continue;
      }
      const trimmed = lines[j].trim();
      if (trimmed && trimmed.includes(",")) {
        inlines.push(trimmed);
      }
      j++;
    }
    blocks.push({ bullets, inlines, tables, evidence: lines[i] });
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

const TABLE_SEP_RE = /^\|?\s*:?-{3,}:?\s*(\|\s*:?-{3,}:?\s*)*\|?\s*$/;

function splitRow(line: string): string[] {
  let s = line.trim();
  if (s.startsWith("|")) s = s.slice(1);
  if (s.endsWith("|")) s = s.slice(0, -1);
  return s.split(/(?<!\\)\|/).map(c => c.replace(/\\\|/g, "|").trim());
}

function normalizeCell(raw: string): string {
  let s = raw;
  // Strip images: ![alt](url)
  s = s.replace(/!\[[^\]]*\]\([^)]*\)/g, "");
  // Unwrap links: [text](url) -> text
  s = s.replace(/\[([^\]]+)\]\([^)]*\)/g, "$1");
  // Strip backticks
  s = s.replace(/`([^`]+)`/g, "$1");
  // Unwrap bold/italic
  s = s.replace(/\*\*([^*]+)\*\*/g, "$1");
  s = s.replace(/__([^_]+)__/g, "$1");
  s = s.replace(/\*([^*]+)\*/g, "$1");
  s = s.replace(/_([^_]+)_/g, "$1");
  // Strip leading/trailing emoji + whitespace
  s = s.replace(/^[^\p{L}\p{N}]+/u, "");
  s = s.replace(/[^\p{L}\p{N}+./#)]+$/u, "");
  return s.trim();
}

const TECH_COLUMN_KEYWORDS = /\b(tech|technology|technologies|framework|library|libraries|package|packages|dependency|dependencies|name|stack)\b/i;

function pickTechColumn(headerCells: string[]): number {
  for (let i = 0; i < headerCells.length; i++) {
    if (TECH_COLUMN_KEYWORDS.test(headerCells[i])) return i;
  }
  return 0;
}

interface ParsedTable { headerCells: string[]; rows: string[][] }

function tryParseTable(lines: string[], start: number): { table: ParsedTable; end: number } | null {
  const header = lines[start];
  if (!header || !/\|/.test(header)) return null;
  const sep = lines[start + 1];
  if (!sep || !TABLE_SEP_RE.test(sep)) return null;
  const headerCells = splitRow(header);
  const rows: string[][] = [];
  let j = start + 2;
  for (; j < lines.length; j++) {
    const line = lines[j];
    if (!line.trim()) break;
    if (!line.includes("|")) break;
    rows.push(splitRow(line));
  }
  return { table: { headerCells, rows }, end: j };
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
    for (const inline of block.inlines) {
      for (const piece of inline.split(",").map(s => s.trim())) {
        const id = matchByName(normalizeBullet(piece), skillsMap);
        if (id) {
          pushMatch(id, "stack-heading", [...piece].slice(0, 80).join(""));
        }
      }
    }
    for (const table of block.tables) {
      const col = pickTechColumn(table.headerCells);
      for (const row of table.rows) {
        const cell = row[col] ?? "";
        const normalized = normalizeCell(cell);
        for (const piece of normalized.split(",").map(s => s.trim()).filter(Boolean)) {
          const id = matchByName(normalizeBullet(piece), skillsMap);
          if (id) {
            pushMatch(id, "stack-heading", [...piece].slice(0, 80).join(""));
          }
        }
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
