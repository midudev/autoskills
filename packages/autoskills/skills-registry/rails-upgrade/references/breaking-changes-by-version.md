# Breaking Changes by Version - Quick Reference

**Complete comparison table for Rails 5.0 → 8.1**

---

## Summary Statistics

| Version | Total Changes | HIGH | MEDIUM | LOW | Difficulty | Ruby Requirement |
|---------|--------------|------|--------|-----|------------|------------------|
| **5.0 → 5.1** | 8 | 2 | 4 | 2 | ⭐ Easy | 2.2.2+ |
| **5.1 → 5.2** | 10 | 3 | 5 | 2 | ⭐⭐ Medium | 2.2.2+ |
| **5.2 → 6.0** | 15 | 5 | 6 | 4 | ⭐⭐⭐ Hard | 2.5.0+ |
| **6.0 → 6.1** | 12 | 3 | 6 | 3 | ⭐⭐ Medium | 2.5.0+ |
| **6.1 → 7.0** | 18 | 5 | 8 | 5 | ⭐⭐⭐ Hard | 2.7.0+ |
| **7.0 → 7.1** | 12 | 5 | 4 | 3 | ⭐⭐ Medium | 2.7.0+ |
| **7.1 → 7.2** | 15 | 5 | 7 | 3 | ⭐⭐ Medium | 3.1.0+ |
| **7.2 → 8.0** | 13 | 5 | 5 | 3 | ⭐⭐⭐⭐ Very Hard | 3.2.0+ |
| **8.0 → 8.1** | 8 | 3 | 3 | 2 | ⭐ Easy | 3.2.0+ |

---

## Rails 5.2 → 6.0 (HIGH Impact)

| Change | Impact | Fix |
|--------|--------|-----|
| Zeitwerk autoloader | ALL apps | Remove require_dependency, fix naming |
| Ruby 2.5+ required | ALL apps | Upgrade Ruby first |
| belongs_to required | Models | Add optional: true where needed |
| update_attributes removed | ALL apps | Change to update |
| protect_from_forgery default | Controllers | Review CSRF settings |

---

## Rails 6.1 → 7.0 (HIGH Impact)

| Change | Impact | Fix |
|--------|--------|-----|
| Ruby 2.7+ required | ALL apps | Upgrade Ruby first |
| Webpacker → Import Maps | Frontend | Migrate JS bundling strategy |
| Turbolinks → Turbo | Frontend | Update event listeners |
| rails-ujs removed | Forms | Use Turbo for remote forms |
| secrets → credentials | Config | Migrate secrets to credentials |

---

## Rails 7.1 → 7.2 (HIGH Impact)

| Change | Impact | Fix |
|--------|--------|-----|
| Transaction-aware jobs | Models with jobs | Test job timing in transactions |
| show_exceptions symbols | ALL envs | true → :all, false → :none |
| params comparison | Controllers | Use params.to_h == hash |
| AR.connection deprecated | Database code | Use with_connection block |
| secrets removed | ALL apps | Migrate to credentials |

---

## Rails 7.2 → 8.0 (HIGH Impact)

| Change | Impact | Fix |
|--------|--------|-----|
| Sprockets → Propshaft | ALL apps | Migrate asset pipeline |
| Solid gems defaults | Optional | Keep Redis or migrate |
| assume_ssl setting | Production | Add to production.rb |
| Multi-database config | Database | Restructure database.yml |
| Docker/Kamal | Deployment | Review deployment config |

---

## Rails 8.0 → 8.1 (HIGH Impact)

| Change | Impact | Fix |
|--------|--------|-----|
| SSL commented out | Production | Uncomment if not using Kamal |
| pool → max_connections | Database | Update database.yml |
| bundler-audit required | Security | Add gem and script |

---

## Most Impactful Changes (All Versions)

1. **Zeitwerk autoloader** (6.0) - Fundamental change to code loading
2. **Propshaft asset pipeline** (8.0) - Complete asset system replacement
3. **Webpacker → Import Maps** (7.0) - JavaScript bundling overhaul
4. **Transaction-aware jobs** (7.2) - Behavior change in job timing
5. **Ruby version jumps** - Required at 6.0, 7.0, 7.2

---

## Pre-Upgrade Checklist

Before ANY upgrade:

- [ ] Ruby version meets minimum requirement
- [ ] Test coverage is adequate (aim for 70%+)
- [ ] All current tests pass
- [ ] Database is backed up
- [ ] Git branch created for upgrade
- [ ] Bundle outdated reviewed
- [ ] Deprecation warnings addressed

---

## Quick Decision Matrix

| Scenario | Recommendation |
|----------|----------------|
| 5.2 app, active development | Upgrade through all versions to 8.x |
| 6.0 app, moderate changes | Upgrade to 7.x minimum |
| 7.0 app, light maintenance | Upgrade to 7.2 |
| 7.2 app, ready for change | Upgrade to 8.0/8.1 |
| Any app, no test coverage | Add tests before upgrading |

---

**For detailed information, see version-specific guides in `version-guides/`**
