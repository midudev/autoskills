import { describe, it } from "node:test";
import { ok, strictEqual, deepStrictEqual } from "node:assert/strict";
import { collectSkills } from "../lib.mjs";
import { DEFAULT_SKILLS } from "../skills-map.mjs";

describe("collectSkills", () => {
  it("returns default skills when no technologies detected", () => {
    const skills = collectSkills([], false);
    deepStrictEqual(skills, DEFAULT_SKILLS.map(skill => ({ skill, sources: ["Default"] })));
  });

  it("collects skills from a single technology", () => {
    const detected = [
      {
        id: "react",
        name: "React",
        skills: ["vercel-labs/agent-skills/vercel-react-best-practices"],
      },
    ];
    const skills = collectSkills(detected, false);

    strictEqual(skills.length, 1 + DEFAULT_SKILLS.length);
    strictEqual(skills[0].skill, "vercel-labs/agent-skills/vercel-react-best-practices");
    deepStrictEqual(skills[0].sources, ["React"]);
  });

  it("deduplicates skills shared across technologies", () => {
    const detected = [
      { id: "a", name: "Tech A", skills: ["shared/repo/my-skill"] },
      { id: "b", name: "Tech B", skills: ["shared/repo/my-skill"] },
    ];
    const skills = collectSkills(detected, false);

    strictEqual(skills.length, 1 + DEFAULT_SKILLS.length);
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
    const skills = collectSkills(detected, false);

    strictEqual(skills.length, 2 + DEFAULT_SKILLS.length);
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
    const skills = collectSkills(detected, false);

    strictEqual(skills.length, 2 + DEFAULT_SKILLS.length);
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
    const skills = collectSkills(detected, true);

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
    const skills = collectSkills(detected, false);

    ok(!skills.some((s) => s.skill === "anthropics/skills/frontend-design"));
  });

  it("does not duplicate frontend bonus skills if already present", () => {
    const detected = [
      { id: "custom", name: "Custom", skills: ["anthropics/skills/frontend-design"] },
    ];
    const skills = collectSkills(detected, true);

    const matches = skills.filter((s) => s.skill === "anthropics/skills/frontend-design");
    strictEqual(matches.length, 1);
    strictEqual(skills.length, 3 + DEFAULT_SKILLS.length); // 3 Frontend Bonus skills + Default
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
    const skills = collectSkills(detected, false);

    strictEqual(skills.length, 1 + DEFAULT_SKILLS.length);
    strictEqual(skills[0].skill, "vercel-labs/agent-skills/vercel-react-best-practices");
  });

  it("accumulates three sources for the same skill", () => {
    const detected = [
      { id: "a", name: "Tech A", skills: ["shared/repo/shared-skill"] },
      { id: "b", name: "Tech B", skills: ["shared/repo/shared-skill"] },
      { id: "c", name: "Tech C", skills: ["shared/repo/shared-skill"] },
    ];
    const skills = collectSkills(detected, false);

    strictEqual(skills.length, 1 + DEFAULT_SKILLS.length);
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
    const skills = collectSkills(detected, false, combos);

    strictEqual(skills.length, 2 + DEFAULT_SKILLS.length);
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
    const skills = collectSkills(detected, false, combos);

    strictEqual(skills.length, 1 + DEFAULT_SKILLS.length);
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
    const skills = collectSkills(detected, false, combos);

    strictEqual(skills.length, 2 + DEFAULT_SKILLS.length);
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
    const skills = collectSkills(detected, true, combos);

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
    const skills = collectSkills(detected, false, []);

    strictEqual(skills.length, 1 + DEFAULT_SKILLS.length);
    strictEqual(skills[0].skill, "vercel-labs/agent-skills/vercel-react-best-practices");
  });

  it("always includes DEFAULT_SKILLS perfectly even when other technologies are present", () => {
    const detected = [
      { id: "react", name: "React", skills: ["vercel-labs/agent-skills/vercel-react-best-practices"] },
    ];
    const skills = collectSkills(detected, false);
    
    strictEqual(skills.length, 1 + DEFAULT_SKILLS.length);
    for (const defaultSkill of DEFAULT_SKILLS) {
      ok(skills.some(s => s.skill === defaultSkill), `Missing default skill: ${defaultSkill}`);
      const entry = skills.find(s => s.skill === defaultSkill);
      ok(entry.sources.includes("Default"), `Source "Default" not assigned to: ${defaultSkill}`);
    }
  });
});
