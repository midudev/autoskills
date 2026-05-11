import { describe, it } from "node:test";
import { equal, ok } from "node:assert/strict";
import { spawnSync } from "node:child_process";
import { resolve } from "node:path";
import { useTmpDir, writePackageJson, writeFile } from "./helpers.ts";

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

describe("--dry-run --json", () => {
  const tmp = useTmpDir();

  it("emits parseable JSON with the required top-level fields", () => {
    writePackageJson(tmp.path, { dependencies: { react: "^19" } });
    const { stdout, status } = run(["--dry-run", "--json"], tmp.path);
    equal(status, 0);
    const parsed = JSON.parse(stdout);
    ok("detected_technologies" in parsed);
    ok("detected_combos" in parsed);
    ok("is_frontend" in parsed);
    ok("skills_resolved" in parsed);
    ok("agents_detected" in parsed);
    ok(Array.isArray(parsed.detected_technologies));
    ok(parsed.detected_technologies.includes("react"));
  });

  it("works with --from-spec", () => {
    writePackageJson(tmp.path, {});
    writeFile(tmp.path, "spec.md", "## Tech Stack\n- React\n- Tailwind CSS\n");
    const { stdout, status } = run(["--dry-run", "--json", "--from-spec", "./spec.md"], tmp.path);
    equal(status, 0);
    const parsed = JSON.parse(stdout);
    ok(parsed.detected_technologies.includes("react"));
    ok(parsed.detected_technologies.includes("tailwind"));
  });

  it("JSON output goes to stdout, not stderr", () => {
    writePackageJson(tmp.path, { dependencies: { react: "^19" } });
    const { stdout, stderr } = run(["--dry-run", "--json"], tmp.path);
    ok(stdout.length > 0);
    // stderr may be empty or contain warnings — shouldn't contain JSON braces-at-start
    ok(!stderr.trimStart().startsWith("{"));
  });
});
