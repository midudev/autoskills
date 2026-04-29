# Schema and Argument Validation (summary)

## JSON Schema in WordPress

- REST API uses JSON Schema (draft 4 subset) for resource and argument definitions.
- Provide schema via `get_item_schema()` on controllers or `schema` callbacks on routes.
- Schema enables discovery (`OPTIONS`) and validation.

## Validation + sanitization

- Use `rest_validate_value_from_schema( $value, $schema )` then `rest_sanitize_value_from_schema( $value, $schema )`.
- If you override `sanitize_callback`, built-in schema validation will not run; use `rest_validate_request_arg` to keep it.
- `WP_REST_Controller::get_endpoint_args_for_item_schema()` wires validation automatically.

## Schema caching

- Cache the generated schema on the controller instance (`$this->schema`) to avoid recomputation.

## Formats and types

- Common formats: `date-time`, `uri`, `email`, `ip`, `uuid`, `hex-color`.
- For `array` and `object` types, you must define `items` or `properties` schemas.
