---
title: Populating Current in Jobs, Mailers, and Channels
impact: MEDIUM
tags: [models, current, jobs, mailers, channels]
---

# Populating Current in Jobs, Mailers, and Channels

`Current` is only auto-populated in web requests. Jobs, mailers called from jobs, and ActionCable channels run in separate contexts where `Current` starts empty. Each context needs explicit setup.

## The Problem

When you use `Current.account` in a model:

```ruby
class Card < ApplicationRecord
  belongs_to :account, default: -> { Current.account }
end
```

This works in web requests because controllers set `Current.session`, which cascades to set other values. But in a background job, `Current.account` is `nil` because:

1. Jobs run in a separate process/thread
2. There's no HTTP request to extract context from
3. `Current` is reset between requests/jobs

## Background Jobs

To have `Current.account` available in jobs, extend ActiveJob to capture it at enqueue time and restore it at perform time:

```ruby
# config/initializers/active_job.rb
module CurrentAttributesJobExtensions
  extend ActiveSupport::Concern

  prepended do
    attr_reader :account
    # Wait for transaction to commit before enqueueing
    self.enqueue_after_transaction_commit = true
  end

  # Capture Current.account when job is created (during web request)
  def initialize(...)
    super
    @account = Current.account
  end

  # Store account in job payload
  def serialize
    super.merge("account" => @account&.to_gid)
  end

  # Restore account when job is deserialized by worker
  def deserialize(job_data)
    super
    if gid = job_data["account"]
      @account = GlobalID::Locator.locate(gid)
    end
  end

  # Wrap job execution in Current context
  def perform_now
    if account.present?
      Current.with_account(account) { super }
    else
      super
    end
  end
end

ActiveSupport.on_load(:active_job) do
  prepend CurrentAttributesJobExtensions
end
```

### How It Works

```
Web Request                              Background Worker
-----------                              -----------------
User clicks button
    ↓
Controller enqueues job
    ↓
Job.new captures Current.account ───────→ Job serialized to queue
                                              ↓
                                         Worker picks up job
                                              ↓
                                         deserialize restores @account
                                              ↓
                                         perform_now sets Current.account
                                              ↓
                                         Job runs with Current.account set
```

### Why NOT Serialize Current.user?

You typically don't serialize `Current.user` because:

- Jobs often run much later when user context is stale
- The user who triggered the action may not be the right context for the job
- If a job needs a user, pass it explicitly as an argument

```ruby
# Good: Pass user explicitly when needed
class NotifyUserJob < ApplicationJob
  def perform(user, message)
    user.notify(message)
  end
end

# In controller
NotifyUserJob.perform_later(Current.user, "Hello")
```

## Mailers Called from Jobs

When a job calls a mailer, the mailer also has no `Current` context. Set it in the model's delivery method:

```ruby
# app/models/notification/bundle.rb
class Notification::Bundle < ApplicationRecord
  def deliver
    user.in_time_zone do
      Current.with_account(user.account) do  # Set Current before mailer
        processing!
        Notification::BundleMailer.notification(self).deliver if deliverable?
        delivered!
      end
    end
  end
end
```

The mailer can then use `Current.account`:

```ruby
# app/mailers/application_mailer.rb
class ApplicationMailer < ActionMailer::Base
  private
    def default_url_options
      if Current.account
        super.merge(script_name: Current.account.slug)  # Multi-tenant URLs
      else
        super
      end
    end
end

# app/mailers/notification/bundle_mailer.rb
class Notification::BundleMailer < ApplicationMailer
  def notification(bundle)
    @bundle = bundle
    @user = bundle.user

    mail \
      to: @user.identity.email_address,
      subject: "Fizzy#{" (#{Current.account.name})" if @user.identity.accounts.many?}: New notifications"
  end
end
```

The key is that `deliver` wraps the mailer call in `Current.with_account`, so by the time the mailer runs, `Current.account` is set.

## ActionCable Channels

Each WebSocket connection must set up its own `Current` context in the `connect` method:

```ruby
# app/channels/application_cable/connection.rb
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      set_current_user || reject_unauthorized_connection
    end

    private
      def set_current_user
        if session = find_session_by_cookie
          # Extract account from request (e.g., from URL or subdomain)
          account = Account.find_by(external_account_id: request.env["fizzy.external_account_id"])
          Current.account = account
          self.current_user = session.identity.users.find_by!(account: account) if account
        end
      end

      def find_session_by_cookie
        Session.find_signed(cookies.signed[:session_token])
      end
  end
end
```

`Current` set in `connect` persists for that connection. All channel subscriptions on the same connection share the same `Current` values.

## Console and Scripts

In Rails console or scripts, set Current manually:

```ruby
# In console
Current.account = Account.first
Current.user = User.find_by(email: "admin@example.com")

# In a script
Account.find_each do |account|
  Current.with_account(account) do
    # Do work in this account's context
  end
end
```

## Context Summary

| Context         | Current Populated? | How to Set Up                              |
| --------------- | ------------------ | ------------------------------------------ |
| Web Request     | Yes                | Controller concerns with cascading setters |
| Background Job  | No                 | Extend ActiveJob to serialize/restore      |
| Mailer from Job | No                 | Wrap mailer call in `Current.with_account` |
| ActionCable     | No                 | Set in `Connection#connect`                |
| Console         | No                 | Set manually                               |
| Tests           | No                 | Set in `setup`, reset in `teardown`        |

## Rules

1. Jobs: Extend ActiveJob to serialize `Current.account` at enqueue and restore at perform
2. Mailers from jobs: Wrap mailer calls in `Current.with_account { ... }`
3. Channels: Set Current in `Connection#connect`
4. Don't serialize `Current.user` in jobs - pass users explicitly as arguments
5. Use `Current.with_account` for temporary context changes
6. Remember: if `Current.account` is `nil` unexpectedly, you're probably in a non-request context
