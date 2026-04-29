import { describe, it } from "node:test";
import { ok, equal, deepEqual } from "node:assert/strict";
import { existsSync, mkdirSync, readFileSync, readlinkSync, rmSync, writeFileSync } from "node:fs";
import { createHash } from "node:crypto";
import { join } from "node:path";

import {
  agentFolderFor,
  installSkill,
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
      review: {
        status: "approved",
        flags: [],
        summary: "test",
        model: "test-model",
        promptVersion: "1.0.0",
        reviewedAt: new Date().toISOString(),
      },
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

  it("skips downloads when the installed skill already matches the manifest", async () => {
    const regDir = join(tmp.path, "registry");
    const projectDir = join(tmp.path, "project");
    mkdirSync(projectDir, { recursive: true });
    buildRegistry(regDir, [
      { name: "cached-skill", source: "owner/repo", files: { "SKILL.md": "# cached" } },
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
