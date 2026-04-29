import { describe, it } from "node:test";
import { ok, strictEqual, throws } from "node:assert/strict";
import { SKILLS_MAP, COMBO_SKILLS_MAP } from "../skills-map.ts";
import type { Technology, ComboSkill, DetectConfig } from "../skills-map.ts";

// ── Helpers ───────────────────────────────────────────────────

function findDuplicates(values: string[]): string[] {
  const counts = new Map<string, number>();
  for (const value of values) {
    counts.set(value, (counts.get(value) ?? 0) + 1);
  }
  return [...counts.entries()]
    .filter(([, count]) => count > 1)
    .map(([value]) => value)
    .sort();
}

function isNonEmptyString(value: unknown): value is string {
  return typeof value === "string" && value.trim().length > 0;
}

function isValidSkillRef(skill: string): boolean {
  if (/^https?:\/\/\S+$/u.test(skill)) return true;
  const parts = skill.split("/");
  if (parts.length < 3) return false;
  const [owner, repo, ...rest] = parts;
  return (
    isNonEmptyString(owner) &&
    isNonEmptyString(repo) &&
    isNonEmptyString(rest.join("/"))
  );
}

function hasAtLeastOneDetectSignal(detect: DetectConfig): boolean {
  return Boolean(
    detect.packages?.length ||
      detect.packagePatterns?.length ||
      detect.configFiles?.length ||
      detect.gems?.length ||
      detect.configFileContent,
  );
}

function toConfigBlocks(
  value: DetectConfig["configFileContent"],
): Array<NonNullable<DetectConfig["configFileContent"]>> {
  if (!value) return [];
  return Array.isArray(value) ? value : [value];
}

// ── Per-entry validators ──────────────────────────────────────

function validateDetectConfig(tech: Technology): void {
  const { detect } = tech;

  ok(detect && typeof detect === "object", `[${tech.id}] detect must exist`);
  ok(
    hasAtLeastOneDetectSignal(detect),
    `[${tech.id}] detect has no signals — define at least one of: packages, configFiles, gems, packagePatterns, or configFileContent`,
  );

  if (detect.packages !== undefined) {
    ok(Array.isArray(detect.packages), `[${tech.id}] detect.packages must be an array`);
    ok(
      detect.packages.length > 0,
      `[${tech.id}] detect.packages is empty — add at least one package name (e.g. ["react", "react-dom"])`,
    );
    for (const pkg of detect.packages) {
      ok(
        isNonEmptyString(pkg),
        `[${tech.id}] detect.packages contains an empty or non-string value`,
      );
    }
  }

  if (detect.packagePatterns !== undefined) {
    ok(
      Array.isArray(detect.packagePatterns),
      `[${tech.id}] detect.packagePatterns must be an array`,
    );
    ok(
      detect.packagePatterns.length > 0,
      `[${tech.id}] detect.packagePatterns is empty — add at least one RegExp (e.g. [/^@aws-sdk\\//])`,
    );
    for (const pattern of detect.packagePatterns) {
      ok(
        pattern instanceof RegExp,
        `[${tech.id}] detect.packagePatterns contains a non-RegExp value — use /pattern/ syntax, not a string`,
      );
    }
  }

  if (detect.configFiles !== undefined) {
    ok(Array.isArray(detect.configFiles), `[${tech.id}] detect.configFiles must be an array`);
    ok(
      detect.configFiles.length > 0,
      `[${tech.id}] detect.configFiles is empty — add at least one filename (e.g. ["next.config.js", "next.config.ts"])`,
    );
    for (const file of detect.configFiles) {
      ok(
        isNonEmptyString(file),
        `[${tech.id}] detect.configFiles contains an empty or non-string value`,
      );
    }
  }

  if (detect.gems !== undefined) {
    ok(Array.isArray(detect.gems), `[${tech.id}] detect.gems must be an array`);
    ok(
      detect.gems.length > 0,
      `[${tech.id}] detect.gems is empty — add at least one gem name (e.g. ["rails", "sinatra"])`,
    );
    for (const gem of detect.gems) {
      ok(isNonEmptyString(gem), `[${tech.id}] detect.gems contains an empty or non-string value`);
    }
  }

  for (const block of toConfigBlocks(detect.configFileContent)) {
    ok(block && typeof block === "object", `[${tech.id}] configFileContent block must be an object`);
    ok(Array.isArray(block.patterns), `[${tech.id}] configFileContent.patterns must be an array`);
    ok(
      block.patterns.length > 0,
      `[${tech.id}] configFileContent.patterns is empty — add at least one string pattern to search for`,
    );
    for (const pattern of block.patterns) {
      ok(
        isNonEmptyString(pattern),
        `[${tech.id}] configFileContent.patterns contains an empty or non-string value`,
      );
    }

    if (!block.scanGradleLayout && !block.scanDotNetLayout) {
      ok(
        Array.isArray(block.files),
        `[${tech.id}] configFileContent.files must be an array (or set scanGradleLayout: true for Gradle projects, scanDotNetLayout: true for .NET projects)`,
      );
      ok(
        block.files.length > 0,
        `[${tech.id}] configFileContent.files is empty — add at least one filename to search in`,
      );
      for (const file of block.files) {
        ok(
          isNonEmptyString(file),
          `[${tech.id}] configFileContent.files contains an empty or non-string value`,
        );
      }
    }
  }
}

function validateSkillList(ownerId: string, skills: string[]): void {
  ok(Array.isArray(skills), `[${ownerId}] skills must be an array`);

  for (const skill of skills) {
    ok(isNonEmptyString(skill), `[${ownerId}] skills contains an empty or non-string value`);
    ok(
      isValidSkillRef(skill),
      `[${ownerId}] skill "${skill}" is not a valid reference — use "owner/repo/skill-name" (e.g. "vercel-labs/agent-skills/vercel-react-best-practices") or an https:// URL`,
    );
  }

  const duplicateSkills = findDuplicates(skills);
  strictEqual(
    duplicateSkills.length,
    0,
    `[${ownerId}] duplicate skill references: ${duplicateSkills.join(", ")} — each skill can appear only once per entry`,
  );
}

function validateTechnologyEntry(tech: Technology): void {
  ok(
    isNonEmptyString(tech.id),
    `technology.id is missing or empty — every SKILLS_MAP entry needs a stable unique id (e.g. "react", "nextjs", "prisma")`,
  );
  ok(
    isNonEmptyString(tech.name),
    `[${tech.id ?? "?"}] name is missing or empty — add a user-facing display name (e.g. "React", "Next.js")`,
  );
  validateDetectConfig(tech);
  validateSkillList(tech.id, tech.skills);
}

function validateComboEntry(combo: ComboSkill, technologyIds: Set<string>): void {
  ok(
    isNonEmptyString(combo.id),
    `combo.id is missing or empty — every COMBO_SKILLS_MAP entry needs a stable unique id (e.g. "nextjs-supabase")`,
  );
  ok(
    isNonEmptyString(combo.name),
    `[${combo.id ?? "?"}] name is missing or empty — add a user-facing name (e.g. "Next.js + Supabase")`,
  );

  ok(Array.isArray(combo.requires), `[${combo.id}] requires must be an array`);
  ok(
    combo.requires.length >= 2,
    `[${combo.id}] requires must list at least two technology ids — combos need a minimum of two technologies`,
  );

  for (const requiredId of combo.requires) {
    ok(isNonEmptyString(requiredId), `[${combo.id}] requires contains an empty or non-string id`);
    ok(
      technologyIds.has(requiredId),
      `[${combo.id}] requires "${requiredId}" which is not in SKILLS_MAP — fix the typo or add the technology first`,
    );
  }

  const duplicateRequires = findDuplicates(combo.requires);
  strictEqual(
    duplicateRequires.length,
    0,
    `[${combo.id}] duplicate ids in requires: ${duplicateRequires.join(", ")} — list each technology id once`,
  );

  validateSkillList(combo.id, combo.skills);
}

// ── SKILLS_MAP ────────────────────────────────────────────────

describe("SKILLS_MAP validation", () => {
  it("has unique technology ids", () => {
    const duplicates = findDuplicates(SKILLS_MAP.map((tech) => tech.id));
    strictEqual(duplicates.length, 0, `duplicate technology ids: ${duplicates.join(", ")}`);
  });

  it("validates every technology entry shape", () => {
    for (const tech of SKILLS_MAP) {
      validateTechnologyEntry(tech);
    }
  });
});

// ── COMBO_SKILLS_MAP ──────────────────────────────────────────

describe("COMBO_SKILLS_MAP validation", () => {
  const technologyIds = new Set(SKILLS_MAP.map((tech) => tech.id));

  it("has unique combo ids", () => {
    const duplicates = findDuplicates(COMBO_SKILLS_MAP.map((combo) => combo.id));
    strictEqual(duplicates.length, 0, `duplicate combo ids: ${duplicates.join(", ")}`);
  });

  it("validates every combo entry shape", () => {
    for (const combo of COMBO_SKILLS_MAP) {
      validateComboEntry(combo, technologyIds);
    }
  });
});

// ── Feedback quality: error messages must be actionable ───────
//
// TDD contract: when a contributor submits a malformed entry,
// the assertion message must tell them exactly what to fix.

describe("validation gives actionable feedback on bad entries", () => {
  const VALID_SKILL = "owner/repo/skill-name";
  const VALID_DETECT: DetectConfig = { packages: ["some-package"] };

  function expectsError(fn: () => void, pattern: RegExp): void {
    throws(fn, (err: unknown) => {
      const message = err instanceof Error ? err.message : String(err);
      ok(
        pattern.test(message),
        `\nExpected error message matching: ${pattern}\nGot: "${message}"`,
      );
      return true;
    });
  }

  it("reports missing technology id with a usage hint", () => {
    expectsError(
      () =>
        validateTechnologyEntry({
          name: "My Tech",
          detect: VALID_DETECT,
          skills: [VALID_SKILL],
        } as Technology),
      /e\.g\.|stable.*id|unique.*id/i,
    );
  });

  it("reports empty detect by listing all available signal types", () => {
    expectsError(
      () =>
        validateTechnologyEntry({
          id: "my-tech",
          name: "My Tech",
          detect: {},
          skills: [VALID_SKILL],
        }),
      /packages.*configFiles.*gems.*packagePatterns.*configFileContent/,
    );
  });

  it("reports empty detect.packages with an example array", () => {
    expectsError(
      () =>
        validateTechnologyEntry({
          id: "my-tech",
          name: "My Tech",
          detect: { packages: [] },
          skills: [VALID_SKILL],
        }),
      /empty|at least one/i,
    );
  });

  it("reports non-RegExp in packagePatterns with usage hint", () => {
    expectsError(
      () =>
        validateTechnologyEntry({
          id: "my-tech",
          name: "My Tech",
          detect: { packagePatterns: ["not-a-regexp"] as unknown as RegExp[] },
          skills: [VALID_SKILL],
        }),
      /RegExp|\/pattern\//,
    );
  });

  it("reports invalid skill reference with expected format and example", () => {
    expectsError(
      () =>
        validateTechnologyEntry({
          id: "my-tech",
          name: "My Tech",
          detect: VALID_DETECT,
          skills: ["not-valid"],
        }),
      /owner\/repo\/skill-name/,
    );
  });

  it("reports duplicate skills within an entry", () => {
    expectsError(
      () =>
        validateTechnologyEntry({
          id: "my-tech",
          name: "My Tech",
          detect: VALID_DETECT,
          skills: [VALID_SKILL, VALID_SKILL],
        }),
      /duplicate/i,
    );
  });

  it("reports unknown combo requires id with actionable message", () => {
    const technologyIds = new Set(["react", "nextjs"]);
    expectsError(
      () =>
        validateComboEntry(
          {
            id: "my-combo",
            name: "My Combo",
            requires: ["react", "nonexistent-tech"],
            skills: [VALID_SKILL],
          },
          technologyIds,
        ),
      /"nonexistent-tech".*SKILLS_MAP|SKILLS_MAP.*"nonexistent-tech"/,
    );
  });

  it("reports missing configFileContent.files with scanGradleLayout hint", () => {
    expectsError(
      () =>
        validateTechnologyEntry({
          id: "my-tech",
          name: "My Tech",
          detect: { configFileContent: { patterns: ["some-pattern"] } },
          skills: [VALID_SKILL],
        }),
      /files.*array|scanGradleLayout/,
    );
  });
});
