---
title: Use Fixtures for Test Data
impact: MEDIUM
tags: [testing, fixtures, patterns]
---

# Use Fixtures for Test Data

Use Rails fixtures instead of factories (FactoryBot). Create a comprehensive fixture set that represents your domain, with deterministic IDs for predictable ordering.

## Why

- **Speed**: Fixtures load once per test run, factories create objects per test
- **Realism**: Fixtures represent a complete, coherent dataset
- **Simplicity**: No factory DSL to learn or maintain
- **Predictability**: Deterministic IDs make debugging easier
- **Discovery**: All test data is visible in YAML files

## Fixture Organization

```
test/fixtures/
├── accounts.yml
├── users.yml
├── boards.yml
├── cards.yml
├── comments.yml
├── events.yml
├── sessions.yml
└── files/           # Binary fixtures (images, etc.)
    └── avatar.png
```

## Basic Fixture Patterns

### Named Fixtures with References

```yaml
# test/fixtures/users.yml
david:
  name: David
  email: david@example.com
  account: primary
  role: admin

kevin:
  name: Kevin
  email: kevin@example.com
  account: primary
  role: member
```

### UUID Primary Keys

For apps using UUIDs, generate deterministic IDs:

```yaml
# test/fixtures/cards.yml
logo:
  id: <%= ActiveRecord::FixtureSet.identify("logo", :uuid) %>
  title: The logo isn't big enough
  board: writebook
  creator: david
  status: published
  created_at: <%= 1.week.ago %>
```

### Foreign Key References

Use fixture names directly (Rails resolves them):

```yaml
# test/fixtures/comments.yml
first_comment:
  card: logo # References cards(:logo)
  creator: kevin # References users(:kevin)
  body: I agree!
```

For UUID foreign keys, use the `_uuid` suffix convention:

```yaml
# test/fixtures/events.yml
logo_published:
  id: <%= ActiveRecord::FixtureSet.identify("logo_published", :uuid) %>
  board: writebook_uuid
  creator: david_uuid
  eventable: logo (Card)
```

### Polymorphic Associations

```yaml
# test/fixtures/notifications.yml
logo_notification:
  user: kevin
  source: logo_published (Event) # Type in parentheses
```

### JSON/JSONB Columns

```yaml
# test/fixtures/events.yml
card_assignment:
  particulars: <%= { assignee_ids: [ActiveRecord::FixtureSet.identify("kevin", :uuid)] }.to_json %>
```

## Accessing Fixtures in Tests

```ruby
class CardTest < ActiveSupport::TestCase
  test "card has a title" do
    card = cards(:logo)
    assert_equal "The logo isn't big enough", card.title
  end

  test "card belongs to board" do
    assert_equal boards(:writebook), cards(:logo).board
  end
end
```

### Multiple Fixtures at Once

```ruby
test "all cards are valid" do
  cards(:logo, :layout, :draft).each do |card|
    assert card.valid?
  end
end
```

## Test Setup with Current

Set up `Current` attributes in test helper:

```ruby
# test/test_helper.rb
class ActiveSupport::TestCase
  fixtures :all

  setup do
    Current.account = accounts(:primary)
  end

  teardown do
    Current.reset_all
  end
end
```

### Session/User Context

```ruby
# test/test_helpers/session_test_helper.rb
module SessionTestHelper
  def sign_in_as(user_or_fixture)
    user = user_or_fixture.is_a?(Symbol) ? users(user_or_fixture) : user_or_fixture
    Current.session = sessions(user.name.parameterize.to_sym)
    Current.user = user
  end

  def with_current_user(user)
    original = Current.user
    Current.user = user
    yield
  ensure
    Current.user = original
  end
end
```

## Testing Concerns

Test concerns in files mirroring their location:

```
test/models/
├── card_test.rb
├── card/
│   ├── closeable_test.rb    # Tests Card::Closeable
│   ├── searchable_test.rb   # Tests Card::Searchable
│   └── watchable_test.rb    # Tests Card::Watchable
└── concerns/
    └── mentions_test.rb     # Tests shared Mentions concern
```

```ruby
# test/models/card/closeable_test.rb
class Card::CloseableTest < ActiveSupport::TestCase
  setup do
    Current.session = sessions(:david)
  end

  test "close creates a closure" do
    card = cards(:logo)

    assert_difference -> { Closure.count }, 1 do
      card.close
    end

    assert card.closed?
  end

  test "reopen destroys the closure" do
    card = cards(:shipping)  # Already closed in fixtures

    assert_difference -> { Closure.count }, -1 do
      card.reopen
    end

    assert_not card.closed?
  end
end
```

## Integration Test Patterns

```ruby
class CardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as :david
  end

  test "create a new card" do
    assert_difference -> { Card.count }, 1 do
      post board_cards_path(boards(:writebook)),
        params: { card: { title: "New card" } }
    end

    assert_redirected_to card_path(Card.last)
  end

  test "unauthorized user cannot access card" do
    sign_in_as :other_account_user

    get card_path(cards(:logo))

    assert_response :not_found
  end
end
```

## Testing Turbo Streams

```ruby
test "closing card returns turbo stream" do
  card = cards(:logo)

  post card_closure_path(card), as: :turbo_stream

  assert_turbo_stream action: :replace, target: dom_id(card, :card_container)
end
```

## Testing Jobs

```ruby
test "closing card enqueues notification job" do
  card = cards(:logo)

  assert_enqueued_with(job: NotifyRecipientsJob) do
    card.close
  end
end

test "job calls model method" do
  card = cards(:logo)

  perform_enqueued_jobs only: Card::ActivitySpike::DetectionJob do
    card.update!(last_active_at: Time.current)
  end

  assert card.reload.stalled?
end
```

## Rules

1. Use fixtures, not factories
2. Create a coherent dataset that represents real usage
3. Use deterministic IDs for predictable ordering
4. Reference fixtures by name in tests
5. Set up `Current` attributes in test setup
6. Mirror concern location in test file structure
7. Use `assert_enqueued_with` for job testing
8. Use `assert_turbo_stream` for Turbo response testing
