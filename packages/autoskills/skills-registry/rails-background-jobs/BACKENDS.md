# Rails Background Jobs — Backend Setup

## Solid Queue (Rails 8+)

Solid Queue is database-backed — no Redis required. It ships with Rails 8 as the default.

**Install:**

```bash
rails solid_queue:install
rails db:migrate
```

**Configuration (`config/application.rb` or environment files):**

```ruby
config.active_job.queue_adapter = :solid_queue
```

**Dashboard — Mission Control Jobs:**

```ruby
# Gemfile
gem "mission_control-jobs"

# config/routes.rb
mount MissionControl::Jobs::Engine, at: "/jobs"
```

**Concurrency (config/solid_queue.yml):**

```yaml
production:
  workers:
    - queues: [default, mailers]
      threads: 5
    - queues: [low]
      threads: 2
```

---

## Sidekiq (Rails 7 and earlier, or high-throughput Rails 8)

Sidekiq requires Redis. Preferred for high-throughput workloads.

**Install:**

```ruby
# Gemfile
gem "sidekiq"
```

```ruby
# config/application.rb
config.active_job.queue_adapter = :sidekiq
```

**Recurring jobs (`config/sidekiq.yml`):**

```yaml
:schedule:
  nightly_cleanup:
    cron: "0 2 * * *"
    class: NightlyCleanupJob
  hourly_sync:
    cron: "0 * * * *"
    class: HourlySyncJob
    queue: low
```

**Dashboard:**

```ruby
# config/routes.rb
require "sidekiq/web"
mount Sidekiq::Web, at: "/sidekiq"
```

---

## Choosing a Backend

| Concern | Use Solid Queue | Use Sidekiq |
|---------|----------------|-------------|
| Rails 8+ new app | ✓ default | Only if scale demands Redis |
| No Redis in infra | ✓ | ✗ |
| Very high throughput (>10k jobs/min) | May need tuning | ✓ |
| Existing Sidekiq setup | Not worth migrating | ✓ keep |
