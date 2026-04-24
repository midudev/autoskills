# Multi-Hop Upgrade Strategy

**FastRuby.io methodology for large version jumps**

---

## Core Principles

1. **Never skip Rails versions.** Upgrade sequentially, one minor/major version at a time.
2. **Always start from the latest patch of your current version.** Before hopping to the next minor/major, upgrade to the latest patch release of your current series first.

---

## Step 0: Upgrade to Latest Patch Release

Before beginning any minor or major version hop, ensure you are on the **latest patch release** of your current Rails series. For example, if you are on Rails 3.2.19, upgrade to 3.2.22.5 first.

### Why This Matters

- **Security fixes** — Patch releases contain critical security patches that may also exist in the next minor version. Starting from the latest patch ensures you're not carrying known vulnerabilities.
- **Bug fixes** — Later patches fix bugs that could cause confusing failures during an upgrade, making it harder to distinguish pre-existing issues from upgrade-related ones.
- **Deprecation warnings** — Later patch releases may include additional deprecation warnings that prepare you for the next version.
- **Smaller delta** — The jump to the next minor/major is smaller and better tested from the latest patch than from an arbitrary earlier patch.

### How to Find the Latest Patch

1. Check [rubygems.org/gems/rails/versions](https://rubygems.org/gems/rails/versions) for all releases in your series
2. Or run: `gem search rails --versions | grep "^rails "` to see available versions
3. The latest patch for each series is the target before hopping

### Latest Patch Versions Reference

#### End-of-Life Series (static — these versions are frozen)

| Series | Latest Patch |
|--------|-------------|
| 2.3.x | 2.3.18 |
| 3.0.x | 3.0.20 |
| 3.1.x | 3.1.12 |
| 3.2.x | 3.2.22.5 |
| 4.0.x | 4.0.13 |
| 4.1.x | 4.1.16 |
| 4.2.x | 4.2.11.3 |
| 5.0.x | 5.0.7.2 |
| 5.1.x | 5.1.7 |
| 5.2.x | 5.2.8.1 |
| 6.0.x | 6.0.6.1 |
| 6.1.x | 6.1.7.10 |
| 7.0.x | 7.0.10 |
| 7.1.x | 7.1.6 |

#### Active Series (look up dynamically — these receive new patches)

For series that are still maintained or receiving security updates, **always resolve the latest patch at runtime** using one of these methods:

**Option A — RubyGems API (preferred, structured JSON):**
```bash
curl -s https://rubygems.org/api/v1/versions/rails.json | \
  ruby -rjson -e '
    series = ARGV[0]
    versions = JSON.parse(STDIN.read)
      .map { |v| v["number"] }
      .select { |v| v.start_with?(series) }
      .sort_by { |v| Gem::Version.new(v) }
    puts versions.last
  ' "7.1."
```
Replace `"7.2."` with the target series prefix (e.g., `"8.0."`, `"8.1."`).

**Option B — gem search (works offline if gem sources are cached):**
```bash
gem search '^rails$' --versions | grep "^rails " | \
  ruby -e '
    series = ARGV[0]
    versions = STDIN.read.scan(/[\d.]+/).select { |v| v.start_with?(series) }
      .sort_by { |v| Gem::Version.new(v) }
    puts versions.last
  ' "7.2."
```

> **Why dynamic?** Active series receive new patch releases for security and bug fixes. A hard-coded table goes stale; querying RubyGems ensures the skill always targets the correct version.

### Process

```
1. Read Gemfile.lock to find exact current Rails version (e.g., 3.2.19)
2. Look up latest patch for that series (e.g., 3.2.22.5)
3. If current version < latest patch:
   a. Update Gemfile: gem 'rails', '3.2.22.5'
   b. Run: bundle update rails
   c. Run test suite — all tests must pass
   d. Review CHANGELOG for security fixes and behavioral changes
   e. Deploy patch upgrade to production
   f. Monitor for issues
4. Once on latest patch, proceed to Step 1 (Map Your Path)
```

---

## Why Sequential Upgrades?

1. **Deprecation warnings** - Each version provides warnings about the next
2. **Smaller changesets** - Easier to debug issues
3. **Gem compatibility** - Gems update incrementally too
4. **Migration paths** - Rails provides migration helpers per version
5. **Rollback safety** - Can revert to previous stable state

---

## Planning a Multi-Hop Upgrade

### Step 1: Map Your Path

Example: Rails 5.2 → 8.1

```
5.2 → 6.0 → 6.1 → 7.0 → 7.1 → 7.2 → 8.0 → 8.1
 |     |     |     |     |     |     |     |
 |     |     |     |     |     |     |     +-- Easy (1-2 days)
 |     |     |     |     |     |     +-------- Very Hard (1-2 weeks)
 |     |     |     |     |     +-------------- Medium (3-5 days)
 |     |     |     |     +-------------------- Medium (3-5 days)
 |     |     |     +-------------------------- Hard (1-2 weeks)
 |     |     +-------------------------------- Medium (3-5 days)
 |     +-------------------------------------- Hard (1-2 weeks)
 +-------------------------------------------- Start
```

### Step 2: Prioritize Critical Hops

**Hardest upgrades (plan extra time):**
- 5.2 → 6.0 (Zeitwerk)
- 6.1 → 7.0 (Hotwire/Turbo)
- 7.2 → 8.0 (Propshaft)

**Easier upgrades (can move quickly):**
- 5.0 → 5.1
- 6.0 → 6.1
- 7.0 → 7.1
- 8.0 → 8.1

### Step 3: Create Milestones

```
Milestone 1: Rails 6.0 (Zeitwerk working)
  - Remove require_dependency
  - Fix autoload issues
  - All tests pass

Milestone 2: Rails 7.0 (Modern frontend)
  - Migrate from Webpacker
  - Turbo/Stimulus working
  - All tests pass

Milestone 3: Rails 8.0 (Current stable)
  - Propshaft or Sprockets
  - SSL configuration correct
  - All tests pass

Milestone 4: Rails 8.1 (Latest)
  - Bundler-audit integrated
  - Database config updated
  - All tests pass
```

---

## Upgrade Process Per Hop

### For Each Version Jump:

1. **Prepare**
   ```bash
   git checkout -b rails-X.Y-upgrade
   ```

2. **Update Gemfile**
   ```ruby
   gem 'rails', '~> X.Y.0'
   ```

3. **Bundle Update**
   ```bash
   bundle update rails
   # Fix gem conflicts as they arise
   ```

4. **Run app:update**
   ```bash
   rails app:update
   # Review each change carefully
   ```

5. **Fix Breaking Changes**
   - Address HIGH priority first
   - Then MEDIUM priority
   - Skip LOW priority if time-constrained

6. **Run Tests**
   ```bash
   bundle exec rspec  # or rails test
   ```

7. **Manual Testing**
   - Test critical user flows
   - Check background jobs
   - Verify file uploads
   - Test emails

8. **Deploy to Staging**
   - Full integration testing
   - Performance monitoring
   - Error tracking

9. **Merge and Deploy**
   ```bash
   git checkout main
   git merge rails-X.Y-upgrade
   # Deploy to production
   ```

10. **Monitor**
    - Watch error rates
    - Check performance metrics
    - Be ready to rollback

---

## Time Estimates

| Path | Hops | Estimated Time | Key Challenges |
|------|------|----------------|----------------|
| 5.2 → 6.0 | 1 | 1-2 weeks | Zeitwerk, Ruby upgrade |
| 6.0 → 7.0 | 2 | 2-3 weeks | Hotwire migration |
| 7.0 → 8.0 | 3 | 3-4 weeks | Propshaft, Solid gems |
| 5.2 → 8.1 | 7 | 2-3 months | All of the above |

**Factors that increase time:**
- Low test coverage (+50%)
- Custom asset pipeline (+1 week)
- Many deprecated APIs (+25%)
- Large codebase (+25%)
- Complex gem dependencies (+25%)

---

## Dual-Boot Strategy (Optional)

For large applications, consider dual-boot testing:

```ruby
# Gemfile
if next?
  gem 'rails', '~> 7.0'
else
  gem 'rails', '~> 6.1'
end
```

```bash
# Run current version
bundle exec rspec

# Run next version
BUNDLE_GEMFILE=Gemfile.next bundle exec rspec
```

**Benefits:**
- Run tests against both versions
- Gradual migration of code
- Confidence before switching

**Use dual-boot for:**
- 6.0 → 6.1 → 7.0 transitions
- Large applications
- Risk-averse teams

---

## Common Pitfalls

### 1. Skipping Versions
❌ "Let's just go from 5.2 to 7.0"
✅ Go through 6.0 and 6.1 first

### 2. Upgrading Everything at Once
❌ Upgrading Rails + Ruby + all gems simultaneously
✅ Upgrade Ruby first, then Rails, then gems

### 3. Ignoring Deprecations
❌ Skipping deprecation warnings
✅ Fix deprecations before the next upgrade

### 4. No Test Coverage
❌ Upgrading without tests
✅ Add tests for critical paths first

### 5. Big Bang Deploys
❌ One massive PR with all changes
✅ Incremental PRs per version

---

## Gem Compatibility Matrix

Check these gems early in planning:

| Gem | Rails 6.0 | Rails 7.0 | Rails 8.0 |
|-----|-----------|-----------|-----------|
| Devise | 4.7+ | 4.8+ | 4.9+ |
| Sidekiq | 6.0+ | 6.0+ | 7.0+ |
| RSpec Rails | 4.0+ | 5.0+ | 6.0+ |
| Pundit | 2.0+ | 2.0+ | 2.3+ |
| Cancancan | 3.0+ | 3.3+ | 3.5+ |

**Check compatibility at:**
- https://rubygems.org (version requirements)
- GitHub issues (Rails X support)
- Gem changelogs

---

## Success Criteria Per Hop

Before moving to the next version:

- [ ] All tests passing
- [ ] No deprecation warnings from current version
- [ ] Application boots without errors
- [ ] Critical user flows work
- [ ] Background jobs process correctly
- [ ] File uploads work
- [ ] Emails send correctly
- [ ] Deployed to staging successfully
- [ ] No new errors in error tracking

---

**For version-specific details, see `version-guides/`**
