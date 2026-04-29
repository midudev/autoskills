# Example: Simple Single-Hop Upgrade

**Scenario:** Upgrading from Rails 7.1 to Rails 7.2

---

## User Request

"I want to upgrade my Rails app from 7.1 to 7.2"

---

### Claude Response

I'll help you upgrade from Rails 7.1 to 7.2. Let me find any breaking changes in your codebase.

## Detection Results

# Rails 7.1 → 7.2 Upgrade Report

**Generated:** January 30, 2025
**Project:** my-blog
**Current Version:** 7.1.x
**Target Version:** 7.2.x

## Summary

- **Total Issues Found:** 5
- **High Priority:** 5
- **Medium Priority:** 0
- **Estimated Effort:** 2-3 hours

---

## Breaking Changes Analysis

### 🔴 Transaction-aware job enqueuing

**Priority:** HIGH
**Found:** 3 occurrences
**Affected Files:**
- app/models/article.rb
- app/controllers/comments_controller.rb

#### What Changed
Rails 7.2 now defers job enqueuing until after the current database transaction commits. This ensures data consistency but changes timing behavior.

#### Your Code (Before)
```ruby
# app/models/article.rb
class Article < ApplicationRecord
  after_create :notify_subscribers

  def notify_subscribers
    NotifySubscribersJob.perform_later(self)
  end
end
```

#### Required Change (After)
```ruby
# app/models/article.rb
class Article < ApplicationRecord
  after_create_commit :notify_subscribers  # Use after_create_commit instead

  def notify_subscribers
    NotifySubscribersJob.perform_later(self)
  end
end
```

⚠️ **Custom Code Warning:** Your `article.rb` enqueues jobs inside model callbacks. Test that the job receives valid (persisted) data after the transaction commits.

---

### 🔴 show_exceptions configuration

**Priority:** HIGH
**Found:** 2 occurrences
**Affected Files:**
- config/environments/development.rb
- config/environments/test.rb

#### What Changed
Rails 7.2 requires symbol values (`:all`, `:rescuable`, `:none`) instead of boolean values.

#### Your Code (Before)
```ruby
# config/environments/development.rb
config.consider_all_requests_local = true
config.action_dispatch.show_exceptions = true

# config/environments/test.rb
config.consider_all_requests_local = true
config.action_dispatch.show_exceptions = false
```

#### Required Change (After)
```ruby
# config/environments/development.rb
config.consider_all_requests_local = true
config.action_dispatch.show_exceptions = :all

# config/environments/test.rb
config.consider_all_requests_local = true
config.action_dispatch.show_exceptions = :rescuable
```

---

## Step-by-Step Migration Plan

### Phase 1: Preparation (30 min)
- [ ] Backup database
- [ ] Create upgrade branch: `git checkout -b rails-72-upgrade`
- [ ] Run current test suite (ensure passing)

### Phase 2: Dependency Updates (30 min)
- [ ] Update Gemfile:
  ```ruby
  gem 'rails', '~> 7.2.0'
  ```
- [ ] Run `bundle update rails`

### Phase 3: Fix Breaking Changes (1-2 hours)
- [ ] Update `config/environments/development.rb`
- [ ] Update `config/environments/test.rb`
- [ ] Review job callbacks in `app/models/article.rb`
- [ ] Review job calls in `app/controllers/comments_controller.rb`

### Phase 4: Configuration (30 min)
- [ ] Run `rails app:update`
- [ ] Update `config.load_defaults` to 7.2

### Phase 5: Testing (1 hour)
- [ ] Run full test suite
- [ ] Test article creation (verify job timing)
- [ ] Test comment creation

---

## Testing Checklist

- [ ] All existing tests pass
- [ ] Article creation triggers notification job (after commit)
- [ ] Comment features work correctly
- [ ] Error pages display correctly in development
- [ ] Test environment shows proper error handling

---

## app:update Preview

### Files that will change:

| File | Change | Impact |
|------|--------|--------|
| config/environments/development.rb | show_exceptions update | MEDIUM |
| config/environments/test.rb | show_exceptions update | MEDIUM |
| config/application.rb | load_defaults 7.2 | LOW |

---

## Next Steps

1. Start with the configuration changes (quick wins)
2. Test the transaction-aware job behavior thoroughly
3. Run `rails app:update` and review changes
4. Let me know if you need help with any specific change!
