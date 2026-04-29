---
title: Pair Synchronous Methods with Async _later Variants
impact: HIGH
tags: [jobs, async, patterns, models]
---

# Pair Synchronous Methods with Async \_later Variants

When a model method needs to run asynchronously, create a paired method with the `_later` suffix that enqueues a job calling the synchronous version.

## Why

- **Testability**: The synchronous method can be tested directly without job infrastructure
- **Flexibility**: Callers choose sync or async based on context
- **Clarity**: The naming convention makes async behavior explicit
- **Consistency**: A predictable pattern across the entire codebase

## Pattern Structure

```ruby
# Model provides both sync and async versions
class Card < ApplicationRecord
  def do_something
    # Synchronous implementation
  end

  def do_something_later
    DoSomethingJob.perform_later(self)
  end
end

# Job is a thin wrapper
class DoSomethingJob < ApplicationJob
  def perform(card)
    card.do_something
  end
end
```

## Bad: Logic in the Job

```ruby
# app/jobs/remove_inaccessible_notifications_job.rb
class RemoveInaccessibleNotificationsJob < ApplicationJob
  def perform(card)
    # Business logic buried in job
    accessible_user_ids = card.board.accesses.pluck(:user_id)
    card.notifications.where.not(user_id: accessible_user_ids).destroy_all
  end
end

# app/models/card.rb
class Card < ApplicationRecord
  def remove_inaccessible_notifications_later
    RemoveInaccessibleNotificationsJob.perform_later(self)
  end
  # No way to call this synchronously!
end
```

## Good: Logic in Model, Job Delegates

```ruby
# app/models/card/readable.rb
module Card::Readable
  extend ActiveSupport::Concern

  def remove_inaccessible_notifications
    accessible_user_ids = board.accesses.pluck(:user_id)
    notification_sources.each do |sources|
      inaccessible_notifications_from(sources, accessible_user_ids)
        .in_batches
        .destroy_all
    end
  end

  private
    def remove_inaccessible_notifications_later
      Card::RemoveInaccessibleNotificationsJob.perform_later(self)
    end
end

# app/jobs/card/remove_inaccessible_notifications_job.rb
class Card::RemoveInaccessibleNotificationsJob < ApplicationJob
  discard_on ActiveJob::DeserializationError

  def perform(card)
    card.remove_inaccessible_notifications
  end
end
```

## Naming Convention: `_later` vs `_now`

Use `_later` for the async version. If needed, use `_now` for emphasis:

```ruby
# Standard case: method + method_later
def deliver
  # sync delivery
end

def deliver_later
  DeliveryJob.perform_later(self)
end

# When called from a callback (async default), add _now for sync
# app/models/event/relaying.rb
module Event::Relaying
  included do
    after_create_commit :relay_later
  end

  def relay_later
    Event::RelayJob.perform_later(self)
  end

  def relay_now
    # Synchronous relay logic
  end
end

# app/jobs/event/relay_job.rb
class Event::RelayJob < ApplicationJob
  def perform(event)
    event.relay_now
  end
end
```

## Real-World Examples

### Storage Materialization

```ruby
# app/models/concerns/storage/totaled.rb
module Storage::Totaled
  def materialize_storage
    total = create_or_find_storage_total
    total.with_lock do
      total.update!(bytes_stored: calculate_current_storage)
    end
  end

  def materialize_storage_later
    Storage::MaterializeJob.perform_later(self)
  end
end

# app/jobs/storage/materialize_job.rb
class Storage::MaterializeJob < ApplicationJob
  queue_as :backend
  limits_concurrency to: 1, key: ->(owner) { owner }
  discard_on ActiveJob::DeserializationError

  def perform(owner)
    owner.materialize_storage
  end
end
```

### Webhook Delivery

```ruby
# app/models/webhook/delivery.rb
class Webhook::Delivery < ApplicationRecord
  after_create_commit :deliver_later

  def deliver_later
    Webhook::DeliveryJob.perform_later(self)
  end

  def deliver
    in_progress!
    self.response = perform_request
    completed!
  rescue => e
    errored!
    raise
  end
end
```

### Mentions Creation

```ruby
# app/models/concerns/mentions.rb
module Mentions
  included do
    after_save_commit :create_mentions_later, if: :should_create_mentions?
  end

  def create_mentions(mentioner: Current.user)
    scan_mentionees.each do |mentionee|
      mentionee.mentioned_by mentioner, at: self
    end
  end

  private
    def create_mentions_later
      Mention::CreateJob.perform_later(self, mentioner: Current.user)
    end
end
```

## Visibility Guidelines

- The `_later` method is often **private** when called from callbacks
- Make it **public** if controllers or other models need to call it directly
- The synchronous method should always be **public** for testing and direct use

```ruby
module Card::Accessible
  def clean_inaccessible_data
    # Public sync method
  end

  private
    def clean_inaccessible_data_later
      # Private - only called from callbacks
      Card::CleanInaccessibleDataJob.perform_later(self)
    end
end
```

## Rules

1. Name async methods with `_later` suffix
2. Keep jobs thin - they only call the model method
3. The synchronous method contains all business logic
4. Use `_now` suffix when the async version is the default (e.g., from callbacks)
5. Make `_later` private if only used from callbacks
6. Always add `discard_on ActiveJob::DeserializationError` to handle deleted records
