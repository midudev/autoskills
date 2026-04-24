# Gem Compatibility Reference

**Common gems and their Rails version requirements**

---

## Authentication & Authorization

| Gem | Rails 5.2 | Rails 6.0 | Rails 6.1 | Rails 7.0 | Rails 7.2 | Rails 8.0 |
|-----|-----------|-----------|-----------|-----------|-----------|-----------|
| devise | 4.5+ | 4.7+ | 4.7+ | 4.8+ | 4.9+ | 4.9+ |
| cancancan | 2.3+ | 3.0+ | 3.0+ | 3.3+ | 3.5+ | 3.6+ |
| pundit | 2.0+ | 2.0+ | 2.0+ | 2.2+ | 2.3+ | 2.4+ |
| rolify | 5.2+ | 6.0+ | 6.0+ | 6.0+ | 6.0+ | 6.0+ |
| doorkeeper | 5.0+ | 5.2+ | 5.4+ | 5.5+ | 5.6+ | 5.7+ |

---

## Background Jobs

| Gem | Rails 5.2 | Rails 6.0 | Rails 6.1 | Rails 7.0 | Rails 7.2 | Rails 8.0 |
|-----|-----------|-----------|-----------|-----------|-----------|-----------|
| sidekiq | 5.2+ | 6.0+ | 6.0+ | 6.4+ | 7.0+ | 7.2+ |
| resque | 2.0+ | 2.0+ | 2.0+ | 2.2+ | 2.4+ | 2.6+ |
| delayed_job | 4.1+ | 4.1+ | 4.1+ | 4.1+ | 4.1+ | 4.1+ |
| good_job | N/A | 1.0+ | 2.0+ | 3.0+ | 3.10+ | 4.0+ |
| solid_queue | N/A | N/A | N/A | N/A | N/A | 1.0+ |

---

## Testing

| Gem | Rails 5.2 | Rails 6.0 | Rails 6.1 | Rails 7.0 | Rails 7.2 | Rails 8.0 |
|-----|-----------|-----------|-----------|-----------|-----------|-----------|
| rspec-rails | 3.8+ | 4.0+ | 4.0+ | 5.0+ | 6.0+ | 6.1+ |
| factory_bot_rails | 4.11+ | 5.0+ | 6.0+ | 6.2+ | 6.2+ | 6.4+ |
| capybara | 3.12+ | 3.28+ | 3.32+ | 3.36+ | 3.38+ | 3.40+ |
| shoulda-matchers | 3.1+ | 4.0+ | 4.4+ | 5.0+ | 5.3+ | 6.0+ |
| webmock | 3.4+ | 3.7+ | 3.10+ | 3.14+ | 3.18+ | 3.20+ |
| vcr | 4.0+ | 5.0+ | 6.0+ | 6.0+ | 6.1+ | 6.2+ |

---

## API & Serialization

| Gem | Rails 5.2 | Rails 6.0 | Rails 6.1 | Rails 7.0 | Rails 7.2 | Rails 8.0 |
|-----|-----------|-----------|-----------|-----------|-----------|-----------|
| jbuilder | 2.7+ | 2.9+ | 2.10+ | 2.11+ | 2.11+ | 2.12+ |
| active_model_serializers | 0.10+ | 0.10+ | 0.10+ | 0.10+ | 0.10+ | 0.10+ |
| jsonapi-serializer | N/A | 2.0+ | 2.1+ | 2.2+ | 2.2+ | 2.2+ |
| grape | 1.2+ | 1.3+ | 1.5+ | 1.6+ | 2.0+ | 2.1+ |
| graphql | 1.8+ | 1.9+ | 1.11+ | 2.0+ | 2.1+ | 2.2+ |

---

## File Handling

| Gem | Rails 5.2 | Rails 6.0 | Rails 6.1 | Rails 7.0 | Rails 7.2 | Rails 8.0 |
|-----|-----------|-----------|-----------|-----------|-----------|-----------|
| shrine | 2.16+ | 3.0+ | 3.3+ | 3.4+ | 3.5+ | 3.6+ |
| carrierwave | 1.3+ | 2.0+ | 2.1+ | 2.2+ | 3.0+ | 3.0+ |
| paperclip | 6.0+ | Deprecated | N/A | N/A | N/A | N/A |
| mini_magick | 4.9+ | 4.10+ | 4.11+ | 4.12+ | 4.12+ | 5.0+ |
| image_processing | 1.7+ | 1.10+ | 1.12+ | 1.12+ | 1.12+ | 1.12+ |

---

## Pagination

| Gem | Rails 5.2 | Rails 6.0 | Rails 6.1 | Rails 7.0 | Rails 7.2 | Rails 8.0 |
|-----|-----------|-----------|-----------|-----------|-----------|-----------|
| kaminari | 1.1+ | 1.2+ | 1.2+ | 1.2+ | 1.2+ | 1.2+ |
| will_paginate | 3.1+ | 3.3+ | 3.3+ | 4.0+ | 4.0+ | 4.0+ |
| pagy | 2.0+ | 3.0+ | 4.0+ | 5.0+ | 6.0+ | 8.0+ |

---

## Admin & CMS

| Gem | Rails 5.2 | Rails 6.0 | Rails 6.1 | Rails 7.0 | Rails 7.2 | Rails 8.0 |
|-----|-----------|-----------|-----------|-----------|-----------|-----------|
| activeadmin | 2.0+ | 2.6+ | 2.9+ | 2.13+ | 3.0+ | 3.2+ |
| rails_admin | 2.0+ | 2.2+ | 3.0+ | 3.1+ | 3.1+ | 3.2+ |
| administrate | 0.11+ | 0.13+ | 0.16+ | 0.17+ | 0.19+ | 0.20+ |

---

## Search

| Gem | Rails 5.2 | Rails 6.0 | Rails 6.1 | Rails 7.0 | Rails 7.2 | Rails 8.0 |
|-----|-----------|-----------|-----------|-----------|-----------|-----------|
| ransack | 2.1+ | 2.3+ | 2.4+ | 3.0+ | 4.0+ | 4.1+ |
| searchkick | 4.0+ | 4.3+ | 4.6+ | 5.0+ | 5.2+ | 5.3+ |
| pg_search | 2.2+ | 2.3+ | 2.3+ | 2.3+ | 2.3+ | 2.3+ |
| elasticsearch-rails | 6.1+ | 7.0+ | 7.1+ | 7.2+ | 8.0+ | 8.0+ |

---

## State Machines

| Gem | Rails 5.2 | Rails 6.0 | Rails 6.1 | Rails 7.0 | Rails 7.2 | Rails 8.0 |
|-----|-----------|-----------|-----------|-----------|-----------|-----------|
| aasm | 5.0+ | 5.0+ | 5.1+ | 5.2+ | 5.5+ | 5.5+ |
| state_machines-activerecord | 0.5+ | 0.6+ | 0.6+ | 0.6+ | 0.9+ | 0.9+ |

---

## Other Essential Gems

| Gem | Rails 5.2 | Rails 6.0 | Rails 6.1 | Rails 7.0 | Rails 7.2 | Rails 8.0 |
|-----|-----------|-----------|-----------|-----------|-----------|-----------|
| simple_form | 4.1+ | 5.0+ | 5.0+ | 5.1+ | 5.2+ | 5.3+ |
| draper | 3.1+ | 4.0+ | 4.0+ | 4.0+ | 4.0+ | 4.0+ |
| friendly_id | 5.2+ | 5.3+ | 5.4+ | 5.4+ | 5.5+ | 5.5+ |
| paranoia | 2.4+ | 2.4+ | 2.5+ | 2.6+ | 2.6+ | 3.0+ |
| paper_trail | 10.0+ | 10.3+ | 11.0+ | 12.0+ | 14.0+ | 15.0+ |
| geocoder | 1.5+ | 1.6+ | 1.6+ | 1.7+ | 1.8+ | 1.8+ |
| chartkick | 3.2+ | 3.4+ | 4.0+ | 4.2+ | 5.0+ | 5.0+ |

---

## Upgrade Order Recommendation

When upgrading Rails, update gems in this order:

1. **Update Ruby** to meet minimum requirements
2. **Update Rails** to target version
3. **Update critical gems** (authentication, authorization)
4. **Update testing gems** to fix test suite
5. **Update remaining gems** incrementally

---

## Checking Gem Compatibility

```bash
# Check for outdated gems
bundle outdated

# Check specific gem
bundle info devise

# Try updating single gem
bundle update devise --conservative

# Check for security issues
bundle audit check
```

---

## Finding Compatible Versions

1. **RubyGems.org** - Check gem page for version requirements
2. **GitHub Issues** - Search for "Rails X support"
3. **Gem Changelog** - Look for Rails compatibility notes
4. **Bundle update errors** - Rails version constraints shown in errors

---

## When Gems Block Upgrades

If a gem doesn't support your target Rails version:

1. **Check for forks** with Rails support
2. **Check GitHub PRs** for pending compatibility fixes
3. **Wait for update** if gem is actively maintained
4. **Consider alternatives** if gem is abandoned
5. **Fork and patch** as last resort

---

**Last Updated:** January 2025
