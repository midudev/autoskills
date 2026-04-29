# Routes and Endpoints (summary)

## Registering routes

- Register routes on the `rest_api_init` hook with `register_rest_route( $namespace, $route, $args )`.
- A **route** is the URL pattern; an **endpoint** is the method + callback bound to that route.
- For non-pretty permalinks, the route is accessed via `?rest_route=/namespace/route`.

## Namespacing

- Always namespace routes (`vendor/v1`).
- **Do not** use the `wp/*` namespace unless you are targeting core.

## Methods

- Use `WP_REST_Server::READABLE` (GET), `CREATABLE` (POST), `EDITABLE` (PUT/PATCH), `DELETABLE` (DELETE).
- Multiple endpoints can share a route, one per method.

## permission_callback (required)

- Always provide `permission_callback`.
- Public endpoints should use `__return_true`.
- For restricted endpoints, use capability checks (`current_user_can`) or object-level authorization.
- Missing `permission_callback` emits a `_doing_it_wrong` notice in modern WP.

## Arguments

- Register `args` to validate and sanitize inputs.
- Use `type`, `required`, `default`, `validate_callback`, `sanitize_callback`.
- Access params via the `WP_REST_Request` object, not `$_GET`/`$_POST`.

## Return values

- Return data via `rest_ensure_response()` or a `WP_REST_Response`.
- Return `WP_Error` with a `status` in `data` for error responses.
- Do not call `wp_send_json()` in REST callbacks.
