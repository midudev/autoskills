import { createInterface } from "node:readline";

import { bold, dim, yellow } from "./colors.ts";
import { parseSkillPath } from "./lib.ts";
import type { SkillEntry } from "./lib.ts";

// ── Symmetric Selection Helpers ──────────────────────────────
//
// These power the default picker's symmetric checkbox semantics:
// checked = "I want this installed", unchecked installed = "remove it".
// Kept in their own module so tests can import them without executing
// main.ts's top-level CLI bootstrap.

export interface SkillChanges {
  /** Not previously installed and currently checked. */
  installs: SkillEntry[];
  /**
   * Bare last-segment names of skills to remove — the same form used as
   * keys in `skills-lock.json` and accepted by `uninstallSkill`. Derived
   * from `SkillEntry.skill` via `parseSkillPath().skillName`. Empty-string
   * names (e.g. raw URL skills with no parseable name) are dropped.
   */
  removes: string[];
  /** Previously installed and still checked — left alone. */
  keeps: SkillEntry[];
  /** Not installed and unchecked — ignored. */
  skips: SkillEntry[];
}

export function computeChanges(skills: SkillEntry[], selected: boolean[]): SkillChanges {
  if (skills.length !== selected.length) {
    throw new Error(
      `selected length (${selected.length}) must match skills length (${skills.length})`,
    );
  }
  const installs: SkillEntry[] = [];
  const removes: string[] = [];
  const keeps: SkillEntry[] = [];
  const skips: SkillEntry[] = [];
  for (let i = 0; i < skills.length; i++) {
    const s = skills[i];
    const checked = selected[i];
    if (s.installed && checked) keeps.push(s);
    else if (s.installed && !checked) {
      const { skillName } = parseSkillPath(s.skill);
      if (skillName) removes.push(skillName);
    } else if (!s.installed && checked) installs.push(s);
    else skips.push(s);
  }
  return { installs, removes, keeps, skips };
}

export async function confirmDestructive(
  installs: number,
  removes: number,
  opts: {
    autoYes?: boolean;
    input?: NodeJS.ReadableStream;
    output?: NodeJS.WritableStream;
  } = {},
): Promise<boolean> {
  if (removes === 0) return true;
  if (opts.autoYes) return true;

  const out = opts.output ?? process.stdout;
  const noun = `skill${removes === 1 ? "" : "s"}`;
  out.write("\n");
  out.write(yellow(`   ⚠ About to install ${installs} and remove ${removes} ${noun}.`) + "\n");
  out.write(`   ${bold("Continue?")} ${dim("[y/N]")} `);

  const input = opts.input ?? process.stdin;
  const rl = createInterface({ input, output: out, terminal: false });
  return new Promise<boolean>((resolve) => {
    rl.once("line", (answer) => {
      rl.close();
      const trimmed = answer.trim();
      resolve(trimmed === "y" || trimmed === "Y");
    });
  });
}
