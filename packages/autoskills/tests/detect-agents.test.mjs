import { describe, it } from "node:test";
import { ok, strictEqual } from "node:assert/strict";
import { mkdirSync } from "node:fs";
import { join } from "node:path";
import { detectAgents, AGENT_FOLDER_MAP } from "../lib.mjs";
import { useTmpDir } from "./helpers.mjs";

describe("detectAgents", () => {
  const tmp = useTmpDir();

  it("always includes universal as first entry", () => {
    const agents = detectAgents(tmp.path);
    strictEqual(agents[0].id, "universal");
    strictEqual(agents[0].detected, true);
  });

  it("detects claude-code from .claude/skills", () => {
    mkdirSync(join(tmp.path, ".claude", "skills"), { recursive: true });
    const agents = detectAgents(tmp.path);
    ok(agents.find((a) => a.id === "claude-code" && a.detected));
  });

  it("detects cursor from .cursor/skills", () => {
    mkdirSync(join(tmp.path, ".cursor", "skills"), { recursive: true });
    const agents = detectAgents(tmp.path);
    ok(agents.find((a) => a.id === "cursor" && a.detected));
  });

  it("detects kiro-cli from .kiro/skills", () => {
    mkdirSync(join(tmp.path, ".kiro", "skills"), { recursive: true });
    const agents = detectAgents(tmp.path);
    ok(agents.find((a) => a.id === "kiro-cli" && a.detected));
  });

  it("detects multiple agents", () => {
    mkdirSync(join(tmp.path, ".claude", "skills"), { recursive: true });
    mkdirSync(join(tmp.path, ".cline", "skills"), { recursive: true });
    mkdirSync(join(tmp.path, ".codex", "skills"), { recursive: true });
    const agents = detectAgents(tmp.path);
    strictEqual(agents[0].id, "universal");
    ok(agents.find((a) => a.id === "claude-code" && a.detected));
    ok(agents.find((a) => a.id === "cline" && a.detected));
    ok(agents.find((a) => a.id === "codex" && a.detected));
    // Others should not be detected
    ok(!agents.find((a) => a.id === "cursor" && a.detected));
  });

  it("ignores agent folders without skills subdirectory", () => {
    mkdirSync(join(tmp.path, ".claude"), { recursive: true });
    mkdirSync(join(tmp.path, ".cursor"), { recursive: true });
    const agents = detectAgents(tmp.path);
    ok(!agents.find((a) => a.id === "claude" && a.detected));
    ok(!agents.find((a) => a.id === "cursor" && a.detected));
  });

  it("ignores unknown folders with skills subdirectory", () => {
    mkdirSync(join(tmp.path, ".unknown-editor", "skills"), { recursive: true });
    const agents = detectAgents(tmp.path);
    // Should only have universal as detected
    const detected = agents.filter((a) => a.detected);
    strictEqual(detected.length, 1);
    strictEqual(detected[0].id, "universal");
  });

  it("detects all mapped agents when present", () => {
    for (const folder of Object.keys(AGENT_FOLDER_MAP)) {
      mkdirSync(join(tmp.path, folder, "skills"), { recursive: true });
    }
    const agents = detectAgents(tmp.path);
    const detectedIds = agents.filter((a) => a.detected).map((a) => a.id);

    strictEqual(detectedIds[0], "universal");
    for (const expectedAgent of Object.values(AGENT_FOLDER_MAP)) {
      ok(detectedIds.includes(expectedAgent));
    }
  });
});
