# Rails 4.1 → 4.2 Upgrade Guide

**Ruby Requirement:** 1.9.3+ (2.0+ recommended)

**Based on "The Complete Guide to Upgrade Rails" by FastRuby.io (OmbuLabs), the official Rails 4.2 upgrade guide, and the FastRuby.io upgrade blog post.**

---

## Overview

Rails 4.2 is a minor release that introduces async infrastructure and several extractions:
- **ActiveJob** framework + ActionMailer integration (`deliver_now` / `deliver_later`)
- **Web Console** in development (IRB on error pages, `<%= console %>` helper)
- **Adequate Record** query performance improvements (transparent)
- **Native foreign-key DSL** in migrations
- **Loofah-based HTML sanitizer** replaces html-scanner
- **Masked per-request CSRF tokens** (SSL attack mitigation)
- **`responders` gem** now external (`respond_with`, class-level `respond_to`)

---

## Breaking Changes

### 🔴 HIGH PRIORITY

#### 1. ActionMailer `#deliver` / `#deliver!` Deprecated

**What Changed:**
`deliver` and `deliver!` are deprecated. The direct, bang-preserving replacements are `deliver_now` and `deliver_now!` (synchronous). `deliver_later` is a new async option that enqueues the mail via ActiveJob.

Calling a mailer method is also now lazy — the instance method runs when you call `deliver_now` / `deliver_later`, not when you call the class method. Code that relied on the old eager behavior for non-mailing work should move to class methods on the mailer.

**Detection Pattern:**
```ruby
UserMailer.welcome(user).deliver
NotificationMailer.daily_summary(user).deliver!
```

**Fix:**
```ruby
# BEFORE
UserMailer.welcome(user).deliver
NotificationMailer.daily_summary(user).deliver!

# AFTER — synchronous (direct drop-in replacements)
UserMailer.welcome(user).deliver_now
NotificationMailer.daily_summary(user).deliver_now!

# AFTER — enqueued via ActiveJob (preferred for non-urgent mail)
UserMailer.welcome(user).deliver_later
```

`deliver_later` requires an ActiveJob queue adapter (Sidekiq, Resque, etc.) for production use.

---

#### 2. `respond_with` / Class-Level `respond_to` Extracted

**What Changed:**
The `respond_with` helper and class-level `respond_to` declarations were extracted from Rails core into the [`responders`](https://github.com/heartcombo/responders) gem.

Action-level `respond_to do |format| ... end` blocks are NOT affected — they remain in Rails core.

**Detection Pattern:**
```ruby
class UsersController < ApplicationController
  respond_to :html, :json  # class-level — affected

  def show
    @user = User.find(params[:id])
    respond_with(@user)    # affected
  end

  def index
    @users = User.all
    respond_to do |format|  # NOT affected — stays in core
      format.html
      format.json { render json: @users }
    end
  end
end
```

**Fix:**
```ruby
# Gemfile
gem 'responders', '~> 2.0'
```

No code changes needed after adding the gem.

---

#### 3. Passing AR Object to `.find` / `.exists?` Deprecated

**What Changed:**
Passing an ActiveRecord object where an id is expected is deprecated — you must pass the id explicitly.

**Detection Pattern:**
```ruby
Comment.find(comment)
User.exists?(current_user)
```

**Fix:**
```ruby
# BEFORE
Comment.find(comment)
User.exists?(current_user)

# AFTER
Comment.find(comment.id)
User.exists?(current_user.id)
```

---

#### 4. Transactional Callback Exception Suppression

**What Changed:**
Exceptions raised in `after_commit` or `after_rollback` callbacks are still silently rescued by default in 4.2, but Rails now emits a deprecation warning. Rails 5.0+ removes the suppression entirely and always raises.

**Detection Pattern:**
Missing configuration:
```ruby
# config/application.rb
config.active_record.raise_in_transactional_callbacks = true
```

**Fix:**
Opt into the Rails 5.0 behavior to surface callback bugs now:
```ruby
# config/application.rb
config.active_record.raise_in_transactional_callbacks = true
```

Without this flag, bugs in transactional callbacks become silent warnings that you'll have to address in the Rails 5.0 hop anyway.

---

#### 5. `assert_tag` / `TagAssertions` Deprecated

**What Changed:**
`assert_tag` and the `TagAssertions` module are deprecated. Use `assert_select` from `SelectorAssertions` (now in the `rails-dom-testing` gem, bundled with Rails 4.2).

**Detection Pattern:**
```ruby
assert_tag :tag => "a", :attributes => { :href => "/foo" }
```

**Fix:**
```ruby
# BEFORE
assert_tag :tag => "a", :attributes => { :href => "/foo" }

# AFTER
assert_select "a[href='/foo']"
```

---

### 🟡 MEDIUM PRIORITY

#### 6. HTML Sanitizer Rewritten (Loofah/Nokogiri)

**What Changed:**
`sanitize`, `sanitize_css`, `strip_tags`, and `strip_links` are now backed by [Loofah](https://github.com/flavorjones/loofah) (via Nokogiri). Output may differ for edge-case inputs. `sanitize` also now accepts a `Loofah::Scrubber` — two new scrubbers ship with Rails: `PermitScrubber` and `TargetScrubber`.

**Detection Pattern:**
```ruby
sanitize(html_string)
strip_tags(html_string)
```

**Fix:**
Review tests that assert on sanitized output. If specific outputs diverge in ways you can't accommodate, temporarily restore the old sanitizer:
```ruby
# Gemfile (temporary fallback — Rails 4.2 only)
gem 'rails-deprecated_sanitizer'
```

---

#### 7. Serialized Attributes with Custom Coder: `nil` Handling

**What Changed:**
Assigning `nil` to a serialized attribute with a custom coder (e.g., `serialize :metadata, JSON`) now saves `NULL` to the database instead of passing `nil` through the coder. Previously, JSON coder would have stored the string `"null"`.

**Detection Pattern:**
```ruby
class User < ActiveRecord::Base
  serialize :metadata, JSON
end

user.metadata = nil
user.save!  # Now saves NULL, not "null"
```

**Fix:**
Review code and tests that relied on the coder's nil representation. If you need the old behavior, store `JSON.generate(nil)` explicitly.

---

#### 8. `config.active_support.test_order` Required

**What Changed:**
Rails 4.2 emits a deprecation warning when `test_order` is not explicitly set. The default becomes `:random`.

**Detection Pattern:**
Missing setting in `config/environments/test.rb`.

**Fix:**
```ruby
# config/environments/test.rb

# Run tests in random order (recommended)
config.active_support.test_order = :random

# Or preserve 4.1's implicit sorted behavior
# config.active_support.test_order = :sorted
```

---

#### 9. `config.serve_static_assets` Renamed

**What Changed:**
`config.serve_static_assets` was renamed to `config.serve_static_files`. In production, the default generated config now uses an ENV var.

**Detection Pattern:**
```ruby
config.serve_static_assets = true
```

**Fix:**
```ruby
# BEFORE (config/environments/test.rb)
config.serve_static_assets = true

# AFTER
config.serve_static_files = true

# BEFORE (config/environments/production.rb)
config.serve_static_assets = false

# AFTER (Rails 4.2 default)
config.serve_static_files = ENV['RAILS_SERVE_STATIC_FILES'].present?
```

---

#### 10. Production Log Level Default Changed

**What Changed:**
The default `config.log_level` in `config/environments/production.rb` changed from `:info` to `:debug`. This makes production logs much noisier.

**Fix:**
If you want to keep the 4.1 behavior:
```ruby
# config/environments/production.rb
config.log_level = :info
```

---

#### 11. Masked CSRF Tokens (Per-Request)

**What Changed:**
`form_authenticity_token` is now masked and varies per request (SSL attack mitigation). Non-Rails forms or external clients that cache a single token will break.

**Detection Pattern:**
```ruby
form_authenticity_token
```

**Fix:**
Rails form helpers handle masking automatically. If you build forms outside Rails (e.g., a static page posting to your app), fetch the token per request rather than caching it.

---

### 🟢 LOW PRIORITY

#### 12. Rack Server Bind Host Changed

**What Changed:**
Rails 4.2's bundled Rack binds `rails server` to `localhost` instead of `0.0.0.0` by default. Docker, Vagrant, and remote-access setups break.

**Detection Pattern:**
```
# Procfile without explicit bind
web: bundle exec rails s
```

**Fix:**
```
# Procfile
web: bundle exec rails s -b 0.0.0.0

# Or per command
rails server -b 0.0.0.0 -p 3000
```

---

#### 13. Foreigner → Native Foreign Keys (Optional)

**What Changed:**
Rails 4.2 ships with a native foreign-key DSL for migrations. You can now drop the [`foreigner`](https://github.com/matthuhiggins/foreigner) gem if its features are a match.

**Detection Pattern:**
```ruby
# Gemfile
gem 'foreigner'
```

**Fix (optional):**
1. Remove `gem 'foreigner'` from your Gemfile
2. `bundle install`
3. `bin/rake db:schema:dump`
4. Verify `db/schema.rb` still matches your database

Rails' FK support is a subset of Foreigner's — keep the gem if you use its advanced features (e.g., `:dependent => :restrict`).

New migration API:
```ruby
add_foreign_key :posts, :users
# or in a table definition
t.references :user, foreign_key: true
```

---

#### 14. Timecop Replaceable with Built-in Time Helpers

**What Changed:**
Rails 4.2 adds `travel`, `travel_to`, and `travel_back` test helpers via `ActiveSupport::Testing::TimeHelpers`. These replace most Timecop use cases.

**Detection Pattern:**
```ruby
gem 'timecop'
Timecop.freeze(...)
```

**Fix:**
```ruby
# BEFORE
Timecop.freeze(Time.zone.local(2024, 1, 1)) do
  # test code
end

# AFTER
travel_to Time.zone.local(2024, 1, 1) do
  # test code
end
```

Keep Timecop if you use its rate feature (e.g., "1 second = 1 hour").

---

#### 15. RSpec 2 Not Supported

**What Changed:**
Rails 4.2 does not support RSpec 2. You must upgrade to RSpec 3 before (or alongside) the Rails upgrade.

**Fix:**
Upgrade in two steps:
1. Upgrade to `rspec-rails ~> 2.99` (prints all 3.0 deprecation warnings). Fix every deprecation.
2. Upgrade to `rspec-rails ~> 3.x`.

Consider [Transpec](http://yujinakayama.me/transpec/) to automate common 2 → 3 syntax conversions.

---

## New Gemfile Defaults

Rails 4.2 generates new applications with these additions — consider adopting them:

```ruby
# Gemfile

group :development do
  gem 'web-console', '~> 2.0'  # interactive IRB on error pages
  gem 'spring'                  # preloader (moved into :development group)
end

group :development, :test do
  gem 'byebug'                  # replaces the commented-out `debugger`
end
```

Version bumps for defaults:
- `sass-rails` `~> 4.0.3` → `~> 5.0`
- `coffee-rails` `~> 4.0.0` → `~> 4.1.0`

---

## Configuration File Changes

Run `bin/rake rails:update` to walk through config changes interactively. Key diffs to review:

### `config/application.rb`
Add (inside the Application class):
```ruby
config.active_record.raise_in_transactional_callbacks = true
```

### `config/environments/development.rb`
Add:
```ruby
config.assets.digest = true
```

### `config/environments/test.rb`
Add:
```ruby
config.active_support.test_order = :random
```

Rename:
```ruby
# BEFORE
config.serve_static_assets = true
# AFTER
config.serve_static_files = true
```

### `config/environments/production.rb`
Rename `serve_static_assets` to `serve_static_files`. Keep log level at `:info` if you want to preserve 4.1 behavior (default is now `:debug`).

### `config/initializers/to_time_preserves_timezone.rb` (NEW)
Forward-compat shim for Rails 5.0:
```ruby
# Preserve the timezone of the receiver when calling to_time.
# Ruby 2.4 will change the behavior of to_time to preserve the timezone.
ActiveSupport.to_time_preserves_timezone = true
```

### `bin/setup` (NEW)
New convention script that installs dependencies and sets up the app. Run `bin/rake rails:update:bin` to generate it.

---

## Migration Steps

### Phase 1: Preparation
```bash
git checkout -b rails-42-upgrade

# Verify Ruby version
ruby -v  # 1.9.3+; 2.0+ recommended
```

### Phase 2: Pre-requisites (before the Rails bump)
1. **Upgrade RSpec to 3.x** if using RSpec 2 (independent of Rails)
2. **Fix all current 4.1 deprecation warnings** — they become errors or silent failures in 4.2
3. **Add `gem 'responders', '~> 2.0'`** if using `respond_with`

### Phase 3: Gemfile Updates
```ruby
# Gemfile
gem 'rails', '~> 4.2.0'
gem 'responders', '~> 2.0'  # only if using respond_with
gem 'sass-rails', '~> 5.0'
gem 'coffee-rails', '~> 4.1.0'

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :development, :test do
  gem 'byebug'
end
```

```bash
bundle update rails
```

### Phase 4: Configuration
```bash
bin/rake rails:update
```

Cross-check against [RailsDiff 4.1.16 → 4.2.11.3](http://railsdiff.org/4.1.16/4.2.11.3) for the exact diff.

### Phase 5: Fix Breaking Changes
1. Replace `.deliver` / `.deliver!` with `.deliver_now` / `.deliver_now!` (or `.deliver_later` for async)
2. Replace `.find(obj)` / `.exists?(obj)` with `.find(obj.id)` / `.exists?(obj.id)`
3. Replace `assert_tag` with `assert_select`
4. Update `Procfile` with `-b 0.0.0.0` if external access needed
5. Review HTML sanitizer output in tests
6. Add `config.active_record.raise_in_transactional_callbacks = true`
7. Add `config.active_support.test_order = :random`
8. Rename `serve_static_assets` → `serve_static_files`
9. Consider replacing Timecop with `travel_to` (optional)
10. Consider dropping Foreigner for native FKs (optional)

### Phase 6: Testing
- Run full test suite
- Test email delivery (`deliver_now` vs `deliver_later`)
- Test `after_commit` / `after_rollback` callbacks
- Test forms with HTML-sanitized content
- Test any code that caches `form_authenticity_token`
- Test serialized attributes that may receive `nil`

---

## Common Issues

### Issue: Email delivery broken after upgrade

**Error:** `NoMethodError: undefined method 'deliver' for #<Mail::Message>`

**Cause:** `deliver` was deprecated in 4.2 and removed in later versions

**Fix:** `Mailer.welcome(user).deliver_now` (or `.deliver_later`)

### Issue: `respond_with` raises NoMethodError

**Error:** `undefined method 'respond_with' for ApplicationController`

**Cause:** Extracted to the `responders` gem

**Fix:** `gem 'responders', '~> 2.0'`

### Issue: Transactional callback bugs became silent

**Symptom:** Data inconsistencies that tests don't catch

**Cause:** Rails 4.2 silently suppresses exceptions in `after_commit` / `after_rollback`

**Fix:** `config.active_record.raise_in_transactional_callbacks = true`

### Issue: Can't reach `rails server` from another machine

**Error:** Connection refused or timeout

**Cause:** Rails 4.2 binds to `localhost` by default

**Fix:** `rails server -b 0.0.0.0`

### Issue: JSON serialized attributes with `nil` now save NULL

**Symptom:** Records that used to store `"null"` now store `NULL`

**Cause:** Serialized attribute nil-handling changed

**Fix:** If the coder's nil string was intentional, assign `JSON.generate(nil)` explicitly. Otherwise, `NULL` is the better default.

### Issue: External forms fail CSRF verification

**Symptom:** `InvalidAuthenticityToken` on forms submitted from static pages

**Cause:** CSRF tokens now masked per-request

**Fix:** Fetch a fresh token per request; don't cache

---

## Resources

- [Rails 4.2 Release Notes](https://guides.rubyonrails.org/v4.2/4_2_release_notes.html)
- [Upgrading from Rails 4.1 to Rails 4.2 (official)](https://guides.rubyonrails.org/v4.2/upgrading_ruby_on_rails.html#upgrading-from-rails-4-1-to-rails-4-2)
- [FastRuby.io: Upgrade Rails from 4.1 to 4.2](https://www.fastruby.io/blog/rails/upgrades/upgrade-rails-from-4-1-to-4-2.html)
- [RailsDiff 4.1.16 → 4.2.11.3](http://railsdiff.org/4.1.16/4.2.11.3)
- [`responders` gem](https://github.com/heartcombo/responders)
- [`web-console` gem](https://github.com/rails/web-console)
- [ActiveSupport::Testing::TimeHelpers](https://api.rubyonrails.org/v4.2/classes/ActiveSupport/Testing/TimeHelpers.html)
