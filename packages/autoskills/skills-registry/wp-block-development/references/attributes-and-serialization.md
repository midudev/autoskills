# Attributes and serialization

Use this file when attributes aren’t saving, content becomes “Invalid block”, or you’re changing markup.

## How attributes persist

Attributes can come from:

- the comment delimiter JSON (common and stable)
- the block’s saved HTML (from tags/attributes)
- context

Read the canonical guide for supported `source`/`selector`/`attribute` patterns:

- https://developer.wordpress.org/block-editor/reference-guides/block-api/block-attributes/

## Common pitfalls

- Changing saved HTML without a `deprecated` version breaks existing posts.
- Using the `meta` attribute source (deprecated) causes long-term pain; avoid it.
- Choosing brittle selectors leads to attributes “not found” when markup changes slightly.

