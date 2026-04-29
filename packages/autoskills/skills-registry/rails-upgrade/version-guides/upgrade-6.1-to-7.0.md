# Rails 6.1 → 7.0 Upgrade Guide

**Ruby Requirement:** 2.7.0+ (3.0+ recommended)

---

## Overview

Rails 7.0 is a major release focused on frontend modernization:
- **Hotwire** (Turbo + Stimulus) replaces Turbolinks + UJS
- **Import Maps** as default JavaScript solution
- **Webpacker removed** from default stack
- **Encrypted attributes** by default
- **Zeitwerk mode only** (classic autoloader removed)

---

## Breaking Changes

### 🔴 HIGH PRIORITY

#### 1. Ruby 2.7+ Required

**What Changed:**
Rails 7.0 requires Ruby 2.7.0 or newer. Ruby 3.0+ is recommended.

**Fix:**
```bash
# Update Ruby first
rbenv install 3.1.4
rbenv local 3.1.4
```

---

#### 2. Webpacker → Import Maps / jsbundling-rails

**What Changed:**
Webpacker is no longer the default. Choose:
- **Import Maps** (default) - No bundling, native ES modules
- **jsbundling-rails** - Use esbuild, rollup, or webpack
- **Keep Webpacker** - Still works but not maintained

**Detection Pattern:**
```ruby
# Gemfile
gem 'webpacker'

# Views
<%= javascript_pack_tag 'application' %>
```

**Migration Options:**

**Option A: Import Maps (Simplest)**
```bash
rails importmap:install
```

```erb
<!-- BEFORE (Webpacker) -->
<%= javascript_pack_tag 'application' %>

<!-- AFTER (Import Maps) -->
<%= javascript_importmap_tags %>
```

**Option B: jsbundling-rails (esbuild)**
```bash
rails javascript:install:esbuild
```

```erb
<!-- BEFORE (Webpacker) -->
<%= javascript_pack_tag 'application' %>

<!-- AFTER (jsbundling) -->
<%= javascript_include_tag 'application', 'data-turbo-track': 'reload' %>
```

---

#### 3. Turbolinks → Turbo

**What Changed:**
Turbolinks is replaced by Turbo (part of Hotwire).

**Detection Pattern:**
```ruby
# Gemfile
gem 'turbolinks'

# JavaScript
import Turbolinks from 'turbolinks'
Turbolinks.start()
```

**Fix:**
```ruby
# Gemfile
gem 'turbo-rails'
```

```javascript
// BEFORE
import Turbolinks from 'turbolinks'
Turbolinks.start()

// AFTER
import "@hotwired/turbo-rails"
```

**Event Changes:**
```javascript
// BEFORE (Turbolinks)
document.addEventListener('turbolinks:load', function() {
  // code
})

// AFTER (Turbo)
document.addEventListener('turbo:load', function() {
  // code
})
```

| Turbolinks Event | Turbo Event |
|-----------------|-------------|
| turbolinks:load | turbo:load |
| turbolinks:click | turbo:click |
| turbolinks:before-visit | turbo:before-visit |
| turbolinks:visit | turbo:visit |
| turbolinks:before-render | turbo:before-render |
| turbolinks:render | turbo:render |

---

#### 4. Rails UJS → Turbo / Stimulus

**What Changed:**
`rails-ujs` functionality is now handled by Turbo and Stimulus.

**Detection Pattern:**
```javascript
import Rails from '@rails/ujs'
Rails.start()
```

```erb
<%= link_to 'Delete', item, method: :delete %>
<%= link_to 'Delete', item, data: { confirm: 'Sure?' } %>
```

**Fix:**

```erb
<!-- BEFORE (UJS) -->
<%= link_to 'Delete', item, method: :delete %>

<!-- AFTER (Turbo) -->
<%= button_to 'Delete', item, method: :delete %>
<!-- or -->
<%= link_to 'Delete', item, data: { turbo_method: :delete } %>
```

```erb
<!-- BEFORE (UJS confirm) -->
<%= link_to 'Delete', item, data: { confirm: 'Sure?' } %>

<!-- AFTER (Turbo confirm) -->
<%= link_to 'Delete', item, data: { turbo_confirm: 'Sure?' } %>
```

---

#### 5. form_with Remote Behavior Change

**What Changed:**
`form_with` now submits forms with Turbo (remote by default).

**Detection Pattern:**
```erb
<%= form_with model: @item, local: true do |f| %>
```

**Fix:**
```erb
<!-- BEFORE (explicit local: true) -->
<%= form_with model: @item, local: true do |f| %>

<!-- AFTER (Turbo handles everything) -->
<%= form_with model: @item do |f| %>

<!-- To disable Turbo on a form -->
<%= form_with model: @item, data: { turbo: false } do |f| %>
```

---

### 🟡 MEDIUM PRIORITY

#### 6. secrets.yml → credentials

**What Changed:**
`Rails.application.secrets` is deprecated.

**Detection Pattern:**
```ruby
Rails.application.secrets.secret_key
```

**Fix:**
```ruby
# BEFORE
Rails.application.secrets.api_key

# AFTER
Rails.application.credentials.api_key

# Or with dig for nested values
Rails.application.credentials.dig(:aws, :access_key_id)
```

**Migration:**
```bash
# Edit credentials
rails credentials:edit

# For environment-specific
rails credentials:edit --environment production
```

---

#### 7. Enum Syntax Changes

**What Changed:**
New enum syntax available (hash form preferred).

**Fix:**
```ruby
# BEFORE (still works)
enum status: [:draft, :published, :archived]

# AFTER (preferred)
enum status: { draft: 0, published: 1, archived: 2 }

# With options
enum :status, { draft: 0, published: 1 }, prefix: true
```

---

#### 8. image_tag skip_pipeline Removed

**What Changed:**
`skip_pipeline` option removed from `image_tag`.

**Fix:**
```erb
<!-- BEFORE -->
<%= image_tag 'logo.png', skip_pipeline: true %>

<!-- AFTER -->
<%= image_tag 'logo.png' %>
```

---

#### 9. to_s(:format) Deprecated

**What Changed:**
`to_s(:format)` is deprecated in favor of `to_fs(:format)`.

**Detection Pattern:**
```ruby
date.to_s(:short)
time.to_s(:db)
```

**Fix:**
```ruby
# BEFORE
Date.today.to_s(:short)

# AFTER
Date.today.to_fs(:short)
```

---

## Migration Steps

### Phase 1: Preparation
```bash
git checkout -b rails-70-upgrade

# Upgrade Ruby first
rbenv install 3.1.4
rbenv local 3.1.4
```

### Phase 2: Gemfile Updates
```ruby
# Gemfile
gem 'rails', '~> 7.0.0'

# Remove
# gem 'webpacker'
# gem 'turbolinks'
# gem 'rails-ujs'  (if standalone)

# Add
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'importmap-rails'  # or jsbundling-rails
```

```bash
bundle update rails
rails turbo:install stimulus:install importmap:install
```

### Phase 3: Frontend Migration
1. Update JavaScript imports
2. Replace Turbolinks events with Turbo events
3. Update UJS patterns (method: :delete, confirm:)
4. Test all forms and links

### Phase 4: Configuration
```bash
rails app:update
```

Update `config/application.rb`:
```ruby
config.load_defaults 7.0
```

### Phase 5: Testing
- Test all form submissions
- Test delete links
- Test JavaScript interactions
- Verify Turbo frame/stream features

---

## Turbo Migration Checklist

- [ ] Remove turbolinks gem
- [ ] Add turbo-rails gem
- [ ] Update JavaScript imports
- [ ] Replace event listeners (turbolinks:* → turbo:*)
- [ ] Update method: :delete links
- [ ] Update data-confirm to data-turbo-confirm
- [ ] Remove remote: true (Turbo handles this)
- [ ] Test form submissions
- [ ] Test link navigation

---

## Common Issues

### Issue: Links with method: :delete Don't Work

**Error:** GET request instead of DELETE

**Cause:** Turbo requires button_to or data-turbo-method

**Fix:**
```erb
<%= button_to 'Delete', item, method: :delete %>
```

### Issue: Forms Submit Twice

**Cause:** Both UJS and Turbo handling forms

**Fix:** Remove rails-ujs completely

### Issue: JavaScript Not Loading

**Cause:** Import Maps not configured

**Fix:**
```erb
<%= javascript_importmap_tags %>
```

---

## Gem Compatibility

| Gem | Minimum Version |
|-----|-----------------|
| devise | 4.8.0 |
| cancancan | 3.3.0 |
| sidekiq | 6.0.0 |
| rspec-rails | 5.0.0 |
| capybara | 3.36.0 |

---

## Resources

- [Rails 7.0 Release Notes](https://guides.rubyonrails.org/7_0_release_notes.html)
- [Hotwire Documentation](https://hotwired.dev)
- [Turbo Handbook](https://turbo.hotwired.dev/handbook/introduction)
- [Import Maps Guide](https://github.com/rails/importmap-rails)
