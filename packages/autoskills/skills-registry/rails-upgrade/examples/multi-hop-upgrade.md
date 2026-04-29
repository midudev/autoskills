# Example: Multi-Hop Upgrade

**Scenario:** Upgrading from Rails 5.2 to Rails 8.0

---

## User Request

"Help me upgrade my Rails app from 5.2 to 8.0"

---

## Claude Response

### Important: Sequential Upgrade Required

I'll help you upgrade from Rails 5.2 to 8.0! This is a multi-hop upgrade that requires going through each version sequentially. **You cannot skip versions.**

### Your Upgrade Path

```
5.2 → 6.0 → 6.1 → 7.0 → 7.1 → 7.2 → 8.0
 |     |     |     |     |     |
Hop1  Hop2  Hop3  Hop4  Hop5  Hop6
```

### Estimated Timeline

| Hop | From → To | Difficulty | Time | Key Challenge |
|-----|-----------|------------|------|---------------|
| 1 | 5.2 → 6.0 | Hard | 1-2 weeks | Zeitwerk autoloader |
| 2 | 6.0 → 6.1 | Medium | 3-5 days | Minor changes |
| 3 | 6.1 → 7.0 | Hard | 1-2 weeks | Hotwire/Turbo |
| 4 | 7.0 → 7.1 | Medium | 3-5 days | Composite keys |
| 5 | 7.1 → 7.2 | Medium | 3-5 days | Transaction jobs |
| 6 | 7.2 → 8.0 | Very Hard | 1-2 weeks | Propshaft |

**Total Estimated Time:** 6-10 weeks

### Ruby Upgrade Required

Before starting, you'll need to upgrade Ruby:
- Rails 5.2: Ruby 2.2.2+
- Rails 6.0: Ruby 2.5.0+ required
- Rails 7.0: Ruby 2.7.0+ required
- Rails 7.2+: Ruby 3.1.0+ recommended
- Rails 8.0: Ruby 3.1.0+ required

**Recommended:** Upgrade to Ruby 3.2+ before starting.

### My Recommendation

1. **Upgrade Ruby first** to 3.2+
2. **Complete Hop 1 (5.2 → 6.0)** - This is the biggest change
3. **Quick hops through 6.1 → 7.0** - Focus on Hotwire migration
4. **Finish with 7.x → 8.0** - Asset pipeline migration

---

Hop 1: Rails 5.2 → 6.0 (Hard — ~1–2 weeks)

Breaking Changes Found in Your Code

┌──────────┬───────────────────────────────────┬──────┬───────────────────────────────────────────────────────┬─────────────────────────┐
│ Priority │               File                │ Line │                         Issue                         │           Fix           │
├──────────┼───────────────────────────────────┼──────┼───────────────────────────────────────────────────────┼─────────────────────────┤
│ 🔴 HIGH  │ config/environments/production.rb │ 20   │ config.read_encrypted_secrets = true — removed in 6.0 │ Delete this line        │
├──────────┼───────────────────────────────────┼──────┼───────────────────────────────────────────────────────┼─────────────────────────┤
│ 🟡 MED   │ config/application.rb             │ 22   │ config.load_defaults 5.1                              │ Update to 5.2, then 6.0 │
└──────────┴───────────────────────────────────┴──────┴───────────────────────────────────────────────────────┴─────────────────────────┘

Zeitwerk Check (⚠️  Most Critical)

No require_dependency calls found in your codebase. However, you must run this after updating Rails:

bundle exec rails zeitwerk:check

This will surface any file naming mismatches that the classic autoloader was silently tolerating.

Gem Updates Required

┌─────────────┬───────────┬─────────────────┐
│     Gem     │  Current  │ Minimum for 6.0 │
├─────────────┼───────────┼─────────────────┤
│ rspec-rails │ ~> 3.5.0  │ 4.0.0           │
├─────────────┼───────────┼─────────────────┤
│ sidekiq     │ ~> 5.0    │ 6.0.0           │
├─────────────┼───────────┼─────────────────┤
│ capybara    │ ~> 2.13.0 │ 3.x             │
└─────────────┴───────────┴─────────────────┘

Migration Steps

git checkout -b rails-60-upgrade
# 1. Remove config.read_encrypted_secrets from production.rb
# 2. Update Gemfile: gem 'rails', '~> 6.0.0'
# 3. Update gem constraints above
bundle update rails
bundle exec rails app:update
bundle exec rails zeitwerk:check
bundle exec rspec

---

Hop 2: Rails 6.0 → 6.1 (Medium — ~3–5 days)

Breaking Changes Found in Your Code

┌──────────┬───────────────────────────────────┬──────┬─────────────────────────────────────────────────────────────────┬────────────────────┐
│ Priority │               File                │ Line │                              Issue                              │        Fix         │
├──────────┼───────────────────────────────────┼──────┼─────────────────────────────────────────────────────────────────┼────────────────────┤
│ 🟡 MED   │ app/views/contacts/_form.html.erb │ 1    │ form_with(model: contact, local: true) — local: true deprecated │ Remove local: true │
└──────────┴───────────────────────────────────┴──────┴─────────────────────────────────────────────────────────────────┴────────────────────┘

No other issues detected. Minor steps:

git checkout -b rails-61-upgrade
# Update Gemfile: gem 'rails', '~> 6.1.0'
bundle update rails
bundle exec rails app:update
# Update config.load_defaults to 6.1
bundle exec rspec

---

Hop 3: Rails 6.1 → 7.0 (Hard — ~1–2 weeks)

⚠️  This is the most impactful hop for your frontend
Breaking Changes Found in Your Code

┌──────────┬────────────────────────────────────────┬──────┬────────────────────────────────────────┬───────────────────────────────────────────┐
│ Priority │                  File                  │ Line │                 Issue                  │                    Fix                    │
├──────────┼────────────────────────────────────────┼──────┼────────────────────────────────────────┼───────────────────────────────────────────┤
│ 🔴 HIGH  │ Gemfile                                │ 31   │ gem 'turbolinks', '~> 5'               │ Replace with gem 'turbo-rails'            │
├──────────┼────────────────────────────────────────┼──────┼────────────────────────────────────────┼───────────────────────────────────────────┤
│ 🔴 HIGH  │ app/views/layouts/application.html.erb │ 7, 9 │ 'data-turbolinks-track': 'reload'      │ Keep as-is — still valid with turbo-rails │
├──────────┼────────────────────────────────────────┼──────┼────────────────────────────────────────┼───────────────────────────────────────────┤
│ 🔴 HIGH  │ app/assets/javascripts/application.js  │ 14   │ //= require turbolinks                 │ Remove this line                          │
└──────────┴────────────────────────────────────────┴──────┴────────────────────────────────────────┴───────────────────────────────────────────┘

Gemfile Changes

# Remove
gem 'turbolinks', '~> 5'

# Add
gem 'turbo-rails'
gem 'stimulus-rails'
JavaScript Changes

Migration Steps

git checkout -b rails-70-upgrade
# Make all JS changes above
# Update Gemfile
bundle update rails
bundle exec rails app:update
# Update config.load_defaults to 7.0
bundle exec rspec
# Manual test: navigate through the app, verify JS events fire

---

Hop 4: Rails 7.0 → 7.1 (Medium — ~3–5 days)

Breaking Changes Found in Your Code

┌──────────┬───────────────────────────────────┬──────┬───────────────────────────────────────────────┬───────────────────────────────────────────┐
│ Priority │               File                │ Line │                     Issue                     │                    Fix                    │
├──────────┼───────────────────────────────────┼──────┼───────────────────────────────────────────────┼───────────────────────────────────────────┤
│ 🔴 HIGH  │ config/environments/production.rb │ 5    │ config.cache_classes = true — replaced in 7.1 │ Change to config.enable_reloading = false │
├──────────┼───────────────────────────────────┼──────┼───────────────────────────────────────────────┼───────────────────────────────────────────┤
│ 🔴 HIGH  │ config/environments/test.rb       │ 8    │ config.cache_classes = true — replaced in 7.1 │ Change to config.enable_reloading = false │
└──────────┴───────────────────────────────────┴──────┴───────────────────────────────────────────────┴───────────────────────────────────────────┘

▎ Note: enable_reloading is the inverse of cache_classes. cache_classes = true → enable_reloading = false.

Also check config/environments/development.rb for config.cache_classes = false → enable_reloading = true.

Migration Steps

git checkout -b rails-71-upgrade
# Replace cache_classes with enable_reloading (inverted)
bundle update rails
bundle exec rails app:update
# Update config.load_defaults to 7.1
bundle exec rspec

---

Hop 5: Rails 7.1 → 7.2 (Medium — ~3–5 days)

Breaking Changes Found in Your Code

┌──────────┬─────────────────────────────┬──────┬────────────────────────────────────────────────┬─────────────────┐
│ Priority │            File             │ Line │                     Issue                      │       Fix       │
├──────────┼─────────────────────────────┼──────┼────────────────────────────────────────────────┼─────────────────┤
│ 🔴 HIGH  │ config/environments/test.rb │ 26   │ config.action_dispatch.show_exceptions = false │ Change to :none │
└──────────┴─────────────────────────────┴──────┴────────────────────────────────────────────────┴─────────────────┘

Fix

# BEFORE
config.action_dispatch.show_exceptions = false

# AFTER
config.action_dispatch.show_exceptions = :none

Migration Steps

git checkout -b rails-72-upgrade
# Fix show_exceptions
bundle update rails
bundle exec rails app:update
# Update config.load_defaults to 7.2
bundle exec rspec

---

Hop 6: Rails 7.2 → 8.0 (Very Hard — ~1–2 weeks)

Asset Pipeline Decision Required

Your app uses Sprockets (sprockets/railtie in config/application.rb:12). Rails 8.0 defaults to Propshaft, but Sprockets still works. You have two options:

Option A — Keep Sprockets (recommended for this app):

# Gemfile — explicitly keep it
gem 'sprockets-rails'

No other asset changes needed. Your config.assets.js_compressor, config.assets.compile, etc. all stay.

Option B — Migrate to Propshaft (more work, cleaner long-term):

- Remove sprockets/railtie from application.rb
- Remove sprockets-rails, sassc-rails from Gemfile
- Add gem 'propshaft'
- Remove Sprockets-specific asset configs from production.rb
- Add cssbundling-rails if using Sass

Solid Gems Decision

Your app uses Sidekiq for jobs, which still works in Rails 8.0. No migration needed unless you want to switch to Solid Queue.

┌───────────────────────────────────┬───────────────────┬────────────────┐
│              Current              │ Rails 8.0 Default │ Recommendation │
├───────────────────────────────────┼───────────────────┼────────────────┤
│ Sidekiq (jobs)                    │ Solid Queue       │ Keep Sidekiq   │
├───────────────────────────────────┼───────────────────┼────────────────┤
│ File caching                      │ Solid Cache       │ Keep existing  │
├───────────────────────────────────┼───────────────────┼────────────────┤
│ ActionCable (no Redis configured) │ Solid Cable       │ Evaluate       │
└───────────────────────────────────┴───────────────────┴────────────────┘

Gem Updates Required

┌─────────────┬────────────────────┬─────────────────┐
│     Gem     │      Current       │ Minimum for 8.0 │
├─────────────┼────────────────────┼─────────────────┤
│ rspec-rails │ (updated in hop 1) │ 6.0.0           │
├─────────────┼────────────────────┼─────────────────┤
│ sidekiq     │ (updated in hop 1) │ 7.0.0           │
├─────────────┼────────────────────┼─────────────────┤
│ capybara    │ (updated in hop 1) │ 3.39.0          │
└─────────────┴────────────────────┴─────────────────┘

New Configuration

# config/environments/production.rb — add:
config.assume_ssl = true  # needed if behind load balancer (Heroku, etc.)

Migration Steps

git checkout -b rails-80-upgrade
# Decide on Sprockets vs Propshaft
# Add gem 'sprockets-rails' if keeping Sprockets
bundle update rails
bundle exec rails app:update
# Update config.load_defaults to 8.0
# Add config.assume_ssl = true to production.rb
bundle exec rspec
# Test asset serving manually

---

## Milestone Tracking

Track your progress through each hop:

### Hop 1: 5.2 → 6.0 (Zeitwerk)
- [ ] Ruby upgraded to 2.5+
- [ ] require_dependency removed
- [ ] Zeitwerk compatible naming
- [ ] update_attributes → update
- [ ] All tests passing
- [ ] Deployed to staging

### Hop 2: 6.0 → 6.1
- [ ] Rails 6.1 in Gemfile
- [ ] load_defaults 6.1
- [ ] All tests passing
- [ ] Deployed to staging

### Hop 3: 6.1 → 7.0 (Hotwire)
- [ ] Ruby upgraded to 2.7+
- [ ] Webpacker → Import Maps/jsbundling
- [ ] Turbolinks → Turbo
- [ ] rails-ujs removed
- [ ] All tests passing
- [ ] Deployed to staging

### Hop 4: 7.0 → 7.1
- [ ] Rails 7.1 in Gemfile
- [ ] load_defaults 7.1
- [ ] All tests passing
- [ ] Deployed to staging

### Hop 5: 7.1 → 7.2
- [ ] Transaction-aware jobs handled
- [ ] show_exceptions updated
- [ ] secrets → credentials
- [ ] All tests passing
- [ ] Deployed to staging

### Hop 6: 7.2 → 8.0 (Propshaft)
- [ ] Ruby upgraded to 3.1+
- [ ] Sprockets → Propshaft (or keep Sprockets)
- [ ] SSL config updated
- [ ] All tests passing
- [ ] Deployed to staging
- [ ] 🎉 UPGRADE COMPLETE!

---

## Tips for Multi-Hop Success

1. **Complete each hop fully** before starting the next
2. **Deploy to staging** after each hop
3. **Run production for 1-2 weeks** on each version if possible
4. **Fix deprecation warnings** as you go
5. **Update gems incrementally** with each Rails version
6. **Keep detailed notes** of changes made
