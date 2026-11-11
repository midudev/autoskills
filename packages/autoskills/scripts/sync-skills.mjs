#!/usr/bin/env node
// Sync script: downloads skills from upstream GitHub repos, reviews each one
// with Claude for supply-chain / prompt-injection safety, and stores the
// approved files inside `packages/autoskills/skills-registry/`.
//
// Meant to be run by maintainers only — never by end users.

import { spawnSync } from "node:child_process";
import {
  createWriteStream,
  existsSync,
  mkdirSync,
  mkdtempSync,
  readFileSync,
  readdirSync,
  rmSync,
  statSync,
  writeFileSync,
} from "node:fs";
import { createHash } from "node:crypto";
import { tmpdir } from "node:os";
import { dirname, join, relative, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { pipeline } from "node:stream/promises";

import Anthropic from "@anthropic-ai/sdk";

import { SKILLS_MAP, COMBO_SKILLS_MAP, FRONTEND_BONUS_SKILLS } from "../skills-map.ts";
import { parseSkillPath } from "../lib.ts";
import { bold, cyan, dim, green, log, red, yellow } from "../colors.ts";
import { REVIEW_PROMPT_VERSION, isTextFile, reviewModels, reviewSkill } from "./skill-review.mjs";

process.loadEnvFile();

// ── Config ───────────────────────────────────────────────────

const __dirname = dirname(fileURLToPath(import.meta.url));
const PKG_ROOT = resolve(__dirname, "..");
const REGISTRY_DIR = join(PKG_ROOT, "skills-registry");
const MANIFEST_PATH = join(REGISTRY_DIR, "index.json");
const REPORT_PATH = join(__dirname, "sync-skills.report.json");

const REVIEW_CONCURRENCY = Number(process.env.AUTOSKILLS_REVIEW_CONCURRENCY) || 8;
const GITHUB_TOKEN = process.env.GITHUB_TOKEN || process.env.GH_TOKEN || "";

const SKIP_NAMES = new Set();

// ── CLI args ─────────────────────────────────────────────────

const args = process.argv.slice(2);
const FLAGS = {
  dryRun: args.includes("--dry-run"),
  noReview: args.includes("--no-review"),
  retryFailed: args.includes("--retry-failed"),
  rereview: args.includes("--rereview"),
  only: (() => {
    const i = args.indexOf("--only");
    if (i === -1 || !args[i + 1]) return null;
    return new Set(
      args[i + 1]
        .split(",")
        .map((name) => name.trim())
        .filter(Boolean),
    );
  })(),
  verbose: args.includes("-v") || args.includes("--verbose"),
};

if (FLAGS.only && FLAGS.retryFailed) {
  log(red("✘ --only and --retry-failed cannot be used together"));
  process.exit(1);
}

if (args.includes("-h") || args.includes("--help")) {
  log(`
  ${bold("sync-skills")} — Download, audit, and persist skills locally

  ${bold("Usage:")}
    node scripts/sync-skills.mjs [flags]

  ${bold("Flags:")}
    --dry-run       Fetch and review, don't write files
    --no-review     Skip the Claude review (dev only)
    --only <names>  Sync only these skills (comma-separated names)
    --retry-failed  Sync only skills from the last report that failed or were blocked
    --rereview      Review the files already in the registry again, without fetching
                    upstream (e.g. after a review prompt change; combine with --only)
    -v, --verbose   Show per-file details
    -h, --help      Show this help
`);
  process.exit(0);
}

// ── Skill collection ─────────────────────────────────────────

function collectAllSkillPaths() {
  const out = new Set();
  for (const tech of SKILLS_MAP) for (const s of tech.skills) out.add(s);
  for (const c of COMBO_SKILLS_MAP) for (const s of c.skills) out.add(s);
  for (const s of FRONTEND_BONUS_SKILLS) out.add(s);
  return [...out];
}

function getSkillName(skillPath) {
  try {
    const { skillName } = parseSkillPath(skillPath);
    if (skillName) return skillName;
  } catch {
    // Reports may be edited manually; fall back to the final path segment.
  }
  return skillPath.split("/").filter(Boolean).at(-1) || skillPath;
}

function collectRetryFailedSkillNames() {
  if (!existsSync(REPORT_PATH)) {
    throw new Error(`retry report not found: ${REPORT_PATH}`);
  }

  const report = JSON.parse(readFileSync(REPORT_PATH, "utf-8"));
  const retry = new Set();
  const add = (entry) => {
    const skill = typeof entry === "string" ? entry : entry?.skill;
    if (skill) retry.add(getSkillName(skill));
  };

  for (const entry of report.flagged || []) {
    if (entry?.accepted) continue;
    add(entry);
  }
  for (const entry of report.rejected || []) add(entry);
  for (const entry of report.missing || []) add(entry);
  for (const entry of report.errors || []) add(entry);

  return retry;
}

function groupSkillsByRepo(skills, retryFailed = null) {
  const byRepo = new Map();
  for (const full of skills) {
    const { repo, skillName } = parseSkillPath(full);
    if (!skillName || SKIP_NAMES.has(skillName)) continue;
    if (FLAGS.only && !FLAGS.only.has(skillName)) continue;
    if (retryFailed && !retryFailed.has(skillName)) continue;
    if (!byRepo.has(repo)) byRepo.set(repo, []);
    byRepo.get(repo).push({ full, skillName });
  }
  return byRepo;
}

// ── GitHub helpers ───────────────────────────────────────────

async function ghFetch(url) {
  const headers = {
    "User-Agent": "autoskills-sync",
    Accept: "application/vnd.github+json",
    "X-GitHub-Api-Version": "2022-11-28",
  };
  if (GITHUB_TOKEN) headers.Authorization = `Bearer ${GITHUB_TOKEN}`;
  const res = await fetch(url, { headers });
  if (!res.ok) {
    const resetAt = Number(res.headers.get("x-ratelimit-reset") || 0) * 1000;
    const resetSuffix = resetAt ? ` (resets ${new Date(resetAt).toISOString()})` : "";
    if (res.status === 403 && res.headers.get("x-ratelimit-remaining") === "0") {
      throw new Error(
        `GitHub 403 rate limit exceeded${resetSuffix} for ${url}. Set GITHUB_TOKEN or GH_TOKEN to increase the limit.`,
      );
    }
    throw new Error(`GitHub ${res.status} ${res.statusText} for ${url}`);
  }
  return res;
}

function resolveRepoHead(repo) {
  const result = spawnSync(
    "git",
    ["ls-remote", "--symref", `https://github.com/${repo}.git`, "HEAD"],
    {
      encoding: "utf-8",
      stdio: ["ignore", "pipe", "pipe"],
    },
  );
  if (result.status !== 0) {
    throw new Error(`git ls-remote failed for ${repo}: ${result.stderr.trim() || "unknown error"}`);
  }

  let defaultBranch = "main";
  let sha = "";
  for (const line of result.stdout.split("\n")) {
    const symref = line.match(/^ref:\s+refs\/heads\/(.+)\s+HEAD$/);
    if (symref) {
      defaultBranch = symref[1];
      continue;
    }
    const head = line.match(/^([0-9a-f]{40})\s+HEAD$/i);
    if (head) sha = head[1];
  }

  if (!sha) {
    throw new Error(`could not resolve HEAD for ${repo}`);
  }

  return { defaultBranch, sha };
}

async function resolveRepoInfo(repo) {
  const res = await ghFetch(`https://api.github.com/repos/${repo}`);
  const body = await res.json();
  return {
    sizeKB: body.size || 0,
  };
}

// Tarball download size threshold (KB). Above this we use per-file fetch.
const HEAVY_REPO_KB = 50_000;
// Hard timeout for tarball downloads. Some repos have slow codeload CDNs.
const TARBALL_TIMEOUT_MS = 180_000;

async function downloadTarball(repo, sha, destFile) {
  const url = `https://codeload.github.com/${repo}/tar.gz/${sha}`;
  const headers = { "User-Agent": "autoskills-sync" };
  if (GITHUB_TOKEN) headers.Authorization = `Bearer ${GITHUB_TOKEN}`;
  const ac = new AbortController();
  const timer = setTimeout(() => ac.abort(), TARBALL_TIMEOUT_MS);
  try {
    const res = await fetch(url, { headers, signal: ac.signal });
    if (!res.ok || !res.body) {
      throw new Error(`Tarball fetch failed: ${res.status} ${url}`);
    }
    await pipeline(res.body, createWriteStream(destFile));
  } finally {
    clearTimeout(timer);
  }
}

async function fetchRepoTree(repo, sha) {
  const res = await ghFetch(`https://api.github.com/repos/${repo}/git/trees/${sha}?recursive=1`);
  const body = await res.json();
  if (body.truncated) {
    throw new Error(`git tree truncated for ${repo}@${sha.slice(0, 7)}`);
  }
  return body.tree || [];
}

function findSkillDirsInTree(tree, skillName) {
  // Returns array of { dir } where dir/SKILL.md exists in the tree.
  const skillPaths = tree
    .filter((t) => t.type === "blob" && /(^|\/)SKILL\.md$/i.test(t.path))
    .map((t) => t.path);

  const candidates = [];
  for (const p of skillPaths) {
    const parts = p.split("/");
    parts.pop();
    const parent = parts[parts.length - 1];
    if (parent === skillName) {
      candidates.push(parts.join("/"));
      continue;
    }
    // Fallback: <skillName>/skills/SKILL.md
    if (parent === "skills" && parts[parts.length - 2] === skillName) {
      candidates.push(parts.join("/"));
    }
  }

  // Fallback for single-SKILL-at-root repos.
  if (candidates.length === 0 && skillPaths.includes("SKILL.md")) {
    candidates.push("");
  }

  candidates.sort((a, b) => a.length - b.length);
  return candidates;
}

async function downloadRawFile(repo, sha, repoPath, destFile) {
  const url = `https://raw.githubusercontent.com/${repo}/${sha}/${repoPath}`;
  const headers = { "User-Agent": "autoskills-sync" };
  if (GITHUB_TOKEN) headers.Authorization = `Bearer ${GITHUB_TOKEN}`;
  const ac = new AbortController();
  const timer = setTimeout(() => ac.abort(), TARBALL_TIMEOUT_MS);
  try {
    const res = await fetch(url, {
      headers,
      signal: ac.signal,
    });
    if (!res.ok || !res.body) {
      throw new Error(`raw fetch failed: ${res.status} ${url}`);
    }
    mkdirSync(dirname(destFile), { recursive: true });
    await pipeline(res.body, createWriteStream(destFile));
  } finally {
    clearTimeout(timer);
  }
}

async function materializeSkillsFromTree(repo, sha, skillNames, destRoot) {
  const tree = await fetchRepoTree(repo, sha);
  const found = new Map(); // skillName → relative dir within destRoot
  for (const skillName of skillNames) {
    const dirs = findSkillDirsInTree(tree, skillName);
    if (dirs.length === 0) continue;
    const pick = dirs[0];
    const blobs = tree.filter(
      (t) =>
        t.type === "blob" &&
        (pick === "" ? true : t.path.startsWith(`${pick}/`) || t.path === pick),
    );
    // When pick === "" (repo root), only grab the single SKILL.md to avoid
    // pulling in unrelated repo content.
    const filtered = pick === "" ? blobs.filter((t) => t.path === "SKILL.md") : blobs;
    for (const blob of filtered) {
      const rel = pick === "" ? blob.path : blob.path.slice(pick.length + 1);
      if (shouldSkipSkillFile(rel)) continue;
      const dest = join(destRoot, skillName, rel);
      await downloadRawFile(repo, sha, blob.path, dest);
    }
    found.set(skillName, join(destRoot, skillName));
  }
  return found;
}

function extractTarball(tarFile, destDir) {
  const r = spawnSync("tar", ["-xzf", tarFile, "-C", destDir], {
    stdio: FLAGS.verbose ? "inherit" : "pipe",
  });
  if (r.status !== 0) {
    throw new Error(`tar extract failed (status ${r.status})`);
  }
  const entries = readdirSync(destDir);
  const root = entries.find((e) => statSync(join(destDir, e)).isDirectory());
  if (!root) throw new Error(`Empty tarball in ${destDir}`);
  return join(destDir, root);
}

function runGit(args, label) {
  const result = spawnSync("git", args, {
    encoding: "utf-8",
    stdio: ["ignore", "pipe", "pipe"],
  });
  if (result.status !== 0) {
    throw new Error(`${label} failed: ${result.stderr.trim() || "unknown error"}`);
  }
  return result.stdout;
}

function materializeSkillsFromSparseClone(repo, branch, skillNames, destRoot) {
  const repoDir = join(destRoot, "repo");
  runGit(
    [
      "clone",
      "--depth",
      "1",
      "--filter=blob:none",
      "--sparse",
      "--branch",
      branch,
      `https://github.com/${repo}.git`,
      repoDir,
    ],
    `git clone ${repo}`,
  );

  const paths = runGit(
    ["-C", repoDir, "ls-tree", "-r", "--name-only", "HEAD"],
    `git ls-tree ${repo}`,
  )
    .split("\n")
    .filter(Boolean);
  const tree = paths.map((path) => ({ type: "blob", path }));
  const found = new Map();
  const sparsePatterns = new Set();

  for (const skillName of skillNames) {
    const dirs = findSkillDirsInTree(tree, skillName);
    if (dirs.length === 0) continue;
    const pick = dirs[0];
    sparsePatterns.add(pick === "" ? "SKILL.md" : `${pick}/**`);
    found.set(skillName, pick === "" ? repoDir : join(repoDir, pick));
  }

  if (sparsePatterns.size > 0) {
    runGit(
      ["-C", repoDir, "sparse-checkout", "set", "--no-cone", ...sparsePatterns],
      `git sparse-checkout ${repo}`,
    );
  }

  return found;
}

// ── Filesystem walk ──────────────────────────────────────────

const SKIP_DIRS = new Set([
  ".git",
  ".github",
  ".vscode",
  ".idea",
  "node_modules",
  "dist",
  "build",
  "out",
  "coverage",
  "__pycache__",
  ".turbo",
  ".cache",
  ".next",
  ".nuxt",
  ".output",
  ".svelte-kit",
  "tests",
  "test",
  "__tests__",
  "fixtures",
  "examples",
  "example",
]);

function shouldSkipSkillFile(rel) {
  return rel.toLowerCase().endsWith(".zip");
}

function findSkillDir(repoRoot, skillName) {
  const candidates = [];
  (function walk(dir, depth) {
    if (depth > 8) return;
    let entries;
    try {
      entries = readdirSync(dir, { withFileTypes: true });
    } catch {
      return;
    }
    for (const e of entries) {
      if (!e.isDirectory()) continue;
      if (SKIP_DIRS.has(e.name)) continue;
      const p = join(dir, e.name);
      if (e.name === skillName) {
        if (existsSync(join(p, "SKILL.md"))) candidates.push(p);
        else if (existsSync(join(p, "skills", "SKILL.md"))) candidates.push(join(p, "skills"));
      }
      walk(p, depth + 1);
    }
  })(repoRoot, 0);

  if (candidates.length === 0) {
    if (existsSync(join(repoRoot, "SKILL.md"))) {
      return repoRoot;
    }
    return null;
  }
  candidates.sort((a, b) => a.length - b.length);
  return candidates[0];
}

function listFilesRecursive(dir) {
  const out = [];
  (function walk(current) {
    for (const e of readdirSync(current, { withFileTypes: true })) {
      const p = join(current, e.name);
      if (e.isDirectory()) {
        walk(p);
      } else if (e.isFile() && !shouldSkipSkillFile(relative(dir, p).split("\\").join("/"))) {
        out.push(p);
      }
    }
  })(dir);
  return out.sort();
}

function sha256Hex(buf) {
  return createHash("sha256").update(buf).digest("hex");
}

// ── Review queue ─────────────────────────────────────────────

function createLimiter(max) {
  let active = 0;
  const queue = [];
  const next = () => {
    if (active >= max || queue.length === 0) return;
    active++;
    const { task, resolve, reject } = queue.shift();
    task()
      .then(resolve, reject)
      .finally(() => {
        active--;
        next();
      });
  };
  return (task) =>
    new Promise((resolve, reject) => {
      queue.push({ task, resolve, reject });
      next();
    });
}

// ── Manifest ─────────────────────────────────────────────────

function reviewerInfo() {
  const { triage, adjudicator } = reviewModels();
  return { model: triage, adjudicator, promptVersion: REVIEW_PROMPT_VERSION };
}

function loadManifest() {
  if (!existsSync(MANIFEST_PATH)) {
    return {
      version: 1,
      generatedAt: new Date().toISOString(),
      reviewer: reviewerInfo(),
      skills: {},
    };
  }
  try {
    return JSON.parse(readFileSync(MANIFEST_PATH, "utf-8"));
  } catch {
    return { version: 1, generatedAt: "", reviewer: {}, skills: {} };
  }
}

function saveManifest(manifest) {
  if (!existsSync(REGISTRY_DIR)) mkdirSync(REGISTRY_DIR, { recursive: true });
  writeFileSync(MANIFEST_PATH, JSON.stringify(manifest, null, 2) + "\n");
}

function writeSkillToRegistry(manifest, skill) {
  const destDir = join(REGISTRY_DIR, skill.skillName);
  rmSync(destDir, { recursive: true, force: true });
  for (const f of skill.relFiles) {
    const out = join(destDir, f.rel);
    mkdirSync(dirname(out), { recursive: true });
    writeFileSync(out, f.buf);
  }

  manifest.skills[skill.skillName] = {
    source: skill.repo,
    skillPath: skill.full,
    commitSha: skill.sha,
    files: skill.relFiles.map((f) => f.rel),
    sha256: skill.shaMap,
    bundleHash: skill.bundleHash,
    review: {
      status: skill.review.warnings.length > 0 ? "flagged" : "approved",
      flags: skill.review.warnings,
      summary: skill.review.summary,
      model: skill.review.model,
      promptVersion: REVIEW_PROMPT_VERSION,
      reviewedAt: new Date().toISOString(),
    },
    securityCheck: {
      status: skill.review.securityStatus,
      findings: skill.review.warnings,
      summary: skill.review.summary || "The sync review did not find security issues.",
      checkedAt: new Date().toISOString(),
    },
  };
}

// Scripts are reviewed too: an attack can live in any file the agent may run.
function filesForReview(relFiles) {
  return relFiles
    .filter((f) => isTextFile(f.buf))
    .map((f) => ({ rel: f.rel, content: f.buf.toString("utf-8") }));
}

// Loads a skill as stored in the registry, checking every file against its hash
// so a re-review never runs on files that differ from what users install.
function readRegistrySkill(skillName, entry) {
  const relFiles = entry.files.map((rel) => {
    const buf = readFileSync(join(REGISTRY_DIR, skillName, rel));
    if (sha256Hex(buf) !== entry.sha256[rel]) throw new Error(`hash mismatch for ${rel}`);
    return { rel, buf };
  });
  return {
    repo: entry.source,
    full: entry.skillPath,
    skillName,
    sha: entry.commitSha,
    relFiles,
    shaMap: entry.sha256,
    bundleHash: entry.bundleHash,
  };
}

async function reviewAndStore(skill, files, manifest, report) {
  let review;
  try {
    review = await reviewSkill(skill.full, files, { skip: FLAGS.noReview });
  } catch (err) {
    // A bad key fails every skill the same way: stop instead of logging N errors.
    if (
      err instanceof Anthropic.AuthenticationError ||
      err instanceof Anthropic.PermissionDeniedError
    ) {
      throw err;
    }
    log(red(`   ✘ ${skill.full}`) + dim(` — review error: ${err.message}`));
    report.errors.push({ skill: skill.full, reason: err.message });
    return;
  }

  if (review.decision === "block") {
    log(red(`   ✘ ${skill.full}`) + dim(` — blocked: ${review.summary}`));
    report.totals.rejected++;
    report.rejected.push({ skill: skill.full, summary: review.summary, model: review.model });
    return;
  }

  if (!FLAGS.dryRun) writeSkillToRegistry(manifest, { ...skill, review });
  const written = FLAGS.dryRun ? "would write" : `${skill.relFiles.length} file(s)`;
  if (review.securityStatus === "warning") {
    report.totals.warned++;
    report.warned.push({ skill: skill.full, warnings: review.warnings, summary: review.summary });
    log(
      yellow(`   ⚠ ${skill.full}`) +
        dim(` — allowed with warnings, ${written}: ${review.warnings.join("; ")}`),
    );
  } else if (review.securityStatus === "info") {
    report.totals.noted++;
    report.noted.push({ skill: skill.full, notes: review.warnings, summary: review.summary });
    log(
      cyan(`   ℹ ${skill.full}`) +
        dim(` — allowed with notes, ${written}: ${review.warnings.join("; ")}`),
    );
  } else {
    report.totals.approved++;
    log(
      green(`   ✔ ${skill.full}`) +
        dim(` — approved${review.escalated ? " after escalation" : ""}, ${written}`),
    );
  }
}

function getManifestRepoSha(manifest, repo, skills) {
  const shas = new Set();
  for (const s of skills) {
    const prev = manifest.skills[s.skillName];
    if (!prev || prev.source !== repo || prev.skillPath !== s.full || !prev.commitSha) {
      return null;
    }
    shas.add(prev.commitSha);
  }
  return shas.size === 1 ? [...shas][0] : null;
}

// ── Main ─────────────────────────────────────────────────────

async function main() {
  log(cyan("◆ ") + bold("autoskills sync"));
  log(
    dim(
      `   review: ${reviewModels().triage} → ${reviewModels().adjudicator} (${REVIEW_CONCURRENCY} in parallel)  registry: ${relative(process.cwd(), REGISTRY_DIR)}`,
    ),
  );
  if (FLAGS.dryRun) log(dim("   --dry-run: no files will be written"));
  if (FLAGS.noReview) log(yellow("   --no-review: skipping Claude audit"));
  if (FLAGS.rereview) log(dim("   --rereview: reviewing registry files, upstream is not fetched"));
  log();

  const allSkills = collectAllSkillPaths();
  const retryFailed = FLAGS.retryFailed ? collectRetryFailedSkillNames() : null;
  if (retryFailed) {
    if (retryFailed.size === 0) {
      log(green("No failed or blocked skills found in the last report."));
      process.exit(0);
    }
    log(
      dim(
        `   --retry-failed: retrying ${retryFailed.size} skill${retryFailed.size === 1 ? "" : "s"}`,
      ),
    );
    log();
  }

  const byRepo = groupSkillsByRepo(allSkills, retryFailed);
  if (FLAGS.retryFailed && byRepo.size === 0) {
    log(green("No retryable skills from the last report are present in the current skills map."));
    process.exit(0);
  }

  const manifest = loadManifest();
  manifest.reviewer = reviewerInfo();

  const report = {
    generatedAt: new Date().toISOString(),
    totals: {
      repos: byRepo.size,
      skills: 0,
      approved: 0,
      noted: 0,
      warned: 0,
      rejected: 0,
      unchanged: 0,
      missing: 0,
    },
    rejected: [],
    noted: [],
    warned: [],
    missing: [],
    errors: [],
  };
  // Reviews run in the background while the next repos are downloaded.
  const reviewLimit = createLimiter(REVIEW_CONCURRENCY);
  const reviews = [];
  let fatalError = null;
  const queueReview = (skill) => {
    reviews.push(
      reviewLimit(() =>
        reviewAndStore(skill, filesForReview(skill.relFiles), manifest, report),
      ).catch((err) => {
        fatalError ??= err;
      }),
    );
  };

  for (const [repo, skills] of byRepo) {
    if (fatalError) break;
    log(bold(repo) + dim(` (${skills.length} skill${skills.length === 1 ? "" : "s"})`));

    if (FLAGS.rereview) {
      for (const { full, skillName } of skills) {
        report.totals.skills++;
        const entry = manifest.skills[skillName];
        if (!entry) {
          log(red(`   ✘ ${skillName}`) + dim(" — not in the registry yet"));
          report.totals.missing++;
          report.missing.push(full);
          continue;
        }
        try {
          queueReview(readRegistrySkill(skillName, entry));
        } catch (err) {
          log(red(`   ✘ ${skillName}`) + dim(` — ${err.message}`));
          report.errors.push({ skill: full, reason: err.message });
        }
      }
      continue;
    }

    let sha;
    let repoRoot;
    let directSkillDirs = null; // skillName → absolute dir (used in per-file mode)
    const tmpDir = mkdtempSync(join(tmpdir(), "autoskills-sync-"));

    try {
      const head = resolveRepoHead(repo);
      sha = head.sha;

      const manifestSha = getManifestRepoSha(manifest, repo, skills);
      if (manifestSha === sha) {
        for (const { skillName } of skills) {
          log(dim(`   · ${skillName} — unchanged`));
          report.totals.skills++;
          report.totals.unchanged++;
        }
        rmSync(tmpDir, { recursive: true, force: true });
        continue;
      }

      if (!GITHUB_TOKEN) {
        log(dim("   ↳ repo changed — using sparse git checkout"));
        directSkillDirs = materializeSkillsFromSparseClone(
          repo,
          head.defaultBranch,
          skills.map((s) => s.skillName),
          tmpDir,
        );
      } else {
        const info = await resolveRepoInfo(repo);

        if (info.sizeKB > HEAVY_REPO_KB) {
          log(dim(`   ↳ repo is ${(info.sizeKB / 1024).toFixed(0)} MB — using per-file fetch`));
          const destRoot = join(tmpDir, "skills");
          mkdirSync(destRoot, { recursive: true });
          directSkillDirs = await materializeSkillsFromTree(
            repo,
            sha,
            skills.map((s) => s.skillName),
            destRoot,
          );
        } else {
          const tarFile = join(tmpDir, "repo.tar.gz");
          await downloadTarball(repo, sha, tarFile);
          repoRoot = extractTarball(tarFile, tmpDir);
        }
      }
    } catch (err) {
      log(red(`   ✘ repo fetch failed: ${err.message}`));
      for (const s of skills) {
        report.errors.push({ skill: s.full, reason: err.message });
      }
      rmSync(tmpDir, { recursive: true, force: true });
      continue;
    }

    for (const { full, skillName } of skills) {
      report.totals.skills++;
      const skillDir = directSkillDirs
        ? directSkillDirs.get(skillName) || null
        : findSkillDir(repoRoot, skillName);
      if (!skillDir) {
        log(red(`   ✘ ${skillName}`) + dim(` — SKILL.md not found in ${repo}`));
        report.totals.missing++;
        report.missing.push(full);
        continue;
      }

      const files = listFilesRecursive(skillDir);
      const relFiles = files.map((f) => ({
        rel: relative(skillDir, f).split("\\").join("/"),
        abs: f,
        buf: readFileSync(f),
      }));

      const shaMap = {};
      for (const f of relFiles) shaMap[f.rel] = sha256Hex(f.buf);
      const bundleHash = sha256Hex(
        relFiles
          .map((f) => `${f.rel}:${shaMap[f.rel]}`)
          .sort()
          .join("\n"),
      );

      const prev = manifest.skills[skillName];
      if (prev && prev.bundleHash === bundleHash) {
        log(dim(`   · ${skillName} — unchanged`));
        report.totals.unchanged++;
        continue;
      }

      queueReview({ repo, full, skillName, sha, relFiles, shaMap, bundleHash });
    }

    rmSync(tmpDir, { recursive: true, force: true });
  }

  if (reviews.length > 0) {
    log();
    log(dim(`   waiting for ${reviews.length} review(s)…`));
  }
  await Promise.all(reviews);
  if (fatalError) throw fatalError;

  if (!FLAGS.dryRun) {
    manifest.generatedAt = new Date().toISOString();
    saveManifest(manifest);
  }

  writeFileSync(REPORT_PATH, JSON.stringify(report, null, 2) + "\n");

  log();
  log(bold("Summary"));
  log(
    `   ${green(`${report.totals.approved} approved`)}` +
      `  ${cyan(`${report.totals.noted} with notes`)}` +
      `  ${yellow(`${report.totals.warned} with warnings`)}` +
      `  ${red(`${report.totals.rejected} blocked`)}` +
      `  ${dim(`${report.totals.unchanged} unchanged`)}` +
      `  ${dim(`${report.totals.missing} missing`)}` +
      `  ${dim(`${report.errors.length} errors`)}`,
  );
  log(dim(`   report: ${relative(process.cwd(), REPORT_PATH)}`));
  log();

  const exitBad =
    report.totals.rejected > 0 || report.totals.missing > 0 || report.errors.length > 0;
  process.exit(exitBad ? 1 : 0);
}

main().catch((err) => {
  log(red(`\n✘ Fatal: ${err.message}\n`));
  if (FLAGS.verbose) console.error(err);
  process.exit(1);
});
