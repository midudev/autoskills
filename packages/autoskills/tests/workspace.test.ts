import { describe, it } from "node:test";
import { ok, strictEqual, deepStrictEqual } from "node:assert/strict";
import { resolveWorkspaces, detectTechnologies } from "../lib.ts";
import { useTmpDir, writePackageJson, writeFile, writeJson, addWorkspace } from "./helpers.ts";

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
    strictEqual(resolveWorkspaces(tmp.path).length, 2);
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
    strictEqual(resolveWorkspaces(tmp.path).length, 2);
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

describe("detectTechnologies — informal multi-project directory fallback", () => {
  const tmp = useTmpDir();

  it("detects technologies from subdirs when root has no package.json", () => {
    addWorkspace(tmp.path, "frontend", {
      dependencies: { react: "18.0.0", "react-dom": "18.0.0" },
    });
    addWorkspace(tmp.path, "backend", {
      dependencies: { express: "4.18.0" },
    });

    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);

    ok(ids.includes("react"), "should detect React from frontend/");
  });

  it("detects technologies from subdirs when root package.json has no deps", () => {
    // Root has a bare package.json (name only, no deps).
    // Sub-projects sit directly inside the root — 1 level deep.
    writePackageJson(tmp.path, { name: "my-workspace" });
    addWorkspace(tmp.path, "web", {
      dependencies: { vue: "3.0.0" },
    });
    addWorkspace(tmp.path, "api", {
      dependencies: { express: "4.18.0" },
    });

    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);

    ok(ids.includes("vue"), "should detect Vue from web/");
  });

  it("does not trigger fallback when root already has detectable technologies", () => {
    writePackageJson(tmp.path, {
      dependencies: { react: "18.0.0", "react-dom": "18.0.0" },
    });
    addWorkspace(tmp.path, "sub", { dependencies: { vue: "3.0.0" } });

    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);

    ok(ids.includes("react"), "should detect React from root");
    ok(!ids.includes("vue"), "should NOT scan subdirs when root has detectable tech");
  });

  it("skips node_modules in the fallback scan", () => {
    writeJson(tmp.path, "node_modules/some-lib/package.json", {
      dependencies: { react: "18.0.0" },
    });

    const { detected } = detectTechnologies(tmp.path);
    strictEqual(detected.length, 0, "should not scan node_modules");
  });

  it("skips hidden directories in the fallback scan", () => {
    writeJson(tmp.path, ".hidden-project/package.json", {
      dependencies: { react: "18.0.0" },
    });

    const { detected } = detectTechnologies(tmp.path);
    strictEqual(detected.length, 0, "should not scan hidden directories");
  });

  it("merges technologies from multiple sub-projects without duplicates", () => {
    addWorkspace(tmp.path, "app-a", {
      dependencies: { react: "18.0.0" },
      devDependencies: { typescript: "5.0.0" },
    });
    addWorkspace(tmp.path, "app-b", {
      dependencies: { vue: "3.0.0" },
      devDependencies: { typescript: "5.0.0" },
    });

    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    const tsEntries = ids.filter((id) => id === "typescript");

    ok(ids.includes("react"), "should detect React");
    ok(ids.includes("vue"), "should detect Vue");
    strictEqual(tsEntries.length, 1, "TypeScript should appear exactly once");
  });
});