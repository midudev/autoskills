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

describe("subcommand dispatch", () => {
  const tmp = useTmpDir();

  it("autoskills list --json parses and has version", () => {
    writePackageJson(tmp.path, {});
    const { stdout, status } = run(["list", "--json"], tmp.path);
    equal(status, 0);
    const parsed = JSON.parse(stdout);
    ok(typeof parsed.version === "string");
    ok(Array.isArray(parsed.technologies));
  });

  it("autoskills list --json --filter react returns one tech", () => {
    writePackageJson(tmp.path, {});
    const { stdout, status } = run(["list", "--json", "--filter", "react"], tmp.path);
    equal(status, 0);
    const parsed = JSON.parse(stdout);
    equal(parsed.technologies.length, 1);
    equal(parsed.technologies[0].id, "react");
  });

  it("autoskills install --only react-that-does-not-exist --json -> install-unknown-id", () => {
    writePackageJson(tmp.path, {});
    const { stdout, status } = run(["install", "--only", "reakt", "--json"], tmp.path);
    equal(status, 1);
    const parsed = JSON.parse(stdout);
    equal(parsed.error.code, "install-unknown-id");
    equal(parsed.error.hint, "did you mean: react?");
  });

  it("autoskills install without --only errors", () => {
    writePackageJson(tmp.path, {});
    const { stdout, status } = run(["install", "--json"], tmp.path);
    equal(status, 1);
    const parsed = JSON.parse(stdout);
    equal(parsed.error.code, "install-missing-only");
  });

  it("default autoskills (no subcommand) still runs dry-run path", () => {
    writePackageJson(tmp.path, { dependencies: { react: "^19" } });
    const { stdout, status } = run(["--dry-run"], tmp.path);
    equal(status, 0);
    ok(stdout.toLowerCase().includes("react"));
  });

  it("unknown subcommand exits 1 with unknown-subcommand error", () => {
    writePackageJson(tmp.path, {});
    const { stderr, status } = run(["foo"], tmp.path);
    equal(status, 1);
    ok(stderr.includes("unknown subcommand 'foo'"));
  });

  it("unknown subcommand --json emits JSON error", () => {
    writePackageJson(tmp.path, {});
    const { stdout, status } = run(["foo", "--json"], tmp.path);
    equal(status, 1);
    const parsed = JSON.parse(stdout);
    equal(parsed.error.code, "unknown-subcommand");
  });

  it("autoskills list react (implicit --filter) returns one tech", () => {
    writePackageJson(tmp.path, {});
    const { stdout, status } = run(["list", "--json", "react"], tmp.path);
    equal(status, 0);
    const parsed = JSON.parse(stdout);
    equal(parsed.technologies.length, 1);
    equal(parsed.technologies[0].id, "react");
  });

  it("autoskills list react --json (positional before --json) returns one tech", () => {
    writePackageJson(tmp.path, {});
    const { stdout, status } = run(["list", "react", "--json"], tmp.path);
    equal(status, 0);
    const parsed = JSON.parse(stdout);
    equal(parsed.technologies.length, 1);
    equal(parsed.technologies[0].id, "react");
  });

  it("autoskills list react (human mode, no --json) prints only react's row", () => {
    writePackageJson(tmp.path, {});
    const { stdout, status } = run(["list", "react"], tmp.path);
    equal(status, 0);
    ok(stdout.toLowerCase().includes("react"));
    // crude but effective: if only 1 tech printed, output should be small
    ok(stdout.split("\n").filter(l => l.trim()).length < 10, "expected compact single-row output");
  });

  it("autoskills --copy-specgen-prompt early-exits with success-or-fallback (does not run detection)", () => {
    // No package.json — would normally trigger "no supported technologies detected".
    // --copy-specgen-prompt must short-circuit before that path.
    const { stdout, stderr, status } = run(["--copy-specgen-prompt"], tmp.path);
    equal(status, 0);
    const combined = stdout + stderr;
    // Either clipboard succeeded OR clipboard failed and the prompt was printed as fallback.
    const succeeded = stdout.includes("✓ prompt copied to clipboard");
    const fellBack = stderr.includes("warning") && stdout.includes("# autoskills");
    ok(succeeded || fellBack, `expected success or fallback, got: ${combined}`);
    // Detection banner must NOT appear (we exited before main flow).
    ok(!combined.includes("Detected technologies"), "detection ran but should not have");
  });

  it("autoskills --show-specgen-prompt prints the prompt and early-exits", () => {
    const { stdout, status } = run(["--show-specgen-prompt"], tmp.path);
    equal(status, 0);
    ok(stdout.includes("# autoskills — Spec-Doc Generator"));
    // Must not run detection.
    ok(!stdout.includes("Detected technologies"), "detection ran but should not have");
  });

  it("autoskills --help mentions both --copy-specgen-prompt and --show-specgen-prompt", () => {
    const { stdout, status } = run(["--help"], tmp.path);
    equal(status, 0);
    ok(stdout.includes("--copy-specgen-prompt"));
    ok(stdout.includes("--show-specgen-prompt"));
  });

  it("autoskills list --filter react extra-positional: explicit --filter wins, extra is ignored", () => {
    writePackageJson(tmp.path, {});
    const { stdout, status } = run(["list", "--filter", "react", "extra", "--json"], tmp.path);
    equal(status, 0);
    const parsed = JSON.parse(stdout);
    equal(parsed.technologies.length, 1);
    equal(parsed.technologies[0].id, "react");
  });

  it("autoskills install --only react -y --json (positive path, mocked installer)", () => {
    writePackageJson(tmp.path, {});
    const r = spawnSync(process.execPath, [CLI, "install", "--only", "react", "-y", "--json"], {
      cwd: tmp.path,
      encoding: "utf-8",
      timeout: 15_000,
      env: { ...process.env, NO_COLOR: "1", AUTOSKILLS_MOCK_INSTALL: "1" },
    });
    equal(r.status, 0);
    const parsed = JSON.parse(r.stdout ?? "");
    ok(Array.isArray(parsed.installed));
    ok(parsed.installed.length >= 1);
    equal(parsed.failed.length, 0);
  });
});
