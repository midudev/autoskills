---
title: Model Everything as Resource Controllers
impact: HIGH
tags: [controllers, REST, architecture]
---

# Model Everything as Resource Controllers

When an action doesn't map cleanly to standard CRUD verbs, introduce a new resource rather than adding custom actions. Every controller action should be one of: index, show, new, create, edit, update, destroy.

## Why

- **Predictability**: Developers always know where to find code for any feature
- **Simpler controllers**: Each controller has fewer actions, each doing one thing
- **Better routing**: RESTful routes are self-documenting
- **Easier testing**: Standard CRUD actions have predictable test patterns

## Bad: Custom Actions

```ruby
# config/routes.rb
resources :cards do
  post :close
  post :reopen
  post :archive
  post :pin
  post :unpin
  patch :assign
  patch :move_to_column
end

# app/controllers/cards_controller.rb
class CardsController < ApplicationController
  def show; end
  def create; end
  def update; end
  def destroy; end
  def close; end      # Custom
  def reopen; end     # Custom
  def archive; end    # Custom
  def pin; end        # Custom
  def unpin; end      # Custom
  def assign; end     # Custom
  def move_to_column; end  # Custom
end
```

Problems:

- Controller has many actions
- Non-standard verbs (what HTTP method for `close`?)
- Inconsistent patterns
- Hard to extend without adding more custom actions

## Good: Resource Controllers for State Changes

```ruby
# config/routes.rb
resources :cards do
  resource :closure, only: [:create, :destroy]
  resource :archive, only: [:create, :destroy]
  resource :pin, only: [:create, :destroy]
  resource :assignment, only: [:create, :update, :destroy]

  scope module: :cards do
    resources :comments
    resources :taggings, only: [:create, :destroy]
  end
end

resources :columns do
  resources :cards do
    resource :drop, only: :create, module: :cards
  end
end
```

### Closure Controller (Toggle On/Off)

```ruby
# app/controllers/cards/closures_controller.rb
class Cards::ClosuresController < ApplicationController
  include CardScoped

  def create
    @card.close
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
```

### Pin Controller (User-Specific Toggle)

```ruby
# app/controllers/cards/pins_controller.rb
class Cards::PinsController < ApplicationController
  include CardScoped

  def create
    @pin = @card.pin_by(Current.user)
    broadcast_add_pin_to_tray
  end

  def destroy
    @pin = @card.unpin_by(Current.user)
    broadcast_remove_pin_from_tray
  end
end
```

### Watch Controller

```ruby
# app/controllers/cards/watches_controller.rb
class Cards::WatchesController < ApplicationController
  include CardScoped

  def create
    @card.watch_by(Current.user)
  end

  def destroy
    @card.unwatch_by(Current.user)
  end
end
```

## Common Resource Patterns

### Binary State Changes

For toggling states like open/closed, published/draft:

```ruby
resource :closure      # create = close, destroy = reopen
resource :publication  # create = publish, destroy = unpublish
resource :archive      # create = archive, destroy = unarchive
```

### User-Specific Resources

For things a user can add/remove:

```ruby
resource :pin          # create = pin, destroy = unpin
resource :watch        # create = watch, destroy = unwatch
resource :bookmark     # create = bookmark, destroy = unbookmark
```

### Nested Actions on Collections

```ruby
# Moving cards between columns
resources :columns do
  resources :cards do
    scope module: :cards do
      scope module: :drops do
        resource :column, only: :create    # Drop into column
        resource :closure, only: :create   # Drop into closed
        resource :stream, only: :create    # Drop into triage
      end
    end
  end
end
```

### Position Changes

```ruby
resources :columns do
  resource :left_position, only: :create   # Move left
  resource :right_position, only: :create  # Move right
end
```

## Controller Size Guide

Each controller should have at most 7 actions (the CRUD set). If you're adding more:

1. **Extract a new resource** - Most custom actions are just CRUD on a hidden resource
2. **Ask: What is being created/updated/destroyed?** - That's your new resource

| Custom Action       | New Resource                              |
| ------------------- | ----------------------------------------- |
| `cards#close`       | `Cards::ClosuresController#create`        |
| `cards#add_tag`     | `Cards::TaggingsController#create`        |
| `cards#assign`      | `Cards::AssignmentsController#create`     |
| `columns#move_left` | `Columns::LeftPositionsController#create` |
| `boards#publish`    | `Boards::PublicationsController#create`   |

## Rules

1. Controllers only have standard CRUD actions
2. State changes become singular resources (`resource :closure`)
3. User-specific toggles are resources scoped to the parent
4. Movement/position changes are their own resources
5. Nest controllers under the parent resource (`Cards::ClosuresController`)
6. Use `module` in routes to organize without deep URL nesting
