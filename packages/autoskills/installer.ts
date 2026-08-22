import {
  copyFileSync,
  existsSync,
  lstatSync,
  mkdirSync,
  readFileSync,
  readdirSync,
  rmSync,
  statSync,
  symlinkSync,
  writeFileSync,
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
    status: "approved" | "flagged" | "skipped";
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
let _cachedRegistryIssue: string | null = null;
let _cachedRegistryDir: string | null = null;
let _cachedPackageVersion: string | null | undefined;

function isRecord(value: unknown): value is Record<string, unknown> {
  return value !== null && typeof value === "object" && !Array.isArray(value);
}

function isStringArray(value: unknown): value is string[] {
  return Array.isArray(value) && value.every((item) => typeof item === "string");
}

function registryPathIssue(path: string): string | null {
  const normalized = normalizeRegistryRelPath(path);
  const segments = normalized.split("/");
  return normalized.startsWith("/") ||
    /^[a-z]:/i.test(normalized) ||
    normalized.includes("\0") ||
    segments.some((segment) => segment === "" || segment === "." || segment === "..")
    ? `unsafe path ${path}`
    : null;
}

function registryEntryIssue(entry: unknown): string | null {
  if (!isRecord(entry)) return "entry must be an object";
  for (const field of ["source", "skillPath", "commitSha", "bundleHash"] as const) {
    if (typeof entry[field] !== "string" || entry[field].length === 0) {
      return `${field} must be a nonempty string`;
    }
  }
  if (!/^[a-f0-9]{64}$/.test(entry.bundleHash as string)) {
    return "bundleHash must be a SHA-256 hash";
  }
  if (!isStringArray(entry.files) || entry.files.length === 0) {
    return "files must contain nonempty strings";
  }
  if (!isRecord(entry.sha256)) return "sha256 must be an object";
  if (Object.values(entry.sha256).some((hash) => typeof hash !== "string")) {
    return "sha256 values must be strings";
  }
  const normalizedFiles = new Set<string>();
  for (const rel of entry.files) {
    const normalizedRel = normalizeRegistryRelPath(rel);
    const pathIssue = registryPathIssue(rel);
    if (pathIssue) return `files contains ${pathIssue}`;
    if (normalizedFiles.has(normalizedRel)) {
      return `files contains duplicate path ${normalizedRel}`;
    }
    normalizedFiles.add(normalizedRel);
    const hash = entry.sha256[rel] ?? entry.sha256[normalizedRel];
    if (typeof hash !== "string" || !/^[a-f0-9]{64}$/.test(hash)) {
      return `sha256 must contain a SHA-256 hash for ${normalizedRel}`;
    }
  }

  const review = entry.review;
  if (!isRecord(review)) return "review must be an object";
  if (!isStringArray(review.flags)) return "review.flags must contain only strings";
  if (!["approved", "flagged", "skipped"].includes(String(review.status))) {
    return "review.status is invalid";
  }
  for (const field of ["summary", "model", "promptVersion", "reviewedAt"] as const) {
    if (typeof review[field] !== "string") return `review.${field} must be a string`;
  }

  const securityCheck = entry.securityCheck;
  if (review.status === "skipped" && securityCheck !== undefined) {
    return "securityCheck must be omitted when review.status is skipped";
  }
  if (securityCheck === undefined) return null;
  if (!isRecord(securityCheck)) return "securityCheck must be an object";
  if (!isStringArray(securityCheck.findings)) {
    return "securityCheck.findings must contain only strings";
  }
  if (!["ok", "warning"].includes(String(securityCheck.status))) {
    return "securityCheck.status is invalid";
  }
  for (const field of ["summary", "checkedAt"] as const) {
    if (typeof securityCheck[field] !== "string") {
      return `securityCheck.${field} must be a string`;
    }
  }
  return null;
}

function registryIssue(registry: unknown): string | null {
  if (!isRecord(registry)) return "registry must be an object";
  if (!Number.isInteger(registry.version) || Number(registry.version) < 1) {
    return "version must be a positive integer";
  }
  if (typeof registry.generatedAt !== "string" || registry.generatedAt.length === 0) {
    return "generatedAt must be a nonempty string";
  }
  if (!isRecord(registry.reviewer)) return "reviewer must be an object";
  for (const field of ["model", "promptVersion"] as const) {
    if (typeof registry.reviewer[field] !== "string" || registry.reviewer[field].length === 0) {
      return `reviewer.${field} must be a nonempty string`;
    }
  }
  if (!isRecord(registry.skills)) return "skills must be an object";
  const normalizedSkillNames = new Set<string>();
  for (const skillName of Object.keys(registry.skills)) {
    const pathIssue = registryPathIssue(skillName);
    if (pathIssue) return `skills contains ${pathIssue}`;
    const normalizedSkillName = normalizeRegistryRelPath(skillName);
    if (normalizedSkillNames.has(normalizedSkillName)) {
      return `skills contains duplicate path ${normalizedSkillName}`;
    }
    normalizedSkillNames.add(normalizedSkillName);
    const entryIssue = registryEntryIssue(registry.skills[skillName]);
    if (entryIssue) return `skills.${skillName} is invalid: ${entryIssue}`;
  }
  return null;
}

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
    const parsed: unknown = JSON.parse(readFileSync(manifestPath, "utf-8"));
    const issue = registryIssue(parsed);
    if (issue) {
      _cachedRegistryIssue = issue;
      _cachedRegistry = null;
      return null;
    }
    _cachedRegistryIssue = null;
    const body = parsed as unknown as Registry;
    _cachedRegistry = body;
    return body;
  } catch {
    _cachedRegistryIssue = null;
    _cachedRegistry = null;
    return null;
  }
}

/** @internal — exported for testing only */
export function _setRegistryDir(dir: string | null): void {
  _cachedRegistryDir = dir;
  _cachedRegistry = undefined;
  _cachedRegistryIssue = null;
}

// ── Integrity ────────────────────────────────────────────────

function sha256File(path: string): string {
  return createHash("sha256").update(readFileSync(path)).digest("hex");
}

function listSkillFiles(dir: string, prefix = ""): string[] {
  return readdirSync(dir, { withFileTypes: true }).flatMap((entry) => {
    const rel = prefix ? `${prefix}/${entry.name}` : entry.name;
    return entry.isDirectory() ? listSkillFiles(join(dir, entry.name), rel) : [rel];
  });
}

export function verifyRegistryEntry(
  skillName: string,
  entry: RegistryEntry,
  registryDir: string = getRegistryDir(),
): { ok: boolean; reason?: string } {
  const manifestIssue = registryEntryIssue(entry);
  if (manifestIssue) return { ok: false, reason: `invalid manifest: ${manifestIssue}` };

  const skillDir = join(registryDir, skillName);
  if (!existsSync(skillDir)) {
    return { ok: false, reason: `missing directory ${skillDir}` };
  }
  const declaredFiles = new Set(entry.files.map(normalizeRegistryRelPath));
  const unexpectedFile = listSkillFiles(skillDir).find((rel) => !declaredFiles.has(rel));
  if (unexpectedFile) {
    return { ok: false, reason: `unexpected file ${unexpectedFile}` };
  }
  for (const rel of entry.files) {
    const normalizedRel = normalizeRegistryRelPath(rel);
    const abs = join(skillDir, ...normalizedRel.split("/"));
    if (!existsSync(abs)) {
      return { ok: false, reason: `missing file ${normalizedRel}` };
    }
    if (!lstatSync(abs).isFile()) {
      return { ok: false, reason: `invalid file ${normalizedRel}` };
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
  reviewSkipped?: boolean;
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

function securityCheckForEntry(
  skillName: string,
  entry: RegistryEntry,
): InstallSecurityCheck | null {
  if (entry.review.status === "skipped") return null;

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
  if (registryEntryIssue(entry)) return null;

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
  copyRegistryFiles(join(registryDir, skillName), destDir, entry.files);
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
  copyRegistryFiles(join(registryDir, skillName), destDir, entry.files);
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

function copyRegistryFiles(srcDir: string, destDir: string, files: string[]): void {
  for (const rel of files) {
    const normalizedRel = normalizeRegistryRelPath(rel);
    const src = join(srcDir, ...normalizedRel.split("/"));
    const dest = join(destDir, ...normalizedRel.split("/"));
    mkdirSync(dirname(dest), { recursive: true });
    copyFileSync(src, dest);
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
    const targetPrefix = `skills.${skillName} is invalid: `;
    if (_cachedRegistryIssue?.startsWith(targetPrefix)) {
      return fail(
        `skill '${skillName}' has invalid registry metadata: ${_cachedRegistryIssue.slice(targetPrefix.length)}.`,
      );
    }
    const detail = _cachedRegistryIssue ? ` Invalid registry: ${_cachedRegistryIssue}.` : "";
    return fail(
      `skills-registry index not found. Run 'pnpm sync:skills' in the autoskills package.${detail}`,
    );
  }

  const entry = registry.skills[skillName];
  if (!entry) {
    return fail(`skill '${skillName}' not found in registry (unaudited).`);
  }
  const manifestIssue = registryEntryIssue(entry);
  if (manifestIssue) {
    return fail(`skill '${skillName}' has invalid registry metadata: ${manifestIssue}.`);
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
      copyRegistryFiles(cachedSkillDir, canonicalDir, entry.files);
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
    ...(securityCheck ? { securityCheck } : {}),
    ...(entry.review.status === "skipped" ? { reviewSkipped: true } : {}),
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
  skippedReviews: string[];
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
  const skippedReviews: string[] = [];
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
        if (result.reviewSkipped) skippedReviews.push(parseSkillPath(state.skill).skillName);
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

  return { installed, failed, errors, securityChecks, skippedReviews };
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
  const skippedReviews: string[] = [];

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
      if (result.reviewSkipped) skippedReviews.push(parseSkillPath(skill).skillName);
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

  return { installed, failed, errors, securityChecks, skippedReviews };
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
  const skippedReviews: string[] = [];
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
        if (result.reviewSkipped) skippedReviews.push(parseSkillPath(skill).skillName);
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

  return { installed, failed, errors, securityChecks, skippedReviews };
}

// ── Deprecated shim ──────────────────────────────────────────

/** @deprecated retained so that UI code keeps compiling; no longer used. */
export function resolveSkillsBin(): string | null {
  return null;
}
