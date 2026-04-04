import { readFileSync, existsSync, readdirSync, statSync } from "node:fs";
import { join, resolve, dirname, extname } from "node:path";
import { homedir } from "node:os";
import { pathToFileURL } from "node:url";

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
 * @returns {string[]} Candidate file paths.
 */
const _gradleCache = new Map();

function gradleLayoutCandidatePaths(projectDir) {
  const cached = _gradleCache.get(projectDir);
  if (cached) return cached;

  const candidates = [];
  for (const f of GRADLE_SCAN_ROOT_FILES) {
    candidates.push(join(projectDir, f));
  }
  let entries;
  try {
    entries = readdirSync(projectDir, { withFileTypes: true });
  } catch {
    entries = [];
  }
  for (const e of entries) {
    if (!e.isDirectory() || e.name.startsWith(".") || SCAN_SKIP_DIRS.has(e.name)) continue;
    for (const g of ["build.gradle.kts", "build.gradle"]) {
      candidates.push(join(projectDir, e.name, g));
    }
  }
  _gradleCache.set(projectDir, candidates);
  return candidates;
}

/**
 * Resolves the file paths that should be read when checking `configFileContent` detection rules.
 * Delegates to the Gradle scanner when `scanGradleLayout` is set, otherwise maps `config.files`
 * relative to the given directory.
 * @param {string} projectDir - Directory to resolve paths against.
 * @param {object} config - The `configFileContent` block from a SKILLS_MAP entry.
 * @returns {string[]} Absolute file paths to check.
 */
function resolveConfigFileContentPaths(projectDir, config) {
  if (config.scanGradleLayout) {
    return gradleLayoutCandidatePaths(projectDir);
  }
  return (config.files || []).map((f) => join(projectDir, f));
}

// ── User Config ──────────────────────────────────────────────

const LOCAL_CONFIG_FILES = [
  ".autoskillsrc.json",
  ".autoskillsrc.js",
  ".autoskillsrc.mjs",
  ".autoskillsrc.cjs",
  "autoskills.config.js",
  "autoskills.config.mjs",
  "autoskills.config.cjs",
];

const GLOBAL_CONFIG_FILES = [...LOCAL_CONFIG_FILES];

function findConfigInDir(dir, names) {
  for (const name of names) {
    const filePath = join(dir, name);
    if (existsSync(filePath)) {
      return filePath;
    }
  }
  return null;
}

export function findLocalConfig(startDir = process.cwd()) {
  return findConfigInDir(resolve(startDir), LOCAL_CONFIG_FILES);
}

export function findGlobalConfig(startDir = process.cwd()) {
  let current = dirname(resolve(startDir));
  while (true) {
    const found = findConfigInDir(current, GLOBAL_CONFIG_FILES);
    if (found) {
      return found;
    }
    const parent = dirname(current);
    if (parent === current) {
      return null;
    }
    current = parent;
  }
}

export async function loadConfigFile(filePath) {
  const ext = extname(filePath);
  if (ext === ".json") {
    return JSON.parse(readFileSync(filePath, "utf-8"));
  }
  if (ext === ".js" || ext === ".mjs" || ext === ".cjs") {
    const fileUrl = pathToFileURL(filePath).href;
    const cacheBuster = `v=${statSync(filePath).mtimeMs}`;
    const mod = await import(`${fileUrl}?${cacheBuster}`);
    return mod.default ?? mod;
  }
  throw new Error(`Unsupported config file extension: ${ext || "unknown"}`);
}

function isPlainObject(value) {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

export function validateSkillConfig(config) {
  if (!Array.isArray(config)) {
    throw new Error("Config must export an array");
  }
  for (let i = 0; i < config.length; i++) {
    const skill = config[i];
    if (!isPlainObject(skill)) {
      throw new Error(`Item at index ${i} must be an object`);
    }
    if (typeof skill.id !== "string" || skill.id.trim() === "") {
      throw new Error(`Item at index ${i} must include a non-empty string id`);
    }
    if (typeof skill.name !== "string" || skill.name.trim() === "") {
      throw new Error(`Item at index ${i} must include a non-empty string name`);
    }
    if (!isPlainObject(skill.detect)) {
      throw new Error(`Item "${skill.id}" must include a detect object`);
    }
    if (!Array.isArray(skill.skills) || skill.skills.some((entry) => typeof entry !== "string")) {
      throw new Error(`Item "${skill.id}" must include a skills string[]`);
    }
    if (
      skill.detect.packages &&
      (!Array.isArray(skill.detect.packages) ||
        skill.detect.packages.some((entry) => typeof entry !== "string"))
    ) {
      throw new Error(`Item "${skill.id}" detect.packages must be string[]`);
    }
    if (skill.detect.packagePatterns) {
      if (!Array.isArray(skill.detect.packagePatterns)) {
        throw new Error(`Item "${skill.id}" detect.packagePatterns must be an array`);
      }
      for (const pattern of skill.detect.packagePatterns) {
        if (pattern instanceof RegExp) {
          continue;
        }
        if (typeof pattern !== "string") {
          throw new Error(
            `Item "${skill.id}" detect.packagePatterns must contain strings or RegExp`,
          );
        }
        try {
          new RegExp(pattern);
        } catch {
          throw new Error(`Item "${skill.id}" has an invalid regex in detect.packagePatterns`);
        }
      }
    }
    if (
      skill.detect.configFiles &&
      (!Array.isArray(skill.detect.configFiles) ||
        skill.detect.configFiles.some((entry) => typeof entry !== "string"))
    ) {
      throw new Error(`Item "${skill.id}" detect.configFiles must be string[]`);
    }
    if (skill.detect.configFileContent) {
      if (!isPlainObject(skill.detect.configFileContent)) {
        throw new Error(`Item "${skill.id}" detect.configFileContent must be an object`);
      }
      const { patterns, files } = skill.detect.configFileContent;
      if (!Array.isArray(patterns) || patterns.some((entry) => typeof entry !== "string")) {
        throw new Error(`Item "${skill.id}" detect.configFileContent.patterns must be string[]`);
      }
      if (files && (!Array.isArray(files) || files.some((entry) => typeof entry !== "string"))) {
        throw new Error(`Item "${skill.id}" detect.configFileContent.files must be string[]`);
      }
    }
  }
}

export function mergeSkillsMap(baseMap, overrides) {
  const merged = [...baseMap];
  for (const override of overrides) {
    const idx = merged.findIndex((entry) => entry.id === override.id);
    if (idx === -1) {
      merged.push(override);
    } else {
      merged[idx] = override;
    }
  }
  return merged;
}

// ── Frontend File Scanning ───────────────────────────────────

/**
 * Recursively checks whether the project contains files with web-frontend extensions
 * (e.g. `.html`, `.css`, `.vue`, `.blade.php`).
 * Skips common non-source directories like `node_modules` and `.git`.
 * @param {string} projectDir - Root directory to scan.
 * @param {number} [maxDepth=3] - Maximum directory nesting depth to traverse.
 * @returns {boolean} `true` if at least one frontend-related file is found.
 */
export function hasWebFrontendFiles(projectDir, maxDepth = 3) {
  function scan(dir, depth) {
    let entries;
    try {
      entries = readdirSync(dir, { withFileTypes: true });
    } catch {
      return false;
    }

    for (const entry of entries) {
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

/**
 * Zero-dependency parser for `pnpm-workspace.yaml`.
 * Extracts the `packages:` list entries (supports quoted and unquoted values).
 * @param {string} content - Raw file content of pnpm-workspace.yaml.
 * @returns {string[]} Workspace glob patterns (e.g. `["packages/*", "apps/*"]`).
 */
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
        patterns.push(
          line
            .slice(2)
            .trim()
            .replace(/^['"]|['"]$/g, ""),
        );
      } else if (line !== "" && !line.startsWith("#")) {
        break;
      }
    }
  }

  return patterns;
}

/**
 * Expands workspace glob patterns (e.g. `packages/*`) into actual directory paths
 * that contain a `package.json`. Non-glob patterns are treated as exact directory references.
 * @param {string} projectDir - Absolute path to the monorepo root.
 * @param {string[]} patterns - Workspace patterns to resolve.
 * @returns {string[]} Absolute paths to workspace directories.
 */
function expandWorkspacePatterns(projectDir, patterns) {
  const dirs = [];

  for (const pattern of patterns) {
    if (pattern.includes("*")) {
      const parent = join(projectDir, pattern.replace(/\/?\*.*$/, ""));
      let entries;
      try {
        entries = readdirSync(parent, { withFileTypes: true });
      } catch {
        continue;
      }
      for (const entry of entries) {
        if (!entry.isDirectory() || SCAN_SKIP_DIRS.has(entry.name) || entry.name.startsWith("."))
          continue;
        const wsDir = join(parent, entry.name);
        if (
          existsSync(join(wsDir, "package.json")) ||
          existsSync(join(wsDir, "deno.json")) ||
          existsSync(join(wsDir, "deno.jsonc"))
        ) {
          dirs.push(wsDir);
        }
      }
    } else {
      const wsDir = join(projectDir, pattern);
      if (
        existsSync(join(wsDir, "package.json")) ||
        existsSync(join(wsDir, "deno.json")) ||
        existsSync(join(wsDir, "deno.jsonc"))
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
 * the `workspaces` field in `package.json` (npm/yarn format).
 * @param {string} projectDir - Absolute path to the project root.
 * @param {{ pkg?: object|null, denoJson?: object|null }} [preloaded] - Pre-read manifests to avoid duplicate I/O.
 * @returns {string[]} Absolute paths to workspace subdirectories (excludes the root itself).
 */
export function resolveWorkspaces(projectDir, preloaded) {
  const pnpmPath = join(projectDir, "pnpm-workspace.yaml");
  if (existsSync(pnpmPath)) {
    try {
      const content = readFileSync(pnpmPath, "utf-8");
      const patterns = parsePnpmWorkspaceYaml(content);
      if (patterns.length > 0) {
        return expandWorkspacePatterns(projectDir, patterns).filter(
          (d) => resolve(d) !== resolve(projectDir),
        );
      }
    } catch {}
  }

  const pkg = preloaded?.pkg !== undefined ? preloaded.pkg : readPackageJson(projectDir);
  if (pkg) {
    const ws = pkg.workspaces;
    const patterns = Array.isArray(ws) ? ws : Array.isArray(ws?.packages) ? ws.packages : null;
    if (patterns && patterns.length > 0) {
      return expandWorkspacePatterns(projectDir, patterns).filter(
        (d) => resolve(d) !== resolve(projectDir),
      );
    }
  }

  const denoJson =
    preloaded?.denoJson !== undefined ? preloaded.denoJson : readDenoJson(projectDir);
  if (denoJson?.workspace) {
    const members = Array.isArray(denoJson.workspace) ? denoJson.workspace : [];
    if (members.length > 0) {
      return expandWorkspacePatterns(projectDir, members).filter(
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
 */
export function readPackageJson(dir) {
  try {
    return JSON.parse(readFileSync(join(dir, "package.json"), "utf-8"));
  } catch {
    return null;
  }
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
 * config files, and config file content against the given skills map.
 * Also determines whether the directory looks like a frontend project.
 * @param {string} dir - Directory to scan.
 * @param {object[]} skillsMap - Skills map to scan against.
 * @param {object} [opts] - Options for scanning.
 * @returns {{ detected: object[], isFrontendByPackages: boolean, isFrontendByFiles: boolean }}
 */
function detectTechnologiesInDir(
  dir,
  skillsMap,
  { skipFrontendFiles = false, pkg: preloadedPkg, denoJson: preloadedDeno } = {},
) {
  const pkg = preloadedPkg !== undefined ? preloadedPkg : readPackageJson(dir);
  const allPackages = getAllPackageNames(pkg);
  const deno = preloadedDeno !== undefined ? preloadedDeno : readDenoJson(dir);
  const denoImports = getDenoImportNames(deno);
  const allDepsSet =
    denoImports.length > 0 ? new Set([...allPackages, ...denoImports]) : new Set(allPackages);
  const allDepsArray = denoImports.length > 0 ? [...allDepsSet] : allPackages;
  const detected = [];
  const fileContentCache = new Map();
  const existsCache = new Map();

  function cachedRead(filePath) {
    if (fileContentCache.has(filePath)) return fileContentCache.get(filePath);
    let content = null;
    try {
      content = readFileSync(filePath, "utf-8");
    } catch {}
    fileContentCache.set(filePath, content);
    if (content !== null) existsCache.set(filePath, true);
    return content;
  }

  function cachedExists(filePath) {
    if (existsCache.has(filePath)) return existsCache.get(filePath);
    const result = existsSync(filePath);
    existsCache.set(filePath, result);
    return result;
  }

  for (const tech of skillsMap) {
    let found = false;

    if (tech.detect.packages) {
      found = tech.detect.packages.some((p) => allDepsSet.has(p));
    }

    if (!found && tech.detect.packagePatterns) {
      found = tech.detect.packagePatterns.some((pattern) => {
        const regex = pattern instanceof RegExp ? pattern : new RegExp(pattern);
        return allDepsArray.some((p) => regex.test(p));
      });
    }

    if (!found && tech.detect.configFiles) {
      found = tech.detect.configFiles.some((f) => cachedExists(join(dir, f)));
    }

    if (!found && tech.detect.configFileContent) {
      const cfg = tech.detect.configFileContent;
      const paths = resolveConfigFileContentPaths(dir, cfg);
      const { patterns } = cfg;
      for (const filePath of paths) {
        const content = cachedRead(filePath);
        if (content === null) continue;
        if (patterns.some((p) => content.includes(p))) {
          found = true;
          break;
        }
      }
    }

    if (found) {
      detected.push(tech);
    }
  }

  const isFrontendByPackages = allDepsArray.some((p) => FRONTEND_PACKAGES.has(p));
  const isFrontendByFiles =
    isFrontendByPackages || skipFrontendFiles ? false : hasWebFrontendFiles(dir);

  return { detected, isFrontendByPackages, isFrontendByFiles };
}

/**
 * Main detection entry point (internal). Scans the project root and all workspace subdirectories,
 * merges and deduplicates detected technologies, and resolves cross-technology combos.
 * @param {string} projectDir - Absolute path to the project root.
 * @param {object[]} skillsMap - Skills map to scan against.
 * @returns {{ detected: object[], isFrontend: boolean, combos: object[] }}
 */
function detectTechnologiesWithSkillsMap(projectDir, skillsMap) {
  const pkg = readPackageJson(projectDir);
  const denoJson = readDenoJson(projectDir);
  const root = detectTechnologiesInDir(projectDir, skillsMap, { pkg, denoJson });
  const seenIds = new Map(root.detected.map((t) => [t.id, t]));
  let isFrontend = root.isFrontendByPackages || root.isFrontendByFiles;

  const workspaceDirs = resolveWorkspaces(projectDir, { pkg, denoJson });
  for (const wsDir of workspaceDirs) {
    const ws = detectTechnologiesInDir(wsDir, skillsMap, { skipFrontendFiles: isFrontend });

    for (const tech of ws.detected) {
      if (!seenIds.has(tech.id)) {
        seenIds.set(tech.id, tech);
      }
    }

    if (ws.isFrontendByPackages || ws.isFrontendByFiles) {
      isFrontend = true;
    }
  }

  const detected = [...seenIds.values()];
  const detectedIds = detected.map((t) => t.id);
  const combos = detectCombos(detectedIds);

  return { detected, isFrontend, combos };
}

function normalizeErrorMessage(error) {
  if (!error || typeof error !== "object") {
    return "Unknown error";
  }
  const code = typeof error.code === "string" ? error.code : null;
  const message = typeof error.message === "string" ? error.message : "Unknown error";
  if (code === "EACCES") {
    return "Permission denied";
  }
  if (code === "ENOENT") {
    return "File not found";
  }
  return message;
}

function warnConfigError(scope, filePath, error) {
  console.warn(
    `[autoskills] Skipping ${scope} config (${filePath}): ${normalizeErrorMessage(error)}`,
  );
}

async function detectTechnologiesAsync(projectDir) {
  let mergedSkillsMap = SKILLS_MAP;
  const globalConfigPath = findGlobalConfig(projectDir);
  if (globalConfigPath) {
    try {
      const globalConfig = await loadConfigFile(globalConfigPath);
      validateSkillConfig(globalConfig);
      mergedSkillsMap = mergeSkillsMap(mergedSkillsMap, globalConfig);
    } catch (error) {
      warnConfigError("global", globalConfigPath, error);
    }
  }

  const localConfigPath = findLocalConfig(projectDir);
  if (localConfigPath) {
    try {
      const localConfig = await loadConfigFile(localConfigPath);
      validateSkillConfig(localConfig);
      mergedSkillsMap = mergeSkillsMap(mergedSkillsMap, localConfig);
    } catch (error) {
      warnConfigError("local", localConfigPath, error);
    }
  }

  return detectTechnologiesWithSkillsMap(projectDir, mergedSkillsMap);
}

export function detectTechnologies(projectDir) {
  const fallback = detectTechnologiesWithSkillsMap(projectDir, SKILLS_MAP);
  const promise = detectTechnologiesAsync(projectDir);
  return Object.assign(promise, fallback);
}

/**
 * Finds combo skills whose requirements are fully satisfied by the detected technology IDs.
 * @param {string[]} detectedIds - Array of technology IDs found in the project.
 * @returns {object[]} Matching entries from COMBO_SKILLS_MAP.
 */
export function detectCombos(detectedIds) {
  const idSet = detectedIds instanceof Set ? detectedIds : new Set(detectedIds);
  return COMBO_SKILLS_MAP.filter((combo) => combo.requires.every((id) => idSet.has(id)));
}

// ── Agent Detection ─────────────────────────────────────────

/**
 * Detects which AI coding agents are installed by checking for `skills/` subdirectories
 * inside known agent folders in the user's home directory.
 * Always includes `"universal"` as the first entry.
 * @param {string} [home=os.homedir()] - Home directory to scan (injectable for testing).
 * @returns {string[]} Agent identifiers suitable for `npx skills add -a ...`.
 */
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

/**
 * Splits a skill identifier (e.g. `"owner/repo/skill-name"`) into its repo and skill components.
 * Full URLs are returned as-is in the `repo` field.
 * @param {string} skill - Skill path string.
 * @returns {{ repo: string, skillName: string, full: string }}
 */
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

// ── Skill Collection ─────────────────────────────────────────

/**
 * Aggregates the final list of skills to install from detected technologies,
 * combo matches, and frontend bonus skills. Deduplicates by skill path and
 * tracks which sources contributed each skill.
 * @param {object[]} detected - Technologies found in the project.
 * @param {boolean} isFrontend - Whether the project has a web frontend.
 * @param {object[]} [combos=[]] - Matched combo skill entries.
 * @returns {{ skill: string, sources: string[] }[]} Deduplicated skill list.
 */
export function collectSkills(detected, isFrontend, combos = []) {
  const skillMap = new Map();
  const skills = [];

  function addSkill(skill, source) {
    const existing = skillMap.get(skill);
    if (!existing) {
      const entry = { skill, sources: [source] };
      skillMap.set(skill, entry);
      skills.push(entry);
    } else if (!existing.sources.includes(source)) {
      existing.sources.push(source);
    }
  }

  for (const tech of detected) {
    for (const skill of tech.skills) {
      addSkill(skill, tech.name);
    }
  }

  for (const combo of combos) {
    for (const skill of combo.skills) {
      addSkill(skill, combo.name);
    }
  }

  if (isFrontend) {
    for (const skill of FRONTEND_BONUS_SKILLS) {
      addSkill(skill, "Frontend");
    }
  }

  return skills;
}
