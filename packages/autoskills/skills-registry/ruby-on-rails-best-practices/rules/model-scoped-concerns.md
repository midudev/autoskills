---
title: Use Model-Scoped Concerns
impact: HIGH
tags: [models, concerns, organization, architecture]
---

# Use Model-Scoped Concerns

Place concerns specific to a single model in a subdirectory named after the model (`app/models/model_name/`), not in the shared `app/models/concerns/` directory.

## Why

- **Co-location**: Related code lives together, making it easier to understand a model's full behavior
- **Namespace clarity**: `Card::Closeable` clearly belongs to Card, not a shared utility
- **Avoid bloated concerns directory**: The shared concerns folder stays small and truly reusable
- **Natural discovery**: When exploring a model, you immediately see all its behaviors in its directory

## Directory Structure

```
app/models/
├── card.rb
├── card/
│   ├── closeable.rb          # Card::Closeable
│   ├── assignable.rb         # Card::Assignable
│   ├── searchable.rb         # Card::Searchable (overrides shared)
│   └── activity_spike/
│       └── detector.rb       # Card::ActivitySpike::Detector (service)
├── user.rb
├── user/
│   ├── avatar.rb             # User::Avatar
│   ├── notifiable.rb         # User::Notifiable
│   └── role.rb               # User::Role
├── concerns/                  # Only truly shared concerns
│   ├── searchable.rb         # Generic Searchable (template)
│   └── mentions.rb           # Generic Mentions (template)
```

## Bad: Everything in Shared Concerns

```ruby
# app/models/concerns/card_closeable.rb
module CardCloseable
  extend ActiveSupport::Concern
  # ...
end

# app/models/concerns/card_assignable.rb
module CardAssignable
  extend ActiveSupport::Concern
  # ...
end

# app/models/card.rb
class Card < ApplicationRecord
  include CardCloseable, CardAssignable
end
```

Problems:

- Concerns directory becomes a dumping ground
- Naming requires prefixes to avoid collisions
- Hard to see what behaviors a model has without searching

## Good: Model-Scoped Concerns

```ruby
# app/models/card/closeable.rb
module Card::Closeable
  extend ActiveSupport::Concern

  included do
    has_one :closure, dependent: :destroy

    scope :closed, -> { joins(:closure) }
    scope :open, -> { where.missing(:closure) }
  end

  def closed?
    closure.present?
  end

  def close
    create_closure!
  end

  def reopen
    closure&.destroy
  end
end

# app/models/card.rb
class Card < ApplicationRecord
  include Closeable, Assignable, Searchable, Watchable
  # Ruby resolves these from Card:: namespace first
end
```

## When to Use Shared Concerns

Place concerns in `app/models/concerns/` only when:

1. **Multiple models use identical behavior** (not just similar)
2. **The concern provides a template** that model-specific concerns override

```ruby
# app/models/concerns/searchable.rb (shared template)
module Searchable
  extend ActiveSupport::Concern

  included do
    after_save_commit :update_search_index
  end

  # Template methods - models override these
  def search_title
    raise NotImplementedError
  end

  def searchable?
    true
  end
end

# app/models/card/searchable.rb (model-specific)
module Card::Searchable
  extend ActiveSupport::Concern

  included do
    include ::Searchable  # Include shared template
  end

  def search_title
    title
  end

  def searchable?
    published?
  end
end
```

## Rules

1. Default to model-scoped concerns (`app/models/model_name/concern.rb`)
2. Name concerns using the model namespace (`Card::Closeable`, not `CardCloseable`)
3. Include without namespace prefix - Ruby resolves `Card::Closeable` automatically
4. Use shared concerns only for true cross-model abstractions or templates
5. Nest service objects and value objects under the model namespace too
