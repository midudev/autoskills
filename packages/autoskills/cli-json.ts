import type { Technology, ComboSkill } from "./skills-map.ts";
import { SKILLS_MAP, COMBO_SKILLS_MAP, FRONTEND_BONUS_SKILLS } from "./skills-map.ts";

// ── list ────────────────────────────────────────────────────

export interface ListJsonTechnology {
  id: string;
  name: string;
  aliases: string[];
  description?: string;
  skills: string[];
}

export interface ListJsonCombo {
  id: string;
  name: string;
  requires: string[];
  skills: string[];
}

export interface ListJson {
  version: string;
  technologies: ListJsonTechnology[];
  combos: ListJsonCombo[];
  frontend_bonus: string[];
}

export function serializeList(args: { version: string; filter?: string }): ListJson {
  const filter = args.filter?.trim().toLowerCase();
  const techs = filter
    ? SKILLS_MAP.filter(t =>
        t.id.toLowerCase() === filter ||
        t.name.toLowerCase() === filter ||
        (t.aliases?.some(a => a.toLowerCase() === filter) ?? false),
      )
    : SKILLS_MAP;
  return {
    version: args.version,
    technologies: techs.map(t => ({
      id: t.id,
      name: t.name,
      aliases: [...(t.aliases ?? [])],
      description: t.description,
      skills: [...t.skills],
    })),
    combos: COMBO_SKILLS_MAP.map(c => ({
      id: c.id,
      name: c.name,
      requires: [...c.requires],
      skills: [...c.skills],
    })),
    frontend_bonus: [...FRONTEND_BONUS_SKILLS],
  };
}

// ── dry-run ─────────────────────────────────────────────────

export interface DryRunSkill {
  id: string;
  path: string;
  source_tech: string;
  installed: boolean;
}

export interface DryRunJson {
  detected_technologies: string[];
  detected_combos: string[];
  is_frontend: boolean;
  skills_resolved: DryRunSkill[];
  agents_detected: string[];
}

export function serializeDryRun(data: DryRunJson): DryRunJson {
  return data;
}

// ── install ─────────────────────────────────────────────────

export interface InstallJson {
  installed: { id: string; path: string }[];
  failed: { id: string; error: string }[];
  agents: string[];
}

export function serializeInstall(data: InstallJson): InstallJson {
  return data;
}

// ── error ───────────────────────────────────────────────────

export interface ErrorEnvelope {
  code: string;
  message: string;
  hint?: string;
  details?: Record<string, unknown>;
}

export interface ErrorJson {
  error: ErrorEnvelope;
}

export function serializeError(err: ErrorEnvelope): ErrorJson {
  return { error: err };
}
