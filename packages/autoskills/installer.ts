import { spawn, execFileSync } from "node:child_process";
import { parseSkillPath } from "./lib.ts";
import type { SkillEntry } from "./lib.ts";
import { log, write, dim, green, cyan, red, HIDE_CURSOR, SHOW_CURSOR, SPINNER } from "./colors.ts";

export function getNpxCommand(platform: string = process.platform): string {
  return platform === "win32" ? "npx.cmd" : "npx";
}

export function getNpxSpawnOptions(platform: string = process.platform): {
  stdio: string[];
  shell: boolean;
} {
  return {
    stdio: ["pipe", "pipe", "pipe"],
    shell: platform === "win32",
  };
}

export function buildInstallArgs(skillPath: string, agents: string[] = []): string[] {
  const { repo, skillName } = parseSkillPath(skillPath);
  const args = ["-y", "skills", "add", repo];
  if (skillName) args.push("--skill", skillName);
  args.push("-y");
  if (agents.length > 0) args.push("-a", ...agents);
  return args;
}

export function buildDirectArgs(skillPath: string, agents: string[] = []): string[] {
  const { repo, skillName } = parseSkillPath(skillPath);
  const args = ["add", repo];
  if (skillName) args.push("--skill", skillName);
  args.push("-y");
  if (agents.length > 0) args.push("-a", ...agents);
  return args;
}

let _resolvedBin: string | null | undefined;

export function resolveSkillsBin(): string | null {
  if (_resolvedBin !== undefined) return _resolvedBin;
  try {
    const npx = getNpxCommand();
    execFileSync(npx, ["-y", "skills", "--version"], {
      encoding: "utf-8",
      timeout: 30_000,
      stdio: "pipe",
    });
    const whichCmd = process.platform === "win32" ? "where" : "which";
    const binPath = execFileSync(whichCmd, ["skills"], {
      encoding: "utf-8",
      timeout: 5_000,
      stdio: "pipe",
    }).trim();
    _resolvedBin = binPath || null;
  } catch {
    _resolvedBin = null;
  }
  return _resolvedBin;
}

/** @internal — exported for testing only */
export function _resetResolvedBin(): void {
  _resolvedBin = undefined;
}

interface InstallResult {
  success: boolean;
  output: string;
  stderr: string;
  exitCode: number | null;
  command: string;
}

export function installSkill(skillPath: string, agents: string[] = []): Promise<InstallResult> {
  const bin = resolveSkillsBin();

  let cmd: string;
  let args: string[];
  let opts: { stdio: string[]; shell?: boolean };
  if (bin) {
    cmd = bin;
    args = buildDirectArgs(skillPath, agents);
    opts = { stdio: ["pipe", "pipe", "pipe"] };
  } else {
    cmd = getNpxCommand();
    args = buildInstallArgs(skillPath, agents);
    opts = getNpxSpawnOptions();
  }

  const command = `${cmd} ${args.join(" ")}`;

  return new Promise((resolve) => {
    const child = spawn(cmd, args, opts as Parameters<typeof spawn>[2]);

    const stdoutChunks: Buffer[] = [];
    const stderrChunks: Buffer[] = [];
    child.stdout?.on("data", (d: Buffer) => stdoutChunks.push(d));
    child.stderr?.on("data", (d: Buffer) => stderrChunks.push(d));

    child.on("close", (code) => {
      const stdout = Buffer.concat(stdoutChunks).toString();
      const stderr = Buffer.concat(stderrChunks).toString();
      resolve({
        success: code === 0,
        output: stdout + stderr,
        stderr,
        exitCode: code,
        command,
      });
    });

    child.on("error", (err) => {
      resolve({
        success: false,
        output: err.message,
        stderr: err.message,
        exitCode: null,
        command,
      });
    });
  });
}

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
): Promise<InstallAllResult> {
  if (!process.stdout.isTTY) return installAllSimple(skills, agents);

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
  let nextIdx = 0;

  async function worker(): Promise<void> {
    while (nextIdx < total) {
      const idx = nextIdx++;
      const state = states[idx];
      state.status = "installing";
      activeCount++;
      render();

      const result = await installSkill(state.skill, agents);

      activeCount--;
      if (result.success) {
        state.status = "success";
        installed++;
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

  return { installed, failed, errors };
}

async function installAllSimple(
  skills: SkillEntry[],
  agents: string[] = [],
): Promise<InstallAllResult> {
  const CONCURRENCY = 6;
  const sorted = sortByRepo(skills);
  let installed = 0;
  let failed = 0;
  const errors: InstallAllResult["errors"] = [];
  let nextIdx = 0;

  async function worker(): Promise<void> {
    while (nextIdx < sorted.length) {
      const idx = nextIdx++;
      const { skill } = sorted[idx];
      const result = await installSkill(skill, agents);

      if (result.success) {
        log(green(`   ✔ ${skill}`));
        installed++;
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

  return { installed, failed, errors };
}
