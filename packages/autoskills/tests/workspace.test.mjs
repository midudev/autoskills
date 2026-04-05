import { describe, it } from "node:test";
import { ok, strictEqual, deepStrictEqual } from "node:assert/strict";
import { resolveWorkspaces } from "../lib.mjs";
import { useTmpDir, writePackageJson, writeFile, writeJson, addWorkspace } from "./helpers.mjs";

describe("resolveWorkspaces", () => {
  const tmp = useTmpDir();

  it("returns empty array for non-monorepo project", () => {
    writePackageJson(tmp.path, { name: "single" });
    deepStrictEqual(resolveWorkspaces(tmp.path), []);
  });

  it("returns empty array when no package.json exists", () => {
    deepStrictEqual(resolveWorkspaces(tmp.path), []);
  });

  it("detects npm/yarn workspaces (array format)", () => {
    writePackageJson(tmp.path, { workspaces: ["packages/*"] });
    addWorkspace(tmp.path, "packages/app-a");
    addWorkspace(tmp.path, "packages/app-b");

    const result = resolveWorkspaces(tmp.path);
    strictEqual(result.length, 2);
    ok(result.some((d) => d.includes("app-a")));
    ok(result.some((d) => d.includes("app-b")));
  });

  it("detects npm/yarn workspaces (object format with packages key)", () => {
    writePackageJson(tmp.path, { workspaces: { packages: ["packages/*"] } });
    addWorkspace(tmp.path, "packages/lib");

    const result = resolveWorkspaces(tmp.path);
    strictEqual(result.length, 1);
    ok(result[0].includes("lib"));
  });

  it("detects pnpm-workspace.yaml", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "pnpm-workspace.yaml", "packages:\n  - packages/*\n  - apps/*\n");
    addWorkspace(tmp.path, "packages/ui");
    addWorkspace(tmp.path, "apps/web");

    const result = resolveWorkspaces(tmp.path);
    strictEqual(result.length, 2);
    ok(result.some((d) => d.includes("ui")));
    ok(result.some((d) => d.includes("web")));
  });

  it("pnpm-workspace.yaml takes precedence over package.json workspaces", () => {
    writePackageJson(tmp.path, { workspaces: ["other/*"] });
    writeFile(tmp.path, "pnpm-workspace.yaml", "packages:\n  - packages/*\n");
    addWorkspace(tmp.path, "packages/core");
    addWorkspace(tmp.path, "other/ignored");

    const result = resolveWorkspaces(tmp.path);
    strictEqual(result.length, 1);
    ok(result[0].includes("core"));
  });

  it("skips directories without package.json", () => {
    writePackageJson(tmp.path, { workspaces: ["packages/*"] });
    addWorkspace(tmp.path, "packages/has-pkg");
    writeFile(tmp.path, "packages/no-pkg/.gitkeep");

    const result = resolveWorkspaces(tmp.path);
    strictEqual(result.length, 1);
    ok(result[0].includes("has-pkg"));
  });

  it("skips SCAN_SKIP_DIRS like node_modules", () => {
    writePackageJson(tmp.path, { workspaces: ["packages/*"] });
    addWorkspace(tmp.path, "packages/node_modules");
    addWorkspace(tmp.path, "packages/real-pkg");

    const result = resolveWorkspaces(tmp.path);
    strictEqual(result.length, 1);
    ok(result[0].includes("real-pkg"));
  });

  it("handles multiple patterns", () => {
    writePackageJson(tmp.path, { workspaces: ["packages/*", "apps/*", "tools/*"] });
    addWorkspace(tmp.path, "packages/ui");
    addWorkspace(tmp.path, "apps/web");

    const result = resolveWorkspaces(tmp.path);
    strictEqual(result.length, 2);
  });

  it("handles exact directory references (no glob)", () => {
    writePackageJson(tmp.path, { workspaces: ["tools/special-tool"] });
    addWorkspace(tmp.path, "tools/special-tool");

    const result = resolveWorkspaces(tmp.path);
    strictEqual(result.length, 1);
    ok(result[0].includes("special-tool"));
  });

  it("handles pnpm-workspace.yaml with quoted patterns", () => {
    writeFile(tmp.path, "pnpm-workspace.yaml", "packages:\n  - 'packages/*'\n  - \"apps/*\"\n");
    addWorkspace(tmp.path, "packages/a");
    addWorkspace(tmp.path, "apps/b");

    const result = resolveWorkspaces(tmp.path);
    strictEqual(result.length, 2);
  });

  it("returns empty for pnpm-workspace.yaml without packages key", () => {
    writeFile(tmp.path, "pnpm-workspace.yaml", "# empty config\nsome_other_key:\n  - foo\n");
    deepStrictEqual(resolveWorkspaces(tmp.path), []);
  });

  it("returns empty for empty workspaces array", () => {
    writePackageJson(tmp.path, { workspaces: [] });
    deepStrictEqual(resolveWorkspaces(tmp.path), []);
  });

  it("detects Deno workspace members from deno.json", () => {
    writeJson(tmp.path, "deno.json", { workspace: ["./api", "./shared"] });
    writeJson(tmp.path, "api/deno.json", {});
    writeJson(tmp.path, "shared/deno.json", {});

    const result = resolveWorkspaces(tmp.path);
    strictEqual(result.length, 2);
    ok(result.some((d) => d.includes("api")));
    ok(result.some((d) => d.includes("shared")));
  });

  it("Deno workspace members with deno.jsonc are detected", () => {
    writeJson(tmp.path, "deno.json", { workspace: ["./lib"] });
    writeJson(tmp.path, "lib/deno.jsonc", {});

    const result = resolveWorkspaces(tmp.path);
    strictEqual(result.length, 1);
    ok(result[0].includes("lib"));
  });

  it("pnpm-workspace.yaml takes precedence over deno.json workspace", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "pnpm-workspace.yaml", "packages:\n  - packages/*\n");
    writeJson(tmp.path, "deno.json", { workspace: ["./deno-member"] });
    addWorkspace(tmp.path, "packages/core");
    writeJson(tmp.path, "deno-member/deno.json", {});

    const result = resolveWorkspaces(tmp.path);
    strictEqual(result.length, 1);
    ok(result[0].includes("core"));
  });

  it("package.json workspaces take precedence over deno.json workspace", () => {
    writePackageJson(tmp.path, { workspaces: ["packages/*"] });
    writeJson(tmp.path, "deno.json", { workspace: ["./deno-member"] });
    addWorkspace(tmp.path, "packages/ui");
    writeJson(tmp.path, "deno-member/deno.json", {});

    const result = resolveWorkspaces(tmp.path);
    strictEqual(result.length, 1);
    ok(result[0].includes("ui"));
  });
});
