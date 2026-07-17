import { readFileSync, existsSync, readdirSync } from "node:fs";
import { join, resolve } from "node:path";
import { homedir } from "node:os";

import type { Technology, ComboSkill, ConfigFileContentBlock } from "./skills-map.ts";

export {
  SKILLS_MAP,
  COMBO_SKILLS_MAP,
  FRONTEND_PACKAGES,
  FRONTEND_BONUS_SKILLS,
  WEB_FRONTEND_EXTENSIONS,
  AGENT_FOLDER_MAP,
} from "./skills-map.ts";

export type { Technology, ComboSkill, ConfigFileContentBlock } from "./skills-map.ts";

import {
  SKILLS_MAP,
  COMBO_SKILLS_MAP,
  FRONTEND_PACKAGES,
  FRONTEND_BONUS_SKILLS,
  WEB_FRONTEND_EXTENSIONS,
  AGENT_FOLDER_MAP,
} from "./skills-map.ts";

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
  ".terraform",
  "var",
  "bin",
  "obj",
  ".vs",
]);

const GRADLE_SCAN_ROOT_FILES = [
  "build.gradle.kts",
  "build.gradle",
  "settings.gradle.kts",
  "settings.gradle",
  "gradle/libs.versions.toml",
];

const DOTNET_SCAN_ROOT_FILES = [
  "global.json",
  "NuGet.Config",
  "Directory.Build.props",
  "Directory.Packages.props",
];

// ── Gradle Scanning ──────────────────────────────────────────

export function parseSettingsGradleModules(content: string): string[] {
  const modules: string[] = [];
  const includeRe = /include\s*\(?\s*([^)]+)/g;
  let includeMatch;
  while ((includeMatch = includeRe.exec(content)) !== null) {
    const args = includeMatch[1];
    const quotedRe = /['"]([^'"]+)['"]/g;
    let quotedMatch;
    while ((quotedMatch = quotedRe.exec(args)) !== null) {
      modules.push(quotedMatch[1].replace(/^:/, "").replace(/:/g, "/"));
    }
  }
  return modules;
}

const _gradleCache = new Map<string, string[]>();

function gradleLayoutCandidatePaths(projectDir: string): string[] {
  const cached = _gradleCache.get(projectDir);
  if (cached) return cached;

  const candidates: string[] = [];
  const seen = new Set<string>();

  function add(filePath: string): void {
    if (!seen.has(filePath)) {
      candidates.push(filePath);
      seen.add(filePath);
    }
  }

  for (const f of GRADLE_SCAN_ROOT_FILES) {
    add(join(projectDir, f));
  }
  let entries: import("node:fs").Dirent[];
  try {
    entries = readdirSync(projectDir, { withFileTypes: true });
  } catch {
    entries = [];
  }
  for (const e of entries) {
    if (!e.isDirectory() || e.name.startsWith(".") || SCAN_SKIP_DIRS.has(e.name)) continue;
    for (const g of ["build.gradle.kts", "build.gradle"]) {
      add(join(projectDir, e.name, g));
    }
  }

  for (const settingsFile of ["settings.gradle.kts", "settings.gradle"]) {
    const settingsPath = join(projectDir, settingsFile);
    let content: string;
    try {
      content = readFileSync(settingsPath, "utf-8");
    } catch {
      continue;
    }
    for (const modulePath of parseSettingsGradleModules(content)) {
      for (const g of ["build.gradle.kts", "build.gradle"]) {
        add(join(projectDir, modulePath, g));
      }
    }
    break;
  }

  _gradleCache.set(projectDir, candidates);
  return candidates;
}

// ── .NET Scanning ────────────────────────────────────────────

const _dotNetCache = new Map<string, string[]>();

function dotNetLayoutCandidatePaths(projectDir: string): string[] {
  const cached = _dotNetCache.get(projectDir);
  if (cached) return cached;

  const candidates: string[] = [];
  const seen = new Set<string>();

  function add(filePath: string): void {
    if (!seen.has(filePath)) {
      candidates.push(filePath);
      seen.add(filePath);
    }
  }

  for (const f of DOTNET_SCAN_ROOT_FILES) {
    add(join(projectDir, f));
  }

  function scan(dir: string, depth: number): void {
    if (depth > 2) return;
    let entries: import("node:fs").Dirent[];
    try {
      entries = readdirSync(dir, { withFileTypes: true });
    } catch {
      return;
    }

    for (const e of entries) {
      if (e.isFile()) {
        const lower = e.name.toLowerCase();
        if (lower.endsWith(".sln") || lower.endsWith(".csproj") || lower.endsWith(".fsproj")) {
          add(join(dir, e.name));
        }
      } else if (e.isDirectory() && !e.name.startsWith(".") && !SCAN_SKIP_DIRS.has(e.name)) {
        scan(join(dir, e.name), depth + 1);
      }
    }
  }

  scan(projectDir, 0);

  _dotNetCache.set(projectDir, candidates);
  return candidates;
}

function resolveConfigFileContentPaths(
  projectDir: string,
  config: ConfigFileContentBlock,
): string[] {
  if (config.scanGradleLayout) {
    return gradleLayoutCandidatePaths(projectDir);
  }
  if (config.scanDotNetLayout) {
    return dotNetLayoutCandidatePaths(projectDir);
  }
  return (config.files || []).map((f) => join(projectDir, f));
}

// ── Project File Scanning ────────────────────────────────────

function hasFileWithExtension(
  projectDir: string,
  extensions: string[],
  maxDepth: number = 4,
): boolean {
  const normalized = new Set(
    extensions.map((ext) => (ext.startsWith(".") ? ext : `.${ext}`).toLowerCase()),
  );
  const normalizedExtensions = [...normalized];

  function scan(dir: string, depth: number): boolean {
    let entries: import("node:fs").Dirent[];
    try {
      entries = readdirSync(dir, { withFileTypes: true });
    } catch {
      return false;
    }

    for (const entry of entries) {
      if (entry.isFile()) {
        const lowerName = entry.name.toLowerCase();
        if (normalizedExtensions.some((ext) => lowerName.endsWith(ext))) return true;
      } else if (entry.isDirectory() && depth < maxDepth) {
        if (SCAN_SKIP_DIRS.has(entry.name) || entry.name.startsWith(".")) continue;
        if (scan(join(dir, entry.name), depth + 1)) return true;
      }
    }

    return false;
  }

  return scan(projectDir, 0);
}

// ── Frontend File Scanning ───────────────────────────────────

export function hasWebFrontendFiles(projectDir: string, maxDepth: number = 3): boolean {
  function scan(dir: string, depth: number): boolean {
    let entries: import("node:fs").Dirent[];
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

function parsePnpmWorkspaceYaml(content: string): string[] {
  const lines = content.split("\n");
  const patterns: string[] = [];
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

function expandWorkspacePatterns(projectDir: string, patterns: string[]): string[] {
  const dirs: string[] = [];

  for (const pattern of patterns) {
    if (pattern.includes("*")) {
      const parent = join(projectDir, pattern.replace(/\/?\*.*$/, ""));
      let entries: import("node:fs").Dirent[];
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

interface PreloadedManifests {
  pkg?: Record<string, unknown> | null;
  denoJson?: Record<string, unknown> | null;
}

export function resolveWorkspaces(projectDir: string, preloaded?: PreloadedManifests): string[] {
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
    const ws = (pkg as Record<string, unknown>).workspaces;
    const patterns = Array.isArray(ws)
      ? (ws as string[])
      : Array.isArray((ws as Record<string, unknown>)?.packages)
        ? (ws as Record<string, string[]>).packages
        : null;
    if (patterns && patterns.length > 0) {
      return expandWorkspacePatterns(projectDir, patterns).filter(
        (d) => resolve(d) !== resolve(projectDir),
      );
    }
  }

  const denoJson =
    preloaded?.denoJson !== undefined ? preloaded.denoJson : readDenoJson(projectDir);
  if (denoJson?.workspace) {
    const members = Array.isArray(denoJson.workspace) ? (denoJson.workspace as string[]) : [];
    if (members.length > 0) {
      return expandWorkspacePatterns(projectDir, members).filter(
        (d) => resolve(d) !== resolve(projectDir),
      );
    }
  }

  return [];
}

// ── Detection ─────────────────────────────────────────────────

export function readGemfile(dir: string): string[] {
  const gemfilePath = join(dir, "Gemfile");
  if (!existsSync(gemfilePath)) return [];

  try {
    const content = readFileSync(gemfilePath, "utf-8");
    const gems: string[] = [];
    const gemRegex = /^\s*gem\s+['"]([^'"]+)['"]/gm;
    let match;
    while ((match = gemRegex.exec(content)) !== null) {
      gems.push(match[1]);
    }
    return gems;
  } catch {
    return [];
  }
}

export function readPackageJson(dir: string): Record<string, unknown> | null {
  try {
    return JSON.parse(readFileSync(join(dir, "package.json"), "utf-8"));
  } catch {
    return null;
  }
}

export function readDenoJson(dir: string): Record<string, unknown> | null {
  for (const name of ["deno.json", "deno.jsonc"]) {
    try {
      return JSON.parse(readFileSync(join(dir, name), "utf-8"));
    } catch {
      continue;
    }
  }
  return null;
}

export function getDenoImportNames(denoJson: Record<string, unknown> | null): string[] {
  if (!denoJson?.imports) return [];
  return Object.values(denoJson.imports as Record<string, string>)
    .filter((s) => typeof s === "string" && (s.startsWith("npm:") || s.startsWith("jsr:")))
    .map((specifier) => {
      const bare = specifier.replace(/^(?:npm|jsr):/, "");
      if (bare.startsWith("@")) {
        return bare.replace(/^(@[^/]+\/[^@]+).*$/, "$1");
      }
      return bare.replace(/@.*$/, "");
    });
}

export function getAllPackageNames(pkg: Record<string, unknown> | null): string[] {
  if (!pkg) return [];

  return [
    ...Object.keys((pkg.dependencies as Record<string, string>) || {}),
    ...Object.keys((pkg.devDependencies as Record<string, string>) || {}),
  ];
}

interface DetectInDirOptions {
  skipFrontendFiles?: boolean;
  pkg?: Record<string, unknown> | null;
  denoJson?: Record<string, unknown> | null;
}

interface DetectInDirResult {
  detected: Technology[];
  isFrontendByPackages: boolean;
  isFrontendByFiles: boolean;
}

function detectTechnologiesInDir(
  dir: string,
  {
    skipFrontendFiles = false,
    pkg: preloadedPkg,
    denoJson: preloadedDeno,
  }: DetectInDirOptions = {},
): DetectInDirResult {
  const pkg = preloadedPkg !== undefined ? preloadedPkg : readPackageJson(dir);
  const allPackages = getAllPackageNames(pkg);
  const deno = preloadedDeno !== undefined ? preloadedDeno : readDenoJson(dir);
  const denoImports = getDenoImportNames(deno);
  const allDepsSet =
    denoImports.length > 0 ? new Set([...allPackages, ...denoImports]) : new Set(allPackages);
  const allDepsArray = denoImports.length > 0 ? [...allDepsSet] : allPackages;
  let gemNames: string[] | undefined;
  const detected: Technology[] = [];
  const fileContentCache = new Map<string, string | null>();
  const existsCache = new Map<string, boolean>();
  const fileExtensionCache = new Map<string, boolean>();

  function cachedRead(filePath: string): string | null {
    if (fileContentCache.has(filePath)) return fileContentCache.get(filePath)!;
    let content: string | null = null;
    try {
      content = readFileSync(filePath, "utf-8");
    } catch {}
    fileContentCache.set(filePath, content);
    if (content !== null) existsCache.set(filePath, true);
    return content;
  }

  function cachedExists(filePath: string): boolean {
    if (existsCache.has(filePath)) return existsCache.get(filePath)!;
    const result = existsSync(filePath);
    existsCache.set(filePath, result);
    return result;
  }

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
      found = tech.detect.configFiles.some((f) => cachedExists(join(dir, f)));
    }

    if (!found && tech.detect.fileExtensions) {
      const key = tech.detect.fileExtensions.join("\0");
      if (!fileExtensionCache.has(key)) {
        fileExtensionCache.set(key, hasFileWithExtension(dir, tech.detect.fileExtensions));
      }
      found = fileExtensionCache.get(key)!;
    }

    if (!found && tech.detect.gems) {
      if (gemNames === undefined) gemNames = readGemfile(dir);
      found = tech.detect.gems.some((g) => gemNames!.includes(g));
    }

    if (!found && tech.detect.configFileContent) {
      const configs = Array.isArray(tech.detect.configFileContent)
        ? tech.detect.configFileContent
        : [tech.detect.configFileContent];
      for (const cfg of configs) {
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
        if (found) break;
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

export interface DetectResult {
  detected: Technology[];
  isFrontend: boolean;
  combos: ComboSkill[];
}

export function detectTechnologies(projectDir: string): DetectResult {
  const pkg = readPackageJson(projectDir);
  const denoJson = readDenoJson(projectDir);
  const root = detectTechnologiesInDir(projectDir, { pkg, denoJson });
  const seenIds = new Map<string, Technology>(root.detected.map((t) => [t.id, t]));
  let isFrontend = root.isFrontendByPackages || root.isFrontendByFiles;

  const workspaceDirs = resolveWorkspaces(projectDir, { pkg, denoJson });
  for (const wsDir of workspaceDirs) {
    const ws = detectTechnologiesInDir(wsDir, { skipFrontendFiles: isFrontend });

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

export function detectCombos(detectedIds: string[]): ComboSkill[] {
  const idSet = detectedIds instanceof Set ? detectedIds : new Set(detectedIds);
  return COMBO_SKILLS_MAP.filter((combo) => combo.requires.every((id) => idSet.has(id)));
}

// ── Agent Detection ─────────────────────────────────────────

export function detectAgents(home: string = homedir()): string[] {
  const agents = ["universal"];

  for (const [folder, agentName] of AGENT_FOLDER_ENTRIES) {
    if (existsSync(join(home, folder, "skills"))) {
      agents.push(agentName);
    }
  }

  return agents;
}

// ── Helpers ──────────────────────────────────────────────────

export interface ParsedSkillPath {
  repo: string;
  skillName: string;
  full: string;
}

export function parseSkillPath(skill: string): ParsedSkillPath {
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

export function getInstalledSkillNames(projectDir: string): Set<string> {
  try {
    const lock = JSON.parse(readFileSync(join(projectDir, "skills-lock.json"), "utf-8"));
    if (lock?.skills && typeof lock.skills === "object" && Object.keys(lock.skills).length > 0) {
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

export interface SkillEntry {
  skill: string;
  sources: string[];
  installed: boolean;
}

interface CollectSkillsOptions {
  detected: Technology[];
  isFrontend: boolean;
  combos?: ComboSkill[];
  installedNames?: Set<string> | null;
}

export function collectSkills({
  detected,
  isFrontend,
  combos = [],
  installedNames = null,
}: CollectSkillsOptions): SkillEntry[] {
  const skillMap = new Map<string, SkillEntry>();
  const skills: SkillEntry[] = [];

  function addSkill(skill: string, source: string): void {
    const existing = skillMap.get(skill);
    if (!existing) {
      const installed = installedNames
        ? installedNames.has(parseSkillPath(skill).skillName)
        : false;
      const entry: SkillEntry = { skill, sources: [source], installed };
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
