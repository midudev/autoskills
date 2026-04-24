---
title: Use Current Attributes for Request Context
impact: MEDIUM
tags: [models, current, request-context, multi-tenancy]
---

# Use Current Attributes for Request Context

Use `ActiveSupport::CurrentAttributes` to store request-scoped data like the current user, account, and request metadata. Design attribute setters to cascade related values.

## Why

- **Global access**: Any model or service can access `Current.user` without passing it around
- **Thread safety**: CurrentAttributes is thread-local and request-scoped
- **Clean interfaces**: Models don't need user/account parameters everywhere
- **Automatic cleanup**: Values are reset between requests

## Basic Setup

```ruby
# app/models/current.rb
class Current < ActiveSupport::CurrentAttributes
  attribute :session, :user, :account
  attribute :request_id, :user_agent, :ip_address

  def session=(value)
    super(value)
    self.user = session&.user
  end
end
```

## Pattern: Cascading Attribute Setters

When setting one attribute should automatically set related attributes:

```ruby
# app/models/current.rb (multi-tenant app)
class Current < ActiveSupport::CurrentAttributes
  attribute :session, :user, :identity, :account
  attribute :http_method, :request_id, :user_agent, :ip_address, :referrer

  # Setting session cascades to identity
  def session=(value)
    super(value)
    self.identity = session&.identity if value.present?
  end

  # Setting identity cascades to user (scoped to account)
  def identity=(identity)
    super(identity)
    self.user = identity&.users&.find_by(account: account) if identity.present?
  end

  # Helper for running code in a specific account context
  def with_account(value, &)
    with(account: value, &)
  end

  def without_account(&)
    with(account: nil, &)
  end
end
```

### Single-Tenant Version

```ruby
# app/models/current.rb (single-tenant app)
class Current < ActiveSupport::CurrentAttributes
  attribute :session, :user, :request

  delegate :host, :protocol, to: :request, prefix: true, allow_nil: true

  def session=(value)
    super(value)
    self.user = session&.user if value.present?
  end

  def account
    Account.first  # Single tenant always uses first account
  end
end
```

## Setting Current from Controllers

Use a concern to set Current values from the request:

```ruby
# app/controllers/concerns/set_current_request.rb
module SetCurrentRequest
  extend ActiveSupport::Concern

  included do
    before_action :set_current_request
  end

  private
    def set_current_request
      Current.request = request
      Current.request_id = request.uuid
      Current.user_agent = request.user_agent
      Current.ip_address = request.ip
    end
end

# app/controllers/concerns/authentication.rb
module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :resume_session
  end

  private
    def resume_session
      Current.session = find_session_by_cookie
    end

    def find_session_by_cookie
      Session.find_by(token: cookies.signed[:session_token])
    end
end
```

## Using Current in Models

### Default Values

```ruby
class Comment < ApplicationRecord
  belongs_to :creator, class_name: "User", default: -> { Current.user }
end

class Event < ApplicationRecord
  belongs_to :creator, class_name: "User", default: -> { Current.user }

  before_create do
    self.request_id ||= Current.request_id
    self.ip_address ||= Current.ip_address
  end
end
```

### Authorization Checks

```ruby
class Card < ApplicationRecord
  def editable_by?(user = Current.user)
    creator == user || user.admin?
  end
end
```

### Scoped Queries

```ruby
class Board < ApplicationRecord
  scope :accessible, -> {
    where(id: Current.user.accessible_board_ids)
  }
end
```

## Current in Tests

Set up Current in test helpers:

```ruby
# test/test_helper.rb
class ActiveSupport::TestCase
  setup do
    Current.account = accounts(:primary)
  end

  teardown do
    Current.reset_all
  end
end

# For specific test contexts
def with_current_user(user)
  original = Current.user
  Current.user = user
  yield
ensure
  Current.user = original
end
```

## Important Limitation

`Current` is only auto-populated in web requests via controller concerns. Other contexts (jobs, mailers called from jobs, ActionCable channels) need explicit setup. See `current-in-other-contexts.md` for how to handle those cases.

## Rules

1. Define `Current` as a subclass of `ActiveSupport::CurrentAttributes`
2. Use cascading setters to automatically set related attributes
3. Set Current values in controller concerns, not individual actions
4. Use `Current.user` for default values in models
5. Always reset Current in tests (teardown)
6. Access Current through the class, never store references to attributes
