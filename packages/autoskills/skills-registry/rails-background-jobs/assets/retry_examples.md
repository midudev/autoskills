# Retry and discard examples

1) Idempotent retry example

class FetchDataJob < ApplicationJob
  retry_on Net::ReadTimeout, attempts: 4, wait: :exponentially_longer
  discard_on ActiveRecord::RecordNotFound

  def perform(resource_id)
    resource = Resource.find(resource_id)
    ApiClient.fetch(resource.api_endpoint)
  end
end

2) Long-running breakdown pattern

Split large export into smaller jobs that write to a shared storage object and then enqueue a finalizer job.

3) Backoff strategy

Use Sidekiq's built-in exponential backoff for background workers; for ActiveJob, prefer `wait: :exponentially_longer`.
