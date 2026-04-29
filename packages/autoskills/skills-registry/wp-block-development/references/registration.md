# Registration patterns (PHP-first)

Use this file when you need to register blocks robustly across repo types (plugin/theme/site).

## Prefer metadata registration

Prefer:

- `register_block_type_from_metadata( $path_to_block_dir, $args = [] )`

Why:

- keeps metadata authoritative (`block.json`)
- supports dynamic render (`render`) and other metadata-driven fields
- enables cleaner asset handling

Upstream reference:

- https://developer.wordpress.org/reference/functions/register_block_type_from_metadata/

## Where to register

- Plugins: register on `init` in the main plugin bootstrap or a dedicated loader.
- Themes: register on `init` (or `after_setup_theme` if you need theme supports first), but keep it predictable.

## Dynamic render mapping

If `block.json` includes `render`, ensure the file exists relative to the block root.
Inside the render file, use `get_block_wrapper_attributes()` for wrapper attributes.

