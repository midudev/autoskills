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

describe("error taxonomy", () => {
  const tmp = useTmpDir();

  it("spec-file-not-found (via --from-spec)", () => {
    writePackageJson(tmp.path, {});
    const { stderr, status } = run(["--dry-run", "--from-spec", "./missing.md"], tmp.path);
    equal(status, 1);
    ok(stderr.includes("spec file not found"));
  });

  it("unknown-subcommand (human)", () => {
    writePackageJson(tmp.path, {});
    const { stderr, status } = run(["foobar"], tmp.path);
    equal(status, 1);
    ok(stderr.includes("unknown subcommand 'foobar'"));
  });

  it("unknown-subcommand (json)", () => {
    writePackageJson(tmp.path, {});
    const { stdout, status } = run(["foobar", "--json"], tmp.path);
    equal(status, 1);
    const parsed = JSON.parse(stdout);
    equal(parsed.error.code, "unknown-subcommand");
  });

  it("install-missing-only (json)", () => {
    writePackageJson(tmp.path, {});
    const { stdout, status } = run(["install", "--json"], tmp.path);
    equal(status, 1);
    const parsed = JSON.parse(stdout);
    equal(parsed.error.code, "install-missing-only");
  });

  it("install-unknown-id with fuzzy suggestion (json)", () => {
    writePackageJson(tmp.path, {});
    const { stdout, status } = run(["install", "--only", "reakt", "--json"], tmp.path);
    equal(status, 1);
    const parsed = JSON.parse(stdout);
    equal(parsed.error.code, "install-unknown-id");
    equal(parsed.error.hint, "did you mean: react?");
  });

  it("install-unknown-id without suggestion (distance > 2)", () => {
    writePackageJson(tmp.path, {});
    const { stdout, status } = run(["install", "--only", "totallyunknown", "--json"], tmp.path);
    equal(status, 1);
    const parsed = JSON.parse(stdout);
    equal(parsed.error.code, "install-unknown-id");
    equal(parsed.error.hint, undefined);
  });

  it("cli-arg-invalid (--only with missing value + --json)", () => {
    writePackageJson(tmp.path, {});
    const { stdout, status } = run(["install", "--only", "--json"], tmp.path);
    equal(status, 1);
    const parsed = JSON.parse(stdout);
    equal(parsed.error.code, "cli-arg-invalid");
    ok(parsed.error.message.includes("--only"));
  });

  it("json-requires-subcommand-or-dry-run (plain --json)", () => {
    writePackageJson(tmp.path, { dependencies: { react: "^19" } });
    const { stdout, status } = run(["--json"], tmp.path);
    equal(status, 1);
    const parsed = JSON.parse(stdout);
    equal(parsed.error.code, "json-requires-subcommand-or-dry-run");
  });
});
