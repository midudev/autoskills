# Rails 5.1 → 5.2 Upgrade Guide

**Ruby Requirement:** 2.2.2+ (2.5+ recommended)

**Based on "The Complete Guide to Upgrade Rails" by FastRuby.io (OmbuLabs)**

---

## Overview

Rails 5.2 introduces:
- **Active Storage** for file uploads
- **Credentials** (replaces encrypted secrets)
- **Bootsnap** for faster boot times
- **Content Security Policy** DSL
- **Redis Cache Store** improvements
- **Early Hints** support (HTTP 103)

---

## Breaking Changes

### 🔴 HIGH PRIORITY

#### 1. Bootsnap Required for Performance

**What Changed:**
Rails 5.2 recommends bootsnap for faster boot times.

**Fix:**
```ruby
# Gemfile
gem 'bootsnap', require: false
```

```ruby
# config/boot.rb (add at top)
require 'bootsnap/setup'
```

---

#### 2. Cookie Expiry Format Changed

**What Changed:**
Signed/encrypted cookie expiry timestamps are now embedded in the cookie value.

**Impact:**
Cookies set before upgrading may be reset after upgrading.

**Fix:**
This is handled automatically. Users may need to re-login after upgrade.

For explicit control:
```ruby
# config/initializers/cookies_serializer.rb
Rails.application.config.action_dispatch.use_authenticated_cookie_encryption = true
```

---

#### 3. Active Record attribute_changed? Behavior

**What Changed:**
`attribute_changed?` and related methods now return `false` after saving, even if the record was changed.

**Detection Pattern:**
```ruby
user.name = 'New Name'
user.save
user.name_changed?  # Was true, now false
```

**Fix:**
Use `saved_changes` or `previous_changes` after save:
```ruby
# BEFORE (checking after save)
user.save
user.name_changed?

# AFTER
user.save
user.saved_change_to_name?
user.saved_changes[:name]
```

---

#### 4. ActiveStorage Attachment Changes

**What Changed:**
Active Storage is new and becomes the recommended approach for file uploads.

**Impact:**
If upgrading from CarrierWave or Paperclip, consider migration (optional).

**Fix:**
If adding Active Storage:
```bash
rails active_storage:install
rails db:migrate
```

---

### 🟡 MEDIUM PRIORITY

#### 5. Encrypted Secrets → Credentials

**What Changed:**
`secrets.yml.enc` is replaced by `credentials.yml.enc`.

**Detection Pattern:**
```ruby
Rails.application.secrets.secret_key
```

**Fix:**
Migrate to credentials:
```bash
rails credentials:edit
```

```ruby
# BEFORE
Rails.application.secrets.api_key

# AFTER
Rails.application.credentials.api_key
```

---

#### 6. DSL for Content Security Policy

**What Changed:**
New DSL for configuring Content Security Policy.

**Fix:**
Create initializer:
```ruby
# config/initializers/content_security_policy.rb
Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self, :https
    policy.script_src  :self, :https
    policy.style_src   :self, :https, :unsafe_inline
  end
end
```

---

#### 7. force_ssl Now 301 Redirect

**What Changed:**
`force_ssl` now uses 301 (permanent) redirects instead of 302.

**Impact:**
Browsers will cache the redirect. Be careful with staging/development URLs.

**Fix:**
If you need 302:
```ruby
config.ssl_options = { redirect: { status: 302 } }
```

---

#### 8. per_form_csrf_tokens Default Changed

**What Changed:**
`per_form_csrf_tokens` is now enabled by default.

**Detection Pattern:**
```ruby
config.action_controller.per_form_csrf_tokens = false
```

**Impact:**
Forms need fresh CSRF tokens. May affect caching of forms.

**Fix:**
Keep it enabled (more secure) or explicitly disable:
```ruby
config.action_controller.per_form_csrf_tokens = false
```

---

## New Features

### Active Storage

```ruby
class User < ApplicationRecord
  has_one_attached :avatar
  has_many_attached :documents
end
```

```erb
<%= form.file_field :avatar %>
<%= image_tag @user.avatar %>
```

### Credentials

```bash
# Edit credentials
rails credentials:edit

# Access in code
Rails.application.credentials.aws[:access_key_id]
```

### Content Security Policy

```ruby
# Per-action CSP
class PostsController < ApplicationController
  content_security_policy do |policy|
    policy.script_src :self, :https
  end
end
```

### Redis Cache Store

```ruby
config.cache_store = :redis_cache_store, {
  url: ENV['REDIS_URL'],
  expires_in: 1.hour
}
```

---

## Migration Steps

### Phase 1: Preparation
```bash
git checkout -b rails-52-upgrade
```

### Phase 2: Gemfile Updates
```ruby
# Gemfile
gem 'rails', '~> 5.2.0'
gem 'bootsnap', require: false
```

```bash
bundle update rails
```

### Phase 3: Add Bootsnap
```ruby
# config/boot.rb (add after bundler setup)
require 'bootsnap/setup'
```

### Phase 4: Fix Breaking Changes
1. Update attribute dirty tracking usage
2. Migrate secrets to credentials (optional)
3. Review CSRF token settings

### Phase 5: Configuration
```bash
rails app:update
```

Update `config/application.rb`:
```ruby
config.load_defaults 5.2
```

### Phase 6: Testing
- Run full test suite
- Test file uploads (if using Active Storage)
- Test authentication (cookies may reset)
- Verify CSRF protection works

---

## Active Record Dirty Tracking Migration

| Rails 5.1 Method | Rails 5.2 Method |
|-----------------|------------------|
| `attribute_changed?` (after save) | `saved_change_to_attribute?` |
| `attribute_was` (after save) | `attribute_before_last_save` |
| `attribute_change` (after save) | `saved_change_to_attribute` |
| `changed?` (after save) | `saved_changes?` |
| `changes` (after save) | `saved_changes` |

---

## Configuration Migration Checklist

- [ ] Add bootsnap gem and setup
- [ ] Review attribute dirty tracking usage
- [ ] Consider migrating to credentials
- [ ] Review CSRF token settings
- [ ] Set up Content Security Policy (optional)
- [ ] Update `load_defaults` to 5.2

---

## Common Issues

### Issue: Dirty Tracking Returns False After Save

**Error:** `attribute_changed?` returns `false` after save

**Cause:** Behavior change in Rails 5.2

**Fix:**
```ruby
user.saved_change_to_name?  # Use this after save
```

### Issue: CSRF Token Invalid

**Error:** `ActionController::InvalidAuthenticityToken`

**Cause:** per_form_csrf_tokens now default

**Fix:**
Ensure forms include fresh CSRF token, or disable feature.

### Issue: Cookies Reset After Upgrade

**Cause:** Cookie encryption format changed

**Fix:**
Expected behavior. Users need to re-authenticate once.

---

## Resources

- [Rails 5.2 Release Notes](https://guides.rubyonrails.org/5_2_release_notes.html)
- [RailsDiff 5.1 to 5.2](http://railsdiff.org/5.1.7/5.2.8)
- [Active Storage Guide](https://guides.rubyonrails.org/active_storage_overview.html)
- [Credentials Guide](https://guides.rubyonrails.org/security.html#custom-credentials)
