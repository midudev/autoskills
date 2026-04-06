import { readFileSync, existsSync, readdirSync } from "node:fs";
import { join, resolve } from "node:path";
import { homedir } from "node:os";

// ── FS Memoization Helper ────────────────────────────────────

/** Creates a per-run fs cache. Returns object with same interface as raw fs helpers. */
function createFsMemo() {
  const existsCache = new Map();
  const fileCache = new Map();
  const dirCache = new Map();

  return {
    exists: (p) => {
      const key = resolve(p);
      if (!existsCache.has(key)) existsCache.set(key, existsSync(key));
      return existsCache.get(key);
    },
    readFile: (p, e = "utf-8") => {
      const key = resolve(p);
      if (!fileCache.has(key)) {
        try { fileCache.set(key, readFileSync(key, e)); }
        catch { fileCache.set(key, null); }
      }
      return fileCache.get(key);
    },
    readDir: (p, o = {}) => {
      const key = `${resolve(p)}#${JSON.stringify(o)}`;
      if (!dirCache.has(key)) {
        try { dirCache.set(key, readdirSync(resolve(p), o)); }
        catch { dirCache.set(key, []); }
      }
      return dirCache.get(key);
    },
  };
}

/** Returns memoized fs or raw fs fallback with same interface. */
const fsOps = (memo) => memo || {
  exists: existsSync,
  readFile: (p, e) => { try { return readFileSync(p, e); } catch { return null; } },
  readDir: (p, o) => { try { return readdirSync(p, o); } catch { return []; } },
};

export {
  SKILLS_MAP,
  COMBO_SKILLS_MAP,
  FRONTEND_PACKAGES,
  FRONTEND_BONUS_SKILLS,
  WEB_FRONTEND_EXTENSIONS,
  AGENT_FOLDER_MAP,
} from "./skills-map.mjs";

import {
  SKILLS_MAP,
  COMBO_SKILLS_MAP,
  FRONTEND_PACKAGES,
  FRONTEND_BONUS_SKILLS,
  WEB_FRONTEND_EXTENSIONS,
  AGENT_FOLDER_MAP,
} from "./skills-map.mjs";

// ── Internal Constants ───────────────────────────────────────

const AGENT_FOLDER_ENTRIES = Object.entries(AGENT_FOLDER_MAP);

const SCAN_SKIP_DIRS = new Set([
  "node_modules",
  ".git",
  "vendor",
  ".next",
  "dist",
  "build",
  ".output",
  ".nuxt",
  ".svelte-kit",
  "__pycache__",
  ".cache",
  "coverage",
  ".turbo",
  "var",
]);

const GRADLE_SCAN_ROOT_FILES = [
  "build.gradle.kts",
  "build.gradle",
  "settings.gradle.kts",
  "settings.gradle",
  "gradle/libs.versions.toml",
];

// ── Gradle Scanning ──────────────────────────────────────────

/**
 * Builds a list of Gradle build file paths to scan for technology markers.
 * Includes root-level Gradle files and `build.gradle(.kts)` inside immediate subdirectories.
 * @param {string} projectDir - Absolute path to the project root.
 * @param {object|null} fsMemo - Per-run fs memoization helper.
 * @returns {string[]} Candidate file paths.
 */
function gradleLayoutCandidatePaths(projectDir, fsMemo = null) {
  const f = fsOps(fsMemo);
  const candidates = [];

  for (const file of GRADLE_SCAN_ROOT_FILES) {
    candidates.push(join(projectDir, file));
  }

  for (const e of f.readDir(projectDir, { withFileTypes: true })) {
    if (!e.isDirectory() || e.name.startsWith(".") || SCAN_SKIP_DIRS.has(e.name)) continue;

    for (const g of ["build.gradle.kts", "build.gradle"]) {
      candidates.push(join(projectDir, e.name, g));
    }
  }

  return candidates;
}

function resolveConfigFileContentPaths(projectDir, config, fsMemo = null) {
  if (config.scanGradleLayout) return gradleLayoutCandidatePaths(projectDir, fsMemo);
  return (config.files || []).map((f) => join(projectDir, f));
}

// ── Frontend File Scanning ───────────────────────────────────

export function hasWebFrontendFiles(projectDir, maxDepth = 3, fsMemo = null) {
  const f = fsOps(fsMemo);

  function scan(dir, depth) {
    for (const entry of f.readDir(dir, { withFileTypes: true })) {
      if (entry.isFile()) {
        const name = entry.name;
        if (name.endsWith(".blade.php")) return true;

        const dot = name.lastIndexOf(".");
        if (dot !== -1 && WEB_FRONTEND_EXTENSIONS.has(name.slice(dot))) return true;
      } else if (entry.isDirectory() && depth < maxDepth) {
        if (SCAN_SKIP_DIRS.has(entry.name) || entry.name.startsWith(".")) continue;
        if (scan(join(dir, entry.name), depth + 1)) return true;
      }
    }
    return false;
  }

  return scan(projectDir, 0);
}

// ── Workspace Resolution ──────────────────────────────────────

function parsePnpmWorkspaceYaml(content) {
  const lines = content.split("\n");
  const patterns = [];
  let inPackages = false;

  for (const raw of lines) {
    const line = raw.trim();
    if (line === "packages:" || line === "packages :") {
      inPackages = true;
      continue;
    }
    if (inPackages) {
      if (line.startsWith("- ")) {
        patterns.push(line.slice(2).trim().replace(/^['"]|['"]$/g, ""));
      } else if (line !== "" && !line.startsWith("#")) {
        break;
      }
    }
  }

  return patterns;
}

function expandWorkspacePatterns(projectDir, patterns, fsMemo = null) {
  const f = fsOps(fsMemo);
  const dirs = [];

  for (const pattern of patterns) {
    if (pattern.includes("*")) {
      const parent = join(projectDir, pattern.replace(/\/?\*.*$/, ""));
      for (const entry of f.readDir(parent, { withFileTypes: true })) {
        if (!entry.isDirectory() || SCAN_SKIP_DIRS.has(entry.name) || entry.name.startsWith("."))
          continue;
        const wsDir = join(parent, entry.name);
        if (
          f.exists(join(wsDir, "package.json")) ||
          f.exists(join(wsDir, "deno.json")) ||
          f.exists(join(wsDir, "deno.jsonc"))
        ) {
          dirs.push(wsDir);
        }
      }
    } else {
      const wsDir = join(projectDir, pattern);
      if (
        f.exists(join(wsDir, "package.json")) ||
        f.exists(join(wsDir, "deno.json")) ||
        f.exists(join(wsDir, "deno.jsonc"))
      ) {
        dirs.push(wsDir);
      }
    }
  }

  return dirs;
}

/**
 * Discovers workspace directories in a monorepo.
 * Checks `pnpm-workspace.yaml` first (higher priority), then falls back to
 * the `workspaces` field in `package.json` (npm/yarn format), and finally
 * checks for Deno workspace configuration.
 * @param {string} projectDir - Absolute path to the project root.
 * @param {{ pkg?: object|null, denoJson?: object|null }} [preloaded] - Pre-read manifests to avoid duplicate I/O.
 * @param {object|null} fsMemo - Per-run fs memoization helper.
 * @returns {string[]} Absolute paths to workspace subdirectories (excludes the root itself).
 */
export function resolveWorkspaces(projectDir, preloaded, fsMemo = null) {
  const f = fsOps(fsMemo);

  const pnpmPath = join(projectDir, "pnpm-workspace.yaml");
  if (f.exists(pnpmPath)) {
    const content = f.readFile(pnpmPath, "utf-8");
    if (content !== null) {
      const patterns = parsePnpmWorkspaceYaml(content);
      if (patterns.length > 0) {
        return expandWorkspacePatterns(projectDir, patterns, fsMemo).filter(
          (d) => resolve(d) !== resolve(projectDir),
        );
      }
    }
  }

  const pkg = preloaded?.pkg !== undefined ? preloaded.pkg : readPackageJson(projectDir, fsMemo);
  if (pkg) {
    const ws = pkg.workspaces;
    const patterns = Array.isArray(ws) ? ws : Array.isArray(ws?.packages) ? ws.packages : null;
    if (patterns?.length > 0) {
      return expandWorkspacePatterns(projectDir, patterns, fsMemo).filter(
        (d) => resolve(d) !== resolve(projectDir),
      );
    }
  }

  const denoJson =
    preloaded?.denoJson !== undefined ? preloaded.denoJson : readDenoJson(projectDir);
  if (denoJson?.workspace) {
    const members = Array.isArray(denoJson.workspace) ? denoJson.workspace : [];
    if (members.length > 0) {
      return expandWorkspacePatterns(projectDir, members, fsMemo).filter(
        (d) => resolve(d) !== resolve(projectDir),
      );
    }
  }

  return [];
}

// ── Detection ─────────────────────────────────────────────────

/**
 * Reads and parses the package.json from the given directory.
 * Returns the parsed object, or null if the file is missing or malformed.
 * @param {string} dir - Directory to look in.
 * @param {object|null} fsMemo - Per-run fs memoization helper.
 * @returns {object|null}
 */
export function readPackageJson(dir, fsMemo = null) {
  const f = fsOps(fsMemo);
  const content = f.readFile(join(dir, "package.json"), "utf-8");
  if (content === null) return null;
  try { return JSON.parse(content); }
  catch { return null; }
}

/**
 * Reads and parses deno.json or deno.jsonc from the given directory.
 * Returns the parsed object, or null if neither file exists or is malformed.
 * @param {string} dir - Directory to look in.
 * @returns {object|null}
 */
export function readDenoJson(dir) {
  for (const name of ["deno.json", "deno.jsonc"]) {
    try {
      return JSON.parse(readFileSync(join(dir, name), "utf-8"));
    } catch {
      continue;
    }
  }
  return null;
}

/**
 * Extracts package names from a Deno import map.
 * Handles `npm:`, `jsr:` prefixed specifiers and plain URLs.
 * @param {object|null} denoJson - Parsed deno.json object.
 * @returns {string[]} Normalised package names.
 */
export function getDenoImportNames(denoJson) {
  if (!denoJson?.imports) return [];
  return Object.values(denoJson.imports)
    .filter((s) => typeof s === "string" && (s.startsWith("npm:") || s.startsWith("jsr:")))
    .map((specifier) => {
      const bare = specifier.replace(/^(?:npm|jsr):/, "");
      if (bare.startsWith("@")) {
        return bare.replace(/^(@[^/]+\/[^@]+).*$/, "$1");
      }
      return bare.replace(/@.*$/, "");
    });
}

/**
 * Extracts all package names from the given package.json object.
 * Returns an array of package names from both dependencies and devDependencies.
 */
export function getAllPackageNames(pkg) {
  if (!pkg) return [];
  return [...Object.keys(pkg.dependencies || {}), ...Object.keys(pkg.devDependencies || {})];
}

/**
 * Scans a single directory for known technologies by checking packages, package patterns,
 * config files, and config file content against the SKILLS_MAP.
 * Also determines whether the directory looks like a frontend project.
 * @param {string} dir - Directory to scan.
 * @param {{ skipFrontendFiles?: boolean, pkg?: object|null, denoJson?: object|null }} [opts] - Options and preloaded manifests.
 * @param {object|null} fsMemo - Per-run fs memoization helper.
 * @returns {{ detected: object[], isFrontendByPackages: boolean, isFrontendByFiles: boolean }}
 */
function detectTechnologiesInDir(
  dir,
  { skipFrontendFiles = false, pkg: preloadedPkg, denoJson: preloadedDeno } = {},
  fsMemo,
) {
  const f = fsOps(fsMemo);

  const pkg = preloadedPkg !== undefined ? preloadedPkg : readPackageJson(dir, fsMemo);
  const allPackages = getAllPackageNames(pkg);
  const deno = preloadedDeno !== undefined ? preloadedDeno : readDenoJson(dir);
  const denoImports = getDenoImportNames(deno);
  const allDepsSet =
    denoImports.length > 0 ? new Set([...allPackages, ...denoImports]) : new Set(allPackages);
  const allDepsArray = denoImports.length > 0 ? [...allDepsSet] : allPackages;

  const isFrontendByPackages = allDepsArray.some((p) => FRONTEND_PACKAGES.has(p));
  const isFrontendByFiles =
    isFrontendByPackages || skipFrontendFiles ? false : hasWebFrontendFiles(dir, 3, fsMemo);

  const detected = [];

  for (const tech of SKILLS_MAP) {
    let found = false;

    if (tech.detect.packages) {
      found = tech.detect.packages.some((p) => allDepsSet.has(p));
    }

    if (!found && tech.detect.packagePatterns) {
      found = tech.detect.packagePatterns.some((pattern) =>
        allDepsArray.some((p) => pattern.test(p)),
      );
    }

    if (!found && tech.detect.configFiles) {
      found = tech.detect.configFiles.some((file) => f.exists(join(dir, file)));
    }

    if (!found && tech.detect.configFileContent) {
      const cfg = tech.detect.configFileContent;
      const paths = resolveConfigFileContentPaths(dir, cfg, fsMemo);
      const { patterns } = cfg;
      for (const filePath of paths) {
        const content = f.readFile(filePath, "utf-8");
        if (content === null) continue;
        if (patterns.some((p) => content.includes(p))) {
          found = true;
          break;
        }
      }
    }

    if (found) detected.push(tech);
  }

  return { detected, isFrontendByPackages, isFrontendByFiles };
}

export function detectTechnologies(projectDir) {
  const fsMemo = createFsMemo();
  const pkg = readPackageJson(projectDir, fsMemo);
  const denoJson = readDenoJson(projectDir);
  const root = detectTechnologiesInDir(projectDir, { pkg, denoJson }, fsMemo);
  const seenIds = new Map(root.detected.map((t) => [t.id, t]));
  let isFrontend = root.isFrontendByPackages || root.isFrontendByFiles;

  const workspaceDirs = resolveWorkspaces(projectDir, { pkg, denoJson }, fsMemo);
  for (const wsDir of workspaceDirs) {
    const ws = detectTechnologiesInDir(wsDir, { skipFrontendFiles: isFrontend }, fsMemo);

    for (const tech of ws.detected) {
      if (!seenIds.has(tech.id)) seenIds.set(tech.id, tech);
    }

    if (ws.isFrontendByPackages || ws.isFrontendByFiles) isFrontend = true;
  }

  const detected = [...seenIds.values()];
  const combos = detectCombos(detected.map((t) => t.id));

  return { detected, isFrontend, combos };
}

export function detectCombos(detectedIds) {
  const idSet = detectedIds instanceof Set ? detectedIds : new Set(detectedIds);
  return COMBO_SKILLS_MAP.filter((combo) => combo.requires.every((id) => idSet.has(id)));
}

// ── Agent Detection ─────────────────────────────────────────

export function detectAgents(home = homedir()) {
  const agents = ["universal"];

  for (const [folder, agentName] of AGENT_FOLDER_ENTRIES) {
    if (existsSync(join(home, folder, "skills"))) {
      agents.push(agentName);
    }
  }

  return agents;
}

// ── Helpers ──────────────────────────────────────────────────

export function parseSkillPath(skill) {
  if (skill.startsWith("http")) {
    return { repo: skill, skillName: "", full: skill };
  }

  const parts = skill.split("/");
  return {
    repo: parts.slice(0, 2).join("/"),
    skillName: parts.slice(2).join("/"),
    full: skill,
  };
}

// ── Installed Skills Detection ───────────────────────────────

/**
 * Returns the names of skills already installed in the project.
 * Reads `skills-lock.json` first; falls back to directory listing of `.agents/skills/`.
 * @param {string} projectDir - Absolute path to the project root.
 * @returns {Set<string>} Skill names (e.g. `"playwright-best-practices"`).
 */
export function getInstalledSkillNames(projectDir) {
  try {
    const lock = JSON.parse(readFileSync(join(projectDir, "skills-lock.json"), "utf-8"));
    if (lock?.skills && typeof lock.skills === "object") {
      return new Set(Object.keys(lock.skills));
    }
  } catch {}

  try {
    const entries = readdirSync(join(projectDir, ".agents", "skills"), { withFileTypes: true });
    return new Set(entries.filter((e) => e.isDirectory()).map((e) => e.name));
  } catch {}

  return new Set();
}

// ── Skill Collection ─────────────────────────────────────────

/**
 * Aggregates the final list of skills to install from detected technologies,
 * combo matches, and frontend bonus skills. Deduplicates by skill path and
 * tracks which sources contributed each skill.
 * @param {object} opts
 * @param {object[]} opts.detected - Technologies found in the project.
 * @param {boolean} opts.isFrontend - Whether the project has a web frontend.
 * @param {object[]} [opts.combos=[]] - Matched combo skill entries.
 * @param {Set<string>|null} [opts.installedNames=null] - Skill names already installed in the project.
 * @returns {{ skill: string, sources: string[], installed: boolean }[]} Deduplicated skill list.
 */
export function collectSkills({ detected, isFrontend, combos = [], installedNames = null }) {
  const skillMap = new Map();
  const skills = [];

  function addSkill(skill, source) {
    const existing = skillMap.get(skill);
    if (!existing) {
      const installed = installedNames
        ? installedNames.has(parseSkillPath(skill).skillName)
        : false;
      const entry = { skill, sources: [source], installed };
      skillMap.set(skill, entry);
      skills.push(entry);
    } else if (!existing.sources.includes(source)) {
      existing.sources.push(source);
    }
  }

  for (const tech of detected) {
    for (const skill of tech.skills) addSkill(skill, tech.name);
  }

  for (const combo of combos) {
    for (const skill of combo.skills) addSkill(skill, combo.name);
  }

  if (isFrontend) {
    for (const skill of FRONTEND_BONUS_SKILLS) addSkill(skill, "Frontend");
  }

  return skills;
}
