import test from "node:test";
import assert from "node:assert/strict";

import { buildRuntimeRegistry, RUNTIME_REGISTRY } from "../runtime-registry.mjs";

const { indexes, combos } = RUNTIME_REGISTRY;

test("indexes exact packages and config files", () => {
  assert.ok(indexes.byPackage.react.includes("react"));
  assert.ok(indexes.byPackage.next.includes("nextjs"));
  assert.ok(indexes.byConfigFile["components.json"].includes("shadcn"));
});

test("combo.skills is normalized to combo.add", () => {
  const combo = combos.find((c) => c.id === "gsap-react");
  assert.ok(combo);
  assert.deepEqual(combo.add, ["greensock/gsap-skills/gsap-react"]);
});

test("combos that already use add are preserved as-is", () => {
  const registry = buildRuntimeRegistry(
    [],
    [
      {
        id: "react-shadcn",
        name: "React + shadcn/ui",
        requires: ["react", "shadcn"],
        add: ["example/react-shadcn"],
      },
    ],
  );

  assert.deepEqual(registry.combos[0].add, ["example/react-shadcn"]);
});
