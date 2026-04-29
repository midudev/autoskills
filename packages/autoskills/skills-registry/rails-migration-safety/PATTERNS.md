# Advanced Migration Patterns

Reference for complex schema operations beyond add-column and add-index.

## Type Changes

Never change a column type in a single migration on a busy table. Use the add-copy-migrate-drop approach:

```ruby
# Step 1: add new column with new type
add_column :orders, :amount_cents, :bigint

# Step 2: backfill (separate deploy, in batches)
# Order.in_batches.update_all('amount_cents = CAST(amount * 100 AS BIGINT)')

# Step 3: migrate code references to new column, then drop old column
remove_column :orders, :amount
```

## Multi-Step Unique Constraints

Adding a unique index on data that may have duplicates will fail at the database level:

1. Query for duplicates: `SELECT col, COUNT(*) FROM table GROUP BY col HAVING COUNT(*) > 1`
2. Resolve duplicates in application code or a data migration
3. Add unique index concurrently after data is clean:

```ruby
disable_ddl_transaction!
add_index :users, :email, unique: true, algorithm: :concurrent
```

## Foreign Keys on Large Tables

Adding a foreign key validates all existing rows by default, which can lock the table:

```ruby
# Step 1: add without validation (fast, no lock)
add_foreign_key :orders, :users, validate: false

# Step 2 (separate migration): validate after cleaning orphans
validate_foreign_key :orders, :users
```

## Removing a Column Safely

Rails caches column information. Removing a column without first telling Active Record to ignore it causes `ActiveModel::MissingAttributeError` during the deploy window.

```ruby
# Step 1: add to ignored_columns in the model (deploy this first)
class Order < ApplicationRecord
  self.ignored_columns += %w[legacy_field]
end

# Step 2 (next deploy): drop the column
remove_column :orders, :legacy_field
```

## Multi-Database Migrations

When running migrations against a non-primary database, use `connects_to` in the migration class:

```ruby
class AddIndexToAnalyticsEvents < ActiveRecord::Migration[7.2]
  def connection
    AnalyticsEvent.connection
  end

  def change
    disable_ddl_transaction!
    add_index :analytics_events, :occurred_at, algorithm: :concurrent
  end
end
```
