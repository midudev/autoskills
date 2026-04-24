# Rails 7.2 → 8.0 Upgrade Guide

**Ruby Requirement:** 3.2.0+ (required)

---

## Overview

Rails 8.0 is a major release with architectural changes:
- **Propshaft** replaces Sprockets as default asset pipeline
- **Solid Cache/Queue/Cable** as database-backed defaults
- **Kamal** for deployment
- **Thruster** for production HTTP serving
- **No more PaaS mode** - designed for containerized deployment

---

## Breaking Changes

### 🔴 HIGH PRIORITY

#### 1. Sprockets → Propshaft

**What Changed:**
Propshaft is the new default asset pipeline. Sprockets is no longer included by default.

**Detection Pattern:**
```ruby
# Gemfile
gem 'sprockets-rails'
gem 'sassc-rails'

# Config
config.assets.compile = true
config.assets.digest = true
```

**Migration Options:**

**Option A: Keep Sprockets (Simplest)**
```ruby
# Gemfile - explicitly keep Sprockets
gem 'sprockets-rails'
gem 'sassc-rails'  # if using Sass
```

This is fine! Sprockets still works.

**Option B: Migrate to Propshaft (Recommended for new features)**
```ruby
# Gemfile
gem 'propshaft'

# Remove
# gem 'sprockets-rails'
# gem 'sassc-rails'
```

**Propshaft Differences:**
- No asset compilation transforms
- Direct serving from `app/assets/`
- Use `cssbundling-rails` for Sass
- Simpler configuration

```ruby
# Remove these Sprockets configs
# config.assets.compile
# config.assets.digest
# config.assets.debug
```

**Asset Helpers:**
```erb
<!-- Both work the same -->
<%= stylesheet_link_tag 'application' %>
<%= javascript_include_tag 'application' %>
```

---

#### 2. Multi-Database Configuration for Solid Gems

**What Changed:**
Rails 8.0 uses Solid Cache/Queue/Cable which may need separate database connections.

**Old database.yml:**
```yaml
production:
  adapter: postgresql
  database: myapp_production
  pool: 5
```

**New database.yml (if using Solid gems):**
```yaml
production:
  primary:
    adapter: postgresql
    database: myapp_production
    pool: 5
  cache:
    adapter: sqlite3
    database: storage/production_cache.sqlite3
  queue:
    adapter: sqlite3
    database: storage/production_queue.sqlite3
  cable:
    adapter: sqlite3
    database: storage/production_cable.sqlite3
```

**If NOT using Solid gems**, keep your existing structure!

---

#### 3. assume_ssl Configuration

**What Changed:**
Rails 8.0 introduces `config.assume_ssl` for apps behind SSL-terminating proxies.

**Detection Pattern:**
```ruby
# config/environments/production.rb
config.force_ssl = true
```

**Fix:**
```ruby
# config/environments/production.rb
config.force_ssl = true
config.assume_ssl = true  # Add this for load balancers
```

This prevents SSL redirect loops when behind a proxy.

---

#### 4. sqlite3_deprecated_warning Removed

**What Changed:**
The `sqlite3_deprecated_warning` configuration option is removed.

**Detection Pattern:**
```ruby
config.active_record.sqlite3_deprecated_warning = false
```

**Fix:**
Remove this line from your configuration files.

---

#### 5. Ruby 3.2+ Strictly Required

**What Changed:**
Rails 8.0 requires Ruby 3.2.0 or newer.

**Fix:**
```bash
rbenv install 3.3.0
rbenv local 3.3.0
```

---

### 🟡 MEDIUM PRIORITY

#### 6. Solid Cache (Optional)

**What Changed:**
Rails 8.0 defaults to Solid Cache for caching (database-backed).

**Detection Pattern:**
```ruby
config.cache_store = :redis_cache_store
config.cache_store = :mem_cache_store
```

**Options:**

**Keep Redis/Memcached:**
```ruby
# No change needed - your existing setup still works
config.cache_store = :redis_cache_store, { url: ENV['REDIS_URL'] }
```

**Switch to Solid Cache:**
```ruby
# Gemfile
gem 'solid_cache'

# Install
rails solid_cache:install

# Config
config.cache_store = :solid_cache_store
```

---

#### 7. Solid Queue (Optional)

**What Changed:**
Rails 8.0 defaults to Solid Queue for background jobs (database-backed).

**Detection Pattern:**
```ruby
config.active_job.queue_adapter = :sidekiq
config.active_job.queue_adapter = :async
```

**Options:**

**Keep Sidekiq:**
```ruby
# No change needed
config.active_job.queue_adapter = :sidekiq
```

**Switch to Solid Queue:**
```ruby
# Gemfile
gem 'solid_queue'

# Install
rails solid_queue:install

# Config
config.active_job.queue_adapter = :solid_queue
```

---

#### 8. Solid Cable (Optional)

**What Changed:**
Rails 8.0 defaults to Solid Cable for WebSockets (database-backed).

**Detection Pattern:**
```yaml
# config/cable.yml
production:
  adapter: redis
```

**Options:**

**Keep Redis:**
```yaml
# No change needed
production:
  adapter: redis
  url: <%= ENV.fetch("REDIS_URL") %>
```

**Switch to Solid Cable:**
```yaml
production:
  adapter: solid_cable
  polling_interval: 0.1.seconds
```

---

#### 9. Docker/Thruster for Production

**What Changed:**
Rails 8.0 apps include Dockerfile and Thruster gem.

**Fix:**
If using Docker, add:
```ruby
# Gemfile
gem 'thruster'
```

Thruster provides:
- HTTP/2 support
- Asset compression
- Static file serving

---

#### 10. Kamal Deployment

**What Changed:**
Rails 8.0 includes Kamal configuration for deployment.

**New Files:**
- `config/deploy.yml`
- `.kamal/` directory

**If not using Kamal**, you can ignore or delete these files.

---

## Solid Gems Decision Guide

| Current Setup | Recommendation |
|--------------|----------------|
| Redis for cache/jobs/cable | Keep Redis - simpler to maintain |
| Sidekiq with complex workflows | Keep Sidekiq |
| Simple background jobs | Consider Solid Queue |
| Need real-time WebSockets | Keep Redis for Cable |
| Want simpler infrastructure | Use Solid gems |
| Heroku/PaaS deployment | Solid gems or Redis add-on |
| Self-hosted/Docker | Either works well |

---

## Migration Steps

### Phase 1: Preparation
```bash
git checkout -b rails-80-upgrade

# Verify Ruby version
ruby -v  # Should be 3.1+
```

### Phase 2: Gemfile Updates
```ruby
# Gemfile
gem 'rails', '~> 8.0.0'

# Choose asset pipeline:
gem 'propshaft'  # New default
# OR
gem 'sprockets-rails'  # Keep existing

# Optional Solid gems (only if migrating):
# gem 'solid_cache'
# gem 'solid_queue'
# gem 'solid_cable'
```

```bash
bundle update rails
```

### Phase 3: Asset Pipeline Decision

**If keeping Sprockets:**
```ruby
# Gemfile
gem 'sprockets-rails'
```
No other changes needed!

**If migrating to Propshaft:**
1. Remove Sprockets-specific configs
2. Update asset structure if needed
3. Use cssbundling-rails for Sass

### Phase 4: Configuration
```bash
rails app:update
```

Update `config/application.rb`:
```ruby
config.load_defaults 8.0
```

Add to production.rb:
```ruby
config.assume_ssl = true
```

### Phase 5: Testing
- Verify assets load correctly
- Test caching if using Solid Cache
- Test background jobs
- Test WebSockets if applicable

---

## Propshaft Migration Checklist

- [ ] Remove `sprockets-rails` from Gemfile
- [ ] Add `propshaft` to Gemfile
- [ ] Remove `config.assets.*` from environment files
- [ ] Verify assets serve correctly
- [ ] If using Sass, add `cssbundling-rails`
- [ ] Update asset precompilation in deployment

---

## Common Issues

### Issue: Assets Not Loading

**Error:** 404 for CSS/JS files

**Cause:** Asset pipeline misconfigured

**Fix for Propshaft:**
```ruby
# No config needed - just place files in app/assets/
```

**Fix for Sprockets:**
```ruby
# Ensure sprockets-rails is in Gemfile
gem 'sprockets-rails'
```

### Issue: SSL Redirect Loop

**Error:** ERR_TOO_MANY_REDIRECTS

**Cause:** Missing assume_ssl behind proxy

**Fix:**
```ruby
config.assume_ssl = true
```

### Issue: Solid Queue Jobs Not Processing

**Error:** Jobs stuck in pending

**Cause:** Solid Queue supervisor not running

**Fix:**
```bash
bin/jobs  # Start job processor
```

---

## Gem Compatibility

| Gem | Minimum Version | Notes |
|-----|-----------------|-------|
| devise | 4.9.0 | Works well |
| sidekiq | 7.0.0 | Keep if using |
| rspec-rails | 6.0.0 | Update recommended |
| capybara | 3.39.0 | Works well |
| webmock | 3.19.0 | Works well |

---

## Files Changed by app:update

| File | Change |
|------|--------|
| Gemfile | Rails version, Propshaft |
| config/application.rb | load_defaults 8.0 |
| config/environments/production.rb | assume_ssl, cache config |
| config/database.yml | Multi-database structure |
| Dockerfile | New file |
| config/deploy.yml | New file (Kamal) |
| bin/jobs | New file (Solid Queue) |

---

## Resources

- [Rails 8.0 Release Notes](https://guides.rubyonrails.org/8_0_release_notes.html)
- [Propshaft Documentation](https://github.com/rails/propshaft)
- [Solid Cache](https://github.com/rails/solid_cache)
- [Solid Queue](https://github.com/rails/solid_queue)
- [Kamal Documentation](https://kamal-deploy.org)
