# Background Jobs Patterns

Guidance for creating robust background jobs in Rails (Active Job + Sidekiq-friendly patterns).

1. Use ActiveJob with an adapter (Sidekiq recommended for scale)

2. Idempotency
- Ensure each job is idempotent. Use a unique job key or a database guard if needed.

3. Retry/Discard strategy
- Use `retry_on StandardError, attempts: 5, wait: :exponentially_longer` for transient errors
- Use `discard_on ActiveRecord::RecordNotFound` for permanent errors

4. Partial work and continuation
- Break large work into smaller jobs (fan-out/fan-in pattern)

5. Logging and observability
- Log job start/end and key metadata (job_id, args summary)
- Capture failures to Sentry or similar with context

6. Resource limits
- Avoid large in-memory arrays; stream or use batch processing

7. Testing
- Use inline adapter in tests and assert perform_enqueued_jobs or perform_enqueued_jobs with block

Example job skeleton:

class SyncUserJob < ApplicationJob
  queue_as :default
  retry_on Net::OpenTimeout, attempts: 3, wait: :exponentially_longer
  discard_on ActiveRecord::RecordNotFound

  def perform(user_id)
    user = User.find(user_id)
    ExternalService.sync(user)
  rescue StandardError => e
    Rails.logger.error("SyncUserJob failed: #{e.message}")
    raise
  end
end
