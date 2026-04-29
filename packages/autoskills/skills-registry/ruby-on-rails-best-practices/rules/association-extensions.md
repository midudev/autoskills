---
title: Association Extensions vs Model Class Methods
impact: MEDIUM
tags: [models, associations, patterns]
---

# Association Extensions vs Model Class Methods

Choose between association extensions and model class methods based on whether the operation needs parent context.

## The Decision

**Use association extensions** when the operation:

- Needs access to the parent record (`proxy_association.owner`)
- Is fundamentally about "this parent's children" (e.g., "this board's accesses")
- Should be called as a command on the collection

**Use model class methods** when the operation:

- Is independent of any specific parent
- Could be called from anywhere with explicit parameters
- Is a general utility for that model

## Example: Granting Access

### Association Extension Approach

Use when the operation is "grant access to THIS board":

```ruby
# app/models/board.rb
class Board < ApplicationRecord
  has_many :accesses, dependent: :delete_all do
    def grant_to(users)
      board = proxy_association.owner
      Access.insert_all(
        Array(users).map do |user|
          {
            id: SecureRandom.uuid,
            board_id: board.id,
            user_id: user.id,
            account_id: board.account_id  # Needs parent's account
          }
        end
      )
    end

    def revoke_from(users)
      # Needs parent to check all_access? setting
      destroy_by(user: users) unless proxy_association.owner.all_access?
    end
  end
end

# Usage - reads as a command on the board's accesses
board.accesses.grant_to(users)
board.accesses.revoke_from(old_users)
```

Why extension works here:

- `grant_to` needs the board's `id` and `account_id`
- `revoke_from` needs to check the board's `all_access?` setting
- The API `board.accesses.grant_to(users)` reads naturally as "grant these users access to this board"

### Model Class Method Approach

Use when the operation is generic and doesn't need parent context:

```ruby
# app/models/access.rb
class Access < ApplicationRecord
  def self.grant(board:, users:)
    insert_all(
      Array(users).map do |user|
        {
          id: SecureRandom.uuid,
          board_id: board.id,
          user_id: user.id,
          account_id: board.account_id
        }
      end
    )
  end

  def self.revoke(board:, users:)
    where(board: board, user: users).destroy_all unless board.all_access?
  end
end

# Usage - explicit about what board
Access.grant(board: board, users: users)
Access.revoke(board: board, users: old_users)
```

Why class method works here:

- All parameters are explicit - no hidden context
- Easier to discover - it's in the Access model where you'd look for it
- Can be called from anywhere without having a board's accesses collection

## When to Use Each

### Use Association Extensions For:

**1. Operations that need multiple parent attributes:**

```ruby
has_many :accesses do
  def grant_to(users)
    board = proxy_association.owner
    # Needs board.id, board.account_id, board.all_access?
    Access.insert_all(users.map { |u|
      { board_id: board.id, account_id: board.account_id, user_id: u.id }
    })
  end
end
```

**2. Operations with behavior that varies by parent state:**

```ruby
has_many :accesses do
  def revoke_from(users)
    # Behavior depends on parent's all_access? setting
    destroy_by(user: users) unless proxy_association.owner.all_access?
  end
end
```

**3. Collection-scoped commands:**

```ruby
has_many :memberships do
  def revise(granted: [], revoked: [])
    transaction do
      grant_to(granted)
      revoke_from(revoked)
    end
  end
end

# Reads as: "revise this room's memberships"
room.memberships.revise(granted: new_users, revoked: old_users)
```

### Use Model Class Methods For:

**1. Operations that only need IDs (no parent behavior):**

```ruby
class Membership < ApplicationRecord
  def self.bulk_create(room_id:, user_ids:)
    insert_all(user_ids.map { |uid| { room_id: room_id, user_id: uid } })
  end
end

# Can be called from anywhere
Membership.bulk_create(room_id: room.id, user_ids: user_ids)
```

**2. General utilities:**

```ruby
class Access < ApplicationRecord
  def self.cleanup_expired
    where("expires_at < ?", Time.current).delete_all
  end
end
```

**3. When discoverability matters more than fluent API:**

If developers would naturally look in the `Access` model for access-related operations, put it there.

## Accessing the Parent in Extensions

Use `proxy_association.owner` to access the parent record:

```ruby
has_many :memberships do
  def connected
    where(user: proxy_association.owner.connected_users)
  end

  def grant_to(users)
    room = proxy_association.owner
    Membership.insert_all(
      users.map { |user| { room_id: room.id, user_id: user.id } }
    )
  end
end
```

## Combining Both Approaches

Sometimes you want both - an extension for the fluent API and a class method for the implementation:

```ruby
# app/models/access.rb
class Access < ApplicationRecord
  def self.grant(board:, users:)
    insert_all(
      Array(users).map do |user|
        { id: SecureRandom.uuid, board_id: board.id, user_id: user.id, account_id: board.account_id }
      end
    )
  end
end

# app/models/board.rb
class Board < ApplicationRecord
  has_many :accesses do
    def grant_to(users)
      Access.grant(board: proxy_association.owner, users: users)
    end
  end
end

# Both work:
Access.grant(board: board, users: users)  # Direct call
board.accesses.grant_to(users)            # Fluent API
```

## Rules

1. **Need parent context?** Use association extension
2. **Independent operation?** Use model class method
3. **Want both?** Extension can delegate to class method
4. Access parent via `proxy_association.owner`
5. Choose based on how the code reads at the call site
