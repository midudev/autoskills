# Rails 4.0 → 4.1 Upgrade Guide

**Ruby Requirement:** 1.9.3+ (2.0+ recommended)

**Based on "The Complete Guide to Upgrade Rails" by FastRuby.io (OmbuLabs), the [official Rails 4.1 upgrade guide](https://guides.rubyonrails.org/v4.1/upgrading_ruby_on_rails.html#upgrading-from-rails-4-0-to-rails-4-1), and the Rails 4.1 release notes.**

---

## Overview

Rails 4.1 is a minor release that polishes 4.0 and introduces several new features:
- **Spring** application preloader (new default)
- **`secrets.yml`** for centralized secret/credential management
- **Action Mailer previews** (browser-viewable emails in development)
- **ActiveRecord enums** (`enum status: [...]`)
- **Variants** (`request.variant = :tablet`)
- **`Module#concerning`** API

The breaking changes are smaller than 3.2 → 4.0 but several silently change behavior. Dynamic-finder removal, implicit-join removal, and PostgreSQL `json`/`hstore` key semantics are the most common sources of runtime failures.

---

## Breaking Changes

### 🔴 HIGH PRIORITY

#### 1. Dynamic Finders Removed

**What Changed:**
`activerecord-deprecated_finders` was removed as a Rails dependency. `find_all_by_*`, `find_last_by_*`, `scoped_by_*`, `find_or_initialize_by_*`, and `find_or_create_by_*` no longer work out of the box.

**Detection Pattern:**
```ruby
User.find_all_by_email(email)
User.find_last_by_email(email)
User.scoped_by_status("active")
User.find_or_initialize_by_email(email)
User.find_or_create_by_email(email)
```

**Fix:**
```ruby
# BEFORE
User.find_all_by_email(email)
User.find_last_by_email(email)
User.scoped_by_status("active")
User.find_or_initialize_by_email_and_name(email, name)
User.find_or_create_by_email(email)

# AFTER
User.where(email: email)
User.where(email: email).last
User.where(status: "active")
User.find_or_initialize_by(email: email, name: name)
User.find_or_create_by(email: email)
```

If you cannot migrate callers now, restore the bridge gem:
```ruby
# Gemfile
gem 'activerecord-deprecated_finders'
```

---

#### 2. `return` Inside Inline Callback Blocks

**What Changed:**
Using `return` inside an **inline callback block** now raises `LocalJumpError` at callback-execution time. This was never officially supported; a rewrite of `ActiveSupport::Callbacks` in 4.1 closed the accidental support.

**Scope:** this affects *inline blocks only* (`before_save { return false }`). Method-form callbacks (`before_save :guard` where `guard` contains `return false`) are unaffected — `return` there behaves normally and `false` still halts the chain on 4.1.

**Detection Pattern:**
```ruby
before_save { return false if invalid_state? }
```

**Fix:**
```ruby
# BEFORE
before_save { return false if invalid_state? }

# AFTER — evaluate to the value
before_save { false if invalid_state? }

# OR — extract to a method where `return` is fine
before_save :halt_if_invalid

def halt_if_invalid
  return false if invalid_state?
end
```

Note: in Rails 5+ the halt mechanism changes again — `false` no longer halts, use `throw :abort`.

See [rails/rails#13271](https://github.com/rails/rails/pull/13271).

---

#### 3. Implicit Join References Removed

**What Changed:**
`includes(...).where("other_table.col = ...")` no longer auto-joins the referenced table. The string-parsing heuristic was removed because it produced incorrect SQL in edge cases.

**Detection Pattern:**
```ruby
Post.includes(:comments).where("comments.title = ?", "foo")
```

**Fix:**
```ruby
# BEFORE
Post.includes(:comments).where("comments.title = ?", "foo")

# AFTER — explicit join (no eager load)
Post.joins(:comments).where("comments.title = ?", "foo")

# AFTER — eager load
Post.eager_load(:comments).where("comments.title = ?", "foo")

# AFTER — equivalent with includes + references
Post.includes(:comments).where("comments.title = ?", "foo").references(:comments)
```

If you see this warning:
```
DEPRECATION WARNING: Implicit join references were removed with Rails 4.1. Make sure to remove this configuration because it does nothing.
```
remove `config.active_record.disable_implicit_join_references` from your config.

See [rails/rails#9712](https://github.com/rails/rails/issues/9712) for background.

---

#### 4. PostgreSQL `json` / `hstore` / `array` Columns Return String-Keyed Data

**What Changed:**
In 4.0, PostgreSQL `json`, `hstore`, and `array` columns (and any `store_accessor` built on top of them) returned a `HashWithIndifferentAccess` or `ArrayWithIndifferentAccess` — symbol and string access both worked. In 4.1 they return plain `Hash` or `Array` with **string keys only**. Symbol access silently returns `nil`.

**Detection Pattern:**
```ruby
class Profile < ActiveRecord::Base
  # :preferences is a json or hstore column
  store_accessor :preferences, :theme
end

profile.preferences[:theme]   # 4.0: "dark" | 4.1: nil
profile.preferences["theme"]  # both: "dark"
```

**Fix:**
Use string keys consistently when reading from `json` / `hstore` attributes:
```ruby
# BEFORE
profile.preferences[:theme]

# AFTER
profile.preferences["theme"]
```

`store_accessor`-generated methods (`profile.theme`) still work — the change only bites direct hash lookups. Audit serializers, presenters, and `as_json` overrides that index into these attributes.

---

### 🟡 MEDIUM PRIORITY

#### 5. MultiJSON Removed from Rails

**What Changed:**
Rails 4.1 no longer depends on [`MultiJSON`](https://github.com/intridea/multi_json). Apps that reference `MultiJSON` directly will raise `NameError` once the transitive dependency goes away.

**Detection Pattern:**
```ruby
require 'multi_json'
MultiJSON.dump(obj)
MultiJSON.load(str)
```

**Fix:**
```ruby
# Option A — keep MultiJSON explicitly
# Gemfile
gem 'multi_json'

# Option B — migrate to core JSON
# BEFORE
MultiJSON.dump(obj)
MultiJSON.load(str)

# AFTER
obj.to_json
JSON.parse(str)
```

**Do not** blindly substitute `JSON.dump` / `JSON.load` — those are the `JSON` gem's arbitrary-object (de)serializers and are unsafe on untrusted input.

---

#### 6. Cookies Serializer Opt-In (Marshal → JSON / Hybrid)

**What Changed:**
Apps created before 4.1 keep `Marshal` as the signed/encrypted cookie serializer. Rails 4.1 introduces a JSON serializer and a `:hybrid` mode that reads legacy Marshal cookies and writes new JSON ones — but the default is still `Marshal` unless you opt in.

**Detection Pattern:**
Missing initializer. No `cookies_serializer` set in `config/initializers/` or `config/application.rb`.

**Fix:**
Add an initializer to migrate transparently:
```ruby
# config/initializers/cookies_serializer.rb
Rails.application.config.action_dispatch.cookies_serializer = :hybrid
```

Once all live cookies have rotated, switch to `:json` for the leaner path. Note that JSON cannot round-trip arbitrary Ruby objects — `Date`/`Time` become strings, symbol keys become strings. Store primitives only in cookie-backed sessions/flash.

---

#### 7. `default_scope` Chains with Other Scopes

**What Changed:**
In Rails 4.1, `default_scope` conditions are now combined (ANDed) with subsequent scopes instead of being overridden by them. Scopes that intentionally contradicted the default scope now produce zero rows.

**Detection Pattern:**
```ruby
class User < ActiveRecord::Base
  default_scope { where(active: true) }
  scope :inactive, -> { where(active: false) }
end

# Rails 4.0:  SELECT ... WHERE active = false
# Rails 4.1:  SELECT ... WHERE active = true AND active = false
User.inactive
```

**Fix:**
Use `unscoped`, `unscope(...)`, or the new `rewhere` method:
```ruby
scope :inactive, -> { unscope(where: :active).where(active: false) }
# or
scope :inactive, -> { rewhere(active: false) }
```

See [this commit](https://github.com/rails/rails/commit/f950b2699f97749ef706c6939a84dfc85f0b05f2).

---

#### 8. `ActiveRecord::Relation` Mutator Methods Removed

**What Changed:**
`#map!`, `#delete_if`, `#compact!`, and other mutator methods are no longer delegated from `Relation` to the underlying array. Call `#to_a` first.

**Detection Pattern:**
```ruby
Project.where(title: "Rails Upgrade").compact!
Project.where(...).map! { |p| ... }
Project.where(...).delete_if { |p| ... }
```

**Fix:**
```ruby
# BEFORE
Project.where(name: "Rails Upgrade").compact!

# AFTER
projects = Project.where(name: "Rails Upgrade").to_a
projects.compact!
```

---

#### 9. CSRF Protection Now Covers GET with JS Responses

**What Changed:**
GET requests with JS responses now enforce CSRF. Test helpers that issue `get` / `post :create, format: :js` must switch to `xhr` so Rails treats the request as XHR.

**Detection Pattern:**
```ruby
post :create, format: :js
get :index, format: :js
```

**Fix:**
```ruby
# BEFORE
post :create, format: :js

# AFTER
xhr :post, :create, format: :js
```

If you legitimately want to serve JS to remote `<script>` tags, skip CSRF on that specific action.

Forward-compat note: the `xhr :verb, :action, ...` syntax is itself removed in Rails 5.0. The 5.0 replacement is `verb :action, params: {...}, xhr: true` (or `process :action, method: :verb, xhr: true`). You will revisit these test calls in the 4.2 → 5.0 hop.

See [rails/rails#13345](https://github.com/rails/rails/pull/13345).

---

#### 10. Flash Message Keys Are Strings

**What Changed:**
Keys in `flash.to_hash` are now strings, not symbols. Code that filters the hash with symbol keys silently no-ops.

**Detection Pattern:**
```ruby
flash.to_hash.except(:notify)
flash.to_hash.slice(:alert, :notice)
```

**Fix:**
```ruby
# BEFORE
flash.to_hash.except(:notify)

# AFTER
flash.to_hash.except("notify")
```

Direct access with either symbol or string still works — the break is specifically in `to_hash`-derived iteration/filtering.

---

#### 11. I18n Enforces Available Locales

**What Changed:**
`config.i18n.enforce_available_locales` defaults to `true` in 4.1. Any locale that is not in `I18n.available_locales` raises `I18n::InvalidLocale`. Apps that accepted user-supplied locale parameters without validation will raise on previously-accepted input.

**Detection Pattern:**
```ruby
I18n.locale = params[:locale]  # previously accepted anything
```

**Fix:**
Preferred — fix data and keep enforcement on. Make sure every locale the app actually uses is declared:
```ruby
# config/application.rb
config.i18n.available_locales = [:en, :es, :fr]
```

Escape hatch — disable enforcement (not recommended; the default exists for a security reason):
```ruby
# config/application.rb
config.i18n.enforce_available_locales = false
```

---

#### 12. `as_json` Millisecond Precision for Time/DateTime/TWZ

**What Changed:**
`Time`, `DateTime`, and `ActiveSupport::TimeWithZone` serialize to JSON with millisecond precision by default (`2024-01-01T00:00:00.000Z` instead of `2024-01-01T00:00:00Z`). API clients that parse the timestamp as a fixed-length string or match it against a regex break.

**Detection Pattern:**
Contract tests or client code that expects second-precision ISO-8601 timestamps in JSON responses.

**Fix:**
Preserve 4.0 behavior globally:
```ruby
# config/initializers/time_precision.rb
ActiveSupport::JSON::Encoding.time_precision = 0
```

Or update consumers to accept fractional seconds.

---

### 🟢 LOW PRIORITY

#### 13. Spring Preloader (New Default)

**What Changed:**
New 4.1 apps generate a `Gemfile` with `gem 'spring'` in `:development`, and a `bin/spring` binstub. Spring keeps the Rails environment in memory between commands.

**Fix (optional):**
```ruby
# Gemfile
group :development do
  gem 'spring'
end
```
Run `bundle exec spring binstub --all` to generate Spring-aware binstubs (`bin/rails`, `bin/rake`, etc.).

---

#### 14. `secrets.yml` (New)

**What Changed:**
Rails 4.1 introduces `config/secrets.yml` as the recommended home for `secret_key_base` and other app secrets, accessible via `Rails.application.secrets`.

**Fix (optional):**
Create `config/secrets.yml`:
```yaml
development:
  secret_key_base: <dev key>
test:
  secret_key_base: <test key>
production:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
```
Migrate reads from `Rails.application.config.secret_key_base` or custom initializers into `Rails.application.secrets`.

---

#### 15. `render :text` Soft-Deprecated

**What Changed:**
`render :text` was a security-adjacent footgun — it sent `text/html`, so any string with markup would be interpreted by the browser. 4.1 introduces `render :plain`, `render :html`, and `render :body` as precise replacements, and signals that `:text` will be deprecated in a future release.

**Detection Pattern:**
```ruby
render text: "ok"
```

**Fix:**
```ruby
# BEFORE
render text: "ok"

# AFTER — choose based on intent
render plain: "ok"           # Content-Type: text/plain
render html: "<b>ok</b>".html_safe  # Content-Type: text/html (explicit)
render body: "raw"           # no Content-Type header
```

---

#### 16. JSON Encoder: Removed Features

**What Changed:**
The 4.1 JSON encoder rewrite drops three features from `as_json` / `to_json`:
- Circular data-structure detection (previously raised a clear error; now stack-overflows)
- `encode_json(options)` hook (customized encoders must move to `as_json`)
- Option to encode `BigDecimal` objects as numbers instead of strings

**Detection Pattern:**
```ruby
class Money
  def encode_json(options); "..."; end   # no longer called
end

# or code that relied on BigDecimal-as-number
ActiveSupport.encode_big_decimal_as_string = false  # no-op on 4.1
```

**Fix:**
Restore the old encoder as an opt-in gem:
```ruby
# Gemfile
gem 'activesupport-json_encoder'
```
Or migrate `encode_json` implementations into `as_json`, and update clients to parse BigDecimals as strings.

---

#### 17. JSON Gem Isolated from Rails Encoder

**What Changed:**
`JSON.generate` / `JSON.dump` no longer consult Rails' `as_json`. They serialize arbitrary Ruby objects the way the stdlib `json` gem wants — which differs significantly. Use `obj.to_json` when you want Rails semantics.

**Detection Pattern:**
```ruby
JSON.generate(active_record_instance)  # now returns something unexpected
```

**Fix:**
```ruby
# BEFORE (ambiguous intent)
JSON.generate(obj)

# AFTER — Rails semantics (honors as_json)
obj.to_json

# AFTER — stdlib semantics (if you truly wanted that)
JSON.generate(obj.as_json)
```

---

#### 18. Fixtures ERB Evaluated in a Separate Context

**What Changed:**
Each fixture's ERB template now runs in its own isolated context. Helper methods defined in one fixture (`<% def my_helper; end %>`) are no longer visible from another fixture.

**Detection Pattern:**
ERB methods defined at the top of one `.yml` fixture and called from another.

**Fix:**
Hoist helpers into a module and mix it into `ActiveRecord::FixtureSet.context_class`:
```ruby
# test/test_helper.rb
module FixtureFileHelpers
  def file_sha(path)
    Digest::SHA2.hexdigest(File.read(Rails.root.join("test/fixtures", path)))
  end
end

ActiveRecord::FixtureSet.context_class.send :include, FixtureFileHelpers
```

---

#### 19. `ActiveSupport::Callbacks.set_callback` Around-Block Signature

**What Changed:**
The around-callback lambda signature changed from `&block` (yield-style) to a positional `block` argument.

**Detection Pattern:**
```ruby
set_callback :save, :around, ->(r, &block) { stuff; block.call; stuff }
```

**Fix:**
```ruby
# BEFORE
set_callback :save, :around, ->(r, &block) { stuff; block.call; stuff }

# AFTER
set_callback :save, :around, ->(r, block) { stuff; block.call; stuff }
```

Rare — only affects apps that build callbacks dynamically with `set_callback`.

---

#### 20. `ActiveRecord::Migration.check_pending!` Now Redundant in Test Helper

**What Changed:**
`require 'test_help'` now runs pending-migration checks automatically. Explicit calls to `ActiveRecord::Migration.check_pending!` in `test_helper.rb` / `rails_helper.rb` are harmless but unnecessary.

**Fix (optional):**
Remove the now-redundant line:
```ruby
# test/test_helper.rb — can be removed
ActiveRecord::Migration.check_pending!
```

---

## New Features Worth Adopting

- **Action Mailer previews** — subclass `ActionMailer::Preview` in `test/mailers/previews/` and browse at `/rails/mailers`.
- **ActiveRecord enums** — `enum status: [:active, :archived]` generates scopes and predicate methods.
- **Variants** — `request.variant = :tablet` lets views render `show.html+tablet.erb`.
- **`Module#concerning`** — inline concerns inside a class.

---

## Configuration File Changes

Run `bin/rake rails:update` to walk through config changes interactively. See also [RailsDiff 4.0.13 → 4.1.16](http://railsdiff.org/4.0.13/4.1.16) for the exact diff.

Remove if present (no longer does anything):
```ruby
config.active_record.disable_implicit_join_references = true
```

Add to opt into forward-compatible defaults:
```ruby
# config/initializers/cookies_serializer.rb
Rails.application.config.action_dispatch.cookies_serializer = :hybrid

# config/application.rb
config.i18n.available_locales = [:en, ...]  # or set enforce_available_locales = false
```

---

## Migration Steps

### Phase 1: Preparation
```bash
git checkout -b rails-41-upgrade
ruby -v  # 1.9.3+ (2.0+ recommended)
```

### Phase 2: Pre-requisites
1. Fix all current 4.0 deprecation warnings.
2. Audit for `MultiJSON`, dynamic finders, implicit-join `where` strings, and inline-block callbacks that `return`.
3. Audit for PG `json` / `hstore` access with symbol keys.
4. List the locales the app actually uses.

### Phase 3: Gemfile Updates
```ruby
# Gemfile
gem 'rails', '~> 4.1.16'  # pin to the last 4.1 patch

# Only if you rely on it directly
# gem 'multi_json'

# Only if you cannot migrate dynamic finders now
# gem 'activerecord-deprecated_finders'

# Only if you depend on removed JSON encoder features
# gem 'activesupport-json_encoder'

group :development do
  gem 'spring'
end
```

```bash
bundle update rails
```

### Phase 4: Configuration
```bash
bin/rake rails:update
```

Cross-check against [RailsDiff 4.0.13 → 4.1.16](http://railsdiff.org/4.0.13/4.1.16).

### Phase 5: Fix Breaking Changes
1. Replace dynamic finders with `where(...)` / `find_or_create_by(...)` equivalents.
2. Move `return` out of inline callback blocks (or refactor to a method).
3. Replace implicit-join `where` strings with `joins`, `eager_load`, or `references`.
4. Audit PG `json` / `hstore` access: use string keys.
5. Add the cookies serializer initializer (`:hybrid`).
6. Declare `config.i18n.available_locales` or disable enforcement.
7. Swap `post :x, format: :js` for `xhr :post, :x, format: :js` in controller tests.
8. Update `flash.to_hash` callers to use string keys.
9. Review `default_scope`-bearing models; apply `unscope`/`rewhere`.
10. Convert `Relation.compact!` / `Relation.map!` etc. to `to_a` then mutate.
11. Replace `render :text` with `:plain` / `:html` / `:body`.
12. Pin JSON time precision if clients need it (`time_precision = 0`).
13. Remove MultiJSON usage or add it back to the `Gemfile` explicitly.

### Phase 6: Testing
- Run full test suite.
- Exercise controller specs that hit JS endpoints.
- Exercise models with `default_scope` and `after_*` callbacks.
- Verify flash-based UI and any cookie-backed session flows.
- Exercise JSON API endpoints for timestamp format and PG `json` / `hstore` response shape.

---

## Common Issues

### Issue: App fails with `NameError: uninitialized constant MultiJSON`

**Cause:** MultiJSON no longer pulled in by Rails.

**Fix:** Add `gem 'multi_json'` to the Gemfile, or migrate to `to_json` / `JSON.parse`.

### Issue: `NoMethodError: undefined method 'find_all_by_email'`

**Cause:** Dynamic finders removed.

**Fix:** Rewrite as `where(email: email)` or add `gem 'activerecord-deprecated_finders'` temporarily.

### Issue: Query returns zero rows after upgrade

**Cause:** A scope intended to override `default_scope` is now ANDed with it.

**Fix:** Use `unscope(where: :col)` or `rewhere(col: ...)`.

### Issue: Controller tests raise `ActionController::InvalidAuthenticityToken` on JS endpoints

**Cause:** CSRF now applies to GET + JS.

**Fix:** Use `xhr :verb, :action, ...` instead of `verb :action, format: :js`.

### Issue: `flash.to_hash.except(:notice)` silently keeps `:notice`

**Cause:** Flash keys are strings now.

**Fix:** Use `"notice"` instead of `:notice`.

### Issue: `profile.preferences[:theme]` returns `nil` after upgrade

**Cause:** PG `json` / `hstore` columns return string-keyed `Hash`, not `HashWithIndifferentAccess`.

**Fix:** Index with string keys (`profile.preferences["theme"]`) or use the `store_accessor`-generated method.

### Issue: `I18n::InvalidLocale` raised by a request that worked on 4.0

**Cause:** `enforce_available_locales` is now `true` by default.

**Fix:** Add the locale to `config.i18n.available_locales`, or disable enforcement if you have a strong reason.

### Issue: API clients fail to parse `2024-01-01T00:00:00.000Z`

**Cause:** JSON millisecond precision is on by default.

**Fix:** `ActiveSupport::JSON::Encoding.time_precision = 0`, or update consumers.

---

## Resources

- [Rails 4.1 Release Notes](https://guides.rubyonrails.org/v4.1/4_1_release_notes.html)
- [Upgrading from Rails 4.0 to Rails 4.1 (official)](https://guides.rubyonrails.org/v4.1/upgrading_ruby_on_rails.html#upgrading-from-rails-4-0-to-rails-4-1)
- [RailsDiff 4.0.13 → 4.1.16](http://railsdiff.org/4.0.13/4.1.16)
- [`activerecord-deprecated_finders` gem](https://github.com/rails/activerecord-deprecated_finders)
- [`activesupport-json_encoder` gem](https://github.com/rails/activesupport-json_encoder)
- [Running `rails:update`](http://thomasleecopeland.com/2015/08/06/running-rails-update.html)
