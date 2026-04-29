# Testing Checklist for Rails Upgrades

**Comprehensive testing checklist based on FastRuby.io methodology**

---

## Pre-Upgrade Testing

### 1. Current State Verification

- [ ] All existing tests pass
- [ ] Run with deprecation warnings enabled:
  ```bash
  RUBYOPT="-W:deprecated" bundle exec rspec
  ```
- [ ] Note current test coverage percentage
- [ ] Document any known failing tests

### 2. Establish Baseline

- [ ] Record current boot time
- [ ] Record average request time
- [ ] Record memory usage
- [ ] Capture current error rate
- [ ] Screenshot key pages

---

## During Upgrade Testing

### 1. After Each Change

- [ ] Application boots without errors
- [ ] Run quick smoke test (5 critical flows)
- [ ] No new deprecation warnings introduced

### 2. After bundle update rails

- [ ] `rails console` works
- [ ] `rails server` starts
- [ ] Basic route works (hit homepage)

### 3. After rails app:update

- [ ] Review each config change
- [ ] Application still boots
- [ ] Run test suite

---

## Post-Upgrade Testing

### Automated Tests

#### Unit Tests
- [ ] Model tests pass
- [ ] Service object tests pass
- [ ] Library tests pass
- [ ] Concern tests pass

#### Controller Tests
- [ ] Index actions work
- [ ] Show actions work
- [ ] Create actions work
- [ ] Update actions work
- [ ] Delete actions work
- [ ] API endpoints work

#### Integration Tests
- [ ] Multi-step workflows pass
- [ ] Authentication flows work
- [ ] Authorization checks work

#### System/Feature Tests
- [ ] JavaScript interactions work
- [ ] Form submissions work
- [ ] File uploads work
- [ ] Navigation flows work

---

### Manual Testing Checklist

#### Authentication & Authorization
- [ ] User can sign up
- [ ] User can log in
- [ ] User can log out
- [ ] Password reset works
- [ ] OAuth login works (if applicable)
- [ ] Session timeout works
- [ ] Remember me works
- [ ] Role-based access works

#### Core Features
- [ ] Main dashboard loads
- [ ] Search functionality works
- [ ] Filtering works
- [ ] Sorting works
- [ ] Pagination works
- [ ] CRUD operations work

#### File Handling
- [ ] File upload works
- [ ] Image upload works
- [ ] File download works
- [ ] Image processing works (variants)
- [ ] Direct uploads work (if using)

#### Email
- [ ] Emails are sent
- [ ] Email templates render correctly
- [ ] Links in emails work
- [ ] Attachments work
- [ ] Mailer previews work

#### Background Jobs
- [ ] Jobs enqueue correctly
- [ ] Jobs process correctly
- [ ] Failed jobs retry
- [ ] Job callbacks fire
- [ ] Scheduled jobs run

#### Real-time Features (if applicable)
- [ ] ActionCable connections work
- [ ] WebSocket messages deliver
- [ ] Broadcast works
- [ ] Subscriptions work

#### API (if applicable)
- [ ] Authentication works
- [ ] JSON responses correct
- [ ] Status codes correct
- [ ] Rate limiting works
- [ ] CORS works

#### Assets
- [ ] CSS loads correctly
- [ ] JavaScript loads correctly
- [ ] Images load correctly
- [ ] Fonts load correctly
- [ ] Asset fingerprinting works
- [ ] Asset compilation works

#### Forms
- [ ] Simple forms submit
- [ ] Nested forms work
- [ ] File upload forms work
- [ ] Remote forms work (Turbo)
- [ ] Form validation displays
- [ ] CSRF protection works

#### Caching
- [ ] Page caching works (if used)
- [ ] Fragment caching works
- [ ] Russian doll caching works
- [ ] Cache invalidation works
- [ ] Session storage works

#### Database
- [ ] Queries execute correctly
- [ ] Transactions work
- [ ] Connection pooling works
- [ ] Multi-database works (if used)

---

### Performance Testing

- [ ] Boot time is acceptable
- [ ] Request times similar to baseline
- [ ] Memory usage similar to baseline
- [ ] No N+1 queries introduced
- [ ] Database query times acceptable

---

### Browser Testing

- [ ] Chrome works
- [ ] Firefox works
- [ ] Safari works
- [ ] Mobile responsive works
- [ ] No JavaScript console errors

---

### Security Testing

- [ ] CSRF protection enabled
- [ ] XSS protection works
- [ ] SQL injection protected
- [ ] Strong parameters work
- [ ] Secrets/credentials accessible
- [ ] SSL/HTTPS works

---

## Staging Deployment Checklist

- [ ] Deployment succeeds
- [ ] Database migrations run
- [ ] Asset compilation works
- [ ] Background workers start
- [ ] Application boots in production mode
- [ ] Environment variables correct
- [ ] External service connections work
- [ ] Error tracking works (Sentry, etc.)
- [ ] Logging works
- [ ] Monitoring dashboards show data

---

## Production Deployment Checklist

### Before Deploy
- [ ] Staging tests complete
- [ ] Rollback plan documented
- [ ] Team notified of deployment
- [ ] Low-traffic window chosen
- [ ] Database backup taken

### During Deploy
- [ ] Monitor deployment progress
- [ ] Watch for deployment errors
- [ ] Verify workers restart

### After Deploy (First 15 minutes)
- [ ] Application responds
- [ ] Check error tracking for spikes
- [ ] Verify key user flows work
- [ ] Monitor response times
- [ ] Check background jobs processing

### After Deploy (First hour)
- [ ] Error rate normal
- [ ] Performance metrics stable
- [ ] No user complaints
- [ ] Jobs backlog clearing

### After Deploy (First day)
- [ ] Review all errors
- [ ] Check for edge cases
- [ ] Monitor resource usage
- [ ] Gather user feedback

---

## Rollback Triggers

Rollback immediately if:

- [ ] Error rate > 2x normal
- [ ] Response time > 3x normal
- [ ] Critical feature broken
- [ ] Data integrity issues
- [ ] Security vulnerability discovered
- [ ] External service integration broken

---

## Test Environment Setup

```bash
# Run tests with Rails next version
BUNDLE_GEMFILE=Gemfile.next bundle exec rspec

# Run with verbose deprecation warnings
RUBYOPT="-W:deprecated" bundle exec rspec

# Run specific test file
bundle exec rspec spec/models/user_spec.rb

# Run with coverage
COVERAGE=true bundle exec rspec
```

---

## Common Test Fixes

### 1. Time-dependent tests
```ruby
# Use travel_to instead of fixed times
travel_to Time.zone.local(2024, 1, 1) do
  # test code
end
```

### 2. Database cleanup
```ruby
# Ensure proper cleanup between tests
RSpec.configure do |config|
  config.use_transactional_fixtures = true
end
```

### 3. Asset pipeline tests
```ruby
# Stub asset methods if needed
allow(helper).to receive(:asset_path).and_return("/assets/test.png")
```

---

**Keep this checklist visible throughout the upgrade process!**
