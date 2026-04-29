---
name: wp-rest-api
description: "Use when building, extending, or debugging WordPress REST API endpoints/routes: register_rest_route, WP_REST_Controller/controller classes, schema/argument validation, permission_callback/authentication, response shaping, register_rest_field/register_meta, or exposing CPTs/taxonomies via show_in_rest."
compatibility: "Targets WordPress 6.9+ (PHP 7.2.24+). Filesystem-based agent with bash + node. Some workflows require WP-CLI."
---

# WP REST API

## When to use

Use this skill when you need to:

- create or update REST routes/endpoints
- debug 401/403/404 errors or permission/nonce issues
- add custom fields/meta to REST responses
- expose custom post types or taxonomies via REST
- implement schema + argument validation
- adjust response links/embedding/pagination

## Inputs required

- Repo root + target plugin/theme/mu-plugin (path to entrypoint).
- Desired namespace + version (e.g. `my-plugin/v1`) and routes.
- Authentication mode (cookie + nonce vs application passwords vs auth plugin).
- Target WordPress version constraints (if below 6.9, call out).

## Procedure

### 0) Triage and locate REST usage

1. Run triage:
   - `node skills/wp-project-triage/scripts/detect_wp_project.mjs`
2. Search for existing REST usage:
   - `register_rest_route`
   - `WP_REST_Controller`
   - `rest_api_init`
   - `show_in_rest`, `rest_base`, `rest_controller_class`

If this is a full site repo, pick the specific plugin/theme before changing code.

### 1) Choose the right approach

- **Expose CPT/taxonomy in `wp/v2`:**
  - Use `show_in_rest => true` + `rest_base` if needed.
  - Optionally provide `rest_controller_class`.
  - Read `references/custom-content-types.md`.
- **Custom endpoints:**
  - Use `register_rest_route()` on `rest_api_init`.
  - Prefer a controller class (`WP_REST_Controller` subclass) for anything non-trivial.
  - Read `references/routes-and-endpoints.md` and `references/schema.md`.

### 2) Register routes safely (namespaces, methods, permissions)

- Use a unique namespace `vendor/v1`; avoid `wp/*` unless core.
- Always provide `permission_callback` (use `__return_true` for public endpoints).
- Use `WP_REST_Server::READABLE/CREATABLE/EDITABLE/DELETABLE` constants.
- Return data via `rest_ensure_response()` or `WP_REST_Response`.
- Return errors via `WP_Error` with an explicit `status`.

Read `references/routes-and-endpoints.md`.

### 3) Validate/sanitize request args

- Define `args` with `type`, `default`, `required`, `validate_callback`, `sanitize_callback`.
- Prefer JSON Schema validation with `rest_validate_value_from_schema` then `rest_sanitize_value_from_schema`.
- Never read `$_GET`/`$_POST` directly inside endpoints; use `WP_REST_Request`.

Read `references/schema.md`.

### 4) Responses, fields, and links

- Do **not** remove core fields from default endpoints; add fields instead.
- Use `register_rest_field` for computed fields; `register_meta` with `show_in_rest` for meta.
- For `object`/`array` meta, define schema in `show_in_rest.schema`.
- If you need unfiltered post content (e.g., ToC plugins injecting HTML), request `?context=edit` to access `content.raw` (auth required). Pair with `_fields=content.raw` to keep responses small.
- Add related resource links via `WP_REST_Response::add_link()`.

Read `references/responses-and-fields.md`.

### 5) Authentication and authorization

- For wp-admin/JS: cookie auth + `X-WP-Nonce` (action `wp_rest`).
- For external clients: application passwords (basic auth) or an auth plugin.
- Use capability checks in `permission_callback` (authorization), not just “logged in”.

Read `references/authentication.md`.

### 6) Client-facing behavior (discovery, pagination, embeds)

- Ensure discovery works (`Link` header or `<link rel="https://api.w.org/">`).
- Support `_fields`, `_embed`, `_method`, `_envelope`, pagination headers.
- Remember `per_page` is capped at 100.

Read `references/discovery-and-params.md`.

## Verification

- `/wp-json/` index includes your namespace.
- `OPTIONS` on your route returns schema (when provided).
- Endpoint returns expected data; permission failures return 401/403 as appropriate.
- CPT/taxonomy routes appear under `wp/v2` when `show_in_rest` is true.
- Run repo lint/tests and any PHP/JS build steps.

## Failure modes / debugging

- 404: `rest_api_init` not firing, route typo, or permalinks off (use `?rest_route=`).
- 401/403: missing nonce/auth, or `permission_callback` too strict.
- `_doing_it_wrong` for missing `permission_callback`: add it (use `__return_true` if public).
- Invalid params: missing/incorrect `args` schema or validation callbacks.
- Fields missing: `show_in_rest` false, meta not registered, or CPT lacks `custom-fields` support.

## Escalation

If version support or behavior is unclear, consult the REST API Handbook and core docs before inventing patterns.
