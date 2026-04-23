import { describe, it } from "node:test";
import { deepEqual, equal } from "node:assert/strict";
import { scanMarkdown } from "../markdown-scanner.ts";
import { SKILLS_MAP } from "../skills-map.ts";

describe("scanMarkdown — json fences", () => {
  it("detects tech from dependencies block", () => {
    const md = "```json\n{\"dependencies\":{\"react\":\"^19\"}}\n```";
    const matches = scanMarkdown(md, SKILLS_MAP);
    equal(matches.length, 1);
    equal(matches[0].techId, "react");
    equal(matches[0].source, "code-fence");
  });

  it("detects tech from devDependencies block", () => {
    const md = "```json\n{\"devDependencies\":{\"typescript\":\"^5\"}}\n```";
    const matches = scanMarkdown(md, SKILLS_MAP);
    equal(matches[0].techId, "typescript");
  });

  it("skips malformed JSON without throwing", () => {
    const md = "```json\n{\"dependencies\":{\"react\":^19}\n```";
    deepEqual(scanMarkdown(md, SKILLS_MAP), []);
  });

  it("returns [] for empty fence", () => {
    const md = "```json\n\n```";
    deepEqual(scanMarkdown(md, SKILLS_MAP), []);
  });

  it("returns [] for no-language fence", () => {
    const md = "```\n{\"dependencies\":{\"react\":\"^19\"}}\n```";
    deepEqual(scanMarkdown(md, SKILLS_MAP), []);
  });
});
