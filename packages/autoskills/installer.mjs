import { spawn, execFileSync } from "node:child_process";
import { parseSkillPath } from "./lib.mjs";
import { log, write, dim, green, cyan, red, HIDE_CURSOR, SHOW_CURSOR, SPINNER } from "./colors.mjs";

/**
 * Returns the platform-appropriate npx executable name.
 * On Windows, Node requires `npx.cmd` to locate the batch wrapper.
 * @param {string} [platform=process.platform]
 * @returns {string} `"npx.cmd"` on win32, `"npx"` elsewhere.
 */
export function getNpxCommand(platform = process.platform) {
  return platform === "win32" ? "npx.cmd" : "npx";
}

/**
 * Builds platform-aware options for `child_process.spawn()`.
 * Enables `shell: true` on Windows so `.cmd` executables resolve correctly.
 * @param {string} [platform=process.platform]
 * @returns {{ stdio: string[], shell: boolean }}
 */
export function getNpxSpawnOptions(platform = process.platform) {
  return {
    stdio: ["pipe", "pipe", "pipe"],
    shell: platform === "win32",
  };
}

/**
 * Constructs the argument array for `npx skills add ...`.
 * @param {string} skillPath - Skill identifier (e.g. `"owner/repo/skill-name"`).
 * @param {string[]} [agents=[]] - Optional list of target IDEs (e.g. `["cursor"]`).
 * @returns {string[]} The full args array ready for `spawn`.
 */
export function buildInstallArgs(skillPath, agents = []) {
  const { repo, skillName } = parseSkillPath(skillPath);
  const args = ["-y", "skills", "add", repo];
  if (skillName) args.push("--skill", skillName);
  args.push("-y");
  if (agents.length > 0) args.push("-a", ...agents);
  return args;
}

/**
 * Constructs the argument array for a direct `skills` binary call (no npx wrapper).
 * @param {string} skillPath
 * @param {string[]} [agents=[]]
 * @returns {string[]}
 */
export function buildDirectArgs(skillPath, agents = []) {
  const { repo, skillName } = parseSkillPath(skillPath);
  const args = ["add", repo];
  if (skillName) args.push("--skill", skillName);
  args.push("-y");
  if (agents.length > 0) args.push("-a", ...agents);
  return args;
}

let _resolvedBin;

/**
 * Ensures the `skills` npm package is available and resolves its binary path.
 * The first call triggers `npx -y skills --version` to install/cache the package,
 * then reads the binary location via `which`. Subsequent calls return the cached path.
 * Falls back to null (use npx) if resolution fails.
 * @returns {string|null}
 */
export function resolveSkillsBin() {
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
export function _resetResolvedBin() {
  _resolvedBin = undefined;
}

/**
 * Spawns a child process to install a single skill via `npx skills add`.
 * Tries to use a pre-resolved binary path to avoid npx overhead on each call.
 * @param {string} skillPath - Skill identifier to install.
 * @param {string[]} [agents=[]] - Optional list of target IDEs.
 * @returns {Promise<{ success: boolean, output: string }>}
 */
export function installSkill(skillPath, agents = []) {
  const bin = resolveSkillsBin();

  let cmd, args, opts;
  if (bin) {
    cmd = bin;
    args = buildDirectArgs(skillPath, agents);
    opts = { stdio: ["pipe", "pipe", "pipe"] };
  } else {
    cmd = getNpxCommand();
    args = buildInstallArgs(skillPath, agents);
    opts = getNpxSpawnOptions();
  }

  return new Promise((resolve) => {
    const child = spawn(cmd, args, opts);

    const chunks = [];
    child.stdout?.on("data", (d) => chunks.push(d));
    child.stderr?.on("data", (d) => chunks.push(d));

    child.on("close", (code) => {
      resolve({ success: code === 0, output: Buffer.concat(chunks).toString() });
    });

    child.on("error", (err) => {
      resolve({ success: false, output: err.message });
    });
  });
}

/**
 * Sorts skills so that entries from the same repo are adjacent.
 * This improves git clone cache locality during parallel installation.
 */
function sortByRepo(skills) {
  return [...skills].sort((a, b) => {
    const repoA = parseSkillPath(a.skill).repo;
    const repoB = parseSkillPath(b.skill).repo;
    return repoA.localeCompare(repoB);
  });
}

/**
 * Parallel installer with animated spinners and live status.
 * Falls back to sequential output for non-TTY environments.
 */
export async function installAll(skills, agents = []) {
  if (!process.stdout.isTTY) return installAllSimple(skills, agents);

  const CONCURRENCY = 6;
  const sorted = sortByRepo(skills);
  const total = sorted.length;

  const states = sorted.map(({ skill }) => ({
    name: skill,
    skill,
    status: "pending",
    output: "",
  }));

  let frame = 0;
  let rendered = false;
  let activeCount = 0;

  function render() {
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
  const errors = [];
  let nextIdx = 0;

  async function worker() {
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
        errors.push({ name: state.name, output: result.output });
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

/**
 * Sequential fallback installer for non-TTY environments (CI, piped output).
 * Prints results line-by-line without animated spinners.
 * @param {{ skill: string }[]} skills - Skills to install.
 * @param {string[]} [agents=[]] - Optional list of target IDEs.
 * @returns {Promise<{ installed: number, failed: number, errors: { name: string, output: string }[] }>}
 */
async function installAllSimple(skills, agents = []) {
  const CONCURRENCY = 6;
  const sorted = sortByRepo(skills);
  let installed = 0;
  let failed = 0;
  const errors = [];
  let nextIdx = 0;

  async function worker() {
    while (nextIdx < sorted.length) {
      const idx = nextIdx++;
      const { skill } = sorted[idx];
      const result = await installSkill(skill, agents);

      if (result.success) {
        log(green(`   ✔ ${skill}`));
        installed++;
      } else {
        log(red(`   ✘ ${skill}`) + dim(" — failed"));
        errors.push({ name: skill, output: result.output });
        failed++;
      }
    }
  }

  const workers = Array.from({ length: Math.min(CONCURRENCY, sorted.length) }, () => worker());
  await Promise.all(workers);

  return { installed, failed, errors };
}
