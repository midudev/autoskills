# Dynamic blocks (server rendering)

Use this file when converting a block to dynamic, or debugging frontend output mismatch.

## Choose the mechanism

- Prefer `render` in `block.json` (dynamic render file).
- Alternative: pass `render_callback` when registering the block in PHP.

## Wrapper attributes

In PHP render output, always use:

- `get_block_wrapper_attributes()`

This preserves support-generated classes/styles.

## Practical checklist

- Ensure PHP file exists and is reachable from the block root.
- Ensure registration runs on every request (not only in admin).
- Keep `save()` empty or `null` for fully dynamic output, unless you intentionally save fallback markup.

