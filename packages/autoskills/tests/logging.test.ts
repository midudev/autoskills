import { describe, it } from "node:test";
import { equal, ok } from "node:assert/strict";
import { spawnSync } from "node:child_process";
import { resolve } from "node:path";
import { useTmpDir, writePackageJson } from "./helpers.ts";

const CLI = resolve(import.meta.dirname!, "..", "index.mjs");

function run(args: string[], cwd: string) {
  const r = spawnSync(process.execPath, [CLI, ...args], {
    cwd,
    encoding: "utf-8",
    timeout: 15_000,
    env: { ...process.env, NO_COLOR: "1" },
  });
  return { stdout: r.stdout ?? "", stderr: r.stderr ?? "", status: r.status };
}

describe("logging / verbosity", () => {
  const tmp = useTmpDir();

  it("--json on subcommand does not produce human banner in stdout", () => {
    writePackageJson(tmp.path, {});
    const { stdout, status } = run(["list", "--json"], tmp.path);
    equal(status, 0);
    // stdout should start with '{' (JSON), not the ASCII banner
    ok(stdout.trimStart().startsWith("{"));
  });

  it("default dry-run (no --json) prints human-readable output with banner", () => {
    writePackageJson(tmp.path, { dependencies: { react: "^19" } });
    const { stdout, status } = run(["--dry-run"], tmp.path);
    equal(status, 0);
    // some banner / detection text should be present
    ok(stdout.length > 10);
    ok(stdout.toLowerCase().includes("react"));
  });

  it("--dry-run --json emits ONLY json on stdout (no banner)", () => {
    writePackageJson(tmp.path, { dependencies: { react: "^19" } });
    const { stdout, status } = run(["--dry-run", "--json"], tmp.path);
    equal(status, 0);
    const trimmed = stdout.trimStart();
    ok(trimmed.startsWith("{"), "stdout should start with '{' for JSON, got: " + trimmed.slice(0, 40));
  });
});
