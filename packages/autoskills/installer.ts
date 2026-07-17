import {
  copyFileSync,
  existsSync,
  mkdirSync,
  readFileSync,
  readdirSync,
  rmSync,
  statSync,
  symlinkSync,
  writeFileSync,
  lstatSync,
} from "node:fs";
import { createHash } from "node:crypto";
import { dirname, join, relative } from "node:path";
import { homedir } from "node:os";
import { fileURLToPath } from "node:url";

import { parseSkillPath } from "./lib.ts";
import type { SkillEntry } from "./lib.ts";
import { AGENT_FOLDER_MAP } from "./skills-map.ts";
import { log, write, dim, green, cyan, red, HIDE_CURSOR, SHOW_CURSOR, SPINNER } from "./colors.ts";

// ── Registry ─────────────────────────────────────────────────

const DEFAULT_REGISTRY_RAW_BASE_URL_PREFIX = "https://raw.githubusercontent.com/midudev/autoskills";
const GITHUB_TOKEN = process.env.GITHUB_TOKEN || process.env.GH_TOKEN || "";

export interface RegistryEntry {
  source: string;
  skillPath: string;
  commitSha: string;
  files: string[];
  sha256: Record<string, string>;
  bundleHash: string;
  review: {
    status: "approved" | "flagged";
    flags: string[];
    summary: string;
    model: string;
    promptVersion: string;
    reviewedAt: string;
  };
  securityCheck?: {
    status: "ok" | "warning";
    findings: string[];
    summary: string;
    checkedAt: string;
  };
}

export interface Registry {
  version: number;
  generatedAt: string;
  reviewer: { model: string; promptVersion: string };
  skills: Record<string, RegistryEntry>;
}

const __dirname = dirname(fileURLToPath(import.meta.url));

let _cachedRegistry: Registry | null | undefined;
let _cachedRegistryDir: string | null = null;
let _cachedPackageVersion: string | null | undefined;

function getPackageVersion(): string | null {
  if (_cachedPackageVersion !== undefined) return _cachedPackageVersion;

  const candidates = [join(__dirname, "package.json"), join(__dirname, "..", "package.json")];
  for (const c of candidates) {
    try {
      const pkg = JSON.parse(readFileSync(c, "utf-8")) as { version?: unknown };
      if (typeof pkg.version === "string" && pkg.version.length > 0) {
        _cachedPackageVersion = pkg.version;
        return _cachedPackageVersion;
      }
    } catch {}
  }

  _cachedPackageVersion = null;
  return _cachedPackageVersion;
}

export function getRegistryDir(): string {
  if (_cachedRegistryDir) return _cachedRegistryDir;
  const candidates = [join(__dirname, "skills-registry"), join(__dirname, "..", "skills-registry")];
  for (const c of candidates) {
    if (existsSync(join(c, "index.json"))) {
      _cachedRegistryDir = c;
      return c;
    }
  }
  _cachedRegistryDir = candidates[0];
  return _cachedRegistryDir;
}

export function loadRegistry(): Registry | null {
  if (_cachedRegistry !== undefined) return _cachedRegistry;
  const manifestPath = join(getRegistryDir(), "index.json");
  try {
    const body = JSON.parse(readFileSync(manifestPath, "utf-8")) as Registry;
    _cachedRegistry = body;
    return body;
  } catch {
    _cachedRegistry = null;
    return null;
  }
}

/** @internal — exported for testing only */
export function _setRegistryDir(dir: string | null): void {
  _cachedRegistryDir = dir;
  _cachedRegistry = undefined;
}

// ── Integrity ────────────────────────────────────────────────

function sha256File(path: string): string {
  return createHash("sha256").update(readFileSync(path)).digest("hex");
}

export function verifyRegistryEntry(
  skillName: string,
  entry: RegistryEntry,
  registryDir: string = getRegistryDir(),
): { ok: boolean; reason?: string } {
  const skillDir = join(registryDir, skillName);
  if (!existsSync(skillDir)) {
    return { ok: false, reason: `missing directory ${skillDir}` };
  }
  for (const rel of entry.files) {
    const normalizedRel = normalizeRegistryRelPath(rel);
    const abs = join(skillDir, ...normalizedRel.split("/"));
    if (!existsSync(abs)) {
      return { ok: false, reason: `missing file ${normalizedRel}` };
    }
    const expected = entry.sha256[rel] || entry.sha256[normalizedRel];
    if (!expected) {
      return { ok: false, reason: `no recorded hash for ${normalizedRel}` };
    }
    const actual = sha256File(abs);
    if (actual !== expected) {
      return { ok: false, reason: `hash mismatch for ${normalizedRel}` };
    }
  }
  return { ok: true };
}

// ── Install ──────────────────────────────────────────────────

export interface InstallResult {
  success: boolean;
  output: string;
  stderr: string;
  exitCode: number | null;
  command: string;
  securityCheck?: InstallSecurityCheck;
}

export interface InstallSecurityCheck {
  name: string;
  status: "ok" | "warning";
  summary: string;
  findings: string[];
}

interface InstallOptions {
  projectDir?: string;
  registryDir?: string;
  registryBaseUrl?: string;
  fetchImpl?: typeof fetch;
  verbose?: boolean;
  onTrace?: (message: string) => void;
}

function relPathFromTo(from: string, to: string): string {
  const rel = relative(from, to);
  return rel.split("\\").join("/");
}

function normalizeRegistryRelPath(rel: string): string {
  return rel.split("\\").join("/");
}

function sha256Buffer(buf: Buffer): string {
  return createHash("sha256").update(buf).digest("hex");
}

function getRegistryRawBaseUrls(opts: InstallOptions): string[] {
  const configured = opts.registryBaseUrl || process.env.AUTOSKILLS_REGISTRY_BASE_URL;
  if (configured) return [configured.replace(/\/+$/, "")];

  const version = getPackageVersion();
  if (!version) {
    throw new Error("could not resolve autoskills package version for registry download");
  }

  return [
    `${DEFAULT_REGISTRY_RAW_BASE_URL_PREFIX}/v${version}/packages/autoskills/skills-registry`,
    `${DEFAULT_REGISTRY_RAW_BASE_URL_PREFIX}/main/packages/autoskills/skills-registry`,
  ];
}

function getInstallRegistryDir(opts: InstallOptions): string {
  return opts.registryDir || getRegistryDir();
}

export function getAutoskillsCacheDir(): string {
  return (
    process.env.AUTOSKILLS_CACHE_DIR || join(homedir(), ".cache", "autoskills", "skills-registry")
  );
}

export function clearAutoskillsCache(): { cacheDir: string; removed: boolean } {
  const cacheDir = getAutoskillsCacheDir();
  const removed = existsSync(cacheDir);
  rmSync(cacheDir, { recursive: true, force: true });
  return { cacheDir, removed };
}

function getCacheRegistryDir(entry: RegistryEntry): string {
  return join(getAutoskillsCacheDir(), entry.bundleHash);
}

function securityCheckForEntry(skillName: string, entry: RegistryEntry): InstallSecurityCheck {
  if (entry.securityCheck) {
    return {
      name: skillName,
      status: entry.securityCheck.status,
      summary: entry.securityCheck.summary,
      findings: entry.securityCheck.findings,
    };
  }

  return {
    name: skillName,
    status: entry.review?.status === "flagged" ? "warning" : "ok",
    summary:
      entry.review?.summary ||
      (entry.review?.status === "flagged"
        ? "The sync review found issues that should be checked."
        : "The sync review did not find security issues."),
    findings: entry.review?.flags || [],
  };
}

export function securityCheckForSkillPath(skillPath: string): InstallSecurityCheck | null {
  const { skillName } = parseSkillPath(skillPath);
  if (!skillName) return null;

  const registry = loadRegistry();
  const entry = registry?.skills[skillName];
  if (!entry) return null;

  return securityCheckForEntry(skillName, entry);
}

function encodeRawPath(skillName: string, rel: string): string {
  return [skillName, ...normalizeRegistryRelPath(rel).split("/")].map(encodeURIComponent).join("/");
}

function githubDownloadHeaders(url: string): HeadersInit {
  const headers: Record<string, string> = { "User-Agent": "autoskills" };
  const host = new URL(url).hostname;
  if (GITHUB_TOKEN && /(^|\.)githubusercontent\.com$/i.test(host)) {
    headers.Authorization = `Bearer ${GITHUB_TOKEN}`;
  }
  return headers;
}

function isDisallowedSkillFile(rel: string): boolean {
  return rel.toLowerCase().endsWith(".zip");
}

async function downloadRegistryFile(
  skillName: string,
  entry: RegistryEntry,
  rel: string,
  opts: InstallOptions,
): Promise<{ buf: Buffer; url: string }> {
  const normalizedRel = normalizeRegistryRelPath(rel);

  if (isDisallowedSkillFile(normalizedRel)) {
    throw new Error(`refusing to download disallowed skill archive: ${normalizedRel}`);
  }

  const expected = entry.sha256[rel] || entry.sha256[normalizedRel];
  if (!expected) {
    throw new Error(`no recorded hash for ${normalizedRel}`);
  }

  const fetchFile = opts.fetchImpl || fetch;
  const errors = [];
  for (const baseUrl of getRegistryRawBaseUrls(opts)) {
    const url = `${baseUrl}/${encodeRawPath(skillName, normalizedRel)}`;
    opts.onTrace?.(`GET ${url}`);
    const res = await fetchFile(url, {
      headers: githubDownloadHeaders(url),
    });
    if (!res.ok) {
      const resetAt = Number(res.headers.get("x-ratelimit-reset") || 0) * 1000;
      const resetSuffix = resetAt ? ` (resets ${new Date(resetAt).toISOString()})` : "";
      if (res.status === 403 && res.headers.get("x-ratelimit-remaining") === "0") {
        throw new Error(
          `GitHub rate limit exceeded${resetSuffix}. Set GITHUB_TOKEN or GH_TOKEN to increase the limit.`,
        );
      }
      errors.push(`${res.status} ${res.statusText} from ${baseUrl}`);
      opts.onTrace?.(`miss ${normalizedRel}: ${res.status} ${res.statusText} from ${baseUrl}`);
      continue;
    }

    const buf = Buffer.from(await res.arrayBuffer());
    const actual = sha256Buffer(buf);
    if (actual !== expected) {
      errors.push(`hash mismatch from ${baseUrl}`);
      opts.onTrace?.(`hash mismatch for ${normalizedRel} from ${baseUrl}`);
      continue;
    }
    opts.onTrace?.(`downloaded ${normalizedRel} from ${url}`);
    return { buf, url };
  }

  throw new Error(`download failed for ${normalizedRel}: ${errors.join("; ")}`);
}

async function downloadRegistryEntry(
  skillName: string,
  entry: RegistryEntry,
  destDir: string,
  opts: InstallOptions,
): Promise<void> {
  const files = [];
  for (const rel of entry.files) {
    files.push({
      rel: normalizeRegistryRelPath(rel),
      ...(await downloadRegistryFile(skillName, entry, rel, opts)),
    });
  }

  const bundleHash = createHash("sha256")
    .update(
      files
        .map(({ rel, buf }) => `${rel}:${sha256Buffer(buf)}`)
        .sort()
        .join("\n"),
    )
    .digest("hex");
  if (bundleHash !== entry.bundleHash) {
    throw new Error("bundle hash mismatch");
  }

  rmSync(destDir, { recursive: true, force: true });
  for (const { rel, buf } of files) {
    const dest = join(destDir, ...rel.split("/"));
    mkdirSync(dirname(dest), { recursive: true });
    writeFileSync(dest, buf);
  }
  opts.onTrace?.(`wrote downloaded bundle to ${destDir}`);
}

function copyRegistryEntryFromLocal(
  skillName: string,
  entry: RegistryEntry,
  destDir: string,
  opts: InstallOptions,
): boolean {
  const registryDir = getInstallRegistryDir(opts);
  opts.onTrace?.(`checking local registry: ${join(registryDir, skillName)}`);
  const verdict = verifyRegistryEntry(skillName, entry, registryDir);
  if (!verdict.ok) {
    opts.onTrace?.(`local registry miss: ${verdict.reason}`);
    return false;
  }

  rmSync(destDir, { recursive: true, force: true });
  copyDir(join(registryDir, skillName), destDir);
  opts.onTrace?.(`copied from local registry: ${join(registryDir, skillName)}`);
  return true;
}

function copyRegistryEntryFromCache(
  skillName: string,
  entry: RegistryEntry,
  destDir: string,
  opts: InstallOptions,
): boolean {
  const registryDir = getCacheRegistryDir(entry);
  opts.onTrace?.(`checking download cache: ${join(registryDir, skillName)}`);
  const verdict = verifyRegistryEntry(skillName, entry, registryDir);
  if (!verdict.ok) {
    opts.onTrace?.(`cache miss: ${verdict.reason}`);
    return false;
  }

  rmSync(destDir, { recursive: true, force: true });
  copyDir(join(registryDir, skillName), destDir);
  opts.onTrace?.(`copied from download cache: ${join(registryDir, skillName)}`);
  return true;
}

async function downloadRegistryEntryToCache(
  skillName: string,
  entry: RegistryEntry,
  opts: InstallOptions,
): Promise<string> {
  const registryDir = getCacheRegistryDir(entry);
  const skillDir = join(registryDir, skillName);
  opts.onTrace?.(`downloading to cache: ${skillDir}`);
  await downloadRegistryEntry(skillName, entry, skillDir, opts);
  return skillDir;
}

function ensureSymlinkTo(target: string, linkPath: string): void {
  mkdirSync(dirname(linkPath), { recursive: true });
  try {
    const st = statSync(linkPath);
    if (st) rmSync(linkPath, { recursive: true, force: true });
  } catch {}
  const rel = relPathFromTo(dirname(linkPath), target);
  try {
    symlinkSync(rel, linkPath, "dir");
  } catch {
    copyDir(target, linkPath);
  }
}

function copyDir(src: string, dest: string): void {
  mkdirSync(dest, { recursive: true });
  for (const e of readdirSync(src, { withFileTypes: true })) {
    const s = join(src, e.name);
    const d = join(dest, e.name);
    if (e.isDirectory()) {
      copyDir(s, d);
    } else if (e.isFile()) {
      copyFileSync(s, d);
    }
  }
}

export function agentFolderFor(agent: string): string | null {
  for (const [folder, name] of Object.entries(AGENT_FOLDER_MAP)) {
    if (name === agent) return folder;
  }
  return null;
}

function updateSkillsLock(projectDir: string, skillName: string, entry: RegistryEntry): void {
  const lockPath = join(projectDir, "skills-lock.json");
  let lock: { version: number; skills: Record<string, unknown> };
  try {
    lock = JSON.parse(readFileSync(lockPath, "utf-8"));
    if (!lock || typeof lock !== "object" || !lock.skills) {
      lock = { version: 1, skills: {} };
    }
  } catch {
    lock = { version: 1, skills: {} };
  }
  lock.skills[skillName] = {
    source: entry.source,
    sourceType: "autoskills-registry",
    computedHash: entry.bundleHash,
  };
  const sortedSkills: Record<string, unknown> = {};
  for (const k of Object.keys(lock.skills).sort()) {
    sortedSkills[k] = lock.skills[k];
  }
  lock.skills = sortedSkills;
  writeFileSync(lockPath, JSON.stringify(lock, null, 2) + "\n");
}

export async function installSkill(
  skillPath: string,
  agents: string[] = [],
  opts: InstallOptions = {},
): Promise<InstallResult> {
  const projectDir = opts.projectDir || process.cwd();
  const command = `autoskills install ${skillPath}`;

  const fail = (msg: string): InstallResult => ({
    success: false,
    output: msg,
    stderr: msg,
    exitCode: 1,
    command,
  });

  const { skillName } = parseSkillPath(skillPath);
  if (!skillName) return fail(`invalid skill path: ${skillPath}`);
  opts.onTrace?.(`resolving ${skillPath}`);

  const registry = loadRegistry();
  if (!registry) {
    return fail(
      `skills-registry index not found. Run 'pnpm sync:skills' in the autoskills package.`,
    );
  }

  const entry = registry.skills[skillName];
  if (!entry) {
    return fail(`skill '${skillName}' not found in registry (unaudited).`);
  }
  const securityCheck = securityCheckForEntry(skillName, entry);
  opts.onTrace?.(`registry source: ${entry.source} @ ${entry.commitSha}`);

  const canonicalDir = join(projectDir, ".agents", "skills", skillName);
  try {
    const installedVerdict = verifyRegistryEntry(
      skillName,
      entry,
      join(projectDir, ".agents", "skills"),
    );
    if (installedVerdict.ok) {
      opts.onTrace?.(`already installed and verified: ${canonicalDir}`);
    } else {
      opts.onTrace?.(`installed copy needs refresh: ${installedVerdict.reason}`);
    }
    if (
      !installedVerdict.ok &&
      !copyRegistryEntryFromLocal(skillName, entry, canonicalDir, opts) &&
      !copyRegistryEntryFromCache(skillName, entry, canonicalDir, opts)
    ) {
      const cachedSkillDir = await downloadRegistryEntryToCache(skillName, entry, opts);
      rmSync(canonicalDir, { recursive: true, force: true });
      copyDir(cachedSkillDir, canonicalDir);
      opts.onTrace?.(`copied downloaded bundle into ${canonicalDir}`);
    }
  } catch (err) {
    return fail(`download failed: ${(err as Error).message}`);
  }

  const uniqueFolders = new Set<string>();
  for (const agent of agents) {
    if (agent === "universal") continue;
    const folder = agentFolderFor(agent);
    if (folder) uniqueFolders.add(folder);
  }

  const symlinkErrors: string[] = [];
  for (const folder of uniqueFolders) {
    const linkPath = join(projectDir, folder, "skills", skillName);
    try {
      ensureSymlinkTo(canonicalDir, linkPath);
      opts.onTrace?.(`linked ${linkPath} -> ${canonicalDir}`);
    } catch (err) {
      symlinkErrors.push(`${folder}: ${(err as Error).message}`);
    }
  }

  try {
    updateSkillsLock(projectDir, skillName, entry);
    opts.onTrace?.(`updated lockfile: ${join(projectDir, "skills-lock.json")}`);
  } catch (err) {
    return fail(`lockfile update failed: ${(err as Error).message}`);
  }

  if (symlinkErrors.length > 0) {
    return {
      success: false,
      output: symlinkErrors.join("\n"),
      stderr: symlinkErrors.join("\n"),
      exitCode: 1,
      command,
    };
  }

  return {
    success: true,
    output: `installed ${skillName} into ${relPathFromTo(projectDir, canonicalDir)}`,
    stderr: "",
    exitCode: 0,
    command,
    securityCheck,
  };
}

// ── Batch install (concurrent + spinner) ─────────────────────

function sortByRepo(skills: SkillEntry[]): SkillEntry[] {
  return [...skills].sort((a, b) => {
    const repoA = parseSkillPath(a.skill).repo;
    const repoB = parseSkillPath(b.skill).repo;
    return repoA.localeCompare(repoB);
  });
}

interface InstallAllResult {
  installed: number;
  failed: number;
  securityChecks: InstallSecurityCheck[];
  errors: {
    name: string;
    output: string;
    stderr: string;
    exitCode: number | null;
    command: string;
  }[];
}

export async function installAll(
  skills: SkillEntry[],
  agents: string[] = [],
  opts: InstallOptions = {},
): Promise<InstallAllResult> {
  if (opts.verbose) return installAllVerbose(skills, agents, opts);
  if (!process.stdout.isTTY) return installAllSimple(skills, agents, opts);

  const CONCURRENCY = 6;
  const sorted = sortByRepo(skills);
  const total = sorted.length;

  const states = sorted.map(({ skill }) => ({
    name: skill,
    skill,
    status: "pending" as "pending" | "installing" | "success" | "failed",
    output: "",
  }));

  let frame = 0;
  let rendered = false;
  let activeCount = 0;

  function render(): void {
    if (rendered) {
      write(`\x1b[${total}A\r`);
    }
    rendered = true;
    write("\x1b[J");

    for (const state of states) {
      switch (state.status) {
        case "pending":
          write(dim(`   ◌ ${state.name}`) + "\n");
          break;
        case "installing":
          write(cyan(`   ${SPINNER[frame]}`) + ` ${state.name}...\n`);
          break;
        case "success":
          write(green(`   ✔ ${state.name}`) + "\n");
          break;
        case "failed":
          write(red(`   ✘ ${state.name}`) + dim(" — failed") + "\n");
          break;
      }
    }
  }

  write(HIDE_CURSOR);

  const timer = setInterval(() => {
    frame = (frame + 1) % SPINNER.length;
    if (activeCount > 0) render();
  }, 80);

  let installed = 0;
  let failed = 0;
  const errors: InstallAllResult["errors"] = [];
  const securityChecks: InstallSecurityCheck[] = [];
  let nextIdx = 0;

  async function worker(): Promise<void> {
    while (nextIdx < total) {
      const idx = nextIdx++;
      const state = states[idx];
      state.status = "installing";
      activeCount++;
      render();

      const result = await installSkill(state.skill, agents, opts);

      activeCount--;
      if (result.success) {
        state.status = "success";
        installed++;
        if (result.securityCheck) securityChecks.push(result.securityCheck);
      } else {
        state.status = "failed";
        state.output = result.output;
        errors.push({
          name: state.name,
          output: result.output,
          stderr: result.stderr,
          exitCode: result.exitCode,
          command: result.command,
        });
        failed++;
      }
      render();
    }
  }

  const workers = Array.from({ length: Math.min(CONCURRENCY, total) }, () => worker());
  await Promise.all(workers);

  clearInterval(timer);
  render();
  write(SHOW_CURSOR);

  return { installed, failed, errors, securityChecks };
}

async function installAllVerbose(
  skills: SkillEntry[],
  agents: string[] = [],
  opts: InstallOptions = {},
): Promise<InstallAllResult> {
  const sorted = sortByRepo(skills);
  let installed = 0;
  let failed = 0;
  const errors: InstallAllResult["errors"] = [];
  const securityChecks: InstallSecurityCheck[] = [];

  for (const { skill } of sorted) {
    log(cyan(`   ◆ ${skill}`));
    const result = await installSkill(skill, agents, {
      ...opts,
      onTrace: (message) => log(dim(`     ${message}`)),
    });

    if (result.success) {
      log(green(`     ✔ installed`));
      installed++;
      if (result.securityCheck) securityChecks.push(result.securityCheck);
    } else {
      log(red(`     ✘ failed`) + dim(` — ${result.output}`));
      errors.push({
        name: skill,
        output: result.output,
        stderr: result.stderr,
        exitCode: result.exitCode,
        command: result.command,
      });
      failed++;
    }
    log();
  }

  return { installed, failed, errors, securityChecks };
}

async function installAllSimple(
  skills: SkillEntry[],
  agents: string[] = [],
  opts: InstallOptions = {},
): Promise<InstallAllResult> {
  const CONCURRENCY = 6;
  const sorted = sortByRepo(skills);
  let installed = 0;
  let failed = 0;
  const errors: InstallAllResult["errors"] = [];
  const securityChecks: InstallSecurityCheck[] = [];
  let nextIdx = 0;

  async function worker(): Promise<void> {
    while (nextIdx < sorted.length) {
      const idx = nextIdx++;
      const { skill } = sorted[idx];
      const result = await installSkill(skill, agents, opts);

      if (result.success) {
        log(green(`   ✔ ${skill}`));
        installed++;
        if (result.securityCheck) securityChecks.push(result.securityCheck);
      } else {
        log(red(`   ✘ ${skill}`) + dim(" — failed"));
        errors.push({
          name: skill,
          output: result.output,
          stderr: result.stderr,
          exitCode: result.exitCode,
          command: result.command,
        });
        failed++;
      }
    }
  }

  const workers = Array.from({ length: Math.min(CONCURRENCY, sorted.length) }, () => worker());
  await Promise.all(workers);

  return { installed, failed, errors, securityChecks };
}

// ── Remove ────────────────────────────────────────────────────

export interface RemoveResult {
  success: boolean;
  message: string;
  removed: {
    canonical: boolean;
    symlinks: string[];
    lockEntry: boolean;
  };
}

function readSkillsLock(projectDir: string): { version: number; skills: Record<string, unknown> } {
  const lockPath = join(projectDir, "skills-lock.json");
  try {
    return JSON.parse(readFileSync(lockPath, "utf-8"));
  } catch {
    return { version: 1, skills: {} };
  }
}

function writeSkillsLock(projectDir: string, lock: Record<string, unknown>): void {
  const lockPath = join(projectDir, "skills-lock.json");
  const sortedSkills: Record<string, unknown> = {};
  const skills = lock.skills as Record<string, unknown>;
  if (skills) {
    for (const k of Object.keys(skills).sort()) {
      sortedSkills[k] = skills[k];
    }
  }
  writeFileSync(lockPath, JSON.stringify({ ...lock, skills: sortedSkills }, null, 2) + "\n");
}

export function removeSkill(
  skillName: string,
  projectDir: string,
  _opts: { dryRun?: boolean } = {},
): RemoveResult {
  const canonicalDir = join(projectDir, ".agents", "skills", skillName);
  const removed: RemoveResult["removed"] = {
    canonical: false,
    symlinks: [],
    lockEntry: false,
  };

  if (existsSync(canonicalDir)) {
    if (_opts.dryRun) {
      // dry run: just report what would be removed
    } else {
      rmSync(canonicalDir, { recursive: true, force: true });
      removed.canonical = true;
    }
  }

  for (const folder of Object.keys(AGENT_FOLDER_MAP)) {
    const linkPath = join(projectDir, folder, "skills", skillName);
    try {
      const st = lstatSync(linkPath);
      if (st.isSymbolicLink() || st.isDirectory()) {
        removed.symlinks.push(linkPath);
        if (!_opts.dryRun) {
          rmSync(linkPath, { recursive: true, force: true });
        }
      }
    } catch {
      // path doesn't exist (including broken symlinks), nothing to remove
    }
  }

  const lock = readSkillsLock(projectDir);
  if (lock.skills && skillName in lock.skills) {
    removed.lockEntry = true;
    if (!_opts.dryRun) {
      delete lock.skills[skillName];
      writeSkillsLock(projectDir, lock);
    }
  }

  return {
    success: true,
    message: `Removed ${skillName}`,
    removed,
  };
}

// ── Deprecated shim ──────────────────────────────────────────

/** @deprecated retained so that UI code keeps compiling; no longer used. */
export function resolveSkillsBin(): string | null {
  return null;
}
