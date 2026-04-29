# Debugging quick routes

## Block doesn’t appear in inserter

- Confirm `block.json` `name` is valid and the block is registered.
- Confirm build output exists and scripts are enqueued.
- If using PHP registration, confirm `register_block_type_from_metadata()` runs (wrong hook/file not loaded is common).

## “This block contains unexpected or invalid content”

- You changed saved markup or attribute parsing.
- Add `deprecated` versions and a migration path.
- Reproduce with an old post containing the previous markup.

## Attributes not saving

- Confirm attribute definition matches actual markup.
- If the value is in delimiter JSON, avoid brittle selectors.
- Avoid `meta` attribute source (deprecated).

## Console warnings about apiVersion (WordPress 6.9+)

If you see "The block 'namespace/block' is registered with API version 2 or lower":

- Update `apiVersion` to `3` in block.json.
- This warning only appears when `SCRIPT_DEBUG` is true.
- WordPress 7.0 will require apiVersion 3 for proper iframe editor support.

## Styles not applying in editor (apiVersion 3 / iframe)

If styles work on frontend but not in the editor:

- Ensure style handles are declared in block.json (`editorStyle`, `style`).
- Styles not included in block.json won't load inside the iframed editor.
- Check for Dashicons or other dependencies that need explicit inclusion.

