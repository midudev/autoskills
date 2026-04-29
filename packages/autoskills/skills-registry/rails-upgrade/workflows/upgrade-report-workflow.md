# Upgrade Report Workflow

**Purpose:** Generate comprehensive upgrade reports based on actual detection findings

**When to use:** After direct detection has been run and findings have been collected

---

## Prerequisites

- Direct detection has been run using Grep/Glob/Read tools
- Detection findings have been collected with file:line references
- Target Rails version is known
- Version guide available for the upgrade

---

## Step-by-Step Workflow

### Step 1: Parse Detection Findings

Extract from the detection findings:

```
1. Total issues found
2. List of HIGH priority issues with counts
3. List of MEDIUM priority issues with counts
4. Affected file paths
5. Project statistics (job count, controller count, etc.)
```

**Example findings to extract:**
```
⚠️  Found 5 breaking change(s) that need fixing:
   - Sprockets usage: 3 occurrence(s)
   - SSL configuration: 2 occurrence(s)

📋 AFFECTED FILES
config/environments/production.rb
Gemfile
config/initializers/assets.rb
```

---

### Step 2: Load Version Guide

Read the version-specific upgrade guide:

```
Read: version-guides/upgrade-{FROM}-to-{TO}.md
```

Extract:
- All breaking changes for this version
- Migration steps
- Code examples (OLD vs NEW)
- Known issues and workarounds

---

### Step 3: Read Affected Files

For each file listed in findings, read the actual content:

```
For each affected_file in findings:
  Read: {affected_file}
  Store: file_contents for context
```

This allows generating reports with the user's actual code, not generic examples.

---

### Step 4: Load Report Template

Read the report template:

```
Read: templates/upgrade-report-template.md
```

---

### Step 5: Generate Report Sections

#### Section 1: Executive Summary

```markdown
# Rails {FROM} → {TO} Upgrade Report

**Generated:** {DATE}
**Project:** {PROJECT_NAME}
**Current Version:** {FROM}
**Target Version:** {TO}

## Summary

- **Total Issues Found:** {TOTAL_COUNT}
- **High Priority:** {HIGH_COUNT}
- **Medium Priority:** {MEDIUM_COUNT}
- **Estimated Effort:** {EFFORT}
```

#### Section 2: Breaking Changes Analysis

For each issue found in findings:

```markdown
### 🔴 {ISSUE_NAME}

**Priority:** HIGH
**Found:** {COUNT} occurrence(s)
**Affected Files:**
{FILE_LIST}

#### What Changed
{EXPLANATION_FROM_VERSION_GUIDE}

#### Your Code (Before)
\```ruby
{ACTUAL_CODE_FROM_USER_FILES}
\```

#### Required Change (After — Dual-Boot with `NextRails.next?`)
\```ruby
# Dual-boot compatible: uses NextRails.next? (NOT respond_to?)
if NextRails.next?
  {FIXED_CODE_FOR_TARGET_VERSION}
else
  {ORIGINAL_CODE_FOR_CURRENT_VERSION}
end
\```

#### Final Code (After upgrade is complete, remove dual-boot branch)
\```ruby
{FIXED_CODE_FOR_TARGET_VERSION}
\```

⚠️ **Custom Code Warning:** {WARNING_IF_APPLICABLE}
```

> **Note:** All code examples use `NextRails.next?` for dual-boot compatibility.
> Never use `respond_to?` for version branching — it is hard to understand, hard to
> maintain, and obscures the intent of the code. See SKILL.md for details.

#### Section 3: Step-by-Step Migration Plan

```markdown
## Migration Plan

### Phase 1: Preparation
- [ ] Backup database
- [ ] Create upgrade branch
- [ ] Run current test suite (ensure passing)

### Phase 2: Dependency Updates
- [ ] Update Gemfile with target Rails version
- [ ] Run `bundle update rails`
- [ ] Update dependent gems as needed

### Phase 3: Breaking Changes
{GENERATE_TASK_LIST_FROM_FINDINGS}

### Phase 4: Configuration
- [ ] Run `rails app:update`
- [ ] Review and merge configuration changes
- [ ] Update load_defaults to {VERSION}

### Phase 5: Testing
- [ ] Run full test suite
- [ ] Fix failing tests
- [ ] Test critical paths manually
- [ ] Deploy to staging
```

#### Section 4: Testing Checklist

```markdown
## Testing Checklist

### Automated Tests
- [ ] Unit tests passing
- [ ] Integration tests passing
- [ ] System tests passing

### Manual Testing
- [ ] User authentication/authorization
- [ ] File uploads (Active Storage)
- [ ] Background jobs
- [ ] Mailers
- [ ] API endpoints
- [ ] Asset loading (CSS/JS)
```

#### Section 5: Rollback Plan

```markdown
## Rollback Plan

If issues arise after deployment:

1. **Immediate:** `git checkout main && bundle install && rails db:migrate`
2. **Database:** Restore from backup if migrations ran
3. **Cache:** Clear Rails cache `rails tmp:clear`
4. **Assets:** Recompile `rails assets:precompile`
```

---

### Step 6: Add Custom Code Warnings

For each issue, check if user has custom code that might be affected:

**Patterns to flag:**
- Custom initializers related to the breaking change
- Monkey-patching of affected classes
- Non-standard configurations
- Third-party gem integrations

**Warning format:**
```markdown
⚠️ **Custom Code Warning:**
Your file `config/initializers/custom_loader.rb` contains custom autoloading logic.
This may conflict with Zeitwerk. Review and test thoroughly.
```

---

### Step 7: Populate Template

Replace all placeholders:

| Placeholder | Source | Example |
|-------------|--------|---------|
| `{FROM}` | Current version | "7.2" |
| `{TO}` | Target version | "8.0" |
| `{DATE}` | Current date | "January 30, 2025" |
| `{PROJECT_NAME}` | From findings | "my-rails-app" |
| `{TOTAL_COUNT}` | Sum of issues | "5" |
| `{HIGH_COUNT}` | High priority count | "3" |
| `{MEDIUM_COUNT}` | Medium priority count | "2" |
| `{EFFORT}` | Based on issue count | "6-8 hours" |

---

### Step 8: Quality Check

Before delivering:

- [ ] All placeholders replaced with actual values
- [ ] All code examples are from user's actual files
- [ ] Breaking changes match what was found in findings
- [ ] Custom code warnings included where appropriate
- [ ] Migration plan is actionable
- [ ] Testing checklist is comprehensive
- [ ] Rollback plan is clear

---

### Step 9: Deliver Report

Present the complete report to the user:

```markdown
# Here's your comprehensive upgrade report

I've analyzed your project and found {TOTAL_COUNT} issues that need addressing.

[FULL REPORT CONTENT]

## Next Steps

1. Review this report
2. Start with HIGH priority issues
3. Run `rails app:update` for configuration changes
4. Run test suite after each change
5. Let me know if you need help with any specific issue!
```

---

## Report Quality Standards

### Code Examples Must Be Real

❌ **Bad:** Generic example code
```ruby
# Generic example
config.some_setting = true
```

✅ **Good:** User's actual code from their files
```ruby
# From config/environments/production.rb:42
config.force_ssl = true
```

### Warnings Must Be Specific

❌ **Bad:** "You might have custom code"

✅ **Good:** "Your `config/initializers/sprockets.rb` contains custom asset pipeline configuration that will need migration to Propshaft"

### Effort Estimates

| Issues | Effort |
|--------|--------|
| 1-3 | 1-2 hours |
| 4-6 | 3-4 hours |
| 7-10 | 5-8 hours |
| 11+ | 1-2 days |

Add 50% if custom code warnings are present.

---

**Related Files:**
- Template: `templates/upgrade-report-template.md`
- Version guides: `version-guides/upgrade-{FROM}-to-{TO}.md`
- Testing checklist: `references/testing-checklist.md`
