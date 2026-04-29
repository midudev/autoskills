# App Update Preview Workflow

**Purpose:** Generate a preview of what `rails app:update` will change in configuration files

**When to use:** After the codebase was analyzed and the breaking changes report was generated

---

## Prerequisites

- Target Rails version known
- User's current configuration files accessible
- Version guide available

---

## Step-by-Step Workflow

### Step 1: Identify Configuration Files

Standard Rails configuration files that may change:

```
config/
├── application.rb
├── boot.rb
├── environment.rb
├── environments/
│   ├── development.rb
│   ├── production.rb
│   └── test.rb
├── initializers/
│   ├── assets.rb
│   ├── content_security_policy.rb
│   ├── filter_parameter_logging.rb
│   ├── inflections.rb
│   └── new_framework_defaults_{version}.rb
├── database.yml
├── storage.yml
├── cable.yml
├── puma.rb
└── routes.rb

bin/
├── rails
├── rake
├── setup
└── dev

Gemfile
```

---

### Step 2: Read Current Configuration

For each configuration file:

```
Read: config/application.rb
Read: config/environments/production.rb
Read: config/environments/development.rb
Read: config/environments/test.rb
Read: config/database.yml
Read: Gemfile
```

Store current contents for comparison.

---

### Step 3: Load Version Guide

Read version-specific configuration changes:

```
Read: version-guides/upgrade-{FROM}-to-{TO}.md
```

Extract the configuration section that details:
- New default settings
- Changed settings
- Removed settings
- New files added

---

### Step 4: Generate File-by-File Preview

For each affected file, create a diff preview:

```markdown
## config/environments/production.rb

### Changes Required

**Line 25: SSL Configuration**

BEFORE:
\```ruby
config.force_ssl = true
\```

AFTER:
\```ruby
config.force_ssl = true
config.assume_ssl = true  # NEW in Rails 8.0
\```

**Impact:** MEDIUM - Required for proper SSL handling with load balancers

---

**Line 48: Cache Store**

BEFORE:
\```ruby
config.cache_store = :redis_cache_store
\```

AFTER:
\```ruby
# Option 1: Keep Redis (recommended if already working)
config.cache_store = :redis_cache_store

# Option 2: Switch to Solid Cache (Rails 8.0 default)
config.cache_store = :solid_cache_store
\```

**Impact:** LOW - Optional change, Redis still supported

⚠️ **Custom Code Warning:** You have Redis-specific configuration in `config/initializers/redis.rb`. Review if switching to Solid Cache.
```

---

### Step 5: List New Files

Files that `rails app:update` will create:

```markdown
## New Files to Be Created

| File | Purpose | Action |
|------|---------|--------|
| `config/initializers/new_framework_defaults_8_0.rb` | Opt-in to new defaults | Review and enable gradually |
| `bin/dev` | Development server script | Review for Procfile compatibility |
| `Dockerfile` | Container configuration | Review if using Docker |
| `config/deploy.yml` | Kamal deployment | Skip if not using Kamal |
| `.github/workflows/ci.yml` | GitHub Actions CI | Review if using GitHub Actions |
```

---

### Step 6: Categorize by Impact

Group changes by impact level:

```markdown
## Impact Summary

### 🔴 HIGH IMPACT (Must Change)
Files that must be updated for the app to work:

1. `Gemfile` - Update Rails version
2. `config/application.rb` - Update load_defaults

### 🟡 MEDIUM IMPACT (Should Change)
Files that should be updated for best practices:

1. `config/environments/production.rb` - SSL configuration
2. `config/database.yml` - Connection pool settings

### 🟢 LOW IMPACT (Optional)
Files that can be updated later:

1. `config/environments/development.rb` - Debug settings
2. `bin/dev` - New development script
```

---

### Step 7: Generate Recommended Approach

```markdown
## Recommended Approach

### Option A: Interactive (Recommended for Complex Apps)

Run `rails app:update` and review each change:

\```bash
rails app:update
\```

For each file, you'll be prompted:
- `Y` - Accept change
- `n` - Skip change
- `d` - View diff
- `q` - Quit

### Option B: Manual (Recommended for Custom Configurations)

Apply changes manually based on this preview:

1. Update `Gemfile` first
2. Run `bundle update rails`
3. Apply HIGH impact changes from this report
4. Run test suite
5. Apply MEDIUM impact changes
6. Run test suite again
7. Optionally apply LOW impact changes

### Option C: Accept All (Only for Simple Apps)

Accept all defaults:

\```bash
rails app:update --force
\```

⚠️ **Warning:** This will overwrite custom configurations. Only use if you have version control and can review changes.
```

---

### Step 8: Add Framework Defaults Guide

```markdown
## New Framework Defaults

After upgrading, Rails creates `config/initializers/new_framework_defaults_{version}.rb`.

This file lets you opt-in to new behaviors gradually:

\```ruby
# config/initializers/new_framework_defaults_8_0.rb

# Don't enable all at once!
# Enable one at a time and test:

# Rails.application.config.active_record.default_column_serializer = JSON
# Rails.application.config.active_support.cache_format_version = 7.1
\```

### Recommended Approach

1. Start with all options commented out
2. Enable one option at a time
3. Run test suite after each
4. Deploy to staging and verify
5. Once all verified, update `config.load_defaults` to {VERSION}
6. Delete the new_framework_defaults file
```

---

### Step 9: Deliver Preview

Present the preview to the user:

```markdown
# app:update Preview for Rails {VERSION}

Here's what will change when you run `rails app:update`:

[PREVIEW CONTENT]

## Quick Start

1. **Review** the HIGH impact changes above
2. **Run** `rails app:update`
3. **Choose** Option A (interactive) for most control
4. **Test** after each major change

Need help with any specific file? Let me know!
```

---

## Preview Quality Standards

### Show Actual Line Numbers

```markdown
**Line 25:** (not just "somewhere in the file")
```

### Provide Both Options When Applicable

```markdown
# Option 1: Keep existing (if it works)
# Option 2: Use new default (recommended)
```

### Flag Custom Code

```markdown
⚠️ **Custom Code Warning:** This file has non-standard configuration
```

### Be Specific About Impact

| Impact | Meaning |
|--------|---------|
| HIGH | App won't start without this change |
| MEDIUM | App works but may have issues |
| LOW | Cosmetic or optional improvements |

---

**Related Files:**
- Template: `templates/app-update-preview-template.md`
- Version guides: `version-guides/upgrade-{FROM}-to-{TO}.md`
