import { existsSync, readFileSync, unlinkSync, writeFileSync } from "node:fs";
import { join } from "node:path";

const SECTION_START = "<!-- autoskills:start -->";
const SECTION_END = "<!-- autoskills:end -->";

export interface CleanupResult {
  cleaned: boolean;
  deleted: boolean;
}

export function cleanupClaudeMd(projectDir: string): CleanupResult {
  const outputPath = join(projectDir, "CLAUDE.md");

  if (!existsSync(outputPath)) {
    return { cleaned: false, deleted: false };
  }

  const existing = readFileSync(outputPath, "utf-8");
  const startIdx = existing.indexOf(SECTION_START);
  const endIdx = existing.indexOf(SECTION_END);

  if (startIdx === -1 || endIdx === -1) {
    return { cleaned: false, deleted: false };
  }

  const before = existing.slice(0, startIdx);
  const after = existing.slice(endIdx + SECTION_END.length);
  const remaining = (before + after).replace(/\n{3,}/g, "\n\n").trim();

  if (!remaining || remaining === "# CLAUDE.md") {
    unlinkSync(outputPath);
    return { cleaned: true, deleted: true };
  }

  writeFileSync(outputPath, remaining + "\n");
  return { cleaned: true, deleted: false };
}
