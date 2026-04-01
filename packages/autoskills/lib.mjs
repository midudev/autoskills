import { readFileSync, existsSync, readdirSync } from "node:fs";
import { join, resolve } from "node:path";
import { homedir } from "node:os";

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
function gradleLayoutCandidatePaths(projectDir) {
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
        if (existsSync(join(wsDir, "package.json"))) {
          dirs.push(wsDir);
        }
      }
    } else {
      const wsDir = join(projectDir, pattern);
      if (existsSync(join(wsDir, "package.json"))) {
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
 * @returns {string[]} Absolute paths to workspace subdirectories (excludes the root itself).
 */
export function resolveWorkspaces(projectDir) {
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

  const pkg = readPackageJson(projectDir);
  if (pkg) {
    const ws = pkg.workspaces;
    const patterns = Array.isArray(ws) ? ws : Array.isArray(ws?.packages) ? ws.packages : null;
    if (patterns && patterns.length > 0) {
      return expandWorkspacePatterns(projectDir, patterns).filter(
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
  const pkgPath = join(dir, "package.json");
  if (!existsSync(pkgPath)) return null;

  try {
    return JSON.parse(readFileSync(pkgPath, "utf-8"));
  } catch {
    return null;
  }
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
 * @returns {{ detected: object[], isFrontendByPackages: boolean, isFrontendByFiles: boolean }}
 */
function detectTechnologiesInDir(dir) {
  const pkg = readPackageJson(dir);
  const allPackages = getAllPackageNames(pkg);
  const detected = [];

  for (const tech of SKILLS_MAP) {
    let found = false;

    if (tech.detect.packages) {
      found = tech.detect.packages.some((p) => allPackages.includes(p));
    }

    if (!found && tech.detect.packagePatterns) {
      found = tech.detect.packagePatterns.some((pattern) =>
        allPackages.some((p) => pattern.test(p)),
      );
    }

    if (!found && tech.detect.configFiles) {
      found = tech.detect.configFiles.some((f) => existsSync(join(dir, f)));
    }

    if (!found && tech.detect.configFileContent) {
      const cfg = tech.detect.configFileContent;
      const paths = resolveConfigFileContentPaths(dir, cfg);
      const { patterns } = cfg;
      for (const filePath of paths) {
        if (!existsSync(filePath)) continue;
        try {
          const content = readFileSync(filePath, "utf-8");
          if (patterns.some((p) => content.includes(p))) {
            found = true;
            break;
          }
        } catch {}
      }
    }

    if (found) {
      detected.push(tech);
    }
  }

  const isFrontendByPackages = allPackages.some((p) => FRONTEND_PACKAGES.includes(p));
  const isFrontendByFiles = hasWebFrontendFiles(dir);

  return { detected, isFrontendByPackages, isFrontendByFiles };
}

/**
 * Main detection entry point. Scans the project root and all workspace subdirectories,
 * merges and deduplicates detected technologies, and resolves cross-technology combos.
 * @param {string} projectDir - Absolute path to the project root.
 * @returns {{ detected: object[], isFrontend: boolean, combos: object[] }}
 */
export function detectTechnologies(projectDir) {
  const root = detectTechnologiesInDir(projectDir);
  const seenIds = new Map(root.detected.map((t) => [t.id, t]));
  let isFrontend = root.isFrontendByPackages || root.isFrontendByFiles;

  const workspaceDirs = resolveWorkspaces(projectDir);
  for (const wsDir of workspaceDirs) {
    const ws = detectTechnologiesInDir(wsDir);

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

/**
 * Finds combo skills whose requirements are fully satisfied by the detected technology IDs.
 * @param {string[]} detectedIds - Array of technology IDs found in the project.
 * @returns {object[]} Matching entries from COMBO_SKILLS_MAP.
 */
export function detectCombos(detectedIds) {
  return COMBO_SKILLS_MAP.filter((combo) => combo.requires.every((id) => detectedIds.includes(id)));
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

  for (const [folder, agentName] of Object.entries(AGENT_FOLDER_MAP)) {
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
  const seen = new Set();
  const skills = [];

  function addSkill(skill, source) {
    if (!seen.has(skill)) {
      seen.add(skill);
      skills.push({ skill, sources: [source] });
    } else {
      const existing = skills.find((s) => s.skill === skill);
      if (existing && !existing.sources.includes(source)) {
        existing.sources.push(source);
      }
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
