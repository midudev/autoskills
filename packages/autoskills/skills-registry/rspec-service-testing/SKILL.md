---
name: rspec-service-testing
license: MIT
description: >
  Use when writing RSpec tests for service objects, API clients, orchestrators, or
  business logic in spec/services/. Covers instance_double, FactoryBot hash factories,
  shared_examples, subject/let blocks, context/describe structure, aggregate_failures,
  change matchers, travel_to, and error scenario testing.
---

# RSpec Service Testing

Use this skill when writing tests for service classes under `spec/services/`.

**Core principle:** Test the public contract (`.call`, `.find`, `.search`), not internal implementation. Use `instance_double` for isolation, `create` for integration.

## Workflow: Write → Run → Verify → Fix

```text
1. WRITE:   Write the spec (happy path + error cases + edge cases)
2. RUN:     bundle exec rspec spec/services/your_service_spec.rb
3. VERIFY:  Confirm failures are for the right reason (not a typo or missing factory)
4. FIX:     Implement or fix until the spec passes
5. SUITE:   bundle exec rspec spec/services/ — verify no regressions
```

**DO NOT implement the service before step 1 is written and failing for the right reason.**

## Quick Reference

| Aspect | Rule |
|--------|------|
| File location | `spec/services/module_name/service_spec.rb` |
| Subject | `subject(:service_call) { described_class.call(params) }` |
| Unit isolation | `instance_double` for collaborators |
| Integration | `create` for DB-backed tests |
| Multi-assertion | `aggregate_failures` |
| State verification | `change` matchers |
| Time-dependent | `travel_to` |
| API responses | FactoryBot hash factories (`class: Hash`) |

## Spec Template

```ruby
# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ModuleName::MainService do
  describe '.call' do
    subject(:service_call) { described_class.call(params) }

    let(:shelter) { create(:shelter, :with_animals) }
    let(:params) do
      { shelter: { shelter_id: shelter.id }, items: %w[TAG001 TAG002] }
    end

    context 'when input is valid' do
      before { create(:animal, tag_number: 'TAG001', shelter:) }

      it 'returns success' do
        expect(service_call[:success]).to be true
      end
    end

    context 'when shelter is not found' do
      let(:params) { super().merge(shelter: { shelter_id: 999_999 }) }

      it 'returns error response' do
        expect(service_call[:success]).to be false
      end
    end

    context 'when input is blank' do
      let(:params) { { shelter: { shelter_id: nil }, items: [] } }

      it 'returns error response with meaningful message' do
        aggregate_failures do
          expect(service_call[:success]).to be false
          expect(service_call[:errors]).not_to be_empty
        end
      end
    end
  end
end
```

Use `instance_double` for unit isolation:

```ruby
let(:client) { instance_double(Api::Client) }
before { allow(client).to receive(:execute_query).and_return(api_response) }
```

Use `create` for integration tests:

```ruby
let(:source_shelter) { create(:shelter, :with_animals) }
```

## FactoryBot Hash Factories for API Responses

When testing API clients, use `class: Hash` with `initialize_with` to build hash-shaped response fixtures — see [PATTERNS.md](./PATTERNS.md) for the full pattern and factory placement.

## New Test File Checklist

- [ ] `subject` defined for the main action
- [ ] `instance_double` for unit / `create` for integration
- [ ] Happy path for each public method
- [ ] Error and edge cases (blank input, invalid refs, failures)
- [ ] Partial success scenarios where relevant
- [ ] `shared_examples` for repeated patterns
- [ ] `aggregate_failures` for multi-assertion tests
- [ ] `change` matchers for state verification
- [ ] Logger expectations for error logging

## Common Mistakes

| Mistake | Correct approach |
|---------|-----------------|
| No error scenario tests | Happy path only = false confidence — always test failures |
| `let!` everywhere | Use `let` (lazy) unless the value is needed unconditionally for setup |
| Huge factory setup | Keep factories minimal — only attributes required for the test |
| Spec breaks when implementation changes but behavior is unchanged | Tests that break on refactoring are testing internals, not contracts |

## Integration

| Skill | When to chain |
|-------|---------------|
| **rspec-best-practices** | For general RSpec style and TDD discipline |
| **ruby-service-objects** | For the service conventions being tested |
| **ruby-api-client-integration** | For API client layer testing patterns |
| **rails-engine-testing** | When testing engine-specific services |

## Assets

- [assets/spec_examples.md](assets/spec_examples.md)
- [assets/testing_checklist.md](assets/testing_checklist.md)
