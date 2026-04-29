---
name: "android-compose-foundations"
description: "Build Android UI with Jetpack Compose foundations, layouts, modifiers, theming, and stable component structure."
metadata:
  version: "0.1.0"
  category: "ui"
  tags: ["android", "compose", "ui", "foundation"]
  triggers:
    include: ["jetpack compose screen", "compose layout in android", "modifier cleanup compose", "android compose component structure", "compose foundation best practices"]
    exclude: ["xml fragment problem", "retrofit interceptor", "play release pipeline"]
  owners: ["@android-agent-skills/maintainers"]
  test_targets: ["examples/orbittasks-compose", "examples/orbittasks-xml", "benchmarks/triggers.jsonl"]
---
# Android Compose Foundations

## When To Use
- Use this skill when the request is about: jetpack compose screen, compose layout in android, modifier cleanup compose.
- Primary outcome: Build Android UI with Jetpack Compose foundations, layouts, modifiers, theming, and stable component structure.
- Handoff skills when the scope expands:
- `android-compose-state-effects`
- `android-material3-design-system`

## Workflow
1. Identify whether the target surface is Compose, View system, or a mixed interoperability screen.
2. Select the lowest-friction UI pattern that satisfies responsiveness, accessibility, and performance needs.
3. Build the UI around stable state, explicit side effects, and reusable design tokens.
4. Exercise edge cases such as long text, font scaling, RTL, and narrow devices in the fixture apps.
5. Validate with unit, UI, and screenshot-friendly checks before handing off.

## Guardrails
- Optimize for stable state and predictable rendering before adding animation or abstraction.
- Respect accessibility semantics, contrast, focus order, and touch target guidance by default.
- Do not mix Compose and View system ownership without an explicit interoperability boundary.
- Prefer measured performance work over premature micro-optimizations.

## Anti-Patterns
- Embedding navigation or business logic directly in leaf UI components.
- Using fixed dimensions that break on localization or dynamic text.
- Ignoring semantics and announcing only visual changes.
- Porting XML patterns directly into Compose without adapting the mental model.

## Examples
### Happy path
- Scenario: Refine the Compose OrbitTasks board with stable slots and theme tokens.
- Command: `cd examples/orbittasks-compose && ./gradlew :app:testDebugUnitTest`

### Edge case
- Scenario: Keep previews and layout behavior stable under narrow widths and long text.
- Command: `cd examples/orbittasks-compose && ./gradlew :app:assembleDebug`

### Failure recovery
- Scenario: Keep general Compose requests from drifting into state/effects or performance work.
- Command: `python3 scripts/eval_triggers.py --skill android-compose-foundations`

## Done Checklist
- The implementation path is explicit, minimal, and tied to the right Android surface.
- Relevant example commands and benchmark prompts have been exercised or updated.
- Handoffs to adjacent skills are documented when the request crosses boundaries.
- Official references cover the chosen pattern and the main migration or troubleshooting path.

## Official References
- [https://developer.android.com/develop/ui/compose](https://developer.android.com/develop/ui/compose)
- [https://developer.android.com/develop/ui/compose/layouts/basics](https://developer.android.com/develop/ui/compose/layouts/basics)
- [https://developer.android.com/develop/ui/compose/modifiers](https://developer.android.com/develop/ui/compose/modifiers)
- [https://developer.android.com/develop/ui/compose/designsystems/material3](https://developer.android.com/develop/ui/compose/designsystems/material3)
