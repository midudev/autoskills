import test from "node:test";
import assert from "node:assert/strict";

import {
  buildRuntimeRegistry,
  NORMALIZED_COMBO_SKILLS_MAP,
  PACKAGE_TO_TECH_IDS,
  CONFIG_FILE_TO_TECH_IDS,
} from "../runtime-registry.mjs";

test("buildRuntimeRegistry indexes exact package and config-file detections", () => {
  assert.ok(PACKAGE_TO_TECH_IDS.react.includes("react"));
  assert.ok(PACKAGE_TO_TECH_IDS.next.includes("nextjs"));
  assert.ok(CONFIG_FILE_TO_TECH_IDS["components.json"].includes("shadcn"));
});

test("legacy combo skills are normalized into addSkills", () => {
  const combo = NORMALIZED_COMBO_SKILLS_MAP.find((entry) => entry.id === "gsap-react");
  assert.ok(combo);
  assert.deepEqual(combo.addSkills, ["greensock/gsap-skills/gsap-react"]);
});

test("buildRuntimeRegistry can normalize combo rules that already use addSkills", () => {
  const registry = buildRuntimeRegistry(
    [],
    [
      {
        id: "react-shadcn",
        name: "React + shadcn/ui",
        requires: ["react", "shadcn"],
        addSkills: ["example/react-shadcn"],
      },
    ],
  );

  assert.deepEqual(registry.combos[0].addSkills, ["example/react-shadcn"]);
});
