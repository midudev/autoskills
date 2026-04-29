# rails-bug-triage compact examples

Example: Reproduce pricing total mismatch

User task: "I see order totals are incorrect after discount applied. Create a failing spec that reproduces the bug and produce a minimal fix plan."

Expected triage output (JSON):

{
  "title": "Order total wrong with discount",
  "reproduction_steps": [
    "Create cart with item price 100, quantity 1",
    "Apply 10% discount code 'TEN'",
    "Call Pricing::Calculator.total on line_items"
  ],
  "failing_command": "bundle exec rspec spec/services/pricing/reproduction_spec.rb",
  "failing_tests": ["Pricing::Calculator reproduces incorrect total when discount applied"],
  "minimal_fix_plan": [
    "Investigate discount application order in Pricing::Calculator",
    "Add nil-safe guard and correct discount rounding in total method",
    "Add unit test and run full spec suite"
  ]
}

Use the spec skeleton in assets/spec-skeletons/reproduction_spec.rb as the starting point for the failing test.
