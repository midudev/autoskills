---
title: Use Scoping Concerns for Nested Resources
impact: HIGH
tags: [controllers, concerns, nested-resources, authorization]
---

# Use Scoping Concerns for Nested Resources

Extract parent resource lookup and authorization into reusable controller concerns like `BoardScoped`, `CardScoped`, etc. Controllers include these concerns to get consistent before_action setup.

## Why

- **DRY**: Parent lookup code isn't repeated across controllers
- **Consistent authorization**: All controllers access resources through the same scoped queries
- **Shared helpers**: Common operations (like rendering replacements) live in one place
- **Clear dependencies**: `include CardScoped` immediately tells you what a controller needs

## Bad: Repeated Setup in Controllers

```ruby
# app/controllers/cards/comments_controller.rb
class Cards::CommentsController < ApplicationController
  before_action :set_card

  def create
    @comment = @card.comments.create!(comment_params)
  end

  private
    def set_card
      @card = Current.user.accessible_cards.find(params[:card_id])
    end
end

# app/controllers/cards/closures_controller.rb
class Cards::ClosuresController < ApplicationController
  before_action :set_card  # Duplicated

  def create
    @card.close
  end

  private
    def set_card  # Duplicated
      @card = Current.user.accessible_cards.find(params[:card_id])
    end
end

# app/controllers/cards/watches_controller.rb
class Cards::WatchesController < ApplicationController
  before_action :set_card  # Duplicated again!
  # ...
end
```

## Good: Scoping Concern

```ruby
# app/controllers/concerns/card_scoped.rb
module CardScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_card, :set_board
  end

  private
    def set_card
      @card = Current.user.accessible_cards.find_by!(number: params[:card_id])
    end

    def set_board
      @board = @card.board
    end

    # Shared helpers for card controllers
    def render_card_replacement
      render turbo_stream: turbo_stream.replace(
        [@card, :card_container],
        partial: "cards/container",
        method: :morph,
        locals: { card: @card.reload }
      )
    end

    def capture_card_location
      @source_column = @card.column
      @was_in_stream = @card.awaiting_triage?
    end

    def refresh_stream_if_needed
      if @was_in_stream
        set_page_and_extract_portion_from(
          @board.cards.awaiting_triage.latest.preloaded
        )
      end
    end
end

# app/controllers/cards/comments_controller.rb
class Cards::CommentsController < ApplicationController
  include CardScoped

  def create
    @comment = @card.comments.create!(comment_params)
  end
end

# app/controllers/cards/closures_controller.rb
class Cards::ClosuresController < ApplicationController
  include CardScoped

  def create
    capture_card_location
    @card.close
    refresh_stream_if_needed
  end
end

# app/controllers/cards/watches_controller.rb
class Cards::WatchesController < ApplicationController
  include CardScoped

  def create
    @card.watch_by(Current.user)
  end
end
```

## Scoping Concern Examples

### BoardScoped

```ruby
# app/controllers/concerns/board_scoped.rb
module BoardScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_board
  end

  private
    def set_board
      @board = Current.user.boards.find(params[:board_id])
    end

    def ensure_permission_to_admin_board
      head :forbidden unless Current.user.can_administer_board?(@board)
    end
end
```

### RoomScoped (with Membership)

```ruby
# app/controllers/concerns/room_scoped.rb
module RoomScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_room
  end

  private
    def set_room
      @membership = Current.user.memberships.find_by!(room_id: params[:room_id])
      @room = @membership.room
    end
end
```

### FilterScoped (with Composition)

```ruby
# app/controllers/concerns/filter_scoped.rb
module FilterScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_filter
    before_action :set_user_filtering
  end

  private
    def set_filter
      if params[:filter_id].present?
        @filter = Current.user.filters.find(params[:filter_id])
      else
        @filter = Current.user.filters.from_params(filter_params)
      end
    end

    def set_user_filtering
      @user_filtering = User::Filtering.new(Current.user, @filter)
    end
end

# Concerns can compose other concerns
module DayTimelinesScoped
  extend ActiveSupport::Concern

  included do
    include FilterScoped  # Composition!
    before_action :set_day_timeline
  end

  private
    def set_day_timeline
      @day_timeline = Current.user.timeline_for(day, filter: @filter)
    end
end
```

## Always Scope Through Current User

Never find records without scoping to the current user:

```ruby
# Bad: Insecure - any user could access any card
def set_card
  @card = Card.find(params[:card_id])
end

# Good: Scoped to accessible records
def set_card
  @card = Current.user.accessible_cards.find_by!(number: params[:card_id])
end

# Good: Scoped through association
def set_board
  @board = Current.user.boards.find(params[:board_id])
end

# Good: Scoped through membership
def set_room
  @membership = Current.user.memberships.find_by!(room_id: params[:room_id])
  @room = @membership.room
end
```

## Overriding Before Actions

Child controllers can skip or extend the inherited before_action:

```ruby
class Cards::ClosuresController < ApplicationController
  include CardScoped

  before_action :capture_card_location, only: :create

  def create
    @card.close
    refresh_stream_if_needed
  end
end
```

## Rules

1. Create concerns for each parent resource (`BoardScoped`, `CardScoped`, `RoomScoped`)
2. Always scope resource lookups through `Current.user`
3. Include shared helpers for common operations (rendering, capturing state)
4. Concerns can compose other concerns (`include FilterScoped`)
5. Use `find_by!` with a custom param (like `number:`) if needed
6. Authorization checks belong in the concern (`ensure_permission_to_admin_board`)
