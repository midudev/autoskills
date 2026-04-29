# Creating new blocks (scaffolding)

Use this file when you are creating a new block (or a new block plugin) from scratch.

## Preferred path: `@wordpress/create-block`

`@wordpress/create-block` scaffolds a modern block setup that tends to track current best practices.

Typical options to decide up front:

- TypeScript vs JavaScript
- Static vs dynamic (`render.php` / server rendering)
- Whether the block should be interactive on the frontend

Canonical docs:

- https://developer.wordpress.org/block-editor/reference-guides/packages/packages-create-block/

## “Most up-to-date” interactive blocks

For a modern interactive block, prefer the official Interactivity API template:

- Template: `@wordpress/create-block-interactive-template`

This template is designed to integrate:

- Interactivity API directives (`data-wp-*`)
- module-based view scripts (`viewScriptModule`)
- server rendering (`render.php`)

References:

- https://developer.wordpress.org/block-editor/reference-guides/packages/packages-create-block/
- https://make.wordpress.org/core/2024/03/04/a-first-look-at-the-interactivity-api-in-wordpress-6-5/

## Manual fallback (when scaffolding is not available)

If you cannot run `create-block` (no Node tooling or restricted network):

1. Create a plugin or theme location that will register the block.
2. Create a block folder with a valid `block.json`.
3. Register via `register_block_type_from_metadata()` in PHP.
4. Add editor JS and (optionally) frontend view assets.

Then follow the rest of `wp-block-development` for metadata, registration, and serialization.

