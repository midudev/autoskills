import { resolve, dirname, join } from "node:path";
import { existsSync, readFileSync } from "node:fs";
import { fileURLToPath } from "node:url";

import {
  detectTechnologies,
  detectCombos,
  collectSkills,
  detectAgents,
  getInstalledSkillNames,
  loadMarkdownSources,
  mergeMarkdownDetections,
} from "./lib.ts";
import type { SkillEntry, Technology, ComboSkill } from "./lib.ts";
import { scanMarkdown } from "./markdown-scanner.ts";
import { SKILLS_MAP } from "./skills-map.ts";
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
} from "./colors.ts";
import { printBanner, multiSelect, formatTime } from "./ui.ts";
import { installAll, resolveSkillsBin } from "./installer.ts";
import { cleanupClaudeMd } from "./claude.ts";
import { runList, runPrompt, runInstall, runCopyPrompt } from "./subcommands.ts";
import { serializeDryRun, serializeError } from "./cli-json.ts";

const __dirname = dirname(fileURLToPath(import.meta.url));
const VERSION: string = (() => {
  for (const base of [__dirname, resolve(__dirname, "..")]) {
    const p = join(base, "package.json");
    if (!existsSync(p)) continue;
    try {
      const pkg = JSON.parse(readFileSync(p, "utf-8"));
      if (pkg.name === "autoskills") return pkg.version;
    } catch {}
  }
  return "0.0.0";
})();

process.on("SIGINT", () => {
  write(SHOW_CURSOR + "\n");
  process.exit(130);
});

// ── CLI ──────────────────────────────────────────────────────

class ArgError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "ArgError";
  }
}

interface CliArgs {
  autoYes: boolean;
  dryRun: boolean;
  verbose: boolean;
  help: boolean;
  agents: string[];
  fromSpec?: string;
  scanDocs: boolean;
  copyPrompt: boolean;
  // subcommand dispatch
  subcommand?: string;
  json: boolean;
  only?: string;
  filter?: string;
  promptPath: boolean;
}

function parseArgs(): CliArgs {
  const args = process.argv.slice(2);
  const subcommand = args[0] && !args[0].startsWith("-") ? args[0] : undefined;
  const consumed = new Set<number>();
  if (subcommand !== undefined) consumed.add(0);

  const agents: string[] = [];
  const agentIdx = args.findIndex((a) => a === "-a" || a === "--agent");
  if (agentIdx !== -1) {
    consumed.add(agentIdx);
    for (let i = agentIdx + 1; i < args.length; i++) {
      if (args[i].startsWith("-")) break;
      agents.push(args[i]);
      consumed.add(i);
    }
  }

  const fromSpecIdx = args.findIndex((a) => a === "--from-spec");
  let fromSpec: string | undefined;
  if (fromSpecIdx !== -1) {
    consumed.add(fromSpecIdx);
    const next = args[fromSpecIdx + 1];
    if (!next || next.startsWith("-")) {
      throw new ArgError("--from-spec requires a path argument");
    }
    fromSpec = next;
    consumed.add(fromSpecIdx + 1);
  }

  const onlyIdx = args.findIndex((a) => a === "--only");
  let only: string | undefined;
  if (onlyIdx !== -1) {
    consumed.add(onlyIdx);
    const next = args[onlyIdx + 1];
    if (!next || next.startsWith("-")) {
      throw new ArgError("--only requires a value");
    }
    only = next;
    consumed.add(onlyIdx + 1);
  }

  const filterIdx = args.findIndex((a) => a === "--filter");
  let filter: string | undefined;
  if (filterIdx !== -1) {
    consumed.add(filterIdx);
    const next = args[filterIdx + 1];
    if (!next || next.startsWith("-")) {
      throw new ArgError("--filter requires a value");
    }
    filter = next;
    consumed.add(filterIdx + 1);
  }

  // Implicit filter: `autoskills list <id>` is equivalent to `autoskills list --filter <id>`.
  // Scan for the first unconsumed non-flag token after the subcommand.
  if (subcommand === "list" && filter === undefined) {
    for (let i = 1; i < args.length; i++) {
      if (consumed.has(i)) continue;
      if (args[i].startsWith("-")) continue;
      filter = args[i];
      break;
    }
  }

  return {
    autoYes: args.includes("-y") || args.includes("--yes"),
    dryRun: args.includes("--dry-run"),
    verbose: args.includes("--verbose") || args.includes("-v"),
    help: args.includes("--help") || args.includes("-h"),
    agents,
    fromSpec,
    scanDocs: args.includes("--scan-docs"),
    copyPrompt: args.includes("--copy-prompt"),
    subcommand,
    json: args.includes("--json"),
    only,
    filter,
    promptPath: args.includes("--path"),
  };
}

function showHelp(): void {
  log(`
  ${bold("autoskills")} — Auto-install the best AI skills for your project

  ${bold("Usage:")}
    npx autoskills                              Detect & install skills
    npx autoskills ${dim("-y")}                            Skip confirmation
    npx autoskills ${dim("--dry-run")} ${dim("[--json]")}            Show what would be installed
    npx autoskills ${dim("-a cursor claude-code")}          Install for specific IDEs only
    npx autoskills ${dim("list")} ${dim("[--json] [--filter <id>]")}  List catalog
    npx autoskills ${dim("prompt")} ${dim("[--path]")}               Print spec-generator prompt
    npx autoskills ${dim("--copy-prompt")}                  Copy spec-generator prompt to clipboard
    npx autoskills ${dim("install --only <ids>")} ${dim("[-a agents] [-y] [--json]")}

  ${bold("Options:")}
    -y, --yes           Skip confirmation prompt
    --dry-run           Show skills without installing
    -v, --verbose       Show error details on failure
    -a, --agent         Install for specific IDEs only (e.g. cursor, claude-code)
    --from-spec <path>  Detect tech from a markdown spec file
    --scan-docs         Auto-scan CLAUDE.md / AGENTS.md in project root
    --copy-prompt       Copy spec-generator prompt to clipboard
    --json              JSON output (subcommands / dry-run)
    --only <ids>        Comma-separated tech ids for 'install'
    --filter <id>       Filter catalog for 'list'
    --path              Print prompt file path (for 'prompt')
    -h, --help          Show this help message
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

  return `${gray(author)} ${gray("›")} ${cyan(bold(skillName))}`;
}

function printSkillsList(skills: SkillEntry[]): void {
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
      if (!verbose) {
        log();
        log(dim("   Run with --verbose to see full error details."));
      }
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
  const labelCache = new Map<string, { label: string; styledLabel: string }>();
  for (const s of skills) {
    labelCache.set(s.skill, {
      label: formatSkillLabel(s.skill),
      styledLabel: formatSkillLabel(s.skill, { styled: true }),
    });
  }
  const maxEffective = Math.max(
    ...skills.map((s) => {
      const len = labelCache.get(s.skill)!.label.length;
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
      const { label, styledLabel } = labelCache.get(s.skill)!;
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
  const args = parseArgs();
  const { autoYes, dryRun, verbose, help, agents, fromSpec, scanDocs } = args;

  if (help) {
    showHelp();
    process.exit(0);
  }

  if (args.copyPrompt) {
    const code = await runCopyPrompt();
    process.exit(code);
  }

  // ── Subcommand dispatch (BEFORE any default-flow side-effects) ──
  if (args.subcommand !== undefined) {
    const KNOWN = new Set(["list", "prompt", "install"]);
    if (!KNOWN.has(args.subcommand)) {
      const msg = {
        code: "unknown-subcommand",
        message: `unknown subcommand '${args.subcommand}'`,
        hint: "run 'autoskills --help'",
      };
      if (args.json) {
        write(JSON.stringify(serializeError(msg)) + "\n");
      } else {
        console.error(red(`   error: ${msg.message}. ${msg.hint}`));
      }
      process.exit(1);
    }
    let code = 0;
    switch (args.subcommand) {
      case "list":
        code = runList({ json: args.json, filter: args.filter, version: VERSION });
        break;
      case "prompt":
        code = runPrompt({ printPath: args.promptPath });
        break;
      case "install":
        code = await runInstall({
          only: args.only ?? "",
          agents: args.agents,
          autoYes: args.autoYes,
          json: args.json,
          verbose: args.verbose,
        });
        break;
    }
    process.exit(code);
  }

  // MUST stay before any write() to stdout when args.json is true. Any new branch added
  // between dispatch and this gate could leak banner/detection output and break JSON consumers.
  if (args.json && !args.dryRun) {
    const msg = {
      code: "json-requires-subcommand-or-dry-run",
      message: "--json requires a subcommand (list/prompt/install) or --dry-run",
    };
    write(JSON.stringify(serializeError(msg)) + "\n");
    process.exit(1);
  }

  if (!args.json) {
    printBanner(VERSION);
  }

  const projectDir = resolve(".");

  if (!args.json) {
    write(dim("   Scanning project...\r"));
  }
  const core = detectTechnologies(projectDir);
  if (!args.json) {
    write("\x1b[K");
  }

  // Merge markdown-scanner results (opt-in) — default path unchanged.
  let detected: Technology[] = core.detected;
  let combos: ComboSkill[] = core.combos;
  let isFrontend = core.isFrontend;

  if (fromSpec || scanDocs) {
    const sources = loadMarkdownSources({
      fromSpec,
      scanDocs,
      projectDir,
    });
    if (scanDocs && !fromSpec && sources.length === 0) {
      console.error(yellow("   warning: no CLAUDE.md, AGENTS.md, or README.md found"));
    }
    if (sources.length > 0) {
      const mdMatches = sources.flatMap(s => scanMarkdown(s.content, SKILLS_MAP));
      const coreIds = core.detected.map(t => t.id);
      const mergedIds = mergeMarkdownDetections(coreIds, mdMatches);
      // mergeMarkdownDetections only appends; length !== means scanner contributed new ids.
      if (mergedIds.length !== coreIds.length) {
        detected = mergedIds
          .map(id => SKILLS_MAP.find(t => t.id === id))
          .filter((t): t is Technology => t !== undefined);
        combos = detectCombos(mergedIds);
        // isFrontend stays as core.isFrontend — core's heuristic is file-system based, not ID-based
      }
    }
  }

  if (detected.length === 0 && !isFrontend) {
    if (!args.json) {
      log(yellow("   ⚠ No supported technologies detected."));
      log(dim("   Make sure you run this in a project directory."));
      log();
    }
    process.exit(0);
  }

  if (!args.json) {
    printDetected(detected, combos, isFrontend);
  }

  const installedNames = getInstalledSkillNames(projectDir);
  const skills = collectSkills({ detected, isFrontend, combos, installedNames });
  const resolvedAgents = agents.length > 0 ? agents : detectAgents();

  if (skills.length === 0) {
    if (!args.json) {
      log(yellow("   No skills available for your stack yet."));
      log(dim("   Check https://skills.sh for the latest."));
      log();
    }
    process.exit(0);
  }

  if (!dryRun) {
    setImmediate(resolveSkillsBin);
  }

  if (dryRun) {
    if (args.json) {
      const payload = serializeDryRun({
        detected_technologies: detected.map((t) => t.id),
        detected_combos: combos.map((c) => c.id),
        is_frontend: isFrontend,
        skills_resolved: skills.map((s) => ({
          id: s.skill,
          path: s.skill,
          source_tech: s.sources[0] ?? "",
          installed: s.installed,
        })),
        agents_detected: resolvedAgents,
      });
      write(JSON.stringify(payload, null, 2) + "\n");
      return;
    }
    printSkillsList(skills);
    log(dim(`   Agents: ${resolvedAgents.join(", ")}`));
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
  const claudeCleanup = cleanupClaudeMd(projectDir);

  if (process.stdout.isTTY) {
    const up = selectedSkills.length + 2;
    write(`\x1b[${up}A\r\x1b[K`);
    log(green("   ◆ ") + bold("Done!"));
    write(`\x1b[${selectedSkills.length + 1}B`);
  }

  printSummary({ installed, failed, errors, elapsed, verbose });

  if (claudeCleanup.cleaned) {
    if (claudeCleanup.deleted) {
      log(dim("   Removed autoskills section from CLAUDE.md (file was empty, deleted)."));
    } else {
      log(dim("   Removed autoskills section from CLAUDE.md."));
    }
    log();
  }
}

main().catch((err: Error) => {
  const isArgError = err instanceof ArgError;
  if (process.argv.includes("--json")) {
    write(JSON.stringify(serializeError({
      code: isArgError ? "cli-arg-invalid" : "internal-error",
      message: err.message,
    })) + "\n");
  } else {
    console.error(red(`\n   Error: ${err.message}\n`));
  }
  process.exit(1);
});
