import { describe, it } from "node:test";
import { ok, strictEqual, deepStrictEqual, throws } from "node:assert/strict";
import { collectSkills, detectTechnologies, getInstalledSkillNames } from "../lib.ts";
import { multiSelect } from "../ui.ts";
import { useTmpDir, writeJson, writeFile, writePackageJson } from "./helpers.ts";

describe("collectSkills", () => {
  const tmp = useTmpDir();

  it("returns empty array when no technologies detected", () => {
    const skills = collectSkills({ detected: [], isFrontend: false });
    deepStrictEqual(skills, []);
  });

  it("collects skills from a single technology", () => {
    const detected = [
      {
        id: "react",
        name: "React",
        detect: {},
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
      { id: "a", name: "Tech A", detect: {}, skills: ["shared/repo/my-skill"] },
      { id: "b", name: "Tech B", detect: {}, skills: ["shared/repo/my-skill"] },
    ];
    const skills = collectSkills({ detected, isFrontend: false });
    strictEqual(skills.length, 1);
    deepStrictEqual(skills[0].sources, ["Tech A", "Tech B"]);
  });

  it("keeps unique skills from different technologies", () => {
    const detected = [
      {
        id: "react",
        name: "React",
        detect: {},
        skills: ["vercel-labs/agent-skills/vercel-react-best-practices"],
      },
      {
        id: "nextjs",
        name: "Next.js",
        detect: {},
        skills: ["vercel-labs/next-skills/next-best-practices"],
      },
    ];
    const skills = collectSkills({ detected, isFrontend: false });
    strictEqual(skills.length, 2);
  });

  it("handles technologies with multiple skills", () => {
    const detected = [
      {
        id: "vue",
        name: "Vue",
        detect: {},
        skills: ["hyf0/vue-skills/vue-best-practices", "antfu/skills/vue"],
      },
    ];
    const skills = collectSkills({ detected, isFrontend: false });
    strictEqual(skills.length, 2);
  });

  it("collects Go curated skills in declared order", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "go.mod", "module example.com/test\n\ngo 1.24.0\n");
    const { detected } = detectTechnologies(tmp.path);
    const skills = collectSkills({ detected, isFrontend: false });
    deepStrictEqual(
      skills.slice(0, 2).map(({ skill, sources }) => ({ skill, sources })),
      [
        { skill: "affaan-m/everything-claude-code/golang-patterns", sources: ["Go"] },
        { skill: "affaan-m/everything-claude-code/golang-testing", sources: ["Go"] },
      ],
    );
  });

  it("adds frontend bonus skills for frontend projects", () => {
    const detected = [
      {
        id: "react",
        name: "React",
        detect: {},
        skills: ["vercel-labs/agent-skills/vercel-react-best-practices"],
      },
    ];
    const skills = collectSkills({ detected, isFrontend: true });
    ok(skills.some((s) => s.skill === "anthropics/skills/frontend-design"));
    const bonus = skills.find((s) => s.skill === "anthropics/skills/frontend-design");
    deepStrictEqual(bonus!.sources, ["Frontend"]);
  });

  it("does not add frontend bonus skills for non-frontend projects", () => {
    const detected = [
      {
        id: "typescript",
        name: "TypeScript",
        detect: {},
        skills: ["wshobson/agents/typescript-advanced-types"],
      },
    ];
    const skills = collectSkills({ detected, isFrontend: false });
    ok(!skills.some((s) => s.skill === "anthropics/skills/frontend-design"));
  });

  it("does not duplicate frontend bonus skills if already present", () => {
    const detected = [
      { id: "custom", name: "Custom", detect: {}, skills: ["anthropics/skills/frontend-design"] },
    ];
    const skills = collectSkills({ detected, isFrontend: true });
    strictEqual(skills.filter((s) => s.skill === "anthropics/skills/frontend-design").length, 1);
  });

  it("skips technologies with empty skills", () => {
    const detected = [
      { id: "svelte", name: "Svelte", detect: {}, skills: [] as string[] },
      {
        id: "react",
        name: "React",
        detect: {},
        skills: ["vercel-labs/agent-skills/vercel-react-best-practices"],
      },
    ];
    const skills = collectSkills({ detected, isFrontend: false });
    strictEqual(skills.length, 1);
  });

  it("accumulates three sources for the same skill", () => {
    const detected = [
      { id: "a", name: "Tech A", detect: {}, skills: ["shared/repo/shared-skill"] },
      { id: "b", name: "Tech B", detect: {}, skills: ["shared/repo/shared-skill"] },
      { id: "c", name: "Tech C", detect: {}, skills: ["shared/repo/shared-skill"] },
    ];
    const skills = collectSkills({ detected, isFrontend: false });
    strictEqual(skills.length, 1);
    deepStrictEqual(skills[0].sources, ["Tech A", "Tech B", "Tech C"]);
  });

  it("adds skills from combo skills", () => {
    const detected = [
      { id: "expo", name: "Expo", detect: {}, skills: ["expo/skills/building-native-ui"] },
    ];
    const combos = [
      {
        id: "expo-tailwind",
        name: "Expo + Tailwind CSS",
        requires: ["expo", "tailwind"],
        skills: ["expo/skills/expo-tailwind-setup"],
      },
    ];
    const skills = collectSkills({ detected, isFrontend: false, combos });
    strictEqual(skills.length, 2);
    ok(skills.some((s) => s.skill === "expo/skills/building-native-ui"));
    ok(skills.some((s) => s.skill === "expo/skills/expo-tailwind-setup"));
  });

  it("deduplicates combo skills already present from techs", () => {
    const detected = [
      { id: "expo", name: "Expo", detect: {}, skills: ["expo/skills/expo-tailwind-setup"] },
    ];
    const combos = [
      {
        id: "expo-tailwind",
        name: "Expo + Tailwind CSS",
        requires: ["expo", "tailwind"],
        skills: ["expo/skills/expo-tailwind-setup"],
      },
    ];
    const skills = collectSkills({ detected, isFrontend: false, combos });
    strictEqual(skills.length, 1);
    ok(skills[0].sources.includes("Expo"));
    ok(skills[0].sources.includes("Expo + Tailwind CSS"));
  });

  it("adds new skills from combos not present in individual techs", () => {
    const detected = [
      {
        id: "react",
        name: "React",
        detect: {},
        skills: ["vercel-labs/agent-skills/vercel-react-best-practices"],
      },
    ];
    const combos = [
      {
        id: "react-custom",
        name: "React + Custom",
        requires: ["react"],
        skills: ["custom/repo/combo-skill"],
      },
    ];
    const skills = collectSkills({ detected, isFrontend: false, combos });
    strictEqual(skills.length, 2);
    ok(skills.some((s) => s.skill === "custom/repo/combo-skill"));
  });

  it("works with combos and frontend bonus skills together", () => {
    const detected = [
      {
        id: "react",
        name: "React",
        detect: {},
        skills: ["vercel-labs/agent-skills/vercel-react-best-practices"],
      },
    ];
    const combos = [
      {
        id: "test-combo",
        name: "Test Combo",
        requires: ["react"],
        skills: ["combo/repo/combo-skill"],
      },
    ];
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
        detect: {},
        skills: ["vercel-labs/agent-skills/vercel-react-best-practices"],
      },
    ];
    const skills = collectSkills({ detected, isFrontend: false, combos: [] });
    strictEqual(skills.length, 1);
  });

  it("sets installed=false by default when no installedNames provided", () => {
    const detected = [
      {
        id: "react",
        name: "React",
        detect: {},
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
        detect: {},
        skills: ["vercel-labs/agent-skills/vercel-react-best-practices", "other/repo/other-skill"],
      },
    ];
    const installed = new Set(["vercel-react-best-practices"]);
    const skills = collectSkills({ detected, isFrontend: false, installedNames: installed });
    strictEqual(skills[0].installed, true);
    strictEqual(skills[1].installed, false);
  });

  it("marks combo skills as installed when present in installedNames", () => {
    const detected = [
      { id: "expo", name: "Expo", detect: {}, skills: ["expo/skills/building-native-ui"] },
    ];
    const combos = [
      {
        id: "expo-tw",
        name: "Expo + Tailwind",
        requires: ["expo", "tailwind"],
        skills: ["expo/skills/expo-tailwind-setup"],
      },
    ];
    const installed = new Set(["expo-tailwind-setup"]);
    const skills = collectSkills({
      detected,
      isFrontend: false,
      combos,
      installedNames: installed,
    });
    strictEqual(skills.find((s) => s.skill === "expo/skills/expo-tailwind-setup")!.installed, true);
    strictEqual(skills.find((s) => s.skill === "expo/skills/building-native-ui")!.installed, false);
  });

  it("marks frontend bonus skills as installed when present in installedNames", () => {
    const detected = [
      {
        id: "react",
        name: "React",
        detect: {},
        skills: ["vercel-labs/agent-skills/vercel-react-best-practices"],
      },
    ];
    const installed = new Set(["frontend-design"]);
    const skills = collectSkills({ detected, isFrontend: true, installedNames: installed });
    strictEqual(
      skills.find((s) => s.skill === "anthropics/skills/frontend-design")!.installed,
      true,
    );
  });
});

describe("getInstalledSkillNames", () => {
  const tmp = useTmpDir();

  it("returns empty set when no lockfile and no .agents dir", () => {
    strictEqual(getInstalledSkillNames(tmp.path).size, 0);
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
    strictEqual(getInstalledSkillNames(tmp.path).size, 0);
  });
});

describe("multiSelect", () => {
  it("throws when initialSelected length does not match items length", () => {
    throws(
      () => multiSelect(["a", "b", "c"], { labelFn: (x) => x, initialSelected: [true, false] }),
      /initialSelected length \(2\) must match items length \(3\)/,
    );
  });

  it("returns all items when stdin is not a TTY", async () => {
    const items = [{ name: "a" }, { name: "b" }];
    const result = await multiSelect(items, { labelFn: (x) => x.name });
    deepStrictEqual(result, items);
  });
});
