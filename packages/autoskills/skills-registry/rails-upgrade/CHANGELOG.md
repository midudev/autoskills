# Changelog

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
