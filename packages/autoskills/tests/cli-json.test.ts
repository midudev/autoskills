import { describe, it } from "node:test";
import { equal, deepEqual, ok } from "node:assert/strict";
import { readFileSync } from "node:fs";
import { resolve } from "node:path";
import {
  serializeList,
  serializeDryRun,
  serializeInstall,
  serializeError,
} from "../cli-json.ts";

const PKG_VERSION = (() => {
  const pkg = JSON.parse(readFileSync(resolve(import.meta.dirname!, "..", "package.json"), "utf-8"));
  return pkg.version as string;
})();

describe("serializeList", () => {
  it("returns version + technologies + combos + frontend_bonus", () => {
    const json = serializeList({ version: PKG_VERSION });
    equal(json.version, PKG_VERSION);
    ok(Array.isArray(json.technologies));
    ok(Array.isArray(json.combos));
    ok(Array.isArray(json.frontend_bonus));
    ok(json.technologies.length > 0, "SKILLS_MAP should not be empty");
    ok(json.combos.length > 0, "COMBO_SKILLS_MAP should not be empty");
    ok(json.frontend_bonus.length > 0, "FRONTEND_BONUS_SKILLS should not be empty");
  });

  it("must NOT expose detect rules", () => {
    const json = serializeList({ version: "test" });
    for (const t of json.technologies) {
      ok(!("detect" in t), `detect must not appear in list JSON for ${t.id}`);
    }
  });

  it("serialized technology shape is id + name + aliases + description? + skills", () => {
    const json = serializeList({ version: "test" });
    const tech = json.technologies.find(t => t.id === "react");
    ok(tech, "react must exist in SKILLS_MAP");
    equal(typeof tech!.id, "string");
    equal(typeof tech!.name, "string");
    ok(Array.isArray(tech!.aliases));
    ok(Array.isArray(tech!.skills));
  });

  it("with filter: exact id match returns only that tech", () => {
    const json = serializeList({ version: "test", filter: "react" });
    equal(json.technologies.length, 1);
    equal(json.technologies[0].id, "react");
  });

  it("with filter: name match (case-insensitive)", () => {
    const json = serializeList({ version: "test", filter: "React" });
    equal(json.technologies.length, 1);
    equal(json.technologies[0].id, "react");
  });

  it("with filter: alias match (e.g., NextJS -> nextjs)", () => {
    const json = serializeList({ version: "test", filter: "NextJS" });
    equal(json.technologies.length, 1);
    equal(json.technologies[0].id, "nextjs");
  });

  it("with unknown filter: empty technologies array, still exits cleanly", () => {
    const json = serializeList({ version: "test", filter: "zzz-not-a-tech" });
    deepEqual(json.technologies, []);
  });

  it("aliases array is copied, not shared (mutation safety)", () => {
    const json1 = serializeList({ version: "test", filter: "nextjs" });
    const aliasesSnapshot = [...json1.technologies[0].aliases];
    json1.technologies[0].aliases.push("MUTATED");
    const json2 = serializeList({ version: "test", filter: "nextjs" });
    deepEqual(json2.technologies[0].aliases, aliasesSnapshot);
  });
});

describe("serializeDryRun", () => {
  it("passes through the provided data shape", () => {
    const input = {
      detected_technologies: ["react", "tailwind"],
      detected_combos: [],
      is_frontend: true,
      skills_resolved: [
        { id: "react-best-practices", path: "vercel-labs/agent-skills/vercel-react-best-practices", source_tech: "react", installed: false },
      ],
      agents_detected: ["claude-code"],
    };
    const json = serializeDryRun(input);
    deepEqual(json, input);
    ok("detected_technologies" in json);
    ok("is_frontend" in json);
    ok("skills_resolved" in json);
  });
});

describe("serializeInstall", () => {
  it("passes through installed/failed/agents", () => {
    const json = serializeInstall({
      installed: [{ id: "react-best-practices", path: "vercel-labs/.../react" }],
      failed: [],
      agents: ["claude-code"],
    });
    equal(json.installed.length, 1);
    equal(json.failed.length, 0);
    deepEqual(json.agents, ["claude-code"]);
  });
});

describe("serializeError", () => {
  it("wraps error in { error: {...} } envelope", () => {
    const json = serializeError({
      code: "install-unknown-id",
      message: "unknown tech id 'reakt'",
      hint: "did you mean: react?",
      details: { provided: "reakt", suggestions: ["react"] },
    });
    equal(json.error.code, "install-unknown-id");
    equal(json.error.hint, "did you mean: react?");
    deepEqual(json.error.details, { provided: "reakt", suggestions: ["react"] });
  });

  it("handles minimal error (no hint or details)", () => {
    const json = serializeError({ code: "foo", message: "bar" });
    equal(json.error.code, "foo");
    equal(json.error.hint, undefined);
    equal(json.error.details, undefined);
  });
});
