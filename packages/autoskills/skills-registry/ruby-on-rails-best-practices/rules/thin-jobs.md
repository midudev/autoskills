---
title: Keep Jobs Thin
impact: HIGH
tags: [jobs, architecture, patterns]
---

# Keep Jobs Thin

Jobs should be thin wrappers that receive records and call model methods. All business logic belongs in the model layer.

## Why

- **Testability**: Model methods can be unit tested without job infrastructure
- **Reusability**: The same logic can be called sync or async
- **Debuggability**: Easier to trace issues when logic isn't buried in jobs
- **Consistency**: Models are the single source of truth for domain logic

## Bad: Business Logic in Jobs

```ruby
class ProcessOrderJob < ApplicationJob
  def perform(order)
    return if order.processed?

    order.transaction do
      order.line_items.each do |item|
        item.product.decrement!(:stock, item.quantity)
      end

      order.update!(
        status: :processing,
        processed_at: Time.current
      )

      order.payments.pending.each(&:capture!)
    end

    OrderMailer.confirmation(order).deliver_later
    WebhookService.notify(:order_processed, order)
  end
end
```

Problems:

- Can't test processing logic without jobs
- Can't process synchronously when needed
- Logic is hidden from model/domain layer

## Good: Jobs Delegate to Models

```ruby
# app/jobs/process_order_job.rb
class ProcessOrderJob < ApplicationJob
  discard_on ActiveJob::DeserializationError

  def perform(order)
    order.process
  end
end

# app/models/order.rb
class Order < ApplicationRecord
  def process
    return if processed?

    transaction do
      decrement_stock
      mark_as_processing
      capture_payments
    end

    send_confirmation
    notify_webhooks
  end

  def process_later
    ProcessOrderJob.perform_later(self)
  end

  private
    def decrement_stock
      line_items.each do |item|
        item.product.decrement!(:stock, item.quantity)
      end
    end

    def mark_as_processing
      update!(status: :processing, processed_at: Time.current)
    end

    def capture_payments
      payments.pending.each(&:capture!)
    end

    def send_confirmation
      OrderMailer.confirmation(self).deliver_later
    end

    def notify_webhooks
      WebhookService.notify(:order_processed, self)
    end
end
```

## Job Responsibilities

Jobs should ONLY:

1. **Receive arguments** (records, simple values)
2. **Call a single model method**
3. **Handle job-specific concerns** (retries, discards, queues)

```ruby
class Card::ActivitySpike::DetectionJob < ApplicationJob
  discard_on ActiveJob::DeserializationError

  def perform(card)
    card.detect_activity_spikes  # Single method call
  end
end

class Notification::Bundle::DeliverJob < ApplicationJob
  include SmtpDeliveryErrorHandling  # Job concern for retries
  queue_as :backend
  discard_on ActiveJob::DeserializationError

  def perform(bundle)
    bundle.deliver  # Single method call
  end
end
```

## When Jobs Can Have More Logic

### Batch Operations

Jobs that process collections may have iteration logic:

```ruby
class DeleteUnusedTagsJob < ApplicationJob
  def perform
    Tag.unused.find_each do |tag|
      tag.destroy!
    end
  end
end
```

But even here, consider a class method:

```ruby
# Better: model class method
class Tag < ApplicationRecord
  def self.delete_unused
    unused.find_each(&:destroy!)
  end
end

class DeleteUnusedTagsJob < ApplicationJob
  def perform
    Tag.delete_unused
  end
end
```

### Keyword Arguments

Jobs can accept keyword arguments alongside records:

```ruby
class Mention::CreateJob < ApplicationJob
  discard_on ActiveJob::DeserializationError

  def perform(record, mentioner:)
    record.create_mentions(mentioner: mentioner)
  end
end
```

## Job Naming Convention

Jobs should be namespaced to mirror the model they operate on:

| Model/Concern          | Job                                 |
| ---------------------- | ----------------------------------- |
| `Card::Accessible`     | `Card::CleanInaccessibleDataJob`    |
| `Card::Stallable`      | `Card::ActivitySpike::DetectionJob` |
| `Storage::Totaled`     | `Storage::MaterializeJob`           |
| `Notification::Bundle` | `Notification::Bundle::DeliverJob`  |
| `Webhook::Delivery`    | `Webhook::DeliveryJob`              |

## Rules

1. Jobs call one method on the received record
2. All business logic lives in models
3. Jobs handle only job-specific concerns (queues, retries, error handling)
4. Namespace jobs to mirror model structure
5. Always include `discard_on ActiveJob::DeserializationError`
