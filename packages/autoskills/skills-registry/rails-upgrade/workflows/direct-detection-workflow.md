# Direct Detection Workflow

**Purpose:** Run breaking change detection directly using Claude's tools (Grep, Glob, Read)

**When to use:** Step 3 of the upgrade workflow - after tests pass and load_defaults is verified

---

## Why Direct Detection?

Claude Code can:
- Search files directly using the Grep tool
- Find files by pattern using the Glob tool
- Read file contents using the Read tool
- Analyze results immediately
- Generate reports without user round-trip

---

## Step-by-Step Workflow

### Step 1: Load Pattern File

Read the version-specific pattern file:

```
detection-scripts/patterns/rails-{VERSION}-patterns.yml
```

Example for Rails 8.0:
```
detection-scripts/patterns/rails-80-patterns.yml
```

The pattern file contains:
- `breaking_changes.high_priority` - Critical patterns to search
- `breaking_changes.medium_priority` - Important patterns to search
- Each pattern has: `name`, `pattern`, `search_paths`, `explanation`, `fix`

---

### Step 2: Process High Priority Patterns

For each pattern in `breaking_changes.high_priority`:

```yaml
- name: "Sprockets usage"
  pattern: "sprockets|Sprockets"
  exclude: "propshaft"
  search_paths:
    - "Gemfile"
    - "config/"
    - "app/assets/"
  explanation: "Rails 8.0 replaces Sprockets with Propshaft"
  fix: "Migrate to Propshaft or keep Sprockets explicitly"
```

**Execute using Grep tool:**

```
Grep:
  pattern: "sprockets|Sprockets"
  path: "Gemfile"
  output_mode: "content"
```

```
Grep:
  pattern: "sprockets|Sprockets"
  path: "config/"
  output_mode: "content"
```

**Collect results:**
- File paths where pattern was found
- Line numbers
- Matching content
- Context (lines before/after if helpful)

---

### Step 3: Process Medium Priority Patterns

Same process for `breaking_changes.medium_priority` patterns.

---

### Step 4: Compile Findings

Structure findings as:

```
findings = {
  high_priority: [
    {
      name: "Sprockets usage",
      explanation: "Rails 8.0 replaces Sprockets with Propshaft",
      fix: "Migrate to Propshaft or keep Sprockets explicitly",
      occurrences: 3,
      files: [
        { path: "Gemfile", line: 16, content: "gem 'sprockets-rails'" },
        { path: "config/initializers/assets.rb", line: 5, content: "config.assets.compile = true" },
        { path: "config/application.rb", line: 23, content: "require 'sprockets/railtie'" }
      ]
    },
    ...
  ],
  medium_priority: [
    ...
  ],
  summary: {
    total_issues: 5,
    high_priority_count: 3,
    medium_priority_count: 2,
    affected_files: ["Gemfile", "config/initializers/assets.rb", ...]
  }
}
```

---

### Step 5: Read Affected Files for Context

For files with findings, read the full content to:
- Understand surrounding code
- Provide accurate OLD vs NEW examples
- Identify custom code that needs ⚠️ warnings

Use Read tool:
```
Read:
  file_path: "/path/to/project/config/initializers/assets.rb"
```

---

### Step 6: Return Findings

Pass structured findings to the report generation step.

---

## Tool Usage Examples

### Using Grep for Pattern Search

**Search for a specific pattern:**
```
Grep:
  pattern: "config\\.assets\\."
  path: "config/environments/"
  output_mode: "content"
  -n: true
```

**Search with exclusion (grep -v equivalent):**
Run the search, then filter results in analysis.

**Search multiple paths:**
Make separate Grep calls for each path, or use a parent directory.

### Using Glob to Find Files

**Find all Ruby files in config:**
```
Glob:
  pattern: "config/**/*.rb"
```

**Find specific file types:**
```
Glob:
  pattern: "app/models/**/*.rb"
```

### Using Read for Full Context

**Read a specific file:**
```
Read:
  file_path: "/absolute/path/to/file.rb"
```

---

## Pattern File Format Reference

```yaml
version: "8.0"
description: "Breaking change patterns for Rails 7.2 → 8.0 upgrade"

breaking_changes:
  high_priority:
    - name: "Human-readable name"
      pattern: "regex pattern"
      exclude: "exclusion pattern (optional)"
      search_paths:
        - "path/to/search"
        - "another/path"
      explanation: "Why this is a breaking change"
      fix: "How to fix it"
      variable_name: "UNIQUE_NAME"  # For reference

  medium_priority:
    - name: "Another pattern"
      # same structure
```

---

## Handling Search Results

### When Pattern Found

1. Record the finding with file:line reference
2. Note the matching content
3. Add to findings list
4. Continue to next pattern

### When Pattern Not Found

1. Pattern is "clear" - no issues for this check
2. Don't include in findings (or include as "✅ None found")
3. Continue to next pattern

### When Search Errors

1. Log the error
2. Note which check couldn't be performed
3. Continue with other patterns
4. Report incomplete checks to user

---

## Output Format

Present findings to the report generation step as structured data:

```markdown
## Detection Results

### High Priority Issues (3 found)

#### 1. Sprockets usage
**Explanation:** Rails 8.0 replaces Sprockets with Propshaft
**Fix:** Migrate to Propshaft or keep Sprockets explicitly

**Found in:**
- `Gemfile:16` - `gem 'sprockets-rails'`
- `config/initializers/assets.rb:5` - `config.assets.compile = true`
- `config/application.rb:23` - `require 'sprockets/railtie'`

#### 2. Asset pipeline configuration
...

### Medium Priority Issues (2 found)
...

### Summary
- Total issues: 5
- High priority: 3
- Medium priority: 2
- Affected files: 4
```

---

## Integration with Report Generation

After detection completes:

1. Pass findings to `workflows/upgrade-report-workflow.md`
2. Pass config file contents to `workflows/app-update-preview-workflow.md`
3. Generate both reports using actual findings
4. Present to user

---

## Performance Considerations

- Run Grep calls in parallel when possible (multiple tool calls in one message)
- Use specific paths rather than searching entire codebase
- Limit context lines to what's needed
- Don't read files unnecessarily - only read what's needed for reports

---

## Quality Checklist

Before proceeding to report generation:

- [ ] All patterns from version YAML file processed
- [ ] High priority patterns all checked
- [ ] Medium priority patterns all checked
- [ ] Findings include file:line references
- [ ] Affected file contents read for context
- [ ] Findings structured for report generation
- [ ] Any search errors noted

---
