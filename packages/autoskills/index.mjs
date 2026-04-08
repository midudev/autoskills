#!/usr/bin/env node

import { resolve, dirname, join } from "node:path";
import { readFileSync } from "node:fs";
import { fileURLToPath } from "node:url";

import { detectTechnologies, collectSkills, detectAgents, getInstalledSkillNames } from "./lib.mjs";
import {
  log,
  write,
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
import { installAll, resolveSkillsBin } from "./installer.mjs";
import { shouldGenerateClaudeMd, generateClaudeMd } from "./claude.mjs";

const __dirname = dirname(fileURLToPath(import.meta.url));
const VERSION = JSON.parse(readFileSync(join(__dirname, "package.json"), "utf-8")).version;

process.on("SIGINT", () => {
  write(SHOW_CURSOR + "\n");
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
  log(`
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

    log(cyan("   ◆ ") + bold("Detected technologies:"));
    log();

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
      log(`     ${row}`);
    }

    if (combos.length > 0) {
      log();
      log(magenta("   ◆ ") + bold("Detected combos:"));
      log();
      for (const combo of combos) {
        log(magenta(`     ⚡ `) + combo.name);
      }
    }
    log();
  }

  if (isFrontend && detected.length === 0) {
    log(cyan("   ◆ ") + bold("Web frontend detected ") + dim("(from project files)"));
    log();
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
  const INSTALLED_TAG = " (installed)";
  const entries = skills.map((s) => ({
    ...s,
    label: formatSkillLabel(s.skill),
    styledLabel: formatSkillLabel(s.skill, { styled: true }),
  }));
  const maxEffective = Math.max(
    ...entries.map((e) => e.label.length + (e.installed ? INSTALLED_TAG.length : 0)),
  );
  const newCount = skills.filter((s) => !s.installed).length;
  const installedCount = skills.length - newCount;
  const countLabel =
    installedCount > 0
      ? `(${skills.length}, ${installedCount} already installed)`
      : `(${skills.length})`;
  log(cyan("   ◆ ") + bold(`Skills to install `) + dim(countLabel));
  log();
  for (let i = 0; i < entries.length; i++) {
    const { label, styledLabel, sources, installed } = entries[i];
    const techSources = sources.filter((s) => !s.includes(" + "));
    const tag = installed ? dim(INSTALLED_TAG) : "";
    const effectiveLen = label.length + (installed ? INSTALLED_TAG.length : 0);
    const pad = " ".repeat(maxEffective - effectiveLen);
    const num = String(i + 1).padStart(2, " ");
    const sourceSuffix = techSources.length > 0 ? `  ${dim(`← ${techSources.join(", ")}`)}` : "";
    log(dim(`   ${num}.`) + ` ${styledLabel}${tag}${pad}${sourceSuffix}`);
  }
  log();
}

/**
 * Prints the final installation summary: success/failure counts, errors, and elapsed time.
 * @param {{ installed: number, failed: number, errors: { name: string, output: string }[], elapsed: number, verbose: boolean }} opts
 */
function printSummary({ installed, failed, errors, elapsed, verbose }) {
  log();

  if (failed === 0) {
    log(
      green(
        bold(
          `   ✔ Done! ${installed} skill${installed !== 1 ? "s" : ""} installed in ${formatTime(elapsed)}.`,
        ),
      ),
    );
  } else {
    log(
      yellow(
        `   Done: ${green(`${installed} installed`)}, ${red(`${failed} failed`)} in ${formatTime(elapsed)}.`,
      ),
    );

    if (errors.length > 0) {
      log();
      log(bold(red("   Errors:")));
      for (const { name, output } of errors) {
        log(red(`     ✘ ${name}`));
        if (verbose && output) {
          const lines = output.trim().split("\n").slice(-5);
          for (const line of lines) {
            log(dim(`       ${line}`));
          }
        }
      }
      if (!verbose) {
        log(dim("   Run with --verbose to see error details."));
      }
    }
  }

  log();
  log(pink("   Enjoyed autoskills? Consider sponsoring → https://github.com/sponsors/midudev"));
  log();
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
  if (autoYes) {
    printSkillsList(skills);
    return skills;
  }

  const INSTALLED_TAG = " (installed)";
  const labelCache = new Map();
  for (const s of skills) {
    labelCache.set(s.skill, {
      label: formatSkillLabel(s.skill),
      styledLabel: formatSkillLabel(s.skill, { styled: true }),
    });
  }
  const maxEffective = Math.max(
    ...skills.map((s) => {
      const len = labelCache.get(s.skill).label.length;
      return len + (s.installed ? INSTALLED_TAG.length : 0);
    }),
  );

  const newCount = skills.filter((s) => !s.installed).length;
  const installedCount = skills.length - newCount;
  const countLabel =
    installedCount > 0
      ? `${skills.length} found, ${installedCount} already installed`
      : `${skills.length} found`;
  log(cyan("   ◆ ") + bold(`Select skills to install `) + dim(`(${countLabel})`));
  log();

  const selected = await multiSelect(skills, {
    labelFn: (s) => {
      const { label, styledLabel } = labelCache.get(s.skill);
      const tag = s.installed ? " " + dim("(installed)") : "";
      const effectiveLen = label.length + (s.installed ? INSTALLED_TAG.length : 0);
      return styledLabel + tag + " ".repeat(maxEffective - effectiveLen);
    },
    hintFn: (s) => {
      const techSources = s.sources.filter((src) => !src.includes(" + "));
      return techSources.length > 1 ? `← ${techSources.join(", ")}` : "";
    },
    groupFn: (s) => s.sources[0],
    initialSelected: skills.map((s) => !s.installed),
    shortcuts:
      installedCount > 0
        ? [
            { key: "n", label: "new", fn: (items) => items.map((s) => !s.installed) },
            { key: "i", label: "installed", fn: (items) => items.map((s) => s.installed) },
          ]
        : [],
  });

  if (selected.length === 0) {
    log();
    log(dim("   Nothing selected."));
    log();
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

  write(dim("   Scanning project...\r"));
  const { detected, isFrontend, combos } = detectTechnologies(projectDir);
  write("\x1b[K");

  if (detected.length === 0 && !isFrontend) {
    log(yellow("   ⚠ No supported technologies detected."));
    log(dim("   Make sure you run this in a project directory."));
    log();
    process.exit(0);
  }

  printDetected(detected, combos, isFrontend);

  const installedNames = getInstalledSkillNames(projectDir);
  const skills = collectSkills({ detected, isFrontend, combos, installedNames });
  const resolvedAgents = agents.length > 0 ? agents : detectAgents();

  if (skills.length === 0) {
    log(yellow("   No skills available for your stack yet."));
    log(dim("   Check https://skills.sh for the latest."));
    log();
    process.exit(0);
  }

  if (!dryRun) {
    setImmediate(resolveSkillsBin);
  }

  if (dryRun) {
    printSkillsList(skills);
    log(dim(`   Agents: ${resolvedAgents.join(", ")}`));
    if (shouldGenerateClaudeMd(resolvedAgents)) {
      log(dim("   Claude Code detected: `CLAUDE.md` will be generated after install."));
    }
    log(dim("   --dry-run: nothing was installed."));
    log();
    process.exit(0);
  }

  const selectedSkills = await selectSkills(skills, autoYes);

  if (!autoYes && process.stdout.isTTY) {
    write("\x1b[H\x1b[2J\x1b[3J");
    printBanner(VERSION);
  } else {
    log();
  }

  log(cyan("   ◆ ") + bold("Installing skills..."));
  log(dim(`   Agents: ${resolvedAgents.join(", ")}`));
  log();

  const startTime = Date.now();
  const { installed, failed, errors } = await installAll(selectedSkills, resolvedAgents);
  const elapsed = Date.now() - startTime;
  let claudeSummary = null;

  if (shouldGenerateClaudeMd(resolvedAgents) && installed > 0) {
    claudeSummary = generateClaudeMd(projectDir);
  }

  if (process.stdout.isTTY) {
    const up = selectedSkills.length + 2;
    write(`\x1b[${up}A\r\x1b[K`);
    log(green("   ◆ ") + bold("Done!"));
    write(`\x1b[${selectedSkills.length + 1}B`);
  }

  printSummary({ installed, failed, errors, elapsed, verbose });

  if (shouldGenerateClaudeMd(resolvedAgents)) {
    if (claudeSummary?.generated) {
      log(
        dim(`   Claude Code summary written to CLAUDE.md (${claudeSummary.files} markdown files).`),
      );
      log();
    } else {
      log(dim("   Claude Code detected, but no markdown files were found under .claude/skills."));
      log();
    }
  }
}

main().catch((err) => {
  console.error(red(`\n   Error: ${err.message}\n`));
  process.exit(1);
});
