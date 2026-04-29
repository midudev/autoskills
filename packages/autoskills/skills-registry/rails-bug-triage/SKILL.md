---
name: rails-bug-triage
license: MIT
description: >
  Use when investigating a bug, error, or regression in a Ruby on Rails codebase.
  Creates a failing RSpec reproduction test, isolates the broken code path, and
  produces a minimal fix plan. Trigger words: debug, broken, error, regression,
  stack trace, failing test, RSpec, bug report, Rails app.
---

# Rails Bug Triage

Use this skill when a bug report exists but the right reproduction path and fix sequence are not yet clear.

**Core principle:** Do not guess at fixes. Reproduce the bug, choose the right failing spec, then plan the smallest safe repair.

## Process

1. **Capture the report:** Restate the expected behavior, actual behavior, and reproduction steps.
2. **Bound the scope:** Identify whether the issue appears in request handling, domain logic, jobs, engine integration, or an external dependency.
3. **Gather current evidence:** Logs, error messages, edge-case inputs, recent changes, or missing guards.
4. **Choose the first failing spec:** Pick the boundary where the bug is visible to users or operators.
5. **Define the smallest fix path:** Name the likely files and the narrowest behavior change that should make the spec pass.
6. **Hand off:** Continue through `rails-tdd-slices` -> `rspec-best-practices` -> implementation skill.

## Triage Output

Return findings in this shape:

1. **Observed behavior**
2. **Expected behavior**
3. **Likely boundary**
4. **First failing spec to add**
5. **Smallest safe fix path**
6. **Follow-up skills**

**Example (wrong status code bug):**

```
1. Observed:  POST /orders returns 500 when product is out of stock
2. Expected:  Returns 422 with { error: "Out of stock" }
3. Boundary:  Request layer — visible in HTTP contract
4. First spec: spec/requests/orders/create_spec.rb
5. Fix path:  Orders::CreateOrder should return { success: false, error: "Out of stock" }
              when inventory check fails; controller renders 422
6. Next:      rails-tdd-slices → write request spec → rspec-best-practices → fix
```

**Skeleton failing spec:**

```ruby
# spec/requests/orders/create_spec.rb
RSpec.describe "POST /orders", type: :request do
  context "when product is out of stock" do
    let(:product) { create(:product, stock: 0) }

    it "returns 422 with an error message" do
      post orders_path, params: { order: { product_id: product.id, quantity: 1 } }, as: :json
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body["error"]).to eq("Out of stock")
    end
  end
end
```

Run it before implementing the fix: `bundle exec rspec spec/requests/orders/create_spec.rb`

## Boundary Guide

See [BOUNDARY_GUIDE.md](./BOUNDARY_GUIDE.md) for the full bug-shape → spec-type mapping and layer diagnosis tips.

Quick reference:

| Bug shape | Likely first spec |
|-----------|-------------------|
| HTTP symptoms (status, JSON, redirect) | Request spec |
| Data symptoms (wrong value, validation) | Model or service spec |
| Timing symptoms (missing job, email) | Job spec |
| Engine routing/generator regression | Engine spec in dummy app |

## Pitfalls

| Pitfall | What to do |
|---------|------------|
| Unit spec when the bug is visible at request level | Start where the failure is actually observed |
| Bundling reproduction, refactor, and new features | Fix the bug in the smallest safe slice only |
| Flaky evidence treated as green light to patch | Stabilize reproduction before touching code |
| The explanation relies on "probably" or "maybe" | Ambiguity means the reproduction step isn't done yet |

## Integration

| Skill | When to chain |
|-------|---------------|
| **rails-tdd-slices** | To choose the strongest first failing spec for the bug |
| **rspec-best-practices** | To run the TDD loop correctly after the spec is chosen |
| **refactor-safely** | When the bug sits inside a risky refactor area and behavior must be preserved first |
| **rails-code-review** | To review the final bug fix for regressions and missing coverage |
| **rails-architecture-review** | When the bug points to a deeper boundary or orchestration problem |

## Assets

- [assets/examples.md](assets/examples.md)
