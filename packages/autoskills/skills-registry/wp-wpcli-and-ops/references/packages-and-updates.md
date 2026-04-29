# Plugin/theme operations

Use this file for installs, activation, updates, and listing state.

## Common commands

- Plugins:
  - `wp plugin list`
  - `wp plugin status <slug>`
  - `wp plugin activate <slug>`
  - `wp plugin deactivate <slug>`
  - `wp plugin update --all`
- Themes:
  - `wp theme list`
  - `wp theme activate <slug>`
  - `wp theme update --all`

## Guardrails

- On production, avoid `update --all` without a maintenance window.
- On multisite, plugin activation may be per-site or network-wide; confirm intent.

