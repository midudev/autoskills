import test from "node:test";
import assert from "node:assert/strict";
import { mkdtempSync, rmSync, writeFileSync } from "node:fs";
import { join } from "node:path";
import { tmpdir } from "node:os";

import { detectTechnologies } from "../lib.mjs";

function createTempProject(files) {
  const dir = mkdtempSync(join(tmpdir(), "autoskills-"));
  for (const [name, content] of Object.entries(files)) {
    writeFileSync(join(dir, name), content);
  }
  return dir;
}

test("detectTechnologies still finds exact package and config-file matches", () => {
  const dir = createTempProject({
    "package.json": JSON.stringify(
      {
        name: "fixture",
        private: true,
        dependencies: {
          react: "19.0.0",
          next: "15.0.0",
        },
      },
      null,
      2,
    ),
    "next.config.ts": "export default {}\n",
  });

  try {
    const { detected } = detectTechnologies(dir);
    const ids = detected.map((tech) => tech.id);
    assert.ok(ids.includes("react"));
    assert.ok(ids.includes("nextjs"));
  } finally {
    rmSync(dir, { recursive: true, force: true });
  }
});
