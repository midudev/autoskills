import { mkdtempSync, mkdirSync, writeFileSync, readFileSync, rmSync } from "node:fs";
import { join, dirname, resolve } from "node:path";
import { tmpdir } from "node:os";
import { fileURLToPath } from "node:url";
import { beforeEach, afterEach } from "node:test";

const HELPERS_DIR = dirname(fileURLToPath(import.meta.url));

export function useTmpDir(prefix: string = "autoskills-"): { path: string } {
  const ctx = { path: "" };
  beforeEach(() => {
    ctx.path = mkdtempSync(join(tmpdir(), prefix));
  });

  afterEach(() => {
    rmSync(ctx.path, { recursive: true, force: true });
  });

  return ctx;
}

export function writePackageJson(dir: string, data: Record<string, unknown> = {}): void {
  writeFileSync(join(dir, "package.json"), JSON.stringify(data));
}

export function writeJson(dir: string, relativePath: string, data: unknown): void {
  const fullPath = join(dir, relativePath);
  mkdirSync(dirname(fullPath), { recursive: true });
  writeFileSync(fullPath, JSON.stringify(data));
}

export function writeFile(dir: string, relativePath: string, content: string = ""): void {
  const fullPath = join(dir, relativePath);
  mkdirSync(dirname(fullPath), { recursive: true });
  writeFileSync(fullPath, content);
}

export function addWorkspace(
  rootDir: string,
  workspacePath: string,
  packageJson: Record<string, unknown> = {},
): void {
  const fullPath = join(rootDir, workspacePath);
  mkdirSync(fullPath, { recursive: true });
  writeFileSync(join(fullPath, "package.json"), JSON.stringify(packageJson));
}

export function writeMarkdown(dir: string, name: string, content: string): string {
  const p = resolve(dir, name);
  writeFileSync(p, content);
  return p;
}

export function readFixtureSpec(name: string): string {
  return readFileSync(join(HELPERS_DIR, "fixtures", "specs", name), "utf-8");
}

export function parseJsonOutput(stdout: string): unknown {
  const trimmed = stdout.trimEnd();
  const lines = trimmed.split("\n");
  for (let j = lines.length - 1; j >= 0; j--) {
    const t = lines[j].trimStart();
    if (t.startsWith("{") || t.startsWith("[")) {
      return JSON.parse(lines.slice(j).join("\n"));
    }
  }
  throw new Error("no JSON found in stdout");
}

export interface Fence { lang: string; body: string }
export interface Heading { level: 1 | 2 | 3; title: string; bullets: string[] }

export function buildMarkdownFromParts(opts: { fences?: Fence[]; headings?: Heading[] }): string {
  const parts: string[] = [];
  for (const h of opts.headings ?? []) {
    parts.push(`${"#".repeat(h.level)} ${h.title}`, "", ...h.bullets.map(b => `- ${b}`), "");
  }
  for (const f of opts.fences ?? []) {
    parts.push("```" + f.lang, f.body, "```", "");
  }
  return parts.join("\n");
}

export interface MockInstallerResult { success: boolean; output?: string; stderr?: string }
export interface MockInstaller {
  installSkill: (path: string, agents: string[]) => Promise<MockInstallerResult & { command: string; exitCode: number | null }>;
  calls: Array<{ path: string; agents: string[] }>;
}

export function mockInstaller(behavior: MockInstallerResult | ((path: string) => MockInstallerResult)): MockInstaller {
  const calls: Array<{ path: string; agents: string[] }> = [];
  return {
    calls,
    async installSkill(path, agents) {
      calls.push({ path, agents });
      const r = typeof behavior === "function" ? behavior(path) : behavior;
      return { ...r, command: "mock", exitCode: r.success ? 0 : 1, output: r.output ?? "", stderr: r.stderr ?? "" };
    },
  };
}
