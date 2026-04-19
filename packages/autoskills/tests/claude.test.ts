import { describe, it } from "node:test";
import { ok, strictEqual } from "node:assert/strict";
import { existsSync, readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";

import { useTmpDir } from "./helpers.ts";
import { cleanupClaudeMd } from "../claude.ts";

describe("cleanupClaudeMd", () => {
  const tmp = useTmpDir();

  it("returns cleaned=false when CLAUDE.md does not exist", () => {
    const result = cleanupClaudeMd(tmp.path);
    strictEqual(result.cleaned, false);
    strictEqual(result.deleted, false);
  });

  it("returns cleaned=false when CLAUDE.md has no autoskills markers", () => {
    writeFileSync(join(tmp.path, "CLAUDE.md"), "# CLAUDE.md\n\nMy custom instructions.\n");
    const result = cleanupClaudeMd(tmp.path);
    strictEqual(result.cleaned, false);
    strictEqual(result.deleted, false);
    const output = readFileSync(join(tmp.path, "CLAUDE.md"), "utf-8");
    strictEqual(output, "# CLAUDE.md\n\nMy custom instructions.\n");
  });

  it("deletes CLAUDE.md when only the autoskills section remains", () => {
    writeFileSync(
      join(tmp.path, "CLAUDE.md"),
      "# CLAUDE.md\n\n<!-- autoskills:start -->\n\nGenerated content.\n\n<!-- autoskills:end -->\n",
    );
    const result = cleanupClaudeMd(tmp.path);
    strictEqual(result.cleaned, true);
    strictEqual(result.deleted, true);
    ok(!existsSync(join(tmp.path, "CLAUDE.md")));
  });

  it("removes autoskills section but preserves user content", () => {
    const content =
      "# CLAUDE.md\n\nMy custom instructions.\n\n<!-- autoskills:start -->\n\nGenerated content.\n\n<!-- autoskills:end -->\n\n## My notes\n\nDo not touch this.\n";
    writeFileSync(join(tmp.path, "CLAUDE.md"), content);
    const result = cleanupClaudeMd(tmp.path);
    strictEqual(result.cleaned, true);
    strictEqual(result.deleted, false);
    const output = readFileSync(join(tmp.path, "CLAUDE.md"), "utf-8");
    ok(output.includes("My custom instructions."));
    ok(output.includes("Do not touch this."));
    ok(!output.includes("<!-- autoskills:start -->"));
    ok(!output.includes("Generated content."));
  });

  it("does not leave triple newlines after removing the section", () => {
    const content =
      "# CLAUDE.md\n\nBefore.\n\n<!-- autoskills:start -->\nstuff\n<!-- autoskills:end -->\n\nAfter.\n";
    writeFileSync(join(tmp.path, "CLAUDE.md"), content);
    cleanupClaudeMd(tmp.path);
    const output = readFileSync(join(tmp.path, "CLAUDE.md"), "utf-8");
    ok(!output.includes("\n\n\n"));
  });

  it("deletes file when heading is the only remaining content", () => {
    writeFileSync(
      join(tmp.path, "CLAUDE.md"),
      "# CLAUDE.md\n\n<!-- autoskills:start -->\ngenerated\n<!-- autoskills:end -->\n",
    );
    const result = cleanupClaudeMd(tmp.path);
    strictEqual(result.cleaned, true);
    strictEqual(result.deleted, true);
    ok(!existsSync(join(tmp.path, "CLAUDE.md")));
  });
});
