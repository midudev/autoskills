import { readFileSync } from "node:fs";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";
import { serializeList, serializeError } from "./cli-json.ts";
import type { ListJson } from "./cli-json.ts";
import { log, write } from "./colors.ts";

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
  printPath: boolean;
  /** Override the prompt file path (for tests). Normally resolved from the package layout. */
  promptPath?: string;
}

/**
 * Candidate paths for the shipped prompts/skill-selection.md.
 * When running from TypeScript sources, SUBCOMMANDS_DIR is the package root.
 * When running from the built tarball, SUBCOMMANDS_DIR is <pkg>/dist/, so we walk up one level.
 */
function resolvePromptPath(): string {
  const candidates = [
    resolve(SUBCOMMANDS_DIR, "prompts", "skill-selection.md"),
    resolve(SUBCOMMANDS_DIR, "..", "prompts", "skill-selection.md"),
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

export function runPrompt(args: RunPromptArgs): number {
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
  if (args.printPath) {
    write(promptPath + "\n");
  } else {
    write(content);
  }
  return 0;
}
