# Responses and Fields (summary)

## Do not remove core fields

- Removing or changing core fields breaks clients (including wp-admin).
- Prefer adding new fields or using `_fields` to limit response size.

## register_rest_field

- Use for computed or custom fields.
- Provide `get_callback`, optional `update_callback`, and `schema`.
- Register on `rest_api_init`.

## Raw vs rendered content

- For posts, `content.rendered` reflects filters (plugins like ToC inject HTML).
- Use `?context=edit` (authenticated) to access `content.raw`.
- Combine with `_fields=content.raw` when you only need the editable body.

## register_meta / register_post_meta / register_term_meta

- Use when the data is stored as meta.
- Set `show_in_rest => true` to expose under `.meta`.
- For `object` or `array` types, provide a JSON schema in `show_in_rest.schema`.

## Links and embedding

- Add links with `WP_REST_Response::add_link( $rel, $href, $attrs )`.
- Use `embeddable => true` to allow `_embed`.
- Use IANA rels or a custom URI relation; CURIEs can be registered via `rest_response_link_curies`.
