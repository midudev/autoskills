---
name: rails-tdd-slices
license: MIT
description: >
  Use when choosing the best first failing RSpec spec or vertical slice for a
  Ruby on Rails change. Covers request vs model vs service vs job vs engine spec
  selection, system spec escalation, smallest safe slice planning, and
  Rails-first TDD sequencing. Trigger words: where to start testing, what test
  to write first, RSpec, test-driven development, TDD, first failing test.
---

# Rails TDD Slices

Use this skill when the hardest part of the task is deciding where TDD should start.

**Core principle:** Start at the highest-value boundary that proves the behavior with the least unnecessary setup.

## Quick Reference

| Change type | First spec | Path | Why |
|-------------|-----------|------|-----|
| API contract, params, status code, JSON shape | Request spec | `spec/requests/` | Proves the real HTTP contract |
| Domain rule on a cohesive record or value object | Model spec | `spec/models/` | Fast feedback on domain behavior |
| Multi-step orchestration across collaborators | Service spec | `spec/services/` | Focuses on the workflow boundary |
| Enqueue/run/retry/discard behavior | Job spec | `spec/jobs/` | Captures async semantics directly |
| Critical Turbo/Stimulus or browser-visible flow | System spec | `spec/system/` | Use only when browser interaction is the real risk |
| Engine routing, generators, host integration | Engine spec | `spec/requests/` or engine path | Normal app specs miss engine wiring — see `rails-engine-testing` |
| Bug fix | Reproduction spec | Where the bug is observed | Proves the fix and prevents regression |
| Unsure between layers | Higher boundary first | — | Easier to prove real behavior before drilling down |

## HARD-GATE

```text
DO NOT choose the first spec based on convenience alone.
DO NOT start with a lower-level unit if the real risk is request, job, engine, or persistence wiring.
ALWAYS run the chosen spec and verify it fails for the right reason before implementation.
```

## Process

1. **Name the behavior:** State the user-visible outcome or invariant to prove.
2. **Locate the boundary:** Decide where the behavior is observed first: HTTP request, service entry point, model rule, job execution, engine integration, or external adapter.
3. **Pick the smallest strong slice:** Choose the spec type that proves the behavior without dragging in unrelated layers.
4. **Suggest the path:** Name the likely spec path using normal Rails conventions (for example `spec/requests/...`, `spec/services/...`, `spec/jobs/...`, `spec/models/...`).
5. **Write one failing example:** Keep it minimal; one example is enough to open the gate.
6. **Run and validate:** Confirm the failure is because the behavior is missing, not because the setup is broken.
7. **Hand off:** Continue with `rspec-best-practices`, `rspec-service-testing`, `rails-engine-testing`, or the implementation skill that fits the slice.

## Examples

### Good: New JSON Endpoint

```ruby
# Behavior: POST /orders validates params and returns 201 with JSON payload
# First slice: request spec
# Suggested path: spec/requests/orders/create_spec.rb

RSpec.describe "POST /orders", type: :request do
  let(:user) { create(:user) }
  let(:valid_params) { { order: { product_id: create(:product).id, quantity: 1 } } }

  before { sign_in user }

  it "creates an order and returns 201" do
    post orders_path, params: valid_params, as: :json
    expect(response).to have_http_status(:created)
    expect(response.parsed_body["id"]).to be_present
  end
end
```

### Good: New Orchestration Service

```ruby
# Behavior: Orders::CreateOrder validates inventory, persists, and enqueues follow-up work
# First slice: service spec
# Suggested path: spec/services/orders/create_order_spec.rb

RSpec.describe Orders::CreateOrder do
  subject(:result) { described_class.call(user: user, product: product, quantity: 1) }

  let(:user)    { create(:user) }
  let(:product) { create(:product, stock: 5) }

  it "returns a successful result with the new order" do
    expect(result).to be_success
    expect(result.order).to be_persisted
  end
end
```

## Test Feedback Checkpoint

After writing and running the first failing spec, **pause before implementation** and present the test for review:

```
CHECKPOINT: Test Design Review

1. Present: Show the failing spec(s) written
2. Ask:
   - Does this test cover the right behavior?
   - Is the boundary correct (request vs service vs model)?
   - Are the most important edge cases represented?
   - Is the failure reason correct (feature missing, not setup error)?
3. Confirm: Only proceed to implementation once test design is approved.
```

**Why this matters:** Implementing against a poorly designed test wastes the TDD cycle. A 2-minute review of the test now prevents a full rewrite later.

**Hand off:** After test design is confirmed → `rspec-best-practices` for the full TDD gate cycle.

## Pitfalls

| Pitfall | What to do |
|---------|------------|
| Starting with a PORO spec because it is easy | Easy ≠ high-signal — choose the boundary that proves the real behavior |
| Writing three spec types before running any | Pick one slice, run it, prove the failure, then proceed |
| Defaulting to request specs for everything | Some domain rules are better proven at the model or service layer |
| Defaulting to model specs for controller behavior | Controllers and APIs need request-level proof |
| Using controller specs as the default HTTP entry point | Prefer request specs unless the repo has an existing reason |
| Jumping to system specs too early | Reserve for critical browser flows that lower layers cannot prove |
| "We'll add the request spec later" | The spec is the gate — implement only after the first slice is failing for the right reason |
| First spec requires excessive factory setup | Excessive setup = wrong boundary. Simplify or move the slice. |

## Integration

| Skill | When to chain |
|-------|---------------|
| **rspec-best-practices** | After choosing the first slice, to enforce the TDD loop correctly |
| **rspec-service-testing** | When the first slice is a service object spec |
| **rails-engine-testing** | When the first slice belongs to an engine |
| **rails-bug-triage** | When the starting point is an existing bug report |
| **refactor-safely** | When the task is mostly structural and needs characterization tests first |
