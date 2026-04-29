# Rails 5.2 → 6.0 Upgrade Guide

**Ruby Requirement:** 2.5.0+ (2.7+ recommended)

---

## Overview

Rails 6.0 is a major release with significant changes:
- **Zeitwerk** replaces classic autoloader
- **Action Mailbox** for inbound email processing
- **Action Text** for rich text editing
- **Parallel testing** by default
- **Webpacker** as default JavaScript compiler

---

## Breaking Changes

### 🔴 HIGH PRIORITY

#### 1. Zeitwerk Autoloader

**What Changed:**
Rails 6.0 introduces Zeitwerk as the new code autoloader, replacing the classic autoloader.

**Detection Pattern:**
```ruby
require_dependency 'some/file'
```

**Fix:**
Remove all `require_dependency` calls. Zeitwerk auto-loads files based on naming conventions.

```ruby
# BEFORE (Rails 5.2)
require_dependency 'concerns/trackable'

# AFTER (Rails 6.0)
# Just delete the line - Zeitwerk handles loading
```

**Naming Requirements:**
- File `app/models/user_profile.rb` must define `UserProfile`
- File `app/services/payment/processor.rb` must define `Payment::Processor`
- Acronyms: `HTMLParser` → `html_parser.rb`

**Check for issues:**
```bash
rails zeitwerk:check
```

---

#### 2. Ruby 2.5+ Required

**What Changed:**
Rails 6.0 requires Ruby 2.5.0 or newer.

**Fix:**
Upgrade Ruby before Rails:
```bash
# Update .ruby-version
echo "2.7.8" > .ruby-version

# Or use rbenv/rvm
rbenv install 2.7.8
rbenv local 2.7.8
```

---

#### 3. update_attributes Removed

**What Changed:**
`update_attributes` and `update_attributes!` are removed.

**Detection Pattern:**
```ruby
user.update_attributes(name: 'New Name')
user.update_attributes!(name: 'New Name')
```

**Fix:**
```ruby
# BEFORE
user.update_attributes(name: 'New Name')

# AFTER
user.update(name: 'New Name')
```

---

#### 4. belongs_to Required by Default

**What Changed:**
`belongs_to` associations are required by default (presence validation).

**Detection Pattern:**
```ruby
belongs_to :user  # Now requires user to exist
```

**Fix:**
Add `optional: true` for associations that can be nil:
```ruby
# BEFORE (implicitly optional)
belongs_to :parent_category

# AFTER (explicitly optional)
belongs_to :parent_category, optional: true
```

---

#### 5. protect_from_forgery Default Changed

**What Changed:**
Default CSRF protection strategy changed to `:exception`.

**Detection Pattern:**
```ruby
protect_from_forgery with: :null_session
```

**Fix:**
Review your CSRF strategy. For APIs:
```ruby
# API controllers
class ApiController < ApplicationController
  protect_from_forgery with: :null_session
end
```

---

### 🟡 MEDIUM PRIORITY

#### 6. before_filter Removed

**What Changed:**
`before_filter`, `after_filter`, `skip_before_filter` are removed.

**Fix:**
```ruby
# BEFORE
before_filter :authenticate_user!

# AFTER
before_action :authenticate_user!
```

---

#### 7. render :text Removed

**What Changed:**
`render text: 'content'` is removed.

**Fix:**
```ruby
# BEFORE
render text: 'Hello'

# AFTER
render plain: 'Hello'
```

---

#### 8. render nothing: true Removed

**What Changed:**
`render nothing: true` is removed.

**Fix:**
```ruby
# BEFORE
render nothing: true

# AFTER
head :ok
# or
head :no_content
```

---

#### 9. ActiveStorage Blob API Changes

**What Changed:**
`ActiveStorage::Blob.create_after_upload!` is deprecated.

**Fix:**
```ruby
# BEFORE
ActiveStorage::Blob.create_after_upload!(io: file, filename: 'file.pdf')

# AFTER
ActiveStorage::Blob.create_and_upload!(io: file, filename: 'file.pdf')
```

---

## New Features (Optional)

### Action Mailbox
Process incoming emails:
```ruby
rails action_mailbox:install
```

### Action Text
Rich text editing with Trix:
```ruby
rails action_text:install
```

### Multiple Databases
Configure multiple databases in `database.yml`:
```yaml
production:
  primary:
    database: my_primary_database
  replica:
    database: my_replica_database
    replica: true
```

---

## Migration Steps

### Phase 1: Preparation
```bash
# Create upgrade branch
git checkout -b rails-60-upgrade

# Check current Ruby version
ruby -v

# Upgrade Ruby if needed (to 2.7+)
```

### Phase 2: Gemfile Updates
```ruby
# Gemfile
gem 'rails', '~> 6.0.0'
gem 'webpacker', '~> 5.0'  # New default for JS
```

```bash
bundle update rails
```

### Phase 3: Fix Breaking Changes
1. Remove all `require_dependency` calls
2. Run `rails zeitwerk:check`
3. Fix naming issues
4. Replace `update_attributes` with `update`
5. Add `optional: true` to nullable associations
6. Replace `before_filter` with `before_action`

### Phase 4: Configuration
```bash
rails app:update
```

Update `config/application.rb`:
```ruby
config.load_defaults 6.0
```

### Phase 5: Webpacker (Optional)
If migrating JavaScript:
```bash
rails webpacker:install
```

---

## Zeitwerk Compatibility Checklist

- [ ] No `require_dependency` calls
- [ ] All files follow naming conventions
- [ ] No files with multiple class/module definitions
- [ ] `rails zeitwerk:check` passes
- [ ] No circular dependencies
- [ ] Concerns named correctly

---

## Common Issues

### Issue: Zeitwerk::NameError

**Error:** `expected file app/models/user_profile.rb to define constant UserProfile`

**Cause:** File naming doesn't match class name

**Fix:** Rename file or class to match

### Issue: Circular Dependency

**Error:** `Circular dependency detected`

**Cause:** Two files require each other

**Fix:** Restructure code or use `require` for specific edge cases

### Issue: NameError in Tests

**Error:** `uninitialized constant`

**Cause:** Tests loading before Zeitwerk setup

**Fix:** Ensure `rails_helper` is properly configured

---

## Gem Compatibility

| Gem | Minimum Version |
|-----|-----------------|
| devise | 4.7.0 |
| cancancan | 3.0.0 |
| pundit | 2.0.0 |
| sidekiq | 6.0.0 |
| rspec-rails | 4.0.0 |
| factory_bot_rails | 5.0.0 |

---

## Resources

- [Rails 6.0 Release Notes](https://guides.rubyonrails.org/6_0_release_notes.html)
- [Zeitwerk Documentation](https://github.com/fxn/zeitwerk)
- [Webpacker Documentation](https://github.com/rails/webpacker)
