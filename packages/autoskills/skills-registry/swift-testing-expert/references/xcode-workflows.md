# Xcode Workflows

## When to use this reference

Use this file when debugging failures quickly in Xcode, configuring focused test plans, and extracting insights from large test reports.

## Test Navigator usage

- Run tests at function, suite, tag, and argument level.
- In parameterized tests, rerun only failing arguments for fast iteration.
- Use "Group by Tag" to inspect cross-suite behavior quickly.

### Example flow

1. Run suite.
2. Open failing parameterized argument.
3. Rerun only that argument to iterate quickly.

## Filtering and grouping

- Use tag filters in navigator for focused development loops.
- Keep tag naming stable so teams can reuse filters and plans.
- Prefer tag-based include/exclude over fragile test-name patterns.

### Suggested tag conventions

- `core` - always-on fast checks
- `integration` - external dependency coverage
- `regression` - bug-fix lock-in tests
- `flaky` - temporary quarantine while fixing

## Test plans

- Configure include/exclude tags per target in test plans.
- Use "any tags" vs "all tags" intentionally when combining filters.
- Maintain separate plans for:
  - fast core checks
  - integration checks
  - slower/optional scenarios

### Example plan strategy

- `Core` plan: include `core`, exclude `integration`.
- `Integration` plan: include `integration`, exclude `flaky`.
- `ReleaseGate` plan: include `core` and `regression`.

## Report triage

- Review distribution insights for failure clustering by tags/bugs/destinations.
- Investigate grouped failures first (often indicates systemic regressions).
- Ensure disabled/known-issue reasons are visible and actionable in reports.

### Triage sequence

1. Check if failures cluster by a shared tag.
2. Open one representative failure.
3. Confirm whether root cause is common (dependency/outage/config) or test-local.
4. Fix root cause, then remove temporary known-issue annotations.

## Diagnostic quality

- Keep expectations expressive and narrow.
- Improve argument/type descriptions for faster root-cause identification.
- Ensure bug traits link to trackable issues.

## Checklist

- Tag naming is consistent across suites.
- Test plans reflect team workflow (local dev, CI, release).
- Parameterized failures are rerun at argument-level before broad reruns.
