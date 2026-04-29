# Deprecations and migrations

Use this file when you must change saved markup or attribute shapes without breaking existing content.

## `deprecated` basics

Block deprecations are handled in JS block registration.

- Add older implementations to `deprecated` (newest → oldest).
- Each deprecated entry can include:
  - `attributes`
  - `supports`
  - `save`
  - `migrate`

Upstream reference:

- https://developer.wordpress.org/block-editor/reference-guides/block-api/block-deprecation/

## Practical guardrails

- Keep fixtures: store example content for each deprecated version.
- When in doubt, add a migration path rather than silently changing selectors.

