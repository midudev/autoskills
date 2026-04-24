---
name: rspec-best-practices
description: >
  Use when writing, reviewing, or cleaning up RSpec tests for Ruby and Rails codebases.
  Covers spec type selection, factory design, flaky test fixes, shared examples, deterministic
  assertions, test-driven development discipline, and choosing the best first failing
  spec for Rails changes. Also applies when choosing between model, request, system,
  and job specs.
---

# RSpec Best Practices

Use this skill when the task is to write, review, or clean up RSpec tests.

**Core principle:** Prefer behavioral confidence over implementation coupling. Good specs are readable, deterministic, and cheap to maintain.

## Quick Reference

| Aspect | Rule |
|--------|------|
| Spec type | Request > controller; model for domain; system only for critical E2E |
| Assertions | Test behavior, not implementation |
| Factories | Minimal — only attributes needed for the test |
| Mocking | Stub external boundaries, not internal code |
| Isolation | Each example independent; no shared mutable state |
| Naming | `describe` for class/method, `context` for scenario |
| Service specs | **Required:** `describe '.call'` and `subject(:result)` for the primary invocation |
| `let` vs `let!` | Default to `let`. Use `let!` ONLY when the object must exist before the example runs (e.g., a DB record checked via `.count`) |
| External service mocking | Class methods: `allow(ServiceClass).to receive(:method)` — **not** `instance_double`. Use `instance_double` only for injected instance collaborators |
| Example names | Never use "and" in an example name — one behavior per example; split it |
| First slice | Start at the highest-value boundary that proves behavior |
| TDD | Write test first, run it, verify failure, then implement |

## HARD-GATE: Tests Gate Implementation

```text
THE WORKFLOW IS: PRD → TASKS → TESTS → IMPLEMENTATION

Tests are a GATE between planning and code.
NO implementation code may be written until:
  1. The test EXISTS
  2. The test has been RUN
  3. The test FAILS for the correct reason (feature missing, not typo)
```

Write code before the test? Delete it. Start over.

**The gate cycle for each behavior:**

1. **Write test:** One minimal test showing what the behavior should do
2. **Run test:** Execute it — this is mandatory, not optional
3. **Validate failure:** Confirm it fails because the feature is missing
4. **CHECKPOINT — Test Design Review:** Present the failing test. Confirm boundary, behavior, and edge cases before writing implementation. See `rails-tdd-slices` for checkpoint format.
5. **GATE PASSED** — you may now write implementation code
6. **CHECKPOINT — Implementation Proposal:** Before writing code, state which classes/methods will be created or changed and the rough structure. Wait for confirmation.
7. **Write minimal code:** Simplest implementation to make the test pass
8. **Run test again:** Confirm it passes and no other tests break
9. **Refactor:** Clean up — tests must stay green
10. **Next behavior:** Return to step 1

## TDD Slice Selection

Choose the first failing spec at the boundary that gives the strongest signal with the least setup:

| Change type | Best first spec |
|-------------|-----------------|
| New endpoint, controller action, or API behavior | Request spec |
| New domain rule on an existing model | Model spec |
| New service object or orchestration flow | Service spec |
| Background job behavior | Job spec; add service/domain spec if logic is non-trivial |
| Rails engine route, install, or generator behavior | Engine request/routing/generator spec via `rails-engine-testing` |
| Bug fix | Reproduction spec at the boundary where the bug is observed |

## Structure and Style

- **describe** for the class, module, or behavior; **context** for scenarios ("when valid", "when user is missing").
- Mirror source paths under `spec/` (e.g. `app/models/user.rb` → `spec/models/user_spec.rb`).
- Use **shared_examples** / **shared_context** for repeated behavior; put reusable shared examples under `spec/support/`.
- Use `let_it_be` only when `test-prof` already exists in the project.
- **Time-dependent behavior MUST use `travel_to`** — do not set dates in the past as a shortcut, do not stub `Time.now`. Wrap assertions in a `travel_to` block to control the clock:

```ruby
let(:subscription) { create(:subscription, activated_at: Time.current) }

context 'after expiration' do
  it 'is expired' do
    travel_to 31.days.from_now do
      expect(subscription).to be_expired
    end
  end
end
```

**Minimal request spec skeleton:**

```ruby
# frozen_string_literal: true

RSpec.describe 'POST /orders', type: :request do
  let(:product) { create(:product, stock: 5) }

  context 'when product is in stock' do
    it 'returns 201 for an in-stock product' do
      post orders_path, params: { order: { product_id: product.id } }, as: :json
      expect(response).to have_http_status(:created)
    end
  end
end
```

**Monolith vs engine:** When the project is a Rails engine, use `rails-engine-testing` for dummy-app setup and engine request/routing/generator specs; keep using this skill for general RSpec style.

For more examples (model spec, service spec, shared_examples, travel_to), see [EXAMPLES.md](./EXAMPLES.md).

## Pitfalls

| Pitfall | What to do |
|---------|------------|
| Starting with the lowest layer by habit | Begin at the boundary that proves the behavior users care about |
| Testing mock behavior instead of real behavior | Assert outcomes, not implementation details |
| Recommending `let_it_be` in every repo | Only use it when `test-prof` already exists in the project |
| Factories creating large graphs by default | Minimal factories — only what the test needs |
| Setting dates in the past instead of `travel_to` | Always use `travel_to` for time-dependent assertions — it makes boundary conditions deterministic |
| Code written before the test | Delete it. Reproduction step isn't done yet. |
| Test name contains "and" | One behavior per example. Split it. |

## Integration

| Skill | When to chain |
|-------|---------------|
| **rails-tdd-slices** | When the hardest part is choosing the first failing Rails spec or vertical slice |
| **rails-bug-triage** | When a bug report must be turned into a reproducible failing spec and fix plan |
| **rspec-service-testing** | For service object specs — `instance_double` for **injected instance** collaborators, hash factories, shared_examples; NOT for external class method mocking |
| **rails-engine-testing** | For engine specs — dummy app, routing specs, generator specs |
| **rails-code-review** | When reviewing test quality as part of code review |
| **refactor-safely** | When adding characterization tests before refactoring |
