---
name: rspec-best-practices
license: MIT
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
| Spec types | Model: domain logic; Request: HTTP endpoints (prefer over controller); Job: background processing; Service/PORO: no Rails helpers; System: critical E2E only (slow) |
| Assertions | Test behavior, not implementation |
| Factories | Minimal — only attributes needed; use traits for optional states; prefer `build`/`build_stubbed` over `create` |
| Mocking | Stub external boundaries, not internal code |
| Isolation | Each example independent; no shared mutable state |
| Naming | `describe` for class/method, `context` for scenario |
| Service specs | **Required:** `describe '.call'` and `subject(:result)` for the primary invocation |
| `let` vs `let!` | Default to `let`; `let!` ONLY when object must exist before example runs |
| External service mocking | `allow(ServiceClass).to receive(:method)` — **not** `instance_double`; `instance_double` only for injected collaborators |
| Example names | Present tense: `it 'returns the user'`, never `it 'should ...'`; **NEVER contains the word "and"** — split into separate examples |
| `aggregate_failures` | Use when asserting multiple related items in one example |

## TDD Workflow

When driving new behaviour with RSpec, follow this sequence:

1. **Write the failing spec** — pick the smallest spec type that exercises the intended behaviour (model > service > request > system).
2. **Run it and confirm the failure message** — the error should be about missing code, not a setup problem.
3. **Implement the minimum code** to make the spec pass.
4. **Refactor** — clean up duplication and naming while keeping the suite green.
5. **Verify** — run the full relevant spec file, then the suite, before committing.

### Choosing the best first failing spec for a Rails change

| Change type | Start with |
|-------------|------------|
| Pure domain logic | Model or PORO service spec |
| HTTP endpoint behaviour | Request spec |
| Background processing | Job spec |
| Cross-layer user journey | System spec (sparingly) |

## Factory Design

Minimal factories only. Never rely on factory defaults for business logic — set explicitly or use traits. Avoid `create` when `build`/`build_stubbed` suffices.

## Service Spec (anchor pattern)

```ruby
RSpec.describe Invoices::MarkOverdue do
  describe '.call' do
    subject(:result) { described_class.call(invoice: invoice) }

    context 'when the invoice is overdue and unpaid' do
      let(:invoice) { create(:invoice, due_date: 2.days.ago, paid_at: nil) }

      it 'marks the invoice overdue' do
        expect { result }.to change { invoice.reload.overdue? }.from(false).to(true)
      end
    end

    context 'when the invoice is already paid' do
      let(:invoice) { create(:invoice, due_date: 2.days.ago, paid_at: 1.day.ago) }

      it 'does not change the invoice' do
        expect { result }.not_to change { invoice.reload.updated_at }
      end
    end
  end
end
```

→ Full examples: `EXAMPLES.md` | Copy-paste templates: `assets/spec_templates.md`

## Shared Examples

Use only when the same behavioural contract applies to multiple subjects without per-example `let` overrides. Avoid when each context needs different setup — that signals a wrong abstraction. → Example in `EXAMPLES.md`

## One Behavior Per Example — NEVER "and" in Example Names

The word **"and"** in an `it` / `specify` description means the example is asserting two behaviors. Split it. One behavior per example. Applies to every spec type — model, request, service, job, mailer, system.

```ruby
# BAD — two assertions; if the first fails, the second never runs
it 'returns 201 and creates the record' do; end
it 'saves the order and sends the confirmation email' do; end
it 'updates the user and logs the change' do; end

# GOOD — one observable outcome per example
it 'returns 201' do; end
it 'creates the record' do; end

it 'saves the order' do; end
it 'sends the confirmation email' do; end
```

**Self-check before finalizing any spec:** scan every `it '...'` / `it "..."` / `specify '...'` string for the word `and` (case-insensitive, word-boundary). Every hit is a split — no exceptions for "convenience" examples like `'returns nil and does not raise'`.

## Output Style

When asked to write or review RSpec specs, your output MUST satisfy each rule below. Each is graded independently — one violation drops the whole check.

1. **Spec file path** mirrors the source: `app/foo/bar.rb` → `spec/foo/bar_spec.rb`.
2. **`# frozen_string_literal: true`** as the first line of every spec file.
3. **`RSpec.describe`** uses the full constant path (`RSpec.describe Module::Class do`), not a string.
4. **`describe '#method'` / `describe '.class_method'`** for each method under test.
5. **`context 'when ...'` / `context 'with ...'`** for scenario variations — never use `context` to group methods.
6. **`let` for test data**, `let!` ONLY when the object must exist before the action under test.
7. **No `let_it_be`** unless the project already depends on `test-prof` (check `Gemfile.lock` first).
8. **NO "and" in any example description** — split on every occurrence (see section above). This is the most-missed rule; do an explicit scan before returning the spec.
9. **`subject(:result) { ... }`** for service / PORO specs invoking `.call`.
10. **`travel_to` / `freeze_time`** for any time-dependent assertion — never set past `Time.now` or stub `Time.current` directly.
11. **External boundaries mocked** at the class-method level (`allow(SomeClient).to receive(:method)`); ActiveRecord finders are NEVER mocked.

## Flaky Tests & Deterministic Assertions

| Cause | Fix |
|-------|-----|
| Time-dependent logic | `freeze_time` / `travel_to`; never set past dates as shortcut |
| State leakage | Each example sets up own state; avoid `before(:all)` |
| Async jobs | `queue_adapter = :test` + `have_enqueued_job`; never assert side-effects imperatively |
| External HTTP | `WebMock` / `VCR`; never allow real network in CI |
| DB state bleed | Transactional fixtures or `DatabaseCleaner`; never share `let!` across contexts |
| Race conditions | Explicit Capybara waits; avoid `sleep` |
| Imprecise assertions | `change.from().to()` over final state; exact values over `be_truthy`/`be_falsey`; never assert `updated_at` |

## Assets

- [EXAMPLES.md](EXAMPLES.md)
- [assets/spec_templates.md](assets/spec_templates.md)
