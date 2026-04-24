# Discovery and Global Parameters (summary)

## API discovery

- REST API root is discovered via the `Link` header: `rel="https://api.w.org/"`.
- HTML pages also include a `<link rel="https://api.w.org/" href="...">` element.
- For non-pretty permalinks, use `?rest_route=/`.

## Global parameters

- `_fields` limits response fields (supports nested meta keys).
- `_embed` includes linked resources in `_embedded`.
- `_method` or `X-HTTP-Method-Override` allows POST to simulate PUT/DELETE.
- `_envelope` puts headers/status in the response body.
- `_jsonp` enables JSONP for legacy clients.

## Pagination

- Collections accept `page`, `per_page` (1-100), and `offset`.
- Pagination headers: `X-WP-Total` and `X-WP-TotalPages`.
