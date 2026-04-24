---
title: Callback Patterns and Organization
impact: MEDIUM
tags: [models, callbacks, patterns]
---

# Callback Patterns and Organization

Use callbacks strategically with consistent patterns. Prefer `after_*_commit` for async work, inline lambdas for simple operations, and the "remember and check" pattern for conditional callbacks.

## Why

- **Reliability**: `after_commit` ensures database state is persisted before side effects
- **Readability**: Inline lambdas are clear for simple operations
- **Control**: "Remember and check" pattern prevents unintended callback execution
- **Testability**: Predictable callback behavior is easier to test

## Pattern 1: after\_\*\_commit for Jobs

Always use `after_*_commit` (not `after_save`) when enqueuing jobs:

```ruby
# Bad: Job might run before transaction commits
after_create :notify_recipients_later

# Good: Job runs after transaction is committed
after_create_commit :notify_recipients_later

# Good: Specific to creation
after_create_commit :send_welcome_email

# Good: Specific to updates
after_update_commit :broadcast_changes
```

```ruby
module Notifiable
  extend ActiveSupport::Concern

  included do
    has_many :notifications, as: :source, dependent: :destroy
    after_create_commit :notify_recipients_later
  end

  private
    def notify_recipients_later
      NotifyRecipientsJob.perform_later(self)
    end
end
```

## Pattern 2: Inline Lambdas for Simple Operations

Use inline lambdas for simple, one-line callbacks:

```ruby
class Card < ApplicationRecord
  # Good: Simple touch operations
  after_save   -> { board.touch }, if: :published?
  after_touch  -> { board.touch }, if: :published?

  # Good: Simple dependent updates
  after_destroy_commit -> { creator.recalculate_stats }
end

class Board < ApplicationRecord
  # Good: Touch all related records
  after_update_commit -> { cards.touch_all }, if: :saved_change_to_name?
end

class Membership < ApplicationRecord
  # Good: Reset connections on destroy
  after_destroy_commit { user.reset_remote_connections }
end
```

## Pattern 3: Remember and Check

For callbacks that depend on changes detected during `before_*`, use instance variables to "remember" the condition:

```ruby
module Card::Stallable
  extend ActiveSupport::Concern

  included do
    before_update :remember_to_detect_activity_spikes
    after_update_commit :detect_activity_spikes_later, if: :should_detect_activity_spikes?
  end

  private
    def remember_to_detect_activity_spikes
      @should_detect_activity_spikes = published? && last_active_at_changed?
    end

    def should_detect_activity_spikes?
      @should_detect_activity_spikes
    end

    def detect_activity_spikes_later
      Card::ActivitySpike::DetectionJob.perform_later(self)
    end
end
```

Why this works:

1. `before_update` runs inside the transaction, can see dirty attributes
2. Instance variable stores the decision
3. `after_update_commit` runs after commit, dirty state is gone but variable persists

## Pattern 4: Conditional Callbacks

Use `:if` and `:unless` for simple conditions:

```ruby
class Card < ApplicationRecord
  after_create_commit :notify_watchers, if: :published?
  after_update_commit :broadcast_changes, if: :saved_change_to_title?
  after_save_commit :index_for_search, unless: :draft?
end
```

For complex conditions, use a method:

```ruby
class Message < ApplicationRecord
  after_create_commit :deliver_to_webhooks, if: :should_deliver_webhooks?

  private
    def should_deliver_webhooks?
      room.bots_enabled? && !creator.bot? && mentionees.any?(&:bot?)
    end
end
```

## Pattern 5: Custom Callbacks with define_callbacks

For complex lifecycle events that don't fit CRUD:

```ruby
module Account::Cancellable
  extend ActiveSupport::Concern

  included do
    has_one :cancellation, dependent: :destroy

    define_callbacks :cancel
    define_callbacks :reactivate
  end

  def cancel(initiated_by: Current.user)
    with_lock do
      if cancellable? && active?
        run_callbacks :cancel do
          create_cancellation!(initiated_by: initiated_by)
        end
        send_cancellation_email
      end
    end
  end

  def reactivate
    run_callbacks :reactivate do
      cancellation&.destroy
    end
  end
end

# Other concerns can hook into these callbacks
module Account::Subscription
  extend ActiveSupport::Concern

  included do
    set_callback :cancel, :after, :cancel_stripe_subscription
    set_callback :reactivate, :after, :resume_stripe_subscription
  end
end
```

## Pattern 6: Callback Ordering in Concerns

Define callbacks in the `included` block, with the callback method below:

```ruby
module Card::Searchable
  extend ActiveSupport::Concern

  included do
    after_save_commit :update_search_index, if: :searchable?
    after_destroy_commit :remove_from_search_index
  end

  def update_search_index
    Search::Entry.upsert(search_attributes)
  end

  def remove_from_search_index
    Search::Entry.where(searchable: self).delete_all
  end
end
```

## Anti-Patterns to Avoid

### Don't Use after_save for Jobs

```ruby
# Bad: Transaction might rollback after job is enqueued
after_save :send_notification_later

# Good: Wait for commit
after_save_commit :send_notification_later
```

### Don't Check Dirty Attributes in after_commit

```ruby
# Bad: Dirty state is cleared after commit
after_update_commit :log_change, if: :title_changed?

# Good: Use saved_change_to_* or remember pattern
after_update_commit :log_change, if: :saved_change_to_title?
```

### Don't Create Complex Callback Chains

```ruby
# Bad: Hard to follow and debug
after_create :step_one
after_create :step_two
after_create :step_three

# Good: Single callback that calls a method with clear steps
after_create_commit :handle_creation

private
  def handle_creation
    step_one
    step_two
    step_three
  end
```

## Rules

1. Use `after_*_commit` for any async work or external effects
2. Use inline lambdas for simple touch/update operations
3. Use "remember and check" when you need to detect changes in `before_*` but act in `after_commit`
4. Use `saved_change_to_*` in `after_commit` callbacks (not `*_changed?`)
5. Keep callbacks focused - one callback, one purpose
6. Define custom callbacks with `define_callbacks` for domain-specific lifecycle events
