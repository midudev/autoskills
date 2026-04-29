# Android Kotlin Core Patterns

## Selection Notes
- Category: `foundations`
- Best fit when the request matches the trigger language in `SKILL.md` and the implementation focus is `Use Kotlin idioms safely in Android apps, including nullability, data classes, sealed types, extension functions, and collection pipelines.`
- Reach for neighboring skills only after this skill has framed the main problem.

## Default Review Sequence
1. Map the request to the current Android stack, module boundaries, and minimum supported API level.
2. Inspect the existing implementation for implicit assumptions, duplicate helpers, and outdated patterns.
3. Apply the smallest change that improves correctness, readability, and long-term maintainability.
4. Validate the result against the relevant showcase app path and repo benchmarks.
5. Hand off adjacent work to the next specialized skill only after the core foundation is stable.

## Handoff Shortlist
- `android-state-management`
- `android-testing-unit`
