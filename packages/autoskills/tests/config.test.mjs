import { describe, it, beforeEach, afterEach } from "node:test";
import assert from "node:assert/strict";
import { mkdtempSync, mkdirSync, writeFileSync, rmSync } from "node:fs";
import { join } from "node:path";
import { tmpdir } from "node:os";
import {
  findLocalConfig,
  findGlobalConfig,
  loadConfigFile,
  mergeSkillsMap,
  detectTechnologies,
} from "../lib.mjs";

describe("config utilities", () => {
  let tmpDir;

  beforeEach(() => {
    tmpDir = mkdtempSync(join(tmpdir(), "autoskills-config-"));
  });

  afterEach(() => {
    rmSync(tmpDir, { recursive: true, force: true });
  });

  it("findLocalConfig resolves .autoskillsrc.json in current directory", () => {
    const root = join(tmpDir, "project");
    const nested = join(root, "apps", "web");
    mkdirSync(nested, { recursive: true });
    writeFileSync(join(nested, ".autoskillsrc.mjs"), "export default []");
    writeFileSync(join(nested, ".autoskillsrc.json"), "[]");
    assert.strictEqual(findLocalConfig(nested), join(nested, ".autoskillsrc.json"));
  });

  it("findLocalConfig supports autoskills.config.*", () => {
    const root = join(tmpDir, "project");
    mkdirSync(root, { recursive: true });
    writeFileSync(join(root, "autoskills.config.mjs"), "export default []");
    assert.strictEqual(findLocalConfig(root), join(root, "autoskills.config.mjs"));
  });

  it("findLocalConfig prioritizes .autoskillsrc.* over autoskills.config.*", () => {
    const root = join(tmpDir, "project");
    mkdirSync(root, { recursive: true });
    writeFileSync(join(root, "autoskills.config.js"), "module.exports = []");
    writeFileSync(join(root, ".autoskillsrc.js"), "module.exports = []");
    assert.strictEqual(findLocalConfig(root), join(root, ".autoskillsrc.js"));
  });

  it("findLocalConfig does not walk parent directories", () => {
    const root = join(tmpDir, "project");
    const nested = join(root, "apps", "web");
    mkdirSync(nested, { recursive: true });
    writeFileSync(join(root, ".autoskillsrc.json"), "[]");
    assert.strictEqual(findLocalConfig(nested), null);
  });

  it("findGlobalConfig resolves parent directories with same filenames", () => {
    const root = join(tmpDir, "project");
    const parent = join(root, "apps");
    const nested = join(parent, "web");
    mkdirSync(nested, { recursive: true });
    writeFileSync(join(parent, ".autoskillsrc.json"), "[]");
    assert.strictEqual(findGlobalConfig(nested), join(parent, ".autoskillsrc.json"));
  });

  it("findGlobalConfig supports autoskills.config.* in parent directories", () => {
    const root = join(tmpDir, "project");
    const parent = join(root, "apps");
    const nested = join(parent, "web");
    mkdirSync(nested, { recursive: true });
    writeFileSync(join(parent, "autoskills.config.js"), "module.exports = []");
    assert.strictEqual(findGlobalConfig(nested), join(parent, "autoskills.config.js"));
  });

  it("loadConfigFile loads both JSON and JS modules", async () => {
    const jsonPath = join(tmpDir, ".autoskillsrc.json");
    const jsPath = join(tmpDir, ".autoskillsrc.mjs");
    writeFileSync(
      jsonPath,
      JSON.stringify([{ id: "x", name: "X", detect: { packages: ["x"] }, skills: ["a/b/x"] }]),
    );
    writeFileSync(
      jsPath,
      "export default [{ id: 'y', name: 'Y', detect: { packages: ['y'] }, skills: ['a/b/y'] }]",
    );

    const fromJson = await loadConfigFile(jsonPath);
    const fromJs = await loadConfigFile(jsPath);
    assert.strictEqual(fromJson[0].id, "x");
    assert.strictEqual(fromJs[0].id, "y");
  });

  it("mergeSkillsMap replaces matching ids and appends new ones", () => {
    const base = [
      { id: "react", name: "React", detect: { packages: ["react"] }, skills: ["a/b/react"] },
    ];
    const overrides = [
      { id: "react", name: "React Custom", detect: { packages: ["react"] }, skills: ["c/d/react"] },
      { id: "acme", name: "Acme", detect: { packages: ["@acme/sdk"] }, skills: ["a/b/acme"] },
    ];
    const merged = mergeSkillsMap(base, overrides);
    assert.strictEqual(merged.find((entry) => entry.id === "react")?.name, "React Custom");
    assert.ok(merged.some((entry) => entry.id === "acme"));
  });
});

describe("detectTechnologies with user config", () => {
  let tmpDir;
  let originalHome;

  beforeEach(() => {
    tmpDir = mkdtempSync(join(tmpdir(), "autoskills-detect-config-"));
    originalHome = process.env.HOME;
  });

  afterEach(() => {
    process.env.HOME = originalHome;
    rmSync(tmpDir, { recursive: true, force: true });
  });

  it("applies local overrides over built-in skills", async () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { react: "^19.0.0" } }),
    );
    writeFileSync(
      join(tmpDir, ".autoskillsrc.json"),
      JSON.stringify([
        {
          id: "react",
          name: "React Custom",
          detect: { packages: ["react"] },
          skills: ["my-org/agent-skills/react-custom"],
        },
      ]),
    );

    const { detected } = await detectTechnologies(tmpDir);
    const react = detected.find((entry) => entry.id === "react");
    assert.ok(react);
    assert.strictEqual(react.name, "React Custom");
    assert.deepStrictEqual(react.skills, ["my-org/agent-skills/react-custom"]);
  });

  it("applies local over global precedence", async () => {
    const parent = join(tmpDir, "parent");
    const project = join(parent, "project");
    mkdirSync(project, { recursive: true });

    writeFileSync(
      join(project, "package.json"),
      JSON.stringify({ dependencies: { react: "^19.0.0" } }),
    );
    writeFileSync(
      join(parent, "autoskills.config.js"),
      "module.exports = [{ id: 'react', name: 'React Global', detect: { packages: ['react'] }, skills: ['my-org/agent-skills/react-global'] }]",
    );
    writeFileSync(
      join(project, "autoskills.config.mjs"),
      "export default [{ id: 'react', name: 'React Local', detect: { packages: ['react'] }, skills: ['my-org/agent-skills/react-local'] }]",
    );

    const { detected } = await detectTechnologies(project);
    const react = detected.find((entry) => entry.id === "react");
    assert.ok(react);
    assert.strictEqual(react.name, "React Local");
    assert.deepStrictEqual(react.skills, ["my-org/agent-skills/react-local"]);
  });

  it("warns and continues when config is invalid", async () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { react: "^19.0.0" } }),
    );
    writeFileSync(join(tmpDir, ".autoskillsrc.json"), "{ invalid json");

    const warnings = [];
    const originalWarn = console.warn;
    console.warn = (message) => warnings.push(message);

    try {
      const { detected } = await detectTechnologies(tmpDir);
      assert.ok(detected.some((entry) => entry.id === "react"));
      assert.ok(warnings.some((message) => String(message).includes("Skipping local config")));
    } finally {
      console.warn = originalWarn;
    }
  });
});
