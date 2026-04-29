# rails-code-review examples

## Machine-readable finding (map `severity` to skill labels: Critical | Suggestion | Nice to have)

```json
{
  "severity": "Critical",
  "file": "app/controllers/orders_controller.rb",
  "line": 120,
  "risk": "Unpermitted params used in create leading to mass-assignment of admin flag",
  "recommendation": "Use strong params and whitelist allowed attributes; add test to assert admin cannot be set via params",
  "proof_of_concept": "POST /orders with { order: { amount: 1, admin: true } } sets admin flag to true for new order"
}
```

## PR comment shape (markdown, matches SKILL.md)

```text
## Review — Add order totals

### Critical
- [app/controllers/orders_controller.rb:42] (Controllers) `permit!` on nested params. **Mitigation:** replace with explicit `.permit(:amount, :currency)`.

### Suggestion
- [app/models/order.rb:30] (Queries) N+1 loading line items in index. **Mitigation:** `includes(:line_items)` on the index scope.

### Nice to have
- [spec/requests/orders_spec.rb:12] (Tests) Describe block could name the unauthorized case. **Mitigation:** add a `context` for the missing-session case.

**Actions required:** Critical — block merge until fixed and re-reviewed. Suggestion — fix in this PR. Nice to have — optional.
```

## Reviewer note examples

- "Suggest moving business logic to OrderCreator service and adding request specs"
- "Index on orders(user_id, status) would improve query performance for recent reports"
