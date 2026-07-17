import { describe, it } from "node:test";
import { ok, strictEqual, deepStrictEqual } from "node:assert/strict";
import { existsSync, mkdirSync, readFileSync, symlinkSync } from "node:fs";
import { join } from "node:path";

import { useTmpDir, writeFile, writeJson } from "./helpers.ts";
import { listInstalledSkills, uninstallSkill } from "../uninstaller.ts";

function setupInstalledSkill(
  projectDir: string,
  name: string,
  {
    withLockEntry = true,
    withAgentLink = true,
  }: { withLockEntry?: boolean; withAgentLink?: boolean } = {},
): void {
  const canonical = join(projectDir, ".agents", "skills", name);
  mkdirSync(canonical, { recursive: true });
  writeFile(canonical, "SKILL.md", `# ${name}\n`);

  if (withAgentLink) {
    const claudeSkills = join(projectDir, ".claude", "skills");
    mkdirSync(claudeSkills, { recursive: true });
    try {
      symlinkSync(canonical, join(claudeSkills, name), "dir");
    } catch {
      // Symlink may fail on filesystems that don't support it; fall back to a real dir.
      mkdirSync(join(claudeSkills, name), { recursive: true });
      writeFile(join(claudeSkills, name), "SKILL.md", `# ${name}\n`);
    }
  }

  if (withLockEntry) {
    writeJson(projectDir, "skills-lock.json", {
      version: 1,
      skills: {
        [name]: {
          source: `example/repo/${name}`,
          sourceType: "autoskills-registry",
          computedHash: "deadbeef",
        },
      },
    });
  }
}

describe("listInstalledSkills", () => {
  const tmp = useTmpDir();

  it("returns an empty array when nothing is installed", () => {
    deepStrictEqual(listInstalledSkills(tmp.path), []);
  });

  it("returns names from skills-lock.json sorted alphabetically", () => {
    writeJson(tmp.path, "skills-lock.json", {
      version: 1,
      skills: {
        zod: { source: "x", sourceType: "autoskills-registry", computedHash: "h" },
        astro: { source: "x", sourceType: "autoskills-registry", computedHash: "h" },
        react: { source: "x", sourceType: "autoskills-registry", computedHash: "h" },
      },
    });

    deepStrictEqual(listInstalledSkills(tmp.path), ["astro", "react", "zod"]);
  });

  it("falls back to .agents/skills/ when skills-lock.json is missing", () => {
    mkdirSync(join(tmp.path, ".agents", "skills", "vite"), { recursive: true });
    mkdirSync(join(tmp.path, ".agents", "skills", "shadcn"), { recursive: true });

    deepStrictEqual(listInstalledSkills(tmp.path), ["shadcn", "vite"]);
  });

  it("merges and de-duplicates lockfile and filesystem entries", () => {
    writeJson(tmp.path, "skills-lock.json", {
      version: 1,
      skills: {
        astro: { source: "x", sourceType: "autoskills-registry", computedHash: "h" },
      },
    });
    mkdirSync(join(tmp.path, ".agents", "skills", "astro"), { recursive: true });
    mkdirSync(join(tmp.path, ".agents", "skills", "vite"), { recursive: true });

    deepStrictEqual(listInstalledSkills(tmp.path), ["astro", "vite"]);
  });
});

describe("uninstallSkill", () => {
  const tmp = useTmpDir();

  it("removes the canonical dir, agent symlinks, and lockfile entry", () => {
    setupInstalledSkill(tmp.path, "vite");

    const result = uninstallSkill("vite", { projectDir: tmp.path });

    strictEqual(result.success, true);
    strictEqual(result.skillName, "vite");
    ok(result.removedPaths.length >= 2);

    ok(!existsSync(join(tmp.path, ".agents", "skills", "vite")));
    ok(!existsSync(join(tmp.path, ".claude", "skills", "vite")));
    ok(!existsSync(join(tmp.path, "skills-lock.json"))); // empty -> deleted
  });

  it("preserves other skills' lockfile entries when removing one", () => {
    setupInstalledSkill(tmp.path, "astro", { withAgentLink: false });
    writeJson(tmp.path, "skills-lock.json", {
      version: 1,
      skills: {
        astro: { source: "x", sourceType: "autoskills-registry", computedHash: "h1" },
        react: { source: "y", sourceType: "autoskills-registry", computedHash: "h2" },
      },
    });

    uninstallSkill("astro", { projectDir: tmp.path });

    const lock = JSON.parse(readFileSync(join(tmp.path, "skills-lock.json"), "utf-8"));
    deepStrictEqual(Object.keys(lock.skills), ["react"]);
    strictEqual(lock.skills.react.computedHash, "h2");
  });

  it("reports failure when the skill is not installed", () => {
    const result = uninstallSkill("not-installed", { projectDir: tmp.path });
    strictEqual(result.success, false);
    ok(result.output.includes("not installed"));
  });

  it("rejects unsafe skill names with path separators", () => {
    const result = uninstallSkill("../etc/passwd", { projectDir: tmp.path });
    strictEqual(result.success, false);
    ok(result.output.includes("invalid skill name"));
  });

  it("rejects empty skill names", () => {
    const result = uninstallSkill("", { projectDir: tmp.path });
    strictEqual(result.success, false);
  });

  it("works even when the lockfile is absent (fallback path)", () => {
    // Only the .agents/skills/<name> dir exists, no lockfile.
    const canonical = join(tmp.path, ".agents", "skills", "shadcn");
    mkdirSync(canonical, { recursive: true });
    writeFile(canonical, "SKILL.md", "# shadcn\n");

    const result = uninstallSkill("shadcn", { projectDir: tmp.path });

    strictEqual(result.success, true);
    ok(!existsSync(canonical));
  });

  it("prunes empty parent directories after the last skill is removed", () => {
    setupInstalledSkill(tmp.path, "vite");
    uninstallSkill("vite", { projectDir: tmp.path });

    ok(!existsSync(join(tmp.path, ".agents")));
    ok(!existsSync(join(tmp.path, ".claude")));
  });

  it("keeps the .agents directory when other skills remain", () => {
    setupInstalledSkill(tmp.path, "vite", { withLockEntry: false });
    setupInstalledSkill(tmp.path, "astro", { withLockEntry: false });

    uninstallSkill("vite", { projectDir: tmp.path });

    ok(!existsSync(join(tmp.path, ".agents", "skills", "vite")));
    ok(existsSync(join(tmp.path, ".agents", "skills", "astro")));
  });

  it("collects trace messages when onTrace is provided", () => {
    setupInstalledSkill(tmp.path, "vite");
    const traces: string[] = [];
    const result = uninstallSkill("vite", {
      projectDir: tmp.path,
      onTrace: (msg) => traces.push(msg),
    });

    strictEqual(result.success, true);
    ok(traces.length > 0);
    ok(traces.some((t) => t.includes("removed")));
  });

  it("removes a broken symlink left behind by a previous failure", () => {
    const claudeSkills = join(tmp.path, ".claude", "skills");
    mkdirSync(claudeSkills, { recursive: true });
    try {
      symlinkSync(join(tmp.path, "does-not-exist"), join(claudeSkills, "ghost"), "dir");
    } catch {
      // skip the test silently on platforms that don't support symlinks.
      return;
    }
    writeJson(tmp.path, "skills-lock.json", {
      version: 1,
      skills: {
        ghost: { source: "x", sourceType: "autoskills-registry", computedHash: "h" },
      },
    });

    const result = uninstallSkill("ghost", { projectDir: tmp.path });

    strictEqual(result.success, true);
    ok(!existsSync(join(claudeSkills, "ghost")));
  });
});
