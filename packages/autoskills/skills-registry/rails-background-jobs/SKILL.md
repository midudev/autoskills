---
name: rails-background-jobs
license: MIT
description: >
  Use when adding or reviewing background jobs in Rails. Configures Active Job
  workers, implements idempotency checks, sets up retry/discard strategies,
  selects Solid Queue (Rails 8+) or Sidekiq based on scale, and defines recurring
  jobs via recurring.yml or sidekiq-cron. Trigger words: background job, Active Job,
  Solid Queue, Sidekiq, idempotency, retry, discard, recurring job, queue.
---

# Rails Background Jobs

Use this skill when the task is to add, configure, or review background jobs in a Rails application.

**Core principle:** Design jobs for idempotency and safe retries. Prefer Active Job's unified API; choose backend based on Rails version and scale.

## HARD-GATE

```
EVERY job MUST have its test written and validated BEFORE implementation.
  1. Write the job spec (idempotency, retry, error handling)
  2. Run the spec — verify it fails because the job does not exist yet
  3. ONLY THEN write the job class

EVERY job that performs a side effect (charge, email, API call) MUST have
an idempotency check BEFORE the side effect.

EVERY perform method should do only three things:
  1. Load the record from the passed ID
  2. Guard for idempotency / permanent no-op conditions
  3. Delegate the side effect or orchestration to a service object

If perform needs more than that, extract a service.

After implementation: run full suite, confirm job appears in queue dashboard,
verify idempotency by enqueueing twice and checking the second run is a no-op.
```

## Quick Reference

| Aspect | Rule |
|--------|------|
| Arguments | Pass IDs, not objects. Load in `perform`. |
| Idempotency | Check "already done?" before doing work |
| Retries | `retry_on` for transient, `discard_on` for permanent errors |
| Job size | Load, guard, delegate. No multi-step orchestration in `perform`. |
| Backend (Rails 8) | Solid Queue (database-backed, no Redis) |
| Backend (Rails 7) | Sidekiq + Redis for high throughput |
| Recurring | `config/recurring.yml` (Solid Queue) or cron/sidekiq-cron |

## Rails 8 vs Rails 7

| Aspect | Rails 7 and earlier | Rails 8 |
|--------|---------------------|---------|
| Default | No default; set `queue_adapter` (often Sidekiq) | **Solid Queue** (database-backed) |
| Dev/test | `:async` or `:inline` | Same |
| Recurring | External (cron, sidekiq-cron) | `config/recurring.yml` |
| Dashboard | Third-party (Sidekiq Web) | **Mission Control Jobs** |

See [BACKENDS.md](./BACKENDS.md) for install steps, configuration, and dashboard setup for both Solid Queue and Sidekiq.

## Examples

**Pass IDs, not objects:**

```ruby
# Bad — object may be stale or deleted by perform time
SomeJob.perform_later(@order)

# Good — reload fresh inside perform
SomeJob.perform_later(@order.id)
```

**Thin job with idempotency and retry:**

```ruby
class SendInvoiceReminderJob < ApplicationJob
  queue_as :default
  retry_on Net::OpenTimeout, wait: :polynomially_longer, attempts: 5
  discard_on ActiveRecord::RecordNotFound

  def perform(invoice_id)
    invoice = Invoice.find(invoice_id)
    return if invoice.reminder_sent_at?

    InvoiceReminders::Send.call(invoice:)
  end
end
```

**Service owns the side effect and state update:**

```ruby
module InvoiceReminders
  class Send
    def self.call(invoice:)
      InvoiceMailer.overdue(invoice).deliver_now
      invoice.update!(reminder_sent_at: Time.current)
    end
  end
end
```

**Recurring job (Solid Queue):**

```yaml
# config/recurring.yml
production:
  nightly_cleanup:
    class: "NightlyCleanupJob"
    schedule: "0 2 * * *"
  hourly_sync:
    class: "HourlySyncJob"
    schedule: "every 1 hour"
    queue: low
```

## Pitfalls

| Problem | Correct approach |
|---------|-----------------|
| Passing ActiveRecord objects as arguments | Pass IDs — objects may be deleted or stale by perform time |
| No idempotency check before side effects | Jobs run at-least-once; double-charging and double-emailing result |
| `retry_on` without `attempts` limit | Infinite retries on persistent errors |
| Missing `discard_on` for permanent errors | Job retries forever on `RecordNotFound` |
| Complex business logic in `perform` | Keep `perform` thin — delegate to service objects |
| Using `:inline` or `:async` in production | No persistence, no retry, no monitoring |
| Recurring job defined only in code | Use `recurring.yml` or equivalent for visibility and recoverability |

## Verification

Before calling the job done:

1. Enqueue or perform the job twice and confirm the second run is a no-op.
2. Confirm `retry_on` has an explicit `attempts:` limit and `discard_on` covers at least one permanent error.
3. Confirm recurring jobs live in `config/recurring.yml` (Rails 8) or the chosen scheduler config.
4. Confirm `perform` only loads, guards, and delegates.
5. If the task asks for an ops artifact, record backend, retry, and idempotency decisions in `process_log.md`.

## Integration

| Skill | When to chain |
|-------|---------------|
| **rails-migration-safety** | Solid Queue uses DB tables; add migrations safely |
| **rails-security-review** | Jobs receive serialized input; validate like any entry point |
| **rspec-best-practices** | TDD gate: write job spec before implementation; use `perform_enqueued_jobs` |
| **ruby-service-objects** | Keep `perform` thin; call service objects for business logic |

## Assets

- [assets/job_patterns.md](assets/job_patterns.md)
- [assets/retry_examples.md](assets/retry_examples.md)
