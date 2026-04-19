import { mkdtempSync, mkdirSync, writeFileSync, rmSync } from "node:fs";
import { join, dirname } from "node:path";
import { tmpdir } from "node:os";
import { beforeEach, afterEach } from "node:test";

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
