---
title: Use Template Method Pattern in Shared Concerns
impact: HIGH
tags: [models, concerns, patterns, inheritance]
---

# Use Template Method Pattern in Shared Concerns

When multiple models need similar but not identical behavior, create a shared concern with template methods (hooks) that model-specific concerns override.

## Why

- **DRY without rigidity**: Share structure while allowing customization
- **Explicit contracts**: Template methods document what subclasses must implement
- **Layered behavior**: Model-specific concerns can add functionality on top of shared behavior
- **Testing clarity**: Each layer can be tested independently

## Pattern Structure

```
app/models/
├── concerns/
│   └── searchable.rb         # Shared template with hooks
├── card/
│   └── searchable.rb         # Card-specific implementation
└── comment/
    └── searchable.rb         # Comment-specific implementation
```

## Bad: Duplicated Logic

```ruby
# app/models/card/searchable.rb
module Card::Searchable
  extend ActiveSupport::Concern

  included do
    after_save_commit :update_search_index
    after_destroy_commit :remove_from_search_index
  end

  def update_search_index
    Search::Entry.upsert(...)  # Duplicated
  end
end

# app/models/comment/searchable.rb
module Comment::Searchable
  extend ActiveSupport::Concern

  included do
    after_save_commit :update_search_index      # Duplicated
    after_destroy_commit :remove_from_search_index  # Duplicated
  end

  def update_search_index
    Search::Entry.upsert(...)  # Same logic, different data
  end
end
```

## Good: Template Method Pattern

### Step 1: Shared Concern with Template Methods

```ruby
# app/models/concerns/searchable.rb
module Searchable
  extend ActiveSupport::Concern

  included do
    after_save_commit :update_search_index, if: :searchable?
    after_destroy_commit :remove_from_search_index
  end

  # Shared implementation
  def update_search_index
    Search::Entry.upsert(
      id: search_entry_id,
      title: search_title,
      content: search_content,
      searchable_type: self.class.name,
      searchable_id: id
    )
  end

  def remove_from_search_index
    Search::Entry.where(searchable: self).delete_all
  end

  # Template methods - must be overridden
  def search_title
    raise NotImplementedError, "#{self.class} must implement #search_title"
  end

  def search_content
    raise NotImplementedError, "#{self.class} must implement #search_content"
  end

  # Template methods with sensible defaults
  def searchable?
    true
  end

  def search_entry_id
    "#{self.class.name.underscore}_#{id}"
  end
end
```

### Step 2: Model-Specific Concerns Override Hooks

```ruby
# app/models/card/searchable.rb
module Card::Searchable
  extend ActiveSupport::Concern

  included do
    include ::Searchable  # Include the shared template

    scope :mentioning, ->(query, user:) do
      # Card-specific search scope
      joins(:search_entry).where("search_entries.content LIKE ?", "%#{query}%")
    end
  end

  # Implement required template methods
  def search_title
    title
  end

  def search_content
    description.to_plain_text
  end

  # Override default template method
  def searchable?
    published?  # Cards are only searchable when published
  end
end

# app/models/comment/searchable.rb
module Comment::Searchable
  extend ActiveSupport::Concern

  included do
    include ::Searchable
  end

  def search_title
    "Comment on #{card.title}"
  end

  def search_content
    body.to_plain_text
  end

  def searchable?
    card.published?  # Comments are searchable if their card is
  end
end
```

### Step 3: Models Include Their Specific Concern

```ruby
# app/models/card.rb
class Card < ApplicationRecord
  include Searchable  # Resolves to Card::Searchable
end

# app/models/comment.rb
class Comment < ApplicationRecord
  include Searchable  # Resolves to Comment::Searchable
end
```

## Real-World Example: Eventable

```ruby
# app/models/concerns/eventable.rb
module Eventable
  extend ActiveSupport::Concern

  included do
    has_many :events, as: :eventable, dependent: :destroy
    after_create_commit :create_event
  end

  def create_event
    events.create!(
      action: event_action,
      creator: event_creator,
      particulars: event_particulars
    ).tap { |event| event_was_created(event) }
  end

  # Template methods
  def event_action
    "created"
  end

  def event_creator
    Current.user
  end

  def event_particulars
    {}
  end

  # Hook for post-creation behavior
  def event_was_created(event)
    # Override in model-specific concerns
  end
end

# app/models/card/eventable.rb
module Card::Eventable
  extend ActiveSupport::Concern
  include ::Eventable

  included do
    before_create { self.last_active_at ||= Time.current }
    after_save :track_title_change, if: :saved_change_to_title?
  end

  def event_was_created(event)
    create_system_comment_for(event)
    touch_last_active_at
  end

  private
    def track_title_change
      events.create!(action: "title_changed", creator: Current.user)
    end
end
```

## Rules

1. Place shared template in `app/models/concerns/`
2. Place model-specific implementations in `app/models/model_name/`
3. Use `include ::Searchable` (with `::`) to reference the shared concern
4. Define required template methods that raise `NotImplementedError`
5. Provide sensible defaults for optional template methods
6. Use `_was_created` or similar hooks for post-action customization
