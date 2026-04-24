import { readFileSync } from "node:fs";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";
import { serializeList, serializeError, serializeInstall } from "./cli-json.ts";
import type { ListJson } from "./cli-json.ts";
import { log, write, green, red, yellow, dim } from "./colors.ts";
import { SKILLS_MAP } from "./skills-map.ts";
import { installSkill as defaultInstallSkill } from "./installer.ts";
import { copyToClipboard } from "./clipboard.ts";
import type { CopyResult } from "./clipboard.ts";

// AGENTS.md: never use console.log / process.stdout.write directly. Use log/write from colors.ts. Errors go to console.error.

const SUBCOMMANDS_DIR = dirname(fileURLToPath(import.meta.url));

export interface RunListArgs {
  json: boolean;
  filter?: string;
  version: string;
}

export function runList(args: RunListArgs): number {
  const payload = serializeList({ version: args.version, filter: args.filter });
  if (args.json) {
    write(JSON.stringify(payload, null, 2) + "\n");
    return 0;
  }
  if (payload.technologies.length === 0 && args.filter) {
    console.error(`no technologies match '${args.filter}'`);
    return 0;
  }
  for (const t of payload.technologies) {
    log(`${t.id}  ${t.name}${t.description ? ` — ${t.description}` : ""}`);
  }
  return 0;
}

export interface RunPromptArgs {
  /** Override the prompt file path (for tests). Normally resolved from the package layout. */
  promptPath?: string;
}

/**
 * Candidate paths for the shipped prompts/spec-generator-prompt.md.
 * When running from TypeScript sources, SUBCOMMANDS_DIR is the package root.
 * When running from the built tarball, SUBCOMMANDS_DIR is <pkg>/dist/, so we walk up one level.
 */
function resolvePromptPath(): string {
  const candidates = [
    resolve(SUBCOMMANDS_DIR, "prompts", "spec-generator-prompt.md"),
    resolve(SUBCOMMANDS_DIR, "..", "prompts", "spec-generator-prompt.md"),
  ];
  for (const p of candidates) {
    try {
      readFileSync(p);
      return p;
    } catch {
      continue;
    }
  }
  // Return the first candidate; readFileSync in runPrompt will surface the ENOENT uniformly.
  return candidates[0];
}

export function runPrompt(args: RunPromptArgs = {}): number {
  const promptPath = args.promptPath ?? resolvePromptPath();
  let content: string;
  try {
    content = readFileSync(promptPath, "utf-8");
  } catch (err: unknown) {
    const e = err as NodeJS.ErrnoException;
    if (e.code === "ENOENT") {
      console.error(
        JSON.stringify(
          serializeError({
            code: "prompt-file-missing",
            message: "prompt file missing from package (build issue). reinstall autoskills",
          }),
        ),
      );
      return 1;
    }
    throw err;
  }
  write(content);
  return 0;
}

// ── runCopyPrompt ────────────────────────────────────────────

export interface RunCopyPromptArgs {
  /** Override the prompt file path (for tests). */
  promptPath?: string;
  /** Inject clipboard fn (for tests). */
  copyFn?: (text: string) => Promise<CopyResult>;
  /** Override platform (for tests). */
  platform?: NodeJS.Platform;
}

export async function runCopyPrompt(args: RunCopyPromptArgs = {}): Promise<number> {
  const promptPath = args.promptPath ?? resolvePromptPath();
  let content: string;
  try {
    content = readFileSync(promptPath, "utf-8");
  } catch (err: unknown) {
    const e = err as NodeJS.ErrnoException;
    if (e.code === "ENOENT") {
      console.error(
        JSON.stringify(
          serializeError({
            code: "prompt-file-missing",
            message: "prompt file missing from package (build issue). reinstall autoskills",
          }),
        ),
      );
      return 1;
    }
    throw err;
  }

  const platform = args.platform ?? process.platform;
  const copy = args.copyFn ?? ((text: string) => copyToClipboard(text, { platform }));
  const result = await copy(content);
  const shortcut = platform === "darwin" ? "Cmd+V" : "Ctrl+V";

  if (result.ok) {
    log(green("✓ prompt copied to clipboard ") + dim(`(${content.length} chars)`));
    log(dim(`  go to your LLM chat, write your requirement, then paste below (${shortcut})`));
    return 0;
  }

  console.error(yellow(`warning: ${result.error ?? "clipboard copy failed"}. prompt printed below — pipe to your clipboard tool (e.g. 'autoskills --show-specgen-prompt | pbcopy')`));
  write(content);
  return 0;
}

// ── runInstall ────────────────────────────────────────────────

export interface InstallDeps {
  installSkill: (skillPath: string, agents: string[]) => Promise<{
    success: boolean;
    output: string;
    stderr: string;
    exitCode: number | null;
    command: string;
  }>;
}

export interface RunInstallArgs {
  only: string;
  agents: string[];
  /** Reserved for T17 interactive prompt. Non-functional in this wave. */
  autoYes: boolean;
  json: boolean;
  verbose: boolean;
  deps?: InstallDeps;
}

function levenshtein(a: string, b: string): number {
  const m = a.length;
  const n = b.length;
  const dp: number[][] = Array.from({ length: m + 1 }, () => new Array(n + 1).fill(0));
  for (let i = 0; i <= m; i++) dp[i][0] = i;
  for (let j = 0; j <= n; j++) dp[0][j] = j;
  for (let i = 1; i <= m; i++) {
    for (let j = 1; j <= n; j++) {
      dp[i][j] = a[i - 1] === b[j - 1]
        ? dp[i - 1][j - 1]
        : 1 + Math.min(dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]);
    }
  }
  return dp[m][n];
}

function suggestTechId(bad: string): string | null {
  let best: { id: string; d: number } | null = null;
  for (const t of SKILLS_MAP) {
    const d = levenshtein(bad, t.id);
    if (d <= 2 && (!best || d < best.d)) best = { id: t.id, d };
  }
  return best?.id ?? null;
}

function emitInstallError(args: {
  json: boolean;
  code: string;
  message: string;
  hint?: string;
  details?: Record<string, unknown>;
}): number {
  if (args.json) {
    write(
      JSON.stringify(
        serializeError({ code: args.code, message: args.message, hint: args.hint, details: args.details }),
      ) + "\n",
    );
  } else {
    const hint = args.hint ? ` (${args.hint})` : "";
    console.error(red(`error: ${args.message}${hint}`));
  }
  return 1;
}

export async function runInstall(args: RunInstallArgs): Promise<number> {
  if (args.only === "") {
    return emitInstallError({
      json: args.json,
      code: "install-missing-only",
      message: "'install' requires --only <ids>",
    });
  }

  const raw = args.only.trim();
  if (raw === "") {
    return emitInstallError({
      json: args.json,
      code: "install-empty-only",
      message: "--only cannot be empty",
    });
  }

  const ids = [...new Set(raw.split(",").map(s => s.trim()).filter(Boolean))];
  if (ids.length === 0) {
    return emitInstallError({
      json: args.json,
      code: "install-empty-only",
      message: "--only cannot be empty",
    });
  }

  const unknown: string[] = [];
  const validEntries: (typeof SKILLS_MAP)[number][] = [];
  for (const id of ids) {
    const tech = SKILLS_MAP.find(t => t.id === id);
    if (!tech) unknown.push(id);
    else validEntries.push(tech);
  }

  if (unknown.length > 0) {
    const firstBad = unknown[0];
    const suggestion = suggestTechId(firstBad);
    return emitInstallError({
      json: args.json,
      code: "install-unknown-id",
      message: `unknown tech id '${firstBad}'`,
      hint: suggestion ? `did you mean: ${suggestion}?` : undefined,
      details: {
        provided: firstBad,
        suggestions: suggestion ? [suggestion] : [],
        unknown_ids: unknown,
      },
    });
  }

  const skillPaths = [...new Set(validEntries.flatMap(t => t.skills))];
  const installFn = args.deps?.installSkill ?? defaultInstallSkill;

  const results = await Promise.all(
    skillPaths.map(async (p) => ({ path: p, result: await installFn(p, args.agents) })),
  );

  const installed = results.filter(r => r.result.success).map(r => ({ id: r.path, path: r.path }));
  const failed = results.filter(r => !r.result.success).map(r => ({
    id: r.path,
    error: r.result.stderr || r.result.output || "install failed",
  }));

  if (args.json) {
    write(JSON.stringify(serializeInstall({ installed, failed, agents: args.agents }), null, 2) + "\n");
  } else {
    for (const ok of installed) log(green("installed") + "  " + ok.path);
    for (const f of failed) {
      log(red("failed") + "     " + f.id);
      if (args.verbose) console.error(f.error);
    }
  }

  return failed.length > 0 ? 1 : 0;
}
