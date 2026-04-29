---
title: Nest Service Objects Under Model Namespaces
impact: LOW
tags: [models, services, organization]
---

# Nest Service Objects Under Model Namespaces

When you need service objects, value objects, or plain Ruby classes, place them under the model namespace they operate on rather than in a separate `app/services` directory.

## Why

- **Co-location**: Related code lives together
- **Discoverability**: Find all card-related code in `app/models/card/`
- **No separate layer**: Avoids proliferating directory structures
- **Natural namespacing**: `Card::ActivitySpike::Detector` clearly belongs to Card

## Directory Structure

```
app/models/
├── card.rb
├── card/
│   ├── closeable.rb          # Concern
│   ├── searchable.rb         # Concern
│   ├── activity_spike/
│   │   └── detector.rb       # Service object
│   └── eventable/
│       └── system_commenter.rb  # Service object
├── user.rb
├── user/
│   ├── day_timeline.rb       # Value object
│   └── day_timeline/
│       ├── column.rb         # Nested value object
│       └── serializable.rb   # Concern for value object
├── room.rb
└── room/
    └── message_pusher.rb     # Service object
```

## Bad: Separate Services Directory

```
app/
├── models/
│   └── card.rb
├── services/
│   ├── card_activity_spike_detector.rb
│   ├── card_system_commenter.rb
│   ├── room_message_pusher.rb
│   └── user_day_timeline_builder.rb
```

Problems:

- Services directory becomes a dumping ground
- Awkward naming to avoid collisions
- Related code is scattered

## Good: Nested Under Models

### Service Object Example

```ruby
# app/models/card/activity_spike/detector.rb
class Card::ActivitySpike::Detector
  attr_reader :card

  def initialize(card)
    @card = card
  end

  def detect
    if has_activity_spike?
      register_activity_spike
      true
    else
      false
    end
  end

  private
    def has_activity_spike?
      card.entropic? &&
        (multiple_people_commented? || card_was_just_assigned? || card_was_just_reopened?)
    end

    def multiple_people_commented?
      recent_comments.distinct.count(:creator_id) >= 3
    end

    def recent_comments
      card.comments.where("created_at > ?", 24.hours.ago)
    end

    def register_activity_spike
      card.create_activity_spike!
    end
end
```

Usage:

```ruby
# app/models/card/stallable.rb
module Card::Stallable
  def detect_activity_spikes
    Card::ActivitySpike::Detector.new(self).detect
  end

  private
    def detect_activity_spikes_later
      Card::ActivitySpike::DetectionJob.perform_later(self)
    end
end
```

### Value Object Example

```ruby
# app/models/user/day_timeline.rb
class User::DayTimeline
  include Serializable

  attr_reader :user, :day, :filter

  delegate :today?, to: :day

  def initialize(user, day, filter)
    @user, @day, @filter = user, day, filter
  end

  def events
    @events ||= user.events_for(day).filtered_by(filter)
  end

  def has_activity?
    events.any?
  end

  def columns
    @columns ||= group_events_into_columns
  end

  private
    def group_events_into_columns
      events.group_by(&:hour).map do |hour, hour_events|
        User::DayTimeline::Column.new(hour, hour_events)
      end
    end
end

# app/models/user/day_timeline/column.rb
class User::DayTimeline::Column
  attr_reader :hour, :events

  def initialize(hour, events)
    @hour, @events = hour, events
  end

  def time_label
    hour.strftime("%l %p")
  end
end
```

Usage:

```ruby
# app/models/user.rb
class User < ApplicationRecord
  def timeline_for(day, filter:)
    User::DayTimeline.new(self, day, filter)
  end
end
```

### System Commenter Example

```ruby
# app/models/card/eventable/system_commenter.rb
class Card::Eventable::SystemCommenter
  include ERB::Util

  attr_reader :card, :event

  def initialize(card, event)
    @card, @event = card, event
  end

  def comment
    return unless comment_body.present?

    card.comments.create!(
      creator: card.account.system_user,
      body: comment_body,
      created_at: event.created_at
    )
  end

  private
    def comment_body
      case event.action
      when "closed" then "Closed by #{event.creator.name}"
      when "reopened" then "Reopened by #{event.creator.name}"
      when "assigned" then "Assigned to #{assignee_names}"
      end
    end

    def assignee_names
      event.particulars["assignee_names"].to_sentence
    end
end
```

### Message Pusher Example

```ruby
# app/models/room/message_pusher.rb
class Room::MessagePusher
  attr_reader :room, :message

  def initialize(room:, message:)
    @room, @message = room, message
  end

  def push
    payload = build_payload
    push_to_subscribers(payload)
  end

  private
    def build_payload
      {
        title: room.name,
        body: message.preview,
        data: { room_id: room.id, message_id: message.id }
      }
    end

    def push_to_subscribers(payload)
      room.push_subscriptions.find_each do |subscription|
        subscription.deliver(payload)
      end
    end
end
```

## When to Create Service Objects

Create service objects when:

1. **Complex operation** - Too much logic for a single model method
2. **Multiple collaborators** - Coordinates between multiple models
3. **Reusable logic** - Same operation used in multiple places
4. **Testable unit** - Logic benefits from isolated testing

Don't create service objects for:

1. **Simple CRUD** - Use model methods
2. **Single model operations** - Put in model or concern
3. **Every controller action** - This isn't Java

## Rules

1. Place service objects under the model namespace they operate on
2. Use descriptive class names (`Detector`, `Commenter`, `Pusher`)
3. Keep the interface simple - usually `initialize` + one public method
4. Value objects are also nested under the model namespace
5. No separate `app/services` directory
6. If it doesn't clearly belong to one model, it might belong in the model it creates/modifies
