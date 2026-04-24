# Migration Report Template

After migration (whether successful or not), write a comprehensive `MIGRATION_REPORT.md` in the project root. This document serves both as human-readable documentation and as structured input for AI agents analyzing the migration.

## Template

```markdown
# Migration Report: CocoaPods to SwiftPM Import

**Project:** <project name>
**Module migrated:** <module name>
**Date:** <YYYY-MM-DD>
**Kotlin version:** <old version> → <new version>
**Status:** <Completed successfully | Completed with workarounds | Failed — see Errors>

---

## Pre-Migration State

### CocoaPods Dependencies

| Pod | Version | Mode | Notes |
|-----|---------|------|-------|
| <PodName> | <version> | Regular / linkOnly | <e.g., cinterop used in Kotlin code> |

### Framework Configuration

- **baseName:** <name>
- **isStatic:** <true/false> → <true/false after migration>
- **Deployment target:** <version>

### Kotlin Files Using `cocoapods.*` Imports

| File | Imports |
|------|---------|
| <path> | `cocoapods.<Module>.<Class>`, ... |

### Non-KMP CocoaPods

<List any pods in Podfile not managed by KMP, or "None">

### Atypical Project Configuration

<Document anything unusual found in Phase 1 that required special handling:
EmbedAndSign disablers, commented-out build phases, custom Gradle tasks
hooking into CocoaPods, non-standard framework configs, missing `group`
property, etc. If nothing unusual, write "Standard configuration.">

---

## Migration Steps

### Phase 2: Gradle Configuration

<List exact changes made to settings.gradle.kts, libs.versions.toml,
root build.gradle.kts, gradle.properties. Include before/after snippets
for non-trivial changes.>

### Phase 3: swiftPMDependencies

<Show the complete `swiftPMDependencies {}` block added.
Document decisions: why `discoverModulesImplicitly = false`,
which `importedClangModules` were chosen and why, framework search
paths added, static/dynamic choice, etc.>

### Phase 4: Import Transformations

<Table of import changes. Clearly mark any preserved `cocoapods.*` imports.>

| File | Before | After | Source |
|------|--------|-------|--------|
| <path> | `cocoapods.<Mod>.<Cls>` | `swiftPMImport.<grp>.<mod>.<Cls>` | swiftPMImport cinterop |
| <path> | `cocoapods.<Mod>.<Cls>` | `cocoapods.<Mod>.<Cls>` (unchanged) | <library> bundled klib |

### Phase 5: iOS Project Reconfiguration

<Document: Option A or B, integration commands run, sandboxing fix,
Crashlytics dSYM script update, any manual pbxproj edits.>

### Phase 6: CocoaPods Removal

<List everything removed: plugin, cocoapods block, gradle.properties
entries, custom tasks, podspec files, Podfile changes.>

### Phase 7: Verification

<Build commands run and their outcomes. Include the final successful
build command or note that verification was deferred to the user.>

---

## Errors Encountered

<For each error, use this structure:>

### Error #N: <Short title>

**Phase:** <which phase>
**Symptom:** <exact error message or behavior>
**Root cause:** <why it happened>
**Fix:** <what was done to resolve it>
**Generalizable:** <Yes/No — is this likely to affect other projects?>

---

## Non-Trivial Decisions

<Document decisions that required judgment, not just following the guide:
- Why a specific `importedClangModules` list was chosen
- Why `isStatic` was changed (or kept)
- Why certain `cocoapods.*` imports were preserved
- Framework search paths added and how the product list was determined
- Any trade-offs made (e.g., disabling iOS tests)>

---

## Files Changed

<Complete list of files modified, created, or deleted during migration.
Group by type: Gradle files, Kotlin sources, Xcode project files, other.>

### Gradle Files
- <path> — <brief description of change>

### Kotlin Sources
- <path> — <brief description of change>

### Xcode Project Files
- <path> — <brief description of change>

### Created
- <path> — <what it is>

### Deleted
- <path> — <what it was>
```

## Writing Guidelines

- **Be specific.** Include actual file paths, class names, error messages. Avoid vague statements like "updated the config."
- **Show before/after.** For non-trivial changes, include code snippets of what was changed and why.
- **Explain the "why."** Every error and non-trivial decision should include root cause analysis, not just the fix.
- **Mark preserved `cocoapods.*` imports clearly.** These are the most confusing aspect of the migration for future readers — explain exactly why each one was kept and which library provides the bundled klib.
- **Flag generalizable issues.** Mark errors that are likely to affect other projects so this report can improve the migration tooling.
- **Keep it machine-parseable.** Use consistent markdown headings, tables, and the `Error #N` format so AI agents can extract structured data.
