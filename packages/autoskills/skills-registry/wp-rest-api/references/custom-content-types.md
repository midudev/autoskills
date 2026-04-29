# Custom Content Types (summary)

## Custom post types

- Set `show_in_rest => true` in `register_post_type()` to expose in `wp/v2`.
- Use `rest_base` to change the route slug.
- Optionally set `rest_controller_class` (must extend `WP_REST_Controller`).

## Custom taxonomies

- Set `show_in_rest => true` in `register_taxonomy()`.
- Use `rest_base` and optional `rest_controller_class` (default `WP_REST_Terms_Controller`).

## Adding REST support to existing types

- Use `register_post_type_args` or `register_taxonomy_args` filters to enable `show_in_rest` for types you do not control.

## Discovery links for custom controllers

- If you use a custom controller class, use `rest_route_for_post` or `rest_route_for_term` filters to map objects to routes.
