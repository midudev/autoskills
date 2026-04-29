# Inner Blocks (nested blocks)

Use this file when your block contains other blocks (container blocks).

## Canonical references

- Nested blocks guide: https://developer.wordpress.org/block-editor/how-to-guides/block-tutorial/nested-blocks-inner-blocks/
- `@wordpress/block-editor` package: https://developer.wordpress.org/block-editor/reference-guides/packages/packages-block-editor/
- Block supports: https://developer.wordpress.org/block-editor/reference-guides/block-api/block-supports/

## Practical patterns

- Editor:
  - Use `useInnerBlocksProps( useBlockProps(), { ... } )` to combine wrapper props with inner blocks.
  - Use templates/allowed blocks only when you have a clear UX reason (too strict is frustrating).
- Save:
  - Use `useInnerBlocksProps.save( useBlockProps.save(), { ... } )` if you need wrapper props.
  - Output nested content via `<InnerBlocks.Content />` when appropriate.

## Common pitfalls

- Only one `InnerBlocks` should exist per block.
- Changing the wrapper structure that contains inner blocks can invalidate existing content; consider deprecations/migrations.
- If you need to constrain allowed blocks, prefer doing it intentionally and documenting why.

