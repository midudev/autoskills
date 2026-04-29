# Autoloaded options

Autoloaded options are loaded on *every request*, so large autoload payloads can hurt performance site-wide.

## Quick checks

- Total autoload bytes:
  - `wp option list --autoload=on --format=total_bytes`
- Find biggest autoloaded options:
  - `wp option list --autoload=on --fields=option_name,size_bytes | sort -n -k 2 | tail`

Docs:

- `wp option list`: https://wpcli.dev/docs/option/list
- `wp doctor` includes an `autoload-options-size` check:
  - https://make.wordpress.org/cli/handbook/doctor-default-checks/

## Fix patterns

- Stop autoloading large blobs:
  - store large data in non-autoload options (autoload=off)
  - move large computed data to transients/object cache
- Remove stale options left behind by removed plugins/themes (careful: confirm usage before deleting).

