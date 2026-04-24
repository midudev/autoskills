---
title: Turbo Stream Broadcast Patterns
impact: MEDIUM
tags: [turbo, hotwire, real-time, broadcasts]
---

# Turbo Stream Broadcast Patterns

Encapsulate broadcast logic in model concerns and call broadcasts explicitly from controllers. Use composite stream names for targeting specific audiences.

## Why

- **Explicit control**: Broadcasts happen when you intend, not automatically
- **Testability**: Broadcasts can be tested in isolation
- **Flexibility**: Different contexts may need different broadcast behavior
- **Performance**: No unexpected broadcasts on every save

## Pattern 1: Broadcast Concerns in Models

Encapsulate broadcast logic in a model concern:

```ruby
# app/models/message/broadcasts.rb
module Message::Broadcasts
  def broadcast_create
    broadcast_append_to room, :messages,
      target: [room, :messages]
    ActionCable.server.broadcast("unread_rooms", { roomId: room.id })
  end

  def broadcast_update
    broadcast_replace_to room, :messages,
      target: [self, :presentation],
      partial: "messages/presentation",
      attributes: { maintain_scroll: true }
  end

  def broadcast_remove
    broadcast_remove_to room, :messages
  end
end

# app/models/message.rb
class Message < ApplicationRecord
  include Broadcasts
end
```

## Pattern 2: Call Broadcasts from Controllers

Explicitly call broadcasts in controller actions:

```ruby
# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  def create
    @message = @room.messages.create!(message_params)
    @message.broadcast_create
  end

  def update
    @message.update!(message_params)
    @message.broadcast_update
  end

  def destroy
    @message.destroy
    @message.broadcast_remove
  end
end
```

## Pattern 3: Composite Stream Names

Use arrays for stream names to create hierarchical channels:

```erb
<%# Subscribe to room-specific messages %>
<%= turbo_stream_from @room, :messages %>

<%# Subscribe to global room list %>
<%= turbo_stream_from :rooms %>

<%# Subscribe to user-specific room updates %>
<%= turbo_stream_from Current.user, :rooms %>

<%# Subscribe to card activity %>
<%= turbo_stream_from @card, :activity %>
```

This generates stream names like:

- `"Z2lkOi8vYXBwL1Jvb20vMQ:messages"` (room + messages)
- `"rooms"` (global)
- `"Z2lkOi8vYXBwL1VzZXIvMQ:rooms"` (user + rooms)

## Pattern 4: Targeted Broadcasts by Audience

Different users may need different broadcasts:

```ruby
# app/controllers/rooms/opens_controller.rb
class Rooms::OpensController < RoomsController
  def create
    room = Rooms::Open.create!(room_params)
    broadcast_create_room(room)
  end

  private
    # Open rooms: broadcast to everyone
    def broadcast_create_room(room)
      broadcast_prepend_to :rooms,
        target: :shared_rooms,
        partial: "sidebars/room",
        locals: { room: room }
    end
end

# app/controllers/rooms/closeds_controller.rb
class Rooms::ClosedsController < RoomsController
  private
    # Closed rooms: broadcast only to members
    def broadcast_create_room(room)
      html = render_to_string(partial: "sidebars/room", locals: { room: room })
      room.users.each do |user|
        broadcast_prepend_to user, :rooms,
          target: :shared_rooms,
          html: html  # Render once, broadcast to many
      end
    end
end
```

## Pattern 5: Controller Broadcast Helpers

Include Turbo broadcast modules in ApplicationController:

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include Turbo::Streams::Broadcasts
  include Turbo::Streams::StreamName
end
```

Then broadcast directly from controller actions:

```ruby
class RoomsController < ApplicationController
  def destroy
    @room.destroy
    broadcast_remove_to :rooms, target: [@room, :list]
  end
end
```

## Pattern 6: Broadcast with morph

Use `method: :morph` for smart DOM updates:

```ruby
def broadcast_card_update
  broadcast_replace_to @board,
    target: [@card, :card_container],
    partial: "cards/container",
    method: :morph,
    locals: { card: self }
end
```

## Pattern 7: Custom Attributes

Pass custom attributes for client-side handling:

```ruby
def broadcast_update
  broadcast_replace_to room, :messages,
    target: [self, :presentation],
    partial: "messages/presentation",
    attributes: { maintain_scroll: true }  # Custom attribute
end
```

Handle in JavaScript:

```javascript
// app/javascript/controllers/maintain_scroll_controller.js
beforeStreamRender(event) {
  if (event.detail.newStream.hasAttribute("maintain_scroll")) {
    // Preserve scroll position
  }
}
```

## Pattern 8: Conditional Broadcasting

Broadcast based on context:

```ruby
module Card::Broadcastable
  def broadcast_changes
    return unless published?

    broadcast_replace_to board,
      target: [self, :card_container],
      partial: "cards/container",
      method: :morph
  end
end
```

## Turbo Stream Template Organization

```
app/views/
├── cards/
│   ├── closures/
│   │   ├── create.turbo_stream.erb
│   │   └── destroy.turbo_stream.erb
│   ├── comments/
│   │   ├── create.turbo_stream.erb
│   │   └── update.turbo_stream.erb
│   └── update.turbo_stream.erb
```

Example template:

```erb
<%# app/views/cards/closures/create.turbo_stream.erb %>
<%= turbo_stream.replace(
  [@card, :card_container],
  partial: "cards/container",
  method: :morph,
  locals: { card: @card.reload }
) %>

<% if @source_column %>
  <%= turbo_stream.replace(
    dom_id(@source_column),
    partial: "columns/column",
    method: :morph,
    locals: { column: @source_column }
  ) %>
<% end %>
```

## When NOT to Use Callbacks for Broadcasts

```ruby
# Bad: Broadcasts on every save, even in background jobs
after_save_commit :broadcast_changes

# Good: Explicit broadcast when needed
# Called from controller:
@card.update!(card_params)
@card.broadcast_changes
```

## Rules

1. Encapsulate broadcast logic in model concerns
2. Call broadcasts explicitly from controllers
3. Use composite stream names (`[room, :messages]`) for scoping
4. Render once, broadcast to many for multi-user broadcasts
5. Use `method: :morph` for smart DOM updates
6. Don't use callbacks for broadcasts (be explicit)
7. Custom attributes can signal client-side behavior
