import { describe, it } from "node:test";
import { ok, equal, deepEqual } from "node:assert/strict";
import { mkdirSync } from "node:fs";
import { join } from "node:path";
import { detectAgents, AGENT_FOLDER_MAP } from "../lib.mjs";
import { useTmpDir } from "./helpers.mjs";

describe("detectAgents", () => {
  const tmp = useTmpDir();

  it("always includes universal as first entry", () => {
    const agents = detectAgents(tmp.path);
    deepEqual(agents, ["universal"]);
  });

  it("detects claude-code from .claude/skills", () => {
    mkdirSync(join(tmp.path, ".claude", "skills"), { recursive: true });
    const agents = detectAgents(tmp.path);
    ok(agents.includes("universal"));
    ok(agents.includes("claude-code"));
  });

  it("detects cursor from .cursor/skills", () => {
    mkdirSync(join(tmp.path, ".cursor", "skills"), { recursive: true });
    const agents = detectAgents(tmp.path);
    ok(agents.includes("cursor"));
  });

  it("detects opencode from .opencode/skills", () => {
    mkdirSync(join(tmp.path, ".opencode", "skills"), { recursive: true });
    const agents = detectAgents(tmp.path);
    ok(agents.includes("opencode"));
  });

  it("detects kiro-cli from .kiro/skills", () => {
    mkdirSync(join(tmp.path, ".kiro", "skills"), { recursive: true });
    const agents = detectAgents(tmp.path);
    ok(agents.includes("kiro-cli"));
  });

  it("detects multiple agents", () => {
    mkdirSync(join(tmp.path, ".claude", "skills"), { recursive: true });
    mkdirSync(join(tmp.path, ".cline", "skills"), { recursive: true });
    mkdirSync(join(tmp.path, ".codex", "skills"), { recursive: true });
    const agents = detectAgents(tmp.path);
    equal(agents[0], "universal");
    ok(agents.includes("claude-code"));
    ok(agents.includes("cline"));
    ok(agents.includes("codex"));
    equal(agents.length, 4);
  });

  it("ignores agent folders without skills subdirectory", () => {
    mkdirSync(join(tmp.path, ".claude"), { recursive: true });
    mkdirSync(join(tmp.path, ".cursor"), { recursive: true });
    const agents = detectAgents(tmp.path);
    deepEqual(agents, ["universal"]);
  });

  it("ignores unknown folders with skills subdirectory", () => {
    mkdirSync(join(tmp.path, ".unknown-editor", "skills"), { recursive: true });
    const agents = detectAgents(tmp.path);
    deepEqual(agents, ["universal"]);
  });

  it("detects all mapped agents when present", () => {
    for (const folder of Object.keys(AGENT_FOLDER_MAP)) {
      mkdirSync(join(tmp.path, folder, "skills"), { recursive: true });
    }
    const agents = detectAgents(tmp.path);
    equal(agents[0], "universal");
    equal(agents.length, 1 + Object.keys(AGENT_FOLDER_MAP).length);
  });
});
