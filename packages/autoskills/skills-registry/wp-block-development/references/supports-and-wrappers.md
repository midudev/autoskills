# Supports and wrapper attributes

Use this file when changing `supports` or when your block wrapper styling behaves unexpectedly.

## Required patterns

- In `edit()`, use `useBlockProps()`.
- In `save()`, use `useBlockProps.save()`.

If the block is dynamic (PHP render), use:

- `get_block_wrapper_attributes()`

Upstream reference:

- https://developer.wordpress.org/block-editor/reference-guides/block-api/block-supports/
- https://developer.wordpress.org/reference/functions/get_block_wrapper_attributes/

