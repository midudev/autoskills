#!/usr/bin/env node

import { resolve, dirname, join } from "node:path";
import { readFileSync } from "node:fs";
import { fileURLToPath } from "node:url";

import { detectTechnologies, collectSkills, detectAgents } from "./lib.mjs";
import {
  bold,
  dim,
  green,
  yellow,
  cyan,
  magenta,
  red,
  pink,
  gray,
  SHOW_CURSOR,
} from "./colors.mjs";
import { printBanner, multiSelect, formatTime } from "./ui.mjs";
import { installAll } from "./installer.mjs";

const __dirname = dirname(fileURLToPath(import.meta.url));
const VERSION = JSON.parse(readFileSync(join(__dirname, "package.json"), "utf-8")).version;

process.on("SIGINT", () => {
  process.stdout.write(SHOW_CURSOR + "\n");
  process.exit(130);
});

// ── CLI ──────────────────────────────────────────────────────

/**
 * Parses CLI arguments from `process.argv`.
 * @returns {{ autoYes: boolean, dryRun: boolean, verbose: boolean, help: boolean, agents: string[] }}
 */
function parseArgs() {
  const args = process.argv.slice(2);
  const agents = [];
  const agentIdx = args.findIndex((a) => a === "-a" || a === "--agent");
  if (agentIdx !== -1) {
    for (let i = agentIdx + 1; i < args.length; i++) {
      if (args[i].startsWith("-")) break;
      agents.push(args[i]);
    }
  }
  return {
    autoYes: args.includes("-y") || args.includes("--yes"),
    dryRun: args.includes("--dry-run"),
    verbose: args.includes("--verbose") || args.includes("-v"),
    help: args.includes("--help") || args.includes("-h"),
    agents,
  };
}

/** Prints usage information and available flags to stdout. */
function showHelp() {
  console.log(`
  ${bold("autoskills")} — Auto-install the best AI skills for your project

  ${bold("Usage:")}
    npx autoskills                   Detect & install skills
    npx autoskills ${dim("-y")}                   Skip confirmation
    npx autoskills ${dim("--dry-run")}            Show what would be installed
    npx autoskills ${dim("-a cursor claude-code")} Install for specific IDEs only

  ${bold("Options:")}
    -y, --yes       Skip confirmation prompt
    --dry-run       Show skills without installing
    -v, --verbose   Show error details on failure
    -a, --agent     Install for specific IDEs only (e.g. cursor, claude-code)
    -h, --help      Show this help message
`);
}

// ── Display ──────────────────────────────────────────────────

/**
 * Displays the detected technologies and combo matches in a formatted grid.
 * Technologies with available skills are highlighted; those without are dimmed.
 * @param {object[]} detected - Technologies found in the project.
 * @param {object[]} combos - Matched combo skill entries.
 * @param {boolean} isFrontend - Whether the project has a web frontend.
 */
function printDetected(detected, combos, isFrontend) {
  if (detected.length > 0) {
    const withSkills = detected.filter((t) => t.skills.length > 0);
    const withoutSkills = detected.filter((t) => t.skills.length === 0);
    const allTech = [...withSkills, ...withoutSkills];

    console.log(cyan("   ◆ ") + bold("Detected technologies:"));
    console.log();

    const COLS = 3;
    const colWidth = Math.max(...allTech.map((t) => t.name.length)) + 3;

    const formatTech = (tech) => {
      const hasSkills = tech.skills.length > 0;
      const icon = hasSkills ? green("✔") : dim("●");
      const name = tech.name.padEnd(colWidth);
      return `${icon} ${hasSkills ? name : dim(name)}`;
    };

    for (let i = 0; i < allTech.length; i += COLS) {
      const row = allTech
        .slice(i, i + COLS)
        .map(formatTech)
        .join("");
      console.log(`     ${row}`);
    }

    if (combos.length > 0) {
      console.log();
      console.log(magenta("   ◆ ") + bold("Detected combos:"));
      console.log();
      for (const combo of combos) {
        console.log(magenta(`     ⚡ `) + combo.name);
      }
    }
    console.log();
  }

  if (isFrontend && detected.length === 0) {
    console.log(cyan("   ◆ ") + bold("Web frontend detected ") + dim("(from project files)"));
    console.log();
  }
}

/**
 * Builds a cleaner, human-readable skill label for CLI output.
 * - URLs are kept as-is.
 * - 3-segment paths (`author/group/skill`) are rendered as `author › skill`.
 * - Any other format is kept as-is.
 * @param {string} skill
 * @param {{ styled?: boolean }} [opts]
 * @returns {string}
 */
function formatSkillLabel(skill, { styled = false } = {}) {
  if (/^https?:\/\//i.test(skill)) {
    return styled ? cyan(skill) : skill;
  }

  const parts = skill.split("/");
  if (parts.length !== 3) {
    return styled ? cyan(skill) : skill;
  }

  const [author, , skillName] = parts;
  if (!styled) {
    return `${author} › ${skillName}`;
  }

  return `${gray(author)} ${gray("›")} ${cyan(bold(skillName))}`;
}

/**
 * Prints a numbered list of skills with their source technologies.
 * @param {{ skill: string, sources: string[] }[]} skills
 */
function printSkillsList(skills) {
  const visibleLabels = skills.map((s) => formatSkillLabel(s.skill));
  const maxLen = Math.max(...visibleLabels.map((label) => label.length));
  console.log(cyan("   ◆ ") + bold(`Skills to install `) + dim(`(${skills.length})`));
  console.log();
  for (let i = 0; i < skills.length; i++) {
    const { skill, sources } = skills[i];
    const label = formatSkillLabel(skill);
    const styledLabel = formatSkillLabel(skill, { styled: true });
    const techSources = sources.filter((s) => !s.includes(" + "));
    const pad = " ".repeat(maxLen - label.length);
    const num = String(i + 1).padStart(2, " ");
    const suffix = techSources.length > 0 ? `  ${dim(`← ${techSources.join(", ")}`)}` : "";
    console.log(dim(`   ${num}.`) + ` ${styledLabel}${pad}${suffix}`);
  }
  console.log();
}

/**
 * Prints the final installation summary: success/failure counts, errors, and elapsed time.
 * @param {{ installed: number, failed: number, errors: { name: string, output: string }[], elapsed: number, verbose: boolean }} opts
 */
function printSummary({ installed, failed, errors, elapsed, verbose }) {
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
  console.log(
    pink("   Enjoyed autoskills? Consider sponsoring → https://github.com/sponsors/midudev"),
  );
  console.log();
}

// ── Skill Selection ──────────────────────────────────────────

/**
 * Prompts the user to select which skills to install via an interactive multi-select.
 * When `autoYes` is true, all skills are selected automatically without prompting.
 * @param {{ skill: string, sources: string[] }[]} skills - Available skills.
 * @param {boolean} autoYes - Skip confirmation and select all.
 * @returns {Promise<{ skill: string, sources: string[] }[]>} Selected skills.
 */
async function selectSkills(skills, autoYes) {
  const visibleLabels = skills.map((s) => formatSkillLabel(s.skill));
  const maxLen = Math.max(...visibleLabels.map((label) => label.length));

  if (autoYes) {
    printSkillsList(skills);
    return skills;
  }

  console.log(cyan("   ◆ ") + bold(`Select skills to install `) + dim(`(${skills.length} found)`));
  console.log();

  const selected = await multiSelect(skills, {
    labelFn: (s) => {
      const label = formatSkillLabel(s.skill);
      const styledLabel = formatSkillLabel(s.skill, { styled: true });
      return styledLabel + " ".repeat(maxLen - label.length);
    },
    hintFn: (s) => {
      const techSources = s.sources.filter((src) => !src.includes(" + "));
      return techSources.length > 1 ? `← ${techSources.join(", ")}` : "";
    },
    groupFn: (s) => s.sources[0],
  });

  if (selected.length === 0) {
    console.log();
    console.log(dim("   Nothing selected."));
    console.log();
    process.exit(0);
  }

  return selected;
}

// ── Main ─────────────────────────────────────────────────────

/** CLI entry point: detects technologies, prompts for selection, and installs skills. */
async function main() {
  const { autoYes, dryRun, verbose, help, agents } = parseArgs();

  if (help) {
    showHelp();
    process.exit(0);
  }

  printBanner(VERSION);

  const projectDir = resolve(".");

  process.stdout.write(dim("   Scanning project...\r"));
  const { detected, isFrontend, combos } = detectTechnologies(projectDir);
  process.stdout.write("\x1b[K");

  if (detected.length === 0 && !isFrontend) {
    console.log(yellow("   ⚠ No supported technologies detected."));
    console.log(dim("   Make sure you run this in a project directory."));
    console.log();
    process.exit(0);
  }

  printDetected(detected, combos, isFrontend);

  const skills = collectSkills(detected, isFrontend, combos);
  const resolvedAgents = agents.length > 0 ? agents : detectAgents();

  if (skills.length === 0) {
    console.log(yellow("   No skills available for your stack yet."));
    console.log(dim("   Check https://skills.sh for the latest."));
    console.log();
    process.exit(0);
  }

  if (dryRun) {
    printSkillsList(skills);
    console.log(dim(`   Agents: ${resolvedAgents.join(", ")}`));
    console.log(dim("   --dry-run: nothing was installed."));
    console.log();
    process.exit(0);
  }

  const selectedSkills = await selectSkills(skills, autoYes);

  if (!autoYes && process.stdout.isTTY) {
    process.stdout.write("\x1b[H\x1b[2J\x1b[3J");
    printBanner(VERSION);
  } else {
    console.log();
  }

  console.log(cyan("   ◆ ") + bold("Installing skills..."));
  console.log(dim(`   Agents: ${resolvedAgents.join(", ")}`));
  console.log();

  const startTime = Date.now();
  const { installed, failed, errors } = await installAll(selectedSkills, resolvedAgents);
  const elapsed = Date.now() - startTime;

  if (process.stdout.isTTY) {
    const up = selectedSkills.length + 2;
    process.stdout.write(`\x1b[${up}A\r\x1b[K`);
    console.log(green("   ◆ ") + bold("Done!"));
    process.stdout.write(`\x1b[${selectedSkills.length + 1}B`);
  }

  printSummary({ installed, failed, errors, elapsed, verbose });
}

main().catch((err) => {
  console.error(red(`\n   Error: ${err.message}\n`));
  process.exit(1);
});
