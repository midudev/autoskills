import { describe, it } from "node:test";
import { equal, ok, deepEqual } from "node:assert/strict";
import { resolve } from "node:path";
import { readFileSync, existsSync } from "node:fs";
import {
  useTmpDir,
  writeMarkdown,
  readFixtureSpec,
  parseJsonOutput,
  buildMarkdownFromParts,
  mockInstaller,
} from "./helpers.ts";

describe("helpers (new)", () => {
  const tmp = useTmpDir();

  it("writeMarkdown writes file and returns absolute path", () => {
    const p = writeMarkdown(tmp.path, "spec.md", "# hi\n");
    ok(existsSync(p));
    equal(readFileSync(p, "utf-8"), "# hi\n");
    equal(p, resolve(tmp.path, "spec.md"));
  });

  it("readFixtureSpec reads from tests/fixtures/specs", () => {
    const content = readFixtureSpec("empty.md");
    equal(content, "");
  });

  it("parseJsonOutput extracts last JSON object from stdout", () => {
    const stdout = "→ scanning...\n{\"ok\":true}\n";
    deepEqual(parseJsonOutput(stdout), { ok: true });
  });

  it("parseJsonOutput parses nested objects", () => {
    deepEqual(parseJsonOutput("noise\n{\"a\":{\"b\":1}}\n"), { a: { b: 1 } });
  });

  it("parseJsonOutput parses top-level arrays", () => {
    deepEqual(parseJsonOutput("noise\n[{\"id\":\"react\"},{\"id\":\"ts\"}]\n"), [{ id: "react" }, { id: "ts" }]);
  });

  it("buildMarkdownFromParts composes fences and headings", () => {
    const md = buildMarkdownFromParts({
      fences: [{ lang: "bash", body: "pnpm add react" }],
      headings: [{ level: 2, title: "Tech Stack", bullets: ["React"] }],
    });
    ok(md.includes("```bash"));
    ok(md.includes("## Tech Stack"));
    ok(md.includes("- React"));
  });

  it("mockInstaller returns controllable result", async () => {
    const stub = mockInstaller({ success: true });
    const result = await stub.installSkill("any/path", []);
    equal(result.success, true);
    equal(stub.calls.length, 1);
  });
});
