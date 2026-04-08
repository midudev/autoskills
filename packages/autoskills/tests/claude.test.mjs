import { describe, it } from "node:test";
import { ok, strictEqual } from "node:assert/strict";
import { readFileSync, writeFileSync } from "node:fs";
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

function addSkillFile(tmpPath) {
  writeFile(
    tmpPath,
    ".claude/skills/react-best-practices/SKILL.md",
    `# React Best Practices

Use this skill to keep components small and predictable.
`,
  );
}

describe("generateClaudeMd", () => {
  const tmp = useTmpDir();

  it("returns generated=false when .claude/skills does not exist", () => {
    const result = generateClaudeMd(tmp.path);
    strictEqual(result.generated, false);
    strictEqual(result.files, 0);
  });

  it("creates CLAUDE.md with delimited section when file does not exist", () => {
    addSkillFile(tmp.path);

    const result = generateClaudeMd(tmp.path);
    const output = readFileSync(join(tmp.path, "CLAUDE.md"), "utf-8");

    strictEqual(result.generated, true);
    strictEqual(result.files, 1);
    ok(output.includes("# CLAUDE.md"));
    ok(output.includes("<!-- autoskills:start -->"));
    ok(output.includes("<!-- autoskills:end -->"));
    ok(output.includes("### React Best Practices"));
    ok(output.includes("`.claude/skills/react-best-practices/SKILL.md`"));
  });

  it("preserves user content and replaces only the delimited section", () => {
    const userContent = [
      "# CLAUDE.md",
      "",
      "My custom instructions for this project.",
      "",
      "<!-- autoskills:start -->",
      "old generated content here",
      "<!-- autoskills:end -->",
      "",
      "## My notes",
      "",
      "Do not touch this.",
      "",
    ].join("\n");

    writeFileSync(join(tmp.path, "CLAUDE.md"), userContent);
    addSkillFile(tmp.path);

    generateClaudeMd(tmp.path);
    const output = readFileSync(join(tmp.path, "CLAUDE.md"), "utf-8");

    ok(output.includes("My custom instructions for this project."));
    ok(output.includes("Do not touch this."));
    ok(output.includes("### React Best Practices"));
    ok(!output.includes("old generated content here"));
  });

  it("appends delimited section when CLAUDE.md exists without markers", () => {
    const userContent = "# CLAUDE.md\n\nAlways use TypeScript strict mode.\n";

    writeFileSync(join(tmp.path, "CLAUDE.md"), userContent);
    addSkillFile(tmp.path);

    generateClaudeMd(tmp.path);
    const output = readFileSync(join(tmp.path, "CLAUDE.md"), "utf-8");

    ok(output.startsWith("# CLAUDE.md\n\nAlways use TypeScript strict mode."));
    ok(output.includes("<!-- autoskills:start -->"));
    ok(output.includes("<!-- autoskills:end -->"));
    ok(output.includes("### React Best Practices"));
  });

  it("updates the section when skills change", () => {
    addSkillFile(tmp.path);
    generateClaudeMd(tmp.path);

    writeFile(
      tmp.path,
      ".claude/skills/vue-patterns/SKILL.md",
      `# Vue Patterns

Composition API best practices.
`,
    );

    generateClaudeMd(tmp.path);
    const output = readFileSync(join(tmp.path, "CLAUDE.md"), "utf-8");

    ok(output.includes("### React Best Practices"));
    ok(output.includes("### Vue Patterns"));

    const startCount = output.split("<!-- autoskills:start -->").length - 1;
    strictEqual(startCount, 1);
  });
});
