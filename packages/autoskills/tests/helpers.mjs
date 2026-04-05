import { mkdtempSync, mkdirSync, writeFileSync, rmSync } from "node:fs";
import { join, dirname } from "node:path";
import { tmpdir } from "node:os";
import { beforeEach, afterEach } from "node:test";

/**
 * Registers beforeEach/afterEach hooks that create and clean up a temp directory.
 * Must be called inside a describe() block.
 *
 * @returns {{ path: string }} Object whose `.path` is the current temp directory.
 */
export function useTmpDir(prefix = "autoskills-") {
  const ctx = { path: "" };
  beforeEach(() => {
    ctx.path = mkdtempSync(join(tmpdir(), prefix));
  });

  afterEach(() => {
    rmSync(ctx.path, { recursive: true, force: true });
  });

  return ctx;
}

/**
 * Writes a package.json at the root of `dir`.
 */
export function writePackageJson(dir, data = {}) {
  writeFileSync(join(dir, "package.json"), JSON.stringify(data));
}

/**
 * Writes a JSON file at `relativePath` inside `dir`, creating parent dirs as needed.
 */
export function writeJson(dir, relativePath, data) {
  const fullPath = join(dir, relativePath);
  mkdirSync(dirname(fullPath), { recursive: true });
  writeFileSync(fullPath, JSON.stringify(data));
}

/**
 * Writes a text file at `relativePath` inside `dir`, creating parent dirs as needed.
 */
export function writeFile(dir, relativePath, content = "") {
  const fullPath = join(dir, relativePath);
  mkdirSync(dirname(fullPath), { recursive: true });
  writeFileSync(fullPath, content);
}

/**
 * Creates a workspace sub-package with its own package.json.
 * Example: addWorkspace(root, "packages/ui", { dependencies: { react: "^19" } })
 */
export function addWorkspace(rootDir, workspacePath, packageJson = {}) {
  const fullPath = join(rootDir, workspacePath);
  mkdirSync(fullPath, { recursive: true });
  writeFileSync(join(fullPath, "package.json"), JSON.stringify(packageJson));
}
