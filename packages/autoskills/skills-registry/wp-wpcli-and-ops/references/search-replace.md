# Safe `wp search-replace`

Use this file when migrating domains, switching http→https, or changing paths.

## Recommended workflow

1. Backup:
   - `wp db export`
2. Dry run:
   - `wp search-replace OLD NEW --dry-run`
3. Run for real (carefully choose scope):
   - consider `--all-tables-with-prefix` if you need to include non-core tables with the WP prefix
4. Flush:
   - `wp cache flush`
   - `wp rewrite flush`

## Multisite notes

For multisite, decide whether you’re replacing:

- a single site (`--url=...`), or
- across the network (`--network` or iterating `wp site list`).

Read:
- `references/multisite.md`

## Common flags

- `--dry-run`
- `--precise` (slower but can be safer in complex cases)
- `--skip-columns=...` (avoid touching large/binary columns)
- `--report-changed-only`

## Serialization caution

WP-CLI search-replace is designed to handle PHP serialized data, but you must still:

- avoid replacing within binary/blob columns
- validate results with application smoke tests

