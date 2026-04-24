---
title: Ruby Code Style Conventions
impact: MEDIUM
tags: [style, conventions, ruby]
---

# Ruby Code Style Conventions

Follow consistent code style conventions for readable, maintainable Ruby code. These patterns are inspired by Basecamp's coding style.

## Conditional Returns

Prefer expanded conditionals over guard clauses in most cases:

```ruby
# Bad: Guard clause can be hard to follow
def todos_for_new_group
  ids = params.require(:todolist)[:todo_ids]
  return [] unless ids
  @bucket.recordings.todos.find(ids.split(","))
end

# Good: Expanded conditional
def todos_for_new_group
  if ids = params.require(:todolist)[:todo_ids]
    @bucket.recordings.todos.find(ids.split(","))
  else
    []
  end
end
```

### Exception: Early Returns for Preconditions

Guard clauses are acceptable when:

1. The return is at the very beginning
2. The main body is non-trivial

```ruby
# OK: Early return for precondition
def after_recorded_as_commit(recording)
  return if recording.parent.was_created?

  if recording.was_created?
    broadcast_new_column(recording)
  else
    broadcast_column_change(recording)
  end
end
```

## Method Ordering

Order methods by their call hierarchy:

1. `class` methods (if any)
2. `public` instance methods with `initialize` first
3. `private` methods in invocation order

```ruby
class SomeClass
  def some_method
    method_1
    method_2
  end

  private
    def method_1
      method_1_1
      method_1_2
    end

    def method_1_1
      # ...
    end

    def method_1_2
      # ...
    end

    def method_2
      # ...
    end
end
```

## Visibility Modifiers

Indent under `private`, no newline after the modifier:

```ruby
# Good
class SomeClass
  def public_method
    # ...
  end

  private
    def private_method_1
      # ...
    end

    def private_method_2
      # ...
    end
end
```

For modules with only private methods, don't indent:

```ruby
module SomeModule
  private

  def some_private_method
    # ...
  end
end
```

## Bang Methods

Only use `!` suffix when there's a corresponding method without `!`:

```ruby
# Good: Bang indicates "raises on failure" variant
def save; end
def save!; end

def find_by; end
def find_by!; end

# Bad: No non-bang counterpart exists
def destroy!; end  # Just use destroy

# Bad: Using bang for "destructive" without counterpart
def delete_all!; end  # Just use delete_all
```

## Line Length and Breaking

Keep lines readable. Break long method chains:

```ruby
# Bad: Too long
result = users.active.where(role: :admin).includes(:profile).order(created_at: :desc).limit(10)

# Good: Break at method calls
result = users
  .active
  .where(role: :admin)
  .includes(:profile)
  .order(created_at: :desc)
  .limit(10)
```

Break long argument lists:

```ruby
# Good: Arguments on separate lines
create_notification!(
  user: recipient,
  source: self,
  creator: Current.user,
  action: :mentioned
)
```

## Hash Syntax

Use modern hash syntax:

```ruby
# Bad
{ :name => "David", :email => "david@example.com" }

# Good
{ name: "David", email: "david@example.com" }
```

## String Interpolation

Use interpolation over concatenation:

```ruby
# Bad
"Hello, " + user.name + "!"

# Good
"Hello, #{user.name}!"
```

## Blocks

Use `do...end` for multi-line blocks, `{ }` for single line:

```ruby
# Good: Single line
users.map { |u| u.name.upcase }

# Good: Multi-line
users.each do |user|
  user.send_notification
  user.update!(notified_at: Time.current)
end
```

## Concern Structure: What Goes Where

Concerns have three distinct areas, each with a specific purpose:

### 1. `included` Block: Class-Level Macros

The `included` block runs when the concern is included into a class. Put **class-level macros** here - things that configure the class itself:

- **Associations**: `has_many`, `belongs_to`, `has_one`
- **Validations**: `validates`, `validate`
- **Callbacks**: `after_save`, `before_create`, etc.
- **Scopes**: `scope :active, -> { ... }`

```ruby
included do
  has_one :closure, dependent: :destroy

  validates :title, presence: true

  scope :closed, -> { joins(:closure) }

  after_create_commit :notify_creator
end
```

**Why it must be in `included`**: These are method calls on the class (like `Card.has_one`). They need to run when the concern is included, not when the module is defined. Without `included`, they would run when Ruby loads the module file, before any class has included it.

### 2. Outside `included`: Instance Methods

Regular instance methods go **outside** the `included` block. They're automatically added to any class that includes the concern:

```ruby
def closed?
  closure.present?
end

def close
  create_closure!
end

private
  def notify_creator
    NotifyJob.perform_later(self)
  end
```

**Why outside**: Instance methods don't need special timing - Ruby's `include` automatically adds the module's methods to the class.

### 3. `class_methods` Block: Class Methods

Use the `class_methods` block for methods you want to call on the class itself:

```ruby
class_methods do
  def search(query)
    where("title LIKE ?", "%#{query}%")
  end
end
```

### Complete Example

```ruby
module Card::Closeable
  extend ActiveSupport::Concern

  # 1. Class-level macros - configure the including class
  included do
    has_one :closure, dependent: :destroy

    scope :closed, -> { joins(:closure) }
    scope :open, -> { where.missing(:closure) }

    after_create_commit :notify_creator
  end

  # 2. Class methods - called on the class (Card.find_closed)
  class_methods do
    def find_closed(id)
      closed.find(id)
    end
  end

  # 3. Instance methods - called on instances (card.closed?)
  def closed?
    closure.present?
  end

  def close
    create_closure!
  end

  private
    def notify_creator
      # ...
    end
end
```

### Common Mistake

```ruby
# WRONG: This runs when the file is loaded, not when included
module Card::Closeable
  extend ActiveSupport::Concern

  has_one :closure  # Error! No class to call has_one on yet

  def closed?
    closure.present?
  end
end

# CORRECT: Macros in included block
module Card::Closeable
  extend ActiveSupport::Concern

  included do
    has_one :closure  # Runs when Card includes this concern
  end

  def closed?
    closure.present?
  end
end
```

## Predicate Methods

Name boolean-returning methods with `?`:

```ruby
def closed?
  closure.present?
end

def can_edit?(user)
  creator == user || user.admin?
end

def published?
  status == "published"
end
```

## Avoid Negated Conditions in Method Names

```ruby
# Bad
def not_published?
  !published?
end

# Good: Use the positive form
def draft?
  !published?
end

# Or check the actual state
def draft?
  status == "draft"
end
```

## Avoid Double Negatives

```ruby
# Bad
unless !user.active?
  # ...
end

# Good
if user.active?
  # ...
end
```

## Rules

1. Prefer expanded conditionals over guard clauses
2. Order methods by invocation hierarchy
3. Indent under `private`, no newline after modifier
4. Only use `!` suffix when a non-bang method exists
5. Break long lines at natural points
6. Use modern hash syntax
7. Use `do...end` for multi-line blocks
8. Name predicate methods with `?` suffix
9. Avoid negated method names
