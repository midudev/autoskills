# Rails 5.0 → 5.1 Upgrade Guide

**Ruby Requirement:** 2.2.2+ (2.4+ recommended)

**Based on "The Complete Guide to Upgrade Rails" by FastRuby.io (OmbuLabs)**

---

## Overview

Rails 5.1 introduces:
- **Encrypted secrets** (`secrets.yml.enc`)
- **Yarn** as default for JavaScript packages
- **Webpack** support via webpacker gem
- **System tests** with Capybara
- **Parameterized mailers**
- **form_with** helper (unifies form_for and form_tag)

---

## Breaking Changes

### 🔴 HIGH PRIORITY

#### 1. HashWithIndifferentAccess Indexing Change

**What Changed:**
Non-symbol access in `HashWithIndifferentAccess` returns `nil` for non-existent keys instead of raising errors.

**Detection Pattern:**
```ruby
hash = HashWithIndifferentAccess.new
hash[:missing_key]  # Returns nil
hash[Object.new]    # Behavior changed
```

**Fix:**
Generally transparent. If you relied on specific behavior with non-string/symbol keys, test thoroughly.

---

#### 2. render :text Removed

**What Changed:**
`render text: 'content'` has been removed.

**Detection Pattern:**
```ruby
render text: 'Hello World'
render text: 'OK', status: 200
```

**Fix:**
```ruby
# BEFORE
render text: 'Hello World'

# AFTER
render plain: 'Hello World'
```

---

#### 3. render :nothing Removed

**What Changed:**
`render nothing: true` has been removed.

**Detection Pattern:**
```ruby
render nothing: true
render nothing: true, status: 204
```

**Fix:**
```ruby
# BEFORE
render nothing: true

# AFTER
head :ok
# Or
head :no_content
```

---

#### 4. render :body Default Layout Removed

**What Changed:**
`render body:` no longer renders with a layout by default.

**Detection Pattern:**
```ruby
render body: 'raw content'
```

**Fix:**
If you need a layout:
```ruby
render body: 'raw content', layout: true
```

---

### 🟡 MEDIUM PRIORITY

#### 5. redirect_to :back Deprecated

**What Changed:**
`redirect_to :back` is deprecated.

**Detection Pattern:**
```ruby
redirect_to :back
redirect_to :back, notice: 'Done!'
```

**Fix:**
```ruby
# BEFORE
redirect_to :back

# AFTER
redirect_back(fallback_location: root_path)
redirect_back(fallback_location: root_path, notice: 'Done!')
```

---

#### 6. Positional Arguments in Process Methods

**What Changed:**
Controller test methods now prefer keyword arguments.

**Detection Pattern:**
```ruby
# In controller tests
get :show, { id: 1 }, { user_id: 1 }, { notice: 'Hi' }
post :create, { user: { name: 'Test' } }
```

**Fix:**
```ruby
# BEFORE (positional)
get :show, { id: 1 }, { user_id: 1 }, { notice: 'Hi' }
post :create, { user: { name: 'Test' } }

# AFTER (keyword)
get :show, params: { id: 1 }, session: { user_id: 1 }, flash: { notice: 'Hi' }
post :create, params: { user: { name: 'Test' } }
```

---

#### 7. ActiveRecord.raise_in_transactional_callbacks Removed

**What Changed:**
The configuration option has been removed (was deprecated in 5.0).

**Detection Pattern:**
```ruby
config.active_record.raise_in_transactional_callbacks = true
```

**Fix:**
Remove the configuration line. This is now the default behavior.

---

## New Features

### Encrypted Secrets

```bash
rails secrets:setup
rails secrets:edit
```

### System Tests

```ruby
# test/system/users_test.rb
class UsersTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end
end
```

### form_with Helper

```erb
<%= form_with model: @user do |f| %>
  <%= f.text_field :name %>
  <%= f.submit %>
<% end %>
```

### Parameterized Mailers

```ruby
class InvitationsMailer < ApplicationMailer
  before_action { @inviter, @invitee = params[:inviter], params[:invitee] }

  def invite
    mail(to: @invitee.email)
  end
end

# Usage
InvitationsMailer.with(inviter: @user, invitee: @friend).invite.deliver_later
```

---

## Migration Steps

### Phase 1: Preparation
```bash
git checkout -b rails-51-upgrade
```

### Phase 2: Gemfile Updates
```ruby
# Gemfile
gem 'rails', '~> 5.1.0'
```

```bash
bundle update rails
```

### Phase 3: Fix Breaking Changes
1. Replace `render text:` with `render plain:`
2. Replace `render nothing:` with `head :ok`
3. Replace `redirect_to :back` with `redirect_back`
4. Update controller test syntax to keyword arguments

### Phase 4: Configuration
```bash
rails app:update
```

Update `config/application.rb`:
```ruby
config.load_defaults 5.1
```

### Phase 5: Testing
- Run full test suite
- Test all render calls
- Test redirects
- Verify controller tests pass

---

## Configuration Migration Checklist

- [ ] Remove `render text:` calls
- [ ] Remove `render nothing:` calls
- [ ] Update `redirect_to :back` calls
- [ ] Update controller test syntax
- [ ] Remove deprecated config options
- [ ] Update `load_defaults` to 5.1

---

## Common Issues

### Issue: ActionView::Template::Error with render

**Error:** `Unknown keyword: text`

**Cause:** `render text:` no longer supported

**Fix:**
```ruby
render plain: 'content'
```

### Issue: redirect_to :back Fails

**Error:** `ActionController::RedirectBackError`

**Cause:** No referer and using deprecated syntax

**Fix:**
```ruby
redirect_back(fallback_location: root_path)
```

---

## Resources

- [Rails 5.1 Release Notes](https://guides.rubyonrails.org/5_1_release_notes.html)
- [RailsDiff 5.0 to 5.1](http://railsdiff.org/5.0.7/5.1.7)
- [Encrypted Secrets Guide](https://guides.rubyonrails.org/security.html#custom-credentials)
