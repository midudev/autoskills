import { describe, it } from "node:test";
import { ok, strictEqual, deepStrictEqual, throws } from "node:assert/strict";
import { collectSkills, getInstalledSkillNames } from "../lib.mjs";
import { multiSelect } from "../ui.mjs";
import { useTmpDir, writeJson, writeFile } from "./helpers.mjs";

describe("collectSkills", () => {
  it("returns empty array when no technologies detected", () => {
    const skills = collectSkills({ detected: [], isFrontend: false });
    deepStrictEqual(skills, []);
  });

  it("collects skills from a single technology", () => {
    const detected = [
      {
        id: "react",
        name: "React",
        skills: ["vercel-labs/agent-skills/vercel-react-best-practices"],
      },
    ];
    const skills = collectSkills({ detected, isFrontend: false });

    strictEqual(skills.length, 1);
    strictEqual(skills[0].skill, "vercel-labs/agent-skills/vercel-react-best-practices");
    deepStrictEqual(skills[0].sources, ["React"]);
  });

  it("deduplicates skills shared across technologies", () => {
    const detected = [
      { id: "a", name: "Tech A", skills: ["shared/repo/my-skill"] },
      { id: "b", name: "Tech B", skills: ["shared/repo/my-skill"] },
    ];
    const skills = collectSkills({ detected, isFrontend: false });

    strictEqual(skills.length, 1);
    strictEqual(skills[0].skill, "shared/repo/my-skill");
    deepStrictEqual(skills[0].sources, ["Tech A", "Tech B"]);
  });

  it("keeps unique skills from different technologies", () => {
    const detected = [
      {
        id: "react",
        name: "React",
        skills: ["vercel-labs/agent-skills/vercel-react-best-practices"],
      },
      { id: "nextjs", name: "Next.js", skills: ["vercel-labs/next-skills/next-best-practices"] },
    ];
    const skills = collectSkills({ detected, isFrontend: false });

    strictEqual(skills.length, 2);
    strictEqual(skills[0].skill, "vercel-labs/agent-skills/vercel-react-best-practices");
    strictEqual(skills[1].skill, "vercel-labs/next-skills/next-best-practices");
  });

  it("handles technologies with multiple skills", () => {
    const detected = [
      {
        id: "vue",
        name: "Vue",
        skills: ["hyf0/vue-skills/vue-best-practices", "antfu/skills/vue"],
      },
    ];
    const skills = collectSkills({ detected, isFrontend: false });

    strictEqual(skills.length, 2);
    strictEqual(skills[0].skill, "hyf0/vue-skills/vue-best-practices");
    strictEqual(skills[1].skill, "antfu/skills/vue");
  });

  it("adds frontend bonus skills for frontend projects", () => {
    const detected = [
      {
        id: "react",
        name: "React",
        skills: ["vercel-labs/agent-skills/vercel-react-best-practices"],
      },
    ];
    const skills = collectSkills({ detected, isFrontend: true });

    ok(skills.some((s) => s.skill === "anthropics/skills/frontend-design"));
    const bonus = skills.find((s) => s.skill === "anthropics/skills/frontend-design");
    deepStrictEqual(bonus.sources, ["Frontend"]);
  });

  it("does not add frontend bonus skills for non-frontend projects", () => {
    const detected = [
      {
        id: "typescript",
        name: "TypeScript",
        skills: ["wshobson/agents/typescript-advanced-types"],
      },
    ];
    const skills = collectSkills({ detected, isFrontend: false });

    ok(!skills.some((s) => s.skill === "anthropics/skills/frontend-design"));
  });

  it("does not duplicate frontend bonus skills if already present", () => {
    const detected = [
      { id: "custom", name: "Custom", skills: ["anthropics/skills/frontend-design"] },
    ];
    const skills = collectSkills({ detected, isFrontend: true });

    const matches = skills.filter((s) => s.skill === "anthropics/skills/frontend-design");
    strictEqual(matches.length, 1);
  });

  it("skips technologies with empty skills", () => {
    const detected = [
      { id: "svelte", name: "Svelte", skills: [] },
      {
        id: "react",
        name: "React",
        skills: ["vercel-labs/agent-skills/vercel-react-best-practices"],
      },
    ];
    const skills = collectSkills({ detected, isFrontend: false });

    strictEqual(skills.length, 1);
    strictEqual(skills[0].skill, "vercel-labs/agent-skills/vercel-react-best-practices");
  });

  it("accumulates three sources for the same skill", () => {
    const detected = [
      { id: "a", name: "Tech A", skills: ["shared/repo/shared-skill"] },
      { id: "b", name: "Tech B", skills: ["shared/repo/shared-skill"] },
      { id: "c", name: "Tech C", skills: ["shared/repo/shared-skill"] },
    ];
    const skills = collectSkills({ detected, isFrontend: false });

    strictEqual(skills.length, 1);
    deepStrictEqual(skills[0].sources, ["Tech A", "Tech B", "Tech C"]);
  });

  it("adds skills from combo skills", () => {
    const detected = [{ id: "expo", name: "Expo", skills: ["expo/skills/building-native-ui"] }];
    const combos = [
      {
        id: "expo-tailwind",
        name: "Expo + Tailwind CSS",
        skills: ["expo/skills/expo-tailwind-setup"],
      },
    ];
    const skills = collectSkills({ detected, isFrontend: false, combos });

    strictEqual(skills.length, 2);
    ok(skills.some((s) => s.skill === "expo/skills/building-native-ui"));
    ok(skills.some((s) => s.skill === "expo/skills/expo-tailwind-setup"));
  });

  it("deduplicates combo skills already present from techs", () => {
    const detected = [{ id: "expo", name: "Expo", skills: ["expo/skills/expo-tailwind-setup"] }];
    const combos = [
      {
        id: "expo-tailwind",
        name: "Expo + Tailwind CSS",
        skills: ["expo/skills/expo-tailwind-setup"],
      },
    ];
    const skills = collectSkills({ detected, isFrontend: false, combos });

    strictEqual(skills.length, 1);
    strictEqual(skills[0].skill, "expo/skills/expo-tailwind-setup");
    ok(skills[0].sources.includes("Expo"));
    ok(skills[0].sources.includes("Expo + Tailwind CSS"));
  });

  it("adds new skills from combos not present in individual techs", () => {
    const detected = [
      {
        id: "react",
        name: "React",
        skills: ["vercel-labs/agent-skills/vercel-react-best-practices"],
      },
    ];
    const combos = [
      { id: "react-custom", name: "React + Custom", skills: ["custom/repo/combo-skill"] },
    ];
    const skills = collectSkills({ detected, isFrontend: false, combos });

    strictEqual(skills.length, 2);
    ok(skills.some((s) => s.skill === "custom/repo/combo-skill"));
    const combo = skills.find((s) => s.skill === "custom/repo/combo-skill");
    deepStrictEqual(combo.sources, ["React + Custom"]);
  });

  it("works with combos and frontend bonus skills together", () => {
    const detected = [
      {
        id: "react",
        name: "React",
        skills: ["vercel-labs/agent-skills/vercel-react-best-practices"],
      },
    ];
    const combos = [{ id: "test-combo", name: "Test Combo", skills: ["combo/repo/combo-skill"] }];
    const skills = collectSkills({ detected, isFrontend: true, combos });

    ok(skills.some((s) => s.skill === "vercel-labs/agent-skills/vercel-react-best-practices"));
    ok(skills.some((s) => s.skill === "combo/repo/combo-skill"));
    ok(skills.some((s) => s.skill === "anthropics/skills/frontend-design"));
  });

  it("handles empty combos array", () => {
    const detected = [
      {
        id: "react",
        name: "React",
        skills: ["vercel-labs/agent-skills/vercel-react-best-practices"],
      },
    ];
    const skills = collectSkills({ detected, isFrontend: false, combos: [] });

    strictEqual(skills.length, 1);
    strictEqual(skills[0].skill, "vercel-labs/agent-skills/vercel-react-best-practices");
  });

  it("sets installed=false by default when no installedNames provided", () => {
    const detected = [
      {
        id: "react",
        name: "React",
        skills: ["vercel-labs/agent-skills/vercel-react-best-practices"],
      },
    ];
    const skills = collectSkills({ detected, isFrontend: false });

    strictEqual(skills[0].installed, false);
  });

  it("marks matching skills as installed when installedNames is provided", () => {
    const detected = [
      {
        id: "react",
        name: "React",
        skills: ["vercel-labs/agent-skills/vercel-react-best-practices", "other/repo/other-skill"],
      },
    ];
    const installed = new Set(["vercel-react-best-practices"]);
    const skills = collectSkills({ detected, isFrontend: false, installedNames: installed });

    strictEqual(skills[0].installed, true);
    strictEqual(skills[1].installed, false);
  });

  it("marks combo skills as installed when present in installedNames", () => {
    const detected = [{ id: "expo", name: "Expo", skills: ["expo/skills/building-native-ui"] }];
    const combos = [
      { id: "expo-tw", name: "Expo + Tailwind", skills: ["expo/skills/expo-tailwind-setup"] },
    ];
    const installed = new Set(["expo-tailwind-setup"]);
    const skills = collectSkills({
      detected,
      isFrontend: false,
      combos,
      installedNames: installed,
    });

    const combo = skills.find((s) => s.skill === "expo/skills/expo-tailwind-setup");
    strictEqual(combo.installed, true);
    const tech = skills.find((s) => s.skill === "expo/skills/building-native-ui");
    strictEqual(tech.installed, false);
  });

  it("marks frontend bonus skills as installed when present in installedNames", () => {
    const detected = [
      {
        id: "react",
        name: "React",
        skills: ["vercel-labs/agent-skills/vercel-react-best-practices"],
      },
    ];
    const installed = new Set(["frontend-design"]);
    const skills = collectSkills({ detected, isFrontend: true, installedNames: installed });

    const bonus = skills.find((s) => s.skill === "anthropics/skills/frontend-design");
    strictEqual(bonus.installed, true);
  });
});

describe("getInstalledSkillNames", () => {
  const tmp = useTmpDir();

  it("returns empty set when no lockfile and no .agents dir", () => {
    const result = getInstalledSkillNames(tmp.path);
    strictEqual(result.size, 0);
  });

  it("reads skill names from skills-lock.json", () => {
    writeJson(tmp.path, "skills-lock.json", {
      version: 1,
      skills: {
        "playwright-best-practices": { source: "currents-dev/playwright-best-practices-skill" },
        "neon-postgres": { source: "neondatabase/agent-skills" },
      },
    });
    const result = getInstalledSkillNames(tmp.path);
    strictEqual(result.size, 2);
    ok(result.has("playwright-best-practices"));
    ok(result.has("neon-postgres"));
  });

  it("falls back to .agents/skills/ directory when no lockfile", () => {
    writeFile(tmp.path, ".agents/skills/next-best-practices/.keep");
    writeFile(tmp.path, ".agents/skills/shadcn/.keep");
    const result = getInstalledSkillNames(tmp.path);
    strictEqual(result.size, 2);
    ok(result.has("next-best-practices"));
    ok(result.has("shadcn"));
  });

  it("prefers lockfile over directory listing", () => {
    writeJson(tmp.path, "skills-lock.json", {
      version: 1,
      skills: { "from-lock": { source: "test/repo" } },
    });
    writeFile(tmp.path, ".agents/skills/from-dir/.keep");
    const result = getInstalledSkillNames(tmp.path);
    strictEqual(result.size, 1);
    ok(result.has("from-lock"));
  });

  it("returns empty set for invalid lockfile JSON", () => {
    writeFile(tmp.path, "skills-lock.json", "not json{{{");
    const result = getInstalledSkillNames(tmp.path);
    strictEqual(result.size, 0);
  });
});

describe("multiSelect", () => {
  it("throws when initialSelected length does not match items length", () => {
    throws(
      () =>
        multiSelect(["a", "b", "c"], {
          labelFn: (x) => x,
          initialSelected: [true, false],
        }),
      /initialSelected length \(2\) must match items length \(3\)/,
    );
  });

  it("returns all items when stdin is not a TTY", async () => {
    const items = [{ name: "a" }, { name: "b" }];
    const result = await multiSelect(items, { labelFn: (x) => x.name });
    deepStrictEqual(result, items);
  });
});
