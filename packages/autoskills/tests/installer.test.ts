import { describe, it } from "node:test";
import { ok, equal, deepEqual } from "node:assert/strict";
import {
  chmodSync,
  existsSync,
  mkdirSync,
  readFileSync,
  readlinkSync,
  rmSync,
  writeFileSync,
} from "node:fs";
import { createHash } from "node:crypto";
import { join } from "node:path";

import {
  agentFolderFor,
  installAll,
  installSkill,
  securityCheckForSkillPath,
  verifyRegistryEntry,
  _setRegistryDir,
} from "../installer.ts";
import type { RegistryEntry } from "../installer.ts";
import { useTmpDir } from "./helpers.ts";

const PACKAGE_VERSION = JSON.parse(
  readFileSync(new URL("../package.json", import.meta.url), "utf-8"),
).version as string;

function sha256(buf: string | Buffer): string {
  return createHash("sha256").update(buf).digest("hex");
}

function bundleHashOf(entry: { files: string[]; sha256: Record<string, string> }): string {
  return sha256(
    entry.files
      .map((f) => `${f}:${entry.sha256[f]}`)
      .sort()
      .join("\n"),
  );
}

interface FakeSkill {
  name: string;
  source: string;
  files: Record<string, string>;
  review?: RegistryEntry["review"];
  securityCheck?: RegistryEntry["securityCheck"];
}

function buildRegistry(dir: string, skills: FakeSkill[]): void {
  mkdirSync(dir, { recursive: true });
  const manifest: Record<string, unknown> = {
    version: 1,
    generatedAt: new Date().toISOString(),
    reviewer: { model: "test-model", promptVersion: "1.0.0" },
    skills: {} as Record<string, RegistryEntry>,
  };
  for (const skill of skills) {
    const shaMap: Record<string, string> = {};
    for (const [rel, content] of Object.entries(skill.files)) {
      const p = join(dir, skill.name, rel);
      mkdirSync(join(dir, skill.name, rel.split("/").slice(0, -1).join("/") || "."), {
        recursive: true,
      });
      writeFileSync(p, content);
      shaMap[rel] = sha256(content);
    }
    const entry: RegistryEntry = {
      source: skill.source,
      skillPath: `${skill.source}/${skill.name}`,
      commitSha: "deadbeef",
      files: Object.keys(skill.files).sort(),
      sha256: shaMap,
      bundleHash: bundleHashOf({ files: Object.keys(skill.files).sort(), sha256: shaMap }),
      review: skill.review || {
        status: "approved",
        flags: [],
        summary: "test",
        model: "test-model",
        promptVersion: "1.0.0",
        reviewedAt: new Date().toISOString(),
      },
      securityCheck: skill.securityCheck,
    };
    (manifest.skills as Record<string, RegistryEntry>)[skill.name] = entry;
  }
  writeFileSync(join(dir, "index.json"), JSON.stringify(manifest, null, 2));
}

function fetchFromRegistry(regDir: string): typeof fetch {
  return (async (url: string | URL | Request) => {
    const href = typeof url === "string" || url instanceof URL ? String(url) : url.url;
    const pathname = new URL(href).pathname;
    const marker = "/skills-registry/";
    const idx = pathname.indexOf(marker);
    if (idx === -1) {
      return new Response("not found", { status: 404, statusText: "Not Found" });
    }
    const rel = decodeURIComponent(pathname.slice(idx + marker.length));
    const filePath = join(regDir, ...rel.split("/"));
    if (!existsSync(filePath)) {
      return new Response("not found", { status: 404, statusText: "Not Found" });
    }
    return new Response(readFileSync(filePath));
  }) as typeof fetch;
}

describe("agentFolderFor", () => {
  it("maps claude-code to .claude", () => {
    equal(agentFolderFor("claude-code"), ".claude");
  });
  it("maps junie to .junie", () => {
    equal(agentFolderFor("junie"), ".junie");
  });
  it("maps codebuddy to .codebuddy", () => {
    equal(agentFolderFor("codebuddy"), ".codebuddy");
  });
  it("does not map codex to a legacy .codex folder", () => {
    equal(agentFolderFor("codex"), null);
  });
  it("returns null for unknown agents", () => {
    equal(agentFolderFor("nope"), null);
  });
});

describe("verifyRegistryEntry", () => {
  const tmp = useTmpDir();

  it("returns ok when hashes match", () => {
    const regDir = join(tmp.path, "registry");
    buildRegistry(regDir, [
      { name: "my-skill", source: "owner/repo", files: { "SKILL.md": "# hi" } },
    ]);
    _setRegistryDir(regDir);
    const manifest = JSON.parse(readFileSync(join(regDir, "index.json"), "utf-8"));
    const verdict = verifyRegistryEntry("my-skill", manifest.skills["my-skill"], regDir);
    ok(verdict.ok);
  });

  it("detects tampered file via hash mismatch", () => {
    const regDir = join(tmp.path, "registry");
    buildRegistry(regDir, [
      { name: "my-skill", source: "owner/repo", files: { "SKILL.md": "# hi" } },
    ]);
    writeFileSync(join(regDir, "my-skill", "SKILL.md"), "# tampered");
    _setRegistryDir(regDir);
    const manifest = JSON.parse(readFileSync(join(regDir, "index.json"), "utf-8"));
    const verdict = verifyRegistryEntry("my-skill", manifest.skills["my-skill"], regDir);
    ok(!verdict.ok);
    ok(verdict.reason?.includes("hash mismatch"));
  });

  it("detects missing file listed in manifest", () => {
    const regDir = join(tmp.path, "registry");
    buildRegistry(regDir, [
      { name: "my-skill", source: "owner/repo", files: { "SKILL.md": "# hi" } },
    ]);
    _setRegistryDir(regDir);
    const manifest = JSON.parse(readFileSync(join(regDir, "index.json"), "utf-8"));
    const entry = manifest.skills["my-skill"];
    entry.files.unshift("references/MISSING.md");
    entry.sha256["references/MISSING.md"] = "0".repeat(64);
    const verdict = verifyRegistryEntry("my-skill", entry, regDir);
    ok(!verdict.ok);
    ok(verdict.reason?.includes("missing"));
  });

  it("detects files omitted from the manifest", () => {
    const regDir = join(tmp.path, "registry");
    buildRegistry(regDir, [
      { name: "my-skill", source: "owner/repo", files: { "SKILL.md": "# hi" } },
    ]);
    writeFileSync(join(regDir, "my-skill", "unlisted.txt"), "not reviewed");
    _setRegistryDir(regDir);
    const manifest = JSON.parse(readFileSync(join(regDir, "index.json"), "utf-8"));

    const verdict = verifyRegistryEntry("my-skill", manifest.skills["my-skill"], regDir);

    equal(verdict.ok, false);
    equal(verdict.reason, "unexpected file unlisted.txt");
  });

  it("returns a failed verdict when registry traversal fails", () => {
    const regDir = join(tmp.path, "registry");
    buildRegistry(regDir, [
      { name: "my-skill", source: "owner/repo", files: { "SKILL.md": "# hi" } },
    ]);
    const unreadableDir = join(regDir, "my-skill", "unreadable");
    mkdirSync(unreadableDir);
    chmodSync(unreadableDir, 0o000);
    const manifest = JSON.parse(readFileSync(join(regDir, "index.json"), "utf-8"));

    try {
      const verdict = verifyRegistryEntry("my-skill", manifest.skills["my-skill"], regDir);

      equal(verdict.ok, false);
      ok(verdict.reason?.startsWith("verification failed:"));
    } finally {
      chmodSync(unreadableDir, 0o700);
    }
  });

  it("rejects unsafe registry paths before installation", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    buildRegistry(regDir, [
      { name: "unsafe-skill", source: "owner/repo", files: { "SKILL.md": "# unsafe" } },
    ]);
    const manifestPath = join(regDir, "index.json");
    const manifest = JSON.parse(readFileSync(manifestPath, "utf-8"));
    const entry = manifest.skills["unsafe-skill"];
    entry.files = ["../outside.txt"];
    entry.sha256["../outside.txt"] = sha256("outside");
    writeFileSync(manifestPath, JSON.stringify(manifest, null, 2));
    _setRegistryDir(regDir);

    const result = await installSkill("owner/repo/unsafe-skill", [], {
      projectDir,
      registryDir: regDir,
    });

    equal(result.success, false);
    ok(result.output.includes("unsafe path"));
    equal(securityCheckForSkillPath("owner/repo/unsafe-skill"), null);
    equal(existsSync(join(projectDir, ".agents", "skills", "outside.txt")), false);
  });

  it("rejects registry files without a valid hash", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    buildRegistry(regDir, [
      { name: "unhashed-skill", source: "owner/repo", files: { "SKILL.md": "# unhashed" } },
    ]);
    const manifestPath = join(regDir, "index.json");
    const manifest = JSON.parse(readFileSync(manifestPath, "utf-8"));
    manifest.skills["unhashed-skill"].sha256 = {};
    writeFileSync(manifestPath, JSON.stringify(manifest, null, 2));
    _setRegistryDir(regDir);

    const result = await installSkill("owner/repo/unhashed-skill", [], {
      projectDir,
      registryDir: regDir,
    });

    equal(result.success, false);
    ok(result.output.includes("sha256 must contain a SHA-256 hash"));
    equal(securityCheckForSkillPath("owner/repo/unhashed-skill"), null);
  });

  it("rejects an unsafe bundle hash before resolving the cache path", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    buildRegistry(regDir, [
      { name: "unsafe-cache", source: "owner/repo", files: { "SKILL.md": "# unsafe" } },
    ]);
    const manifestPath = join(regDir, "index.json");
    const manifest = JSON.parse(readFileSync(manifestPath, "utf-8"));
    manifest.skills["unsafe-cache"].bundleHash = "../../outside";
    writeFileSync(manifestPath, JSON.stringify(manifest, null, 2));
    _setRegistryDir(regDir);

    const result = await installSkill("owner/repo/unsafe-cache", [], {
      projectDir,
      registryDir: regDir,
    });

    equal(result.success, false);
    ok(result.output.includes("bundleHash must be a SHA-256 hash"));
    equal(securityCheckForSkillPath("owner/repo/unsafe-cache"), null);
  });

  it("rejects an incomplete top-level registry", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    buildRegistry(regDir, [
      { name: "incomplete", source: "owner/repo", files: { "SKILL.md": "# incomplete" } },
    ]);
    const manifestPath = join(regDir, "index.json");
    const manifest = JSON.parse(readFileSync(manifestPath, "utf-8"));
    delete manifest.reviewer;
    writeFileSync(manifestPath, JSON.stringify(manifest, null, 2));
    _setRegistryDir(regDir);

    const result = await installSkill("owner/repo/incomplete", [], {
      projectDir,
      registryDir: regDir,
    });

    equal(result.success, false);
    ok(result.output.includes("skills-registry index not found"));
    equal(securityCheckForSkillPath("owner/repo/incomplete"), null);
  });

  it("rejects unsafe skill names before resolving installation paths", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    const targetDir = join(projectDir, "target");
    buildRegistry(regDir, [
      { name: "safe-skill", source: "owner/repo", files: { "SKILL.md": "# safe" } },
    ]);
    const manifestPath = join(regDir, "index.json");
    const manifest = JSON.parse(readFileSync(manifestPath, "utf-8"));
    const entry = manifest.skills["safe-skill"];
    delete manifest.skills["safe-skill"];
    entry.skillPath = "owner/repo/../../target";
    manifest.skills["../../target"] = entry;
    writeFileSync(manifestPath, JSON.stringify(manifest, null, 2));
    mkdirSync(targetDir, { recursive: true });
    writeFileSync(join(targetDir, "sentinel.txt"), "keep");
    _setRegistryDir(regDir);

    const result = await installSkill("owner/repo/../../target", [], {
      projectDir,
      registryDir: regDir,
      fetchImpl: (async () => {
        throw new Error("unexpected fetch");
      }) as typeof fetch,
    });

    equal(result.success, false);
    ok(result.output.includes("skills-registry index not found"));
    equal(readFileSync(join(targetDir, "sentinel.txt"), "utf-8"), "keep");
  });

  it("rejects the whole registry when another entry is malformed", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    buildRegistry(regDir, [
      { name: "target", source: "owner/repo", files: { "SKILL.md": "# target" } },
      { name: "malformed", source: "owner/repo", files: { "SKILL.md": "# malformed" } },
    ]);
    const manifestPath = join(regDir, "index.json");
    const manifest = JSON.parse(readFileSync(manifestPath, "utf-8"));
    delete manifest.skills.malformed.review;
    writeFileSync(manifestPath, JSON.stringify(manifest, null, 2));
    _setRegistryDir(regDir);

    const result = await installSkill("owner/repo/target", [], {
      projectDir,
      registryDir: regDir,
    });

    equal(result.success, false);
    ok(result.output.includes("skills.malformed is invalid: review must be an object"));
    equal(securityCheckForSkillPath("owner/repo/target"), null);
  });

  it("rejects non-string review and security statuses", async () => {
    for (const field of ["review", "securityCheck"] as const) {
      const skillName = `${field}-status-array`;
      const regDir = join(tmp.path, skillName, "registry");
      const projectDir = join(tmp.path, skillName, "project");
      buildRegistry(regDir, [
        {
          name: skillName,
          source: "owner/repo",
          files: { "SKILL.md": "# invalid status" },
          securityCheck: {
            status: "warning",
            findings: ["manual review"],
            summary: "Needs manual review.",
            checkedAt: new Date().toISOString(),
          },
        },
      ]);
      const manifestPath = join(regDir, "index.json");
      const manifest = JSON.parse(readFileSync(manifestPath, "utf-8"));
      manifest.skills[skillName][field].status = [field === "review" ? "flagged" : "warning"];
      writeFileSync(manifestPath, JSON.stringify(manifest, null, 2));
      _setRegistryDir(regDir);

      const result = await installSkill(`owner/repo/${skillName}`, [], {
        projectDir,
        registryDir: regDir,
      });

      equal(result.success, false);
      ok(result.output.includes(`${field}.status is invalid`));
      equal(securityCheckForSkillPath(`owner/repo/${skillName}`), null);
    }
  });
});

describe("installSkill", () => {
  const tmp = useTmpDir();

  it("copies files to .agents/skills/<name> and updates lock", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    mkdirSync(projectDir, { recursive: true });
    buildRegistry(regDir, [
      {
        name: "hello-skill",
        source: "owner/repo",
        files: { "SKILL.md": "# hello", "references/notes.md": "notes" },
      },
    ]);
    _setRegistryDir(regDir);

    const result = await installSkill("owner/repo/hello-skill", [], {
      projectDir,
      registryDir: regDir,
      registryBaseUrl: "https://example.test/skills-registry",
      fetchImpl: fetchFromRegistry(regDir),
    });

    ok(result.success, result.output);
    ok(existsSync(join(projectDir, ".agents", "skills", "hello-skill", "SKILL.md")));
    ok(existsSync(join(projectDir, ".agents", "skills", "hello-skill", "references", "notes.md")));

    const lock = JSON.parse(readFileSync(join(projectDir, "skills-lock.json"), "utf-8"));
    equal(lock.skills["hello-skill"].source, "owner/repo");
    equal(lock.skills["hello-skill"].sourceType, "autoskills-registry");
    ok(typeof lock.skills["hello-skill"].computedHash === "string");
  });

  it("returns the persisted security check after installing a skill", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    mkdirSync(projectDir, { recursive: true });
    buildRegistry(regDir, [
      {
        name: "warning-skill",
        source: "owner/repo",
        files: { "SKILL.md": "# warning" },
        securityCheck: {
          status: "warning",
          findings: ["external URL needs review"],
          summary: "External URLs should be reviewed.",
          checkedAt: new Date().toISOString(),
        },
      },
    ]);
    _setRegistryDir(regDir);

    const result = await installSkill("owner/repo/warning-skill", [], {
      projectDir,
      registryDir: regDir,
    });

    ok(result.success, result.output);
    deepEqual(result.securityCheck, {
      name: "warning-skill",
      status: "warning",
      summary: "External URLs should be reviewed.",
      findings: ["external URL needs review"],
    });
  });

  it("falls back to review metadata when securityCheck is missing", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    mkdirSync(projectDir, { recursive: true });
    buildRegistry(regDir, [
      {
        name: "review-skill",
        source: "owner/repo",
        files: { "SKILL.md": "# review" },
        review: {
          status: "flagged",
          flags: ["broad shell command"],
          summary: "Contains a broad shell command.",
          model: "test-model",
          promptVersion: "1.0.0",
          reviewedAt: new Date().toISOString(),
        },
      },
    ]);
    _setRegistryDir(regDir);

    const result = await installSkill("owner/repo/review-skill", [], {
      projectDir,
      registryDir: regDir,
    });

    ok(result.success, result.output);
    deepEqual(result.securityCheck, {
      name: "review-skill",
      status: "warning",
      summary: "Contains a broad shell command.",
      findings: ["broad shell command"],
    });
  });

  it("does not report a security result when review was skipped", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    mkdirSync(projectDir, { recursive: true });
    buildRegistry(regDir, [
      {
        name: "unreviewed-skill",
        source: "owner/repo",
        files: { "SKILL.md": "# unreviewed" },
        review: {
          status: "skipped",
          flags: [],
          summary: "review skipped (--no-review)",
          model: "test-model",
          promptVersion: "1.0.0",
          reviewedAt: new Date().toISOString(),
        },
      },
    ]);
    _setRegistryDir(regDir);

    const result = await installSkill("owner/repo/unreviewed-skill", [], {
      projectDir,
      registryDir: regDir,
    });

    ok(result.success, result.output);
    equal(result.securityCheck, undefined);
    equal(result.reviewSkipped, true);
    equal(securityCheckForSkillPath("owner/repo/unreviewed-skill"), null);
  });

  it("rejects a security result when review was skipped", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    mkdirSync(projectDir, { recursive: true });
    buildRegistry(regDir, [
      {
        name: "inconsistent-skill",
        source: "owner/repo",
        files: { "SKILL.md": "# inconsistent" },
        review: {
          status: "skipped",
          flags: [],
          summary: "review skipped (--no-review)",
          model: "test-model",
          promptVersion: "1.0.0",
          reviewedAt: new Date().toISOString(),
        },
        securityCheck: {
          status: "warning",
          findings: ["stale result"],
          summary: "Stale result.",
          checkedAt: new Date().toISOString(),
        },
      },
    ]);
    _setRegistryDir(regDir);

    const result = await installSkill("owner/repo/inconsistent-skill", [], {
      projectDir,
      registryDir: regDir,
    });

    equal(result.success, false);
    ok(
      result.output.includes(
        "invalid registry metadata: securityCheck must be omitted when review.status is skipped",
      ),
    );
    equal(securityCheckForSkillPath("owner/repo/inconsistent-skill"), null);
  });

  it("rejects registry entries without review metadata", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    mkdirSync(projectDir, { recursive: true });
    buildRegistry(regDir, [
      {
        name: "malformed-skill",
        source: "owner/repo",
        files: { "SKILL.md": "# malformed" },
      },
    ]);
    const manifestPath = join(regDir, "index.json");
    const manifest = JSON.parse(readFileSync(manifestPath, "utf-8"));
    delete manifest.skills["malformed-skill"].review;
    writeFileSync(manifestPath, JSON.stringify(manifest, null, 2));
    _setRegistryDir(regDir);

    const result = await installSkill("owner/repo/malformed-skill", [], {
      projectDir,
      registryDir: regDir,
    });

    equal(result.success, false);
    ok(result.output.includes("invalid registry metadata: review must be an object"));
    equal(securityCheckForSkillPath("owner/repo/malformed-skill"), null);
  });

  it("returns security checks from the registry before installing", () => {
    const regDir = join(tmp.path, "registry");
    buildRegistry(regDir, [
      {
        name: "offer-warning-skill",
        source: "owner/repo",
        files: { "SKILL.md": "# warning" },
        securityCheck: {
          status: "warning",
          findings: ["manual review"],
          summary: "Needs manual review.",
          checkedAt: new Date().toISOString(),
        },
      },
    ]);
    _setRegistryDir(regDir);

    deepEqual(securityCheckForSkillPath("owner/repo/offer-warning-skill"), {
      name: "offer-warning-skill",
      status: "warning",
      summary: "Needs manual review.",
      findings: ["manual review"],
    });
  });

  it("collects security checks when installing multiple skills", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    mkdirSync(projectDir, { recursive: true });
    buildRegistry(regDir, [
      { name: "first-skill", source: "owner/repo", files: { "SKILL.md": "# first" } },
      {
        name: "second-skill",
        source: "owner/repo",
        files: { "SKILL.md": "# second" },
        securityCheck: {
          status: "warning",
          findings: ["manual review"],
          summary: "Needs manual review.",
          checkedAt: new Date().toISOString(),
        },
      },
    ]);
    _setRegistryDir(regDir);

    const result = await installAll(
      [
        { skill: "owner/repo/first-skill", sources: [], installed: false },
        { skill: "owner/repo/second-skill", sources: [], installed: false },
      ],
      [],
      { projectDir, registryDir: regDir },
    );

    equal(result.installed, 2);
    deepEqual(result.securityChecks.map((check) => check.name).sort(), [
      "first-skill",
      "second-skill",
    ]);
    equal(result.securityChecks.find((check) => check.name === "second-skill")?.status, "warning");
  });

  it("installs from the local registry without fetching", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    mkdirSync(projectDir, { recursive: true });
    buildRegistry(regDir, [
      { name: "local-skill", source: "owner/repo", files: { "SKILL.md": "# local" } },
    ]);
    _setRegistryDir(regDir);

    const result = await installSkill("owner/repo/local-skill", [], {
      projectDir,
      registryDir: regDir,
      fetchImpl: (async () => {
        throw new Error("unexpected fetch");
      }) as typeof fetch,
    });

    ok(result.success, result.output);
    equal(
      readFileSync(join(projectDir, ".agents", "skills", "local-skill", "SKILL.md"), "utf-8"),
      "# local",
    );
  });

  it("excludes unlisted files from local registry installs", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    buildRegistry(regDir, [
      { name: "listed-skill", source: "owner/repo", files: { "SKILL.md": "# listed" } },
    ]);
    writeFileSync(join(regDir, "listed-skill", "unlisted.txt"), "not reviewed");
    _setRegistryDir(regDir);

    const result = await installSkill("owner/repo/listed-skill", [], {
      projectDir,
      registryDir: regDir,
      registryBaseUrl: "https://example.test/skills-registry",
      fetchImpl: fetchFromRegistry(regDir),
    });

    ok(result.success, result.output);
    ok(existsSync(join(projectDir, ".agents", "skills", "listed-skill", "SKILL.md")));
    equal(existsSync(join(projectDir, ".agents", "skills", "listed-skill", "unlisted.txt")), false);
  });

  it("refreshes matching installed skills that contain unlisted files", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    buildRegistry(regDir, [
      { name: "listed-skill", source: "owner/repo", files: { "SKILL.md": "# listed" } },
    ]);
    const installedDir = join(projectDir, ".agents", "skills", "listed-skill");
    mkdirSync(installedDir, { recursive: true });
    writeFileSync(join(installedDir, "SKILL.md"), "# listed");
    writeFileSync(join(installedDir, "unlisted.txt"), "not reviewed");
    _setRegistryDir(regDir);

    const result = await installSkill("owner/repo/listed-skill", [], {
      projectDir,
      registryDir: regDir,
      fetchImpl: (async () => {
        throw new Error("unexpected fetch");
      }) as typeof fetch,
    });

    ok(result.success, result.output);
    equal(existsSync(join(installedDir, "SKILL.md")), true);
    equal(existsSync(join(installedDir, "unlisted.txt")), false);
  });

  it("replaces an installed skill path that is not a directory", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    buildRegistry(regDir, [
      { name: "listed-skill", source: "owner/repo", files: { "SKILL.md": "# listed" } },
    ]);
    const installedPath = join(projectDir, ".agents", "skills", "listed-skill");
    mkdirSync(join(projectDir, ".agents", "skills"), { recursive: true });
    writeFileSync(installedPath, "corrupted installation");
    _setRegistryDir(regDir);

    const result = await installSkill("owner/repo/listed-skill", [], {
      projectDir,
      registryDir: regDir,
      fetchImpl: (async () => {
        throw new Error("unexpected fetch");
      }) as typeof fetch,
    });

    ok(result.success, result.output);
    equal(readFileSync(join(installedPath, "SKILL.md"), "utf-8"), "# listed");
  });

  it("skips downloads when the installed skill already matches the manifest", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    mkdirSync(projectDir, { recursive: true });
    buildRegistry(regDir, [
      {
        name: "cached-skill",
        source: "owner/repo",
        files: { "SKILL.md": "# cached" },
        securityCheck: {
          status: "warning",
          findings: ["reinstall warning"],
          summary: "Reinstalled skill needs review.",
          checkedAt: new Date().toISOString(),
        },
      },
    ]);
    const installedDir = join(projectDir, ".agents", "skills", "cached-skill");
    mkdirSync(installedDir, { recursive: true });
    writeFileSync(join(installedDir, "SKILL.md"), "# cached");
    rmSync(join(regDir, "cached-skill"), { recursive: true, force: true });
    _setRegistryDir(regDir);

    const result = await installSkill("owner/repo/cached-skill", [], {
      projectDir,
      registryDir: regDir,
      fetchImpl: (async () => {
        throw new Error("unexpected fetch");
      }) as typeof fetch,
    });

    ok(result.success, result.output);
    deepEqual(result.securityCheck, {
      name: "cached-skill",
      status: "warning",
      summary: "Reinstalled skill needs review.",
      findings: ["reinstall warning"],
    });
  });

  it("installs from the user cache without fetching", async () => {
    const regDir = join(tmp.path, "registry");
    const cacheDir = join(tmp.path, "cache");
    const projectDir = join(tmp.path, "project");
    mkdirSync(projectDir, { recursive: true });
    buildRegistry(regDir, [
      {
        name: "cached-remote-skill",
        source: "owner/repo",
        files: { "SKILL.md": "# cached remote" },
      },
    ]);
    const manifest = JSON.parse(readFileSync(join(regDir, "index.json"), "utf-8"));
    const entry = manifest.skills["cached-remote-skill"] as RegistryEntry;
    const cacheRegistryDir = join(cacheDir, entry.bundleHash);
    mkdirSync(join(cacheRegistryDir, "cached-remote-skill"), { recursive: true });
    writeFileSync(join(cacheRegistryDir, "cached-remote-skill", "SKILL.md"), "# cached remote");
    rmSync(join(regDir, "cached-remote-skill"), { recursive: true, force: true });
    _setRegistryDir(regDir);

    const prevCacheDir = process.env.AUTOSKILLS_CACHE_DIR;
    process.env.AUTOSKILLS_CACHE_DIR = cacheDir;
    try {
      const result = await installSkill("owner/repo/cached-remote-skill", [], {
        projectDir,
        registryDir: regDir,
        fetchImpl: (async () => {
          throw new Error("unexpected fetch");
        }) as typeof fetch,
      });

      ok(result.success, result.output);
    } finally {
      if (prevCacheDir === undefined) delete process.env.AUTOSKILLS_CACHE_DIR;
      else process.env.AUTOSKILLS_CACHE_DIR = prevCacheDir;
    }
  });

  it("downloads from the raw GitHub registry by default", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    mkdirSync(projectDir, { recursive: true });
    buildRegistry(regDir, [
      { name: "raw-skill", source: "owner/repo", files: { "AGENTS.md": "# raw" } },
    ]);
    _setRegistryDir(regDir);

    const prevCacheDir = process.env.AUTOSKILLS_CACHE_DIR;
    process.env.AUTOSKILLS_CACHE_DIR = join(tmp.path, "raw-github-cache");
    const trace: string[] = [];
    let result;
    try {
      result = await installSkill("owner/repo/raw-skill", [], {
        projectDir,
        registryDir: join(tmp.path, "manifest-only"),
        onTrace: (message) => trace.push(message),
        fetchImpl: (async (url: string | URL | Request) => {
          const href = typeof url === "string" || url instanceof URL ? String(url) : url.url;
          ok(
            href.startsWith(
              `https://raw.githubusercontent.com/midudev/autoskills/v${PACKAGE_VERSION}/`,
            ),
          );
          return fetchFromRegistry(regDir)(url);
        }) as typeof fetch,
      });
    } finally {
      if (prevCacheDir === undefined) delete process.env.AUTOSKILLS_CACHE_DIR;
      else process.env.AUTOSKILLS_CACHE_DIR = prevCacheDir;
    }

    ok(result.success, result.output);
    ok(
      trace.some((line) =>
        line.includes(
          `downloaded AGENTS.md from https://raw.githubusercontent.com/midudev/autoskills/v${PACKAGE_VERSION}/packages/autoskills/skills-registry/raw-skill/AGENTS.md`,
        ),
      ),
    );
    equal(
      readFileSync(join(projectDir, ".agents", "skills", "raw-skill", "AGENTS.md"), "utf-8"),
      "# raw",
    );
  });

  it("normalizes Windows-style registry file paths before downloading", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    mkdirSync(projectDir, { recursive: true });
    buildRegistry(regDir, [
      {
        name: "windows-path-skill",
        source: "owner/repo",
        files: { "SKILL.md": "# raw", "references/notes.md": "notes" },
      },
    ]);
    const manifestPath = join(regDir, "index.json");
    const manifest = JSON.parse(readFileSync(manifestPath, "utf-8"));
    manifest.skills["windows-path-skill"].files = ["SKILL.md", "references\\notes.md"];
    writeFileSync(manifestPath, JSON.stringify(manifest, null, 2));
    _setRegistryDir(regDir);

    const prevCacheDir = process.env.AUTOSKILLS_CACHE_DIR;
    process.env.AUTOSKILLS_CACHE_DIR = join(tmp.path, "windows-path-cache");
    const seenUrls: string[] = [];
    try {
      const result = await installSkill("owner/repo/windows-path-skill", [], {
        projectDir,
        registryDir: join(tmp.path, "manifest-only"),
        registryBaseUrl: "https://example.test/skills-registry",
        fetchImpl: (async (url: string | URL | Request) => {
          const href = typeof url === "string" || url instanceof URL ? String(url) : url.url;
          seenUrls.push(href);
          return fetchFromRegistry(regDir)(url);
        }) as typeof fetch,
      });

      ok(result.success, result.output);
      ok(
        seenUrls.includes(
          "https://example.test/skills-registry/windows-path-skill/references/notes.md",
        ),
      );
      ok(seenUrls.every((url) => !url.includes("%5C") && !url.includes("\\")));
      equal(
        readFileSync(
          join(projectDir, ".agents", "skills", "windows-path-skill", "references", "notes.md"),
          "utf-8",
        ),
        "notes",
      );
    } finally {
      if (prevCacheDir === undefined) delete process.env.AUTOSKILLS_CACHE_DIR;
      else process.env.AUTOSKILLS_CACHE_DIR = prevCacheDir;
    }
  });

  it("falls back to the main registry mirror when the release registry mirror is missing files", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    mkdirSync(projectDir, { recursive: true });
    buildRegistry(regDir, [
      { name: "fallback-skill", source: "owner/repo", files: { "SKILL.md": "# fallback" } },
    ]);
    _setRegistryDir(regDir);

    const prevCacheDir = process.env.AUTOSKILLS_CACHE_DIR;
    process.env.AUTOSKILLS_CACHE_DIR = join(tmp.path, "fallback-main-cache");
    const seenUrls: string[] = [];
    try {
      const result = await installSkill("owner/repo/fallback-skill", [], {
        projectDir,
        registryDir: join(tmp.path, "manifest-only"),
        fetchImpl: (async (url: string | URL | Request) => {
          const href = typeof url === "string" || url instanceof URL ? String(url) : url.url;
          seenUrls.push(href);
          if (href.includes(`/midudev/autoskills/v${PACKAGE_VERSION}/`)) {
            return new Response("not found", { status: 404, statusText: "Not Found" });
          }
          if (href.includes("/midudev/autoskills/main/packages/autoskills/skills-registry/")) {
            const rel = decodeURIComponent(
              href.split("/midudev/autoskills/main/packages/autoskills/skills-registry/")[1],
            );
            return new Response(readFileSync(join(regDir, rel)));
          }
          return fetchFromRegistry(regDir)(url);
        }) as typeof fetch,
      });

      ok(result.success, result.output);
      ok(
        seenUrls.some((url) =>
          url.startsWith(
            "https://raw.githubusercontent.com/midudev/autoskills/main/packages/autoskills/skills-registry/fallback-skill/",
          ),
        ),
      );
      equal(
        readFileSync(join(projectDir, ".agents", "skills", "fallback-skill", "SKILL.md"), "utf-8"),
        "# fallback",
      );
    } finally {
      if (prevCacheDir === undefined) delete process.env.AUTOSKILLS_CACHE_DIR;
      else process.env.AUTOSKILLS_CACHE_DIR = prevCacheDir;
    }
  });

  it("creates symlinks for requested agents", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    mkdirSync(projectDir, { recursive: true });
    buildRegistry(regDir, [{ name: "s1", source: "owner/repo", files: { "SKILL.md": "# s1" } }]);
    _setRegistryDir(regDir);

    const result = await installSkill("owner/repo/s1", ["universal", "claude-code", "junie"], {
      projectDir,
      registryDir: regDir,
      registryBaseUrl: "https://example.test/skills-registry",
      fetchImpl: fetchFromRegistry(regDir),
    });
    ok(result.success, result.output);

    const claudeLink = join(projectDir, ".claude", "skills", "s1");
    const junieLink = join(projectDir, ".junie", "skills", "s1");
    ok(existsSync(claudeLink));
    ok(existsSync(junieLink));

    const target = readlinkSync(claudeLink);
    ok(target.includes(".agents/skills/s1") || target.includes(".agents\\skills\\s1"));
  });

  it("rejects when skill is not in the registry", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    mkdirSync(projectDir, { recursive: true });
    buildRegistry(regDir, [
      { name: "known", source: "owner/repo", files: { "SKILL.md": "# known" } },
    ]);
    _setRegistryDir(regDir);

    const result = await installSkill("owner/repo/unknown", [], {
      projectDir,
      registryDir: regDir,
    });
    ok(!result.success);
    ok(result.output.includes("not found in registry"));
  });

  it("rejects when downloaded content fails the integrity check", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    mkdirSync(projectDir, { recursive: true });
    buildRegistry(regDir, [
      { name: "tampered", source: "owner/repo", files: { "SKILL.md": "# ok" } },
    ]);
    writeFileSync(join(regDir, "tampered", "SKILL.md"), "# evil");
    _setRegistryDir(regDir);

    const result = await installSkill("owner/repo/tampered", [], {
      projectDir,
      registryDir: regDir,
      registryBaseUrl: "https://example.test/skills-registry",
      fetchImpl: fetchFromRegistry(regDir),
    });
    ok(!result.success);
    ok(result.output.includes("hash mismatch"));
  });

  it("rejects disallowed .zip files before downloading", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    mkdirSync(projectDir, { recursive: true });
    buildRegistry(regDir, [
      { name: "archive-skill", source: "owner/repo", files: { "downloads/tool.ZIP": "zip" } },
    ]);
    rmSync(join(regDir, "archive-skill"), { recursive: true, force: true });
    _setRegistryDir(regDir);

    const result = await installSkill("owner/repo/archive-skill", [], {
      projectDir,
      registryDir: regDir,
      fetchImpl: (async () => {
        throw new Error("unexpected fetch");
      }) as typeof fetch,
    });

    ok(!result.success);
    ok(result.output.includes("refusing to download disallowed skill archive"));
  });

  it("preserves existing entries in skills-lock.json and sorts keys", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    mkdirSync(projectDir, { recursive: true });
    writeFileSync(
      join(projectDir, "skills-lock.json"),
      JSON.stringify({
        version: 1,
        skills: { zebra: { source: "x/y", sourceType: "autoskills-registry", computedHash: "z" } },
      }),
    );
    buildRegistry(regDir, [{ name: "alpha", source: "owner/repo", files: { "SKILL.md": "# a" } }]);
    _setRegistryDir(regDir);

    const result = await installSkill("owner/repo/alpha", [], {
      projectDir,
      registryDir: regDir,
      registryBaseUrl: "https://example.test/skills-registry",
      fetchImpl: fetchFromRegistry(regDir),
    });
    ok(result.success);

    const lock = JSON.parse(readFileSync(join(projectDir, "skills-lock.json"), "utf-8"));
    deepEqual(Object.keys(lock.skills), ["alpha", "zebra"]);
    equal(lock.skills.zebra.source, "x/y");
  });
});
