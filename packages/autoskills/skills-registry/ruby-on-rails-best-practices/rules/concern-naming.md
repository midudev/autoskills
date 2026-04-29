---
title: Concern Naming Conventions
impact: MEDIUM
tags: [models, concerns, naming]
---

# Concern Naming Conventions

Use consistent naming patterns for concerns that communicate their purpose at a glance.

## Why

- **Self-documenting**: Good names tell you what a model can do or has
- **Consistency**: Predictable naming makes the codebase easier to navigate
- **Discoverability**: Developers can guess concern names without searching

## Naming Patterns

### Adjectives ending in `-able` (Most Common)

Use for capabilities or behaviors the model can perform:

```ruby
module Card::Closeable      # Can be closed
module Card::Assignable     # Can be assigned
module Card::Searchable     # Can be searched
module Card::Watchable      # Can be watched
module Card::Taggable       # Can be tagged
module Card::Postponable    # Can be postponed
module User::Mentionable    # Can be mentioned
module User::Transferable   # Can be transferred
module Board::Accessible    # Has access control
module Account::Cancellable # Can be cancelled
```

### Adjectives ending in `-ed` (State/Tracking)

Use for concerns that track or materialize state:

```ruby
module Storage::Tracked     # Tracks storage usage
module Storage::Totaled     # Has materialized totals
```

### Nouns (Features/Concepts)

Use when the concern represents a distinct feature or concept:

```ruby
module User::Avatar         # Has avatar functionality
module User::Role           # Has role/permissions
module Card::Mentions       # Has @mentions functionality
module Card::Statuses       # Has status management
module Account::Storage     # Has storage management
```

### Present Participles (Actions)

Use sparingly for action-focused concerns:

```ruby
module User::Filtering      # Provides filtering capabilities
module Card::Broadcastable  # Handles Turbo broadcasting
```

### Derived from Associations

Sometimes name after the association it manages:

```ruby
module User::Accessor       # Manages Access records
module User::Assignee       # Acts as an assignee
module Board::Cards         # Manages cards relationship
```

## Bad: Inconsistent or Unclear Names

```ruby
module CardHelpers          # Too vague
module CardMixin            # Meaningless suffix
module DoesCardStuff        # Not a proper adjective/noun
module CardClosingBehavior  # Overly verbose
module CloseableCard        # Wrong order - model name comes first in namespace
```

## Good: Clear, Consistent Names

```ruby
module Card::Closeable
module Card::Assignable
module Card::Eventable
module User::Notifiable
module Board::Accessible
```

## Naming Decision Tree

1. Does it add a capability the model can do? → Use `-able` (e.g., `Searchable`)
2. Does it track state or provide data? → Use `-ed` or noun (e.g., `Tracked`, `Storage`)
3. Does it represent a distinct feature? → Use noun (e.g., `Avatar`, `Role`)
4. Does it manage an association? → Consider deriving from association name

## Rules

1. Prefer `-able` suffix for behaviors and capabilities
2. Use the model namespace prefix (`Card::`, not `Card` prefix)
3. Keep names short - one word when possible
4. Be consistent across the codebase
5. Names should be guessable - a developer should be able to find concerns without searching
