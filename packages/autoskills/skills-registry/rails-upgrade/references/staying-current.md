# Staying Current with Rails

**Based on "The Complete Guide to Upgrade Rails" by FastRuby.io (OmbuLabs)**

---

## Overview

Congratulations on completing your Rails upgrade! Now the goal is to never fall behind again. This guide covers strategies to keep your Rails application current.

---

## Continuous Integration with Dual-Boot

Set up your CI to run tests against both your current Rails version and the next version. This way you're always prepared for the next upgrade.

### CircleCI Configuration

```yaml
# .circleci/config.yml

version: 2.1

jobs:
  build-current:
    docker:
      - image: cimg/ruby:3.2.0
        environment:
          RAILS_ENV: test
          DATABASE_URL: postgres://postgres@localhost/myapp_test
      - image: cimg/postgres:14.0
    steps:
      - checkout
      - run: bundle install
      - run: bundle exec rails db:create db:schema:load
      - run: bundle exec rspec

  build-next:
    docker:
      - image: cimg/ruby:3.2.0
        environment:
          RAILS_ENV: test
          DATABASE_URL: postgres://postgres@localhost/myapp_test
          BUNDLE_GEMFILE: Gemfile.next
      - image: cimg/postgres:14.0
    steps:
      - checkout
      - run: bundle install
      - run: bundle exec rails db:create db:schema:load
      - run: bundle exec rspec

workflows:
  version: 2
  test:
    jobs:
      - build-current
      - build-next:
          # Run next version tests, but don't block deploys
          requires:
            - build-current
```

### Travis CI Configuration

```yaml
# .travis.yml

language: ruby
cache: bundler

rvm:
  - 3.2.0

gemfile:
  - Gemfile
  - Gemfile.next

services:
  - postgresql

before_script:
  - bundle install
  - bundle exec rails db:create db:schema:load

script:
  - bundle exec rspec

# Allow next version failures (informational only)
jobs:
  allow_failures:
    - gemfile: Gemfile.next
```

### GitHub Actions Configuration

```yaml
# .github/workflows/ci.yml

name: CI

on: [push, pull_request]

jobs:
  test-current:
    runs-on: ubuntu-latest
    env:
      RAILS_ENV: test
      DATABASE_URL: postgres://postgres:postgres@localhost/myapp_test

    services:
      postgres:
        image: postgres:14
        env:
          POSTGRES_PASSWORD: postgres
        ports:
          - 5432:5432

    steps:
      - uses: actions/checkout@v3
      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: 3.2
          bundler-cache: true
      - run: bundle exec rails db:create db:schema:load
      - run: bundle exec rspec

  test-next:
    runs-on: ubuntu-latest
    continue-on-error: true  # Don't block PR merges
    env:
      RAILS_ENV: test
      DATABASE_URL: postgres://postgres:postgres@localhost/myapp_test
      BUNDLE_GEMFILE: Gemfile.next

    services:
      postgres:
        image: postgres:14
        env:
          POSTGRES_PASSWORD: postgres
        ports:
          - 5432:5432

    steps:
      - uses: actions/checkout@v3
      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: 3.2
          bundler-cache: true
      - run: bundle exec rails db:create db:schema:load
      - run: bundle exec rspec
```

---

## Tracking Outdated Dependencies

### Regular Dependency Audits

Schedule regular checks for outdated gems:

```bash
# Check all outdated gems
bundle outdated

# Check only direct dependencies
bundle outdated --only-explicit

# Check for security vulnerabilities
bundle audit check --update
```

### Automated Dependency Updates

Use tools like [Dependabot](https://docs.github.com/en/code-security/dependabot) or [Renovate](https://www.mend.io/renovate/) to automatically create PRs for dependency updates.

**Dependabot configuration:**

```yaml
# .github/dependabot.yml

version: 2
updates:
  - package-ecosystem: "bundler"
    directory: "/"
    schedule:
      interval: "weekly"
    open-pull-requests-limit: 5
    groups:
      rails:
        patterns:
          - "rails"
          - "actioncable"
          - "actionmailer"
          - "actionpack"
          - "actionview"
          - "activejob"
          - "activemodel"
          - "activerecord"
          - "activestorage"
          - "activesupport"
          - "railties"
```

### Test-Driven Updates

Create a workflow where every dependency update:

1. Creates a pull request
2. Runs the full test suite
3. Requires code review
4. Gets deployed to staging
5. QA verification
6. Production deployment

---

## Testing Against Rails Master

Stay ahead of releases by testing against Rails' main branch:

### Gemfile Configuration

```ruby
# Gemfile

def next?
  File.basename(__FILE__) == "Gemfile.next"
end

if next?
  # Test against Rails main branch
  gem 'rails', github: 'rails/rails', branch: 'main'
else
  gem 'rails', '~> 7.1.0'
end
```

### When to Test Against Main

- **Weekly**: Run CI against Rails main once a week
- **Before major releases**: Increase frequency before new Rails versions
- **After RC releases**: Test release candidates immediately

### Benefits

- Discover breaking changes early
- Contribute fixes to Rails
- Be ready on release day
- Understand upcoming features

---

## Release Monitoring

### Stay Informed

1. **Rails Blog**: https://rubyonrails.org/blog/
2. **Rails Twitter**: https://twitter.com/rails
3. **Rails GitHub Releases**: https://github.com/rails/rails/releases
4. **Ruby Weekly Newsletter**: https://rubyweekly.com/

### Version Monitoring Tools

```ruby
# Add to Gemfile
gem 'libyear-bundler', group: :development
```

```bash
# Check how "out of date" your dependencies are
bundle libyear
```

---

## Upgrade Schedule

### Recommended Cadence

| Cycle | Action |
|-------|--------|
| Weekly | Check `bundle outdated` |
| Monthly | Update patch versions |
| Quarterly | Update minor versions |
| Annually | Plan major version upgrade |

### When to Upgrade

**Upgrade immediately:**
- Security patches (x.y.Z releases)
- Critical bug fixes

**Upgrade soon (within 1-2 months):**
- Minor versions with important features
- Dependency requirements

**Plan for next quarter:**
- Major version upgrades
- Breaking changes

---

## Team Practices

### Ownership

Assign ownership for keeping dependencies current:

- **Rails version**: Senior developer or tech lead
- **Security gems**: Security-conscious team member
- **CI/CD tools**: DevOps or platform team

### Documentation

Maintain upgrade documentation:

- Record decisions made during upgrades
- Note workarounds for specific issues
- Track gems that commonly cause problems
- Document custom patches or forks

### Knowledge Sharing

After each upgrade:

- Hold a brief retrospective
- Share learnings with the team
- Update internal documentation
- Consider blog posts or conference talks

---

## Preventive Measures

### Don't Accumulate Debt

1. **Address deprecations immediately** - Don't let them pile up
2. **Update gems regularly** - Small updates are easier than big jumps
3. **Keep test coverage high** - Makes upgrades safe
4. **Review changelogs** - Understand what's changing

### Avoid Common Traps

- **Don't pin to old versions** without a plan to upgrade
- **Don't ignore CI warnings** about deprecated features
- **Don't skip testing** to save time
- **Don't deploy untested upgrades** directly to production

---

## Quick Reference

### Commands

```bash
# Check outdated gems
bundle outdated

# Security audit
bundle audit check --update

# Update a specific gem
bundle update gem_name --conservative

# Update all gems (careful!)
bundle update
```

### CI Environment Variables

```bash
# Run with next Rails version
BUNDLE_GEMFILE=Gemfile.next bundle exec rspec

# Enable deprecation warnings
RUBYOPT="-W:deprecated" bundle exec rspec
```

---

## Resources

- [RailsBump](https://railsbump.org/) - Gem compatibility checker
- [RailsDiff](https://railsdiff.org/) - Compare Rails versions
- [FastRuby.io Blog](https://www.fastruby.io/blog) - Upgrade guides and tips
- [next_rails gem](https://github.com/fastruby/next_rails) - Dual-boot tool
