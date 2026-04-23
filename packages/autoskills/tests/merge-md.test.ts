import { describe, it } from "node:test";
import { deepEqual } from "node:assert/strict";
import { mergeMarkdownDetections } from "../lib.ts";

describe("mergeMarkdownDetections", () => {
  it("union with no duplicates, preserves core order then scanner order", () => {
    const core = ["react", "typescript"];
    const matches = [
      { techId: "tailwind", source: "code-fence" as const, evidence: "" },
      { techId: "react",    source: "stack-heading" as const, evidence: "" },
    ];
    deepEqual(mergeMarkdownDetections(core, matches), ["react", "typescript", "tailwind"]);
  });

  it("returns core unchanged when matches empty", () => {
    deepEqual(mergeMarkdownDetections(["react"], []), ["react"]);
  });

  it("returns scanner ids when core empty", () => {
    const matches = [{ techId: "react", source: "code-fence" as const, evidence: "" }];
    deepEqual(mergeMarkdownDetections([], matches), ["react"]);
  });

  it("preserves scanner order for multiple new ids", () => {
    const matches = [
      { techId: "tailwind", source: "code-fence" as const, evidence: "" },
      { techId: "nextjs",   source: "code-fence" as const, evidence: "" },
      { techId: "vue",      source: "stack-heading" as const, evidence: "" },
    ];
    deepEqual(mergeMarkdownDetections([], matches), ["tailwind", "nextjs", "vue"]);
  });

  it("deduplicates scanner matches among themselves", () => {
    const matches = [
      { techId: "react", source: "code-fence" as const, evidence: "" },
      { techId: "react", source: "stack-heading" as const, evidence: "" },
    ];
    deepEqual(mergeMarkdownDetections([], matches), ["react"]);
  });
});
