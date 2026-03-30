import { describe, it, beforeEach, afterEach } from "node:test";
import assert from "node:assert/strict";
import { mkdtempSync, mkdirSync, writeFileSync, rmSync } from "node:fs";
import { join } from "node:path";
import { tmpdir } from "node:os";
import { resolveWorkspaces } from "../lib.mjs";

describe("resolveWorkspaces", () => {
  let tmpDir;

  beforeEach(() => {
    tmpDir = mkdtempSync(join(tmpdir(), "autoskills-ws-"));
  });

  afterEach(() => {
    rmSync(tmpDir, { recursive: true, force: true });
  });

  it("returns empty array for non-monorepo project", () => {
    writeFileSync(join(tmpDir, "package.json"), JSON.stringify({ name: "single" }));
    assert.deepStrictEqual(resolveWorkspaces(tmpDir), []);
  });

  it("returns empty array when no package.json exists", () => {
    assert.deepStrictEqual(resolveWorkspaces(tmpDir), []);
  });

  it("detects npm/yarn workspaces (array format)", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ workspaces: ["packages/*"] }),
    );
    mkdirSync(join(tmpDir, "packages", "app-a"), { recursive: true });
    writeFileSync(join(tmpDir, "packages", "app-a", "package.json"), "{}");
    mkdirSync(join(tmpDir, "packages", "app-b"), { recursive: true });
    writeFileSync(join(tmpDir, "packages", "app-b", "package.json"), "{}");

    const result = resolveWorkspaces(tmpDir);
    assert.strictEqual(result.length, 2);
    assert.ok(result.some((d) => d.includes("app-a")));
    assert.ok(result.some((d) => d.includes("app-b")));
  });

  it("detects npm/yarn workspaces (object format with packages key)", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ workspaces: { packages: ["packages/*"] } }),
    );
    mkdirSync(join(tmpDir, "packages", "lib"), { recursive: true });
    writeFileSync(join(tmpDir, "packages", "lib", "package.json"), "{}");

    const result = resolveWorkspaces(tmpDir);
    assert.strictEqual(result.length, 1);
    assert.ok(result[0].includes("lib"));
  });

  it("detects pnpm-workspace.yaml", () => {
    writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
    writeFileSync(join(tmpDir, "pnpm-workspace.yaml"), "packages:\n  - packages/*\n  - apps/*\n");
    mkdirSync(join(tmpDir, "packages", "ui"), { recursive: true });
    writeFileSync(join(tmpDir, "packages", "ui", "package.json"), "{}");
    mkdirSync(join(tmpDir, "apps", "web"), { recursive: true });
    writeFileSync(join(tmpDir, "apps", "web", "package.json"), "{}");

    const result = resolveWorkspaces(tmpDir);
    assert.strictEqual(result.length, 2);
    assert.ok(result.some((d) => d.includes("ui")));
    assert.ok(result.some((d) => d.includes("web")));
  });

  it("pnpm-workspace.yaml takes precedence over package.json workspaces", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ workspaces: ["other/*"] }),
    );
    writeFileSync(join(tmpDir, "pnpm-workspace.yaml"), "packages:\n  - packages/*\n");
    mkdirSync(join(tmpDir, "packages", "core"), { recursive: true });
    writeFileSync(join(tmpDir, "packages", "core", "package.json"), "{}");
    mkdirSync(join(tmpDir, "other", "ignored"), { recursive: true });
    writeFileSync(join(tmpDir, "other", "ignored", "package.json"), "{}");

    const result = resolveWorkspaces(tmpDir);
    assert.strictEqual(result.length, 1);
    assert.ok(result[0].includes("core"));
  });

  it("skips directories without package.json", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ workspaces: ["packages/*"] }),
    );
    mkdirSync(join(tmpDir, "packages", "has-pkg"), { recursive: true });
    writeFileSync(join(tmpDir, "packages", "has-pkg", "package.json"), "{}");
    mkdirSync(join(tmpDir, "packages", "no-pkg"), { recursive: true });

    const result = resolveWorkspaces(tmpDir);
    assert.strictEqual(result.length, 1);
    assert.ok(result[0].includes("has-pkg"));
  });

  it("skips SCAN_SKIP_DIRS like node_modules", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ workspaces: ["packages/*"] }),
    );
    mkdirSync(join(tmpDir, "packages", "node_modules"), { recursive: true });
    writeFileSync(join(tmpDir, "packages", "node_modules", "package.json"), "{}");
    mkdirSync(join(tmpDir, "packages", "real-pkg"), { recursive: true });
    writeFileSync(join(tmpDir, "packages", "real-pkg", "package.json"), "{}");

    const result = resolveWorkspaces(tmpDir);
    assert.strictEqual(result.length, 1);
    assert.ok(result[0].includes("real-pkg"));
  });

  it("handles multiple patterns", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ workspaces: ["packages/*", "apps/*", "tools/*"] }),
    );
    mkdirSync(join(tmpDir, "packages", "ui"), { recursive: true });
    writeFileSync(join(tmpDir, "packages", "ui", "package.json"), "{}");
    mkdirSync(join(tmpDir, "apps", "web"), { recursive: true });
    writeFileSync(join(tmpDir, "apps", "web", "package.json"), "{}");
    // tools/ dir doesn't exist — should not error

    const result = resolveWorkspaces(tmpDir);
    assert.strictEqual(result.length, 2);
  });

  it("handles exact directory references (no glob)", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ workspaces: ["tools/special-tool"] }),
    );
    mkdirSync(join(tmpDir, "tools", "special-tool"), { recursive: true });
    writeFileSync(join(tmpDir, "tools", "special-tool", "package.json"), "{}");

    const result = resolveWorkspaces(tmpDir);
    assert.strictEqual(result.length, 1);
    assert.ok(result[0].includes("special-tool"));
  });

  it("handles pnpm-workspace.yaml with quoted patterns", () => {
    writeFileSync(join(tmpDir, "pnpm-workspace.yaml"), "packages:\n  - 'packages/*'\n  - \"apps/*\"\n");
    mkdirSync(join(tmpDir, "packages", "a"), { recursive: true });
    writeFileSync(join(tmpDir, "packages", "a", "package.json"), "{}");
    mkdirSync(join(tmpDir, "apps", "b"), { recursive: true });
    writeFileSync(join(tmpDir, "apps", "b", "package.json"), "{}");

    const result = resolveWorkspaces(tmpDir);
    assert.strictEqual(result.length, 2);
  });

  it("returns empty for pnpm-workspace.yaml without packages key", () => {
    writeFileSync(join(tmpDir, "pnpm-workspace.yaml"), "# empty config\nsome_other_key:\n  - foo\n");
    assert.deepStrictEqual(resolveWorkspaces(tmpDir), []);
  });

  it("returns empty for empty workspaces array", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ workspaces: [] }),
    );
    assert.deepStrictEqual(resolveWorkspaces(tmpDir), []);
  });
});
