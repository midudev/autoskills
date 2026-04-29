---
title: Keep Controllers Thin with Rich Domain Models
impact: HIGH
tags: [controllers, models, architecture, vanilla-rails]
---

# Keep Controllers Thin with Rich Domain Models

Controllers should be thin orchestrators that call rich model APIs directly. Avoid service objects, interactors, or other intermediaries between controllers and models.

## Why

- **Simplicity**: Fewer layers means less code to maintain
- **Discoverability**: Domain logic lives where you expect it (in models)
- **Rails-native**: Works with Rails conventions and tooling
- **Testability**: Models can be unit tested, controllers integration tested

## Bad: Fat Controllers

```ruby
class Cards::ClosuresController < ApplicationController
  def create
    @card = Current.user.accessible_cards.find(params[:card_id])

    # Business logic in controller
    return head :forbidden unless @card.closeable?

    @card.transaction do
      @card.update!(status: :closed, closed_at: Time.current)
      @card.closure.create!(user: Current.user)
      @card.events.create!(action: :closed, creator: Current.user)
    end

    # Notification logic in controller
    @card.watchers.each do |watcher|
      NotificationMailer.card_closed(@card, watcher).deliver_later
    end

    respond_to do |format|
      format.turbo_stream
      format.json { head :no_content }
    end
  end
end
```

## Bad: Service Objects

```ruby
# app/services/close_card_service.rb
class CloseCardService
  def initialize(card, user)
    @card = card
    @user = user
  end

  def call
    return false unless @card.closeable?

    @card.transaction do
      @card.update!(status: :closed)
      @card.closure.create!(user: @user)
      @card.events.create!(action: :closed, creator: @user)
    end

    notify_watchers
    true
  end
end

# Controller
class Cards::ClosuresController < ApplicationController
  def create
    service = CloseCardService.new(@card, Current.user)
    if service.call
      respond_to { |format| format.turbo_stream }
    else
      head :unprocessable_entity
    end
  end
end
```

Problems with services:

- Extra layer of indirection
- Logic is harder to discover
- Often becomes a dumping ground
- Duplicates what models should do

## Good: Thin Controller, Rich Model

```ruby
# app/controllers/cards/closures_controller.rb
class Cards::ClosuresController < ApplicationController
  include CardScoped

  def create
    @card.close  # All logic in model method

    respond_to do |format|
      format.turbo_stream
      format.json { head :no_content }
    end
  end

  def destroy
    @card.reopen

    respond_to do |format|
      format.turbo_stream
      format.json { head :no_content }
    end
  end
end

# app/models/card/closeable.rb
module Card::Closeable
  extend ActiveSupport::Concern

  included do
    has_one :closure, dependent: :destroy
  end

  def close
    transaction do
      create_closure!(user: Current.user)
      events.create!(action: :closed, creator: Current.user)
    end
    notify_watchers_later
  end

  def reopen
    transaction do
      closure.destroy!
      events.create!(action: :reopened, creator: Current.user)
    end
  end

  def closed?
    closure.present?
  end
end
```

## Controller Action Patterns

### Simple CRUD Operations

Direct ActiveRecord operations are fine:

```ruby
class Cards::CommentsController < ApplicationController
  include CardScoped

  def create
    @comment = @card.comments.create!(comment_params)
  end

  def update
    @comment = @card.comments.find(params[:id])
    @comment.update!(comment_params)
  end
end
```

### State Changes

Call intention-revealing model methods:

```ruby
class Cards::GoldnessesController < ApplicationController
  include CardScoped

  def create
    @card.gild
  end

  def destroy
    @card.ungild
  end
end
```

### Toggles

Models provide toggle methods:

```ruby
class Cards::AssignmentsController < ApplicationController
  include CardScoped

  def update
    @card.toggle_assignment(Current.user)
  end
end

# In model
def toggle_assignment(user)
  if assigned_to?(user)
    unassign(user)
  else
    assign(user)
  end
end
```

### Complex Operations

Models expose rich APIs that hide complexity:

```ruby
class BoardsController < ApplicationController
  def create
    @board = Current.user.draft_new_board(board_params)
    # Model handles: creating board, granting access, setting defaults

    redirect_to @board
  end
end
```

## When Service Objects Are Acceptable

Service objects or form objects may be justified when:

1. **Multiple models are created** without a clear owner
2. **External APIs** are called with complex orchestration
3. **Form handling** spans multiple models

But even then, keep them simple and don't treat them as a pattern to follow everywhere:

```ruby
# Acceptable: FirstRun handles initial account + user setup
class FirstRunsController < ApplicationController
  def create
    user = FirstRun.create!(user_params)
    start_new_session_for(user)
    redirect_to root_url
  end
end
```

## Rules

1. Controllers call model methods directly
2. All business logic belongs in models (or model concerns)
3. Service objects are the exception, not the rule
4. Controller actions should be 1-5 lines typically
5. Use scoping concerns to DRY up resource lookup
6. Respond with appropriate format (turbo_stream, json, html)
