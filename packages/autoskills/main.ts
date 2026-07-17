import { existsSync, readFileSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { createInterface } from "node:readline";
import { fileURLToPath } from "node:url";

import { cleanupClaudeMd } from "./claude.ts";
import {
  bold,
  cyan,
  dim,
  gray,
  green,
  log,
  magenta,
  muted,
  pink,
  red,
  SHOW_CURSOR,
  write,
  yellow,
} from "./colors.ts";
import type { InstallSecurityCheck } from "./installer.ts";
import {
  clearAutoskillsCache,
  installAll,
  loadRegistry,
  removeSkill,
  securityCheckForSkillPath,
} from "./installer.ts";
import type { ComboSkill, SkillEntry, Technology } from "./lib.ts";
import { collectSkills, detectAgents, detectTechnologies, getInstalledSkillNames } from "./lib.ts";
import { formatTime, multiSelect, printBanner } from "./ui.ts";

const __dirname = dirname(fileURLToPath(import.meta.url));
const VERSION: string = (() => {
  for (const base of [__dirname, resolve(__dirname, "..")]) {
    const p = join(base, "package.json");
    if (!existsSync(p)) continue;
    try {
      const pkg = JSON.parse(readFileSync(p, "utf-8"));
      if (pkg.name === "autoskills") return pkg.version;
    } catch { }
  }
  return "0.0.0";
})();
const ISSUES_URL = "https://github.com/midudev/autoskills/issues";

process.on("SIGINT", () => {
  write(SHOW_CURSOR + "\n");
  process.exit(130);
});

// ── CLI ──────────────────────────────────────────────────────

interface CliArgs {
  autoYes: boolean;
  dryRun: boolean;
  verbose: boolean;
  help: boolean;
  clearCache: boolean;
  agents: string[];
  remove: string | undefined;
}

function parseArgs(): CliArgs {
  const args = process.argv.slice(2);
  const agents: string[] = [];
  const agentIdx = args.findIndex((a) => a === "-a" || a === "--agent");
  if (agentIdx !== -1) {
    for (let i = agentIdx + 1; i < args.length; i++) {
      if (args[i].startsWith("-")) break;
      agents.push(args[i]);
    }
  }

  const removeIdx = args.findIndex((a) => a === "remove" || a === "rm");
  let remove: string | undefined = undefined;
  if (removeIdx !== -1) {
    remove = args[removeIdx + 1] || "";
    if (remove && remove.startsWith("-")) {
      remove = "";
    }
  }

  return {
    autoYes: args.includes("-y") || args.includes("--yes"),
    dryRun: args.includes("--dry-run"),
    verbose: args.includes("--verbose") || args.includes("-v"),
    help: args.includes("--help") || args.includes("-h"),
    clearCache: args.includes("--clear-cache"),
    agents,
    remove,
  };
}

function showHelp(): void {
  log(`
  ${bold("autoskills")} — Auto-install the best AI skills for your project

  ${bold("Usage:")}
    npx autoskills                   Detect & install skills
    npx autoskills ${dim("-y")}                   Skip confirmation
    npx autoskills ${dim("--dry-run")}            Show what would be installed
    npx autoskills ${dim("--clear-cache")}        Clear downloaded skills cache
    npx autoskills ${dim("-a cursor claude-code")} Install for specific IDEs only
    npx autoskills ${dim("remove <skill>")}        Remove an installed skill
    npx autoskills ${dim("rm <skill>")}            Alias for remove

  ${bold("Options:")}
    -y, --yes       Skip confirmation prompt
    --dry-run       Show skills without installing
    --clear-cache   Clear downloaded skills cache
    -v, --verbose   Show install trace and error details
    -a, --agent     Install for specific IDEs only (e.g. cursor, claude-code)
    -h, --help      Show this help message
`);
}

// ── Display ──────────────────────────────────────────────────

function printDetected(detected: Technology[], combos: ComboSkill[], isFrontend: boolean): void {
  if (detected.length > 0) {
    const withSkills = detected.filter((t) => t.skills.length > 0);
    const withoutSkills = detected.filter((t) => t.skills.length === 0);
    const allTech = [...withSkills, ...withoutSkills];

    log(cyan("   ◆ ") + bold("Detected technologies:"));
    log();

    const COLS = 3;
    const colWidth = Math.max(...allTech.map((t) => t.name.length)) + 3;

    const formatTech = (tech: Technology): string => {
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

function formatSkillLabel(skill: string, { styled = false }: { styled?: boolean } = {}): string {
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

  return `${muted(author)} ${gray("›")} ${cyan(bold(skillName))}`;
}

function securityWarningForSkill(skill: string): string | null {
  const check = securityCheckForSkillPath(skill);
  if (check?.status !== "warning") return null;

  const findings = check.findings.map((finding) => finding.trim()).filter(Boolean);
  const detail = [check.summary.trim(), findings.join("; ")].filter(Boolean).join(" ");
  return detail || "The sync review found issues that should be checked.";
}

function printSkillsList(skills: SkillEntry[]): void {
  const INSTALLED_TAG = " (installed)";
  const SECURITY_TAG = " (security check ⚠)";
  const entries = skills.map((s) => ({
    ...s,
    label: formatSkillLabel(s.skill),
    styledLabel: formatSkillLabel(s.skill, { styled: true }),
    hasSecurityWarning: Boolean(securityWarningForSkill(s.skill)),
  }));
  const maxEffective = Math.max(
    ...entries.map(
      (e) =>
        e.label.length +
        (e.installed ? INSTALLED_TAG.length : 0) +
        (e.hasSecurityWarning ? SECURITY_TAG.length : 0),
    ),
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
    const { label, styledLabel, sources, installed, hasSecurityWarning } = entries[i];
    const techSources = sources.filter((s) => !s.includes(" + "));
    const installedTag = installed ? dim(INSTALLED_TAG) : "";
    const securityTag = hasSecurityWarning ? yellow(SECURITY_TAG) : "";
    const effectiveLen =
      label.length +
      (installed ? INSTALLED_TAG.length : 0) +
      (hasSecurityWarning ? SECURITY_TAG.length : 0);
    const pad = " ".repeat(maxEffective - effectiveLen);
    const num = String(i + 1).padStart(2, " ");
    const sourceSuffix = techSources.length > 0 ? `  ${dim(`← ${techSources.join(", ")}`)}` : "";
    log(dim(`   ${num}.`) + ` ${styledLabel}${installedTag}${securityTag}${pad}${sourceSuffix}`);
  }
  log();
}

function stripAnsi(str: string): string {
  // eslint-disable-next-line no-control-regex
  return str.replace(/\x1b\[[0-9;]*m/g, "");
}

function extractErrorLines(stderr: string, output: string): string[] {
  const raw = stderr?.trim() || output?.trim() || "";
  const noisePatterns = [
    /^npm\s+(warn|notice|http)\b/i,
    /^npm\s+error\s*$/i,
    /^\s*$/,
    /^>\s/,
    /^added\s+\d+\s+packages/i,
    /^up to date/i,
    /^npm error A complete log of this run/i,
    /^npm error\s+[\w/\\:.-]+debug-\d+\.log$/i,
  ];

  return stripAnsi(raw)
    .split("\n")
    .map((l) => l.trim())
    .filter((l) => l && !noisePatterns.some((p) => p.test(l)));
}

function briefErrorReason(stderr: string, output: string): string {
  const lines = extractErrorLines(stderr, output);
  if (lines.length === 0) return "Unknown error";
  const line = lines[0];
  return line.length > 80 ? line.slice(0, 77) + "..." : line;
}

function visiblePad(value: string, width: number): string {
  return value + " ".repeat(Math.max(0, width - stripAnsi(value).length));
}

function truncateVisible(value: string, width: number): string {
  const plain = stripAnsi(value);
  if (plain.length <= width) return value;
  if (width <= 1) return "…";
  return plain.slice(0, width - 1) + "…";
}

function wrapText(value: string, width: number): string[] {
  if (width <= 0) return [value];
  const words = value.trim().split(/\s+/).filter(Boolean);
  if (words.length === 0) return [""];

  const lines: string[] = [];
  let line = "";
  for (const word of words) {
    if (word.length > width) {
      if (line) {
        lines.push(line);
        line = "";
      }
      for (let i = 0; i < word.length; i += width) {
        lines.push(word.slice(i, i + width));
      }
      continue;
    }

    const next = line ? `${line} ${word}` : word;
    if (next.length > width) {
      lines.push(line);
      line = word;
    } else {
      line = next;
    }
  }

  if (line) lines.push(line);
  return lines;
}

function formatSecurityFindings(check: InstallSecurityCheck): string | null {
  const findings = check.findings.map((finding) => finding.trim()).filter(Boolean);
  if (findings.length === 0) return null;

  const summary = check.summary.trim();
  return [summary, findings.join("; ")].filter(Boolean).join(" ");
}

function printSecurityChecks(checks: InstallSecurityCheck[]): void {
  const checksWithFindings = checks
    .map((check) => ({ check, findings: formatSecurityFindings(check) }))
    .filter((entry): entry is { check: InstallSecurityCheck; findings: string } =>
      Boolean(entry.findings),
    );
  if (checksWithFindings.length === 0) return;

  const sorted = checksWithFindings.sort((a, b) => a.check.name.localeCompare(b.check.name));
  const skillWidth = Math.min(34, Math.max(5, ...sorted.map(({ check }) => check.name.length)));
  const checkWidth = 7;
  const terminalWidth = process.stdout.columns || 100;
  const findingsWidth = Math.max(40, terminalWidth - skillWidth - checkWidth - 16);

  log();
  log(cyan("   ◆ ") + bold("Security checks"));
  log();
  log(
    dim(
      `   | ${visiblePad("Skill", skillWidth)} | ${visiblePad("Check", checkWidth)} | ${visiblePad("Findings", findingsWidth)} |`,
    ),
  );
  log(
    dim(
      `   | ${"-".repeat(skillWidth)} | ${"-".repeat(checkWidth)} | ${"-".repeat(findingsWidth)} |`,
    ),
  );

  for (const { check, findings } of sorted) {
    const status = check.status === "warning" ? yellow("warning") : green("ok");
    const lines = wrapText(findings, findingsWidth);
    log(
      `   | ${visiblePad(truncateVisible(check.name, skillWidth), skillWidth)} | ${visiblePad(status, checkWidth)} | ${visiblePad(lines[0], findingsWidth)} |`,
    );
    for (const line of lines.slice(1)) {
      log(
        `   | ${visiblePad("", skillWidth)} | ${visiblePad("", checkWidth)} | ${visiblePad(line, findingsWidth)} |`,
      );
    }
  }
}

interface SummaryOptions {
  installed: number;
  failed: number;
  errors: {
    name: string;
    output: string;
    stderr: string;
    exitCode: number | null;
    command: string;
  }[];
  elapsed: number;
  verbose: boolean;
}

function printSummary({ installed, failed, errors, elapsed, verbose }: SummaryOptions): void {
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
      for (const { name, output, stderr, exitCode, command } of errors) {
        log(red(`     ✘ ${name}`));

        if (verbose) {
          if (exitCode !== undefined && exitCode !== null) {
            log(dim(`       exit code ${exitCode}`));
          }

          const errorLines = extractErrorLines(stderr, output);
          if (errorLines.length > 0) {
            log();
            for (const line of errorLines.slice(0, 20)) {
              log(dim(`       ${line}`));
            }
            if (errorLines.length > 20) {
              log(dim(`       … (${errorLines.length - 20} more lines)`));
            }
          }

          if (command) {
            log();
            log(dim(`       command: ${command}`));
          }
          log();
        } else {
          const reason = briefErrorReason(stderr, output);
          log(dim(`       ${reason}`));
        }
      }
      log();
      if (!verbose) {
        log(dim("   Run again with --verbose to see the full error details."));
      }
      log(dim(`   If it looks like an autoskills bug, please create an issue: ${ISSUES_URL}`));
    }
  }

  log();
  log(pink("   Enjoyed autoskills? Consider sponsoring → https://github.com/sponsors/midudev"));
  log();
}

// ── Skill Selection ──────────────────────────────────────────

async function selectSkills(skills: SkillEntry[], autoYes: boolean): Promise<SkillEntry[]> {
  if (autoYes) {
    printSkillsList(skills);
    return skills;
  }

  const INSTALLED_TAG = " (installed)";
  const SECURITY_TAG = " (security check ⚠)";
  const labelCache = new Map<
    string,
    { label: string; styledLabel: string; hasSecurityWarning: boolean }
  >();
  for (const s of skills) {
    labelCache.set(s.skill, {
      label: formatSkillLabel(s.skill),
      styledLabel: formatSkillLabel(s.skill, { styled: true }),
      hasSecurityWarning: Boolean(securityWarningForSkill(s.skill)),
    });
  }
  const maxEffective = Math.max(
    ...skills.map((s) => {
      const cached = labelCache.get(s.skill)!;
      return (
        cached.label.length +
        (s.installed ? INSTALLED_TAG.length : 0) +
        (cached.hasSecurityWarning ? SECURITY_TAG.length : 0)
      );
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
      const { label, styledLabel, hasSecurityWarning } = labelCache.get(s.skill)!;
      const installedTag = s.installed ? " " + dim("(installed)") : "";
      const securityTag = hasSecurityWarning ? yellow(SECURITY_TAG) : "";
      const effectiveLen =
        label.length +
        (s.installed ? INSTALLED_TAG.length : 0) +
        (hasSecurityWarning ? SECURITY_TAG.length : 0);
      return styledLabel + installedTag + securityTag + " ".repeat(maxEffective - effectiveLen);
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
          { key: "n", label: "new", fn: (items: SkillEntry[]) => items.map((s) => !s.installed) },
          {
            key: "i",
            label: "installed",
            fn: (items: SkillEntry[]) => items.map((s) => s.installed),
          },
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

async function main(): Promise<void> {
  const { autoYes, dryRun, verbose, help, clearCache, agents, remove } = parseArgs();

  if (help) {
    showHelp();
    process.exit(0);
  }

  if (clearCache) {
    const { cacheDir, removed } = clearAutoskillsCache();
    log(
      removed
        ? green(`   ✔ Cleared autoskills cache: ${cacheDir}`)
        : dim(`   No autoskills cache found: ${cacheDir}`),
    );
    log();
    process.exit(0);
  }

  if (remove !== undefined) {
    const projectDir = resolve(".");
    const installedNames = getInstalledSkillNames(projectDir);

    if (installedNames.size === 0) {
      log(dim("   No skills installed."));
      log();
      process.exit(0);
    }

    if (remove === "") {
      const installedList = [...installedNames].sort();
      log(cyan("   ◆ ") + bold(`Select skills to remove `) + dim(`(${installedList.length} installed)`));
      log();

      let selected: string[];
      if (process.stdin.isTTY) {
        selected = await multiSelect(installedList, {
          labelFn: (name) => name,
          initialSelected: Array(installedList.length).fill(false),
          shortcuts: [],
        });
      } else {
        selected = [];
      }

      if (selected.length === 0) {
        log();
        log(dim("   Nothing selected."));
        log();
        process.exit(0);
      }

      if (!autoYes) {
        const rl = createInterface({ input: process.stdin, output: process.stdout });
        const answer = await new Promise<string>((resolve) => {
          rl.question(
            `   Remove ${selected.length} skill${selected.length !== 1 ? "s" : ""}? ${dim("[y/N]")} `,
            (ans: string) => {
              rl.close();
              resolve(ans.trim());
            },
          );
        });
        if (answer.toLowerCase() !== "y") {
          log(dim("   Cancelled."));
          log();
          process.exit(0);
        }
      }

      for (const skillName of selected) {
        const result = removeSkill(skillName, projectDir, { dryRun });
        if (result.success) {
          log(green(`   ✔ Removed ${skillName}`));
        }
      }
      log();
      process.exit(0);
    }

    if (!installedNames.has(remove)) {
      log(dim(`   '${remove}' is not installed.`));
      log();
      process.exit(0);
    }

    if (dryRun) {
      log(dim(`   Would remove: ${remove}`));
      log();
      process.exit(0);
    }

    if (!autoYes) {
      const rl = createInterface({ input: process.stdin, output: process.stdout });
      const answer = await new Promise<string>((resolve) => {
        rl.question(
          `   Remove '${remove}'? ${dim("[y/N]")} `,
          (ans: string) => {
            rl.close();
            resolve(ans.trim());
          },
        );
      });
      if (answer.toLowerCase() !== "y") {
        log(dim("   Cancelled."));
        log();
        process.exit(0);
      }
    }

    const result = removeSkill(remove, projectDir);
    if (result.success) {
      log(green(`   ✔ Removed ${remove}`));
      log();
    }
    process.exit(0);
  }

  await printBanner(VERSION);

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
    log(dim("   Check https://autoskills.sh for the latest."));
    log();
    process.exit(0);
  }

  if (!dryRun) {
    setImmediate(loadRegistry);
  }

  if (dryRun) {
    printSkillsList(skills);
    log(dim(`   Agents: ${resolvedAgents.join(", ")}`));
    log(dim("   --dry-run: nothing was installed."));
    log();
    process.exit(0);
  }

  const selectedSkills = await selectSkills(skills, autoYes);

  log();

  log(cyan("   ◆ ") + bold("Installing skills..."));
  log(dim(`   Agents: ${resolvedAgents.join(", ")}`));
  log();

  const startTime = Date.now();
  const { installed, failed, errors, securityChecks } = await installAll(
    selectedSkills,
    resolvedAgents,
    {
      verbose,
    },
  );
  const elapsed = Date.now() - startTime;
  const claudeCleanup = cleanupClaudeMd(projectDir);

  if (process.stdout.isTTY && !verbose) {
    const up = selectedSkills.length + 2;
    write(`\x1b[${up}A\r\x1b[K`);
    log(green("   ◆ ") + bold("Done!"));
    write(`\x1b[${selectedSkills.length + 1}B`);
  }

  if (claudeCleanup.cleaned) {
    if (claudeCleanup.deleted) {
      log(dim("   Removed autoskills section from CLAUDE.md (file was empty, deleted)."));
    } else {
      log(dim("   Removed autoskills section from CLAUDE.md."));
    }
    log();
  }

  printSecurityChecks(securityChecks);
  printSummary({ installed, failed, errors, elapsed, verbose });
}

main().catch((err: Error) => {
  console.error(red(`\n   Error: ${err.message}\n`));
  process.exit(1);
});
