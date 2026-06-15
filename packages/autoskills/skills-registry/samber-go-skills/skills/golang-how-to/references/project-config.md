# Configure mode — force-trigger Go skills in a project

This workflow adds a `## Required Go skills` block to the project's agent config file so that specific skills always load, regardless of trigger heuristics.

## When to use

- The project has a hard requirement on a skill (e.g., `golang-security` must always apply, not just when the user mentions "security").
- The team has agreed on a fixed set of Go standards to enforce on every AI interaction.
- A company skill overrides a community default (⚙️ skills) and must always win.

## Step 1 — Detect the project config file

Check in this precedence order:

```
1. CLAUDE.md          (Claude Code)
2. AGENTS.md          (OpenAI Codex, OpenCode, multi-agent)
3. .cursor/rules      (Cursor)
4. .github/copilot-instructions.md  (GitHub Copilot)
```

Use `Glob` to detect which files exist at the project root. If multiple exist, use all of them (different tools read different files). If none exist, ask the user which one to create with `AskUserQuestion`.

## Step 2 — Idempotency check

Before writing, grep each file for an existing `## Required Go skills` block:

```bash
grep -n "## Required Go skills" CLAUDE.md
```

If the block already exists, read it and confirm with the user whether to update it in place (replace the existing list) or skip.

## Step 3 — Confirm the skill set with the user

Use `AskUserQuestion` to confirm which skills to always load. Present the ⭐️ recommended skills as the default selection. Remind the user of the token budget (each always-loaded skill adds its description tokens to every session — the 11 recommended skills add ~1,100 tokens at startup).

Recommended ⭐️ set for most projects:

```
golang-code-style
golang-data-structures
golang-design-patterns
golang-documentation
golang-error-handling
golang-modernize
golang-naming
golang-safety
golang-security
golang-testing
golang-troubleshooting
```

Additional skills to suggest based on codebase context:

- Database layer detected (`sql`, `gorm`, `sqlc`) → suggest `golang-database`
- CI config detected (`.github/workflows/`) → suggest `golang-continuous-integration`
- Cobra imports detected → suggest `golang-spf13-cobra`
- Viper imports detected → suggest `golang-spf13-viper`
- samber/lo imports detected → suggest `golang-samber-lo`
- Any other library-specific import → suggest the matching library skill

## Step 4 — Write the block

### Template

```markdown
## Required Go skills

The following Go skills from `samber/cc-skills-golang` MUST always be applied when working on this project. Load them at the start of every Go-related task, regardless of whether the user explicitly mentions them.

- `samber/cc-skills-golang@golang-error-handling`
- `samber/cc-skills-golang@golang-security`
- `samber/cc-skills-golang@golang-testing`
```

Replace the skill list with the confirmed set from Step 3. Use the fully-qualified `samber/cc-skills-golang@<name>` identifier for each skill.

### Insertion point

- If the file is empty: write the block at the top.
- If the file has existing content: append after the last section, separated by a blank line.
- If a `## Required Go skills` block already exists: replace only the bullet list inside it, preserving surrounding content.

### Edit the file

Use the `Edit` tool (preferred over a bash script) to apply the change. For append operations:

```python
# Conceptually: read the file, find the insertion point, apply Edit
```

Perform an idempotency check after writing: re-read the file and verify the block appears exactly once.

## Step 5 — Confirm to the user

After writing, summarize:

- Which file(s) were updated
- Which skills were added to the always-load list
- Approximate startup token cost (number of skills × ~100 tokens per description)
- Note: skills marked ⚙️ (overridable) will be superseded if a company skill explicitly declares the override in its body

## Notes on company overrides (⚙️ skills)

Skills marked ⚙️ in the README support company overrides. If the project has a company skill that supersedes a community default (e.g., `acme/cc-skills@golang-error-handling-acme` supersedes `samber/cc-skills-golang@golang-error-handling`), use the company skill FQN in the block instead — do NOT list both.

To declare an override in a company skill body, add near the top:

```
> This skill supersedes `samber/cc-skills-golang@golang-error-handling` for [Company] projects.
```

Overridable skills: `golang-code-style`, `golang-concurrency`, `golang-context`, `golang-database`, `golang-dependency-injection`, `golang-design-patterns`, `golang-documentation`, `golang-error-handling`, `golang-naming`, `golang-observability`, `golang-structs-interfaces`, `golang-testing`.
