# Changelog

## v3.3.0, 28 April 2026
- Added `upgrade-cleanup` companion plugin for finishing a Rails upgrade campaign. Removes dual-boot scaffolding, drops `NextRails.next?` / `NextRails.current?` branches, retires stale monkey-patches and version-conditional code, and aligns CI matrix / Dockerfile / Ruby pin to the new version baseline. Lives as a sibling plugin in this repo (`upgrade-cleanup/.claude-plugin/plugin.json` + `upgrade-cleanup/upgrade-cleanup/SKILL.md` + `upgrade-cleanup/upgrade-cleanup/workflows/upgrade-cleanup-workflow.md`). `load_defaults` alignment and deprecation triage stay with the rails-upgrade skill, cleanup deliberately does not duplicate them. Based on FastRuby.io's "Finishing an Upgrade" methodology. (Closes #1)
- Cleanup is **user-triggered, never automatic**. After each Rails upgrade ships, the rails-upgrade skill now mentions the cleanup option but does not run it. Between hops in a multi-hop campaign the user usually wants to keep dual-boot in place and roll straight into the next hop. Cleanup ends the campaign.
- Wired the new behavior into the rails-upgrade SKILL.md as Step 7 / Step 8 (with explicit "user-triggered, do not auto-run" framing), updated Trigger Patterns, Key Principle #16, and Success Criteria.

## v3.2.1 — 25 April 2026
- Added `bin/validate-patterns`: a small Ruby script (stdlib only) that validates every detection pattern YAML file under `rails-upgrade/detection-scripts/patterns/`. Checks that YAML parses, the top-level keys (`version`, `description`, `breaking_changes`) are present, every pattern entry has the seven required keys (`name`, `pattern`, `exclude`, `search_paths`, `explanation`, `fix`, `variable_name`), and each `pattern` / `exclude` regex compiles under Ruby Onigmo.
- Updated `CLAUDE.md` to point contributors at the script instead of the previous inline-Ruby YAML check.

## v3.2 — April 2026
- Added a **CI config check** at the end of Step 5, before opening the upgrade PR. New workflow file: `workflows/ci-sync-workflow.md`. Claude now lists every CI file in the repo, compares Ruby / Rails / service versions against the upgraded Gemfile, and stops to fix any mismatches. Addresses a real incident where a 7.1 → 7.2 upgrade PR opened with stale CI config. (Closes #41)
- Wired the check into SKILL.md Core Workflow Step 5, High-Level Workflow, Pattern 1, Quality Checklist, Key Principles, and Success Criteria so it is enforced, not just mentioned.

## v3.1 — March 2026
- Added mandatory Step 0: Verify Latest Patch Version — ensures app is on latest patch of current series before any minor/major hop
- Added latest patch versions reference table in `reference/multi-hop-strategy.md`
- Updated workflow from 4-step to 5-step process
- All request patterns now include Step 0 patch verification
- Updated Key Principles and Success Criteria to include patch verification

## v3.0
- **MAJOR:** Removed script generation - Claude now runs detection directly using tools
- Detection uses Grep, Glob, and Read tools instead of generating bash scripts
- Eliminated user round-trip (no more "run this script and share results")
- Streamlined detection from 5-step to 4-step process
- New workflow file: `workflows/direct-detection-workflow.md`
- Removed: `workflows/detection-script-workflow.md`, `examples/detection-script-only.md`

## v2.2
- Added mandatory `load_defaults` verification as Step 2 of all upgrade workflows
- If `load_defaults` is behind current Rails version, skill now:
  - Informs user of the mismatch
  - Recommends updating `load_defaults` to match current Rails BEFORE upgrading to next version
  - Asks user for confirmation before proceeding
- ~~New workflow file: `workflows/load-defaults-verification-workflow.md`~~ (removed in v3.0 — replaced by external `rails-load-defaults` skill dependency)

## v2.1
- Added mandatory test suite verification as Step 1 of all upgrade workflows
- Upgrade process now BLOCKS if any tests fail
- New workflow file: `workflows/test-suite-verification-workflow.md`
