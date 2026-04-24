# Rails 6.0 → 6.1 Upgrade Guide

**Ruby Requirement:** 2.5.0+ (2.7+ recommended)

**Based on "The Complete Guide to Upgrade Rails" by FastRuby.io (OmbuLabs)**

---

## Overview

Rails 6.1 introduces:
- **Horizontal database sharding** support
- **Strict loading** to prevent N+1 queries
- **Per-database connection switching**
- **Destroy associations async**
- **Error objects** in Active Model

---

## Breaking Changes

### 🔴 HIGH PRIORITY

#### 1. config_for Returns HashWithIndifferentAccess

**What Changed:**
`Rails.application.config_for` now returns `ActiveSupport::HashWithIndifferentAccess` instead of `Hash`.

**Detection Pattern:**
```ruby
config = Rails.application.config_for(:some_config)
config.keys.first.class  # Was String, now can be accessed as symbol
```

**Fix:**
This is usually transparent, but if you're checking key types explicitly:
```ruby
# BEFORE (may break)
if config.keys.include?("database")

# AFTER (works with both)
if config.key?(:database) || config.key?("database")
```

---

#### 2. respond_to#any Content-Type Change

**What Changed:**
`respond_to#any` now returns `text/html` Content-Type instead of `*/*`.

**Detection Pattern:**
```ruby
respond_to do |format|
  format.any { render json: @data }
end
```

**Fix:**
If you need specific Content-Type, use explicit format:
```ruby
# BEFORE
respond_to do |format|
  format.any { render json: @data }
end

# AFTER (explicit JSON)
respond_to do |format|
  format.json { render json: @data }
  format.any { render json: @data, content_type: 'application/json' }
end
```

---

#### 3. HTTPS Redirects Use 308 Status

**What Changed:**
`config.force_ssl` now uses HTTP status 308 instead of 301 for redirects.

**Impact:**
308 preserves the HTTP method (POST stays POST). This is usually correct behavior, but may affect some clients.

**Fix:**
If you need the old 301 behavior:
```ruby
# config/environments/production.rb
config.ssl_options = { redirect: { status: 301 } }
```

---

#### 4. ActiveSupport::Callbacks Default Changed

**What Changed:**
`:unless` and `:if` callbacks now default to `:before` rather than `:after`.

**Detection Pattern:**
```ruby
set_callback :save, :around, :my_callback, if: :condition
```

**Fix:**
Be explicit about callback type:
```ruby
set_callback :save, :around, :my_callback, if: :condition, prepend: true
```

---

### 🟡 MEDIUM PRIORITY

#### 5. ActiveRecord::Base.allow_unsafe_raw_sql Removed

**What Changed:**
The `allow_unsafe_raw_sql` configuration has been removed.

**Detection Pattern:**
```ruby
ActiveRecord::Base.allow_unsafe_raw_sql = :enabled
```

**Fix:**
Remove the configuration. Use `Arel.sql()` for raw SQL:
```ruby
# BEFORE
Model.order("FIELD(id, #{ids.join(',')})")

# AFTER
Model.order(Arel.sql("FIELD(id, #{ids.join(',')})"))
```

---

#### 6. ActiveModel::Errors API Change

**What Changed:**
`ActiveModel::Errors` now returns `Error` objects instead of strings.

**Detection Pattern:**
```ruby
user.errors[:email].first  # Was String
user.errors.full_messages  # Still works
```

**Fix:**
```ruby
# BEFORE
error_string = user.errors[:email].first

# AFTER
error = user.errors.where(:email).first
error.message  # Get the message
error.full_message  # Get full message with attribute name
```

---

#### 7. find_or_create_by Behavior Change

**What Changed:**
`find_or_create_by` now handles race conditions better, but behavior changed slightly.

**Detection Pattern:**
```ruby
User.find_or_create_by(email: email)
```

**Fix:**
No changes needed for typical usage. If you relied on specific exception behavior, test thoroughly.

---

## New Features

### Horizontal Database Sharding

```ruby
# database.yml
production:
  primary:
    database: my_primary
  primary_shard_one:
    database: my_shard_one
```

### Strict Loading (Prevent N+1)

```ruby
class User < ApplicationRecord
  has_many :posts, strict_loading: true
end

# Or at query time
User.strict_loading.includes(:posts).first
```

### Destroy Associations Async

```ruby
class User < ApplicationRecord
  has_many :posts, dependent: :destroy_async
end
```

---

## Migration Steps

### Phase 1: Preparation
```bash
git checkout -b rails-61-upgrade

# Set up dual-boot
gem install next_rails
next_rails --init
```

### Phase 2: Gemfile Updates
```ruby
# Gemfile
if next?
  gem 'rails', '~> 6.1.0'
else
  gem 'rails', '~> 6.0.0'
end
```

### Phase 3: Fix Breaking Changes
1. Review `config_for` usage
2. Check `respond_to#any` blocks
3. Test SSL redirects if critical
4. Update `ActiveModel::Errors` usage

### Phase 4: Configuration
```bash
rails app:update
```

Update `config/application.rb`:
```ruby
config.load_defaults 6.1
```

### Phase 5: Testing
- Run full test suite
- Test forms with validations
- Test API responses Content-Type
- Verify SSL redirects work correctly

---

## Configuration Migration Checklist

- [ ] Review `config_for` usage for hash access patterns
- [ ] Check `respond_to#any` blocks for Content-Type expectations
- [ ] Test SSL redirect behavior
- [ ] Update `ActiveModel::Errors` usage if accessing errors directly
- [ ] Update `load_defaults` to 6.1

---

## Common Issues

### Issue: Content-Type Mismatch in API Responses

**Error:** Client receives `text/html` instead of `application/json`

**Cause:** `respond_to#any` Content-Type change

**Fix:**
```ruby
format.json { render json: @data }
```

### Issue: SSL Redirect Loops with POST Requests

**Cause:** 308 status code preserves method, may confuse some proxies

**Fix:**
```ruby
config.ssl_options = { redirect: { status: 301 } }
```

### Issue: Errors Behave Differently

**Error:** `NoMethodError: undefined method 'include?' for #<ActiveModel::Error>`

**Cause:** Errors are now objects, not strings

**Fix:**
```ruby
user.errors.where(:email).map(&:message)
```

---

## Resources

- [Rails 6.1 Release Notes](https://guides.rubyonrails.org/6_1_release_notes.html)
- [RailsDiff 6.0 to 6.1](http://railsdiff.org/6.0.6/6.1.0)
- [Horizontal Sharding Guide](https://guides.rubyonrails.org/active_record_multiple_databases.html)
