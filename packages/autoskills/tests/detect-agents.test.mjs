import { describe, it, beforeEach, afterEach } from "node:test";
import assert from "node:assert/strict";
import { mkdtempSync, mkdirSync, rmSync } from "node:fs";
import { join } from "node:path";
import { tmpdir } from "node:os";
import { detectAgents, AGENT_FOLDER_MAP } from "../lib.mjs";

describe("detectAgents", () => {
  let tmpHome;

  beforeEach(() => {
    tmpHome = mkdtempSync(join(tmpdir(), "autoskills-agents-"));
  });

  afterEach(() => {
    rmSync(tmpHome, { recursive: true, force: true });
  });

  it("always includes universal as first entry", () => {
    const agents = detectAgents(tmpHome);
    assert.deepEqual(agents, ["universal"]);
  });

  it("detects claude-code from .claude/skills", () => {
    mkdirSync(join(tmpHome, ".claude", "skills"), { recursive: true });
    const agents = detectAgents(tmpHome);
    assert.ok(agents.includes("universal"));
    assert.ok(agents.includes("claude-code"));
  });

  it("detects cursor from .cursor/skills", () => {
    mkdirSync(join(tmpHome, ".cursor", "skills"), { recursive: true });
    const agents = detectAgents(tmpHome);
    assert.ok(agents.includes("cursor"));
  });

  it("detects kiro from .kiro/skills", () => {
    mkdirSync(join(tmpHome, ".kiro", "skills"), { recursive: true });
    const agents = detectAgents(tmpHome);
    assert.ok(agents.includes("kiro"));
  });

  it("detects multiple agents", () => {
    mkdirSync(join(tmpHome, ".claude", "skills"), { recursive: true });
    mkdirSync(join(tmpHome, ".cline", "skills"), { recursive: true });
    mkdirSync(join(tmpHome, ".codex", "skills"), { recursive: true });
    const agents = detectAgents(tmpHome);
    assert.equal(agents[0], "universal");
    assert.ok(agents.includes("claude-code"));
    assert.ok(agents.includes("cline"));
    assert.ok(agents.includes("codex"));
    assert.equal(agents.length, 4);
  });

  it("ignores agent folders without skills subdirectory", () => {
    mkdirSync(join(tmpHome, ".claude"), { recursive: true });
    mkdirSync(join(tmpHome, ".cursor"), { recursive: true });
    const agents = detectAgents(tmpHome);
    assert.deepEqual(agents, ["universal"]);
  });

  it("ignores unknown folders with skills subdirectory", () => {
    mkdirSync(join(tmpHome, ".unknown-editor", "skills"), { recursive: true });
    const agents = detectAgents(tmpHome);
    assert.deepEqual(agents, ["universal"]);
  });

  it("detects all mapped agents when present", () => {
    for (const folder of Object.keys(AGENT_FOLDER_MAP)) {
      mkdirSync(join(tmpHome, folder, "skills"), { recursive: true });
    }
    const agents = detectAgents(tmpHome);
    assert.equal(agents[0], "universal");
    assert.equal(agents.length, 1 + Object.keys(AGENT_FOLDER_MAP).length);
  });
});
