# Deprecation Warnings Guide

**Based on "The Complete Guide to Upgrade Rails" by FastRuby.io (OmbuLabs)**

---

## Overview

Deprecation warnings notify you that a specific feature (method, class, or API) will be removed in a future version and should be replaced. Features are deprecated rather than immediately removed to:

- Provide backward compatibility
- Give developers time to update their code
- Allow gradual migration to new patterns

---

## Finding Deprecation Warnings

### In Test Suite Logs

If you have good test coverage, run your test suite and check the logs:

```bash
# Run tests and capture output
bundle exec rspec 2>&1 | tee test_output.log

# Search for deprecation warnings
grep "DEPRECATION WARNING" test_output.log
```

All Rails deprecation warnings start with `DEPRECATION WARNING:`.

### In CI Services

Most CI services (CircleCI, GitHub Actions, Travis CI) display full test output. After the build finishes, search the logs for `DEPRECATION WARNING`.

### In Test Log File

```bash
# After running tests
grep "DEPRECATION WARNING" log/test.log
```

### In Production

The best way to discover production deprecation warnings is through a monitoring tool like [Honeybadger](https://www.honeybadger.io/), [Sentry](https://sentry.io/), or [Airbrake](https://airbrake.io/).

**Configure Rails to notify on deprecations:**

```ruby
# config/environments/production.rb
config.active_support.deprecation = :notify
```

**Subscribe to deprecation events:**

```ruby
# config/initializers/deprecation_warnings.rb

ActiveSupport::Notifications.subscribe('deprecation.rails') do |name, start, finish, id, payload|
  # Honeybadger
  Honeybadger.notify(
    error_class: "DeprecationWarning",
    error_message: payload[:message],
    backtrace: payload[:callstack]
  )

  # Or Sentry
  # Sentry.capture_message(
  #   payload[:message],
  #   level: :warning,
  #   backtrace: payload[:callstack]
  # )

  # Or Airbrake
  # Airbrake.notify(
  #   error_class: "DeprecationWarning",
  #   error_message: payload[:message],
  #   backtrace: payload[:callstack]
  # )
end
```

See the [ActiveSupport Instrumentation Guide](https://guides.rubyonrails.org/active_support_instrumentation.html#subscribing-to-an-event) for more details.

### Alternative: Log to Production Log

```ruby
# config/environments/production.rb
config.active_support.deprecation = :log
```

Then check `log/production.log`, but this can be noisy on high-traffic applications.

---

## Tracking Deprecation Warnings

Once you've collected deprecation warnings, track them systematically:

### 1. Create Issues for Each Root Cause

Use your project management tool (Jira, Linear, GitHub Issues) to create a story for each unique deprecation warning. This helps with:

- Code review organization
- Progress tracking
- Team visibility

### 2. Prioritize by Frequency

Address the most common deprecation warnings first. They often fix the largest number of occurrences with a single change.

### 3. Group Related Warnings

Some warnings share a root cause. For example, `update_attributes` being deprecated affects multiple files but has one fix pattern.

---

## Fixing Deprecation Warnings

### Process

1. **Pick a warning** from the top of your backlog
2. **Understand the fix** - Most warnings clearly state what to replace
3. **Search for all occurrences** in the project
4. **Apply the fix** consistently
5. **Run tests** for affected code
6. **Create a pull request**
7. **Move to the next warning**

### Example Fix

**Warning:**
```
DEPRECATION WARNING: update_attributes is deprecated and will be removed
from Rails 6.1 (please, use update instead)
```

**Search and Replace:**
```bash
# Find all occurrences
grep -r "update_attributes" app/ lib/ --include="*.rb"

# In your editor, replace:
# object.update_attributes(params)
# with:
# object.update(params)
```

### Warnings from Gems

Sometimes deprecation warnings come from gems, not your code. In this case:

1. Check if a newer version of the gem fixes the issue
2. Run `bundle outdated` to see available updates
3. Update the gem: `bundle update gem_name`
4. If no fix exists, consider contributing a patch or finding an alternative

---

## Preventing Future Deprecation Debt

### Treat Warnings as Errors

Configure test and development environments to raise on deprecation:

```ruby
# config/environments/test.rb
config.active_support.deprecation = :raise

# config/environments/development.rb
config.active_support.deprecation = :raise
```

This immediately surfaces deprecations during development and in CI.

### Use Rubocop for Regression Prevention

Write custom Rubocop cops to prevent deprecated patterns. See [Lint/DeprecatedClassMethods](https://github.com/rubocop-hq/rubocop/blob/master/lib/rubocop/cop/lint/deprecated_class_methods.rb) for examples.

Example custom cop:

```ruby
# lib/rubocop/cop/custom/no_update_attributes.rb

module RuboCop
  module Cop
    module Custom
      class NoUpdateAttributes < Base
        MSG = 'Use `update` instead of `update_attributes`.'

        def_node_matcher :update_attributes?, <<~PATTERN
          (send _ {:update_attributes :update_attributes!} ...)
        PATTERN

        def on_send(node)
          return unless update_attributes?(node)
          add_offense(node)
        end
      end
    end
  end
end
```

---

## Rails 6.1+ Disallowed Deprecations

Rails 6.1 introduced a feature to disallow specific deprecations. Once you fix a deprecation, you can prevent it from reappearing:

```ruby
# config/environments/test.rb

# Treat disallowed deprecations as failures
ActiveSupport::Deprecation.disallowed_behavior = [:raise]

# List of disallowed deprecation patterns
ActiveSupport::Deprecation.disallowed_warnings = [
  # String match
  "update_attributes",

  # Symbol match
  :update_attributes,

  # Regex match
  /(update_attributes)!?/,

  # Multiple patterns
  "before_filter",
  "after_filter",
]
```

### How It Works

- **Allowed deprecations**: Logged normally (warning level)
- **Disallowed deprecations**: Raise an exception in development/test, logged as error in production

### Recommended Workflow

1. Fix a deprecation warning
2. Add it to `disallowed_warnings`
3. Any reintroduction will fail tests

---

## Deprecation Configuration Options

| Setting | Behavior |
|---------|----------|
| `:raise` | Raise an exception (stops execution) |
| `:log` | Log to Rails logger |
| `:notify` | Send to `ActiveSupport::Notifications` |
| `:silence` | Ignore (not recommended) |
| `:stderr` | Print to stderr |
| `:report` | Report via error reporter (Rails 7.1+) |

**Recommended settings:**

```ruby
# config/environments/development.rb
config.active_support.deprecation = :raise

# config/environments/test.rb
config.active_support.deprecation = :raise

# config/environments/production.rb
config.active_support.deprecation = :notify
```

---

## Common Deprecation Patterns by Rails Version

### Rails 5.0 → 5.1
- `render :text` → `render :plain`
- `redirect_to :back` → `redirect_back`

### Rails 5.1 → 5.2
- `secrets.yml` → `credentials.yml.enc`
- `config.active_record.belongs_to_required_by_default`

### Rails 5.2 → 6.0
- `update_attributes` → `update`
- Classic autoloader → Zeitwerk

### Rails 6.0 → 6.1
- `Rails.application.secrets` → `Rails.application.credentials`

### Rails 6.1 → 7.0
- `to_s(:format)` → `to_fs(:format)`
- Turbolinks → Turbo

### Rails 7.0 → 7.1
- `before_action` callback order changes
- `config.cache_classes` → `config.enable_reloading`

### Rails 7.1 → 7.2
- `show_exceptions` boolean → symbol
- `params == hash` → `params.to_h == hash`

---

## Quick Reference

### Find Deprecations
```bash
# In test logs
grep "DEPRECATION WARNING" log/test.log

# In CI output
# Search the build log for "DEPRECATION WARNING"

# Run tests with verbose output
RAILS_ENV=test bundle exec rspec 2>&1 | grep "DEPRECATION"
```

### Configure Strict Mode
```ruby
# config/environments/test.rb
config.active_support.deprecation = :raise
```

### Track in Production
```ruby
# config/environments/production.rb
config.active_support.deprecation = :notify

# config/initializers/deprecation_warnings.rb
ActiveSupport::Notifications.subscribe('deprecation.rails') do |*, payload|
  YourErrorTracker.notify(payload[:message])
end
```

---

## Resources

- [Rails Deprecation Behavior](https://guides.rubyonrails.org/configuring.html#config-active-support-deprecation)
- [ActiveSupport Instrumentation](https://guides.rubyonrails.org/active_support_instrumentation.html)
- [Rubocop](https://github.com/rubocop-hq/rubocop)
