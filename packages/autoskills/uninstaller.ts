import {
  existsSync,
  lstatSync,
  readFileSync,
  readdirSync,
  rmSync,
  rmdirSync,
  writeFileSync,
} from "node:fs";
import { join } from "node:path";

import { AGENT_FOLDER_MAP } from "./skills-map.ts";
import { log, write, dim, green, cyan, red, HIDE_CURSOR, SHOW_CURSOR, SPINNER } from "./colors.ts";

// ── Types ────────────────────────────────────────────────────

export interface UninstallResult {
  success: boolean;
  skillName: string;
  removedPaths: string[];
  output: string;
  stderr: string;
}

interface UninstallOptions {
  projectDir?: string;
  verbose?: boolean;
  onTrace?: (message: string) => void;
}

export interface UninstallAllResult {
  uninstalled: number;
  failed: number;
  errors: { name: string; output: string; stderr: string }[];
}

// ── Filesystem helpers ───────────────────────────────────────

function safeRemove(path: string, trace?: (msg: string) => void): boolean {
  try {
    if (!existsSync(path)) {
      // existsSync follows symlinks, so it returns false for broken symlinks.
      // Use lstat to detect them and still remove them.
      try {
        lstatSync(path);
      } catch {
        return false;
      }
    }
    rmSync(path, { recursive: true, force: true });
    trace?.(`removed ${path}`);
    return true;
  } catch (err) {
    trace?.(`could not remove ${path}: ${(err as Error).message}`);
    return false;
  }
}

function removeFromSkillsLock(projectDir: string, skillName: string): boolean {
  const lockPath = join(projectDir, "skills-lock.json");
  if (!existsSync(lockPath)) return false;

  let lock: { version?: number; skills?: Record<string, unknown> };
  try {
    lock = JSON.parse(readFileSync(lockPath, "utf-8"));
  } catch {
    return false;
  }

  if (!lock?.skills || typeof lock.skills !== "object" || !(skillName in lock.skills)) {
    return false;
  }

  delete lock.skills[skillName];

  const remaining = Object.keys(lock.skills);
  if (remaining.length === 0) {
    rmSync(lockPath, { force: true });
    return true;
  }

  const sortedSkills: Record<string, unknown> = {};
  for (const k of remaining.sort()) {
    sortedSkills[k] = lock.skills[k];
  }
  lock.skills = sortedSkills;
  writeFileSync(lockPath, JSON.stringify(lock, null, 2) + "\n");
  return true;
}

function removeEmptyDir(path: string, trace?: (msg: string) => void): void {
  try {
    if (!existsSync(path)) return;
    const entries = readdirSync(path);
    if (entries.length === 0) {
      rmdirSync(path);
      trace?.(`removed empty dir ${path}`);
    }
  } catch {
    // ignore — best-effort cleanup
  }
}

// ── Installed skills discovery ───────────────────────────────

/**
 * Return the list of skills currently installed in the project, drawn from
 * skills-lock.json (preferred) and falling back to the contents of
 * .agents/skills/. Names are sorted alphabetically and de-duplicated.
 */
export function listInstalledSkills(projectDir: string): string[] {
  const names = new Set<string>();

  try {
    const lock = JSON.parse(readFileSync(join(projectDir, "skills-lock.json"), "utf-8"));
    if (lock?.skills && typeof lock.skills === "object") {
      for (const name of Object.keys(lock.skills)) names.add(name);
    }
  } catch {}

  try {
    const entries = readdirSync(join(projectDir, ".agents", "skills"), { withFileTypes: true });
    for (const entry of entries) {
      if (entry.isDirectory()) names.add(entry.name);
    }
  } catch {}

  return [...names].sort((a, b) => a.localeCompare(b));
}

// ── Single skill uninstall ───────────────────────────────────

export function uninstallSkill(skillName: string, opts: UninstallOptions = {}): UninstallResult {
  const projectDir = opts.projectDir || process.cwd();
  const trace = opts.onTrace;
  const removedPaths: string[] = [];

  if (!skillName || skillName.includes("/") || skillName.includes("\\") || skillName === "..") {
    return {
      success: false,
      skillName,
      removedPaths: [],
      output: `invalid skill name: ${skillName}`,
      stderr: `invalid skill name: ${skillName}`,
    };
  }

  // 1) Remove the per-agent symlinks/copies under each known agent folder.
  for (const folder of Object.keys(AGENT_FOLDER_MAP)) {
    const linkPath = join(projectDir, folder, "skills", skillName);
    if (safeRemove(linkPath, trace)) removedPaths.push(linkPath);
    // If the agent's skills/ directory is now empty, prune it (best-effort).
    removeEmptyDir(join(projectDir, folder, "skills"), trace);
    removeEmptyDir(join(projectDir, folder), trace);
  }

  // 2) Remove the canonical install dir under .agents/skills/<name>.
  const canonicalDir = join(projectDir, ".agents", "skills", skillName);
  if (safeRemove(canonicalDir, trace)) removedPaths.push(canonicalDir);

  // 3) Prune .agents/skills and .agents if they ended up empty.
  removeEmptyDir(join(projectDir, ".agents", "skills"), trace);
  removeEmptyDir(join(projectDir, ".agents"), trace);

  // 4) Remove the entry from skills-lock.json.
  const lockUpdated = removeFromSkillsLock(projectDir, skillName);
  if (lockUpdated) {
    removedPaths.push(`skills-lock.json:${skillName}`);
    trace?.(`updated skills-lock.json (removed ${skillName})`);
  }

  if (removedPaths.length === 0) {
    return {
      success: false,
      skillName,
      removedPaths,
      output: `skill '${skillName}' is not installed`,
      stderr: `skill '${skillName}' is not installed`,
    };
  }

  return {
    success: true,
    skillName,
    removedPaths,
    output: `uninstalled ${skillName}`,
    stderr: "",
  };
}

// ── Batch uninstall ──────────────────────────────────────────

export async function uninstallAll(
  skillNames: string[],
  opts: UninstallOptions = {},
): Promise<UninstallAllResult> {
  if (opts.verbose) return uninstallAllVerbose(skillNames, opts);
  if (!process.stdout.isTTY) return uninstallAllSimple(skillNames, opts);

  const sorted = [...skillNames].sort((a, b) => a.localeCompare(b));
  const total = sorted.length;
  const states = sorted.map((name) => ({
    name,
    status: "pending" as "pending" | "removing" | "success" | "failed",
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
        case "removing":
          write(cyan(`   ${SPINNER[frame]}`) + ` ${state.name}...\n`);
          break;
        case "success":
          write(green(`   ✔ ${state.name}`) + dim(" — removed") + "\n");
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

  let uninstalled = 0;
  let failed = 0;
  const errors: UninstallAllResult["errors"] = [];

  for (let i = 0; i < sorted.length; i++) {
    const state = states[i];
    state.status = "removing";
    activeCount++;
    render();

    const result = uninstallSkill(sorted[i], opts);

    activeCount--;
    if (result.success) {
      state.status = "success";
      uninstalled++;
    } else {
      state.status = "failed";
      errors.push({ name: result.skillName, output: result.output, stderr: result.stderr });
      failed++;
    }
    render();
  }

  clearInterval(timer);
  render();
  write(SHOW_CURSOR);

  return { uninstalled, failed, errors };
}

function uninstallAllVerbose(skillNames: string[], opts: UninstallOptions): UninstallAllResult {
  const sorted = [...skillNames].sort((a, b) => a.localeCompare(b));
  let uninstalled = 0;
  let failed = 0;
  const errors: UninstallAllResult["errors"] = [];

  for (const name of sorted) {
    log(cyan(`   ◆ ${name}`));
    const result = uninstallSkill(name, {
      ...opts,
      onTrace: (message) => log(dim(`     ${message}`)),
    });

    if (result.success) {
      log(green(`     ✔ removed`));
      uninstalled++;
    } else {
      log(red(`     ✘ failed`) + dim(` — ${result.output}`));
      errors.push({ name: result.skillName, output: result.output, stderr: result.stderr });
      failed++;
    }
    log();
  }

  return { uninstalled, failed, errors };
}

function uninstallAllSimple(skillNames: string[], opts: UninstallOptions): UninstallAllResult {
  const sorted = [...skillNames].sort((a, b) => a.localeCompare(b));
  let uninstalled = 0;
  let failed = 0;
  const errors: UninstallAllResult["errors"] = [];

  for (const name of sorted) {
    const result = uninstallSkill(name, opts);
    if (result.success) {
      log(green(`   ✔ ${name}`) + dim(" — removed"));
      uninstalled++;
    } else {
      log(red(`   ✘ ${name}`) + dim(` — ${result.output}`));
      errors.push({ name: result.skillName, output: result.output, stderr: result.stderr });
      failed++;
    }
  }

  return { uninstalled, failed, errors };
}
