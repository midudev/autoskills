# Rails 7.1 → 7.2 Upgrade Guide

**Ruby Requirement:** 3.1.0+ (3.2+ recommended)

**Based on "The Complete Guide to Upgrade Rails" by FastRuby.io (OmbuLabs)**

---

## Overview

Rails 7.2 introduces:
- **Transaction-aware job enqueuing** by default
- **DevContainers** support
- **Browser version restrictions**
- **Enhanced Active Record connection handling**
- **Progressive Web App (PWA) support**

---

## Breaking Changes

### 🔴 HIGH PRIORITY

#### 1. Transaction-Aware Job Enqueuing

**What Changed:**
Jobs enqueued inside a database transaction now wait until the transaction commits before being processed.

**Impact:**
```ruby
# This behavior changed!
ActiveRecord::Base.transaction do
  user = User.create!(name: "Test")
  WelcomeEmailJob.perform_later(user)
  # Job now waits for transaction to commit
end
```

**Detection Pattern:**
```ruby
# Models with callbacks that enqueue jobs
after_create :send_welcome_email

def send_welcome_email
  WelcomeEmailJob.perform_later(self)
end
```

**Fix:**

The new behavior is usually correct (ensures data exists before job runs). If you need the old behavior:

```ruby
# Option 1: Use after_commit callback (recommended)
after_commit :send_welcome_email, on: :create

# Option 2: Disable transaction-aware enqueuing globally
# config/application.rb
config.active_job.enqueue_after_transaction_commit = :never
```

---

#### 2. show_exceptions Requires Symbols

**What Changed:**
`config.action_dispatch.show_exceptions` now requires symbol values instead of booleans.

**Detection Pattern:**
```ruby
# config/environments/development.rb
config.action_dispatch.show_exceptions = true

# config/environments/test.rb
config.action_dispatch.show_exceptions = false
```

**Fix:**
```ruby
# BEFORE
config.action_dispatch.show_exceptions = true
config.action_dispatch.show_exceptions = false

# AFTER
config.action_dispatch.show_exceptions = :all       # Was true
config.action_dispatch.show_exceptions = :rescuable # Show only rescuable
config.action_dispatch.show_exceptions = :none      # Was false
```

**Values:**
- `:all` - Show all exceptions (like `true`)
- `:rescuable` - Show only rescuable exceptions
- `:none` - Don't show exceptions (like `false`)

---

#### 3. params Comparison Removed

**What Changed:**
`ActionController::Parameters` no longer compares equal to `Hash`.

**Detection Pattern:**
```ruby
# In controllers or tests
if params == { key: 'value' }
if params[:user] == some_hash
```

**Fix:**
```ruby
# BEFORE
params == { key: 'value' }
params[:user] == some_hash

# AFTER
params.to_h == { key: 'value' }
params[:user].to_h == some_hash
```

---

#### 4. ActiveRecord.connection Deprecated

**What Changed:**
`ActiveRecord::Base.connection` is deprecated.

**Detection Pattern:**
```ruby
ActiveRecord::Base.connection.execute("SELECT 1")
ActiveRecord::Base.connection.tables
```

**Fix:**
```ruby
# BEFORE
ActiveRecord::Base.connection.execute("SELECT 1")

# AFTER - Option 1: with_connection block (recommended)
ActiveRecord::Base.with_connection do |conn|
  conn.execute("SELECT 1")
end

# AFTER - Option 2: lease_connection (for longer use)
conn = ActiveRecord::Base.lease_connection
conn.execute("SELECT 1")
# Return connection when done
```

---

#### 5. Rails.application.secrets Removed

**What Changed:**
`Rails.application.secrets` is completely removed.

**Detection Pattern:**
```ruby
Rails.application.secrets.api_key
Rails.application.secrets[:database_password]
```

**Fix:**
Migrate to credentials:

```bash
# Edit credentials
rails credentials:edit

# Or for environment-specific
rails credentials:edit --environment production
```

```ruby
# BEFORE
Rails.application.secrets.api_key

# AFTER
Rails.application.credentials.api_key
Rails.application.credentials.dig(:production, :api_key)
```

---

### 🟡 MEDIUM PRIORITY

#### 6. serialize Requires Type Parameter

**What Changed:**
`serialize` now requires explicit `type:` or `coder:` parameter.

**Detection Pattern:**
```ruby
class User < ApplicationRecord
  serialize :preferences
end
```

**Fix:**
```ruby
# BEFORE
serialize :preferences

# AFTER
serialize :preferences, type: Hash
serialize :preferences, coder: YAML
serialize :preferences, coder: JSON
```

---

#### 7. fixture_path → fixture_paths

**What Changed:**
Singular `fixture_path` deprecated in favor of plural.

**Detection Pattern:**
```ruby
# test/test_helper.rb
self.fixture_path = "#{Rails.root}/test/fixtures"
```

**Fix:**
```ruby
# BEFORE
self.fixture_path = "#{Rails.root}/test/fixtures"

# AFTER
self.fixture_paths = ["#{Rails.root}/test/fixtures"]
```

---

#### 8. query_constraints Deprecated

**What Changed:**
`query_constraints` is deprecated.

**Fix:**
```ruby
# Use foreign_key instead
has_many :posts, foreign_key: [:author_id, :author_type]
```

---

#### 9. Mailer Test args: → params:

**What Changed:**
Mailer assertion helpers change `args:` to `params:`.

**Detection Pattern:**
```ruby
# In tests
assert_enqueued_email_with UserMailer, :welcome, args: [user]
```

**Fix:**
```ruby
# BEFORE
assert_enqueued_email_with UserMailer, :welcome, args: [user]

# AFTER
assert_enqueued_email_with UserMailer, :welcome, params: { user: user }
```

---

#### 10. Queue Adapter Must Support `at:` for Testing

**What Changed:**
Tests now require queue adapters to support scheduling with `at:` option.

**Detection Pattern:**
```ruby
# test_helper.rb
config.active_job.queue_adapter = :test
```

**Fix:**
If using custom queue adapter in tests, ensure it supports `at:` option for scheduled jobs. The `:test` adapter works correctly out of the box.

---

#### 11. alias_attribute Behavior Change

**What Changed:**
`alias_attribute` now applies attribute methods to the aliased attribute too.

**Detection Pattern:**
```ruby
class User < ApplicationRecord
  alias_attribute :login, :username
end
```

**Impact:**
If you call `user.login_changed?` or `user.login_was`, they now work correctly. Previously only the original attribute (`username_changed?`) had these methods.

**Note:**
This is generally an improvement, but may affect code that relied on the previous behavior.

---

## New Features

### Browser Version Restrictions

```ruby
class ApplicationController < ActionController::Base
  allow_browser versions: :modern
end
```

### DevContainers

Rails 7.2 apps can generate DevContainer configuration:
```bash
rails new myapp --devcontainer
```

### PWA Support

Basic PWA files generated by default:
- `app/views/pwa/manifest.json.erb`
- `app/views/pwa/service-worker.js`

---

## Migration Steps

### Phase 1: Preparation
```bash
git checkout -b rails-72-upgrade

# Set up dual-boot
gem install next_rails
next_rails --init
```

### Phase 2: Gemfile Updates
```ruby
# Gemfile
if next?
  gem 'rails', '~> 7.2.0'
else
  gem 'rails', '~> 7.1.0'
end
```

### Phase 3: Fix Breaking Changes
1. Update `show_exceptions` to use symbols
2. Review jobs enqueued in transactions
3. Migrate secrets to credentials
4. Update `serialize` declarations
5. Fix params comparisons

### Phase 4: Configuration
```bash
rails app:update
```

### Phase 5: Testing
- Run full test suite
- Test job enqueuing behavior
- Verify credentials access
- Check serialized attributes

---

## Configuration Migration Checklist

- [ ] `show_exceptions` boolean → symbol
- [ ] `fixture_path` → `fixture_paths`
- [ ] `serialize` add type/coder
- [ ] Secrets → Credentials migration
- [ ] Review transaction job behavior

---

## Common Issues

### Issue: Jobs Not Processing

**Cause:** Transaction-aware enqueuing waiting for commit

**Fix:**
Use `after_commit` callback or check transaction is committed

### Issue: Invalid show_exceptions Value

**Error:** `ArgumentError: Invalid show_exceptions value`

**Fix:**
```ruby
config.action_dispatch.show_exceptions = :all  # Not true/false
```

### Issue: Secrets Method Not Found

**Error:** `NoMethodError: undefined method 'secrets'`

**Fix:**
```ruby
Rails.application.credentials.key_name
```

---

## Resources

- [Rails 7.2 Release Notes](https://guides.rubyonrails.org/7_2_release_notes.html)
- [RailsDiff 7.1 to 7.2](http://railsdiff.org/7.1.0/7.2.0)
- [Credentials Guide](https://guides.rubyonrails.org/security.html#custom-credentials)
