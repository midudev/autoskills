import { describe, it } from "node:test";
import { equal, ok, throws } from "node:assert/strict";
import { useTmpDir, writeFile } from "./helpers.ts";
import { loadMarkdownSources } from "../lib.ts";

describe("loadMarkdownSources", () => {
  const tmp = useTmpDir();

  it("reads --from-spec file", () => {
    writeFile(tmp.path, "spec.md", "# hi");
    const sources = loadMarkdownSources({ fromSpec: "spec.md", projectDir: tmp.path });
    equal(sources.length, 1);
    equal(sources[0].content, "# hi");
  });

  it("throws spec-file-not-found on missing path", () => {
    throws(
      () => loadMarkdownSources({ fromSpec: "nope.md", projectDir: tmp.path }),
      /spec file not found/,
    );
  });

  it("resolves --from-spec relative paths against projectDir", () => {
    writeFile(tmp.path, "nested/spec.md", "ok");
    const sources = loadMarkdownSources({ fromSpec: "nested/spec.md", projectDir: tmp.path });
    equal(sources.length, 1);
    equal(sources[0].content, "ok");
  });

  it("scan-docs reads CLAUDE.md only when present", () => {
    writeFile(tmp.path, "CLAUDE.md", "# claude");
    const sources = loadMarkdownSources({ scanDocs: true, projectDir: tmp.path });
    equal(sources.length, 1);
    equal(sources[0].content, "# claude");
  });

  it("scan-docs reads AGENTS.md only when present", () => {
    writeFile(tmp.path, "AGENTS.md", "# agents");
    const sources = loadMarkdownSources({ scanDocs: true, projectDir: tmp.path });
    equal(sources.length, 1);
  });

  it("scan-docs reads both CLAUDE.md and AGENTS.md when both present", () => {
    writeFile(tmp.path, "CLAUDE.md", "# c");
    writeFile(tmp.path, "AGENTS.md", "# a");
    const sources = loadMarkdownSources({ scanDocs: true, projectDir: tmp.path });
    equal(sources.length, 2);
  });

  it("scan-docs returns [] when neither CLAUDE.md nor AGENTS.md exists", () => {
    const sources = loadMarkdownSources({ scanDocs: true, projectDir: tmp.path });
    equal(sources.length, 0);
  });

  it("combines fromSpec + scanDocs without duplicating an auto-discovered file also passed explicitly", () => {
    writeFile(tmp.path, "CLAUDE.md", "# c");
    writeFile(tmp.path, "extra.md", "# e");
    const sources = loadMarkdownSources({ fromSpec: "extra.md", scanDocs: true, projectDir: tmp.path });
    equal(sources.length, 2);
  });

  it("deduplicates when fromSpec explicitly points at CLAUDE.md while scanDocs is set", () => {
    writeFile(tmp.path, "CLAUDE.md", "# c");
    const sources = loadMarkdownSources({ fromSpec: "CLAUDE.md", scanDocs: true, projectDir: tmp.path });
    equal(sources.length, 1);
    ok(sources[0].path.endsWith("CLAUDE.md"));
  });

  it("reads README.md when scanDocs is true", () => {
    writeFile(tmp.path, "README.md", "# Hello\n\n## Tech Stack\n- React\n");
    const sources = loadMarkdownSources({ scanDocs: true, projectDir: tmp.path });
    equal(sources.length, 1);
    equal(sources[0].content.includes("Tech Stack"), true);
  });

  it("reads CLAUDE.md + AGENTS.md + README.md together", () => {
    writeFile(tmp.path, "CLAUDE.md", "# a\n");
    writeFile(tmp.path, "AGENTS.md", "# b\n");
    writeFile(tmp.path, "README.md", "# c\n");
    const sources = loadMarkdownSources({ scanDocs: true, projectDir: tmp.path });
    equal(sources.length, 3);
  });
});
