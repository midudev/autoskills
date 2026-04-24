# Rails Code Review Checklist

Full per-area check criteria for use during the 15-step Review Order.

## 1. Configuration & Environments
- Encrypted credentials (not plaintext secrets)
- Zeitwerk autoloading compliant
- Per-environment logging configured

## 2. Routing
- RESTful `resources`/`resource` — max one level nesting (prefer shallow)
- Named routes used consistently
- Route constraints where input must be validated

## 3. Controllers
- Action order: index, show, new, edit, create, update, destroy
- Strong params with explicit `permit` — no `permit!`
- `before_action` scoped with `only:`/`except:`
- Skinny: no business logic inline — delegate to services
- `respond_to` for multi-format responses

## 4. Action View
- No logic in views — use helpers or presenters
- `content_for`/`yield` for layout composition
- Rails helpers over raw HTML

## 5. ActiveRecord Models
- Structure order: extends, includes, constants, attributes, enums, associations, delegations, validations, scopes, callbacks, class methods, instance methods
- `inverse_of` on bidirectional associations
- Explicit enum values (`enum status: { active: 0, inactive: 1 }`)
- `validates` not `validates_presence_of`
- Scopes for reusable queries
- Limit callbacks — prefer service objects for orchestration

## 6. Associations
- `dependent:` set for all has_many/has_one associations
- `through:` for many-to-many
- STI only when justified (shared behavior + same table makes sense)

## 7. Queries
- `includes`/`preload`/`eager_load` for N+1 prevention
- `exists?` over `present?` for existence checks
- `pluck` for arrays of single attributes
- `find_each` for large dataset iteration
- `insert_all`/`upsert_all` for bulk operations
- `load_async` (Rails 7+) for parallelizable queries
- Transactions for atomic multi-step operations

## 8. Migrations
- `change` method for reversibility
- Index every foreign key and WHERE/JOIN column
- `add_reference` with `foreign_key: true`
- Large-table index additions in separate migration with `algorithm: :concurrent`

## 9. Validations
- Built-in validators preferred
- Conditional validators with `if:`/`unless:`
- Custom validator classes for complex cross-field rules

## 10. I18n
- All user-facing strings via I18n (no hardcoded English in views)
- Lazy lookup in views (`t('.title')`)
- Locale set from user preferences or Accept-Language header

## 11. Sessions & Cookies
- No complex objects stored in session
- Signed/encrypted cookies for sensitive values
- `flash` for temporary user-facing messages only

## 12. Security
- Strong params, parameterized queries
- No `raw`/`html_safe` on user-provided content
- `protect_from_forgery` active
- CSP headers configured
- Sensitive data masked in logs

## 13. Caching & Performance
- Fragment caching with cache keys
- Nested caching where appropriate
- `Rails.cache` for shared cache access
- ETags for conditional GET responses
- `EXPLAIN` for slow queries before merging

## 14. Background Jobs
- Active Job for queue abstraction
- Idempotent: safe to run twice
- Retriable: appropriate retry/discard strategy
- Correct queue and backend for the job's priority

## 15. Testing (RSpec)
- Descriptive `describe`/`context`/`it` blocks
- `let`/`let!` for test data setup
- FactoryBot for fixtures
- Shared examples for repeated patterns
- External services mocked at boundary
