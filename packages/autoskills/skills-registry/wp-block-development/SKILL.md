---
name: wp-block-development
description: "Use when developing WordPress (Gutenberg) blocks: block.json metadata, register_block_type(_from_metadata), attributes/serialization, supports, dynamic rendering (render.php/render_callback), deprecations/migrations, viewScript vs viewScriptModule, and @wordpress/scripts/@wordpress/create-block build and test workflows."
compatibility: "Targets WordPress 6.9+ (PHP 7.2.24+). Filesystem-based agent with bash + node. Some workflows require WP-CLI."
---

# WP Block Development

## When to use

Use this skill for block work such as:

- creating a new block, or updating an existing one
- changing `block.json` (scripts/styles/supports/attributes/render/viewScriptModule)
- fixing “block invalid / not saving / attributes not persisting”
- adding dynamic rendering (`render.php` / `render_callback`)
- block deprecations and migrations (`deprecated` versions)
- build tooling for blocks (`@wordpress/scripts`, `@wordpress/create-block`, `wp-env`)

## Inputs required

- Repo root and target (plugin vs theme vs full site).
- The block name/namespace and where it lives (path to `block.json` if known).
- Target WordPress version range (especially if using modules / `viewScriptModule`).

## Procedure

### 0) Triage and locate blocks

1. Run triage:
   - `node skills/wp-project-triage/scripts/detect_wp_project.mjs`
2. List blocks (deterministic scan):
   - `node skills/wp-block-development/scripts/list_blocks.mjs`
3. Identify the block root (directory containing `block.json`) you’re changing.

If this repo is a full site (`wp-content/` present), be explicit about *which* plugin/theme contains the block.

### 1) Create a new block (if needed)

If you are creating a new block, prefer scaffolding rather than hand-rolling structure:

- Use `@wordpress/create-block` to scaffold a modern block/plugin setup.
- If you need Interactivity API from day 1, use the interactive template.

Read:
- `references/creating-new-blocks.md`

After scaffolding:

1. Re-run the block list script and confirm the new block root.
2. Continue with the remaining steps (model choice, metadata, registration, serialization).

### 2) Ensure apiVersion 3 (WordPress 6.9+)

WordPress 6.9 enforces `apiVersion: 3` in the block.json schema. Blocks with apiVersion 2 or lower trigger console warnings when `SCRIPT_DEBUG` is enabled.

**Why this matters:**
- WordPress 7.0 will run the post editor in an iframe regardless of block apiVersion.
- apiVersion 3 ensures your block works correctly inside the iframed editor (style isolation, viewport units, media queries).

**Migration:** Changing from version 2 to 3 is usually as simple as updating the `apiVersion` field in `block.json`. However:
- Test in a local environment with the iframe editor enabled.
- Ensure any style handles are included in `block.json` (styles missing from the iframe won't apply).
- Third-party scripts attached to a specific `window` may have scoping issues.

Read:
- `references/block-json.md` (apiVersion and schema details)

### 3) Pick the right block model

- **Static block** (markup saved into post content): implement `save()`; keep attributes serialization stable.
- **Dynamic block** (server-rendered): use `render` in `block.json` (or `render_callback` in PHP) and keep `save()` minimal or `null`.
- **Interactive frontend behavior**:
  - Prefer `viewScriptModule` for modern module-based view scripts where supported.
  - If you're working primarily on `data-wp-*` directives or stores, also use `wp-interactivity-api`.

### 4) Update `block.json` safely

Make changes in the block’s `block.json`, then confirm registration matches metadata.

For field-by-field guidance, read:
- `references/block-json.md`

Common pitfalls:

- changing `name` breaks compatibility (treat it as stable API)
- changing saved markup without adding `deprecated` causes “Invalid block”
- adding attributes without defining source/serialization correctly causes “attribute not saving”

### 5) Register the block (server-side preferred)

Prefer PHP registration using metadata, especially when:

- you need dynamic rendering
- you need translations (`wp_set_script_translations`)
- you need conditional asset loading

Read and apply:
- `references/registration.md`

### 6) Implement edit/save/render patterns

Follow wrapper attribute best practices:

- Editor: `useBlockProps()`
- Static save: `useBlockProps.save()`
- Dynamic render (PHP): `get_block_wrapper_attributes()`

Read:
- `references/supports-and-wrappers.md`
- `references/dynamic-rendering.md` (if dynamic)

### 7) Inner blocks (block composition)

If your block is a “container” that nests other blocks, treat Inner Blocks as a first-class feature:

- Use `useInnerBlocksProps()` to integrate inner blocks with wrapper props.
- Keep migrations in mind if you change inner markup.

Read:
- `references/inner-blocks.md`

### 8) Attributes and serialization

Before changing attributes:

- confirm where the attribute value lives (comment delimiter vs HTML vs context)
- avoid the deprecated `meta` attribute source

Read:
- `references/attributes-and-serialization.md`

### 9) Migrations and deprecations (avoid "Invalid block")

If you change saved markup or attributes:

1. Add a `deprecated` entry (newest → oldest).
2. Provide `save` for old versions and an optional `migrate` to normalize attributes.

Read:
- `references/deprecations.md`

### 10) Tooling and verification commands

Prefer whatever the repo already uses:

- `@wordpress/scripts` (common) → run existing npm scripts
- `wp-env` (common) → use for local WP + E2E

Read:
- `references/tooling-and-testing.md`

## Verification

- Block appears in inserter and inserts successfully.
- Saving + reloading does not create “Invalid block”.
- Frontend output matches expectations (static: saved markup; dynamic: server output).
- Assets load where expected (editor vs frontend).
- Run the repo’s lint/build/tests that triage recommends.

## Failure modes / debugging

If something fails, start here:

- `references/debugging.md` (common failures + fastest checks)
- `references/attributes-and-serialization.md` (attributes not saving)
- `references/deprecations.md` (invalid block after change)

## Escalation

If you’re uncertain about upstream behavior/version support, consult canonical docs first:

- WordPress Developer Resources (Block Editor Handbook, Theme Handbook, Plugin Handbook)
- Gutenberg repo docs for bleeding-edge behaviors
