# Rails 8.0 → 8.1 Upgrade Guide

**Ruby Requirement:** 3.2.0+ (required)

---

## Overview

Rails 8.1 is a minor release with:
- **bundler-audit** integration for security scanning
- **Database configuration** naming changes
- **SSL configuration** changes for Kamal deployments
- Removal of some deprecated job adapters

---

## Breaking Changes

### 🔴 HIGH PRIORITY

#### 1. SSL Configuration Commented Out

**What Changed:**
SSL configuration is now commented out by default (assumes Kamal handles SSL).

**Detection Pattern:**
```ruby
# config/environments/production.rb
# If you're NOT using Kamal and see this:
# config.force_ssl = true
# config.assume_ssl = true
```

**Fix:**

If NOT using Kamal (traditional deployment):
```ruby
# config/environments/production.rb
# Uncomment these lines:
config.force_ssl = true
config.assume_ssl = true
```

If using Kamal:
```ruby
# Leave commented - Kamal handles SSL
# config.force_ssl = true
```

---

#### 2. pool: → max_connections:

**What Changed:**
Database configuration renames `pool:` to `max_connections:`.

**Detection Pattern:**
```yaml
# config/database.yml
production:
  adapter: postgresql
  pool: 5
```

**Fix:**
```yaml
# BEFORE
production:
  adapter: postgresql
  pool: 5

# AFTER
production:
  adapter: postgresql
  max_connections: 5
```

**Note:** Update ALL database configurations (primary, cache, queue, cable).

---

#### 3. bundler-audit Required

**What Changed:**
Rails 8.1 expects bundler-audit for security vulnerability scanning.

**Fix:**

1. Add to Gemfile:
```ruby
# Gemfile
gem 'bundler-audit', group: :development
```

2. Create the script:
```bash
# bin/brakeman
#!/usr/bin/env ruby
require "bundler/audit/cli"
Bundler::Audit::CLI.start
```

3. Make executable:
```bash
chmod +x bin/brakeman
```

4. Run security audit:
```bash
bundle audit check --update
```

---

### 🟡 MEDIUM PRIORITY

#### 4. Semicolon Query Separator Removed

**What Changed:**
Semicolons (`;`) can no longer be used as query parameter separators.

**Detection Pattern:**
```ruby
# URLs or code using semicolons
"/search?q=test;page=2"
```

**Fix:**
```ruby
# BEFORE
"/search?q=test;page=2"

# AFTER
"/search?q=test&page=2"
```

---

#### 5. Sidekiq Adapter Removed

**What Changed:**
Built-in Sidekiq adapter removed from ActiveJob.

**Detection Pattern:**
```ruby
# Gemfile
gem 'sidekiq', '< 6.5'
```

**Fix:**
Update Sidekiq to 6.5+ which includes its own adapter:
```ruby
# Gemfile
gem 'sidekiq', '>= 6.5'
```

---

#### 6. SuckerPunch Adapter Removed

**What Changed:**
Built-in SuckerPunch adapter removed.

**Fix:**
Update sucker_punch to 3.2+ which includes its own adapter:
```ruby
# Gemfile
gem 'sucker_punch', '>= 3.2'
```

---

#### 7. Azure Storage Service Removed

**What Changed:**
Azure storage service adapter removed from Active Storage.

**Detection Pattern:**
```yaml
# config/storage.yml
azure:
  service: AzureStorage
```

**Fix:**
- Switch to S3, GCS, or Disk storage
- Or use azure-storage-blob gem directly with custom service

---

### 🟢 LOW PRIORITY

#### 8. schema.rb Column Sorting Change

**What Changed:**
Database columns in `schema.rb` are now sorted alphabetically instead of by creation order.

**Impact:**
Running `rails db:migrate` may regenerate `schema.rb` with columns in different order.

**Note:**
This is a cosmetic change. Your database structure is unaffected. You may see large diffs in version control on first migration after upgrade.

---

#### 9. MySQL Unsigned Types Deprecation

**What Changed:**
MySQL `unsigned: true` generates deprecation warnings.

**Fix:**
Use check constraints instead:
```ruby
# BEFORE
t.integer :count, unsigned: true

# AFTER
t.integer :count
t.check_constraint "count >= 0"
```

---

#### 10. .gitignore Update

**What Changed:**
Recommended `.gitignore` pattern for credential keys changed.

**Fix:**
```gitignore
# BEFORE
*.key

# AFTER
/config/*.key
```

---

## Migration Steps

### Phase 1: Preparation
```bash
git checkout -b rails-81-upgrade
```

### Phase 2: Gemfile Updates
```ruby
# Gemfile
gem 'rails', '~> 8.1.0'
gem 'bundler-audit', group: :development

# Update job adapters if using
gem 'sidekiq', '>= 6.5'  # If using Sidekiq
```

```bash
bundle update rails
```

### Phase 3: Fix Breaking Changes

1. **Update database.yml:**
```yaml
# Replace pool: with max_connections:
production:
  max_connections: 5  # Was: pool: 5
```

2. **Check SSL configuration:**
```ruby
# If NOT using Kamal, uncomment in production.rb:
config.force_ssl = true
config.assume_ssl = true
```

3. **Add bundler-audit:**
```bash
bundle add bundler-audit --group development
```

### Phase 4: Configuration
```bash
rails app:update
```

### Phase 5: Testing
- Run `bundle audit check --update`
- Test database connections
- Verify SSL works correctly
- Test background jobs

---

## Configuration Migration Checklist

- [ ] `pool:` → `max_connections:` in database.yml
- [ ] SSL config uncommented (if not using Kamal)
- [ ] bundler-audit added
- [ ] Job adapter gems updated
- [ ] Semicolons replaced with ampersands in URLs

---

## Common Issues

### Issue: Database Connection Pool Error

**Error:** `unknown keyword: pool`

**Cause:** Old configuration syntax

**Fix:**
```yaml
max_connections: 5  # Not pool: 5
```

### Issue: SSL Redirect Not Working

**Cause:** SSL config is commented out

**Fix:**
Uncomment `force_ssl` and `assume_ssl` in production.rb

### Issue: Sidekiq Jobs Not Processing

**Cause:** Using old Sidekiq version without built-in adapter

**Fix:**
```ruby
gem 'sidekiq', '>= 6.5'
```

---

## Security Best Practices

After upgrading, run security checks:

```bash
# Check for vulnerable gems
bundle audit check --update

# Run Brakeman for code analysis
bundle exec brakeman

# Check for outdated gems
bundle outdated
```

---

## Resources

- [Rails 8.1 Release Notes](https://guides.rubyonrails.org/8_1_release_notes.html)
- [bundler-audit](https://github.com/rubysec/bundler-audit)
- [Kamal Documentation](https://kamal-deploy.org)
