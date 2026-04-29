# Multisite targeting

Use this file any time you might be operating on multisite.

## Key flags

- `--url=<site-url>` targets a specific site/blog context.
- `--network` applies to the network where supported.

## Common commands

- List sites:
  - `wp site list`
- Get site options for a specific site:
  - `wp option get siteurl --url=<site-url>`

## Guardrails

- Always include `--url` when you mean “one site” in a multisite install.
- If you need to run something across sites, prefer scripting:
  - list sites → iterate → run a safe per-site command.

