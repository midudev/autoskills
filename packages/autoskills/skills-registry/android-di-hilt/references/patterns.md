# Android DI Hilt Patterns

## Selection Notes
- Category: `foundations`
- Best fit when the request matches the trigger language in `SKILL.md` and the implementation focus is `Wire Android dependency injection with Hilt, scopes, testing overrides, and module ownership boundaries.`
- Reach for neighboring skills only after this skill has framed the main problem.

## Review Sequence
- Ownership:
  which component owns the dependency and why
- Binding style:
  constructor injection vs `@Binds` vs `@Provides` vs entry point
- Lifetime:
  singleton vs retained vs ViewModel vs shorter-lived scopes
- Testing:
  fake/replacement strategy and graph override location

## Default Review Sequence
1. Identify the injection boundary and owner component.
2. Choose the simplest binding style that fits.
3. Match scope to lifetime deliberately.
4. Plan test replacement at the same graph boundary.
5. Hand off non-DI concerns once the graph is coherent.

## Best-Practice Notes
- Constructor injection is the default when you control the type.
- Qualifiers are often clearer than multiple similar providers with implicit selection.
- Multi-module Hilt setups need explicit ownership to avoid “god modules.”
- Scope bugs are usually ownership bugs first.

## Handoff Shortlist
- `android-testing-unit`
- `android-networking-retrofit-okhttp`
