# Test Suite Verification Workflow

**Purpose:** Run and verify the test suite BEFORE any upgrade work begins

**When to use:** MANDATORY first step for ALL upgrade requests - no exceptions

---

## Why This Step is Critical

The FastRuby.io methodology requires a green test suite before starting any upgrade:

1. **Establishes Baseline** - Know what works before making changes
2. **Catches Pre-existing Issues** - Don't blame the upgrade for existing bugs
3. **Enables Confidence** - Verify changes don't break existing functionality
4. **Prevents Wasted Effort** - Don't upgrade code that's already broken

**If tests fail before the upgrade, they will definitely fail after.**

---

## Step-by-Step Workflow

### Step 1: Detect Test Framework

Check which test framework the project uses:

```bash
# Check for RSpec
if [ -d "spec" ] && [ -f "spec/spec_helper.rb" ]; then
  TEST_FRAMEWORK="rspec"
fi

# Check for Minitest
if [ -d "test" ] && [ -f "test/test_helper.rb" ]; then
  TEST_FRAMEWORK="minitest"
fi
```

**Detection Logic:**
- If `spec/` directory exists with `spec_helper.rb` → RSpec
- If `test/` directory exists with `test_helper.rb` → Minitest
- If both exist → Prefer RSpec, but note both are available
- Check Gemfile for `rspec-rails` or `minitest` gems

---

### Step 2: Run the Test Suite

Execute the appropriate test command:

**For RSpec:**
```bash
bundle exec rspec --format progress
```

**For Minitest:**
```bash
bundle exec rails test
```

**For both (if project uses both):**
```bash
bundle exec rspec && bundle exec rails test
```

**With Coverage (if SimpleCov is configured):**
```bash
COVERAGE=true bundle exec rspec
```

---

### Step 3: Capture Results

Parse the test output to extract:

| Metric | Description | Example |
|--------|-------------|---------|
| Total Tests | Number of test examples | 245 examples |
| Passing | Tests that passed | 240 passed |
| Failing | Tests that failed | 3 failures |
| Pending | Skipped/pending tests | 2 pending |
| Coverage | Code coverage % (if available) | 78.5% |
| Duration | Time to run tests | 45.2 seconds |

**RSpec Output Pattern:**
```
245 examples, 3 failures, 2 pending
```

**Minitest Output Pattern:**
```
245 runs, 512 assertions, 3 failures, 0 errors, 2 skips
```

---

### Step 4: Evaluate Results

#### If ALL Tests Pass (0 failures):

```
✅ TEST SUITE PASSED

Baseline Metrics:
- Total tests: 245
- Passing: 245 (100%)
- Pending: 2
- Coverage: 78.5% (if available)
- Duration: 45.2s

Proceeding with upgrade assessment...
```

**Action:** Continue to Step 2 of the main workflow (Detect Current Version)

#### If ANY Tests Fail:

```
❌ TEST SUITE FAILED - UPGRADE BLOCKED

Results:
- Total tests: 245
- Passing: 240
- Failing: 3
- Pending: 2

⚠️  CANNOT PROCEED WITH UPGRADE

The following tests must be fixed before upgrading:

1. spec/models/user_spec.rb:45
   - Expected true, got false

2. spec/controllers/posts_controller_spec.rb:123
   - NoMethodError: undefined method 'foo'

3. spec/features/login_spec.rb:67
   - Timeout waiting for element

Would you like help fixing these failing tests?
```

**Action:** STOP the upgrade process. Offer to help fix failing tests.

---

### Step 5: Handle Edge Cases

#### No Tests Found

```
⚠️  NO TEST SUITE DETECTED

Could not find:
- spec/ directory (RSpec)
- test/ directory (Minitest)

This is a significant risk for upgrading. Consider:
1. Adding test coverage before upgrading
2. Proceeding with extra manual testing (not recommended)

Do you want to proceed without tests? (This is risky)
```

**Action:** Warn user strongly, but allow them to proceed if they acknowledge the risk.

#### Tests Take Too Long (> 10 minutes)

```
⏱️  TEST SUITE RUNNING...

The test suite is taking longer than expected.
Current progress: 150/245 tests completed

Options:
1. Continue waiting for full suite
2. Run a subset of critical tests
3. Skip test verification (not recommended)
```

#### Test Database Issues

If tests fail due to database issues:

```bash
# Common fixes
bundle exec rails db:test:prepare
bundle exec rails db:migrate RAILS_ENV=test
```

---

## Output Format

When presenting results to user, use this format:

### Tests Passed:

```markdown
## Test Suite Verification ✅

**Status:** PASSED - Ready for upgrade

| Metric | Value |
|--------|-------|
| Total Tests | 245 |
| Passing | 245 |
| Failing | 0 |
| Pending | 2 |
| Coverage | 78.5% |
| Duration | 45.2s |

Baseline recorded. Proceeding with upgrade assessment...
```

### Tests Failed:

```markdown
## Test Suite Verification ❌

**Status:** FAILED - Upgrade blocked

| Metric | Value |
|--------|-------|
| Total Tests | 245 |
| Passing | 240 |
| Failing | 3 |
| Pending | 2 |

### Failing Tests

The following tests must pass before upgrading:

1. **spec/models/user_spec.rb:45**
   ```
   Failure/Error: expect(user.active?).to be true
   expected true, got false
   ```

2. **spec/controllers/posts_controller_spec.rb:123**
   ```
   NoMethodError: undefined method 'foo' for #<Post:0x00007f>
   ```

3. **spec/features/login_spec.rb:67**
   ```
   Capybara::ElementNotFound: Unable to find button "Login"
   ```

### Next Steps

1. Fix the failing tests above
2. Run the test suite again: `bundle exec rspec`
3. Once all tests pass, we can proceed with the upgrade

Would you like help debugging these test failures?
```

---

## Common Test Failures and Fixes

### 1. Database Schema Mismatch

**Error:** `ActiveRecord::PendingMigrationError`

**Fix:**
```bash
bundle exec rails db:migrate RAILS_ENV=test
```

### 2. Missing Test Database

**Error:** `ActiveRecord::NoDatabaseError`

**Fix:**
```bash
bundle exec rails db:create RAILS_ENV=test
bundle exec rails db:schema:load RAILS_ENV=test
```

### 3. Stale Factory Definitions

**Error:** `FactoryBot::InvalidFactoryError`

**Fix:** Update factory definitions to match current model validations

### 4. Time-Dependent Tests

**Error:** Tests pass locally but fail in CI (or vice versa)

**Fix:**
```ruby
# Use travel_to for time-dependent tests
travel_to Time.zone.local(2024, 1, 1) do
  # test code
end
```

### 5. Missing Environment Variables

**Error:** `KeyError: key not found`

**Fix:** Ensure `.env.test` or test environment has required variables

---

## Integration with Main Workflow

This workflow integrates with the main upgrade process:

```
┌─────────────────────────────────────────┐
│  Step 1: Test Suite Verification        │
│  (THIS WORKFLOW)                        │
│                                         │
│  ┌─────────────┐    ┌─────────────────┐ │
│  │ Run Tests   │───▶│ All Pass?       │ │
│  └─────────────┘    └─────────────────┘ │
│                            │            │
│              ┌─────────────┴──────────┐ │
│              ▼                        ▼ │
│         ┌────────┐              ┌──────┐│
│         │  YES   │              │  NO  ││
│         └────────┘              └──────┘│
│              │                      │   │
│              ▼                      ▼   │
│     ┌──────────────┐      ┌───────────┐ │
│     │ Record       │      │ STOP      │ │
│     │ Baseline     │      │ Help Fix  │ │
│     │ Continue     │      │ Tests     │ │
│     └──────────────┘      └───────────┘ │
└─────────────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────┐
│  Step 2: Detect Current Version         │
│  (Continue main workflow)               │
└─────────────────────────────────────────┘
```

---

## Quality Checklist

Before proceeding past this step:

- [ ] Test framework detected correctly
- [ ] Test suite executed successfully
- [ ] All tests pass (0 failures)
- [ ] Baseline metrics recorded
- [ ] User informed of results
- [ ] If failures: user understands they must fix tests first

---

**This step is NON-NEGOTIABLE. Never skip test verification.**
