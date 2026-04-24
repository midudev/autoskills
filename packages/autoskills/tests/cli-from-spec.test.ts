import { describe, it } from "node:test";
import { equal, ok } from "node:assert/strict";
import { spawnSync } from "node:child_process";
import { resolve } from "node:path";
import { useTmpDir, writePackageJson, writeFile } from "./helpers.ts";

const CLI = resolve(import.meta.dirname!, "..", "index.mjs");

function run(args: string[], cwd: string): { stdout: string; stderr: string; status: number | null } {
  const result = spawnSync(process.execPath, [CLI, ...args], {
    cwd,
    encoding: "utf-8",
    timeout: 10_000,
    env: { ...process.env, NO_COLOR: "1" },
  });
  return { stdout: result.stdout ?? "", stderr: result.stderr ?? "", status: result.status };
}

describe("--from-spec / --scan-docs", () => {
  const tmp = useTmpDir();

  it("--from-spec adds tech detected in a markdown spec", () => {
    writePackageJson(tmp.path, { dependencies: { react: "^19" } });
    writeFile(tmp.path, "spec.md", "## Tech Stack\n- Tailwind CSS\n");
    const { stdout } = run(["--dry-run", "--from-spec", "./spec.md"], tmp.path);
    ok(stdout.toLowerCase().includes("react"));
    ok(stdout.toLowerCase().includes("tailwind"));
  });

  it("--scan-docs picks up CLAUDE.md", () => {
    writePackageJson(tmp.path, {});
    writeFile(tmp.path, "CLAUDE.md", "## Stack\n- Astro\n");
    const { stdout } = run(["--dry-run", "--scan-docs"], tmp.path);
    ok(stdout.toLowerCase().includes("astro"));
  });

  it("--scan-docs without docs prints warning, continues", () => {
    writePackageJson(tmp.path, { dependencies: { react: "^19" } });
    const { stdout, stderr } = run(["--dry-run", "--scan-docs"], tmp.path);
    ok(stdout.toLowerCase().includes("react"));
    ok(stderr.includes("no CLAUDE.md, AGENTS.md, or README.md found"), "expected warning in stderr, got: " + stderr);
  });

  it("--from-spec nonexistent exits 1 with clear error", () => {
    writePackageJson(tmp.path, {});
    const { stderr, status } = run(["--dry-run", "--from-spec", "./missing.md"], tmp.path);
    ok(stderr.includes("spec file not found"), "expected 'spec file not found' in stderr, got: " + stderr);
    equal(status, 1);
  });

  it("--from-spec without a value exits 1 with clear error", () => {
    writePackageJson(tmp.path, {});
    const { stderr, status } = run(["--dry-run", "--from-spec"], tmp.path);
    ok(stderr.includes("--from-spec requires a path argument"), "expected arg-validation error, got: " + stderr);
    equal(status, 1);
  });

  it("REGRESSION: default autoskills with CLAUDE.md does NOT read it", () => {
    writePackageJson(tmp.path, { dependencies: { react: "^19" } });
    writeFile(tmp.path, "CLAUDE.md", "## Stack\n- Astro\n");
    const { stdout } = run(["--dry-run"], tmp.path);
    ok(stdout.toLowerCase().includes("react"));
    ok(!stdout.toLowerCase().includes("astro"), "Astro leaked into default flow — opt-in guarantee broken");
  });
});
