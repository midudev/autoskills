import { describe, it } from "node:test";
import { ok, strictEqual } from "node:assert/strict";
import { readFileSync } from "node:fs";
import { join } from "node:path";

import { useTmpDir, writeFile } from "./helpers.mjs";
import { shouldGenerateClaudeMd, summarizeMarkdown, generateClaudeMd } from "../claude.mjs";

describe("shouldGenerateClaudeMd", () => {
  it("returns true when claude-code is selected", () => {
    strictEqual(shouldGenerateClaudeMd(["universal", "claude-code"]), true);
  });

  it("returns false when claude-code is not selected", () => {
    strictEqual(shouldGenerateClaudeMd(["universal", "cursor"]), false);
  });
});

describe("summarizeMarkdown", () => {
  it("extracts the first heading and paragraph", () => {
    const result = summarizeMarkdown(`# React Skill

Best practices for building React apps with this stack.

## Details
More text.
`);

    strictEqual(result.title, "React Skill");
    strictEqual(result.summary, "Best practices for building React apps with this stack.");
  });

  it("ignores code fences before the summary", () => {
    const result = summarizeMarkdown(`# Example

\`\`\`js
console.log("test")
\`\`\`

Use this skill to guide API integrations.
`);

    strictEqual(result.title, "Example");
    strictEqual(result.summary, "Use this skill to guide API integrations.");
  });
});

describe("generateClaudeMd", () => {
  const tmp = useTmpDir();

  it("returns generated=false when .claude/skills does not exist", () => {
    const result = generateClaudeMd(tmp.path);
    strictEqual(result.generated, false);
    strictEqual(result.files, 0);
  });

  it("builds CLAUDE.md from markdown files under .claude/skills", () => {
    writeFile(
      tmp.path,
      ".claude/skills/react-best-practices/SKILL.md",
      `# React Best Practices

Use this skill to keep components small and predictable.
`,
    );
    writeFile(
      tmp.path,
      ".claude/skills/react-best-practices/README.md",
      `# React Skill Notes

Remember to prefer composition over inheritance.
`,
    );

    const result = generateClaudeMd(tmp.path);
    const output = readFileSync(join(tmp.path, "CLAUDE.md"), "utf-8");

    strictEqual(result.generated, true);
    strictEqual(result.files, 2);
    ok(output.includes("# CLAUDE.md"));
    ok(output.includes("## react-best-practices"));
    ok(output.includes("### React Best Practices"));
    ok(output.includes("Use this skill to keep components small and predictable."));
    ok(output.includes("### React Skill Notes"));
    ok(output.includes("`.claude/skills/react-best-practices/SKILL.md`"));
  });
});
