#!/usr/bin/env node

import { resolve, dirname, join } from "node:path";
import { readFileSync } from "node:fs";
import { fileURLToPath } from "node:url";
import { spawn } from "node:child_process";
import { detectTechnologies, collectSkills, parseSkillPath } from "./lib.mjs";

const __dirname = dirname(fileURLToPath(import.meta.url));
const VERSION = JSON.parse(readFileSync(join(__dirname, "package.json"), "utf-8")).version;

// ── ANSI Colors ───────────────────────────────────────────────

const noColor = "NO_COLOR" in process.env;
const forceColor = "FORCE_COLOR" in process.env;
const useColor = forceColor || (!noColor && process.stdout.isTTY);

const bold = useColor ? (s) => `\x1b[1m${s}\x1b[22m` : (s) => s;
const dim = useColor ? (s) => `\x1b[2m${s}\x1b[22m` : (s) => s;
const green = useColor ? (s) => `\x1b[32m${s}\x1b[39m` : (s) => s;
const yellow = useColor ? (s) => `\x1b[33m${s}\x1b[39m` : (s) => s;
const cyan = useColor ? (s) => `\x1b[36m${s}\x1b[39m` : (s) => s;
const red = useColor ? (s) => `\x1b[31m${s}\x1b[39m` : (s) => s;
const magenta = useColor ? (s) => `\x1b[35m${s}\x1b[39m` : (s) => s;
const gray = useColor ? (s) => `\x1b[38;5;240m${s}\x1b[39m` : (s) => s;
const white = useColor ? (s) => `\x1b[97m${s}\x1b[39m` : (s) => s;
const HIDE_CURSOR = process.stdout.isTTY ? "\x1b[?25l" : "";
const SHOW_CURSOR = process.stdout.isTTY ? "\x1b[?25h" : "";
const SPINNER = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"];

// Restore cursor on unexpected exit
process.on("SIGINT", () => {
  process.stdout.write(SHOW_CURSOR + "\n");
  process.exit(130);
});

// ── Helpers ──────────────────────────────────────────────────

function formatTime(ms) {
  if (ms < 1000) return `${ms}ms`;
  const s = ms / 1000;
  if (s < 60) return `${s.toFixed(1)}s`;
  const m = Math.floor(s / 60);
  return `${m}m ${Math.round(s % 60)}s`;
}

// ── Terminal UI ───────────────────────────────────────────────

function printBanner() {
  const ver = `v${VERSION}`;
  const title = "   autoskills";
  const gap = " ".repeat(39 - title.length - ver.length - 3);
  console.log();
  console.log(bold(cyan("   ╔═══════════════════════════════════════╗")));
  console.log(bold(cyan("   ║")) + bold(yellow(title)) + gap + gray(ver) + "   " + bold(cyan("║")));
  console.log(
    bold(cyan("   ║")) + dim("   Auto-install the best AI skills     ") + bold(cyan("║")),
  );
  console.log(
    bold(cyan("   ║")) + dim("   for your project                    ") + bold(cyan("║")),
  );
  console.log(bold(cyan("   ╚═══════════════════════════════════════╝")));
  console.log();
}

/**
 * Interactive multi-select with optional group headers.
 * All items are selected by default.
 */
function multiSelect(items, { labelFn, hintFn, groupFn }) {
  if (!process.stdin.isTTY) return Promise.resolve(items);

  return new Promise((resolve) => {
    const selected = Array.from({ length: items.length }, () => true);
    let cursor = 0;
    let rendered = false;

    let groupCount = 0;
    if (groupFn) {
      let last = null;
      for (const item of items) {
        const g = groupFn(item);
        if (g !== last) {
          groupCount++;
          last = g;
        }
      }
    }

    function render() {
      if (rendered) {
        // items + group headers + blank line (instruction line has no \n)
        process.stdout.write(`\x1b[${items.length + groupCount + 1}A\r`);
      }
      rendered = true;
      process.stdout.write("\x1b[J");
      draw();
    }

    function draw() {
      const count = selected.filter(Boolean).length;
      let lastGroup = null;

      for (let i = 0; i < items.length; i++) {
        if (groupFn) {
          const group = groupFn(items[i]);
          if (group !== lastGroup) {
            lastGroup = group;
            process.stdout.write(`   ${dim(group)}\n`);
          }
        }
        const pointer = i === cursor ? cyan("❯") : " ";
        const check = selected[i] ? green("◼") : dim("◻");
        const label = labelFn(items[i], i);
        const hint = hintFn ? hintFn(items[i], i) : "";
        const line = selected[i] ? label : dim(label);
        process.stdout.write(`   ${pointer} ${check} ${line}${hint ? "  " + dim(hint) : ""}\n`);
      }
      process.stdout.write("\n");
      process.stdout.write(
        dim("   ") +
          white(bold("[↑↓]")) +
          dim(" move · ") +
          white(bold("[space]")) +
          dim(" toggle · ") +
          white(bold("[a]")) +
          dim(" all · ") +
          white(bold("[enter]")) +
          dim(` confirm (${count}/${items.length})`),
      );
    }

    process.stdout.write(HIDE_CURSOR);
    render();

    const { stdin } = process;
    stdin.setRawMode(true);
    stdin.resume();
    stdin.setEncoding("utf-8");

    function onData(key) {
      if (key === "\x03") {
        cleanup();
        process.stdout.write(SHOW_CURSOR + "\n");
        process.exit(0);
      }

      if (key === "\r" || key === "\n") {
        cleanup();
        process.stdout.write("\x1b[1A\r\x1b[J");
        process.stdout.write(SHOW_CURSOR);
        resolve(items.filter((_, i) => selected[i]));
        return;
      }

      if (key === " ") {
        selected[cursor] = !selected[cursor];
        render();
        return;
      }

      if (key === "a") {
        const allSelected = selected.every(Boolean);
        selected.fill(!allSelected);
        render();
        return;
      }

      if (key === "\x1b[A" || key === "k") {
        cursor = (cursor - 1 + items.length) % items.length;
        render();
        return;
      }
      if (key === "\x1b[B" || key === "j") {
        cursor = (cursor + 1) % items.length;
        render();
        return;
      }
    }

    function cleanup() {
      stdin.setRawMode(false);
      stdin.pause();
      stdin.removeListener("data", onData);
    }

    stdin.on("data", onData);
  });
}

// ── Installation ──────────────────────────────────────────────

function installSkill(skillPath) {
  const { repo, skillName } = parseSkillPath(skillPath);
  const args = ["-y", "skills", "add", repo];
  if (skillName) args.push("--skill", skillName);
  args.push("-y");
  return new Promise((resolve) => {
    const child = spawn("npx", args, {
      stdio: ["pipe", "pipe", "pipe"],
    });

    let output = "";
    child.stdout?.on("data", (d) => {
      output += d.toString();
    });
    child.stderr?.on("data", (d) => {
      output += d.toString();
    });

    child.on("close", (code) => {
      resolve({ success: code === 0, output });
    });

    child.on("error", (err) => {
      resolve({ success: false, output: err.message });
    });
  });
}

/**
 * Parallel installer with animated spinners and live status.
 * Falls back to sequential output for non-TTY environments.
 */
async function installAll(skills) {
  if (!process.stdout.isTTY) return installAllSimple(skills);

  const CONCURRENCY = 3;
  const total = skills.length;

  const states = skills.map(({ skill }) => ({
    name: skill,
    skill,
    status: "pending",
    output: "",
  }));

  let frame = 0;
  let rendered = false;

  function render() {
    if (rendered) {
      process.stdout.write(`\x1b[${total}A\r`);
    }
    rendered = true;
    process.stdout.write("\x1b[J");

    for (const state of states) {
      switch (state.status) {
        case "pending":
          process.stdout.write(dim(`   ◌ ${state.name}`) + "\n");
          break;
        case "installing":
          process.stdout.write(cyan(`   ${SPINNER[frame]}`) + ` ${state.name}...\n`);
          break;
        case "success":
          process.stdout.write(green(`   ✔ ${state.name}`) + "\n");
          break;
        case "failed":
          process.stdout.write(red(`   ✘ ${state.name}`) + dim(" — failed") + "\n");
          break;
      }
    }
  }

  process.stdout.write(HIDE_CURSOR);

  const timer = setInterval(() => {
    frame = (frame + 1) % SPINNER.length;
    if (states.some((s) => s.status === "installing")) render();
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
      render();

      const result = await installSkill(state.skill);

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
  process.stdout.write(SHOW_CURSOR);

  return { installed, failed, errors };
}

async function installAllSimple(skills) {
  let installed = 0;
  let failed = 0;
  const errors = [];

  for (const { skill } of skills) {
    const result = await installSkill(skill);

    if (result.success) {
      console.log(green(`   ✔ ${skill}`));
      installed++;
    } else {
      console.log(red(`   ✘ ${skill}`) + dim(" — failed"));
      errors.push({ name: skill, output: result.output });
      failed++;
    }
  }

  return { installed, failed, errors };
}

// ── Main ──────────────────────────────────────────────────────

async function main() {
  const args = process.argv.slice(2);
  const autoYes = args.includes("-y") || args.includes("--yes");
  const dryRun = args.includes("--dry-run");
  const verbose = args.includes("--verbose") || args.includes("-v");

  if (args.includes("--help") || args.includes("-h")) {
    console.log(`
  ${bold("autoskills")} — Auto-install the best AI skills for your project

  ${bold("Usage:")}
    npx autoskills            Detect & install skills
    npx autoskills ${dim("-y")}        Skip confirmation
    npx autoskills ${dim("--dry-run")} Show what would be installed

  ${bold("Options:")}
    -y, --yes       Skip confirmation prompt
    --dry-run       Show skills without installing
    -v, --verbose   Show error details on failure
    -h, --help      Show this help message
`);
    process.exit(0);
  }

  printBanner();

  const projectDir = resolve(".");

  // ── Detect technologies
  process.stdout.write(dim("   Scanning project...\r"));
  const { detected, isFrontend, combos } = detectTechnologies(projectDir);
  process.stdout.write("\x1b[K");

  if (detected.length === 0 && !isFrontend) {
    console.log(yellow("   ⚠ No supported technologies detected."));
    console.log(dim("   Make sure you run this in a project directory."));
    console.log();
    process.exit(0);
  }

  // ── Show detected technologies
  if (detected.length > 0) {
    const withSkills = detected.filter((t) => t.skills.length > 0);
    const withoutSkills = detected.filter((t) => t.skills.length === 0);
    const allTech = [...withSkills, ...withoutSkills];

    console.log(cyan("   ▸ ") + bold("Detected technologies:"));
    console.log();

    const COLS = 3;
    const maxNameLen = Math.max(...allTech.map((t) => t.name.length));
    const colWidth = maxNameLen + 3;
    const rows = Math.ceil(allTech.length / COLS);

    for (let r = 0; r < rows; r++) {
      let line = "     ";
      for (let c = 0; c < COLS; c++) {
        const idx = r * COLS + c;
        if (idx < allTech.length) {
          const tech = allTech[idx];
          const hasSkills = tech.skills.length > 0;
          const icon = hasSkills ? green("✔") : dim("●");
          const padded = tech.name.padEnd(colWidth);
          line += `${icon} ${hasSkills ? padded : dim(padded)}`;
        }
      }
      console.log(line);
    }

    if (combos.length > 0) {
      console.log();
      console.log(magenta("   ▸ ") + bold("Detected combos:"));
      console.log();
      for (const combo of combos) {
        console.log(magenta(`     ⚡ `) + combo.name);
      }
    }
    console.log();
  }

  if (isFrontend && detected.length === 0) {
    console.log(cyan("   ▸ ") + bold("Web frontend detected ") + dim("(from project files)"));
    console.log();
  }

  // ── Collect unique skills
  const skills = collectSkills(detected, isFrontend, combos);

  if (skills.length === 0) {
    console.log(yellow("   No skills available for your stack yet."));
    console.log(dim("   Check https://skills.sh for the latest."));
    console.log();
    process.exit(0);
  }

  const maxSkillLen = Math.max(...skills.map((s) => s.skill.length));

  // ── Dry run: just list and exit
  if (dryRun) {
    console.log(cyan("   ▸ ") + bold(`Skills to install `) + dim(`(${skills.length})`));
    console.log();
    for (let i = 0; i < skills.length; i++) {
      const { skill, sources } = skills[i];
      const pad = " ".repeat(maxSkillLen - skill.length);
      const num = String(i + 1).padStart(2, " ");
      console.log(
        dim(`   ${num}.`) + ` ${cyan(skill)}${pad}  ${dim(`← ${sources.join(", ")}`)}`,
      );
    }
    console.log();
    console.log(dim("   --dry-run: nothing was installed."));
    console.log();
    process.exit(0);
  }

  // ── Interactive select or auto-yes
  let selectedSkills;

  if (autoYes) {
    console.log(cyan("   ▸ ") + bold(`Skills to install `) + dim(`(${skills.length})`));
    console.log();
    for (let i = 0; i < skills.length; i++) {
      const { skill, sources } = skills[i];
      const pad = " ".repeat(maxSkillLen - skill.length);
      const num = String(i + 1).padStart(2, " ");
      console.log(
        dim(`   ${num}.`) + ` ${cyan(skill)}${pad}  ${dim(`← ${sources.join(", ")}`)}`,
      );
    }
    console.log();
    selectedSkills = skills;
  } else {
    console.log(
      cyan("   ▸ ") + bold(`Select skills to install `) + dim(`(${skills.length} found)`),
    );
    console.log();

    selectedSkills = await multiSelect(skills, {
      labelFn: (s) => {
        return s.skill + " ".repeat(maxSkillLen - s.skill.length);
      },
      hintFn: (s) => (s.sources.length > 1 ? `← ${s.sources.join(", ")}` : ""),
      groupFn: (s) => s.sources[0],
    });

    if (selectedSkills.length === 0) {
      console.log();
      console.log(dim("   Nothing selected."));
      console.log();
      process.exit(0);
    }
  }

  console.log();

  // ── Install skills
  const startTime = Date.now();
  const { installed, failed, errors } = await installAll(selectedSkills);
  const elapsed = Date.now() - startTime;

  // ── Summary
  console.log();
  if (failed === 0) {
    console.log(
      green(
        bold(
          `   ✔ Done! ${installed} skill${installed !== 1 ? "s" : ""} installed in ${formatTime(elapsed)}.`,
        ),
      ),
    );
  } else {
    console.log(
      yellow(
        `   Done: ${green(`${installed} installed`)}, ${red(`${failed} failed`)} in ${formatTime(elapsed)}.`,
      ),
    );

    if (errors.length > 0) {
      console.log();
      console.log(bold(red("   Errors:")));
      for (const { name, output } of errors) {
        console.log(red(`     ✘ ${name}`));
        if (verbose && output) {
          const lines = output.trim().split("\n").slice(-5);
          for (const line of lines) {
            console.log(dim(`       ${line}`));
          }
        }
      }
      if (!verbose) {
        console.log(dim("   Run with --verbose to see error details."));
      }
    }
  }
  console.log();
}

main().catch((err) => {
  console.error(red(`\n   Error: ${err.message}\n`));
  process.exit(1);
});
