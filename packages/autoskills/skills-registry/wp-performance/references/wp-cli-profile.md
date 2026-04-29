# WP-CLI profiling (`wp profile`)

Use this when you need actionable profiling without a browser.

## Install (if missing)

`wp profile` comes from a WP-CLI package:

- `wp package install wp-cli/profile-command`

Docs:

- https://wpcli.dev/docs/profile/stage
- https://wpcli.dev/docs/profile/hook
- https://wpcli.dev/docs/profile/eval

## Recommended sequence

1. Stage overview:
   - `wp profile stage --fields=stage,time,cache_ratio [--url=<url>]`
2. Hooks hotspot:
   - `wp profile hook --spotlight [--url=<url>]`
   - then drill into a specific hook:
     - `wp profile hook init --spotlight [--url=<url>]`
3. Targeted evaluation:
   - `wp profile eval 'do_action(\"init\");' --hook=init`

Tips:

- Use `--url` to profile specific site/route behavior.
- Use `--skip-plugins` / `--skip-themes` to isolate culprit components (careful: behavior changes).

